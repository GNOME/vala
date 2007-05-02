/* valaenum.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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
 * Represents an enum declaration in the source code.
 */
public class Vala.Enum : DataType {
	private List<EnumValue> values;
	private string cname;
	private string cprefix;

	/**
	 * Creates a new enum.
	 *
	 * @param name   type name
	 * @param source reference to source code
	 * @return       newly created enum
	 */
	public Enum (string! _name, SourceReference source = null) {
		name = _name;
		source_reference = source;
	}
	
	/**
	 * Appends the specified enum value to the list of values.
	 *
	 * @param value an enum value
	 */
	public void add_value (EnumValue! value) {
		values.append (value);
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_enum (this);
		
		foreach (EnumValue value in values) {
			value.accept (visitor);
		}

		visitor.visit_end_enum (this);
	}

	public override string get_cname (bool const_type = false) {
		if (cname == null) {
			cname = "%s%s".printf (@namespace.get_cprefix (), name);
		}
		return cname;
	}
	
	public override ref string get_upper_case_cname (string infix) {
		return "%s%s".printf (@namespace.get_lower_case_cprefix (), Namespace.camel_case_to_lower_case (name)).up ();
	}

	public override bool is_reference_type () {
		return false;
	}
	
	private void set_cname (string! cname) {
		this.cname = cname;
	}
	
	/**
	 * Returns the string to be prepended to the name of members of this
	 * enum when used in C code.
	 *
	 * @return the prefix to be used in C code
	 */
	public string! get_cprefix () {
		if (cprefix == null) {
			cprefix = "%s_".printf (get_upper_case_cname (null));
		}
		return cprefix;
	}
	
	/**
	 * Sets the string to be prepended to the name of members of this enum
	 * when used in C code.
	 *
	 * @param cprefix the prefix to be used in C code
	 */
	public void set_cprefix (string! cprefix) {
		this.cprefix = cprefix;
	}
	
	private void process_ccode_attribute (Attribute! a) {
		if (a.has_argument ("cname")) {
			set_cname (a.get_string ("cname"));
		}
		if (a.has_argument ("cprefix")) {
			set_cprefix (a.get_string ("cprefix"));
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				add_cheader_filename (filename);
			}
		}
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			}
		}
	}

	public override string get_type_id () {
		// FIXME: use GType-registered enums
		return "G_TYPE_INT";
	}
	
	public override string get_marshaller_type_name () {
		return "ENUM";
	}

	public override string get_get_value_function () {
		return "g_value_get_enum";
	}
	
	public override string get_set_value_function () {
		return "g_value_set_enum";
	}

	public override string get_default_value () {
		return "0";
	}
}
