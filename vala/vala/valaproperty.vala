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

namespace Vala {
	public class Property : CodeNode {
		public string name { get; construct; }
		public TypeReference type_reference { get; construct; }
		public PropertyAccessor get_accessor { get; construct; }
		public PropertyAccessor set_accessor { get; construct; }
		public SourceReference source_reference { get; construct; }
		public MemberAccessibility access;
		public FormalParameter this_parameter;
		public bool no_accessor_method;
		
		public static ref Property new (string name, TypeReference type, PropertyAccessor get_accessor, PropertyAccessor set_accessor, SourceReference source) {
			return (new Property (name = name, type_reference = type, get_accessor = get_accessor, set_accessor = set_accessor, source_reference = source));
		}
		
		public override void accept (CodeVisitor visitor) {
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
		
		public ref string get_upper_case_cname () {
			return "%s_%s".printf (((Class) symbol.parent_symbol.node).get_lower_case_cname (null), Namespace.camel_case_to_lower_case (name)).up ();
		}
		
		public ref CCodeConstant get_canonical_cconstant () {
			var str = String.new ("\"");
			
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
			
			return new CCodeConstant (name = str.str);
		}
		
		public void process_attributes () {
			foreach (Attribute a in attributes) {
				if (a.name == "NoAccessorMethod") {
					no_accessor_method = true;
				}
			}
		}
	}
}
