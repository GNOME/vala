/* valaproperty.vala
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
 * Represents a property declaration in the source code.
 */
public class Vala.Property : CodeNode {
	/**
	 * The property name.
	 */
	public string! name { get; set construct; }
	
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
	 * Creates a new property.
	 *
	 * @param name         property name
	 * @param type         property type
	 * @param get_accessor get accessor
	 * @param set_accessor set/construct accessor
	 * @param source       reference to source code
	 * @return             newly created property
	 */
	public construct (string! _name, TypeReference! type, PropertyAccessor _get_accessor, PropertyAccessor _set_accessor, SourceReference source) {
		name = _name;
		type_reference = type;
		get_accessor = _get_accessor;
		set_accessor = _set_accessor;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_property (this);

		type_reference.accept (visitor);
		
		if (get_accessor != null) {
			get_accessor.accept (visitor);
		}
		if (set_accessor != null) {
			set_accessor.accept (visitor);
		}
	
		visitor.visit_end_property (this);
	}
	
	/**
	 * Returns the C name of this property in upper case. Words are
	 * separated by underscores. The upper case C name of the class is
	 * prefix of the result.
	 *
	 * @return the upper case name to be used in C code
	 */
	public ref string! get_upper_case_cname () {
		return "%s_%s".printf (((Class) symbol.parent_symbol.node).get_lower_case_cname (null), Namespace.camel_case_to_lower_case (name)).up ();
	}
	
	/**
	 * Returns the string literal of this property to be used in C code.
	 *
	 * @return string literal to be used in C code
	 */
	public ref CCodeConstant! get_canonical_cconstant () {
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
}
