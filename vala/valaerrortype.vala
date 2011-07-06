/* valaerrortype.vala
 *
 * Copyright (C) 2008-2010  Jürg Billeter
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

/**
 * A class type.
 */
public class Vala.ErrorType : ReferenceType {
	/**
	 * The error domain or null for generic error.
	 */
	public weak ErrorDomain? error_domain { get; set; }

	/**
	 * The error code or null for generic error.
	 */
	public weak ErrorCode? error_code { get; set; }

	public bool dynamic_error { get; set; }

	public ErrorType (ErrorDomain? error_domain, ErrorCode? error_code, SourceReference? source_reference = null) {
		this.error_domain = error_domain;
		this.data_type = error_domain;
		this.error_code = error_code;
		this.source_reference = source_reference;
	}

	public override bool compatible (DataType target_type) {
		/* temporarily ignore type parameters */
		if (target_type.type_parameter != null) {
			return true;
		}

		var et = target_type as ErrorType;

		/* error types are only compatible to error types */
		if (et == null) {
			return false;
		}

		/* every error type is compatible to the base error type */
		if (et.error_domain == null) {
			return true;
		}

		/* otherwhise the error_domain has to be equal */
		if (et.error_domain != error_domain) {
			return false;
		}

		if (et.error_code == null) {
			return true;
		}

		return et.error_code == error_code;
	}

	public override string to_qualified_string (Scope? scope) {
		string result;

		if (error_domain == null) {
			result = "GLib.Error";
		} else {
			result = error_domain.get_full_name ();
		}

		if (nullable) {
			result += "?";
		}

		return result;
	}

	public override DataType copy () {
		var result = new ErrorType (error_domain, error_code, source_reference);
		result.value_owned = value_owned;
		result.nullable = nullable;
		result.dynamic_error = dynamic_error;

		return result;
	}

	public override bool equals (DataType type2) {
		var et = type2 as ErrorType;

		if (et == null) {
			return false;
		}

		return error_domain == et.error_domain;
	}

	public override Symbol? get_member (string member_name) {
		var root_symbol = source_reference.file.context.root;
		var gerror_symbol = root_symbol.scope.lookup ("GLib").scope.lookup ("Error");
		return gerror_symbol.scope.lookup (member_name);
	}

	public override bool is_reference_type_or_type_parameter () {
		return true;
	}

	public override bool check (CodeContext context) {
		if (error_domain != null) {
			return error_domain.check (context);
		}
		return true;
	}
}
