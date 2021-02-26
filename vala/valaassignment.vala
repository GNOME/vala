/* valaassignment.vala
 *
 * Copyright (C) 2006-2011  Jürg Billeter
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
 * Represents an assignment expression in the source code.
 *
 * Supports =, |=, &=, ^=, +=, -=, *=, /=, %=, <<=, >>=.
 */
public class Vala.Assignment : Expression {
	/**
	 * Left hand side of the assignment.
	 */
	public Expression left {
		get { return _left; }
		set {
			_left = value;
			_left.parent_node = this;
		}
	}

	/**
	 * Assignment operator.
	 */
	public AssignmentOperator operator { get; set; }

	/**
	 * Right hand side of the assignment.
	 */
	public Expression right {
		get { return _right; }
		set {
			_right = value;
			_right.parent_node = this;
		}
	}

	private Expression _left;
	private Expression _right;

	/**
	 * Creates a new assignment.
	 *
	 * @param left             left hand side
	 * @param operator         assignment operator
	 * @param right            right hand side
	 * @param source_reference reference to source code
	 * @return                 newly created assignment
	 */
	public Assignment (Expression left, Expression right, AssignmentOperator operator = AssignmentOperator.SIMPLE, SourceReference? source_reference = null) {
		this.right = right;
		this.operator = operator;
		this.source_reference = source_reference;
		this.left = left;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_assignment (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		left.accept (visitor);
		right.accept (visitor);
	}

	public override string to_string () {
		return "(%s %s %s)".printf (_left.to_string (), operator.to_string (), _right.to_string ());
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (left == old_node) {
			left = new_node;
		}
		if (right == old_node) {
			right = new_node;
		}
	}

	public override bool is_pure () {
		return false;
	}

	public override bool is_accessible (Symbol sym) {
		return left.is_accessible (sym) && right.is_accessible (sym);
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		left.get_error_types (collection, source_reference);
		right.get_error_types (collection, source_reference);
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (left is Tuple && operator == AssignmentOperator.SIMPLE && parent_node is ExpressionStatement) {
			unowned Tuple tuple = (Tuple) left;

			var local = new LocalVariable (null, get_temp_name (), right, right.source_reference);
			var decl = new DeclarationStatement (local, source_reference);
			insert_statement (context.analyzer.insert_block, decl);
			decl.check (context);

			int i = 0;
			ExpressionStatement stmt = null;
			foreach (var expr in tuple.get_expressions ()) {
				if (stmt != null) {
					insert_statement (context.analyzer.insert_block, stmt);
					stmt.check (context);
				}

				var temp_access = new MemberAccess.simple (local.name, right.source_reference);
				var ea = new ElementAccess (temp_access, expr.source_reference);
				ea.append_index (new IntegerLiteral (i.to_string (), expr.source_reference));
				var assign = new Assignment (expr, ea, operator, expr.source_reference);
				stmt = new ExpressionStatement (assign, expr.source_reference);

				i++;
			}

			context.analyzer.replaced_nodes.add (this);
			parent_node.replace_expression (this, stmt.expression);
			return stmt.expression.check (context);
		}

		left.lvalue = true;

		if (!left.check (context)) {
			// skip on error in inner expression
			error = true;
			return false;
		}

		if (left is MemberAccess) {
			unowned MemberAccess ma = (MemberAccess) left;

			check_constant_assignment (ma);

			if ((!(ma.symbol_reference is DynamicProperty) && ma.value_type == null) ||
			    (ma.inner == null && ma.member_name == "this" && context.analyzer.is_in_instance_method ())) {
				error = true;
				Report.error (source_reference, "unsupported lvalue in assignment");
				return false;
			}
			if (ma.prototype_access) {
				error = true;
				Report.error (source_reference, "Access to instance member `%s' denied".printf (ma.symbol_reference.get_full_name ()));
				return false;
			}

			if (ma.error || ma.symbol_reference == null) {
				error = true;
				/* if no symbol found, skip this check */
				return false;
			}

			if (ma.symbol_reference is DynamicProperty) {
				// target_type not available for dynamic properties
			} else {
				right.formal_target_type = ma.formal_value_type.copy ();
				right.target_type = ma.value_type.copy ();
			}
		} else if (left is ElementAccess) {
			unowned ElementAccess ea = (ElementAccess) left;

			check_constant_assignment (ea.container as MemberAccess);

			if (ea.container.value_type.type_symbol == context.analyzer.string_type.type_symbol) {
				error = true;
				Report.error (ea.source_reference, "strings are immutable");
				return false;
			} else if (ea.container.value_type.get_member ("set") is Method) {
				var set_call = new MethodCall (new MemberAccess (ea.container, "set", source_reference), source_reference);
				foreach (Expression e in ea.get_indices ()) {
					set_call.add_argument (e);
				}
				set_call.add_argument (right);
				parent_node.replace_expression (this, set_call);
				return set_call.check (context);
			} else {
				right.target_type = left.value_type.copy ();
			}
		} else if (left is PointerIndirection) {
			right.target_type = left.value_type.copy ();
		} else if (left is Literal) {
			error = true;
			Report.error (source_reference, "Literals are immutable");
			return false;
		} else {
			error = true;
			Report.error (source_reference, "unsupported lvalue in assignment");
			return false;
		}

		if (!right.check (context)) {
			// skip on error in inner expression
			error = true;
			return false;
		}

		unowned MemberAccess? ma = left as MemberAccess;
		if (operator != AssignmentOperator.SIMPLE && ma != null
		    && !(left.value_type.is_non_null_simple_type () && ma.symbol_reference is LocalVariable)) {
			// transform into simple assignment
			// FIXME: only do this if the backend doesn't support
			// the assignment natively

			var old_value = new MemberAccess (ma.inner, ma.member_name);

			BinaryOperator bop;

			switch (operator) {
			case AssignmentOperator.BITWISE_OR: bop = BinaryOperator.BITWISE_OR; break;
			case AssignmentOperator.BITWISE_AND: bop = BinaryOperator.BITWISE_AND; break;
			case AssignmentOperator.BITWISE_XOR: bop = BinaryOperator.BITWISE_XOR; break;
			case AssignmentOperator.ADD: bop = BinaryOperator.PLUS; break;
			case AssignmentOperator.SUB: bop = BinaryOperator.MINUS; break;
			case AssignmentOperator.MUL: bop = BinaryOperator.MUL; break;
			case AssignmentOperator.DIV: bop = BinaryOperator.DIV; break;
			case AssignmentOperator.PERCENT: bop = BinaryOperator.MOD; break;
			case AssignmentOperator.SHIFT_LEFT: bop = BinaryOperator.SHIFT_LEFT; break;
			case AssignmentOperator.SHIFT_RIGHT: bop = BinaryOperator.SHIFT_RIGHT; break;
			default:
				error = true;
				Report.error (source_reference, "internal error: unsupported assignment operator");
				return false;
			}

			var bin = new BinaryExpression (bop, old_value, right, source_reference);
			bin.target_type = right.target_type;
			right.target_type = right.target_type.copy ();
			right.target_type.value_owned = false;

			right = bin;
			right.check (context);

			operator = AssignmentOperator.SIMPLE;
		}

		if (ma != null) {
			if (ma.symbol_reference is Property) {
				unowned Property prop = (Property) ma.symbol_reference;

				unowned DynamicProperty? dynamic_prop = prop as DynamicProperty;
				if (dynamic_prop != null) {
					dynamic_prop.property_type = right.value_type.copy ();
					left.value_type = dynamic_prop.property_type.copy ();
				}
			} else if (ma.symbol_reference is ArrayLengthField && ((ArrayType) ma.inner.value_type).inline_allocated) {
				error = true;
				Report.error (source_reference, "`length' field of fixed length arrays is read-only");
				return false;
			} else if (ma.symbol_reference is Variable && right.value_type is MethodType) {
				unowned Variable variable = (Variable) ma.symbol_reference;

				if (variable.variable_type is DelegateType) {
					/* check whether method matches callback type */
					if (!right.value_type.compatible (variable.variable_type)) {
						unowned Method m = (Method) right.symbol_reference;
						unowned Delegate cb = ((DelegateType) variable.variable_type).delegate_symbol;
						error = true;
						Report.error (source_reference, "Declaration of method `%s' is not compatible with delegate `%s'".printf (m.get_full_name (), cb.get_full_name ()));
						return false;
					}
				} else {
					error = true;
					Report.error (source_reference, "Assignment: Invalid assignment attempt");
					return false;
				}
			} else if (ma.symbol_reference is Variable) {
				unowned Variable variable = (Variable) ma.symbol_reference;
				unowned ArrayType? variable_array_type = variable.variable_type as ArrayType;
				if (variable_array_type != null && variable_array_type.inline_allocated
				    && right is ArrayCreationExpression && ((ArrayCreationExpression) right).initializer_list == null) {
					Report.warning (source_reference, "Inline allocated arrays don't require an explicit instantiation");
					((Block) parent_node.parent_node).replace_statement ((Statement) parent_node, new EmptyStatement (source_reference));
					return true;
				}
			}

			if (left.value_type != null && right.value_type != null) {
				/* if there was an error on either side,
				 * i.e. {left|right}.value_type == null, skip type check */

				if (!right.value_type.compatible (left.value_type)) {
					error = true;
					Report.error (source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (right.value_type.to_string (), left.value_type.to_string ()));
					return false;
				}

				if (!(ma.symbol_reference is Property)) {
					if (right.value_type.is_disposable ()) {
						/* rhs transfers ownership of the expression */
						if (!(left.value_type is PointerType) && !left.value_type.value_owned) {
							/* lhs doesn't own the value */
							error = true;
							Report.error (source_reference, "Invalid assignment from owned expression to unowned variable");
						}
					} else if (left.value_type.value_owned) {
						/* lhs wants to own the value
						 * rhs doesn't transfer the ownership
						 * code generator needs to add reference
						 * increment calls */
					}
				}
			}

			unowned MemberAccess? right_ma = right as MemberAccess;
			if (right_ma != null && ma.symbol_reference == right_ma.symbol_reference) {
				if (ma.symbol_reference is LocalVariable || ma.symbol_reference is Parameter) {
					Report.warning (source_reference, "Assignment to same variable");
				} else if (ma.symbol_reference is Field) {
					unowned Field f = (Field) ma.symbol_reference;
					if (f.binding == MemberBinding.STATIC) {
						Report.warning (source_reference, "Assignment to same variable");
					} else {
						unowned MemberAccess? ma_inner = ma.inner as MemberAccess;
						unowned MemberAccess? right_ma_inner = right_ma.inner as MemberAccess;
						if (ma_inner != null && ma_inner.member_name == "this" && ma_inner.inner == null &&
						    right_ma_inner != null && right_ma_inner.member_name == "this" && right_ma_inner.inner == null) {
							Report.warning (source_reference, "Assignment to same variable");
						}
					}
				}
			}
		} else if (left is ElementAccess) {
			unowned ElementAccess ea = (ElementAccess) left;

			if (!right.value_type.compatible (left.value_type)) {
				error = true;
				Report.error (source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (right.value_type.to_string (), left.value_type.to_string ()));
				return false;
			}

			if (right.value_type.is_disposable ()) {
				/* rhs transfers ownership of the expression */

				DataType element_type;

				if (ea.container.value_type is ArrayType) {
					unowned ArrayType array_type = (ArrayType) ea.container.value_type;
					element_type = array_type.element_type;
				} else {
					var args = ea.container.value_type.get_type_arguments ();
					assert (args.size == 1);
					element_type = args.get (0);
				}

				if (!(element_type is PointerType) && !element_type.value_owned) {
					/* lhs doesn't own the value */
					error = true;
					Report.error (source_reference, "Invalid assignment from owned expression to unowned variable");
					return false;
				}
			} else if (left.value_type.value_owned) {
				/* lhs wants to own the value
				 * rhs doesn't transfer the ownership
				 * code generator needs to add reference
				 * increment calls */
			}
		} else {
			return true;
		}

		if (left.value_type != null) {
			value_type = left.value_type.copy ();
			value_type.value_owned = false;
		} else {
			value_type = null;
		}

		if (value_type != null) {
			value_type.check (context);
		}

		return !error;
	}

	bool is_array_add () {
		unowned BinaryExpression? binary = right as BinaryExpression;
		if (binary != null && binary.left.value_type is ArrayType) {
			if (binary.operator == BinaryOperator.PLUS) {
				if (left.symbol_reference == binary.left.symbol_reference) {
					// Allow direct access to array variable
					binary.left.lvalue = true;
					return true;
				}
			}
		}

		return false;
	}

	void check_constant_assignment (MemberAccess? inner) {
		while (inner != null) {
			if (inner.symbol_reference is Constant) {
				error = true;
				Report.error (source_reference, "Assignment to constant after initialization");
				break;
			}
			if (inner.inner is MemberAccess) {
				inner = (MemberAccess) inner.inner;
			} else if (inner.inner is ElementAccess) {
				inner = ((ElementAccess) inner.inner).container as MemberAccess;
			} else {
				inner = null;
			}
		}
	}

	public override void emit (CodeGenerator codegen) {
		unowned MemberAccess? ma = left as MemberAccess;
		unowned ElementAccess? ea = left as ElementAccess;
		unowned PointerIndirection? pi = left as PointerIndirection;
		if (ma != null) {
			unowned LocalVariable? local = ma.symbol_reference as LocalVariable;
			unowned Parameter? param = ma.symbol_reference as Parameter;
			unowned Field? field = ma.symbol_reference as Field;
			unowned Property? property = ma.symbol_reference as Property;

			bool instance = (field != null && field.binding != MemberBinding.STATIC)
				|| (property != null && property.binding != MemberBinding.STATIC);

			if (operator == AssignmentOperator.SIMPLE &&
			    (local != null || param != null || field != null) &&
			    !is_array_add () &&
			    !(field is ArrayLengthField) &&
			    !(field is DelegateTargetField) &&
			    !(field is DelegateDestroyField) &&
				!(left.value_type.is_real_non_null_struct_type () && right is ObjectCreationExpression)) {
				// visit_assignment not necessary
				if (instance && ma.inner != null) {
					ma.inner.emit (codegen);
				}

				right.emit (codegen);
				var new_value = right.target_value;

				if (local != null) {
					codegen.store_local (local, new_value, false, source_reference);
				} else if (param != null) {
					codegen.store_parameter (param, new_value, false, source_reference);
				} else if (field != null) {
					codegen.store_field (field, instance && ma.inner != null ? ma.inner.target_value : null, new_value, source_reference);
				}

				if (!(parent_node is ExpressionStatement)) {
					// when load_variable is changed to use temporary
					// variables, replace following code with this line
					// target_value = new_value;
					if (local != null) {
						target_value = codegen.load_local (local);
					} else if (param != null) {
						target_value = codegen.load_parameter (param);
					} else if (field != null) {
						target_value = codegen.load_field (field, instance && ma.inner != null ? ma.inner.target_value : null);
					}
				}

				codegen.visit_expression (this);
				return;
			}

			if (instance && ma.inner != null && property != null) {
				ma.inner.emit (codegen);
			} else if (property == null) {
				// always process full lvalue
				// current codegen depends on it
				// should be removed when moving codegen from
				// visit_assignment to emit_store_field/local/param
				ma.emit (codegen);
			}
		} else if (ea != null) {
			// always process full lvalue
			// current codegen depends on it
			// should be removed when moving codegen from
			// visit_assignment to emit_store_element
			ea.emit (codegen);
		} else if (pi != null) {
			// always process full lvalue
			// current codegen depends on it
			// should be removed when moving codegen from
			// visit_assignment to emit_store_indirectZ
			pi.emit (codegen);
		}

		right.emit (codegen);

		codegen.visit_assignment (this);

		codegen.visit_expression (this);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		right.get_defined_variables (collection);
		left.get_defined_variables (collection);
		unowned LocalVariable? local = left.symbol_reference as LocalVariable;
		unowned Parameter? param = left.symbol_reference as Parameter;
		if (local != null) {
			collection.add (local);
		} else if (param != null && param.direction == ParameterDirection.OUT) {
			collection.add (param);
		}
	}

	public override void get_used_variables (Collection<Variable> collection) {
		unowned MemberAccess? ma = left as MemberAccess;
		unowned ElementAccess? ea = left as ElementAccess;
		if (ma != null && ma.inner != null) {
			ma.inner.get_used_variables (collection);
		} else if (ea != null) {
			ea.get_used_variables (collection);
		}
		right.get_used_variables (collection);
	}
}

public enum Vala.AssignmentOperator {
	NONE,
	SIMPLE,
	BITWISE_OR,
	BITWISE_AND,
	BITWISE_XOR,
	ADD,
	SUB,
	MUL,
	DIV,
	PERCENT,
	SHIFT_LEFT,
	SHIFT_RIGHT;

	public unowned string to_string () {
		switch (this) {
		case SIMPLE: return "=";
		case BITWISE_OR: return "|=";
		case BITWISE_AND: return "&=";
		case BITWISE_XOR: return "^=";
		case ADD: return "+=";
		case SUB: return "-=";
		case MUL: return "*=";
		case DIV: return "/=";
		case PERCENT: return "%=";
		case SHIFT_LEFT: return "<<=";
		case SHIFT_RIGHT: return ">>=";
		default: assert_not_reached ();
		}
	}
}
