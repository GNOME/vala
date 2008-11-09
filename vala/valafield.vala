/* valafield.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
using Gee;

/**
 * Represents a type or namespace field.
 */
public class Vala.Field : Member, Lockable {
	/**
	 * The data type of this field.
	 */
	public DataType field_type {
		get { return _data_type; }
		set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}

	/**
	 * Specifies the expression to be used to initialize this field.
	 */
	public Expression? initializer { 
		get { return _initializer; }
		set {
			_initializer = value;
			if (_initializer != null) {
				_initializer.parent_node = this;
			}
		}
	}

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

	private string cname;
	
	private bool lock_used = false;

	private Expression _initializer;

	private DataType _data_type;

	/**
	 * Creates a new field.
	 *
	 * @param name   field name
	 * @param type   field type
	 * @param init   initializer expression
	 * @param source reference to source code
	 * @return       newly created field
	 */
	public Field (string name, DataType field_type, Expression? initializer, SourceReference? source_reference = null) {
		base (name, source_reference);
		this.field_type = field_type;
		this.initializer = initializer;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_member (this);
		
		visitor.visit_field (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		field_type.accept (visitor);
		
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
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			} else if (a.name == "NoArrayLength") {
				no_array_length = true;
			}
		}
	}

	public bool get_lock_used () {
		return lock_used;
	}
	
	public void set_lock_used (bool used) {
		lock_used = used;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (field_type == old_type) {
			field_type = new_type;
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

		field_type.check (analyzer);

		process_attributes ();

		if (initializer != null) {
			initializer.target_type = field_type;
		}

		accept_children (analyzer);

		if (binding == MemberBinding.INSTANCE && parent_symbol is Interface) {
			error = true;
			Report.error (source_reference, "Interfaces may not have instance fields");
			return false;
		}

		if (!is_internal_symbol ()) {
			if (field_type is ValueType) {
				analyzer.current_source_file.add_type_dependency (field_type, SourceFileDependencyType.HEADER_FULL);
			} else {
				analyzer.current_source_file.add_type_dependency (field_type, SourceFileDependencyType.HEADER_SHALLOW);
			}
		} else {
			if (parent_symbol is Namespace) {
				error = true;
				Report.error (source_reference, "Namespaces may not have private members");
				return false;
			}

			analyzer.current_source_file.add_type_dependency (field_type, SourceFileDependencyType.SOURCE);
		}

		return !error;
	}
}
