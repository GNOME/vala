/* valainitializerlist.vala
 *
 * Copyright (C) 2006-2011  Jürg Billeter
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
 * 	Jürg Billeter <j@bitron.ch>
 * 	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

/**
 * Represents an array or struct initializer list in the source code.
 */
public class Vala.InitializerList : Expression {
	private List<Expression> initializers = new ArrayList<Expression> ();
	
	/**
	 * Appends the specified expression to this initializer 
	 *
	 * @param expr an expression
	 */
	public void append (Expression expr) {
		initializers.add (expr);
		expr.parent_node = this;
	}
	
	/**
	 * Returns a copy of the expression 
	 *
	 * @return expression list
	 */
	public List<Expression> get_initializers () {
		return initializers;
	}

	/**
	 * Returns the initializer count in this initializer 
	 */
	public int size {
		get { return initializers.size; }
	}

	/**
	 * Creates a new initializer 
	 *
	 * @param source_reference reference to source code
	 * @return                 newly created initializer list
	 */
	public InitializerList (SourceReference source_reference) {
		this.source_reference = source_reference;
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (Expression expr in initializers) {
			expr.accept (visitor);
		}
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_initializer_list (this);

		visitor.visit_expression (this);
	}

	public override bool is_constant () {
		foreach (Expression initializer in initializers) {
			if (!initializer.is_constant ()) {
				return false;
			}
		}
		return true;
	}

	public override bool is_pure () {
		foreach (Expression initializer in initializers) {
			if (!initializer.is_pure ()) {
				return false;
			}
		}
		return true;
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		for (int i = 0; i < initializers.size; i++) {
			if (initializers[i] == old_node) {
				initializers[i] = new_node;
			}
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (target_type == null) {
			error = true;
			Report.error (source_reference, "initializer list used for unknown type");
			return false;
		} else if (target_type is ArrayType) {
			/* initializer is used as array initializer */
			var array_type = (ArrayType) target_type;

			if (!(parent_node is ArrayCreationExpression)
			      && !(parent_node is Constant)
			      && !(parent_node is InitializerList)) {
				// transform shorthand form
				//     int[] array = { 42 };
				// into
				//     int[] array = new int[] { 42 };

				var old_parent_node = parent_node;

				var array_creation = new ArrayCreationExpression (array_type.element_type.copy (), array_type.rank, this, source_reference);
				array_creation.target_type = target_type;
				old_parent_node.replace_expression (this, array_creation);

				checked = false;
				return array_creation.check (context);
			}

			DataType inner_target_type;
			if (array_type.rank > 1) {
				// allow initialization of multi-dimensional arrays
				var inner_array_type = (ArrayType) array_type.copy ();
				inner_array_type.rank--;
				inner_target_type = inner_array_type;
			} else {
				inner_target_type = array_type.element_type.copy ();
			}

			foreach (Expression e in get_initializers ()) {
				e.target_type = inner_target_type;
			}
		} else if (target_type.data_type is Struct) {
			/* initializer is used as struct initializer */
			var st = (Struct) target_type.data_type;
			while (st.base_struct != null) {
				st = st.base_struct;
			}

			var field_it = st.get_fields ().iterator ();
			foreach (Expression e in get_initializers ()) {
				Field field = null;
				while (field == null) {
					if (!field_it.next ()) {
						error = true;
						Report.error (e.source_reference, "too many expressions in initializer list for `%s'".printf (target_type.to_string ()));
						return false;
					}
					field = field_it.get ();
					if (field.binding != MemberBinding.INSTANCE) {
						// we only initialize instance fields
						field = null;
					}
				}

				e.target_type = field.variable_type.copy ();
				if (!target_type.value_owned) {
					e.target_type.value_owned = false;
				}
			}
		} else {
			error = true;
			Report.error (source_reference, "initializer list used for `%s', which is neither array nor struct".printf (target_type.to_string ()));
			return false;
		}

		foreach (Expression expr in initializers) {
			expr.check (context);
		}

		bool error = false;
		foreach (Expression e in get_initializers ()) {
			if (e.value_type == null) {
				error = true;
				Report.error (e.source_reference, "expression type not allowed as initializer");
				continue;
			}

			var unary = e as UnaryExpression;
			if (unary != null && (unary.operator == UnaryOperator.REF || unary.operator == UnaryOperator.OUT)) {
				// TODO check type for ref and out expressions
			} else if (!e.value_type.compatible (e.target_type)) {
				error = true;
				e.error = true;
				Report.error (e.source_reference, "Expected initializer of type `%s' but got `%s'".printf (e.target_type.to_string (), e.value_type.to_string ()));
			}
		}

		if (!error) {
			/* everything seems to be correct */
			value_type = target_type.copy ();
			value_type.nullable = false;
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		foreach (Expression expr in initializers) {
			expr.emit (codegen);
		}

		codegen.visit_initializer_list (this);

		codegen.visit_expression (this);
	}
}
