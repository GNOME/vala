/* valalocalvariable.vala
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

using GLib;

/**
 * Represents a local variable declaration in the source code.
 */
public class Vala.LocalVariable : Variable {
	public bool is_result { get; set; }

	public bool captured { get; set; }

	public bool init { get; set; }

	/**
	 * Creates a new local variable.
	 *
	 * @param name              name of the variable
	 * @param initializer       optional initializer expression
	 * @param source_reference  reference to source code
	 * @return                  newly created variable declarator
	 */
	public LocalVariable (DataType? variable_type, string name, Expression? initializer = null, SourceReference? source_reference = null) {
		base (variable_type, name, initializer, source_reference);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_local_variable (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (initializer != null) {
			initializer.accept (visitor);

			visitor.visit_end_full_expression (initializer);
		}

		if (variable_type != null) {
			variable_type.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (initializer == old_node) {
			initializer = new_node;
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (variable_type == old_type) {
			variable_type = new_type;
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (variable_type == null) {
			variable_type = new VarType ();
		}

		if (!context.experimental_non_null) {
			// local reference variables are considered nullable
			// except when using experimental non-null enhancements
			if (variable_type is ReferenceType) {
				unowned ArrayType? array_type = variable_type as ArrayType;
				if (array_type != null && array_type.fixed_length) {
					// local fixed length arrays are not nullable
				} else {
					variable_type.nullable = true;
				}
			}
		}

		if (!(variable_type is VarType)) {
			if (variable_type is VoidType) {
				error = true;
				Report.error (source_reference, "'void' not supported as variable type");
			} else if (!variable_type.check (context)) {
				error = true;
			}
			if (!external_package) {
				context.analyzer.check_type (variable_type);
			}
		}

		// Catch initializer list transformation:
		bool is_initializer_list = false;
		int initializer_size = -1;

		if (initializer != null && !error) {
			initializer.target_type = variable_type;

			if (initializer is InitializerList) {
				initializer_size = ((InitializerList) initializer).size;
				is_initializer_list = true;
			}

			if (!initializer.check (context)) {
				error = true;
			} else if (initializer.value_type is VoidType) {
				error = true;
				Report.error (initializer.source_reference, "'void' not supported as initializer type");
			}
		}

		// local variables are defined even on errors
		context.analyzer.current_symbol.scope.add (name, this);

		if (error) {
			return false;
		}

		if (variable_type is VarType) {
			/* var type */

			if (initializer == null) {
				error = true;
				Report.error (source_reference, "var declaration not allowed without initializer");
				return false;
			}
			if (initializer.value_type == null) {
				error = true;
				Report.error (source_reference, "var declaration not allowed with non-typed initializer");
				return false;
			}
			if (initializer.value_type is FieldPrototype || initializer.value_type is PropertyPrototype) {
				error = true;
				Report.error (initializer.source_reference, "Access to instance member `%s' denied".printf (initializer.symbol_reference.get_full_name ()));
				return false;
			}

			bool value_owned = variable_type.value_owned;
			variable_type = initializer.value_type.copy ();
			variable_type.value_owned = value_owned;
			variable_type.floating_reference = false;

			initializer.target_type = variable_type;
			variable_type.check (context);
		}

		if (!external_package) {
			// check symbol availability
			if (variable_type.type_symbol != null) {
				variable_type.type_symbol.version.check (source_reference);
			}
		}

		unowned ArrayType? variable_array_type = variable_type as ArrayType;
		if (variable_array_type != null && variable_array_type.inline_allocated
		    && initializer is ArrayCreationExpression && ((ArrayCreationExpression) initializer).initializer_list == null) {
			Report.warning (source_reference, "Inline allocated arrays don't require an explicit instantiation");
			initializer = null;
		}

		if (variable_array_type != null && variable_array_type.inline_allocated
		    && variable_array_type.length == null && !(initializer is ArrayCreationExpression)) {
			error = true;
			Report.error (source_reference, "Inline allocated array requires either a given length or an initializer");
		}

		if (initializer != null && !initializer.error) {
			if (initializer.value_type is MethodType) {
				if (!(initializer is MemberAccess) && !(initializer is LambdaExpression)) {
					error = true;
					Report.error (source_reference, "expression type not allowed as initializer");
					return false;
				}

				if (variable_type is DelegateType) {
					/* check whether method matches callback type */
					if (!initializer.value_type.compatible (variable_type)) {
						unowned Method m = (Method) initializer.symbol_reference;
						unowned Delegate cb = ((DelegateType) variable_type).delegate_symbol;
						error = true;
						Report.error (source_reference, "Declaration of method `%s' is not compatible with delegate `%s'".printf (m.get_full_name (), cb.get_full_name ()));
						return false;
					}
				} else {
					error = true;
					Report.error (source_reference, "expression type not allowed as initializer");
					return false;
				}
			}

			if (!initializer.value_type.compatible (variable_type)) {
				error = true;
				Report.error (source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (initializer.value_type.to_string (), variable_type.to_string ()));
				return false;
			}

			if (variable_array_type != null && variable_array_type.inline_allocated && !variable_array_type.fixed_length && is_initializer_list) {
				variable_array_type.length = new IntegerLiteral (initializer_size.to_string ());
				variable_array_type.fixed_length = true;
				variable_array_type.nullable = false;
			}

			if (variable_array_type != null && variable_array_type.inline_allocated && initializer.value_type is ArrayType == false) {
				error = true;
				Report.error (source_reference, "only arrays are allowed as initializer for arrays with fixed length");
				return false;
			}

			if (initializer.value_type.is_disposable ()) {
				/* rhs transfers ownership of the expression */
				if (!(variable_type is PointerType) && !variable_type.value_owned) {
					/* lhs doesn't own the value */
					error = true;
					Report.error (source_reference, "Invalid assignment from owned expression to unowned variable");
					return false;
				}
			}
		}

		// current_symbol is a Method if this is the `result'
		// variable used for postconditions
		unowned Block? block = context.analyzer.current_symbol as Block;
		if (block != null) {
			block.add_local_variable (this);
		}

		active = true;

		return !error;
	}
}
