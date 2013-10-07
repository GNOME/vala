/* valacastexpression.vala
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
 * Represents a type cast in the source code.
 */
public class Vala.CastExpression : Expression {
	/**
	 * The expression to be cast.
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
	
	/**
	 * The target type.
	 */
	public DataType type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}

	/**
	 * Checked casts return NULL instead of raising an error.
	 */
	public bool is_silent_cast { get; set; }

	public bool is_non_null_cast { get; set; }

	private Expression _inner;

	private DataType _data_type;

	/**
	 * Creates a new cast expression.
	 *
	 * @param inner expression to be cast
	 * @param type  target type
	 * @return      newly created cast expression
	 */
	public CastExpression (Expression inner, DataType type_reference, SourceReference source_reference, bool is_silent_cast) {
		this.type_reference = type_reference;
		this.source_reference = source_reference;
		this.is_silent_cast = is_silent_cast;
		this.inner = inner;
	}

	public CastExpression.non_null (Expression inner, SourceReference source_reference) {
		this.inner = inner;
		this.is_non_null_cast = true;
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_cast_expression (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		inner.accept (visitor);
		if (!is_non_null_cast) {
			type_reference.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (inner == old_node) {
			inner = new_node;
		}
	}

	public override bool is_pure () {
		return inner.is_pure ();
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!inner.check (context)) {
			error = true;
			return false;
		}

		if (inner.value_type == null) {
			Report.error (source_reference, "Invalid cast expression");
			error = true;
			return false;
		}

		if (is_non_null_cast) {
			// (!) non-null cast
			type_reference = inner.value_type.copy ();
			type_reference.nullable = false;
		}

		type_reference.check (context);

		// FIXME: check whether cast is allowed

		if (type_reference is DelegateType && inner.value_type is MethodType) {
			if (target_type != null) {
				inner.value_type.value_owned = target_type.value_owned;
			} else {
				inner.value_type.value_owned = true;
			}
		}

		value_type = type_reference;
		value_type.value_owned = inner.value_type.value_owned;

		if (is_silent_cast) {
			value_type.nullable = true;
		}

		if (is_gvariant (context, inner.value_type) && !is_gvariant (context, value_type)) {
			// GVariant unboxing returns owned value
			value_type.value_owned = true;
		}

		inner.target_type = inner.value_type.copy ();

		return !error;
	}

	bool is_gvariant (CodeContext context, DataType type) {
		return type.data_type != null && type.data_type.is_subtype_of (context.analyzer.gvariant_type.data_type);
	}

	public override void emit (CodeGenerator codegen) {
		inner.emit (codegen);

		codegen.visit_cast_expression (this);

		codegen.visit_expression (this);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		inner.get_defined_variables (collection);
	}

	public override void get_used_variables (Collection<Variable> collection) {
		inner.get_used_variables (collection);
	}

	public override bool is_constant () {
		return inner.is_constant ();
	}
}
