/* valacodegenerator.vala
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
	public class CodeGenerator : CodeVisitor {
		CCodeFragment# header_begin;
		CCodeFragment# header_type_declaration;
		CCodeFragment# header_type_definition;
		CCodeFragment# header_type_member_declaration;
		CCodeFragment# source_begin;
		CCodeFragment# source_include_directives;
		CCodeFragment# source_type_member_declaration;
		CCodeFragment# source_type_member_definition;
		
		CCodeStruct# instance_struct;
		
		TypeReference reference; // dummy for dependency resolution

		public void emit (CodeContext context) {
			context.accept (this);
		}
	
		public override void visit_begin_source_file (SourceFile source_file) {
			header_begin = new CCodeFragment ();
			header_type_declaration = new CCodeFragment ();
			header_type_definition = new CCodeFragment ();
			header_type_member_declaration = new CCodeFragment ();
			source_begin = new CCodeFragment ();
			source_include_directives = new CCodeFragment ();
			source_type_member_declaration = new CCodeFragment ();
			source_type_member_definition = new CCodeFragment ();
			
			if (source_file.comment != null) {
				header_begin.append (new CCodeComment (text = source_file.comment));
			}
		}
		
		public override void visit_end_source_file (SourceFile source_file) {
			var writer = new CCodeWriter (stream = File.open (source_file.get_cheader_filename (), "w"));
			header_begin.write (writer);
			header_type_declaration.write (writer);
			header_type_definition.write (writer);
			header_type_member_declaration.write (writer);
			writer.close ();
			
			writer = new CCodeWriter (stream = File.open (source_file.get_csource_filename (), "w"));
			source_begin.write (writer);
			source_include_directives.write (writer);
			source_type_member_declaration.write (writer);
			source_type_member_definition.write (writer);
			writer.close ();

			header_begin = null;
			header_type_declaration = null;
			header_type_definition = null;
			header_type_member_declaration = null;
			source_begin = null;
			source_include_directives = null;
			source_type_member_declaration = null;
			source_type_member_definition = null;
		}
		
		public override void visit_begin_class (Class cl) {
			instance_struct = new CCodeStruct (name = cl.name);

			if (cl.source_reference.comment != null) {
				header_type_definition.append (new CCodeComment (text = cl.source_reference.comment));
			}
			header_type_definition.append (instance_struct);
		}
		
		public override void visit_field (Field f) {
			instance_struct.add_field (f.type_reference.get_cname (), f.name);
		}
		
		public override void visit_method (Method m) {
		}
	}
}
