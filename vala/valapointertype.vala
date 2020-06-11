/* valapointertype.vala
 *
 * Copyright (C) 2007-2009  Jürg Billeter
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
 * A pointer type.
 */
public class Vala.PointerType : DataType {
	/**
	 * The base type the pointer is referring to.
	 */
	public DataType base_type {
		get { return _base_type; }
		set {
			_base_type = value;
			_base_type.parent_node = this;
		}
	}

	private DataType _base_type;

	public PointerType (DataType base_type, SourceReference? source_reference = null) {
		this.base_type = base_type;
		nullable = true;
		this.source_reference = source_reference;
	}

	public override string to_qualified_string (Scope? scope) {
		return base_type.to_qualified_string (scope) + "*";
	}

	public override DataType copy () {
		return new PointerType (base_type.copy ());
	}

	public override bool compatible (DataType target_type) {
		if (target_type is PointerType) {
			unowned PointerType? tt = target_type as PointerType;

			if (tt.base_type is VoidType || base_type is VoidType) {
				return true;
			}

			/* dereference only if both types are references or not */
			if (base_type.is_reference_type_or_type_parameter () != tt.base_type.is_reference_type_or_type_parameter ()) {
				return false;
			}

			return base_type.compatible (tt.base_type);
		}

		if ((target_type.type_symbol != null && target_type.type_symbol.get_attribute ("PointerType") != null)) {
			return true;
		}

		/* temporarily ignore type parameters */
		if (target_type is GenericType) {
			return true;
		}

		if (base_type.is_reference_type_or_type_parameter ()) {
			// Object* is compatible with Object if Object is a reference type
			return base_type.compatible (target_type);
		}

		var context = CodeContext.get ();

		if (context.profile == Profile.GOBJECT && target_type.type_symbol != null && target_type.type_symbol.is_subtype_of (context.analyzer.gvalue_type.type_symbol)) {
			// allow implicit conversion to GValue
			return true;
		}

		return false;
	}

	public override Symbol? get_member (string member_name) {
		return null;
	}

	public override Symbol? get_pointer_member (string member_name) {
		unowned Symbol? base_symbol = base_type.type_symbol;

		if (base_symbol == null) {
			return null;
		}

		return SemanticAnalyzer.symbol_lookup_inherited (base_symbol, member_name);
	}

	public override bool is_accessible (Symbol sym) {
		return base_type.is_accessible (sym);
	}

	public override void accept_children (CodeVisitor visitor) {
		base_type.accept (visitor);
	}

	public override bool stricter (DataType type2) {
		if (type2 is PointerType) {
			return compatible (type2);
		}

		if (base_type is VoidType) {
			// void* can hold reference types
			return type2 is ReferenceType;
		}

		return base_type.stricter (type2);
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (base_type == old_type) {
			base_type = new_type;
		}
	}

	public override bool is_disposable () {
		return false;
	}

	public override DataType get_actual_type (DataType? derived_instance_type, List<DataType>? method_type_arguments, CodeNode? node_reference) {
		PointerType result = (PointerType) this.copy ();

		if (derived_instance_type == null && method_type_arguments == null) {
			return result;
		}

		if (base_type is GenericType || base_type.has_type_arguments ()) {
			result.base_type = result.base_type.get_actual_type (derived_instance_type, method_type_arguments, node_reference);
		}

		return result;
	}

	public override DataType? infer_type_argument (TypeParameter type_param, DataType value_type) {
		unowned PointerType? pointer_type = value_type as PointerType;
		if (pointer_type != null) {
			return base_type.infer_type_argument (type_param, pointer_type.base_type);
		}

		return null;
	}

	public override bool check (CodeContext context) {
		error = !base_type.check (context);
		return !error;
	}
}
