/* valadelegatetype.vala
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

using GLib;

/**
 * The type of an instance of a delegate.
 */
public class Vala.DelegateType : DataType {
	public Delegate delegate_symbol { get; set; }

	public bool is_called_once { get; set; }

	public DelegateType (Delegate delegate_symbol) {
		this.delegate_symbol = delegate_symbol;
	}

	public override bool is_invokable () {
		return true;
	}

	public override DataType? get_return_type () {
		return delegate_symbol.return_type;
	}

	public override List<Parameter>? get_parameters () {
		return delegate_symbol.get_parameters ();
	}

	public override string to_qualified_string (Scope? scope) {
		// logic temporarily duplicated from DataType class

		Symbol global_symbol = delegate_symbol;
		while (global_symbol.parent_symbol.name != null) {
			global_symbol = global_symbol.parent_symbol;
		}

		Symbol sym = null;
		Scope parent_scope = scope;
		while (sym == null && parent_scope != null) {
			sym = parent_scope.lookup (global_symbol.name);
			parent_scope = parent_scope.parent_scope;
		}

		string s;

		if (sym != null && global_symbol != sym) {
			s = "global::" + delegate_symbol.get_full_name ();;
		} else {
			s = delegate_symbol.get_full_name ();
		}

		var type_args = get_type_arguments ();
		if (type_args.size > 0) {
			s += "<";
			bool first = true;
			foreach (DataType type_arg in type_args) {
				if (!first) {
					s += ",";
				} else {
					first = false;
				}
				if (!type_arg.value_owned) {
					s += "weak ";
				}
				s += type_arg.to_qualified_string (scope);
			}
			s += ">";
		}
		if (nullable) {
			s += "?";
		}
		return s;
	}

	public override DataType copy () {
		var result = new DelegateType (delegate_symbol);
		result.source_reference = source_reference;
		result.value_owned = value_owned;
		result.nullable = nullable;

		foreach (DataType arg in get_type_arguments ()) {
			result.add_type_argument (arg.copy ());
		}

		result.is_called_once = is_called_once;

		return result;
	}

	public override bool is_accessible (Symbol sym) {
		return delegate_symbol.is_accessible (sym);
	}

	public override bool check (CodeContext context) {
		return delegate_symbol.check (context);
	}

	public override bool is_disposable () {
		return delegate_symbol.has_target && value_owned;
	}
}
