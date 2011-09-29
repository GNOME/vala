/* valaelementaccess.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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

/**
 * Represents an array access expression e.g. "a[1,2]".
 */
public class Vala.ElementAccess : Expression {
	/**
	 * Expression representing the container on wich we want to access.
	 */
	public Expression container {
		get {
			return _container;
		}
		set {
			_container = value;
			_container.parent_node = this;
		}
	}

	/**
	 * Expressions representing the indices we want to access inside the container.
	 */
	private List<Expression> indices = new ArrayList<Expression> ();

	Expression _container;

	public void append_index (Expression index) {
		indices.add (index);
		index.parent_node = this;
	}

	public List<Expression> get_indices () {
		return indices;
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

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!container.check (context)) {
			/* don't proceed if a child expression failed */
			error = true;
			return false;
		}

		if (container.value_type == null) {
			error = true;
			Report.error (container.source_reference, "Invalid container expression");
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
			get_indices ().get (0).target_type = context.analyzer.string_type.copy ();
		}

		foreach (Expression index in get_indices ()) {
			index.check (context);
		}

		bool index_int_type_check = true;

		var pointer_type = container.value_type as PointerType;

		/* assign a value_type when possible */
		if (container.value_type is ArrayType) {
			var array_type = (ArrayType) container.value_type;
			value_type = array_type.element_type.copy ();
			if (!lvalue) {
				value_type.value_owned = false;
			} else {
				var ma = container as MemberAccess;
				if (context.profile == Profile.GOBJECT && ma != null && ma.symbol_reference is ArrayLengthField) {
					// propagate lvalue for gobject length access
					ma.inner.lvalue = true;
					((MemberAccess) ma.inner).check_lvalue_access ();
				} else if (ma != null && ma.symbol_reference is Field &&
					ma.inner != null && ma.inner.symbol_reference is Variable &&
					ma.inner.value_type is StructValueType && !ma.inner.value_type.nullable) {
					// propagate lvalue if container is a field and container.inner is a struct variable
					ma.lvalue = true;
					ma.check_lvalue_access ();
				}
			}

			if (array_type.rank < get_indices ().size) {
				Report.error (source_reference, "%d extra indices for element access".printf (get_indices ().size - array_type.rank));
			} else if (array_type.rank > get_indices ().size) {
				Report.error (source_reference, "%d missing indices for element access".printf (array_type.rank - get_indices ().size));
			}
		} else if (pointer_type != null && !pointer_type.base_type.is_reference_type_or_type_parameter ()) {
			value_type = pointer_type.base_type.copy ();
		} else if (context.profile == Profile.DOVA && container_type == context.analyzer.tuple_type.data_type) {
			if (get_indices ().size != 1) {
				error = true;
				Report.error (source_reference, "Element access with more than one dimension is not supported for tuples");
				return false;
			}
			var index = get_indices ().get (0) as IntegerLiteral;
			if (index == null) {
				error = true;
				Report.error (source_reference, "Element access with non-literal index is not supported for tuples");
				return false;
			}
			int i = int.parse (index.value);
			if (container.value_type.get_type_arguments ().size == 0) {
				error = true;
				Report.error (source_reference, "Element access is not supported for untyped tuples");
				return false;
			}
			if (i < 0 || i >= container.value_type.get_type_arguments ().size) {
				error = true;
				Report.error (source_reference, "Index out of range");
				return false;
			}

			value_type = container.value_type.get_type_arguments ().get (i);

			// replace element access by call to generic get method
			var ma = new MemberAccess (container, "get", source_reference);
			ma.add_type_argument (value_type);
			var get_call = new MethodCall (ma, source_reference);
			get_call.add_argument (index);
			get_call.target_type = this.target_type;
			parent_node.replace_expression (this, get_call);
			return get_call.check (context);
		} else if (container is MemberAccess && container.symbol_reference is Signal) {
			index_int_type_check = false;

			symbol_reference = container.symbol_reference;
			value_type = container.value_type;
		} else {
			if (lvalue) {
				var set_method = container.value_type.get_member ("set") as Method;
				var assignment = parent_node as Assignment;
				if (set_method != null && set_method.return_type is VoidType && assignment != null) {
					return !error;
				}
			} else {
				var get_method = container.value_type.get_member ("get") as Method;
				if (get_method != null) {
					var get_call = new MethodCall (new MemberAccess (container, "get", source_reference), source_reference);
					foreach (Expression e in get_indices ()) {
						get_call.add_argument (e);
					}
					get_call.formal_target_type = this.formal_target_type;
					get_call.target_type = this.target_type;
					parent_node.replace_expression (this, get_call);
					return get_call.check (context);
				}
			}

			error = true;
			Report.error (source_reference, "The expression `%s' does not denote an array".printf (container.value_type.to_string ()));
		}

		if (index_int_type_check) {
			/* check if the index is of type integer */
			foreach (Expression e in get_indices ()) {
				/* don't proceed if a child expression failed */
				if (e.value_type == null) {
					return false;
				}

				/* check if the index is of type integer */
				if (!(e.value_type is IntegerType || e.value_type is EnumValueType)) {
					error = true;
					Report.error (e.source_reference, "Expression of integer type expected");
				}
			}
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		container.emit (codegen);
		foreach (Expression e in indices) {
			e.emit (codegen);
		}

		codegen.visit_element_access (this);

		codegen.visit_expression (this);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		container.get_defined_variables (collection);
		foreach (Expression index in indices) {
			index.get_defined_variables (collection);
		}
	}

	public override void get_used_variables (Collection<Variable> collection) {
		container.get_used_variables (collection);
		foreach (Expression index in indices) {
			index.get_used_variables (collection);
		}
	}
}
