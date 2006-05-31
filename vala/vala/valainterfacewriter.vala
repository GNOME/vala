/* valainterfacewriter.vala
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
	public class InterfaceWriter : CodeVisitor {
		File stream;
		
		int indent;
		/* at begin of line */
		bool bol = true;
		
		bool internal_scope = false;
		
		string current_cheader_filename;

		public void write_file (CodeContext context, string filename) {
			stream = File.open (filename, "w");
		
			/* we're only interested in non-pkg source files */
			foreach (SourceFile file in context.get_source_files ()) {
				if (!file.pkg) {
					file.accept (this);
				}
			}
			
			stream.close ();
		}
	
		public override void visit_begin_source_file (SourceFile source_file) {
			current_cheader_filename = source_file.get_cheader_filename ();
		}

		public override void visit_begin_namespace (Namespace ns) {
			if (ns.name == null)  {
				return;
			}
			
			write_indent ();
			write_string ("[CCode (cheader_filename = \"%s\")]".printf (current_cheader_filename));
			write_newline ();

			write_indent ();
			write_string ("namespace ");
			write_identifier (ns.name);
			write_begin_block ();
		}

		public override void visit_end_namespace (Namespace ns) {
			if (ns.name == null)  {
				return;
			}
			
			write_end_block ();
			write_newline ();
		}

		public override void visit_begin_class (Class cl) {
			if (cl.access != MemberAccessibility.PUBLIC) {
				internal_scope = true;
				return;
			}
			
			write_indent ();
			write_string ("public ");
			if (cl.is_abstract) {
				write_string ("abstract ");
			}
			write_string ("class ");
			write_identifier (cl.name);
			if (cl.base_types != null) {
				write_string (" : ");
			
				bool first = true;
				foreach (TypeReference base_type in cl.base_types) {
					if (!first) {
						write_string (", ");
					} else {
						first = false;
					}
					write_string (base_type.type.symbol.get_full_name ());
				}
			}
			write_begin_block ();
		}

		public override void visit_end_class (Class cl) {
			if (cl.access != MemberAccessibility.PUBLIC) {
				internal_scope = false;
				return;
			}
			
			write_end_block ();
			write_newline ();
		}

		public override void visit_begin_struct (Struct st) {
			if (st.access != MemberAccessibility.PUBLIC) {
				internal_scope = true;
				return;
			}
			
			write_indent ();
			write_string ("public struct ");
			write_identifier (st.name);
			write_begin_block ();
		}

		public override void visit_end_struct (Struct st) {
			if (st.access != MemberAccessibility.PUBLIC) {
				internal_scope = false;
				return;
			}
			
			write_end_block ();
			write_newline ();
		}

		public override void visit_begin_enum (Enum en) {
			if (en.access != MemberAccessibility.PUBLIC) {
				internal_scope = true;
				return;
			}
			
			write_indent ();
			write_string ("public enum ");
			write_identifier (en.name);
			write_begin_block ();
		}

		public override void visit_end_enum (Enum en) {
			if (en.access != MemberAccessibility.PUBLIC) {
				internal_scope = false;
				return;
			}
			
			write_end_block ();
			write_newline ();
		}

		public override void visit_enum_value (EnumValue ev) {
			if (internal_scope) {
				return;
			}
			
			write_indent ();
			write_identifier (ev.name);
			write_string (",");
			write_newline ();
		}

		public override void visit_constant (Constant c) {
		}

		public override void visit_field (Field f) {
			if (internal_scope || f.access != MemberAccessibility.PUBLIC) {
				return;
			}
			
			write_indent ();
			write_string ("public ");
			write_string (f.type_reference.type.symbol.get_full_name ());
			write_string (" ");
			write_identifier (f.name);
			write_string (";");
			write_newline ();
		}

		public override void visit_begin_method (Method m) {
			if (internal_scope || m.access != MemberAccessibility.PUBLIC || m.is_override) {
				return;
			}
			
			write_indent ();
			write_string ("public ");
			
			if (!m.instance) {
				write_string ("static ");
			} else if (m.is_abstract) {
				write_string ("abstract ");
			} else if (m.is_virtual) {
				write_string ("virtual ");
			}
			
			var type = m.return_type.type;
			if (type == null) {
				write_string ("void");
			} else {
				write_string (m.return_type.type.symbol.get_full_name ());
			}
			
			write_string (" ");
			write_identifier (m.name);
			write_string (" (");
			
			bool first = true;
			foreach (FormalParameter param in m.parameters) {
				if (!first) {
					write_string (", ");
				} else {
					first = false;
				}
				
				write_string (param.type_reference.type.symbol.get_full_name ());
				write_string (" ");
				write_identifier (param.name);
			}
			
			write_string (");");
			write_newline ();
		}

		public override void visit_begin_property (Property prop) {
			if (internal_scope) {
				return;
			}
			
			write_indent ();
			write_string ("public ");
			write_string (prop.type_reference.type.symbol.get_full_name ());
			write_string (" ");
			write_identifier (prop.name);
			write_string (" { get; set construct; }");
			write_newline ();
		}

		private void write_indent () {
			int i;
			
			if (!bol) {
				stream.putc ('\n');
			}
			
			for (i = 0; i < indent; i++) {
				stream.putc ('\t');
			}
			
			bol = false;
		}
		
		private void write_identifier (string s) {
			if (s == "namespace") {
				stream.putc ('@');
			}
			write_string (s);
		}
		
		private void write_string (string s) {
			stream.printf ("%s", s);
			bol = false;
		}
		
		private void write_newline () {
			stream.putc ('\n');
			bol = true;
		}
		
		private void write_begin_block () {
			if (!bol) {
				stream.putc (' ');
			} else {
				write_indent ();
			}
			stream.putc ('{');
			write_newline ();
			indent++;
		}
		
		private void write_end_block () {
			indent--;
			write_indent ();
			stream.printf ("}");
		}
	}
}
