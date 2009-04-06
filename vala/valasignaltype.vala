/* valasignaltype.vala
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
using Gee;

/**
 * The type of a signal referencea.
 */
public class Vala.SignalType : DataType {
	public Signal signal_symbol { get; set; }

	public SignalType (Signal signal_symbol) {
		this.signal_symbol = signal_symbol;
	}

	public override bool is_invokable () {
		return true;
	}

	public override DataType? get_return_type () {
		return signal_symbol.return_type;
	}

	public override Gee.List<FormalParameter>? get_parameters () {
		return signal_symbol.get_parameters ();
	}

	public override DataType copy () {
		return new SignalType (signal_symbol);
	}

	public override bool compatible (DataType target_type) {
		return false;
	}

	public override string to_qualified_string (Scope? scope) {
		return signal_symbol.get_full_name ();
	}
}
