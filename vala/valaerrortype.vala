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

	public ErrorType (ErrorDomain? error_domain) {
		this.error_domain = error_domain;
		this.data_type = error_domain;
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
			return "GLib.error";
		} else {
			return error_domain.get_full_name ();
		}
	}

	public override DataType copy () {
		return new ErrorType (error_domain);
	}
}
