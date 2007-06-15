/* valacodegeneratorsourcefile.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;

public class Vala.CodeGenerator {
	private ref CCodeIncludeDirective get_internal_include (string! filename) {
		return new CCodeIncludeDirective (filename, context.library == null);
	}

	public override void visit_source_file (SourceFile! source_file) {
		header_begin = new CCodeFragment ();
		header_type_declaration = new CCodeFragment ();
		header_type_definition = new CCodeFragment ();
		header_type_member_declaration = new CCodeFragment ();
		source_begin = new CCodeFragment ();
		source_include_directives = new CCodeFragment ();
		source_type_member_declaration = new CCodeFragment ();
		source_type_member_definition = new CCodeFragment ();
		source_signal_marshaller_definition = new CCodeFragment ();
		source_signal_marshaller_declaration = new CCodeFragment ();
		
		user_marshal_list = new HashTable (str_hash, str_equal);
		
		next_temp_var_id = 0;
		
		string_h_needed = false;
		
		header_begin.append (new CCodeIncludeDirective ("glib.h"));
		header_begin.append (new CCodeIncludeDirective ("glib-object.h"));
		source_include_directives.append (new CCodeIncludeDirective (source_file.get_cheader_filename (), true));
		
		ref List<weak string> used_includes = null;
		used_includes.append ("glib.h");
		used_includes.append ("glib-object.h");
		used_includes.append (source_file.get_cheader_filename ());
		
		foreach (string filename1 in source_file.get_header_external_includes ()) {
			if (used_includes.find_custom (filename1, strcmp) == null) {
				header_begin.append (new CCodeIncludeDirective (filename1));
				used_includes.append (filename1);
			}
		}
		foreach (string filename2 in source_file.get_header_internal_includes ()) {
			if (used_includes.find_custom (filename2, strcmp) == null) {
				header_begin.append (get_internal_include (filename2));
				used_includes.append (filename2);
			}
		}
		foreach (string filename3 in source_file.get_source_external_includes ()) {
			if (used_includes.find_custom (filename3, strcmp) == null) {
				source_include_directives.append (new CCodeIncludeDirective (filename3));
				used_includes.append (filename3);
			}
		}
		foreach (string filename4 in source_file.get_source_internal_includes ()) {
			if (used_includes.find_custom (filename4, strcmp) == null) {
				source_include_directives.append (get_internal_include (filename4));
				used_includes.append (filename4);
			}
		}
		if (source_file.is_cycle_head) {
			foreach (SourceFile cycle_file in source_file.cycle.files) {
				var namespaces = cycle_file.get_namespaces ();
				foreach (Namespace ns in namespaces) {
					var structs = ns.get_structs ();
					foreach (Struct st in structs) {
						header_type_declaration.append (new CCodeTypeDefinition ("struct _%s".printf (st.get_cname ()), new CCodeVariableDeclarator (st.get_cname ())));
					}
					var classes = ns.get_classes ();
					foreach (Class cl in classes) {
						header_type_declaration.append (new CCodeTypeDefinition ("struct _%s".printf (cl.get_cname ()), new CCodeVariableDeclarator (cl.get_cname ())));
						header_type_declaration.append (new CCodeTypeDefinition ("struct _%sClass".printf (cl.get_cname ()), new CCodeVariableDeclarator ("%sClass".printf (cl.get_cname ()))));
					}
					var ifaces = ns.get_interfaces ();
					foreach (Interface iface in ifaces) {
						header_type_declaration.append (new CCodeTypeDefinition ("struct _%s".printf (iface.get_cname ()), new CCodeVariableDeclarator (iface.get_cname ())));
						header_type_declaration.append (new CCodeTypeDefinition ("struct _%s".printf (iface.get_type_cname ()), new CCodeVariableDeclarator (iface.get_type_cname ())));
					}
				}
			}
		}
		
		/* generate hardcoded "well-known" macros */
		source_begin.append (new CCodeMacroReplacement ("VALA_FREE_CHECKED(o,f)", "((o) == NULL ? NULL : ((o) = (f (o), NULL)))"));
		source_begin.append (new CCodeMacroReplacement ("VALA_FREE_UNCHECKED(o,f)", "((o) = (f (o), NULL))"));

		source_file.accept_children (this);

		var header_define = get_define_for_filename (source_file.get_cheader_filename ());
		
		if (string_h_needed) {
			source_include_directives.append (new CCodeIncludeDirective ("string.h"));
		}
		
		CCodeComment comment = null;
		if (source_file.comment != null) {
			comment = new CCodeComment (source_file.comment);
		}

		var writer = new CCodeWriter (source_file.get_cheader_filename ());
		if (comment != null) {
			comment.write (writer);
		}
		writer.write_newline ();
		var once = new CCodeOnceSection (header_define);
		once.append (new CCodeNewline ());
		once.append (header_begin);
		once.append (new CCodeNewline ());
		once.append (new CCodeIdentifier ("G_BEGIN_DECLS"));
		once.append (new CCodeNewline ());
		once.append (new CCodeNewline ());
		once.append (header_type_declaration);
		once.append (new CCodeNewline ());
		once.append (header_type_definition);
		once.append (new CCodeNewline ());
		once.append (header_type_member_declaration);
		once.append (new CCodeNewline ());
		once.append (new CCodeIdentifier ("G_END_DECLS"));
		once.append (new CCodeNewline ());
		once.append (new CCodeNewline ());
		once.write_declaration (writer);
		once.write (writer);
		writer.close ();
		
		writer = new CCodeWriter (source_file.get_csource_filename ());
		if (comment != null) {
			comment.write (writer);
		}
		source_begin.write (writer);
		writer.write_newline ();
		source_include_directives.write (writer);
		writer.write_newline ();
		source_type_member_declaration.write_declaration (writer);
		source_type_member_declaration.write (writer);
		writer.write_newline ();
		source_signal_marshaller_declaration.write_declaration (writer);
		source_signal_marshaller_declaration.write (writer);
		writer.write_newline ();
		source_type_member_definition.write (writer);
		writer.write_newline ();
		source_signal_marshaller_definition.write (writer);
		writer.write_newline ();
		writer.close ();

		header_begin = null;
		header_type_declaration = null;
		header_type_definition = null;
		header_type_member_declaration = null;
		source_begin = null;
		source_include_directives = null;
		source_type_member_declaration = null;
		source_type_member_definition = null;
		source_signal_marshaller_definition = null;
		source_signal_marshaller_declaration = null;
	}
	
	private static ref string get_define_for_filename (string! filename) {
		var define = new String ("__");
		
		var i = filename;
		while (i.len () > 0) {
			var c = i.get_char ();
			if (c.isalnum  () && c < 0x80) {
				define.append_unichar (c.toupper ());
			} else {
				define.append_c ('_');
			}
		
			i = i.next_char ();
		}
		
		define.append ("__");
		
		return define.str;
	}
}
