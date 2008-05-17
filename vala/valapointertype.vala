/* valapointertype.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
using Gee;

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

	public override string to_string () {
		return base_type.to_string () + "*";
	}

	public override string? get_cname () {
		if (base_type.data_type != null && base_type.data_type.is_reference_type ()) {
			return base_type.get_cname ();
		} else {
			return base_type.get_cname () + "*";
		}
	}

	public override DataType copy () {
		return new PointerType (base_type);
	}

	public override bool compatible (DataType target_type) {
		if (target_type is PointerType || (target_type.data_type != null && target_type.data_type.get_attribute ("PointerType") != null)) {
			return true;
		}

		/* temporarily ignore type parameters */
		if (target_type.type_parameter != null) {
			return true;
		}

		if (base_type.is_reference_type_or_type_parameter ()) {
			// Object* is compatible with Object if Object is a reference type
			return base_type.compatible (target_type);
		}

		return false;
	}

	public override Symbol? get_pointer_member (string member_name) {
		Symbol base_symbol = base_type.data_type;

		if (base_symbol == null) {
			return null;
		}

		return SemanticAnalyzer.symbol_lookup_inherited (base_symbol, member_name);
	}

	public override Collection<Symbol> get_symbols () {
		return base_type.get_symbols ();
	}

	public override string? get_type_id () {
		return "G_TYPE_POINTER";
	}

	public override void accept_children (CodeVisitor visitor) {
		base_type.accept (visitor);
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (base_type == old_type) {
			base_type = new_type;
		}
	}
}
