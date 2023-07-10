/* valamethodtype.vala
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

/**
 * The type of a method referencea.
 */
public class Vala.MethodType : CallableType {
	public weak Method method_symbol {
		get {
			return (Method) symbol;
		}
	}

	public MethodType (Method method_symbol, SourceReference? source_reference = null) {
		base (method_symbol, source_reference);
	}

	public override DataType copy () {
		return new MethodType (method_symbol, source_reference);
	}

	public override bool compatible (DataType target_type) {
		unowned DelegateType? dt = target_type as DelegateType;
		if (dt == null) {
			// method types incompatible to anything but delegates
			return false;
		}

		// FIXME delegates don't provide dedicated parameters for generic arguments,
		// therefore they are never compatible
		if (!(method_symbol.parent_node is LambdaExpression) && method_symbol.has_type_parameters ()) {
			return false;
		}

		return dt.delegate_symbol.matches_method (method_symbol, dt);
	}

	public override string to_qualified_string (Scope? scope) {
		return method_symbol.get_full_name ();
	}

	public override Symbol? get_member (string member_name) {
		if (method_symbol.coroutine && member_name == "begin") {
			return method_symbol;
		} else if (method_symbol.coroutine && member_name == "end") {
			return method_symbol;
		} else if (method_symbol.coroutine && member_name == "callback") {
			return method_symbol.get_callback_method ();
		}
		return null;
	}
}
