/* valaccodebasemodule.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

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
 * 	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using Gee;

/**
 * Code visitor generating C Code.
 */
public class Vala.CCodeBaseModule : CCodeModule {
	public CCodeBaseModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void emit (CodeContext context) {
	}

	public override CCodeIdentifier get_value_setter_function (DataType type_reference) {
		if (type_reference.data_type != null) {
			return new CCodeIdentifier (type_reference.data_type.get_set_value_function ());
		} else {
			return new CCodeIdentifier ("g_value_set_pointer");
		}
	}

	public override CCodeExpression get_construct_property_assignment (CCodeConstant canonical_cconstant, DataType property_type, CCodeExpression value) {
		// this property is used as a construction parameter
		var cpointer = new CCodeIdentifier ("__params_it");
		
		var ccomma = new CCodeCommaExpression ();
		// set name in array for current parameter
		var cnamemember = new CCodeMemberAccess.pointer (cpointer, "name");
		var cnameassign = new CCodeAssignment (cnamemember, canonical_cconstant);
		ccomma.append_expression (cnameassign);
		
		var gvaluearg = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess.pointer (cpointer, "value"));
		
		// initialize GValue in array for current parameter
		var cvalueinit = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
		cvalueinit.add_argument (gvaluearg);
		cvalueinit.add_argument (new CCodeIdentifier (property_type.get_type_id ()));
		ccomma.append_expression (cvalueinit);
		
		// set GValue for current parameter
		var cvalueset = new CCodeFunctionCall (get_value_setter_function (property_type));
		cvalueset.add_argument (gvaluearg);
		cvalueset.add_argument (value);
		ccomma.append_expression (cvalueset);
		
