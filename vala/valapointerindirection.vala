/* valapointerindirection.vala
 *
 * Copyright (C) 2007-2010  Jürg Billeter
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
 * Represents a pointer indirection in the source code, e.g. `*pointer`.
 */
public class Vala.PointerIndirection : Expression {
	/**
	 * The pointer to dereference.
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
	 * Creates a new pointer indirection.
	 *
	 * @param inner pointer to be dereferenced
	 * @return      newly created pointer indirection
	 */
	public PointerIndirection (Expression inner, SourceReference? source_reference = null) {
		this.source_reference = source_reference;
		this.inner = inner;
	}
	
	public override void accept (CodeVisitor visitor) {
		inner.accept (visitor);

		visitor.visit_pointer_indirection (this);

		visitor.visit_expression (this);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (inner == old_node) {
			inner = new_node;
		}
	}

	public override bool is_pure () {
		return inner.is_pure ();
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!inner.check (context)) {
			return false;
		}
		if (inner.value_type == null) {
			error = true;
			Report.error (source_reference, "internal error: unknown type of inner expression");
			return false;
		}
		if (inner.value_type is PointerType) {
			var pointer_type = (PointerType) inner.value_type;
			if (pointer_type.base_type is ReferenceType || pointer_type.base_type is VoidType) {
				error = true;
				Report.error (source_reference, "Pointer indirection not supported for this expression");
				return false;
			}
			value_type = pointer_type.base_type;
		} else {
			error = true;
			Report.error (source_reference, "Pointer indirection not supported for this expression");
			return false;
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		inner.emit (codegen);

		codegen.visit_pointer_indirection (this);

		codegen.visit_expression (this);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		inner.get_defined_variables (collection);
	}

	public override void get_used_variables (Collection<Variable> collection) {
		inner.get_used_variables (collection);
	}
}
