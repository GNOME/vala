/* valafield.vala
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
 * Represents a type or namespace field.
 */
public class Vala.Field : Variable, Lockable {
	/**
	 * Specifies whether this field may only be accessed with an instance of
	 * the contained type.
	 */
	public MemberBinding binding { get; set; default = MemberBinding.INSTANCE; }

	/**
	 * Specifies whether the field is volatile. Volatile fields are
	 * necessary to allow multi-threaded access.
	 */
	public bool is_volatile { get; set; }

	/**
	 * Specifies whether an array length field should implicitly be created
	 * if the field type is an array.
	 */
	public bool no_array_length { get; set; }

	/**
	 * Specifies whether a delegate target field should implicitly be created
	 * if the field type is a delegate.
	 */
	public bool no_delegate_target { get; set; }

	/**
	 * Specifies whether the array is null terminated.
	 */
	public bool array_null_terminated { get; set; }

	/**
	 * Specifies whether the array length field uses a custom name in C.
	 */
	public bool has_array_length_cname {
		get { return (array_length_cname != null); }
	}

	/**
	 * Specifies whether the array uses a custom C expression as length.
	 */
	public bool has_array_length_cexpr {
		get { return (array_length_cexpr != null); }
	}

	/**
	 * Specifies a custom type for the array length.
	 */
	public string? array_length_type { get; set; default = null; }

	private string? array_length_cname;

	private string? array_length_cexpr;

	private string cname;
	
	private bool lock_used = false;

	/**
	 * Creates a new field.
	 *
	 * @param name   field name
	 * @param type   field type
	 * @param init   initializer expression
	 * @param source reference to source code
	 * @return       newly created field
	 */
	public Field (string name, DataType variable_type, Expression? initializer, SourceReference? source_reference = null, Comment? comment = null) {
		base (variable_type, name, initializer, source_reference, comment);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_field (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		variable_type.accept (visitor);
		
		if (initializer != null) {
			initializer.accept (visitor);
		}
	}

	/**
	 * Returns the name of this field as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public string get_cname () {
		if (cname == null) {
			cname = get_default_cname ();
		}
		return cname;
	}

	/**
	 * Sets the name of this field as it is used in C code.
	 *
	 * @param cname the name to be used in C code
	 */
	public void set_cname (string cname) {
		this.cname = cname;
	}

	/**
	 * Returns the default name of this field as it is used in C code.
	 *
	 * @return the name to be used in C code by default
	 */
	public string get_default_cname () {
		if (binding == MemberBinding.STATIC) {
			return parent_symbol.get_lower_case_cprefix () + name;
		} else {
			return name;
		}
	}

	/**
	 * Returns the name of the array length field as it is used in C code
	 *
	 * @return the name of the array length field to be used in C code
	 */
	public string? get_array_length_cname () {
		return this.array_length_cname;
	}

	/**
	 * Sets the name of the array length field as it is used in C code
	 *
	 * @param array_length_cname the name of the array length field to be
	 * used in C code
	 */
	public void set_array_length_cname (string? array_length_cname) {
		this.array_length_cname = array_length_cname;
	}

	/**
	 * Returns the array length expression as it is used in C code
	 *
	 * @return the array length expression to be used in C code
	 */
	public string? get_array_length_cexpr () {
		return this.array_length_cexpr;
	}


	/**
	 * Sets the array length expression as it is used in C code
	 *
	 * @param array_length_cexpr the array length expression to be used in C
	 * code
	 */
	public void set_array_length_cexpr (string? array_length_cexpr) {
		this.array_length_cexpr = array_length_cexpr;
	}

	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("cname")) {
			set_cname (a.get_string ("cname"));
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				add_cheader_filename (filename);
			}
		}
		if (a.has_argument ("array_length")) {
			no_array_length = !a.get_bool ("array_length");
		}
		if (a.has_argument ("array_null_terminated")) {
			array_null_terminated = a.get_bool ("array_null_terminated");
		}
		if (a.has_argument ("array_length_cname")) {
			set_array_length_cname (a.get_string ("array_length_cname"));
		}
		if (a.has_argument ("array_length_cexpr")) {
			set_array_length_cexpr (a.get_string ("array_length_cexpr"));
		}
		if (a.has_argument ("array_length_type")) {
			array_length_type = a.get_string ("array_length_type");
		}
		if (a.has_argument ("delegate_target")) {
			no_delegate_target = !a.get_bool ("delegate_target");
		}
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			} else if (a.name == "Deprecated") {
				process_deprecated_attribute (a);
			}
		}
	}

	public bool get_lock_used () {
		return lock_used;
	}
	
	public void set_lock_used (bool used) {
		lock_used = used;
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (initializer == old_node) {
			initializer = new_node;
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (variable_type == old_type) {
			variable_type = new_type;
		}
	}

	public string? get_ctype () {
		var attr = get_attribute ("CCode");
		if (attr == null) {
			return null;
		}
		return attr.get_string ("type");
	}

	public void set_ctype (string ctype) {
		var attr = get_attribute ("CCode");
		if (attr == null) {
			attr = new Attribute ("CCode");
			attributes.append (attr);
		}
		attr.add_argument ("type", new StringLiteral ("\"%s\"".printf (ctype)));
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		var old_source_file = analyzer.current_source_file;
		var old_symbol = analyzer.current_symbol;

		if (source_reference != null) {
			analyzer.current_source_file = source_reference.file;
		}
		analyzer.current_symbol = this;

		variable_type.check (analyzer);

		// check whether field type is at least as accessible as the field
		if (!analyzer.is_type_accessible (this, variable_type)) {
			error = true;
			Report.error (source_reference, "field type `%s` is less accessible than field `%s`".printf (variable_type.to_string (), get_full_name ()));
			return false;
		}

		process_attributes ();

		if (initializer != null) {
			initializer.target_type = variable_type;

			if (!initializer.check (analyzer)) {
				error = true;
				return false;
			}

			if (initializer.value_type == null) {
				error = true;
				Report.error (source_reference, "expression type not allowed as initializer");
				return false;
			}

			if (!initializer.value_type.compatible (variable_type)) {
				error = true;
				Report.error (source_reference, "Cannot convert from `%s' to `%s'".printf (initializer.value_type.to_string (), variable_type.to_string ()));
				return false;
			}

			if (external) {
				error = true;
				Report.error (source_reference, "External fields cannot use initializers");
			}
		}

		if (binding == MemberBinding.INSTANCE && parent_symbol is Interface) {
			error = true;
			Report.error (source_reference, "Interfaces may not have instance fields");
			return false;
		}

		bool field_in_header = !is_internal_symbol ();
		if (parent_symbol is Class) {
			var cl = (Class) parent_symbol;
			if (cl.is_compact && !cl.is_internal_symbol ()) {
				// compact classes don't have priv structs
				field_in_header = true;
			}
		}

		if (!external_package && !hides && get_hidden_member () != null) {
			Report.warning (source_reference, "%s hides inherited field `%s'. Use the `new' keyword if hiding was intentional".printf (get_full_name (), get_hidden_member ().get_full_name ()));
		}

		analyzer.current_source_file = old_source_file;
		analyzer.current_symbol = old_symbol;

		return !error;
	}
}
