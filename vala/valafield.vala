/* valafield.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
public class Vala.Field : Member, Invokable, Lockable {
	/**
	 * The data type of this field.
	 */
	public TypeReference! type_reference { get; set; }

	/**
	 * Specifies the expression to be used to initialize this field.
	 */
	public Expression initializer { get; set; }
	
	/**
	 * Specifies whether this field may only be accessed with an instance of
	 * the contained type.
	 */
	public bool instance {
		get { return _instance; }
		set { _instance = value; }
	}
	
	/**
	 * Specifies whether an array length field should implicitly be created
	 * if the field type is an array.
	 */
	public bool no_array_length { get; set; }

	private string cname;
	private bool _instance = true;
	
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
	public Field (construct string! name, construct TypeReference! type_reference, construct Expression initializer, construct SourceReference source_reference = null) {
	}

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_member (this);
		
		visitor.visit_field (this);
	}

	public override void accept_children (CodeVisitor! visitor) {
		type_reference.accept (visitor);
		
		if (initializer != null) {
			initializer.accept (visitor);
		}
	}

	/**
	 * Returns the name of this field as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public string! get_cname () {
		if (cname == null) {
			cname = get_default_cname ();
		}
		return cname;
	}
	
	private void set_cname (string! cname) {
		this.cname = cname;
	}

	/**
	 * Returns the default name of this field as it is used in C code.
	 *
	 * @return the name to be used in C code by default
	 */
	public string! get_default_cname () {
		if (!instance) {
			return parent_symbol.get_lower_case_cprefix () + name;
		} else {
			return name;
		}
	}

	private void process_ccode_attribute (Attribute! a) {
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

	public Collection<FormalParameter> get_parameters () {
		if (!is_invokable ()) {
			return null;
		}
		
		var cb = (Callback) type_reference.data_type;
		return cb.get_parameters ();
	}
	
	public TypeReference get_return_type () {
		if (!is_invokable ()) {
			return null;
		}
		
		var cb = (Callback) type_reference.data_type;
		return cb.return_type;
	}

	public bool is_invokable () {
		return (type_reference.data_type is Callback);
	}
	
	public bool get_lock_used () {
		return lock_used;
	}
	
	public void set_lock_used (bool used) {
		lock_used = used;
	}
}
