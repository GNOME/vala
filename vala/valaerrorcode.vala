/* valaerrorcode.vala
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
 * Represents an enum member in the source code.
 */
public class Vala.ErrorCode : TypeSymbol {
	/**
	 * Specifies the numerical representation of this enum value.
	 */
	public Expression value { get; set; }

	private string cname;

	/**
	 * Creates a new enum value.
	 *
	 * @param name enum value name
	 * @return     newly created enum value
	 */
	public ErrorCode (string name, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
	}

	/**
	 * Creates a new enum value with the specified numerical representation.
	 *
	 * @param name  enum value name
	 * @param value numerical representation
	 * @return      newly created enum value
	 */
	public ErrorCode.with_value (string name, Expression value, SourceReference? source_reference = null) {
		this (name, source_reference);
		this.value = value;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_error_code (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (value != null) {
			value.accept (visitor);
		}
	}

	public override string get_cname (bool const_type = false) {
		if (cname == null) {
			cname = get_default_cname ();
		}
		return cname;
	}

	public string get_default_cname () {
		var edomain = (ErrorDomain) parent_symbol;
		return "%s%s".printf (edomain.get_cprefix (), name);
	}

	public void set_cname (string value) {
		this.cname = value;
	}

	public override string? get_lower_case_cname (string? infix) {
		return get_cname ().down ();
	}

	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("cname")) {
			cname = a.get_string ("cname");
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

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		process_attributes ();

		if (value != null) {
			value.check (context);
		}

		return !error;
	}
}
