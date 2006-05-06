/* valasourcefile.vala
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
	public class SourceFile {
		public readonly string# filename;
		
		Namespace# global_namespace = new Namespace ();
		List<Namespace#># namespaces;
		
		public void add_namespace (Namespace ns) {
			namespaces.append (ns);
		}
		
		public Namespace get_global_namespace () {
			return global_namespace;
		}
		
		public void accept (CodeVisitor visitor) {
			visitor.visit_source_file (this);
			
			global_namespace.accept (visitor);
			
			foreach (Namespace ns in namespaces) {
				ns.accept (visitor);
			}
		}
	}
}
