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
public class Vala.ForeachStatement : Block {
	/**
	 * Specifies the element type.
	 */
	public DataType? type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			if (_data_type != null) {
				_data_type.parent_node = this;
			}
		}
	}
	
	/**
	 * Specifies the element variable name.
	 */
	public string variable_name { get; set; }
	
	/**
	 * Specifies the container.
	 */
	public Expression collection {
		get {
			return _collection;
		}
		set {
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
		set {
			_body = value;
			_body.parent_node = this;
		}
	}

	public bool use_iterator { get; private set; }

	/**
	 * Specifies the declarator for the generated element variable.
	 */
	public LocalVariable element_variable { get; set; }

	/**
	 * Specifies the declarator for the generated collection variable.
	 */
	public LocalVariable collection_variable { get; set; }

	/**
	 * Specifies the declarator for the generated iterator variable.
	 */
	public LocalVariable iterator_variable { get; set; }

	private Expression _collection;
	private Block _body;

	private DataType _data_type;

	/**
	 * Creates a new foreach statement.
	 *
	 * @param type   element type
	 * @param id     element variable name
	 * @param col    loop body
	 * @param source reference to source code
	 * @return       newly created foreach statement
	 */
	public ForeachStatement (DataType? type_reference, string variable_name, Expression collection, Block body, SourceReference source_reference) {
		base (source_reference);
		this.variable_name = variable_name;
		this.collection = collection;
		this.body = body;
		this.type_reference = type_reference;
	}
	
	public override void accept (CodeVisitor visitor) {
		if (use_iterator) {
			base.accept (visitor);
			return;
		}

		visitor.visit_foreach_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (use_iterator) {
			base.accept_children (visitor);
			return;
		}

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

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		// analyze collection expression first, used for type inference
		if (!collection.check (analyzer)) {
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
		
		if (collection_type.is_array ()) {
			var array_type = (ArrayType) collection_type;

			// can't use inline-allocated array for temporary variable
			array_type.inline_allocated = false;

			return check_without_iterator (analyzer, collection_type, array_type.element_type);
		} else if (collection_type.compatible (analyzer.glist_type) || collection_type.compatible (analyzer.gslist_type)) {
			if (collection_type.get_type_arguments ().size != 1) {
				error = true;
				Report.error (collection.source_reference, "missing type argument for collection");
				return false;
			}

			return check_without_iterator (analyzer, collection_type, collection_type.get_type_arguments ().get (0));
		} else if (collection_type.compatible (analyzer.gvaluearray_type)) {
			return check_without_iterator (analyzer, collection_type, analyzer.gvalue_type);
		} else {
			return check_with_iterator (analyzer, collection_type);
		}
	}

	bool check_with_iterator (SemanticAnalyzer analyzer, DataType collection_type) {
		use_iterator = true;

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
		var next_method = iterator_type.get_member ("next") as Method;
		if (next_method == null) {
			Report.error (collection.source_reference, "`%s' does not have a `next' method".printf (iterator_type.to_string ()));
			error = true;
			return false;
		}
		if (next_method.get_parameters ().size != 0) {
			Report.error (collection.source_reference, "`%s' must not have any parameters".printf (next_method.get_full_name ()));
			error = true;
			return false;
		}
		if (!next_method.return_type.compatible (analyzer.bool_type)) {
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

		// analyze element type
		if (type_reference == null) {
			// var type
			type_reference = element_type.copy ();
		} else if (!element_type.compatible (type_reference)) {
			error = true;
			Report.error (source_reference, "Foreach: Cannot convert from `%s' to `%s'".printf (element_type.to_string (), type_reference.to_string ()));
			return false;
		} else if (element_type.is_disposable () && element_type.value_owned && !type_reference.value_owned) {
			error = true;
			Report.error (source_reference, "Foreach: Invalid assignment from owned expression to unowned variable");
			return false;
		}

		var iterator_call = new MethodCall (new MemberAccess (collection, "iterator"));
		add_statement (new DeclarationStatement (new LocalVariable (iterator_type, "_%s_it".printf (variable_name), iterator_call, source_reference), source_reference));

		var next_call = new MethodCall (new MemberAccess (new MemberAccess.simple ("_%s_it".printf (variable_name), source_reference), "next", source_reference), source_reference);
		var loop = new WhileStatement (next_call, body, source_reference);
		add_statement (loop);

		var get_call = new MethodCall (new MemberAccess (new MemberAccess.simple ("_%s_it".printf (variable_name), source_reference), "get", source_reference), source_reference);
		body.insert_statement (0, new DeclarationStatement (new LocalVariable (type_reference, variable_name, get_call, source_reference), source_reference));

		checked = false;
		return base.check (analyzer);
	}

	bool check_without_iterator (SemanticAnalyzer analyzer, DataType collection_type, DataType element_type) {
		// analyze element type
		if (type_reference == null) {
			// var type
			type_reference = element_type.copy ();
		} else if (!element_type.compatible (type_reference)) {
			error = true;
			Report.error (source_reference, "Foreach: Cannot convert from `%s' to `%s'".printf (element_type.to_string (), type_reference.to_string ()));
			return false;
		}

		element_variable = new LocalVariable (type_reference, variable_name);

		body.scope.add (variable_name, element_variable);

		body.add_local_variable (element_variable);
		element_variable.active = true;
		element_variable.checked = true;

		// analyze body
		owner = analyzer.current_symbol.scope;
		analyzer.current_symbol = this;

		body.check (analyzer);

		foreach (LocalVariable local in get_local_variables ()) {
			local.active = false;
		}

		analyzer.current_symbol = analyzer.current_symbol.parent_symbol;

		collection_variable = new LocalVariable (collection_type, "%s_collection".printf (variable_name));

		add_local_variable (collection_variable);
		collection_variable.active = true;

		add_error_types (collection.get_error_types ());
		add_error_types (body.get_error_types ());

		return !error;
	}

	public override void get_defined_variables (Collection<LocalVariable> collection) {
		collection.add (element_variable);
	}
}
