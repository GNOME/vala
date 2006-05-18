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
	}
}
