/* valapropertyaccessor.vala
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
	public class PropertyAccessor : CodeNode {
		public readonly ref bool readable;
		public readonly ref bool writable;
		public readonly ref bool construct_;
		public readonly ref Statement body;
		public readonly ref SourceReference source_reference;
		
		public static ref PropertyAccessor new (bool readable, bool writable, bool construct_, Statement body, SourceReference source) {
			return (new PropertyAccessor (readable = readable, writable = writable, construct_ = construct_, body = body, source_reference = source));
		}
		
		public override void accept (CodeVisitor visitor) {
			visitor.visit_begin_property_accessor (this);

			if (body != null) {
				body.accept (visitor);
			}
		
			visitor.visit_end_property_accessor (this);
		}
	}
}
