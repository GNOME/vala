/* valaunaryexpression.vala
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
 * Represents an expression with one operand in the source code.
 *
 * Supports +, -, !, ~, ref, out.
 */
public class Vala.UnaryExpression : Expression {
	/**
	 * The unary operator.
	 */
	public UnaryOperator operator { get; set; }

	/**
	 * The operand.
	 */
	public Expression inner {
		get {
			return _inner;
		}
		set {
			_inner = value;
			_inner.parent_node = this;
		}
	}
	
	private Expression _inner;

	/**
	 * Creates a new unary expression.
	 *
	 * @param op     unary operator
	 * @param inner  operand
	 * @param source reference to source code
	 * @return       newly created binary expression
	 */
	public UnaryExpression (UnaryOperator op, Expression _inner, SourceReference source) {
		operator = op;
		inner = _inner;
		source_reference = source;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_unary_expression (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		inner.accept (visitor);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (inner == old_node) {
			inner = new_node;
		}
	}

	private string get_operator_string () {
		switch (_operator) {
		case UnaryOperator.PLUS: return "+";
		case UnaryOperator.MINUS: return "-";
		case UnaryOperator.LOGICAL_NEGATION: return "!";
		case UnaryOperator.BITWISE_COMPLEMENT: return "~";
		case UnaryOperator.INCREMENT: return "++";
		case UnaryOperator.DECREMENT: return "--";
		case UnaryOperator.REF: return "ref ";
		case UnaryOperator.OUT: return "out ";
		default: assert_not_reached ();
		}
	}

	public override string to_string () {
		return get_operator_string () + _inner.to_string ();
	}

	public override bool is_constant () {
		if (operator == UnaryOperator.INCREMENT || operator == UnaryOperator.DECREMENT) {
			return false;
		}

		if (operator == UnaryOperator.REF || operator == UnaryOperator.OUT) {
			var field = inner.symbol_reference as Field;
			if (field != null && field.binding == MemberBinding.STATIC) {
				return true;
			} else {
				return false;
			}
		}

		return inner.is_constant ();
	}

	public override bool is_pure () {
		if (operator == UnaryOperator.INCREMENT || operator == UnaryOperator.DECREMENT) {
			return false;
		}

		return inner.is_pure ();
	}

	bool is_numeric_type (DataType type) {
		if (!(type.data_type is Struct)) {
			return false;
		}

		var st = (Struct) type.data_type;
		return st.is_integer_type () || st.is_floating_type ();
	}

	bool is_integer_type (DataType type) {
		if (!(type.data_type is Struct)) {
			return false;
		}

		var st = (Struct) type.data_type;
		return st.is_integer_type ();
	}

	MemberAccess? find_member_access (Expression expr) {
		if (expr is MemberAccess) {
			return (MemberAccess) expr;
		}

		return null;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (operator == UnaryOperator.REF || operator == UnaryOperator.OUT) {
			inner.lvalue = true;
			inner.target_type = target_type;
		} else if (operator == UnaryOperator.INCREMENT || operator == UnaryOperator.DECREMENT) {
			inner.lvalue = true;
		}

		if (!inner.check (context)) {
			/* if there was an error in the inner expression, skip type check */
			error = true;
			return false;
		}

		if (inner.value_type is FieldPrototype) {
			error = true;
			Report.error (inner.source_reference, "Access to instance member `%s' denied".printf (inner.symbol_reference.get_full_name ()));
			return false;
		}

		if (operator == UnaryOperator.PLUS || operator == UnaryOperator.MINUS) {
			// integer or floating point type
			if (!is_numeric_type (inner.value_type)) {
				error = true;
				Report.error (source_reference, "Operator not supported for `%s'".printf (inner.value_type.to_string ()));
				return false;
			}

			value_type = inner.value_type;
		} else if (operator == UnaryOperator.LOGICAL_NEGATION) {
			// boolean type
			if (!inner.value_type.compatible (context.analyzer.bool_type)) {
				error = true;
				Report.error (source_reference, "Operator not supported for `%s'".printf (inner.value_type.to_string ()));
				return false;
			}

			value_type = inner.value_type;
		} else if (operator == UnaryOperator.BITWISE_COMPLEMENT) {
			// integer type
			if (!is_integer_type (inner.value_type) && !(inner.value_type is EnumValueType)) {
				error = true;
				Report.error (source_reference, "Operator not supported for `%s'".printf (inner.value_type.to_string ()));
				return false;
			}

			value_type = inner.value_type;
		} else if (operator == UnaryOperator.INCREMENT ||
		           operator == UnaryOperator.DECREMENT) {
			// integer type
			if (!is_integer_type (inner.value_type)) {
				error = true;
				Report.error (source_reference, "Operator not supported for `%s'".printf (inner.value_type.to_string ()));
				return false;
			}

			var ma = find_member_access (inner);
			if (ma == null) {
				error = true;
				Report.error (source_reference, "Prefix operators not supported for this expression");
				return false;
			}

			var old_value = new MemberAccess (ma.inner, ma.member_name, inner.source_reference);
			var bin = new BinaryExpression (operator == UnaryOperator.INCREMENT ? BinaryOperator.PLUS : BinaryOperator.MINUS, old_value, new IntegerLiteral ("1"), source_reference);

			var assignment = new Assignment (ma, bin, AssignmentOperator.SIMPLE, source_reference);
			assignment.target_type = target_type;
			context.analyzer.replaced_nodes.add (this);
			parent_node.replace_expression (this, assignment);
			assignment.check (context);
			return true;
		} else if (operator == UnaryOperator.REF || operator == UnaryOperator.OUT) {
			var ea = inner as ElementAccess;
			if (inner.symbol_reference is Field || inner.symbol_reference is Parameter || inner.symbol_reference is LocalVariable ||
			    (ea != null && ea.container.value_type is ArrayType)) {
				// ref and out can only be used with fields, parameters, local variables, and array element access
				lvalue = true;
				value_type = inner.value_type;
			} else {
				error = true;
				Report.error (source_reference, "ref and out method arguments can only be used with fields, parameters, local variables, and array element access");
				return false;
			}
		} else {
			error = true;
			Report.error (source_reference, "internal error: unsupported unary operator");
			return false;
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		inner.emit (codegen);

		codegen.visit_unary_expression (this);

		codegen.visit_expression (this);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		inner.get_defined_variables (collection);
		if (operator == UnaryOperator.OUT || operator == UnaryOperator.REF) {
			var local = inner.symbol_reference as LocalVariable;
			var param = inner.symbol_reference as Parameter;
			if (local != null) {
				collection.add (local);
			}
			if (param != null && param.direction == ParameterDirection.OUT) {
				collection.add (param);
			}
		}
	}

	public override void get_used_variables (Collection<Variable> collection) {
		if (operator != UnaryOperator.OUT) {
			inner.get_used_variables (collection);
		}
	}
}

public enum Vala.UnaryOperator {
	NONE,
	PLUS,
	MINUS,
	LOGICAL_NEGATION,
	BITWISE_COMPLEMENT,
	INCREMENT,
	DECREMENT,
	REF,
	OUT
}
