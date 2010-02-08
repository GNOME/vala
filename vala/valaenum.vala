/* valaenum.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
 * Represents an enum declaration in the source code.
 */
public class Vala.Enum : TypeSymbol {
	/**
	 * Specifies whether this is a flags enum.
	 */
	public bool is_flags { get; set; }

	/**
	 * Specifies whether this enum has a registered GType.
	 */
	public bool has_type_id { get; set; default = true; }

	private List<EnumValue> values = new ArrayList<EnumValue> ();
	private List<Method> methods = new ArrayList<Method> ();
	private string cname;
	private string cprefix;
	private string lower_case_cprefix;
	private string lower_case_csuffix;
	private string type_id;

	/**
	 * Creates a new enum.
	 *
	 * @param name             type name
	 * @param source_reference reference to source code
	 * @return                 newly created enum
	 */
	public Enum (string name, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
	}
	
	/**
	 * Appends the specified enum value to the list of values.
	 *
	 * @param value an enum value
	 */
	public void add_value (EnumValue value) {
		values.add (value);
		scope.add (value.name, value);
	}

	/**
	 * Adds the specified method as a member to this enum.
	 *
	 * @param m a method
	 */
	public void add_method (Method m) {
		if (m is CreationMethod) {
			Report.error (m.source_reference, "construction methods may only be declared within classes and structs");
		
			m.error = true;
			return;
		}
		if (m.binding == MemberBinding.INSTANCE) {
			m.this_parameter = new FormalParameter ("this", new EnumValueType (this));
			m.scope.add (m.this_parameter.name, m.this_parameter);
		}

		methods.add (m);
		scope.add (m.name, m);
	}

	/**
	 * Returns a copy of the list of enum values.
	 *
	 * @return list of enum values
	 */
	public List<EnumValue> get_values () {
		return new ReadOnlyList<EnumValue> (values);
	}

	/**
	 * Returns a copy of the list of methods.
	 *
	 * @return list of methods
	 */
	public List<Method> get_methods () {
		return new ReadOnlyList<Method> (methods);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_enum (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (EnumValue value in values) {
			value.accept (visitor);
		}

		foreach (Method m in methods) {
			m.accept (visitor);
		}
	}

	public override string get_cname (bool const_type = false) {
		if (cname == null) {
			var attr = get_attribute ("CCode");
			if (attr != null) {
				cname = attr.get_string ("cname");
			}
			if (cname == null) {
				cname = "%s%s".printf (parent_symbol.get_cprefix (), name);
			}
		}
		return cname;
	}

	public void set_cname (string cname) {
		this.cname = cname;
	}

	public override string get_lower_case_cprefix () {
		if (lower_case_cprefix == null) {
			lower_case_cprefix = "%s_".printf (get_lower_case_cname (null));
		}
		return lower_case_cprefix;
	}

	private string get_lower_case_csuffix () {
		if (lower_case_csuffix == null) {
			lower_case_csuffix = camel_case_to_lower_case (name);
		}
		return lower_case_csuffix;
	}

	public override string? get_lower_case_cname (string? infix) {
		if (infix == null) {
			infix = "";
		}
		return "%s%s%s".printf (parent_symbol.get_lower_case_cprefix (), infix, get_lower_case_csuffix ());
	}

	public override string? get_upper_case_cname (string? infix = null) {
		return get_lower_case_cname (infix).up ();
	}

	public override bool is_reference_type () {
		return false;
	}

	public override string get_cprefix () {
		if (cprefix == null) {
			cprefix = "%s_".printf (get_upper_case_cname ());
		}
		return cprefix;
	}
	
	/**
	 * Sets the string to be prepended to the name of members of this enum
	 * when used in C code.
	 *
	 * @param cprefix the prefix to be used in C code
	 */
	public void set_cprefix (string? cprefix) {
		this.cprefix = cprefix;
	}
	
	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("cprefix")) {
			set_cprefix (a.get_string ("cprefix"));
		}
		if (a.has_argument ("lower_case_csuffix")) {
			lower_case_csuffix = a.get_string ("lower_case_csuffix");
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				add_cheader_filename (filename);
			}
		}
		if (a.has_argument ("has_type_id")) {
			has_type_id = a.get_bool ("has_type_id");
		}
		if (a.has_argument ("type_id")) {
			type_id = a.get_string ("type_id");
		}
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			} else if (a.name == "Flags") {
				is_flags = true;
			}
		}
	}

	public void set_type_id (string? type_id) {
		this.type_id = type_id;
	}

	public override string? get_type_id () {
		if (type_id == null) {
			if (has_type_id) {
				type_id = get_upper_case_cname ("TYPE_");
			} else {
				type_id = is_flags ? "G_TYPE_UINT" : "G_TYPE_INT";
			}
		}

		return type_id;
	}
	
	public override string? get_marshaller_type_name () {
		if (has_type_id) {
			if (is_flags) {
				return "FLAGS";
			} else {
				return "ENUM";
			}
		} else {
			if (is_flags) {
				return "UINT";
			} else {
				return "INT";
			}
		}
	}

	public override string? get_get_value_function () {
		if (has_type_id) {
			if (is_flags) {
				return "g_value_get_flags";
			} else {
				return "g_value_get_enum";
			}
		} else {
			if (is_flags) {
				return "g_value_get_uint";
			} else {
				return "g_value_get_int";
			}
		}
	}
	
	public override string? get_set_value_function () {
		if (has_type_id) {
			if (is_flags) {
				return "g_value_set_flags";
			} else {
				return "g_value_set_enum";
			}
		} else {
			if (is_flags) {
				return "g_value_set_uint";
			} else {
				return "g_value_set_int";
			}
		}
	}

	public override string? get_default_value () {
		return "0";
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		process_attributes ();

		var old_source_file = analyzer.current_source_file;
		var old_symbol = analyzer.current_symbol;

		if (source_reference != null) {
			analyzer.current_source_file = source_reference.file;
		}
		analyzer.current_symbol = this;

		foreach (EnumValue value in values) {
			value.check (analyzer);
		}

		foreach (Method m in methods) {
			m.check (analyzer);
		}

		analyzer.current_source_file = old_source_file;
		analyzer.current_symbol = old_symbol;

		return !error;
	}
}
