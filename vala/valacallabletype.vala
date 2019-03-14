/* valacallabletype.vala
 *
 * Copyright (C) 2017  Rico Tzschichholz
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
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */

using GLib;

/**
 * A callable type, i.e. a delegate, method, or signal type.
 */
public abstract class Vala.CallableType : DataType {
	public weak Callable callable_symbol {
		get {
			return (Callable) symbol;
		}
	}

	protected CallableType (Symbol symbol) {
		base.with_symbol (symbol);
	}

	public override bool is_invokable () {
		return true;
	}

	public override unowned DataType? get_return_type () {
		return callable_symbol.return_type;
	}

	public override unowned List<Parameter>? get_parameters () {
		return callable_symbol.get_parameters ();
	}

	public override string to_prototype_string (string? override_name = null) {
		StringBuilder builder = new StringBuilder ();

		unowned DelegateType? delegate_type = this as DelegateType;
		unowned MethodType? method_type = this as MethodType;
		unowned SignalType? signal_type = this as SignalType;

		if (method_type != null && method_type.method_symbol.coroutine) {
			// Only methods can be asynchronous
			builder.append ("async ");
		} else if (delegate_type != null) {
			builder.append ("delegate ");
		} else if (signal_type != null) {
			builder.append ("signal ");
		}

		// Append return-type, but omit return-type for creation methods
		if (method_type == null || !(method_type.method_symbol is CreationMethod)) {
			builder.append (get_return_type ().to_prototype_string ());
		}

		// Append name
		builder.append_c (' ');
		builder.append (override_name ?? this.to_string ());
		builder.append_c (' ');

		// Append parameter-list
		builder.append_c ('(');
		int i = 1;
		// add sender parameter for internal signal-delegates
		if (delegate_type != null) {
			unowned Delegate delegate_symbol = delegate_type.delegate_symbol;
			if (delegate_symbol.parent_symbol is Signal && delegate_symbol.sender_type != null) {
				builder.append (delegate_symbol.sender_type.to_qualified_string ());
				i++;
			}
		}
		foreach (Parameter param in get_parameters ()) {
			if (i > 1) {
				builder.append (", ");
			}

			if (param.ellipsis) {
				builder.append ("...");
				continue;
			}

			if (param.params_array) {
				builder.append ("params ");
			}

			if (param.direction == ParameterDirection.IN) {
				if (param.variable_type.value_owned) {
					builder.append ("owned ");
				}
			} else {
				if (param.direction == ParameterDirection.REF) {
					builder.append ("ref ");
				} else if (param.direction == ParameterDirection.OUT) {
					builder.append ("out ");
				}
				if (!param.variable_type.value_owned && param.variable_type is ReferenceType) {
					builder.append ("weak ");
				}
			}

			builder.append (param.variable_type.to_qualified_string ());

			if (param.initializer != null) {
				builder.append (" = ");
				builder.append (param.initializer.to_string ());
			}

			i++;
		}
		builder.append_c (')');

		// Append error-types
		var error_types = new ArrayList<DataType> ();
		get_error_types (error_types);
		if (error_types.size > 0) {
			builder.append (" throws ");

			bool first = true;
			foreach (DataType type in error_types) {
				if (!first) {
					builder.append (", ");
				} else {
					first = false;
				}

				builder.append (type.to_string ());
			}
		}

		return builder.str;
	}
}
