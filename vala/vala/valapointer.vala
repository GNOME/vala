/* valapointer.vala
 *
 * Copyright (C) 2007  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 * Represents a pointer-type.
 */
public class Vala.Pointer : DataType {
	/**
	 * The type to which this pointer type points.
	 */
	public DataType! referent_type { get; set construct; }
	
	private string cname;
	
	public Pointer (construct DataType! referent_type, construct SourceReference source_reference = null) {
	}

	construct {
		name = referent_type.name + "*";
	}

	public override string get_cname (bool const_type = false) {
		if (cname == null) {
			if (referent_type.is_reference_type ()) {
				cname = "%s**".printf (referent_type.get_cname ());
			} else {
				cname = "%s*".printf (referent_type.get_cname ());
			}
		}

		return cname;
	}

	public override bool is_reference_type () {
		return false;
	}
	
	public override ref string get_upper_case_cname (string infix) {
		return null;
	}

	public override ref string get_lower_case_cname (string infix) {
		return null;
	}

	public override string get_free_function () {
		return null;
	}
	
	public override ref List<string> get_cheader_filenames () {
		return referent_type.get_cheader_filenames ();
	}

	public override string get_type_id () {
		return "G_TYPE_POINTER";
	}

	public override string get_marshaller_type_name () {
		return "POINTER";
	}

	public override string get_get_value_function () {
		return "g_value_get_pointer";
	}
	
	public override string get_set_value_function () {
		return "g_value_set_pointer";
	}
}
