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
using Gee;

/**
 * The type of a method referencea.
 */
public class Vala.MethodType : DataType {
	public Method method_symbol { get; set; }

	public MethodType (Method method_symbol) {
		this.method_symbol = method_symbol;
	}

	public override bool is_invokable () {
		return true;
	}

	public override DataType get_return_type () {
		return method_symbol.return_type;
	}

	public override Collection<FormalParameter> get_parameters () {
		return method_symbol.get_parameters ();
	}

	public override DataType copy () {
		return new MethodType (method_symbol);
	}

	public override bool compatible (DataType target_type, bool enable_non_null = true) {
		var dt = target_type as DelegateType;
		if (dt == null) {
			// method types incompatible to anything but delegates
			return false;
		}
		
		return dt.delegate_symbol.matches_method (method_symbol);
	}

	public override string to_string () {
		return method_symbol.get_full_name ();
	}
}
