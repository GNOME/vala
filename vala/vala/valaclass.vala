/* valaclass.vala
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
	public class Class : Struct {
		public List<TypeReference> base_types;
		public Class base_class;
		public bool is_abstract;
		
		List<Property> properties;

		public void add_base_type (TypeReference type) {
			base_types.append (type);
		}
		
		public static ref Class new (string name, SourceReference source) {
			return (new Class (name = name, source_reference = source));
		}
		
		public void add_property (Property prop) {
			properties.append (prop);
			
			if (prop.set_accessor != null && prop.set_accessor.body == null) {
				/* automatic property accessor body generation */
				var f = new Field (name = "_%s".printf (prop.name), type_reference = prop.type_reference, source_reference = prop.source_reference);
				f.access = MemberAccessibility.PRIVATE;
				add_field (f);
			}
		}
		
		public ref List<Property> get_properties () {
			return properties.copy ();
		}
		
		public override void accept (CodeVisitor visitor) {
			visitor.visit_begin_class (this);
			
			foreach (TypeReference type in base_types) {
				type.accept (visitor);
			}

			visit_children (visitor);			
			
			foreach (Property prop in properties) {
				prop.accept (visitor);
			}

			visitor.visit_end_class (this);
		}

		public override bool is_reference_type () {
			return true;
		}
	}
}
