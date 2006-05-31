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
		Symbol current_symbol;

		CCodeFragment header_begin;
		CCodeFragment header_type_declaration;
		CCodeFragment header_type_definition;
		CCodeFragment header_type_member_declaration;
		CCodeFragment source_begin;
		CCodeFragment source_include_directives;
		CCodeFragment source_type_member_declaration;
		CCodeFragment source_type_member_definition;
		
		CCodeStruct instance_struct;
		CCodeStruct type_struct;
		CCodeStruct instance_priv_struct;
		CCodeEnum prop_enum;
		CCodeEnum cenum;
		CCodeFunction function;
		CCodeBlock block;

		public void emit (CodeContext context) {
			context.find_header_cycles ();
		
			/* we're only interested in non-pkg source files */
			foreach (SourceFile file in context.get_source_files ()) {
				if (!file.pkg) {
					file.accept (this);
				}
			}
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
			
			header_begin.append (new CCodeIncludeDirective (filename = "glib.h"));
			source_include_directives.append (new CCodeIncludeDirective (filename = source_file.get_cheader_filename ()));
			
			List<string> used_includes = null;
			used_includes.append ("glib.h");
			used_includes.append (source_file.get_cheader_filename ());
			
			foreach (string filename1 in source_file.header_external_includes) {
				if (used_includes.find_custom (filename1, strcmp) == null) {
					header_begin.append (new CCodeIncludeDirective (filename = filename1));
					used_includes.append (filename1);
				}
			}
			foreach (string filename2 in source_file.header_internal_includes) {
				if (used_includes.find_custom (filename2, strcmp) == null) {
					header_begin.append (new CCodeIncludeDirective (filename = filename2));
					used_includes.append (filename2);
				}
			}
			foreach (string filename3 in source_file.source_includes) {
				if (used_includes.find_custom (filename3, strcmp) == null) {
					source_include_directives.append (new CCodeIncludeDirective (filename = filename3));
					used_includes.append (filename3);
				}
			}
			if (source_file.is_cycle_head) {
				foreach (SourceFile cycle_file in source_file.cycle.files) {
					foreach (Namespace ns in cycle_file.get_namespaces ()) {
						foreach (Struct st in ns.get_structs ()) {
							header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct _%s".printf (st.get_cname ()), typedef_name = st.get_cname ()));
						}
						foreach (Class cl in ns.get_classes ()) {
							header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct _%s".printf (cl.get_cname ()), typedef_name = cl.get_cname ()));
							header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct _%sClass".printf (cl.get_cname ()), typedef_name = "%sClass".printf (cl.get_cname ())));
						}
					}
				}
			}
		}
		
		private static ref string get_define_for_filename (string filename) {
			var define = String.new ("__");
			
			var i = filename;
			while (i.len (-1) > 0) {
				var c = i.get_char ();
				/* FIXME: remove explicit cast when implicit cast works */
				if (c.isalnum  () && c < (unichar) 128) {
					define.append_unichar (c.toupper ());
				} else {
					define.append_c ('_');
				}
			
				i = i.next_char ();
			}
			
			define.append ("__");
			
			return define.str;
		}
		
		public override void visit_end_source_file (SourceFile source_file) {
			var header_define = get_define_for_filename (source_file.get_cheader_filename ());
			
			CCodeComment comment = null;
			if (source_file.comment != null) {
				comment = new CCodeComment (text = source_file.comment);
			}

			var writer = new CCodeWriter (filename = source_file.get_cheader_filename ());
			if (comment != null) {
				comment.write (writer);
			}
			writer.write_newline ();
			var once = new CCodeOnceSection (define = header_define);
			once.append (new CCodeNewline ());
			once.append (header_begin);
			once.append (new CCodeNewline ());
			once.append (new CCodeIdentifier (name = "G_BEGIN_DECLS"));
			once.append (new CCodeNewline ());
			once.append (new CCodeNewline ());
			once.append (header_type_declaration);
			once.append (new CCodeNewline ());
			once.append (header_type_definition);
			once.append (new CCodeNewline ());
			once.append (header_type_member_declaration);
			once.append (new CCodeNewline ());
			once.append (new CCodeIdentifier (name = "G_END_DECLS"));
			once.append (new CCodeNewline ());
			once.append (new CCodeNewline ());
			once.write (writer);
			writer.close ();
			
			writer = new CCodeWriter (filename = source_file.get_csource_filename ());
			if (comment != null) {
				comment.write (writer);
			}
			source_begin.write (writer);
			writer.write_newline ();
			source_include_directives.write (writer);
			writer.write_newline ();
			source_type_member_declaration.write (writer);
			writer.write_newline ();
			source_type_member_definition.write (writer);
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
		}

		public override void visit_begin_class (Class cl) {
			current_symbol = cl.symbol;

			instance_struct = new CCodeStruct (name = "_%s".printf (cl.get_cname ()));
			type_struct = new CCodeStruct (name = "_%sClass".printf (cl.get_cname ()));
			instance_priv_struct = new CCodeStruct (name = "_%sPrivate".printf (cl.get_cname ()));
			prop_enum = new CCodeEnum ();
			prop_enum.add_value ("%s_DUMMY_PROPERTY".printf (cl.get_upper_case_cname (null)), null);
			
			
			header_type_declaration.append (new CCodeNewline ());
			var macro = "(%s_get_type ())".printf (cl.get_lower_case_cname (null));
			header_type_declaration.append (new CCodeMacroReplacement (name = cl.get_upper_case_cname ("TYPE_"), replacement = macro));

			macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (cl.get_upper_case_cname ("TYPE_"), cl.get_cname ());
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s(obj)".printf (cl.get_upper_case_cname (null)), replacement = macro));

			macro = "(G_TYPE_CHECK_CLASS_CAST ((klass), %s, %sClass))".printf (cl.get_upper_case_cname ("TYPE_"), cl.get_cname ());
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s_CLASS(klass)".printf (cl.get_upper_case_cname (null)), replacement = macro));

			macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (cl.get_upper_case_cname ("TYPE_"));
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s(obj)".printf (cl.get_upper_case_cname ("IS_")), replacement = macro));

			macro = "(G_TYPE_CHECK_CLASS_TYPE ((klass), %s))".printf (cl.get_upper_case_cname ("TYPE_"));
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s_CLASS(klass)".printf (cl.get_upper_case_cname ("IS_")), replacement = macro));

			macro = "(G_TYPE_INSTANCE_GET_CLASS ((obj), %s, %sClass))".printf (cl.get_upper_case_cname ("TYPE_"), cl.get_cname ());
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s_GET_CLASS(obj)".printf (cl.get_upper_case_cname (null)), replacement = macro));
			header_type_declaration.append (new CCodeNewline ());


			if (cl.source_reference.file.cycle == null) {
				header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct %s".printf (instance_struct.name), typedef_name = cl.get_cname ()));
				header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct %s".printf (type_struct.name), typedef_name = "%sClass".printf (cl.get_cname ())));
			}
			header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct %s".printf (instance_priv_struct.name), typedef_name = "%sPrivate".printf (cl.get_cname ())));
			
			instance_struct.add_field (cl.base_class.get_cname (), "parent");
			instance_struct.add_field ("%sPrivate *".printf (cl.get_cname ()), "priv");
			type_struct.add_field ("%sClass".printf (cl.base_class.get_cname ()), "parent");

			if (cl.source_reference.comment != null) {
				header_type_definition.append (new CCodeComment (text = cl.source_reference.comment));
			}
			header_type_definition.append (instance_struct);
			header_type_definition.append (type_struct);
			source_type_member_declaration.append (instance_priv_struct);
			macro = "(G_TYPE_INSTANCE_GET_PRIVATE ((o), %s, %sPrivate))".printf (cl.get_upper_case_cname ("TYPE_"), cl.get_cname ());
			source_type_member_declaration.append (new CCodeMacroReplacement (name = "%s_GET_PRIVATE(o)".printf (cl.get_upper_case_cname (null)), replacement = macro));
			source_type_member_declaration.append (prop_enum);
		}
		
		public override void visit_end_class (Class cl) {
			add_get_property_function (cl);
			add_set_property_function (cl);
			add_class_init_function (cl);
			add_instance_init_function (cl);
			add_type_register_function (cl);			
		}
		
		private void add_type_register_function (Class cl) {
			var type_fun = new CCodeFunction (name = "%s_get_type".printf (cl.get_lower_case_cname (null)), return_type = "GType");
			header_type_member_declaration.append (type_fun.copy ());
			
			var type_block = new CCodeBlock ();
			var cdecl = new CCodeDeclaration (type_name = "GType");
			cdecl.add_declarator (new CCodeVariableDeclarator (name = "g_define_type_id", initializer = new CCodeConstant (name = "0")));
			cdecl.modifiers = CCodeModifiers.STATIC;
			type_block.add_statement (cdecl);
			
			var cond = new CCodeFunctionCall (call = new CCodeIdentifier (name = "G_UNLIKELY"));
			cond.add_argument (new CCodeBinaryExpression (operator = CCodeBinaryOperator.EQUALITY, left = new CCodeIdentifier (name = "g_define_type_id"), right = new CCodeConstant (name = "0")));
			var type_init = new CCodeBlock ();
			var ctypedecl = new CCodeDeclaration (type_name = "const GTypeInfo");
			ctypedecl.modifiers = CCodeModifiers.STATIC;
			ctypedecl.add_declarator (new CCodeVariableDeclarator (name = "g_define_type_info", initializer = new CCodeConstant (name = "{ sizeof (%sClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) %s_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (%s), 0, (GInstanceInitFunc) %s_init }".printf (cl.get_cname (), cl.get_lower_case_cname (null), cl.get_cname (), cl.get_lower_case_cname (null)))));
			type_init.add_statement (ctypedecl);
			var reg_call = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_type_register_static"));
			reg_call.add_argument (new CCodeIdentifier (name = cl.base_class.get_upper_case_cname ("TYPE_")));
			reg_call.add_argument (new CCodeConstant (name = "\"%s\"".printf (cl.get_cname ())));
			reg_call.add_argument (new CCodeIdentifier (name = "&g_define_type_info"));
			reg_call.add_argument (new CCodeConstant (name = "0"));
			type_init.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeIdentifier (name = "g_define_type_id"), right = reg_call)));
			var cif = new CCodeIfStatement (condition = cond, true_statement = type_init);
			type_block.add_statement (cif);
			type_block.add_statement (new CCodeReturnStatement (return_expression = new CCodeIdentifier (name = "g_define_type_id")));
			
			type_fun.block = type_block;
			source_type_member_definition.append (type_fun);
		}
		
		private void add_class_init_function (Class cl) {
			var class_init = new CCodeFunction (name = "%s_class_init".printf (cl.get_lower_case_cname (null)), return_type = "void");
			class_init.add_parameter (new CCodeFormalParameter (type_name = "%sClass *".printf (cl.get_cname ()), name = "klass"));
			class_init.modifiers = CCodeModifiers.STATIC;
			
			var init_block = new CCodeBlock ();
			class_init.block = init_block;
			
			ref CCodeFunctionCall ccall;
			
			if (cl.has_private_fields) {
				ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_type_class_add_private"));
				ccall.add_argument (new CCodeIdentifier (name = "klass"));
				ccall.add_argument (new CCodeConstant (name = "sizeof (%sPrivate)".printf (cl.get_cname ())));
				init_block.add_statement (new CCodeExpressionStatement (expression = ccall));
			}
			
			ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "G_OBJECT_CLASS"));
			ccall.add_argument (new CCodeIdentifier (name = "klass"));
			init_block.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeMemberAccess (inner = ccall, member_name = "get_property", is_pointer = true), right = new CCodeIdentifier (name = "%s_get_property".printf (cl.get_lower_case_cname (null))))));
			init_block.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeMemberAccess (inner = ccall, member_name = "set_property", is_pointer = true), right = new CCodeIdentifier (name = "%s_set_property".printf (cl.get_lower_case_cname (null))))));
			
			foreach (Method m in cl.get_methods ()) {
				if (m.is_virtual || m.is_override) {
					var ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_CLASS".printf (((Class) m.base_method.symbol.parent_symbol.node).get_upper_case_cname (null))));
					ccast.add_argument (new CCodeIdentifier (name = "klass"));
					init_block.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeMemberAccess (inner = ccast, member_name = m.name, is_pointer = true), right = new CCodeIdentifier (name = m.get_real_cname ()))));
				}
			}
			
			foreach (Property prop in cl.get_properties ()) {
				var cinst = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_object_class_install_property"));
				cinst.add_argument (ccall);
				cinst.add_argument (new CCodeConstant (name = prop.get_upper_case_cname ()));
				var cspec = new CCodeFunctionCall ();
				cspec.add_argument (new CCodeConstant (name = "\"%s\"".printf (prop.name)));
				cspec.add_argument (new CCodeConstant (name = "\"foo\""));
				cspec.add_argument (new CCodeConstant (name = "\"bar\""));
				if (prop.type_reference.type is Class) {
					cspec.call = new CCodeIdentifier (name = "g_param_spec_object");
					cspec.add_argument (new CCodeIdentifier (name = prop.type_reference.type.get_upper_case_cname ("TYPE_")));
				} else if (prop.type_reference.type_name == "string") {
					cspec.call = new CCodeIdentifier (name = "g_param_spec_string");
					cspec.add_argument (new CCodeConstant (name = "NULL"));
				} else if (prop.type_reference.type_name == "int"
					   || prop.type_reference.type is Enum) {
					cspec.call = new CCodeIdentifier (name = "g_param_spec_int");
					cspec.add_argument (new CCodeConstant (name = "G_MININT"));
					cspec.add_argument (new CCodeConstant (name = "G_MAXINT"));
					cspec.add_argument (new CCodeConstant (name = "0"));
				} else if (prop.type_reference.type_name == "bool") {
					cspec.call = new CCodeIdentifier (name = "g_param_spec_boolean");
					cspec.add_argument (new CCodeConstant (name = "FALSE"));
				} else {
					cspec.call = new CCodeIdentifier (name = "g_param_spec_pointer");
				}
				cspec.add_argument (new CCodeConstant (name = "G_PARAM_CONSTRUCT | G_PARAM_READWRITE"));
				cinst.add_argument (cspec);
				
				init_block.add_statement (new CCodeExpressionStatement (expression = cinst));
			}
			
			source_type_member_definition.append (class_init);
		}
		
		private void add_instance_init_function (Class cl) {
			var instance_init = new CCodeFunction (name = "%s_init".printf (cl.get_lower_case_cname (null)), return_type = "void");
			instance_init.add_parameter (new CCodeFormalParameter (type_name = "%s *".printf (cl.get_cname ()), name = "self"));
			instance_init.modifiers = CCodeModifiers.STATIC;
			
			var init_block = new CCodeBlock ();
			instance_init.block = init_block;
			
			if (cl.has_private_fields) {
				var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_GET_PRIVATE".printf (cl.get_upper_case_cname (null))));
				ccall.add_argument (new CCodeIdentifier (name = "self"));
				init_block.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeMemberAccess (inner = new CCodeIdentifier (name = "self"), member_name = "priv", is_pointer = true), right = ccall)));
			}
			
			foreach (Field f in cl.get_fields ()) {
				if (f.initializer != null) {
					ref CCodeExpression lhs = null;
					if (f.instance) {
						if (f.access == MemberAccessibility.PRIVATE) {
							lhs = new CCodeMemberAccess (inner = new CCodeMemberAccess (inner = new CCodeIdentifier (name = "self"), member_name = "priv", is_pointer = true), member_name = f.get_cname (), is_pointer = true);
						} else {
							lhs = new CCodeMemberAccess (inner = new CCodeIdentifier (name = "self"), member_name = f.get_cname (), is_pointer = true);
						}
					} /* else {
						lhs = new CCodeIdentifier (name = "%s_%s".printf (cl.get_lower_case_cname (null), f.get_cname ()));
					} */
					if (lhs != null)  {
						init_block.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = lhs, right = f.initializer.ccodenode)));
					}
				}
			}
			
			var init_sym = cl.symbol.lookup ("init");
			if (init_sym != null) {
				var init_fun = (Method) init_sym.node;
				init_block.add_statement (init_fun.body.ccodenode);
			}
			
			source_type_member_definition.append (instance_init);
		}
		
		private void add_get_property_function (Class cl) {
			var get_prop = new CCodeFunction (name = "%s_get_property".printf (cl.get_lower_case_cname (null)), return_type = "void");
			get_prop.add_parameter (new CCodeFormalParameter (type_name = "GObject *", name = "object"));
			get_prop.add_parameter (new CCodeFormalParameter (type_name = "guint", name = "property_id"));
			get_prop.add_parameter (new CCodeFormalParameter (type_name = "GValue *", name = "value"));
			get_prop.add_parameter (new CCodeFormalParameter (type_name = "GParamSpec *", name = "pspec"));
			
			var block = new CCodeBlock ();
			
			var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = cl.get_upper_case_cname (null)));
			ccall.add_argument (new CCodeIdentifier (name = "object"));
			var cdecl = new CCodeDeclaration (type_name = "%s *".printf (cl.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator (name = "self", initializer = ccall));
			block.add_statement (cdecl);
			
			var cswitch = new CCodeSwitchStatement (expression = new CCodeIdentifier (name = "property_id"));
			foreach (Property prop in cl.get_properties ()) {
				var ccase = new CCodeCaseStatement (expression = new CCodeIdentifier (name = prop.get_upper_case_cname ()));
				var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_get_%s".printf (cl.get_lower_case_cname (null), prop.name)));
				ccall.add_argument (new CCodeIdentifier (name = "self"));
				var csetcall = new CCodeFunctionCall ();
				if (prop.type_reference.type is Class) {
					csetcall.call = new CCodeIdentifier (name = "g_value_set_object");
				} else if (prop.type_reference.type_name == "string") {
					csetcall.call = new CCodeIdentifier (name = "g_value_set_string");
				} else if (prop.type_reference.type_name == "int"
					   || prop.type_reference.type is Enum) {
					csetcall.call = new CCodeIdentifier (name = "g_value_set_int");
				} else if (prop.type_reference.type_name == "bool") {
					csetcall.call = new CCodeIdentifier (name = "g_value_set_boolean");
				} else {
					csetcall.call = new CCodeIdentifier (name = "g_value_set_pointer");
				}
				csetcall.add_argument (new CCodeIdentifier (name = "value"));
				csetcall.add_argument (ccall);
				ccase.add_statement (new CCodeExpressionStatement (expression = csetcall));
				ccase.add_statement (new CCodeBreakStatement ());
				cswitch.add_case (ccase);
			}
			block.add_statement (cswitch);

			get_prop.block = block;
			
			source_type_member_definition.append (get_prop);
		}
		
		private void add_set_property_function (Class cl) {
			var set_prop = new CCodeFunction (name = "%s_set_property".printf (cl.get_lower_case_cname (null)), return_type = "void");
			set_prop.add_parameter (new CCodeFormalParameter (type_name = "GObject *", name = "object"));
			set_prop.add_parameter (new CCodeFormalParameter (type_name = "guint", name = "property_id"));
			set_prop.add_parameter (new CCodeFormalParameter (type_name = "const GValue *", name = "value"));
			set_prop.add_parameter (new CCodeFormalParameter (type_name = "GParamSpec *", name = "pspec"));
			
			var block = new CCodeBlock ();
			
			var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = cl.get_upper_case_cname (null)));
			ccall.add_argument (new CCodeIdentifier (name = "object"));
			var cdecl = new CCodeDeclaration (type_name = "%s *".printf (cl.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator (name = "self", initializer = ccall));
			block.add_statement (cdecl);
			
			var cswitch = new CCodeSwitchStatement (expression = new CCodeIdentifier (name = "property_id"));
			foreach (Property prop in cl.get_properties ()) {
				var ccase = new CCodeCaseStatement (expression = new CCodeIdentifier (name = prop.get_upper_case_cname ()));
				var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_set_%s".printf (cl.get_lower_case_cname (null), prop.name)));
				ccall.add_argument (new CCodeIdentifier (name = "self"));
				var cgetcall = new CCodeFunctionCall ();
				if (prop.type_reference.type is Class) {
					cgetcall.call = new CCodeIdentifier (name = "g_value_get_object");
				} else if (prop.type_reference.type_name == "string") {
					cgetcall.call = new CCodeIdentifier (name = "g_value_dup_string");
				} else if (prop.type_reference.type_name == "int"
					  || prop.type_reference.type is Enum) {
					cgetcall.call = new CCodeIdentifier (name = "g_value_get_int");
				} else if (prop.type_reference.type_name == "bool") {
					cgetcall.call = new CCodeIdentifier (name = "g_value_get_boolean");
				} else {
					cgetcall.call = new CCodeIdentifier (name = "g_value_get_pointer");
				}
				cgetcall.add_argument (new CCodeIdentifier (name = "value"));
				ccall.add_argument (cgetcall);
				ccase.add_statement (new CCodeExpressionStatement (expression = ccall));
				ccase.add_statement (new CCodeBreakStatement ());
				cswitch.add_case (ccase);
			}
			block.add_statement (cswitch);
			
			set_prop.block = block;
			
			source_type_member_definition.append (set_prop);
		}
		
		public override void visit_begin_struct (Struct st) {
			instance_struct = new CCodeStruct (name = "_%s".printf (st.name));

			if (st.source_reference.comment != null) {
				header_type_definition.append (new CCodeComment (text = st.source_reference.comment));
			}
			header_type_definition.append (instance_struct);
		}

		public override void visit_begin_interface (Interface iface) {
			current_symbol = iface.symbol;

			type_struct = new CCodeStruct (name = "_%sInterface".printf (iface.get_cname ()));
			
			header_type_declaration.append (new CCodeNewline ());
			var macro = "(%s_get_type ())".printf (iface.get_lower_case_cname (null));
			header_type_declaration.append (new CCodeMacroReplacement (name = iface.get_upper_case_cname ("TYPE_"), replacement = macro));

			macro = "(G_TYPE_CHECK_INSTANCE_CAST ((obj), %s, %s))".printf (iface.get_upper_case_cname ("TYPE_"), iface.get_cname ());
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s(obj)".printf (iface.get_upper_case_cname (null)), replacement = macro));

			macro = "(G_TYPE_CHECK_INSTANCE_TYPE ((obj), %s))".printf (iface.get_upper_case_cname ("TYPE_"));
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s(obj)".printf (iface.get_upper_case_cname ("IS_")), replacement = macro));

			macro = "(G_TYPE_INSTANCE_GET_INTERFACE ((obj), %s, %sInterface))".printf (iface.get_upper_case_cname ("TYPE_"), iface.get_cname ());
			header_type_declaration.append (new CCodeMacroReplacement (name = "%s_GET_INTERFACE(obj)".printf (iface.get_upper_case_cname (null)), replacement = macro));
			header_type_declaration.append (new CCodeNewline ());


			if (iface.source_reference.file.cycle == null) {
				header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct _%s".printf (iface.get_cname ()), typedef_name = iface.get_cname ()));
				header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct %s".printf (type_struct.name), typedef_name = "%sInterface".printf (iface.get_cname ())));
			}
			
			type_struct.add_field ("GTypeInterface", "parent");

			if (iface.source_reference.comment != null) {
				header_type_definition.append (new CCodeComment (text = iface.source_reference.comment));
			}
			header_type_definition.append (type_struct);
		}

		public override void visit_end_interface (Interface iface) {
		}
		
		public override void visit_begin_enum (Enum en) {
			cenum = new CCodeEnum (name = en.get_cname ());

			if (en.source_reference.comment != null) {
				header_type_definition.append (new CCodeComment (text = en.source_reference.comment));
			}
			header_type_definition.append (cenum);
		}

		public override void visit_enum_value (EnumValue ev) {
			cenum.add_value (ev.get_cname (), null);
		}

		public override void visit_constant (Constant c) {
			if (c.symbol.parent_symbol.node is Type_) {
				var t = (Type_) c.symbol.parent_symbol.node;
				var cdecl = new CCodeDeclaration (type_name = c.type_reference.get_const_cname ());
				var arr = "";
				if (c.type_reference.array) {
					arr = "[]";
				}
				cdecl.add_declarator (new CCodeVariableDeclarator (name = "%s_%s%s".printf (t.get_lower_case_cname (null), c.name, arr), initializer = c.initializer.ccodenode));
				cdecl.modifiers = CCodeModifiers.STATIC;
				source_type_member_declaration.append (cdecl);
			}
		}
		
		public override void visit_field (Field f) {
			if (f.access == MemberAccessibility.PUBLIC) {
				instance_struct.add_field (f.type_reference.get_cname (), f.get_cname ());
			} else if (f.access == MemberAccessibility.PRIVATE) {
				if (f.instance) {
					instance_priv_struct.add_field (f.type_reference.get_cname (), f.get_cname ());
				} else {
					if (f.symbol.parent_symbol.node is Type_) {
						var t = (Type_) f.symbol.parent_symbol.node;
						var cdecl = new CCodeDeclaration (type_name = f.type_reference.get_cname ());
						cdecl.add_declarator (new CCodeVariableDeclarator (name = "%s_%s".printf (t.get_lower_case_cname (null), f.get_cname ())));
						cdecl.modifiers = CCodeModifiers.STATIC;
						source_type_member_declaration.append (cdecl);
					}
				}
			}
		}
		
		public override void visit_end_method (Method m) {
			if (m.name == "init") {
				
				return;
			}
		
			function = new CCodeFunction (name = m.get_real_cname (), return_type = m.return_type.get_cname ());
			CCodeFunctionDeclarator vdeclarator = null;
			
			if (m.instance) {
				var this_type = new TypeReference ();
				this_type.type = (Type_) m.symbol.parent_symbol.node;
				if (!m.is_override) {
					var cparam = new CCodeFormalParameter (type_name = this_type.get_cname (), name = "self");
					function.add_parameter (cparam);
				} else {
					var base_type = new TypeReference ();
					base_type.type = (Class) m.base_method.symbol.parent_symbol.node;
					var cparam = new CCodeFormalParameter (type_name = base_type.get_cname (), name = "base");
					function.add_parameter (cparam);
				}
				if (m.is_abstract || m.is_virtual) {
					var vdecl = new CCodeDeclaration (type_name = m.return_type.get_cname ());
					vdeclarator = new CCodeFunctionDeclarator (name = m.name);
					vdecl.add_declarator (vdeclarator);
					type_struct.add_declaration (vdecl);

					var cparam = new CCodeFormalParameter (type_name = this_type.get_cname (), name = "self");
					vdeclarator.add_parameter (cparam);
				}
			}
			
			foreach (FormalParameter param in m.get_parameters ()) {
				function.add_parameter ((CCodeFormalParameter) param.ccodenode);
				if (vdeclarator != null) {
					vdeclarator.add_parameter ((CCodeFormalParameter) param.ccodenode);
				}
			}
			
			if (!m.is_abstract) {
				if (m.access == MemberAccessibility.PUBLIC && !(m.is_virtual || m.is_override)) {
					header_type_member_declaration.append (function.copy ());
				} else {
					function.modifiers |= CCodeModifiers.STATIC;
					source_type_member_declaration.append (function.copy ());
				}
				
				if (m.body != null) {
					if (m.is_override) {
						var cl = (Class) m.symbol.parent_symbol.node;

						var cblock = new CCodeBlock ();
						
						var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = cl.get_upper_case_cname (null)));
						ccall.add_argument (new CCodeIdentifier (name = "base"));
						
						var cdecl = new CCodeDeclaration (type_name = "%s *".printf (cl.get_cname ()));
						cdecl.add_declarator (new CCodeVariableDeclarator (name = "self", initializer = ccall));
						
						cblock.add_statement (cdecl);
						cblock.add_statement (m.body.ccodenode);
						function.block = cblock;
					} else {
						function.block = m.body.ccodenode;
					}
				} else if (m.is_abstract) {
					function.block = new CCodeBlock ();
				}

				if (m.source_reference.comment != null) {
					source_type_member_definition.append (new CCodeComment (text = m.source_reference.comment));
				}
				source_type_member_definition.append (function);
			}
			
			if (m.is_abstract || m.is_virtual) {
				var cl = (Class) m.symbol.parent_symbol.node;

				var vfunc = new CCodeFunction (name = m.get_cname (), return_type = m.return_type.get_cname ());

				var this_type = new TypeReference ();
				this_type.type = (Type_) m.symbol.parent_symbol.node;

				var cparam = new CCodeFormalParameter (type_name = this_type.get_cname (), name = "self");
				vfunc.add_parameter (cparam);
				
				var vblock = new CCodeBlock ();
				
				var vcast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_GET_CLASS".printf (cl.get_upper_case_cname (null))));
				vcast.add_argument (new CCodeIdentifier (name = "self"));
			
				var vcall = new CCodeFunctionCall (call = new CCodeMemberAccess (inner = vcast, member_name = m.name, is_pointer = true));
				vcall.add_argument (new CCodeIdentifier (name = "self"));
			
				foreach (FormalParameter param in m.get_parameters ()) {
					vfunc.add_parameter ((CCodeFormalParameter) param.ccodenode);
					vcall.add_argument (new CCodeIdentifier (name = param.name));
				}

				vblock.add_statement (new CCodeExpressionStatement (expression = vcall));

				header_type_member_declaration.append (vfunc.copy ());
				
				vfunc.block = vblock;
				
				source_type_member_definition.append (vfunc);
			}
			
			if (m.name == "main") {
				var cmain = new CCodeFunction (name = "main", return_type = "int");
				cmain.add_parameter (new CCodeFormalParameter (type_name = "int", name = "argc"));
				cmain.add_parameter (new CCodeFormalParameter (type_name = "char **", name = "argv"));
				var main_block = new CCodeBlock ();
				main_block.add_statement (new CCodeExpressionStatement (expression = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_type_init"))));
				var main_call = new CCodeFunctionCall (call = new CCodeIdentifier (name = function.name));
				main_call.add_argument (new CCodeIdentifier (name = "argc"));
				main_call.add_argument (new CCodeIdentifier (name = "argv"));
				main_block.add_statement (new CCodeReturnStatement (return_expression = main_call));
				cmain.block = main_block;
				source_type_member_definition.append (cmain);
			}
		}
		
		public override void visit_formal_parameter (FormalParameter p) {
			if (!p.ellipsis) {
				p.ccodenode = new CCodeFormalParameter (type_name = p.type_reference.get_cname (), name = p.name);
			}
		}

		public override void visit_end_property (Property prop) {
			prop_enum.add_value (prop.get_upper_case_cname (), null);
		}

		public override void visit_end_property_accessor (PropertyAccessor acc) {
			var prop = (Property) acc.symbol.parent_symbol.node;
			var cl = (Class) prop.symbol.parent_symbol.node;
			
			if (acc.readable) {
				function = new CCodeFunction (name = "%s_get_%s".printf (cl.get_lower_case_cname (null), prop.name), return_type = prop.type_reference.get_cname ());
			} else {
				function = new CCodeFunction (name = "%s_set_%s".printf (cl.get_lower_case_cname (null), prop.name), return_type = "void");
			}
			var this_type = new TypeReference ();
			this_type.type = cl;
			var cparam = new CCodeFormalParameter (type_name = this_type.get_cname (), name = "self");
			function.add_parameter (cparam);
			if (acc.writable || acc.construct_) {
				function.add_parameter (new CCodeFormalParameter (type_name = prop.type_reference.get_cname (), name = "value"));
			}
			
			header_type_member_declaration.append (function.copy ());
			
			if (acc.body != null) {
				function.block = acc.body.ccodenode;
			}
			
			source_type_member_definition.append (function);
		}

		public override void visit_end_block (Block b) {
			var cblock = new CCodeBlock ();
			
			foreach (Statement stmt in b.statement_list) {
				var src = stmt.source_reference;
				if (src != null && src.comment != null) {
					cblock.add_statement (new CCodeComment (text = src.comment));
				}
				
				if (stmt.ccodenode is CCodeFragment) {
					foreach (CCodeStatement cstmt in ((CCodeFragment) stmt.ccodenode).children) {
						cblock.add_statement (cstmt);
					}
				} else {
					cblock.add_statement ((CCodeStatement) stmt.ccodenode);
				}
			}
			
			b.ccodenode = cblock;
		}

		public override void visit_empty_statement (EmptyStatement stmt) {
			stmt.ccodenode = new CCodeEmptyStatement ();
		}

		public override void visit_declaration_statement (DeclarationStatement stmt) {
			/* split declaration statement as var declarators might have different types */
		
			var cfrag = new CCodeFragment ();
			
			foreach (VariableDeclarator decl in stmt.declaration.variable_declarators) {
				var cdecl = new CCodeDeclaration (type_name = decl.type_reference.get_cname ());
			
				cdecl.add_declarator ((CCodeVariableDeclarator) decl.ccodenode);

				cfrag.append (cdecl);
			}
			
			stmt.ccodenode = cfrag;
		}

		public override void visit_variable_declarator (VariableDeclarator decl) {
			if (decl.initializer != null) {
				decl.ccodenode = new CCodeVariableDeclarator (name = decl.name, initializer = decl.initializer.ccodenode);
			} else {
				decl.ccodenode = new CCodeVariableDeclarator (name = decl.name);
			}
		}

		public override void visit_initializer_list (InitializerList list) {
			var clist = new CCodeInitializerList ();
			foreach (Expression expr in list.initializers) {
				clist.append (expr.ccodenode);
			}
			list.ccodenode = clist;
		}

		public override void visit_expression_statement (ExpressionStatement stmt) {
			stmt.ccodenode = new CCodeExpressionStatement (expression = (CCodeExpression) stmt.expression.ccodenode);
		}

		public override void visit_if_statement (IfStatement stmt) {
			if (stmt.false_statement != null) {
				stmt.ccodenode = new CCodeIfStatement (condition = (CCodeExpression) stmt.condition.ccodenode, true_statement = (CCodeStatement) stmt.true_statement.ccodenode, false_statement = (CCodeStatement) stmt.false_statement.ccodenode);
			} else {
				stmt.ccodenode = new CCodeIfStatement (condition = (CCodeExpression) stmt.condition.ccodenode, true_statement = (CCodeStatement) stmt.true_statement.ccodenode);
			}
		}

		public override void visit_while_statement (WhileStatement stmt) {
			stmt.ccodenode = new CCodeWhileStatement (condition = (CCodeExpression) stmt.condition.ccodenode, body = (CCodeStatement) stmt.body.ccodenode);
		}

		public override void visit_for_statement (ForStatement stmt) {
			var cfor = new CCodeForStatement (condition = (CCodeExpression) stmt.condition.ccodenode, body = (CCodeStatement) stmt.body.ccodenode);
			
			foreach (Expression init_expr in stmt.initializer) {
				cfor.add_initializer ((CCodeExpression) init_expr.ccodenode);
			}
			
			foreach (Expression it_expr in stmt.iterator) {
				cfor.add_iterator ((CCodeExpression) it_expr.ccodenode);
			}
			
			stmt.ccodenode = cfor;
		}

		public override void visit_end_foreach_statement (ForeachStatement stmt) {
			var cblock = new CCodeBlock ();
			
			if (stmt.collection.static_type.array) {
				var it_name = "%s_it".printf (stmt.variable_name);
			
				var citdecl = new CCodeDeclaration (type_name = stmt.collection.static_type.get_cname ());
				citdecl.add_declarator (new CCodeVariableDeclarator (name = it_name));
				cblock.add_statement (citdecl);
				
				var cbody = new CCodeBlock ();
				
				var cdecl = new CCodeDeclaration (type_name = stmt.type_reference.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator (name = stmt.variable_name, initializer = new CCodeIdentifier (name = "*%s".printf (it_name))));
				cbody.add_statement (cdecl);
				
				cbody.add_statement (stmt.body.ccodenode);
				
				var ccond = new CCodeBinaryExpression (operator = CCodeBinaryOperator.INEQUALITY, left = new CCodeIdentifier (name = "*%s".printf (it_name)), right = new CCodeConstant (name = "NULL"));
				
				var cfor = new CCodeForStatement (condition = ccond, body = cbody);
				cfor.add_initializer (new CCodeAssignment (left = new CCodeIdentifier (name = it_name), right = (CCodeExpression) stmt.collection.ccodenode));
				cfor.add_iterator (new CCodeAssignment (left = new CCodeIdentifier (name = it_name), right = new CCodeBinaryExpression (operator = CCodeBinaryOperator.PLUS, left = new CCodeIdentifier (name = it_name), right = new CCodeConstant (name = "1"))));
				cblock.add_statement (cfor);
			} else if (stmt.collection.static_type.type.name == "List") {
				var it_name = "%s_it".printf (stmt.variable_name);
			
				var citdecl = new CCodeDeclaration (type_name = "GList *");
				citdecl.add_declarator (new CCodeVariableDeclarator (name = it_name));
				cblock.add_statement (citdecl);
				
				var cbody = new CCodeBlock ();
				
				var cdecl = new CCodeDeclaration (type_name = stmt.type_reference.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator (name = stmt.variable_name, initializer = new CCodeMemberAccess (inner = new CCodeIdentifier (name = it_name), member_name = "data", is_pointer = true)));
				cbody.add_statement (cdecl);
				
				cbody.add_statement (stmt.body.ccodenode);
				
				var ccond = new CCodeBinaryExpression (operator = CCodeBinaryOperator.INEQUALITY, left = new CCodeIdentifier (name = it_name), right = new CCodeConstant (name = "NULL"));
				
				var cfor = new CCodeForStatement (condition = ccond, body = cbody);
				cfor.add_initializer (new CCodeAssignment (left = new CCodeIdentifier (name = it_name), right = (CCodeExpression) stmt.collection.ccodenode));
				cfor.add_iterator (new CCodeAssignment (left = new CCodeIdentifier (name = it_name), right = new CCodeMemberAccess (inner = new CCodeIdentifier (name = it_name), member_name = "next", is_pointer = true)));
				cblock.add_statement (cfor);
			}
			
			stmt.ccodenode = cblock;
		}

		public override void visit_break_statement (BreakStatement stmt) {
			stmt.ccodenode = new CCodeBreakStatement ();
		}

		public override void visit_continue_statement (ContinueStatement stmt) {
			stmt.ccodenode = new CCodeContinueStatement ();
		}

		public override void visit_return_statement (ReturnStatement stmt) {
			if (stmt.return_expression == null) {
				stmt.ccodenode = new CCodeReturnStatement ();
			} else {
				stmt.ccodenode = new CCodeReturnStatement (return_expression = (CCodeExpression) stmt.return_expression.ccodenode);
			}
		}

		public override void visit_boolean_literal (BooleanLiteral expr) {
			if (expr.value) {
				expr.ccodenode = new CCodeConstant (name = "TRUE");
			} else {
				expr.ccodenode = new CCodeConstant (name = "FALSE");
			}
		}

		public override void visit_character_literal (CharacterLiteral expr) {
			expr.ccodenode = new CCodeConstant (name = expr.value);
		}

		public override void visit_integer_literal (IntegerLiteral expr) {
			expr.ccodenode = new CCodeConstant (name = expr.value);
		}

		public override void visit_string_literal (StringLiteral expr) {
			expr.ccodenode = new CCodeConstant (name = expr.value);
		}

		public override void visit_null_literal (NullLiteral expr) {
			expr.ccodenode = new CCodeConstant (name = "NULL");
		}

		public override void visit_literal_expression (LiteralExpression expr) {
			expr.ccodenode = expr.literal.ccodenode;
		}
		
		private void process_cmember (Expression expr, CCodeIdentifier pub_inst, Type_ base_type) {
			if (expr.symbol_reference.node is Method) {
				var m = (Method) expr.symbol_reference.node;
				if (!m.is_override) {
					expr.ccodenode = new CCodeIdentifier (name = m.get_cname ());
				} else {
					expr.ccodenode = new CCodeIdentifier (name = m.base_method.get_cname ());
				}
			} else if (expr.symbol_reference.node is Field) {
				var f = (Field) expr.symbol_reference.node;
				if (f.instance) {
					ref CCodeExpression typed_inst;
					if (f.symbol.parent_symbol.node != base_type) {
						typed_inst = new CCodeFunctionCall (call = new CCodeIdentifier (name = ((Type_) f.symbol.parent_symbol.node).get_upper_case_cname (null)));
						((CCodeFunctionCall) typed_inst).add_argument (pub_inst);
					} else {
						typed_inst = pub_inst;
					}
					ref CCodeExpression inst;
					if (f.access == MemberAccessibility.PRIVATE) {
						inst = new CCodeMemberAccess (inner = typed_inst, member_name = "priv", is_pointer = true);
					} else {
						inst = typed_inst;
					}
					expr.ccodenode = new CCodeMemberAccess (inner = inst, member_name = f.get_cname (), is_pointer = true);
				} else {
					if (f.symbol.parent_symbol.node is Type_) {
						var t = (Type_) f.symbol.parent_symbol.node;
						expr.ccodenode = new CCodeIdentifier (name = "%s_%s".printf (t.get_lower_case_cname (null), f.get_cname ()));
					} else {
						expr.ccodenode = new CCodeIdentifier (name = f.get_cname ());
					}
				}
			} else if (expr.symbol_reference.node is Constant) {
				var c = (Constant) expr.symbol_reference.node;
				expr.ccodenode = new CCodeIdentifier (name = c.get_cname ());
			} else if (expr.symbol_reference.node is Property) {
				var prop = (Property) expr.symbol_reference.node;
				var cl = (Class) prop.symbol.parent_symbol.node;
				var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_get_%s".printf (cl.get_lower_case_cname (null), prop.name)));
				ccall.add_argument (pub_inst);
				expr.ccodenode = ccall;
			} else if (expr.symbol_reference.node is EnumValue) {
				var ev = (EnumValue) expr.symbol_reference.node;
				expr.ccodenode = new CCodeConstant (name = ev.get_cname ());
			} else if (expr.symbol_reference.node is VariableDeclarator) {
				var decl = (VariableDeclarator) expr.symbol_reference.node;
				expr.ccodenode = new CCodeIdentifier (name = decl.name);
			} else if (expr.symbol_reference.node is FormalParameter) {
				var p = (FormalParameter) expr.symbol_reference.node;
				if (p.name == "this") {
					expr.ccodenode = pub_inst;
				} else {
					expr.ccodenode = new CCodeIdentifier (name = p.name);
				}
			}
		}
		
		public override void visit_simple_name (SimpleName expr) {
			var pub_inst = new CCodeIdentifier (name = "self");
			var base_type = (Type_) current_symbol.node;
			
			process_cmember (expr, pub_inst, base_type);
		}

		public override void visit_parenthesized_expression (ParenthesizedExpression expr) {
			expr.ccodenode = new CCodeParenthesizedExpression (inner = (CCodeExpression) expr.inner.ccodenode);
		}

		public override void visit_member_access (MemberAccess expr) {
			var pub_inst = expr.inner.ccodenode;
			Type_ base_type = null;
			if (expr.inner.static_type != null) {
				base_type = expr.inner.static_type.type;
			}

			process_cmember (expr, pub_inst, base_type);
		}

		public override void visit_invocation_expression (InvocationExpression expr) {
			var ccall = new CCodeFunctionCall (call = (CCodeExpression) expr.call.ccodenode);
			
			var m = (Method) expr.call.symbol_reference.node;
			CCodeExpression instance;
			if (m.instance) {
				if (expr.call is SimpleName) {
					instance = new CCodeIdentifier (name = "self");
				} else if (expr.call is MemberAccess) {
					instance = ((MemberAccess) expr.call).inner.ccodenode;
				} else {
					Report.error (expr.source_reference, "unsupported method invocation");
				}
				if (!m.instance_last) {
					ccall.add_argument (instance);
				}
			}
			
			foreach (Expression arg in expr.argument_list) {
				ccall.add_argument ((CCodeExpression) arg.ccodenode);
			}
			
			if (m.instance && m.instance_last) {
				ccall.add_argument (instance);
			}
			
			if (m.instance && m.returns_modified_pointer) {
				expr.ccodenode = new CCodeAssignment (left = instance, right = ccall);
			} else {
				expr.ccodenode = ccall;
			}
		}

		public override void visit_postfix_expression (PostfixExpression expr) {
			if (expr.increment) {
				expr.ccodenode = new CCodeUnaryExpression (operator = CCodeUnaryOperator.POSTFIX_INCREMENT, inner = expr.inner.ccodenode);
			} else {
				expr.ccodenode = new CCodeUnaryExpression (operator = CCodeUnaryOperator.POSTFIX_DECREMENT, inner = expr.inner.ccodenode);
			}
		}

		public override void visit_object_creation_expression (ObjectCreationExpression expr) {
			var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_object_new"));
			
			ccall.add_argument (new CCodeConstant (name = expr.type_reference.get_upper_case_cname ("TYPE_")));

			foreach (NamedArgument arg in expr.named_argument_list) {
				ccall.add_argument (new CCodeConstant (name = "\"%s\"".printf (arg.name)));
				ccall.add_argument ((CCodeExpression) arg.argument.ccodenode);
			}
			ccall.add_argument (new CCodeConstant (name = "NULL"));
			
			expr.ccodenode = ccall;
		}

		public override void visit_unary_expression (UnaryExpression expr) {
			CCodeUnaryOperator op;
			if (expr.operator == UnaryOperator.PLUS) {
				op = CCodeUnaryOperator.PLUS;
			} else if (expr.operator == UnaryOperator.MINUS) {
				op = CCodeUnaryOperator.MINUS;
			} else if (expr.operator == UnaryOperator.LOGICAL_NEGATION) {
				op = CCodeUnaryOperator.LOGICAL_NEGATION;
			} else if (expr.operator == UnaryOperator.BITWISE_COMPLEMENT) {
				op = CCodeUnaryOperator.BITWISE_COMPLEMENT;
			} else if (expr.operator == UnaryOperator.REF) {
				op = CCodeUnaryOperator.ADDRESS_OF;
			} else if (expr.operator == UnaryOperator.OUT) {
				op = CCodeUnaryOperator.ADDRESS_OF;
			}
			expr.ccodenode = new CCodeUnaryExpression (operator = op, inner = expr.inner.ccodenode);
		}

		public override void visit_cast_expression (CastExpression expr) {
			expr.ccodenode = expr.inner.ccodenode;
		}

		public override void visit_binary_expression (BinaryExpression expr) {
			expr.ccodenode = new CCodeBinaryExpression (operator = expr.operator, left = expr.left.ccodenode, right = expr.right.ccodenode);
		}

		public override void visit_type_check (TypeCheck expr) {
			var ccheck = new CCodeFunctionCall (call = new CCodeIdentifier (name = expr.type_reference.type.get_upper_case_cname ("IS_")));
			ccheck.add_argument (expr.expression.ccodenode);
			expr.ccodenode = ccheck;
		}

		public override void visit_assignment (Assignment a) {
			if (a.left.symbol_reference.node is Property) {
				var prop = (Property) a.left.symbol_reference.node;
				var cl = (Class) prop.symbol.parent_symbol.node;
				var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_set_%s".printf (cl.get_lower_case_cname (null), prop.name)));
				if (a.left is MemberAccess) {
					var expr = (MemberAccess) a.left;
					ccall.add_argument (expr.inner.ccodenode);
				} else if (a.left is SimpleName) {
					ccall.add_argument (new CCodeIdentifier (name = "self"));
				} else {
					Report.error (a.source_reference, "unexpected lvalue in assignment");
				}
				ccall.add_argument ((CCodeExpression) a.right.ccodenode);
				a.ccodenode = ccall;
			} else {
				a.ccodenode = new CCodeAssignment (left = (CCodeExpression) a.left.ccodenode, right = (CCodeExpression) a.right.ccodenode);
			}
		}
	}
}
