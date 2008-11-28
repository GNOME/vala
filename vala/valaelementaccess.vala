/* valaelementaccess.vala
 *
 * Copyright (C) 2006-2008  Raffaele Sandrini, Jürg Billeter
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
 * 	Raffaele Sandrini <raffaele@sandrini.ch>
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;
using Gee;

/**
 * Represents an array access expression e.g. "a[1,2]".
 */
public class Vala.ElementAccess : Expression {
	/**
	 * Expression representing the container on wich we want to access.
	 */
	public Expression container { get; set; }
	
	/**
	 * Expressions representing the indices we want to access inside the container.
	 */
	private Gee.List<Expression> indices = new ArrayList<Expression> ();

	public void append_index (Expression index) {
		indices.add (index);
		index.parent_node = this;
	}

	public Gee.List<Expression> get_indices () {
		return new ReadOnlyList<Expression> (indices);
	}
	
	public ElementAccess (Expression container, SourceReference source_reference) {
		this.source_reference = source_reference;
		this.container = container;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_element_access (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		container.accept (visitor);
		foreach (Expression e in indices) {
			e.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (container == old_node) {
			container = new_node;
		}
		
		int index = indices.index_of (old_node);
		if (index >= 0 && new_node.parent_node == null) {
			indices[index] = new_node;
			new_node.parent_node = this;
		}
	}

	public override bool is_pure () {
		foreach (Expression index in indices) {
			if (!index.is_pure ()) {
				return false;
			}
		}
		return container.is_pure ();
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		container.check (analyzer);

		if (container.value_type == null) {
			/* don't proceed if a child expression failed */
			error = true;
			return false;
		}

		var container_type = container.value_type.data_type;

		if (container is MemberAccess && container.symbol_reference is Signal) {
			// signal detail access
			if (get_indices ().size != 1) {
				error = true;
				Report.error (source_reference, "Element access with more than one dimension is not supported for signals");
				return false;
			}
			get_indices ().get (0).target_type = analyzer.string_type.copy ();
		}

		foreach (Expression index in get_indices ()) {
			index.check (analyzer);
		}

		bool index_int_type_check = true;

		var pointer_type = container.value_type as PointerType;

		/* assign a value_type when possible */
		if (container.value_type is ArrayType) {
			var array_type = (ArrayType) container.value_type;
			value_type = array_type.element_type.copy ();
			if (!lvalue) {
				value_type.value_owned = false;
			}
		} else if (pointer_type != null && !pointer_type.base_type.is_reference_type_or_type_parameter ()) {
			value_type = pointer_type.base_type.copy ();
		} else if (container_type == analyzer.string_type.data_type) {
			if (get_indices ().size != 1) {
				error = true;
				Report.error (source_reference, "Element access with more than one dimension is not supported for strings");
				return false;
			}

			value_type = analyzer.unichar_type;
		} else if (container_type != null && analyzer.list_type != null && analyzer.map_type != null &&
		           (container_type.is_subtype_of (analyzer.list_type) || container_type.is_subtype_of (analyzer.map_type))) {
			Gee.List<Expression> indices = get_indices ();
			if (indices.size != 1) {
				error = true;
				Report.error (source_reference, "Element access with more than one dimension is not supported for the specified type");
				return false;
			}
			Iterator<Expression> indices_it = indices.iterator ();
			indices_it.next ();
			var index = indices_it.get ();
			index_int_type_check = false;

			// lookup symbol in interface instead of class as implemented interface methods are not in VAPI files
			Symbol get_sym = null;
			if (container_type.is_subtype_of (analyzer.list_type)) {
				get_sym = analyzer.list_type.scope.lookup ("get");
			} else if (container_type.is_subtype_of (analyzer.map_type)) {
				get_sym = analyzer.map_type.scope.lookup ("get");
			}
			var get_method = (Method) get_sym;
			Gee.List<FormalParameter> get_params = get_method.get_parameters ();
			Iterator<FormalParameter> get_params_it = get_params.iterator ();
			get_params_it.next ();
			var get_param = get_params_it.get ();

			var index_type = get_param.parameter_type;
			if (index_type is GenericType) {
				index_type = analyzer.get_actual_type (container.value_type, (GenericType) index_type, this);
			}

			if (!index.value_type.compatible (index_type)) {
				error = true;
				Report.error (source_reference, "index expression: Cannot convert from `%s' to `%s'".printf (index.value_type.to_string (), index_type.to_string ()));
				return false;
			}

			value_type = analyzer.get_actual_type (container.value_type, (GenericType) get_method.return_type, this).copy ();
			if (lvalue) {
				// get () returns owned value, set () accepts unowned value
				value_type.value_owned = false;
			}
		} else if (container is MemberAccess && container.symbol_reference is Signal) {
			index_int_type_check = false;

			symbol_reference = container.symbol_reference;
			value_type = container.value_type;
		} else {
			error = true;
			Report.error (source_reference, "The expression `%s' does not denote an Array".printf (container.value_type.to_string ()));
		}

		if (index_int_type_check) {
			/* check if the index is of type integer */
			foreach (Expression e in get_indices ()) {
				/* don't proceed if a child expression failed */
				if (e.value_type == null) {
					return false;
				}

				/* check if the index is of type integer */
				if (!e.value_type.compatible (analyzer.long_type)) {
					error = true;
					Report.error (e.source_reference, "Expression of integer type expected");
				}
			}
		}

		return !error;
	}

	public override void get_defined_variables (Collection<LocalVariable> collection) {
		container.get_defined_variables (collection);
		foreach (Expression index in indices) {
			index.get_defined_variables (collection);
		}
	}

	public override void get_used_variables (Collection<LocalVariable> collection) {
		container.get_used_variables (collection);
		foreach (Expression index in indices) {
			index.get_used_variables (collection);
		}
	}
}
