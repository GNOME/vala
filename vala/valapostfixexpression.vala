/* valapostfixexpression.vala
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
 * Represents a postfix increment or decrement expression.
 */
public class Vala.PostfixExpression : Expression {
	/**
	 * The operand, must be a variable or a property.
	 */
	public Expression inner {
		get { return _inner; }
		set {
			_inner = value;
			_inner.parent_node = this;
		}
	}
	
	/**
	 * Specifies whether value should be incremented or decremented.
	 */
	public bool increment { get; set; }

	private Expression _inner;

	/**
	 * Creates a new postfix expression.
	 *
	 * @param inner  operand expression
	 * @param inc    true for increment, false for decrement
	 * @param source reference to source code
	 * @return newly created postfix expression
	 */
	public PostfixExpression (Expression _inner, bool inc, SourceReference source) {
		inner = _inner;
		increment = inc;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_postfix_expression (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		inner.accept (visitor);
	}

	public override bool is_pure () {
		return false;
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		inner.get_defined_variables (collection);
		var local = inner.symbol_reference as LocalVariable;
		var param = inner.symbol_reference as Parameter;
		if (local != null) {
			collection.add (local);
		} else if (param != null && param.direction == ParameterDirection.OUT) {
			collection.add (param);
		}
	}

	public override void get_used_variables (Collection<Variable> collection) {
		inner.get_used_variables (collection);
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		inner.lvalue = true;
		if (!inner.check (context)) {
			error = true;
			return false;
		}

		if (!(inner.value_type is IntegerType) && !(inner.value_type is FloatingType) && !(inner.value_type is PointerType)) {
			error = true;
			Report.error (source_reference, "unsupported lvalue in postfix expression");
			return false;
		}

		if (inner is MemberAccess) {
			var ma = (MemberAccess) inner;

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
		} else if (inner is ElementAccess) {
			var ea = (ElementAccess) inner;
			if (!(ea.container.value_type is ArrayType)) {
				error = true;
				Report.error (source_reference, "unsupported lvalue in postfix expression");
				return false;
			}
		} else {
			error = true;
			Report.error (source_reference, "unsupported lvalue in postfix expression");
			return false;
		}

		if (inner is MemberAccess) {
			var ma = (MemberAccess) inner;

			if (ma.symbol_reference is Property) {
				var prop = (Property) ma.symbol_reference;

				if (prop.set_accessor == null || !prop.set_accessor.writable) {
					ma.error = true;
					Report.error (ma.source_reference, "Property `%s' is read-only".printf (prop.get_full_name ()));
					return false;
				}
			}
		}

		value_type = inner.value_type;

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		inner.emit (codegen);

		codegen.visit_postfix_expression (this);

		codegen.visit_expression (this);
	}
}
