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
		public string filename { get; construct; }
		public string comment;
		
		List<NamespaceReference> using_directives;

		Namespace global_namespace = new Namespace ();
		List<Namespace> namespaces;
		
		public void add_using_directive (NamespaceReference ns) {
			using_directives.append (ns);
		}
		
		public List<NamespaceReference> get_using_directives () {
			return using_directives;
		}
		
		public void add_namespace (Namespace ns) {
			namespaces.append (ns);
		}
		
		public Namespace get_global_namespace () {
			return global_namespace;
		}
		
		public void accept (CodeVisitor visitor) {
			visitor.visit_begin_source_file (this);

			foreach (NamespaceReference ns_ref in using_directives) {
				ns_ref.accept (visitor);
			}
			
			global_namespace.accept (visitor);
			
			foreach (Namespace ns in namespaces) {
				ns.accept (visitor);
			}

			visitor.visit_end_source_file (this);
		}
		
		public ref string get_cheader_filename () {
			var basename = filename.ndup (filename.len (-1) - ".vala".len (-1));
			return "%s.h".printf (basename);
		}
		
		public ref string get_csource_filename () {
			var basename = filename.ndup (filename.len (-1) - ".vala".len (-1));
			return "%s.c".printf (basename);
		}
	}
}
