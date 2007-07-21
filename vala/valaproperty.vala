/* valaproperty.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 * Represents a property declaration in the source code.
 */
public class Vala.Property : Member, Lockable {
	/**
	 * The property type.
	 */
	public TypeReference! type_reference { get; set construct; }
	
	/**
	 * The get accessor of this property if available.
	 */
	public PropertyAccessor get_accessor { get; set; }
	
	/**
	 * The set/construct accessor of this property if available.
	 */
	public PropertyAccessor set_accessor { get; set; }
	
	/**
	 * Specifies the accessibility of this property. Public accessibility
	 * doesn't limit access. Default accessibility limits access to this
	 * program or library. Private accessibility limits access to the parent
	 * class.
	 */
	public MemberAccessibility access { get; set; }
	
	/**
	 * Represents the generated ´this' parameter in this property.
	 */
	public FormalParameter this_parameter { get; set; }
	
	/**
	 * Specifies whether the implementation of this property does not
	 * provide getter/setter methods.
	 */
	public bool no_accessor_method { get; set; }
	
	/**
	 * Specifies whether automatic accessor code generation should be
	 * disabled.
	 */
	public bool interface_only { get; set; }
	
	/**
	 * Specifies whether this property is abstract. Abstract properties have
	 * no accessor bodies, may only be specified within abstract classes and
	 * interfaces, and must be overriden by derived non-abstract classes.
	 */
	public bool is_abstract { get; set; }
	
	/**
	 * Specifies whether this property is virtual. Virtual properties may be
	 * overridden by derived classes.
	 */
	public bool is_virtual { get; set; }
	
	/**
	 * Specifies whether this property overrides a virtual or abstract
	 * property of a base type.
	 */
	public bool overrides { get; set; }
	
	/**
	 * Specifies the virtual or abstract property this property overrides.
	 * Reference must be weak as virtual properties set base_property to
	 * themselves.
	 */
	public weak Property base_property { get; set; }
	
	/**
	 * Specifies the abstract interface property this property implements.
	 */
	public Property base_interface_property { get; set; }
	
	private bool lock_used = false;
	
	/**
	 * Creates a new property.
	 *
	 * @param name         property name
	 * @param type         property type
	 * @param get_accessor get accessor
	 * @param set_accessor set/construct accessor
	 * @param source       reference to source code
	 * @return             newly created property
	 */
	public Property (string! _name, TypeReference! type, PropertyAccessor _get_accessor, PropertyAccessor _set_accessor, SourceReference source) {
		name = _name;
		type_reference = type;
		get_accessor = _get_accessor;
		set_accessor = _set_accessor;
		source_reference = source;
	}

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_member (this);

		visitor.visit_property (this);
	}

	public override void accept_children (CodeVisitor! visitor) {
		type_reference.accept (visitor);
		
		if (get_accessor != null) {
			get_accessor.accept (visitor);
		}
		if (set_accessor != null) {
			set_accessor.accept (visitor);
		}
	}

	/**
	 * Returns the C name of this property in upper case. Words are
	 * separated by underscores. The upper case C name of the class is
	 * prefix of the result.
	 *
	 * @return the upper case name to be used in C code
	 */
	public string! get_upper_case_cname () {
		return "%s_%s".printf (parent_symbol.get_lower_case_cname (null), camel_case_to_lower_case (name)).up ();
	}
	
	/**
	 * Returns the string literal of this property to be used in C code.
	 *
	 * @return string literal to be used in C code
	 */
	public CCodeConstant! get_canonical_cconstant () {
		var str = new String ("\"");
		
		string i = name;
		
		while (i.len () > 0) {
			unichar c = i.get_char ();
			if (c == '_') {
				str.append_c ('-');
			} else {
				str.append_unichar (c);
			}
			
			i = i.next_char ();
		}
		
		str.append_c ('"');
		
		return new CCodeConstant (str.str);
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "NoAccessorMethod") {
				no_accessor_method = true;
			}
		}
	}
	
	public bool get_lock_used () {
		return lock_used;
	}
	
	public void set_lock_used (bool used) {
		lock_used = used;
	}
	
	/**
	 * Checks whether the accessors and type of the specified property
	 * matches this property.
	 *
	 * @param prop a property
	 * @return     true if the specified property is compatible to this
	 *             property
	 */
	public bool equals (Property! prop2) {
		if (!prop2.type_reference.equals (type_reference)) {
			return false;
		}

		if ((get_accessor == null && prop2.get_accessor != null) ||
		    (get_accessor != null && prop2.get_accessor == null)) {
			return false;
		}

		if ((set_accessor == null && prop2.set_accessor != null) ||
		    (set_accessor != null && prop2.set_accessor == null)) {
			return false;
		}

		if (set_accessor != null) {
			if (set_accessor.writable != prop2.set_accessor.writable) {
				return false;
			}
			if (set_accessor.construction != prop2.set_accessor.construction) {
				return false;
			}
		}

		return true;
	}
}
