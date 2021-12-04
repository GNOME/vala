/* valasignaltype.vala
 *
 * Copyright (C) 2007-2011  Jürg Billeter
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
 * The type of a signal referencea.
 */
public class Vala.SignalType : CallableType {
	public weak Signal signal_symbol {
		get {
			return (Signal) symbol;
		}
	}

	Method? connect_method;
	Method? connect_after_method;
	Method? disconnect_method;
	Method? emit_method;

	public SignalType (Signal signal_symbol, SourceReference? source_reference = null) {
		base (signal_symbol, source_reference);
	}

	public override DataType copy () {
		return new SignalType (signal_symbol, source_reference);
	}

	public override bool compatible (DataType target_type) {
		return false;
	}

	public override string to_qualified_string (Scope? scope) {
		return signal_symbol.get_full_name ();
	}

	public DelegateType get_handler_type () {
		var type_sym = (ObjectTypeSymbol) signal_symbol.parent_symbol;
		var sender_type = SemanticAnalyzer.get_data_type_for_symbol (type_sym);
		var result = new DelegateType (signal_symbol.get_delegate (sender_type, this), source_reference);
		result.value_owned = true;

		if (result.delegate_symbol.has_type_parameters ()) {
			foreach (var type_param in type_sym.get_type_parameters ()) {
				var type_arg = new GenericType (type_param, source_reference);
				type_arg.value_owned = true;
				result.add_type_argument (type_arg);
			}
		}

		return result;
	}

	unowned Method get_connect_method () {
		if (connect_method == null) {
			var ulong_type = CodeContext.get ().analyzer.ulong_type.copy ();
			connect_method = new Method ("connect", ulong_type, source_reference);
			connect_method.access = SymbolAccessibility.PUBLIC;
			connect_method.external = true;
			connect_method.owner = signal_symbol.scope;
			connect_method.add_parameter (new Parameter ("handler", get_handler_type (), source_reference));
		}
		return connect_method;
	}

	unowned Method get_connect_after_method () {
		if (connect_after_method == null) {
			var ulong_type = CodeContext.get ().analyzer.ulong_type.copy ();
			connect_after_method = new Method ("connect_after", ulong_type, source_reference);
			connect_after_method.access = SymbolAccessibility.PUBLIC;
			connect_after_method.external = true;
			connect_after_method.owner = signal_symbol.scope;
			connect_after_method.add_parameter (new Parameter ("handler", get_handler_type (), source_reference));
		}
		return connect_after_method;
	}

	unowned Method get_disconnect_method () {
		if (disconnect_method == null) {
			disconnect_method = new Method ("disconnect", new VoidType (), source_reference);
			disconnect_method.access = SymbolAccessibility.PUBLIC;
			disconnect_method.external = true;
			disconnect_method.owner = signal_symbol.scope;
			disconnect_method.add_parameter (new Parameter ("handler", get_handler_type (), source_reference));
		}
		return disconnect_method;
	}

	unowned Method get_emit_method () {
		if (emit_method == null) {
			emit_method = new Method ("emit", signal_symbol.return_type, source_reference);
			emit_method.access = SymbolAccessibility.PUBLIC;
			emit_method.external = true;
			emit_method.owner = signal_symbol.scope;
		}
		return emit_method;
	}

	public override Symbol? get_member (string member_name) {
		if (member_name == "connect") {
			return get_connect_method ();
		} else if (member_name == "connect_after") {
			return get_connect_after_method ();
		} else if (member_name == "disconnect") {
			return get_disconnect_method ();
		} else if (member_name == "emit") {
			return get_emit_method ();
		}
		return null;
	}

	public override bool is_accessible (Symbol sym) {
		return signal_symbol.is_accessible (sym);
	}
}
