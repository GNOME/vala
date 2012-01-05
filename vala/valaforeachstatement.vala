/* valaforeachstatement.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */


/**
 * Represents a foreach statement in the source code. Foreach statements iterate
 * over the elements of a collection.
 */
public class Vala.ForeachStatement : BaseStatement {
	/**
	 * Specifies the element type.
	 */
	public DataType? type_reference {
		get { return _data_type; }
		private set {
			_data_type = value;
			if (_data_type != null) {
				_data_type.parent_node = this;
			}
		}
	}

	/**
	 * Specifies the element variable name.
	 */
	public string variable_name { get; private set; }

	/**
	 * Specifies the container.
	 */
	public Expression collection {
		get {
			return _collection;
		}
		private set {
			_collection = value;
			_collection.parent_node = this;
		}
	}

	/**
	 * Specifies the loop body.
	 */
	public Block body {
		get {
			return _body;
		}
		private set {
			_body = value;
			_body.parent_node = this;
		}
	}

	/**
	 * Specifies the approach used for the iteration.
	 */
	public ForeachIteration foreach_iteration { get; private set; }

	/**
	 * Specifies the declarator for the generated element variable.
	 */
	public LocalVariable element_variable { get; private set; }

	private Expression _collection;
	private Block _body;

	private DataType _data_type;

