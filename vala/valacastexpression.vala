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
		private set {
			_inner = value;
			_inner.parent_node = this;
		}
	}

	/**
	 * The target type.
	 */
	public DataType type_reference {
		get { return _data_type; }
		private set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}

	/**
	 * Checked casts return NULL instead of raising an error.
	 */
	public bool is_silent_cast { get; private set; }

	public bool is_non_null_cast { get; private set; }

	private Expression _inner;

	private DataType _data_type;

	/**
	 * Creates a new cast expression.
	 *
	 * @param inner           expression to be cast
	 * @param type_reference  target type
	 * @return                newly created cast expression
	 */
	public CastExpression (Expression inner, DataType type_reference, SourceReference? source_reference = null) {
		this.type_reference = type_reference;
		this.source_reference = source_reference;
		this.is_silent_cast = false;
		this.is_non_null_cast = false;
		this.inner = inner;
	}

	public CastExpression.silent (Expression inner, DataType type_reference, SourceReference? source_reference = null) {
		this.type_reference = type_reference;
		this.source_reference = source_reference;
		this.is_silent_cast = true;
		this.is_non_null_cast = false;
		this.inner = inner;
	}

	public CastExpression.non_null (Expression inner, SourceReference? source_reference = null) {
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

	public override string to_string () {
		if (is_non_null_cast) {
			return "(!) %s".printf (inner.to_string ());
		} else if (is_silent_cast) {
			return "%s as %s".printf (inner.to_string (), type_reference.to_string ());
		} else {
			return "(%s) %s".printf (type_reference.to_string (), inner.to_string ());
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

	public override bool is_accessible (Symbol sym) {
		return inner.is_accessible (sym);
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}

	public override bool is_non_null () {
		return is_non_null_cast || (!is_silent_cast && inner.is_non_null ());
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		inner.get_error_types (collection, source_reference);
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

		if (type_reference is VoidType) {
			Report.error (source_reference, "Casting to `void' is not allowed");
			error = true;
			return false;
		}

		// Allow casting to array or pointer type
		if (!(type_reference is ArrayType || type_reference is PointerType)) {
			if (!type_reference.is_real_struct_type () && inner.value_type.is_real_struct_type ()
			    && (context.profile != Profile.GOBJECT || !(is_gvariant (context, inner.value_type) || is_gvalue (context, inner.value_type)))) {
				error = true;
				Report.error (source_reference, "Casting of struct `%s' to `%s' is not allowed", inner.value_type.to_qualified_string (), type_reference.to_qualified_string ());
			}
		}

		if (type_reference is DelegateType && inner.value_type is MethodType) {
			if (target_type != null) {
				inner.value_type.value_owned = target_type.value_owned;
			} else {
				inner.value_type.value_owned = true;
			}
		}

		// Implicit transformation of stack-allocated value to heap-allocated boxed-type
		if (!(is_silent_cast || is_non_null_cast)
		    && (type_reference is ValueType && type_reference.nullable)
		    && inner.value_type.is_non_null_simple_type ()) {
			var local = new LocalVariable (type_reference, get_temp_name (), null, inner.source_reference);
			var decl = new DeclarationStatement (local, source_reference);

			insert_statement (context.analyzer.insert_block, decl);

			var temp_access = SemanticAnalyzer.create_temp_access (local, target_type);
			temp_access.formal_target_type = formal_target_type;

			// don't set initializer earlier as this changes parent_node and parent_statement
			local.initializer = inner;
			decl.check (context);

			context.analyzer.replaced_nodes.add (this);
			parent_node.replace_expression (this, temp_access);
			return temp_access.check (context);
		}

		value_type = type_reference;
		value_type.value_owned = inner.value_type.value_owned;
		value_type.floating_reference = inner.value_type.floating_reference;

		if (is_silent_cast) {
			value_type.nullable = true;
		}

		if (context.profile == Profile.GOBJECT
		    && is_gvariant (context, inner.value_type) && !is_gvariant (context, value_type)) {
			// GVariant unboxing returns owned value
			value_type.value_owned = true;
			if (value_type.get_type_signature () == null) {
				error = true;
				Report.error (source_reference, "Casting of `GLib.Variant' to `%s' is not supported", value_type.to_qualified_string ());
			}
		}

		if (context.profile == Profile.GOBJECT
		    && is_gvalue (context, inner.value_type) && !is_gvalue (context, value_type)) {
			// GValue unboxing returns unowned value
			value_type.value_owned = false;
			if (value_type.nullable && value_type.type_symbol != null && !value_type.type_symbol.is_reference_type ()) {
				error = true;
				Report.error (source_reference, "Casting of `GLib.Value' to `%s' is not supported", value_type.to_qualified_string ());
			}
		}

		inner.target_type = inner.value_type.copy ();

		return !error;
	}

	bool is_gvariant (CodeContext context, DataType type) {
		return type.type_symbol != null && type.type_symbol.is_subtype_of (context.analyzer.gvariant_type.type_symbol);
	}

	bool is_gvalue (CodeContext context, DataType type) {
		return type.type_symbol != null && type.type_symbol.is_subtype_of (context.analyzer.gvalue_type.type_symbol);
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
