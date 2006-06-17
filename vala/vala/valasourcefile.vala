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
		public bool pkg { get; construct; }
		
		List<NamespaceReference> using_directives;

		Namespace global_namespace;
		List<Namespace> namespaces;
		
		private void init () {
			global_namespace = new Namespace (source_reference = new SourceReference (file = this));
		}
		
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
		
		public ref List<Namespace> get_namespaces () {
			return namespaces.copy ();
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
		
		string cheader_filename = null;
		
		public string get_cheader_filename () {
			if (cheader_filename == null) {
				var basename = filename.ndup ((uint) (filename.len () - ".vala".len ()));
				cheader_filename = "%s.h".printf (basename);
			}
			return cheader_filename;
		}
		
		string csource_filename = null;
		
		public string get_csource_filename () {
			if (csource_filename == null) {
				var basename = filename.ndup ((uint) (filename.len () - ".vala".len ()));
				csource_filename = "%s.c".printf (basename);
			}
			return csource_filename;
		}
		
		public List<weak string> header_external_includes;
		public List<weak string> header_internal_includes;
		public List<weak string> source_includes;
		
		public List<weak SourceFile> header_internal_full_dependencies;
		public List<weak SourceFile> header_internal_dependencies;
		public SourceFileCycle cycle; // null = not in a cycle; if not null, don't write typedefs
		public bool is_cycle_head; // if true, write typedefs for all types in the cycle
		public int mark; // used for cycle detection, 0 = white (not yet visited), 1 = gray (currently visiting), 2 = black (already visited)

		public void add_symbol_dependency (Symbol sym, SourceFileDependencyType dep_type) {
			Type_ t;
			
			if (sym.node is Type_) {
				t = (Type_) sym.node;
			} else if (sym.node is Method || sym.node is Field) {
				if (sym.parent_symbol.node is Type_) {
					t = (Type_) sym.parent_symbol.node;
				} else {
					return;
				}
			} else if (sym.node is Property) {
				t = (Type_) sym.parent_symbol.node;
			} else if (sym.node is FormalParameter) {
				var fp = (FormalParameter) sym.node;
				t = fp.type_reference.type;
				if (t == null) {
					/* generic type parameter */
					return;
				}
			} else {
				return;
			}
			
			if (dep_type == SourceFileDependencyType.SOURCE) {
				source_includes.concat (t.get_cheader_filenames ());
				return;
			}

			if (t.source_reference.file.pkg) {
				/* external package */
				header_external_includes.concat (t.get_cheader_filenames ());
				return;
			}
			
			if (dep_type == SourceFileDependencyType.HEADER_FULL || !t.is_reference_type ()) {
				header_internal_includes.concat (t.get_cheader_filenames ());
				header_internal_full_dependencies.append (t.source_reference.file);
			}

			header_internal_dependencies.append (t.source_reference.file);
		}
	}
	
	public enum SourceFileDependencyType {
		HEADER_FULL,
		HEADER_SHALLOW,
		SOURCE
	}
}
