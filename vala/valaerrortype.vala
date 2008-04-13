/* valaerrortype.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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

	public ErrorType (ErrorDomain? error_domain, SourceReference source_reference) {
		this.error_domain = error_domain;
		this.data_type = error_domain;
		this.source_reference = source_reference;
	}

	public override bool compatible (DataType! target_type, bool enable_non_null = true) {
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
		return et.error_domain == error_domain;
	}

	public override string to_string () {
		if (error_domain == null) {
			return "GLib.Error";
		} else {
			return error_domain.get_full_name ();
		}
	}

	public override DataType copy () {
		return new ErrorType (error_domain, source_reference);
	}

	public override string get_cname (bool var_type = false, bool const_type = false) {
		return "GError*";
	}

	public override string get_lower_case_cname (string infix = null) {
		if (error_domain == null) {
			if (infix == null) {
				return "g_error";
			} else {
				return "g_%s_error".printf (infix);
			}
		} else {
			return error_domain.get_lower_case_cname (infix);
		}
	}

	public override bool equals (DataType! type2) {
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

	public override string? get_type_id () {
		return "G_TYPE_POINTER";
	}
}
