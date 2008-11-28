/* valaforeachstatement.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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

using Gee;

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
		
		DataType element_data_type = null;
		bool element_owned = false;

		if (collection_type.is_array ()) {
			var array_type = (ArrayType) collection_type;
			element_data_type = array_type.element_type;
		} else if (collection_type.compatible (analyzer.glist_type) || collection_type.compatible (analyzer.gslist_type)) {
			if (collection_type.get_type_arguments ().size > 0) {
				element_data_type = (DataType) collection_type.get_type_arguments ().get (0);
			}
		} else if (analyzer.iterable_type != null && collection_type.compatible (analyzer.iterable_type)) {
			element_owned = true;

			if (analyzer.list_type == null || !collection_type.compatible (new ObjectType (analyzer.list_type))) {
				// don't use iterator objects for lists for performance reasons
				var foreach_iterator_type = new ObjectType (analyzer.iterator_type);
				foreach_iterator_type.value_owned = true;
				foreach_iterator_type.add_type_argument (type_reference);
				iterator_variable = new LocalVariable (foreach_iterator_type, "%s_it".printf (variable_name));

				add_local_variable (iterator_variable);
				iterator_variable.active = true;
			}

			var it_method = (Method) analyzer.iterable_type.data_type.scope.lookup ("iterator");
			if (it_method.return_type.get_type_arguments ().size > 0) {
				var type_arg = it_method.return_type.get_type_arguments ().get (0);
				if (type_arg is GenericType) {
					element_data_type = SemanticAnalyzer.get_actual_type (collection_type, (GenericType) type_arg, this);
				} else {
					element_data_type = type_arg;
				}
			}
		} else {
			error = true;
			Report.error (source_reference, "Gee.List not iterable");
			return false;
		}

		if (element_data_type == null) {
			error = true;
			Report.error (collection.source_reference, "missing type argument for collection");
			return false;
		}

		// analyze element type
		if (type_reference == null) {
			// var type
			type_reference = element_data_type.copy ();
		} else if (!element_data_type.compatible (type_reference)) {
			error = true;
			Report.error (source_reference, "Foreach: Cannot convert from `%s' to `%s'".printf (element_data_type.to_string (), type_reference.to_string ()));
			return false;
		} else if (element_data_type.is_disposable () && element_owned && !type_reference.value_owned) {
			error = true;
			Report.error (source_reference, "Foreach: Invalid assignment from owned expression to unowned variable");
			return false;
		}
		
		analyzer.current_source_file.add_type_dependency (type_reference, SourceFileDependencyType.SOURCE);

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
