/* valaenumvalue.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
public class Vala.EnumValue : Symbol {
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
	public EnumValue (string name, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference);
		this.comment = comment;
	}

	/**
	 * Creates a new enum value with the specified numerical representation.
	 *
	 * @param name  enum value name
	 * @param value numerical representation
	 * @return      newly created enum value
	 */
	public EnumValue.with_value (string name, Expression value, SourceReference? source_reference = null, Comment? comment = null) {
		this (name, source_reference, comment);
		this.value = value;
	}
	
	/**
	 * Returns the string literal of this signal to be used in C code.
	 * (FIXME: from vlaasignal.vala)
	 *
	 * @return string literal to be used in C code
	 */
	public CCodeConstant get_canonical_cconstant () {
		var str = new StringBuilder ("\"");

		string i = name;

		while (i.len () > 0) {
			unichar c = i.get_char ();
			if (c == '_') {
				str.append_c ('-');
			} else {
				str.append_unichar (c.tolower ());
			}

			i = i.next_char ();
		}

		str.append_c ('"');

		return new CCodeConstant (str.str);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_enum_value (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (value != null) {
			value.accept (visitor);
		}
	}

	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode" && a.has_argument("cname")) {
				cname = a.get_string ("cname");
			} else if (a.name == "Deprecated") {
				process_deprecated_attribute (a);
			}
		}
	}

	/**
	 * Returns the name of this enum value as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public string get_cname () {
		if (cname == null) {
			cname = get_default_cname ();
		}
		return cname;
	}

	public string get_default_cname () {
		var en = (Enum) parent_symbol;
		return "%s%s".printf (en.get_cprefix (), name);
	}

	/**
	 * Sets the name of this enum value to be used in C code.
	 *
	 * @param cname the name to be used in C code
	 */
	public void set_cname (string cname) {
		this.cname = cname;
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		process_attributes ();

		if (value != null) {
			value.check (analyzer);
		}

		return !error;
	}
}
