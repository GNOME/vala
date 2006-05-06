/* valanamespace.vala
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
	public class Namespace : CodeNode {
		public readonly string# name;
		public readonly SourceReference# source_reference;

		List<Class#># classes;
		
		public static Namespace# @new (string name, SourceReference source) {
			return (new Namespace (name = name, source_reference = source));
		}
		
		public void add_class (Class cl) {
			classes.append (cl);
		}
		
		public void remove_class (Class cl) {
			classes.remove (cl);
		}
		
		public List<Class># get_classes () {
			return classes.copy ();
		}
		
		public override void accept (CodeVisitor visitor) {
			visitor.visit_namespace (this);

			foreach (Class cl in classes) {
				cl.accept (visitor);
			}
		}
	}
}