	/**
	 * Creates a new foreach statement.
	 *
	 * @param type_reference    element type
	 * @param variable_name     element variable name
	 * @param collection        container
	 * @param body              loop body
	 * @param source_reference  reference to source code
	 * @return                  newly created foreach statement
	 */
	public ForeachStatement (DataType? type_reference, string variable_name, Expression collection, Block body, SourceReference source_reference) {
		this.variable_name = variable_name;
		this.collection = collection;
		this.body = body;
		this.type_reference = type_reference;
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_foreach_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		collection.accept (visitor);
		visitor.visit_end_full_expression (collection);

		if (type_reference != null) {
			type_reference.accept (visitor);
		}

		body.accept (visitor);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (collection == old_node) {
			collection = new_node;
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		// analyze collection expression first, used for type inference
		if (!collection.check (context)) {
			// ignore inner error
			error = true;
			return false;
		} else if (collection.value_type == null) {
			Report.error (collection.source_reference, "invalid collection expression");
			error = true;
			return false;
		}

		var collection_type = collection.value_type.copy ();
		collection.target_type = collection_type.copy ();

		if (collection_type is ArrayType) {
			var array_type = (ArrayType) collection_type;

			// can't use inline-allocated array for temporary variable
			array_type.inline_allocated = false;

			foreach_iteration = ForeachIteration.ARRAY;
			error = !analyze_element_type (array_type.element_type, false);
		} else if (context.profile == Profile.GOBJECT && collection_type.compatible (context.analyzer.glist_type) || collection_type.compatible (context.analyzer.gslist_type)) {
			if (collection_type.get_type_arguments ().size != 1) {
				error = true;
				Report.error (collection.source_reference, "missing type argument for collection");
				return false;
			}

			foreach_iteration = ForeachIteration.GLIST;
			error = !analyze_element_type (collection_type.get_type_arguments ().get (0), false);
		} else if (context.profile == Profile.GOBJECT && collection_type.compatible (context.analyzer.gvaluearray_type)) {
			foreach_iteration = ForeachIteration.GVALUE_ARRAY;
			error = !analyze_element_type (context.analyzer.gvalue_type, false);
		} else {
			error = !check_with_iterator (context, collection_type);
		}

		element_variable = new LocalVariable (type_reference, variable_name, null, source_reference);
		element_variable.checked = true;
		element_variable.active = true;
		body.add_local_variable (element_variable);
		if (!body.check (context)) {
			error = true;
		}
		element_variable.active = false;

		return !error;
	}

	bool check_with_index (CodeContext context, DataType collection_type) {
		var get_method = collection_type.get_member ("get") as Method;
		if (get_method == null) {
			return false;
		}
		if (get_method.get_parameters ().size != 1) {
			return false;
		}
		var element_type = get_method.return_type.get_actual_type (collection.value_type, null, this);
		if (element_type is VoidType) {
			Report.error (collection.source_reference, "`%s' must return an element".printf (get_method.get_full_name ()));
			error = true;
			return false;
		}

		if (!analyze_element_type (element_type, element_type.value_owned)) {
			return false;
		}

		var size_property = collection_type.get_member ("size") as Property;
		if (size_property == null) {
			return false;
		}

		foreach_iteration = ForeachIteration.INDEX;
		return true;
	}

	bool check_with_iterator (CodeContext context, DataType collection_type) {
		if (check_with_index (context, collection_type)) {
			return true;
		}

		var iterator_method = collection_type.get_member ("iterator") as Method;
		if (iterator_method == null) {
			Report.error (collection.source_reference, "`%s' does not have an `iterator' method".printf (collection_type.to_string ()));
			error = true;
			return false;
		}
		if (iterator_method.get_parameters ().size != 0) {
			Report.error (collection.source_reference, "`%s' must not have any parameters".printf (iterator_method.get_full_name ()));
			error = true;
			return false;
		}
		var iterator_type = iterator_method.return_type.get_actual_type (collection_type, null, this);
		if (iterator_type is VoidType) {
			Report.error (collection.source_reference, "`%s' must return an iterator".printf (iterator_method.get_full_name ()));
			error = true;
			return false;
		}

		var next_value_method = iterator_type.get_member ("next_value") as Method;
		var next_method = iterator_type.get_member ("next") as Method;
		if (next_value_method != null) {
			if (next_value_method.get_parameters ().size != 0) {
				Report.error (collection.source_reference, "`%s' must not have any parameters".printf (next_value_method.get_full_name ()));
				error = true;
				return false;
			}
			var element_type = next_value_method.return_type.get_actual_type (iterator_type, null, this);
			if (!element_type.nullable) {
				Report.error (collection.source_reference, "return type of `%s' must be nullable".printf (next_value_method.get_full_name ()));
				error = true;
				return false;
			}

			if (!analyze_element_type (element_type, element_type.value_owned)) {
				return false;
			}

			foreach_iteration = ForeachIteration.NEXT_VALUE;
		} else if (next_method != null) {
			if (next_method.get_parameters ().size != 0) {
				Report.error (collection.source_reference, "`%s' must not have any parameters".printf (next_method.get_full_name ()));
				error = true;
				return false;
			}
			if (!next_method.return_type.compatible (context.analyzer.bool_type)) {
				Report.error (collection.source_reference, "`%s' must return a boolean value".printf (next_method.get_full_name ()));
				error = true;
				return false;
			}
			var get_method = iterator_type.get_member ("get") as Method;
			if (get_method == null) {
				Report.error (collection.source_reference, "`%s' does not have a `get' method".printf (iterator_type.to_string ()));
				error = true;
				return false;
			}
			if (get_method.get_parameters ().size != 0) {
				Report.error (collection.source_reference, "`%s' must not have any parameters".printf (get_method.get_full_name ()));
				error = true;
				return false;
			}
			var element_type = get_method.return_type.get_actual_type (iterator_type, null, this);
			if (element_type is VoidType) {
				Report.error (collection.source_reference, "`%s' must return an element".printf (get_method.get_full_name ()));
				error = true;
				return false;
			}

			if (!analyze_element_type (element_type, element_type.value_owned)) {
				return false;
			}

			foreach_iteration = ForeachIteration.NEXT_GET;
		} else {
			Report.error (collection.source_reference, "`%s' does not have a `next_value' or `next' method".printf (iterator_type.to_string ()));
			error = true;
			return false;
		}

		return true;
	}

	bool analyze_element_type (DataType element_type, bool get_owned) {
		// analyze element type
		if (type_reference == null) {
			// var type
			type_reference = element_type.copy ();
		} else if (!element_type.compatible (type_reference)) {
			error = true;
			Report.error (source_reference, "Foreach: Cannot convert from `%s' to `%s'".printf (element_type.to_string (), type_reference.to_string ()));
			return false;
		} else if (get_owned && element_type.is_disposable () && element_type.value_owned && !type_reference.value_owned) {
			error = true;
			Report.error (source_reference, "Foreach: Invalid assignment from owned expression to unowned variable");
			return false;
		}

		return true;
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		if (source_reference == null) {
			source_reference = this.source_reference;
		}
		this.collection.get_error_types (collection, source_reference);
		body.get_error_types (collection, source_reference);
	}

	public override void emit (CodeGenerator codegen) {
		collection.emit (codegen);
		codegen.visit_end_full_expression (collection);

		codegen.visit_foreach_statement (this);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		if (element_variable != null) {
			collection.add (element_variable);
		}
	}
}

public enum Vala.ForeachIteration {
	NONE,
	ARRAY,
	GVALUE_ARRAY,
	GLIST,
	INDEX,
	NEXT_VALUE,
	NEXT_GET
}