		// move pointer to next parameter in array
		ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, cpointer));

		return ccomma;
	}

	private CCodeIncludeDirective get_internal_include (string filename) {
		return new CCodeIncludeDirective (filename, codegen.context.library == null);
	}

	public virtual void append_vala_array_free () {
	}

	public virtual void append_vala_array_move () {
	}

	private void append_vala_strcmp0 () {
		var fun = new CCodeFunction ("_vala_strcmp0", "int");
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeFormalParameter ("str1", "const char *"));
		fun.add_parameter (new CCodeFormalParameter ("str2", "const char *"));
		codegen.source_type_member_declaration.append (fun.copy ());

		// (str1 != str2)
		var cineq = new CCodeParenthesizedExpression (new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("str1"), new CCodeIdentifier ("str2")));

		fun.block = new CCodeBlock ();

		var cblock = new CCodeBlock ();
		// if (str1 == NULL)
		var cif = new CCodeIfStatement (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("str1"), new CCodeConstant ("NULL")), cblock);
		// return -(str1 != str2);
		cblock.add_statement (new CCodeReturnStatement (new CCodeUnaryExpression (CCodeUnaryOperator.MINUS, cineq)));
		fun.block.add_statement (cif);

		cblock = new CCodeBlock ();
		// if (str2 == NULL)
		cif = new CCodeIfStatement (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("str2"), new CCodeConstant ("NULL")), cblock);
		// return (str1 != str2);
		cblock.add_statement (new CCodeReturnStatement (cineq));
		fun.block.add_statement (cif);

		// strcmp (str1, str2)
		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("strcmp"));
		ccall.add_argument (new CCodeIdentifier ("str1"));
		ccall.add_argument (new CCodeIdentifier ("str2"));
		// return strcmp (str1, str2);
		fun.block.add_statement (new CCodeReturnStatement (ccall));

		codegen.source_type_member_definition.append (fun);
	}

	public override void visit_source_file (SourceFile source_file) {
		codegen.header_begin = new CCodeFragment ();
		codegen.header_type_declaration = new CCodeFragment ();
		codegen.header_type_definition = new CCodeFragment ();
		codegen.header_type_member_declaration = new CCodeFragment ();
		codegen.header_constant_declaration = new CCodeFragment ();
		codegen.source_begin = new CCodeFragment ();
		codegen.source_include_directives = new CCodeFragment ();
		codegen.source_type_declaration = new CCodeFragment ();
		codegen.source_type_definition = new CCodeFragment ();
		codegen.source_type_member_declaration = new CCodeFragment ();
		codegen.source_constant_declaration = new CCodeFragment ();
		codegen.source_type_member_definition = new CCodeFragment ();
		codegen.source_signal_marshaller_definition = new CCodeFragment ();
		codegen.source_signal_marshaller_declaration = new CCodeFragment ();
		
		codegen.user_marshal_set = new HashSet<string> (str_hash, str_equal);
		
		codegen.next_temp_var_id = 0;
		
		codegen.string_h_needed = false;
		codegen.gvaluecollector_h_needed = false;
		codegen.gio_h_needed = false;
		codegen.dbus_glib_h_needed = false;
		codegen.requires_free_checked = false;
		codegen.requires_array_free = false;
		codegen.requires_array_move = false;
		codegen.requires_strcmp0 = false;

		codegen.wrappers = new HashSet<string> (str_hash, str_equal);

		codegen.header_begin.append (new CCodeIncludeDirective ("glib.h"));
		codegen.header_begin.append (new CCodeIncludeDirective ("glib-object.h"));
		if (codegen.context.basedir != null || codegen.context.library != null) {
			codegen.source_include_directives.append (new CCodeIncludeDirective (source_file.get_cinclude_filename ()));
		} else {
			codegen.source_include_directives.append (new CCodeIncludeDirective (source_file.get_cinclude_filename (), true));
		}
		
		Gee.List<string> used_includes = new ArrayList<string> (str_equal);
		used_includes.add ("glib.h");
		used_includes.add ("glib-object.h");
		used_includes.add (source_file.get_cinclude_filename ());
		
		foreach (string filename in source_file.get_header_external_includes ()) {
			if (!used_includes.contains (filename)) {
				codegen.header_begin.append (new CCodeIncludeDirective (filename));
				used_includes.add (filename);
			}
		}
		foreach (string filename in source_file.get_header_internal_includes ()) {
			if (!used_includes.contains (filename)) {
				codegen.header_begin.append (get_internal_include (filename));
				used_includes.add (filename);
			}
		}
		foreach (string filename in source_file.get_source_external_includes ()) {
			if (!used_includes.contains (filename)) {
				codegen.source_include_directives.append (new CCodeIncludeDirective (filename));
				used_includes.add (filename);
			}
		}
		foreach (string filename in source_file.get_source_internal_includes ()) {
			if (!used_includes.contains (filename)) {
				codegen.source_include_directives.append (get_internal_include (filename));
				used_includes.add (filename);
			}
		}
		foreach (Symbol symbol in source_file.get_source_symbol_dependencies ()) {
			if (!symbol.external && symbol.external_package) {
				symbol.accept (codegen);
			}
		}
		if (source_file.is_cycle_head) {
			foreach (SourceFile cycle_file in source_file.cycle.files) {
				foreach (CodeNode node in cycle_file.get_nodes ()) {
					if (node is Struct) {
						var st = (Struct) node;
						codegen.header_type_declaration.append (new CCodeTypeDefinition ("struct _%s".printf (st.get_cname ()), new CCodeVariableDeclarator (st.get_cname ())));
					} else if (node is Class) {
						var cl = (Class) node;
						codegen.header_type_declaration.append (new CCodeTypeDefinition ("struct _%s".printf (cl.get_cname ()), new CCodeVariableDeclarator (cl.get_cname ())));
						codegen.header_type_declaration.append (new CCodeTypeDefinition ("struct _%sClass".printf (cl.get_cname ()), new CCodeVariableDeclarator ("%sClass".printf (cl.get_cname ()))));
					} else if (node is Interface) {
						var iface = (Interface) node;
						codegen.header_type_declaration.append (new CCodeTypeDefinition ("struct _%s".printf (iface.get_cname ()), new CCodeVariableDeclarator (iface.get_cname ())));
						codegen.header_type_declaration.append (new CCodeTypeDefinition ("struct _%s".printf (iface.get_type_cname ()), new CCodeVariableDeclarator (iface.get_type_cname ())));
					}
				}
			}
		}

		source_file.accept_children (codegen);

		if (Report.get_errors () > 0) {
			return;
		}

		var header_define = get_define_for_filename (source_file.get_cinclude_filename ());
		
		/* generate hardcoded "well-known" macros */
		if (codegen.requires_free_checked) {
			codegen.source_begin.append (new CCodeMacroReplacement ("VALA_FREE_CHECKED(o,f)", "((o) == NULL ? NULL : ((o) = (f (o), NULL)))"));
		}
		if (codegen.requires_array_free) {
			append_vala_array_free ();
		}
		if (codegen.requires_array_move) {
			append_vala_array_move ();
		}
		if (codegen.requires_strcmp0) {
			append_vala_strcmp0 ();
		}
		
		if (codegen.string_h_needed) {
			codegen.source_include_directives.append (new CCodeIncludeDirective ("string.h"));
		}

		if (codegen.gvaluecollector_h_needed) {
			codegen.source_include_directives.append (new CCodeIncludeDirective ("gobject/gvaluecollector.h"));
		}

		if (codegen.gio_h_needed) {
			codegen.header_begin.append (new CCodeIncludeDirective ("gio/gio.h"));
		}

		if (codegen.dbus_glib_h_needed) {
			codegen.source_include_directives.append (new CCodeIncludeDirective ("dbus/dbus-glib.h"));
		}

		CCodeComment comment = null;
		if (source_file.comment != null) {
			comment = new CCodeComment (source_file.comment);
		}

		var writer = new CCodeWriter (source_file.get_cheader_filename ());
		if (!writer.open ()) {
			Report.error (null, "unable to open `%s' for writing".printf (writer.filename));
			return;
		}
		if (comment != null) {
			comment.write (writer);
		}
		writer.write_newline ();
		var once = new CCodeOnceSection (header_define);
		once.append (new CCodeNewline ());
		once.append (codegen.header_begin);
		once.append (new CCodeNewline ());
		once.append (new CCodeIdentifier ("G_BEGIN_DECLS"));
		once.append (new CCodeNewline ());
		once.append (new CCodeNewline ());
		once.append (codegen.header_type_declaration);
		once.append (new CCodeNewline ());
		once.append (codegen.header_type_definition);
		once.append (new CCodeNewline ());
		once.append (codegen.header_type_member_declaration);
		once.append (new CCodeNewline ());
		once.append (codegen.header_constant_declaration);
		once.append (new CCodeNewline ());
		once.append (new CCodeIdentifier ("G_END_DECLS"));
		once.append (new CCodeNewline ());
		once.append (new CCodeNewline ());
		once.write (writer);
		writer.close ();
		
		writer = new CCodeWriter (source_file.get_csource_filename ());
		if (!writer.open ()) {
			Report.error (null, "unable to open `%s' for writing".printf (writer.filename));
			return;
		}
		writer.line_directives = codegen.context.debug;
		if (comment != null) {
			comment.write (writer);
		}
		codegen.source_begin.write (writer);
		writer.write_newline ();
		codegen.source_include_directives.write (writer);
		writer.write_newline ();
		codegen.source_type_declaration.write_combined (writer);
		writer.write_newline ();
		codegen.source_type_definition.write_combined (writer);
		writer.write_newline ();
		codegen.source_type_member_declaration.write_declaration (writer);
		writer.write_newline ();
		codegen.source_type_member_declaration.write (writer);
		writer.write_newline ();
		codegen.source_constant_declaration.write (writer);
		writer.write_newline ();
		codegen.source_signal_marshaller_declaration.write_declaration (writer);
		codegen.source_signal_marshaller_declaration.write (writer);
		writer.write_newline ();
		codegen.source_type_member_definition.write (writer);
		writer.write_newline ();
		codegen.source_signal_marshaller_definition.write (writer);
		writer.write_newline ();
		writer.close ();

		codegen.header_begin = null;
		codegen.header_type_declaration = null;
		codegen.header_type_definition = null;
		codegen.header_type_member_declaration = null;
		codegen.header_constant_declaration = null;
		codegen.source_begin = null;
		codegen.source_include_directives = null;
		codegen.source_type_declaration = null;
		codegen.source_type_definition = null;
		codegen.source_type_member_declaration = null;
		codegen.source_constant_declaration = null;
		codegen.source_type_member_definition = null;
		codegen.source_signal_marshaller_definition = null;
		codegen.source_signal_marshaller_declaration = null;
	}
	
	private static string get_define_for_filename (string filename) {
		var define = new StringBuilder ("__");
		
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
