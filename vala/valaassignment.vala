/* valaassignment.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		left.lvalue = true;

		if (!left.check (analyzer)) {
			// skip on error in inner expression
			error = true;
			return false;
		}

		if (left is MemberAccess) {
			var ma = (MemberAccess) left;

			if (!(ma.symbol_reference is Signal || ma.symbol_reference is DynamicProperty) && ma.value_type == null) {
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

			if (ma.symbol_reference is DynamicSignal) {
				// target_type not available for dynamic signals
			} else if (ma.symbol_reference is Signal) {
				var sig = (Signal) ma.symbol_reference;
				right.target_type = new DelegateType (sig.get_delegate (ma.inner.value_type, this));
			} else {
				right.formal_target_type = ma.formal_value_type;
				right.target_type = ma.value_type;
			}
		} else if (left is ElementAccess) {
			var ea = (ElementAccess) left;

			if (ea.container.value_type.data_type == analyzer.string_type.data_type) {
				error = true;
				Report.error (ea.source_reference, "strings are immutable");
				return false;
			} else if (ea.container is MemberAccess && ea.container.symbol_reference is Signal) {
				var ma = (MemberAccess) ea.container;
				var sig = (Signal) ea.container.symbol_reference;
				right.target_type = new DelegateType (sig.get_delegate (ma.inner.value_type, this));
			} else if (ea.container.value_type.get_member ("set") is Method) {
				var set_call = new MethodCall (new MemberAccess (ea.container, "set"));
				foreach (Expression e in ea.get_indices ()) {
					set_call.add_argument (e);
				}
				set_call.add_argument (right);
				parent_node.replace_expression (this, set_call);
				return set_call.check (analyzer);
			} else {
				right.target_type = left.value_type;
			}
		} else if (left is PointerIndirection) {
			right.target_type = left.value_type;
		} else {
			error = true;
			Report.error (source_reference, "unsupported lvalue in assignment");
			return false;
		}

		if (!right.check (analyzer)) {
			// skip on error in inner expression
			error = true;
			return false;
		}

		if (operator != AssignmentOperator.SIMPLE && left is MemberAccess) {
			// transform into simple assignment
			// FIXME: only do this if the backend doesn't support
			// the assignment natively

			var ma = (MemberAccess) left;

			if (!(ma.symbol_reference is Signal)) {
				var old_value = new MemberAccess (ma.inner, ma.member_name);

				var bin = new BinaryExpression (BinaryOperator.PLUS, old_value, right);
				bin.target_type = right.target_type;
				right.target_type = right.target_type.copy ();
				right.target_type.value_owned = false;

				if (operator == AssignmentOperator.BITWISE_OR) {
					bin.operator = BinaryOperator.BITWISE_OR;
				} else if (operator == AssignmentOperator.BITWISE_AND) {
					bin.operator = BinaryOperator.BITWISE_AND;
				} else if (operator == AssignmentOperator.BITWISE_XOR) {
					bin.operator = BinaryOperator.BITWISE_XOR;
				} else if (operator == AssignmentOperator.ADD) {
					bin.operator = BinaryOperator.PLUS;
				} else if (operator == AssignmentOperator.SUB) {
					bin.operator = BinaryOperator.MINUS;
				} else if (operator == AssignmentOperator.MUL) {
					bin.operator = BinaryOperator.MUL;
				} else if (operator == AssignmentOperator.DIV) {
					bin.operator = BinaryOperator.DIV;
				} else if (operator == AssignmentOperator.PERCENT) {
					bin.operator = BinaryOperator.MOD;
				} else if (operator == AssignmentOperator.SHIFT_LEFT) {
					bin.operator = BinaryOperator.SHIFT_LEFT;
				} else if (operator == AssignmentOperator.SHIFT_RIGHT) {
					bin.operator = BinaryOperator.SHIFT_RIGHT;
				}

				right = bin;
				right.check (analyzer);

				operator = AssignmentOperator.SIMPLE;
			}
		}

		if (left.symbol_reference is Signal) {
			var sig = (Signal) left.symbol_reference;

			var m = right.symbol_reference as Method;

			if (m == null) {
				error = true;
				Report.error (right.source_reference, "unsupported expression for signal handler");
				return false;
			}

			var dynamic_sig = sig as DynamicSignal;
			var right_ma = right as MemberAccess;
			if (dynamic_sig != null) {
				bool first = true;
				foreach (FormalParameter param in dynamic_sig.handler.value_type.get_parameters ()) {
					if (first) {
						// skip sender parameter
						first = false;
					} else {
						dynamic_sig.add_parameter (param.copy ());
					}
				}
				right.target_type = new DelegateType (sig.get_delegate (new ObjectType ((ObjectTypeSymbol) sig.parent_symbol), this));
			} else if (!right.value_type.compatible (right.target_type)) {
				var delegate_type = (DelegateType) right.target_type;

				error = true;
				Report.error (right.source_reference, "method `%s' is incompatible with signal `%s', expected `%s'".printf (right.value_type.to_string (), right.target_type.to_string (), delegate_type.delegate_symbol.get_prototype_string (m.name)));
				return false;
			} else if (right_ma != null && right_ma.prototype_access) {
				error = true;
				Report.error (right.source_reference, "Access to instance member `%s' denied".printf (m.get_full_name ()));
				return false;
			}
		} else if (left is MemberAccess) {
			var ma = (MemberAccess) left;

			if (ma.symbol_reference is Property) {
				var prop = (Property) ma.symbol_reference;

				var dynamic_prop = prop as DynamicProperty;
				if (dynamic_prop != null) {
					dynamic_prop.property_type = right.value_type.copy ();
					left.value_type = dynamic_prop.property_type.copy ();
				}

				if (prop.set_accessor == null
				    || (!prop.set_accessor.writable && !(analyzer.find_current_method () is CreationMethod || analyzer.is_in_constructor ()))) {
					ma.error = true;
					Report.error (ma.source_reference, "Property `%s' is read-only".printf (prop.get_full_name ()));
					return false;
				} else if (!analyzer.context.deprecated
				           && !prop.set_accessor.writable
				           && analyzer.find_current_method () is CreationMethod) {
					if (ma.inner.symbol_reference != analyzer.find_current_method ().this_parameter) {
						// trying to set construct-only property in creation method for foreign instance
						Report.error (ma.source_reference, "Property `%s' is read-only".printf (prop.get_full_name ()));
						return false;
					} else {
						Report.warning (ma.source_reference, "assigning to construct-only properties is deprecated, use Object (property: value) constructor chain up");
					}
				}
			} else if (ma.symbol_reference is LocalVariable && right.value_type == null) {
				var local = (LocalVariable) ma.symbol_reference;

				if (right.symbol_reference is Method &&
				    local.variable_type is DelegateType) {
					var m = (Method) right.symbol_reference;
					var dt = (DelegateType) local.variable_type;
					var cb = dt.delegate_symbol;

					/* check whether method matches callback type */
					if (!cb.matches_method (m)) {
						error = true;
						Report.error (source_reference, "declaration of method `%s' doesn't match declaration of callback `%s'".printf (m.get_full_name (), cb.get_full_name ()));
						return false;
					}

					right.value_type = local.variable_type;
				} else {
					error = true;
					Report.error (source_reference, "Assignment: Invalid callback assignment attempt");
					return false;
				}
			} else if (ma.symbol_reference is Field && right.value_type == null) {
				var f = (Field) ma.symbol_reference;

				if (right.symbol_reference is Method &&
				    f.field_type is DelegateType) {
					var m = (Method) right.symbol_reference;
					var dt = (DelegateType) f.field_type;
					var cb = dt.delegate_symbol;

					/* check whether method matches callback type */
					if (!cb.matches_method (m)) {
						f.error = true;
						Report.error (source_reference, "declaration of method `%s' doesn't match declaration of callback `%s'".printf (m.get_full_name (), cb.get_full_name ()));
						return false;
					}

					right.value_type = f.field_type;
				} else {
					error = true;
					Report.error (source_reference, "Assignment: Invalid callback assignment attempt");
					return false;
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
		} else if (left is ElementAccess) {
			var ea = (ElementAccess) left;

			if (!right.value_type.compatible (left.value_type)) {
				error = true;
				Report.error (source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (right.value_type.to_string (), left.value_type.to_string ()));
				return false;
			}

			if (right.value_type.is_disposable ()) {
				/* rhs transfers ownership of the expression */

				DataType element_type;

				if (ea.container.value_type is ArrayType) {
					var array_type = (ArrayType) ea.container.value_type;
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

		add_error_types (left.get_error_types ());
		add_error_types (right.get_error_types ());

		return !error;
	}

	public override void get_defined_variables (Collection<LocalVariable> collection) {
		right.get_defined_variables (collection);
		left.get_defined_variables (collection);
		var local = left.symbol_reference as LocalVariable;
		if (local != null) {
			collection.add (local);
		}
	}

	public override void get_used_variables (Collection<LocalVariable> collection) {
		var ma = left as MemberAccess;
		var ea = left as ElementAccess;
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
	SHIFT_RIGHT
}
