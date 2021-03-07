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
	public weak Delegate delegate_symbol {
		get {
			return (Delegate) symbol;
		}
	}

	public bool is_called_once { get; set; }

	DelegateTargetField? target_field;
	DelegateDestroyField? destroy_field;

	public DelegateType (Delegate delegate_symbol) {
		base (delegate_symbol);
		this.is_called_once = (delegate_symbol.get_attribute_string ("CCode", "scope") == "async");
	}

	public override Symbol? get_member (string member_name) {
		if (member_name == "target") {
			return get_target_field ();
		} else if (member_name == "destroy") {
			return get_destroy_field ();
		}
		return null;
	}

	unowned DelegateTargetField get_target_field () {
		if (target_field == null) {
			target_field = new DelegateTargetField (source_reference);
			target_field.access = SymbolAccessibility.PUBLIC;
		}
		return target_field;
	}

	unowned DelegateDestroyField get_destroy_field () {
		if (destroy_field == null) {
			destroy_field = new DelegateDestroyField (source_reference);
			destroy_field.access = SymbolAccessibility.PUBLIC;
		}
		return destroy_field;
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

	public override bool equals (DataType type2) {
		return compatible (type2);
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

		// check whether there is the expected amount of type-arguments
		if (!check_type_arguments (context, true)) {
			return false;
		}

		return true;
	}

	public override bool compatible (DataType target_type) {
		unowned DelegateType? dt_target = target_type as DelegateType;
		if (dt_target == null) {
			return false;
		}

		// trivial case
		if (delegate_symbol == dt_target.delegate_symbol) {
			return true;
		}

		if (delegate_symbol.has_target != dt_target.delegate_symbol.has_target) {
			return false;
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
			if (!params_it.next ()) {
				return false;
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
		var error_types = new ArrayList<DataType> ();
		get_error_types (error_types);
		foreach (DataType error_type in error_types) {
			bool match = false;
			var delegate_error_types = new ArrayList<DataType> ();
			dt_target.get_error_types (delegate_error_types);
			foreach (DataType delegate_error_type in delegate_error_types) {
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
