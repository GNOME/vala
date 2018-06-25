/* valadelegatetype.vala
 *
 * Copyright (C) 2007-2012  Jürg Billeter
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
public class Vala.DelegateType : CallableType {
	public weak Delegate delegate_symbol { get; set; }

	public bool is_called_once { get; set; }

	public DelegateType (Delegate delegate_symbol) {
		this.delegate_symbol = delegate_symbol;
		this.is_called_once = (delegate_symbol.get_attribute_string ("CCode", "scope") == "async");
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
		while (global_symbol.parent_symbol != null && global_symbol.parent_symbol.name != null) {
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
		if (is_called_once && !value_owned) {
			Report.warning (source_reference, "delegates with scope=\"async\" must be owned");
		}

		if (!delegate_symbol.check (context)) {
			return false;
		}

		var n_type_params = delegate_symbol.get_type_parameters ().size;
		var n_type_args = get_type_arguments ().size;
		if (n_type_args > 0 && n_type_args < n_type_params) {
			Report.error (source_reference, "too few type arguments");
			return false;
		} else if (n_type_args > 0 && n_type_args > n_type_params) {
			Report.error (source_reference, "too many type arguments");
			return false;
		}

		foreach (DataType type in get_type_arguments ()) {
			if (!type.check (context)) {
				return false;
			}
		}

		return true;
	}

	public override bool compatible (DataType target_type) {
		var dt_target = target_type as DelegateType;
		if (dt_target == null) {
			return false;
		}

		// trivial case
		if (delegate_symbol == dt_target.delegate_symbol) {
			return true;
		}

		// target-delegate is allowed to ensure stricter return type (stronger postcondition)
		if (!get_return_type ().stricter (dt_target.get_return_type ().get_actual_type (dt_target, null, this))) {
			return false;
		}

		var parameters = get_parameters ();
		Iterator<Parameter> params_it = parameters.iterator ();

		if (dt_target.delegate_symbol.parent_symbol is Signal && dt_target.delegate_symbol.sender_type != null && parameters.size == dt_target.get_parameters ().size + 1) {
			// target-delegate has sender parameter
			params_it.next ();

			// target-delegate is allowed to accept arguments of looser types (weaker precondition)
			var p = params_it.get ();
			if (!dt_target.delegate_symbol.sender_type.stricter (p.variable_type)) {
				return false;
			}
		}

		foreach (Parameter param in dt_target.get_parameters ()) {
			/* target-delegate is allowed to accept less arguments */
			if (!params_it.next ()) {
				break;
			}

			// target-delegate is allowed to accept arguments of looser types (weaker precondition)
			var p = params_it.get ();
			if (!param.variable_type.get_actual_type (this, null, this).stricter (p.variable_type)) {
				return false;
			}
		}

		/* target-delegate may not expect more arguments */
		if (params_it.next ()) {
			return false;
		}

		// target-delegate may throw less but not more errors than the delegate
		foreach (DataType error_type in get_error_types ()) {
			bool match = false;
			foreach (DataType delegate_error_type in dt_target.get_error_types ()) {
				if (error_type.compatible (delegate_error_type)) {
					match = true;
					break;
				}
			}

			if (!match) {
				return false;
			}
		}

		return true;
	}

	public override bool is_disposable () {
		return delegate_symbol.has_target && value_owned && !is_called_once;
	}
}
