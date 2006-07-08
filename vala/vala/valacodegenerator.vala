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

/**
 * Code visitor generating C Code.
 */
public class Vala.CodeGenerator : CodeVisitor {
	/**
	 * Specifies whether automatic memory management is active.
	 */
	public bool memory_management { get; set; }
	
	Symbol root_symbol;
	Symbol current_symbol;
	Symbol current_type_symbol;

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
	
	/* all temporary variables */
	List<VariableDeclarator> temp_vars;
	/* temporary variables that own their content */
	List<VariableDeclarator> temp_ref_vars;
	
	private int next_temp_var_id = 0;

	TypeReference bool_type;
	TypeReference string_type;

	/**
	 * Generate and emit C code for the specified code context.
	 *
	 * @param context a code context
	 */
	public void emit (CodeContext! context) {
		context.find_header_cycles ();

		root_symbol = context.get_root ();

		bool_type = new TypeReference ();
		bool_type.type = (DataType) root_symbol.lookup ("bool").node;

		string_type = new TypeReference ();
		string_type.type = (DataType) root_symbol.lookup ("string").node;
	
		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (!file.pkg) {
				file.accept (this);
			}
		}
	}

	public override void visit_begin_source_file (SourceFile! source_file) {
		header_begin = new CCodeFragment ();
		header_type_declaration = new CCodeFragment ();
		header_type_definition = new CCodeFragment ();
		header_type_member_declaration = new CCodeFragment ();
		source_begin = new CCodeFragment ();
		source_include_directives = new CCodeFragment ();
		source_type_member_declaration = new CCodeFragment ();
		source_type_member_definition = new CCodeFragment ();
		
		next_temp_var_id = 0;
		
		header_begin.append (new CCodeIncludeDirective (filename = "glib.h"));
		source_include_directives.append (new CCodeIncludeDirective (filename = source_file.get_cheader_filename ()));
		
		ref List<string> used_includes = null;
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
				var namespaces = cycle_file.get_namespaces ();
				foreach (Namespace ns in namespaces) {
					var structs = ns.get_structs ();
					foreach (Struct st in structs) {
						header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct _%s".printf (st.get_cname ()), declarator = new CCodeVariableDeclarator (name = st.get_cname ())));
					}
					var classes = ns.get_classes ();
					foreach (Class cl in classes) {
						header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct _%s".printf (cl.get_cname ()), declarator = new CCodeVariableDeclarator (name = cl.get_cname ())));
						header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct _%sClass".printf (cl.get_cname ()), declarator = new CCodeVariableDeclarator (name = "%sClass".printf (cl.get_cname ()))));
					}
				}
			}
		}
	}
	
	private static ref string get_define_for_filename (string! filename) {
		var define = String.new ("__");
		
		var i = filename;
		while (i.len () > 0) {
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
	
	public override void visit_end_source_file (SourceFile! source_file) {
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

	public override void visit_begin_class (Class! cl) {
		current_symbol = cl.symbol;
		current_type_symbol = cl.symbol;

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
			header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct %s".printf (instance_struct.name), declarator = new CCodeVariableDeclarator (name = cl.get_cname ())));
			header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct %s".printf (type_struct.name), declarator = new CCodeVariableDeclarator (name = "%sClass".printf (cl.get_cname ()))));
		}
		header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct %s".printf (instance_priv_struct.name), declarator = new CCodeVariableDeclarator (name = "%sPrivate".printf (cl.get_cname ()))));
		
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
	
	public override void visit_end_class (Class! cl) {
		add_get_property_function (cl);
		add_set_property_function (cl);
		add_class_init_function (cl);
		
		foreach (TypeReference base_type in cl.get_base_types ()) {
			if (base_type.type is Interface) {
				add_interface_init_function (cl, (Interface) base_type.type);
			}
		}
		
		add_instance_init_function (cl);
		if (memory_management) {
			add_dispose_function (cl);
		}
		
		var type_fun = new ClassRegisterFunction (class_reference = cl);
		type_fun.init_from_type ();
		header_type_member_declaration.append (type_fun.get_declaration ());
		source_type_member_definition.append (type_fun);

		current_type_symbol = null;
	}
	
	private void add_class_init_function (Class! cl) {
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
		
		if (cl.constructor != null) {
			var ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "G_OBJECT_CLASS"));
			ccast.add_argument (new CCodeIdentifier (name = "klass"));
			init_block.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeMemberAccess (inner = ccast, member_name = "constructor", is_pointer = true), right = new CCodeIdentifier (name = "%s_constructor".printf (cl.get_lower_case_cname (null))))));
		}

		if (memory_management && cl.get_fields () != null) {
			var ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "G_OBJECT_CLASS"));
			ccast.add_argument (new CCodeIdentifier (name = "klass"));
			init_block.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeMemberAccess (inner = ccast, member_name = "dispose", is_pointer = true), right = new CCodeIdentifier (name = "%s_dispose".printf (cl.get_lower_case_cname (null))))));
		}
		
		var methods = cl.get_methods ();
		foreach (Method m in methods) {
			if (!m.is_virtual && !m.overrides) {
				continue;
			}
			
			var base_type = m.base_method.symbol.parent_symbol.node;
			if (base_type is Interface) {
				continue;
			}
			
			var ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_CLASS".printf (((Class) base_type).get_upper_case_cname (null))));
			ccast.add_argument (new CCodeIdentifier (name = "klass"));
			init_block.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeMemberAccess (inner = ccast, member_name = m.name, is_pointer = true), right = new CCodeIdentifier (name = m.get_real_cname ()))));
		}
		
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			var cinst = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_object_class_install_property"));
			cinst.add_argument (ccall);
			cinst.add_argument (new CCodeConstant (name = prop.get_upper_case_cname ()));
			var cspec = new CCodeFunctionCall ();
			cspec.add_argument (prop.get_canonical_cconstant ());
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
			
			var pflags = "G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB";
			if (prop.get_accessor != null) {
				pflags = "%s%s".printf (pflags, " | G_PARAM_READABLE");
			}
			if (prop.set_accessor != null) {
				pflags = "%s%s".printf (pflags, " | G_PARAM_WRITABLE");
				if (prop.set_accessor.construct_) {
					if (prop.set_accessor.writable) {
						pflags = "%s%s".printf (pflags, " | G_PARAM_CONSTRUCT");
					} else {
						pflags = "%s%s".printf (pflags, " | G_PARAM_CONSTRUCT_ONLY");
					}
				}
			}
			cspec.add_argument (new CCodeConstant (name = pflags));
			cinst.add_argument (cspec);
			
			init_block.add_statement (new CCodeExpressionStatement (expression = cinst));
		}
		
		foreach (Signal sig in cl.get_signals ()) {
			var csignew = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_signal_new"));
			csignew.add_argument (new CCodeConstant (name = "\"%s\"".printf (sig.name)));
			csignew.add_argument (new CCodeIdentifier (name = cl.get_upper_case_cname ("TYPE_")));
			csignew.add_argument (new CCodeConstant (name = "G_SIGNAL_RUN_LAST"));
			csignew.add_argument (new CCodeConstant (name = "0"));
			csignew.add_argument (new CCodeConstant (name = "NULL"));
			csignew.add_argument (new CCodeConstant (name = "NULL"));
			
			/* TODO: generate marshallers */
			string marshaller = "g_cclosure_marshal";
			
			var marshal_arg = new CCodeIdentifier (name = marshaller);
			csignew.add_argument (marshal_arg);
			
			var params = sig.get_parameters ();
			var params_len = params.length ();
			if (sig.return_type.type == null) {
				marshaller = "%s_VOID_".printf (marshaller);
				csignew.add_argument (new CCodeConstant (name = "G_TYPE_NONE"));
			} else {
				marshaller = "%s_%s_".printf (marshaller, sig.return_type.type.get_marshaller_type_name ());
				csignew.add_argument (new CCodeConstant (name = sig.return_type.type.get_type_id ()));
			}
			csignew.add_argument (new CCodeConstant (name = "%d".printf (params_len)));
			foreach (FormalParameter param in params) {
				marshaller = "%s_%s".printf (marshaller, param.type_reference.type.get_marshaller_type_name ());
				csignew.add_argument (new CCodeConstant (name = param.type_reference.type.get_type_id ()));
			}
			
			marshal_arg.name = marshaller;
			
			init_block.add_statement (new CCodeExpressionStatement (expression = csignew));
		}
		
		source_type_member_definition.append (class_init);
	}
	
	private void add_interface_init_function (Class! cl, Interface! iface) {
		var iface_init = new CCodeFunction (name = "%s_%s_interface_init".printf (cl.get_lower_case_cname (null), iface.get_lower_case_cname (null)), return_type = "void");
		iface_init.add_parameter (new CCodeFormalParameter (type_name = "%sInterface *".printf (iface.get_cname ()), name = "iface"));
		iface_init.modifiers = CCodeModifiers.STATIC;
		
		var init_block = new CCodeBlock ();
		iface_init.block = init_block;
		
		ref CCodeFunctionCall ccall;
		
		var methods = cl.get_methods ();
		foreach (Method m in methods) {
			if (!m.overrides) {
				continue;
			}
			
			var base_type = m.base_method.symbol.parent_symbol.node;
			if (base_type != iface) {
				continue;
			}
			
			var ciface = new CCodeIdentifier (name = "iface");
			init_block.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeMemberAccess (inner = ciface, member_name = m.name, is_pointer = true), right = new CCodeIdentifier (name = m.get_real_cname ()))));
		}
		
		source_type_member_definition.append (iface_init);
	}
	
	private void add_instance_init_function (Class! cl) {
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
		
		var fields = cl.get_fields ();
		foreach (Field f in fields) {
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
	
	private void add_dispose_function (Class! cl) {
		function = new CCodeFunction (name = "%s_dispose".printf (cl.get_lower_case_cname (null)), return_type = "void");
		function.modifiers = CCodeModifiers.STATIC;
		
		function.add_parameter (new CCodeFormalParameter (name = "obj", type_name = "GObject *"));
		
		source_type_member_declaration.append (function.copy ());


		var cblock = new CCodeBlock ();

		var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = cl.get_upper_case_cname (null)));
		ccall.add_argument (new CCodeIdentifier (name = "obj"));
		
		var cdecl = new CCodeDeclaration (type_name = "%s *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator (name = "self", initializer = ccall));
		
		cblock.add_statement (cdecl);
		
		
		var fields = cl.get_fields ();
		foreach (Field f in fields) {
			if (f.instance && f.type_reference.is_lvalue_ref) {
				var cself = new CCodeIdentifier (name = "self");
				CCodeExpression cstruct = cself;
				if (f.access == MemberAccessibility.PRIVATE) {
					cstruct = new CCodeMemberAccess (inner = cself, member_name = "priv", is_pointer = true);
				}
				var cfield = new CCodeMemberAccess (inner = cstruct, member_name = f.get_cname (), is_pointer = true);

				cblock.add_statement (new CCodeExpressionStatement (expression = get_unref_expression (cfield, f.type_reference)));
			}
		}


		cdecl = new CCodeDeclaration (type_name = "%sClass *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator (name = "klass"));
		cblock.add_statement (cdecl);

		cdecl = new CCodeDeclaration (type_name = "GObjectClass *");
		cdecl.add_declarator (new CCodeVariableDeclarator (name = "parent_class"));
		cblock.add_statement (cdecl);


		ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_type_class_peek"));
		ccall.add_argument (new CCodeIdentifier (name = cl.get_upper_case_cname ("TYPE_")));
		var ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_CLASS".printf (cl.get_upper_case_cname (null))));
		ccast.add_argument (ccall);
		cblock.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeIdentifier (name = "klass"), right = ccast)));

		ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_type_class_peek_parent"));
		ccall.add_argument (new CCodeIdentifier (name = "klass"));
		ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "G_OBJECT_CLASS"));
		ccast.add_argument (ccall);
		cblock.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeIdentifier (name = "parent_class"), right = ccast)));

		
		ccall = new CCodeFunctionCall (call = new CCodeMemberAccess (inner = new CCodeIdentifier (name = "parent_class"), member_name = "dispose", is_pointer = true));
		ccall.add_argument (new CCodeIdentifier (name = "obj"));
		cblock.add_statement (new CCodeExpressionStatement (expression = ccall));


		function.block = cblock;

		source_type_member_definition.append (function);
	}
	
	private void add_get_property_function (Class! cl) {
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
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			if (prop.get_accessor == null) {
				continue;
			}

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
	
	private void add_set_property_function (Class! cl) {
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
		var props = cl.get_properties ();
		foreach (Property prop in props) {
			if (prop.set_accessor == null) {
				continue;
			}

			var ccase = new CCodeCaseStatement (expression = new CCodeIdentifier (name = prop.get_upper_case_cname ()));
			var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_set_%s".printf (cl.get_lower_case_cname (null), prop.name)));
			ccall.add_argument (new CCodeIdentifier (name = "self"));
			var cgetcall = new CCodeFunctionCall ();
			if (prop.type_reference.type is Class) {
				cgetcall.call = new CCodeIdentifier (name = "g_value_get_object");
			} else if (prop.type_reference.type_name == "string") {
				cgetcall.call = new CCodeIdentifier (name = "g_value_get_string");
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
	
	public override void visit_begin_struct (Struct! st) {
		instance_struct = new CCodeStruct (name = "_%s".printf (st.name));

		if (st.source_reference.comment != null) {
			header_type_definition.append (new CCodeComment (text = st.source_reference.comment));
		}
		header_type_definition.append (instance_struct);
	}

	public override void visit_begin_interface (Interface! iface) {
		current_symbol = iface.symbol;
		current_type_symbol = iface.symbol;

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
			header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct _%s".printf (iface.get_cname ()), declarator = new CCodeVariableDeclarator (name = iface.get_cname ())));
			header_type_declaration.append (new CCodeTypeDefinition (type_name = "struct %s".printf (type_struct.name), declarator = new CCodeVariableDeclarator (name = "%sInterface".printf (iface.get_cname ()))));
		}
		
		type_struct.add_field ("GTypeInterface", "parent");

		if (iface.source_reference.comment != null) {
			header_type_definition.append (new CCodeComment (text = iface.source_reference.comment));
		}
		header_type_definition.append (type_struct);
	}

	public override void visit_end_interface (Interface! iface) {
		var type_fun = new InterfaceRegisterFunction (interface_reference = iface);
		type_fun.init_from_type ();
		header_type_member_declaration.append (type_fun.get_declaration ());
		source_type_member_definition.append (type_fun);

		current_type_symbol = null;
	}
	
	public override void visit_begin_enum (Enum! en) {
		cenum = new CCodeEnum (name = en.get_cname ());

		if (en.source_reference.comment != null) {
			header_type_definition.append (new CCodeComment (text = en.source_reference.comment));
		}
		header_type_definition.append (cenum);
	}

	public override void visit_enum_value (EnumValue! ev) {
		cenum.add_value (ev.get_cname (), null);
	}

	public override void visit_end_callback (Callback! cb) {
		var ctypedef = new CCodeTypeDefinition ();
		
		ctypedef.type_name = cb.return_type.get_cname ();
		
		var cfundecl = new CCodeFunctionDeclarator (name = cb.get_cname ());
		foreach (FormalParameter param in cb.get_parameters ()) {
			cfundecl.add_parameter ((CCodeFormalParameter) param.ccodenode);
		}
		ctypedef.declarator = cfundecl;
		
		if (cb.access == MemberAccessibility.PUBLIC) {
			header_type_declaration.append (ctypedef);
		} else {
			source_type_member_declaration.append (ctypedef);
		}
	}

	public override void visit_constant (Constant! c) {
		if (c.symbol.parent_symbol.node is DataType) {
			var t = (DataType) c.symbol.parent_symbol.node;
			var cdecl = new CCodeDeclaration (type_name = c.type_reference.get_const_cname ());
			var arr = "";
			if (c.type_reference.array) {
				arr = "[]";
			}
			cdecl.add_declarator (new CCodeVariableDeclarator (name = "%s%s".printf (c.get_cname (), arr), initializer = c.initializer.ccodenode));
			cdecl.modifiers = CCodeModifiers.STATIC;
			source_type_member_declaration.append (cdecl);
		}
	}
	
	public override void visit_field (Field! f) {
		if (f.access == MemberAccessibility.PUBLIC) {
			instance_struct.add_field (f.type_reference.get_cname (), f.get_cname ());
		} else if (f.access == MemberAccessibility.PRIVATE) {
			if (f.instance) {
				instance_priv_struct.add_field (f.type_reference.get_cname (), f.get_cname ());
			} else {
				if (f.symbol.parent_symbol.node is DataType) {
					var t = (DataType) f.symbol.parent_symbol.node;
					var cdecl = new CCodeDeclaration (type_name = f.type_reference.get_cname ());
					var var_decl = new CCodeVariableDeclarator (name = "%s_%s".printf (t.get_lower_case_cname (null), f.get_cname ()));
					if (f.initializer != null) {
						var_decl.initializer = (CCodeExpression) f.initializer.ccodenode;
					}
					cdecl.add_declarator (var_decl);
					cdecl.modifiers = CCodeModifiers.STATIC;
					source_type_member_declaration.append (cdecl);
				}
			}
		}
	}

	public override void visit_begin_method (Method! m) {
		current_symbol = m.symbol;
	}
	
	private ref CCodeStatement create_method_type_check_statement (Method! m, DataType! t, bool non_null, string! var_name) {
		return create_type_check_statement (m, m.return_type.type, t, non_null, var_name);
	}
	
	private ref CCodeStatement create_property_type_check_statement (Property! prop, bool getter, DataType! t, bool non_null, string! var_name) {
		if (getter) {
			return create_type_check_statement (prop, prop.type_reference.type, t, non_null, var_name);
		} else {
			return create_type_check_statement (prop, null, t, non_null, var_name);
		}
	}
	
	private ref CCodeStatement create_type_check_statement (CodeNode! method_node, DataType ret_type, DataType! t, bool non_null, string! var_name) {
		var ccheck = new CCodeFunctionCall ();
		
		var ctype_check = new CCodeFunctionCall (call = new CCodeIdentifier (name = t.get_upper_case_cname ("IS_")));
		ctype_check.add_argument (new CCodeIdentifier (name = var_name));
		
		ref CCodeExpression cexpr = ctype_check;
		if (!non_null) {
			var cnull = new CCodeBinaryExpression (operator = CCodeBinaryOperator.EQUALITY, left = new CCodeIdentifier (name = var_name), right = new CCodeConstant (name = "NULL"));
		
			cexpr = new CCodeBinaryExpression (operator = CCodeBinaryOperator.OR, left = cnull, right = ctype_check);
		}
		ccheck.add_argument (cexpr);
		
		if (ret_type == null) {
			/* void function */
			ccheck.call = new CCodeIdentifier (name = "g_return_if_fail");
		} else {
			ccheck.call = new CCodeIdentifier (name = "g_return_val_if_fail");
			
			if (ret_type.is_reference_type ()) {
				ccheck.add_argument (new CCodeConstant (name = "NULL"));
			} else if (ret_type.name == "bool") {
				ccheck.add_argument (new CCodeConstant (name = "FALSE"));
			} else if (ret_type.name == "int" || ret_type is Enum || ret_type is Flags) {
				ccheck.add_argument (new CCodeConstant (name = "0"));
			} else {
				Report.error (method_node.source_reference, "not supported return type for runtime type checks");
				return null;
			}
		}
		
		return new CCodeExpressionStatement (expression = ccheck);
	}

	private DataType find_parent_type (CodeNode node) {
		var sym = node.symbol;
		while (sym != null) {
			if (sym.node is DataType) {
				return (DataType) sym.node;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}

	public override void visit_end_method (Method! m) {
		current_symbol = current_symbol.parent_symbol;

		if (m.name == "init") {
			return;
		}
	
		function = new CCodeFunction (name = m.get_real_cname (), return_type = m.return_type.get_cname ());
		CCodeFunctionDeclarator vdeclarator = null;
		
		CCodeFormalParameter instance_param = null;
		
		if (m.instance) {
			var this_type = new TypeReference ();
			this_type.type = find_parent_type (m);
			if (!m.overrides) {
				instance_param = new CCodeFormalParameter (type_name = this_type.get_cname (), name = "self");
			} else {
				var base_type = new TypeReference ();
				base_type.type = (DataType) m.base_method.symbol.parent_symbol.node;
				instance_param = new CCodeFormalParameter (type_name = base_type.get_cname (), name = "base");
			}
			if (!m.instance_last) {
				function.add_parameter (instance_param);
			}
			
			if (m.is_abstract || m.is_virtual) {
				var vdecl = new CCodeDeclaration (type_name = m.return_type.get_cname ());
				vdeclarator = new CCodeFunctionDeclarator (name = m.name);
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);

				vdeclarator.add_parameter (instance_param);
			}
		}
		
		var params = m.get_parameters ();
		foreach (FormalParameter param in params) {
			function.add_parameter ((CCodeFormalParameter) param.ccodenode);
			if (vdeclarator != null) {
				vdeclarator.add_parameter ((CCodeFormalParameter) param.ccodenode);
			}
		}
		
		if (m.instance && m.instance_last) {
			function.add_parameter (instance_param);
		}

		/* real function declaration and definition not needed
		 * for abstract methods */
		if (!m.is_abstract) {
			if (m.access == MemberAccessibility.PUBLIC && !(m.is_virtual || m.overrides)) {
				/* public methods need function declaration in
				 * header file except virtual/overridden methods */
				header_type_member_declaration.append (function.copy ());
			} else {
				/* declare all other functions in source file to
				 * avoid dependency on order within source file */
				function.modifiers |= CCodeModifiers.STATIC;
				source_type_member_declaration.append (function.copy ());
			}
			
			/* Methods imported from a plain C file don't
			 * have a body, e.g. Vala.Parser.parse_file () */
			if (m.body != null) {
				function.block = (CCodeBlock) m.body.ccodenode;

				var cinit = new CCodeFragment ();
				function.block.prepend_statement (cinit);

				if (m.symbol.parent_symbol.node is Class) {
					var cl = (Class) m.symbol.parent_symbol.node;
					if (m.overrides) {
						var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = cl.get_upper_case_cname (null)));
						ccall.add_argument (new CCodeIdentifier (name = "base"));
						
						var cdecl = new CCodeDeclaration (type_name = "%s *".printf (cl.get_cname ()));
						cdecl.add_declarator (new CCodeVariableDeclarator (name = "self", initializer = ccall));
						
						cinit.append (cdecl);
					} else if (m.instance) {
						cinit.append (create_method_type_check_statement (m, cl, true, "self"));
					}
				}
				foreach (FormalParameter param in m.get_parameters ()) {
					var t = param.type_reference.type;
					if (t != null && (t is Class || t is Interface) && !param.type_reference.is_out) {
						cinit.append (create_method_type_check_statement (m, t, param.type_reference.non_null, param.name));
					}
				}

				if (m.source_reference != null && m.source_reference.comment != null) {
					source_type_member_definition.append (new CCodeComment (text = m.source_reference.comment));
				}
				source_type_member_definition.append (function);
			}
		}
		
		if (m.is_abstract || m.is_virtual) {
			var vfunc = new CCodeFunction (name = m.get_cname (), return_type = m.return_type.get_cname ());

			var this_type = new TypeReference ();
			this_type.type = (DataType) m.symbol.parent_symbol.node;

			var cparam = new CCodeFormalParameter (type_name = this_type.get_cname (), name = "self");
			vfunc.add_parameter (cparam);
			
			var vblock = new CCodeBlock ();
			
			CCodeFunctionCall vcast = null;
			if (m.symbol.parent_symbol.node is Interface) {
				var iface = (Interface) m.symbol.parent_symbol.node;

				vcast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_GET_INTERFACE".printf (iface.get_upper_case_cname (null))));
			} else {
				var cl = (Class) m.symbol.parent_symbol.node;

				vcast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_GET_CLASS".printf (cl.get_upper_case_cname (null))));
			}
			vcast.add_argument (new CCodeIdentifier (name = "self"));
		
			var vcall = new CCodeFunctionCall (call = new CCodeMemberAccess (inner = vcast, member_name = m.name, is_pointer = true));
			vcall.add_argument (new CCodeIdentifier (name = "self"));
		
			var params = m.get_parameters ();
			foreach (FormalParameter param in params) {
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
	
	public override void visit_formal_parameter (FormalParameter! p) {
		if (!p.ellipsis) {
			p.ccodenode = new CCodeFormalParameter (type_name = p.type_reference.get_cname (), name = p.name);
		}
	}

	public override void visit_end_property (Property! prop) {
		prop_enum.add_value (prop.get_upper_case_cname (), null);
	}

	public override void visit_end_property_accessor (PropertyAccessor! acc) {
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
			function.block = (CCodeBlock) acc.body.ccodenode;

			function.block.prepend_statement (create_property_type_check_statement (prop, acc.readable, cl, true, "self"));
		}
		
		source_type_member_definition.append (function);
	}
	
	public override void visit_end_constructor (Constructor! c) {
		var cl = (Class) c.symbol.parent_symbol.node;
	
		function = new CCodeFunction (name = "%s_constructor".printf (cl.get_lower_case_cname (null)), return_type = "GObject *");
		function.modifiers = CCodeModifiers.STATIC;
		
		function.add_parameter (new CCodeFormalParameter (name = "type", type_name = "GType"));
		function.add_parameter (new CCodeFormalParameter (name = "n_construct_properties", type_name = "guint"));
		function.add_parameter (new CCodeFormalParameter (name = "construct_properties", type_name = "GObjectConstructParam *"));
		
		source_type_member_declaration.append (function.copy ());


		var cblock = new CCodeBlock ();
		var cdecl = new CCodeDeclaration (type_name = "GObject *");
		cdecl.add_declarator (new CCodeVariableDeclarator (name = "obj"));
		cblock.add_statement (cdecl);

		cdecl = new CCodeDeclaration (type_name = "%sClass *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator (name = "klass"));
		cblock.add_statement (cdecl);

		cdecl = new CCodeDeclaration (type_name = "GObjectClass *");
		cdecl.add_declarator (new CCodeVariableDeclarator (name = "parent_class"));
		cblock.add_statement (cdecl);


		var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_type_class_peek"));
		ccall.add_argument (new CCodeIdentifier (name = cl.get_upper_case_cname ("TYPE_")));
		var ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "%s_CLASS".printf (cl.get_upper_case_cname (null))));
		ccast.add_argument (ccall);
		cblock.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeIdentifier (name = "klass"), right = ccast)));

		ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_type_class_peek_parent"));
		ccall.add_argument (new CCodeIdentifier (name = "klass"));
		ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "G_OBJECT_CLASS"));
		ccast.add_argument (ccall);
		cblock.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeIdentifier (name = "parent_class"), right = ccast)));

		
		ccall = new CCodeFunctionCall (call = new CCodeMemberAccess (inner = new CCodeIdentifier (name = "parent_class"), member_name = "constructor", is_pointer = true));
		ccall.add_argument (new CCodeIdentifier (name = "type"));
		ccall.add_argument (new CCodeIdentifier (name = "n_construct_properties"));
		ccall.add_argument (new CCodeIdentifier (name = "construct_properties"));
		cblock.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeIdentifier (name = "obj"), right = ccall)));


		ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = cl.get_upper_case_cname (null)));
		ccall.add_argument (new CCodeIdentifier (name = "obj"));
		
		cdecl = new CCodeDeclaration (type_name = "%s *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator (name = "self", initializer = ccall));
		
		cblock.add_statement (cdecl);


		cblock.add_statement (c.body.ccodenode);
		
		cblock.add_statement (new CCodeReturnStatement (return_expression = new CCodeIdentifier (name = "obj")));
		
		function.block = cblock;

		if (c.source_reference.comment != null) {
			source_type_member_definition.append (new CCodeComment (text = c.source_reference.comment));
		}
		source_type_member_definition.append (function);
	}

	public override void visit_begin_block (Block! b) {
		current_symbol = b.symbol;
	}

	public override void visit_end_block (Block! b) {
		var local_vars = b.get_local_variables ();
		foreach (VariableDeclarator decl in local_vars) {
			decl.symbol.active = false;
		}
	
		var cblock = new CCodeBlock ();
		
		foreach (Statement stmt in b.get_statements ()) {
			var src = stmt.source_reference;
			if (src != null && src.comment != null) {
				cblock.add_statement (new CCodeComment (text = src.comment));
			}
			
			if (stmt.ccodenode is CCodeFragment) {
				foreach (CCodeStatement cstmt in ((CCodeFragment) stmt.ccodenode).get_children ()) {
					cblock.add_statement (cstmt);
				}
			} else {
				cblock.add_statement ((CCodeStatement) stmt.ccodenode);
			}
		}
		
		if (memory_management) {
			foreach (VariableDeclarator decl in local_vars) {
				if (decl.type_reference.type.is_reference_type () && decl.type_reference.is_lvalue_ref) {
					cblock.add_statement (new CCodeExpressionStatement (expression = get_unref_expression (new CCodeIdentifier (name = decl.name), decl.type_reference)));
				}
			}
		}
		
		b.ccodenode = cblock;

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_empty_statement (EmptyStatement! stmt) {
		stmt.ccodenode = new CCodeEmptyStatement ();
	}

	public override void visit_declaration_statement (DeclarationStatement! stmt) {
		/* split declaration statement as var declarators
		 * might have different types */
	
		var cfrag = new CCodeFragment ();
		
		foreach (VariableDeclarator decl in stmt.declaration.variable_declarators) {
			var cdecl = new CCodeDeclaration (type_name = decl.type_reference.get_cname ());
		
			cdecl.add_declarator ((CCodeVariableDeclarator) decl.ccodenode);

			cfrag.append (cdecl);
		}
		
		stmt.ccodenode = cfrag;

		foreach (VariableDeclarator decl in stmt.declaration.variable_declarators) {
			if (decl.initializer != null) {
				create_temp_decl (stmt, decl.initializer.temp_vars);
			}
		}
	}

	public override void visit_variable_declarator (VariableDeclarator! decl) {
		CCodeExpression rhs = null;
		if (decl.initializer != null) {
			rhs = (CCodeExpression) decl.initializer.ccodenode;
			
			if (decl.type_reference.type != null
			    && decl.initializer.static_type.type != null
			    && decl.type_reference.type.is_reference_type ()
			    && decl.initializer.static_type.type != decl.type_reference.type) {
				rhs = new InstanceCast (type_reference = decl.type_reference.type, inner = rhs);
			}
		} else if (decl.type_reference.type != null && decl.type_reference.type.is_reference_type ()) {
			rhs = new CCodeConstant (name = "NULL");
		}
			
		decl.ccodenode = new CCodeVariableDeclarator (name = decl.name, initializer = rhs);

		decl.symbol.active = true;
	}

	public override void visit_initializer_list (InitializerList! list) {
		var clist = new CCodeInitializerList ();
		foreach (Expression expr in list.initializers) {
			clist.append ((CCodeExpression) expr.ccodenode);
		}
		list.ccodenode = clist;
	}
	
	private ref VariableDeclarator get_temp_variable_declarator (TypeReference! type) {
		var decl = new VariableDeclarator (name = "__temp%d".printf (next_temp_var_id));
		decl.type_reference = type.copy ();
		decl.type_reference.is_ref = false;
		decl.type_reference.is_out = false;
		
		next_temp_var_id++;
		
		return decl;
	}
	
	private ref CCodeExpression get_unref_expression (CCodeExpression! cvar, TypeReference! type) {
		/* (foo == NULL ? NULL : foo = (unref (foo), NULL)) */
		
		/* can be simplified to
		 * foo = (unref (foo), NULL)
		 * if foo is of static type non-null
		 */

		var cisnull = new CCodeBinaryExpression (operator = CCodeBinaryOperator.EQUALITY, left = cvar, right = new CCodeConstant (name = "NULL"));

		string unref_function;
		if (type.type.is_reference_counting ()) {
			unref_function = type.type.get_unref_function ();
		} else {
			unref_function = type.type.get_free_function ();
		}
	
		if (type.array && type.type.name == "string") {
			unref_function = "g_strfreev";
		}
		var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = unref_function));
		ccall.add_argument (cvar);
		
		/* set freed references to NULL to prevent further use */
		var ccomma = new CCodeCommaExpression ();
		
		if (unref_function == "g_list_free") {
			bool is_ref = false;
			bool is_class = false;
			var type_args = type.get_type_arguments ();
			foreach (TypeReference type_arg in type_args) {
				is_ref = type_arg.is_ref;
				is_class = type_arg.type is Class;
			}
			
			if (is_ref) {
				var cunrefcall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_list_foreach"));
				cunrefcall.add_argument (cvar);
				if (is_class) {
					cunrefcall.add_argument (new CCodeIdentifier (name = "(GFunc) g_object_unref"));
				} else {
					cunrefcall.add_argument (new CCodeIdentifier (name = "(GFunc) g_free"));
				}
				cunrefcall.add_argument (new CCodeConstant (name = "NULL"));
				ccomma.append_expression (cunrefcall);
			}
		} else if (unref_function == "g_string_free") {
			ccall.add_argument (new CCodeConstant (name = "TRUE"));
		}
		
		ccomma.append_expression (ccall);
		ccomma.append_expression (new CCodeConstant (name = "NULL"));
		
		var cassign = new CCodeAssignment (left = cvar, right = ccomma);
		
		return new CCodeConditionalExpression (condition = cisnull, true_expression = new CCodeConstant (name = "NULL"), false_expression = new CCodeParenthesizedExpression (inner = cassign));
	}
	
	public override void visit_end_full_expression (Expression! expr) {
		if (!memory_management) {
			temp_vars = null;
			temp_ref_vars = null;
			return;
		}
	
		/* expr is a full expression, i.e. an initializer, the
		 * expression in an expression statement, the controlling
		 * expression in if, while, for, or foreach statements
		 *
		 * we unref temporary variables at the end of a full
		 * expression
		 */
		
		/* can't automatically deep copy lists yet, so do it
		 * manually for now
		 * replace with
		 * expr.temp_vars = temp_vars;
		 * when deep list copying works
		 */
		expr.temp_vars = null;
		foreach (VariableDeclarator decl1 in temp_vars) {
			expr.temp_vars.append (decl1);
		}
		temp_vars = null;

		if (temp_ref_vars == null) {
			/* nothing to do without temporary variables */
			return;
		}
		
		var full_expr_decl = get_temp_variable_declarator (expr.static_type);
		expr.temp_vars.append (full_expr_decl);
		
		var expr_list = new CCodeCommaExpression ();
		expr_list.append_expression (new CCodeAssignment (left = new CCodeIdentifier (name = full_expr_decl.name), right = expr.ccodenode));
		
		foreach (VariableDeclarator decl in temp_ref_vars) {
			expr_list.append_expression (get_unref_expression (new CCodeIdentifier (name = decl.name), decl.type_reference));
		}
		
		expr_list.append_expression (new CCodeIdentifier (name = full_expr_decl.name));
		
		expr.ccodenode = expr_list;
		
		temp_ref_vars = null;
	}
	
	private void append_temp_decl (CCodeFragment! cfrag, List<VariableDeclarator> temp_vars) {
		foreach (VariableDeclarator decl in temp_vars) {
			var cdecl = new CCodeDeclaration (type_name = decl.type_reference.get_cname (true));
		
			cdecl.add_declarator (new CCodeVariableDeclarator (name = decl.name));
			
			cfrag.append (cdecl);
		}
	}

	public override void visit_expression_statement (ExpressionStatement! stmt) {
		stmt.ccodenode = new CCodeExpressionStatement (expression = (CCodeExpression) stmt.expression.ccodenode);
		
		/* free temporary objects */
		if (!memory_management) {
			temp_vars = null;
			temp_ref_vars = null;
			return;
		}
		
		if (temp_vars == null) {
			/* nothing to do without temporary variables */
			return;
		}
		
		var cfrag = new CCodeFragment ();
		append_temp_decl (cfrag, temp_vars);
		
		cfrag.append (stmt.ccodenode);
		
		foreach (VariableDeclarator decl in temp_ref_vars) {
			cfrag.append (new CCodeExpressionStatement (expression = get_unref_expression (new CCodeIdentifier (name = decl.name), decl.type_reference)));
		}
		
		stmt.ccodenode = cfrag;
		
		temp_vars = null;
		temp_ref_vars = null;
	}
	
	private void create_temp_decl (Statement! stmt, List<VariableDeclarator> temp_vars) {
		/* declare temporary variables */
		
		if (temp_vars == null) {
			/* nothing to do without temporary variables */
			return;
		}
		
		var cfrag = new CCodeFragment ();
		append_temp_decl (cfrag, temp_vars);
		
		cfrag.append (stmt.ccodenode);
		
		stmt.ccodenode = cfrag;
	}

	public override void visit_if_statement (IfStatement! stmt) {
		if (stmt.false_statement != null) {
			stmt.ccodenode = new CCodeIfStatement (condition = (CCodeExpression) stmt.condition.ccodenode, true_statement = (CCodeStatement) stmt.true_statement.ccodenode, false_statement = (CCodeStatement) stmt.false_statement.ccodenode);
		} else {
			stmt.ccodenode = new CCodeIfStatement (condition = (CCodeExpression) stmt.condition.ccodenode, true_statement = (CCodeStatement) stmt.true_statement.ccodenode);
		}
		
		create_temp_decl (stmt, stmt.condition.temp_vars);
	}

	public override void visit_while_statement (WhileStatement! stmt) {
		stmt.ccodenode = new CCodeWhileStatement (condition = (CCodeExpression) stmt.condition.ccodenode, body = (CCodeStatement) stmt.body.ccodenode);
		
		create_temp_decl (stmt, stmt.condition.temp_vars);
	}

	public override void visit_for_statement (ForStatement! stmt) {
		var cfor = new CCodeForStatement (condition = (CCodeExpression) stmt.condition.ccodenode, body = (CCodeStatement) stmt.body.ccodenode);
		
		foreach (Expression init_expr in stmt.get_initializer ()) {
			cfor.add_initializer ((CCodeExpression) init_expr.ccodenode);
		}
		
		foreach (Expression it_expr in stmt.get_iterator ()) {
			cfor.add_iterator ((CCodeExpression) it_expr.ccodenode);
		}
		
		stmt.ccodenode = cfor;
		
		create_temp_decl (stmt, stmt.condition.temp_vars);
	}

	public override void visit_end_foreach_statement (ForeachStatement! stmt) {
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

	public override void visit_break_statement (BreakStatement! stmt) {
		stmt.ccodenode = new CCodeBreakStatement ();
	}

	public override void visit_continue_statement (ContinueStatement! stmt) {
		stmt.ccodenode = new CCodeContinueStatement ();
	}
	
	private void append_local_free (Symbol sym, CCodeFragment cfrag, bool stop_at_loop) {
		var b = (Block) sym.node;

		var local_vars = b.get_local_variables ();
		foreach (VariableDeclarator decl in local_vars) {
			if (decl.symbol.active && decl.type_reference.type.is_reference_type () && decl.type_reference.is_lvalue_ref) {
				cfrag.append (new CCodeExpressionStatement (expression = get_unref_expression (new CCodeIdentifier (name = decl.name), decl.type_reference)));
			}
		}
		
		if (sym.parent_symbol.node is Block) {
			append_local_free (sym.parent_symbol, cfrag, stop_at_loop);
		}
	}

	private void create_local_free (Statement stmt) {
		if (!memory_management) {
			return;
		}
		
		var cfrag = new CCodeFragment ();
	
		append_local_free (current_symbol, cfrag, false);

		cfrag.append (stmt.ccodenode);
		stmt.ccodenode = cfrag;
	}
	
	private bool append_local_free_expr (Symbol sym, CCodeCommaExpression ccomma, bool stop_at_loop) {
		var found = false;
	
		var b = (Block) sym.node;

		var local_vars = b.get_local_variables ();
		foreach (VariableDeclarator decl in local_vars) {
			if (decl.symbol.active && decl.type_reference.type.is_reference_type () && decl.type_reference.is_lvalue_ref) {
				found = true;
				ccomma.append_expression (get_unref_expression (new CCodeIdentifier (name = decl.name), decl.type_reference));
			}
		}
		
		if (sym.parent_symbol.node is Block) {
			found = found || append_local_free_expr (sym.parent_symbol, ccomma, stop_at_loop);
		}
		
		return found;
	}

	private void create_local_free_expr (Expression expr) {
		if (!memory_management) {
			return;
		}
		
		var return_expr_decl = get_temp_variable_declarator (expr.static_type);
		
		var ccomma = new CCodeCommaExpression ();
		ccomma.append_expression (new CCodeAssignment (left = new CCodeIdentifier (name = return_expr_decl.name), right = expr.ccodenode));

		if (!append_local_free_expr (current_symbol, ccomma, false)) {
			/* no local variables need to be freed */
			return;
		}

		ccomma.append_expression (new CCodeIdentifier (name = return_expr_decl.name));
		
		expr.ccodenode = ccomma;
		expr.temp_vars.append (return_expr_decl);
	}

	public override void visit_return_statement (ReturnStatement! stmt) {
		if (stmt.return_expression == null) {
			stmt.ccodenode = new CCodeReturnStatement ();
			
			create_local_free (stmt);
		} else {
			create_local_free_expr (stmt.return_expression);

			stmt.ccodenode = new CCodeReturnStatement (return_expression = (CCodeExpression) stmt.return_expression.ccodenode);
		
			create_temp_decl (stmt, stmt.return_expression.temp_vars);
		}
	}

	public override void visit_boolean_literal (BooleanLiteral! expr) {
		if (expr.value) {
			expr.ccodenode = new CCodeConstant (name = "TRUE");
		} else {
			expr.ccodenode = new CCodeConstant (name = "FALSE");
		}
	}

	public override void visit_character_literal (CharacterLiteral! expr) {
		expr.ccodenode = new CCodeConstant (name = expr.value);
	}

	public override void visit_integer_literal (IntegerLiteral! expr) {
		expr.ccodenode = new CCodeConstant (name = expr.value);
	}

	public override void visit_real_literal (RealLiteral! expr) {
		expr.ccodenode = new CCodeConstant (name = expr.value);
	}

	public override void visit_string_literal (StringLiteral! expr) {
		expr.ccodenode = new CCodeConstant (name = expr.value);
	}

	public override void visit_null_literal (NullLiteral! expr) {
		expr.ccodenode = new CCodeConstant (name = "NULL");
	}

	public override void visit_literal_expression (LiteralExpression! expr) {
		expr.ccodenode = expr.literal.ccodenode;
		
		visit_expression (expr);
	}
	
	private void process_cmember (MemberAccess! expr, CCodeExpression pub_inst, DataType base_type) {
		if (expr.symbol_reference.node is Method) {
			var m = (Method) expr.symbol_reference.node;
			if (!m.overrides) {
				expr.ccodenode = new CCodeIdentifier (name = m.get_cname ());
			} else {
				expr.ccodenode = new CCodeIdentifier (name = m.base_method.get_cname ());
			}
		} else if (expr.symbol_reference.node is Field) {
			var f = (Field) expr.symbol_reference.node;
			if (f.instance) {
				ref CCodeExpression typed_inst;
				if (f.symbol.parent_symbol.node != base_type) {
					typed_inst = new CCodeFunctionCall (call = new CCodeIdentifier (name = ((DataType) f.symbol.parent_symbol.node).get_upper_case_cname (null)));
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
				if (f.symbol.parent_symbol.node is DataType) {
					var t = (DataType) f.symbol.parent_symbol.node;
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
			
			/* explicitly use strong reference as ccast
			 * gets unrefed at the end of the inner block
			 */
			ref CCodeExpression typed_pub_inst = pub_inst;

			/* cast if necessary */
			if (prop.no_accessor_method) {
				var ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "G_OBJECT"));
				ccast.add_argument (pub_inst);
				typed_pub_inst = ccast;
			} else if (prop.symbol.parent_symbol.node != base_type) {
				var ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = ((DataType) prop.symbol.parent_symbol.node).get_upper_case_cname (null)));
				ccast.add_argument (pub_inst);
				typed_pub_inst = ccast;
			}

			ccall.add_argument (typed_pub_inst);
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
				if (p.type_reference.is_out || p.type_reference.is_ref) {
					expr.ccodenode = new CCodeIdentifier (name = "*%s".printf (p.name));
				} else {
					expr.ccodenode = new CCodeIdentifier (name = p.name);
				}
			}
		} else if (expr.symbol_reference.node is Signal) {
			var sig = (Signal) expr.symbol_reference.node;
			
			var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_signal_emit_by_name"));

			var ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = "G_OBJECT"));
			ccast.add_argument (pub_inst);
			ccall.add_argument (ccast);

			ccall.add_argument (new CCodeConstant (name = "\"%s\"".printf (sig.name)));
			
			expr.ccodenode = ccall;
		}
	}
	
	public override void visit_parenthesized_expression (ParenthesizedExpression! expr) {
		expr.ccodenode = new CCodeParenthesizedExpression (inner = (CCodeExpression) expr.inner.ccodenode);

		visit_expression (expr);
	}

	public override void visit_member_access (MemberAccess! expr) {
		CCodeExpression pub_inst = null;
		DataType base_type = null;
	
		if (expr.inner == null) {
			pub_inst = new CCodeIdentifier (name = "self");

			if (current_type_symbol != null) {
				/* base type is available if this is a type method */
				base_type = (DataType) current_type_symbol.node;
			}
		} else {
			pub_inst = (CCodeExpression) expr.inner.ccodenode;

			if (expr.inner.static_type != null) {
				base_type = expr.inner.static_type.type;
			}
		}

		process_cmember (expr, pub_inst, base_type);

		visit_expression (expr);
	}

	public override void visit_end_invocation_expression (InvocationExpression! expr) {
		var ccall = new CCodeFunctionCall (call = (CCodeExpression) expr.call.ccodenode);
		
		Method m = null;
		List<FormalParameter> params;
		
		if (!(expr.call is MemberAccess)) {
			expr.error = true;
			Report.error (expr.source_reference, "unsupported method invocation");
			return;
		}
		
		var ma = (MemberAccess) expr.call;
		
		if (expr.call.symbol_reference.node is VariableDeclarator) {
			var decl = (VariableDeclarator) expr.call.symbol_reference.node;
			var cb = (Callback) decl.type_reference.type;
			params = cb.get_parameters ();
		} else if (expr.call.symbol_reference.node is FormalParameter) {
			var param = (FormalParameter) expr.call.symbol_reference.node;
			var cb = (Callback) param.type_reference.type;
			params = cb.get_parameters ();
		} else if (expr.call.symbol_reference.node is Method) {
			m = (Method) expr.call.symbol_reference.node;
			params = m.get_parameters ();
		} else {
			var sig = (Signal) expr.call.symbol_reference.node;
			params = sig.get_parameters ();
			
			ccall = (CCodeFunctionCall) expr.call.ccodenode;
		}
		
		/* explicitly use strong reference as ccall gets unrefed
		 * at end of inner block
		 */
		ref CCodeExpression instance;
		if (m != null && m.instance) {
			var base_method = m;
			if (m.overrides) {
				base_method = m.base_method;
			}

			var req_cast = false;
			if (ma.inner == null) {
				instance = new CCodeIdentifier (name = "self");
				/* require casts for overriden and inherited methods */
				req_cast = m.overrides || (m.symbol.parent_symbol != current_type_symbol);
			} else {
				instance = (CCodeExpression) ma.inner.ccodenode;
				/* reqiure casts if the type of the used instance is
				 * different than the type which declared the method */
				req_cast = base_method.symbol.parent_symbol.node != ma.inner.static_type.type;
			}
			
			if (req_cast && ((DataType) m.symbol.parent_symbol.node).is_reference_type ()) {
				var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = ((DataType) base_method.symbol.parent_symbol.node).get_upper_case_cname (null)));
				ccall.add_argument (instance);
				instance = ccall;
			}
			
			if (!m.instance_last) {
				ccall.add_argument (instance);
			}
		}
		
		var i = 1;
		foreach (Expression arg in expr.argument_list) {
			/* explicitly use strong reference as ccall gets
			 * unrefed at end of inner block
			 */
			ref CCodeExpression cexpr = (CCodeExpression) arg.ccodenode;
			if (params != null) {
				var param = (FormalParameter) params.data;
				if (!param.ellipsis
				    && param.type_reference.type != null
				    && param.type_reference.type.is_reference_type ()
				    && arg.static_type.type != null
				    && param.type_reference.type != arg.static_type.type) {
					var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = param.type_reference.type.get_upper_case_cname (null)));
					ccall.add_argument (cexpr);
					cexpr = ccall;
				}
			}
		
			ccall.add_argument (cexpr);
			i++;
			
			if (params != null) {
				params = params.next;
			}
		}
		while (params != null) {
			var param = (FormalParameter) params.data;
			
			if (param.ellipsis) {
				break;
			}
			
			if (param.default_expression == null) {
				Report.error (expr.source_reference, "no default expression for argument %d".printf (i));
				return;
			}
			
			/* evaluate default expression here as the code
			 * generator might not have visited the formal
			 * parameter yet */
			param.default_expression.accept (this);
		
			ccall.add_argument ((CCodeExpression) param.default_expression.ccodenode);
			i++;
		
			params = params.next;
		}
		
		if (m != null && m.instance && m.instance_last) {
			ccall.add_argument (instance);
		}
		
		if (m != null && m.instance && m.returns_modified_pointer) {
			expr.ccodenode = new CCodeAssignment (left = instance, right = ccall);
		} else {
			expr.ccodenode = ccall;
		
			visit_expression (expr);
		}
	}

	public override void visit_postfix_expression (PostfixExpression! expr) {
		if (expr.increment) {
			expr.ccodenode = new CCodeUnaryExpression (operator = CCodeUnaryOperator.POSTFIX_INCREMENT, inner = expr.inner.ccodenode);
		} else {
			expr.ccodenode = new CCodeUnaryExpression (operator = CCodeUnaryOperator.POSTFIX_DECREMENT, inner = expr.inner.ccodenode);
		}
		
		visit_expression (expr);
	}
	
	private ref CCodeExpression get_ref_expression (Expression! expr) {
		/* (temp = expr, temp == NULL ? temp : ref (temp))
		 *
		 * can be simplified to
		 * ref (expr)
		 * if static type of expr is non-null
		 *
		 * can be simplified to
		 * (expr == NULL ? expr : ref (expr))
		 * if expr.ccodenode is CCodeSimpleName or CCodeMemberAccess
		 */
	
		var decl = get_temp_variable_declarator (expr.static_type);
		temp_vars.prepend (decl);

		var ctemp = new CCodeIdentifier (name = decl.name);
		
		var cisnull = new CCodeBinaryExpression (operator = CCodeBinaryOperator.EQUALITY, left = ctemp, right = new CCodeConstant (name = "NULL"));
		
		string ref_function;
		if (expr.static_type.type.is_reference_counting ()) {
			ref_function = expr.static_type.type.get_ref_function ();
		} else {
			ref_function = expr.static_type.type.get_dup_function ();
		}
	
		var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = ref_function));
		ccall.add_argument (ctemp);
		
		var ccomma = new CCodeCommaExpression ();
		ccomma.append_expression (new CCodeAssignment (left = ctemp, right = expr.ccodenode));
		ccomma.append_expression (new CCodeConditionalExpression (condition = cisnull, true_expression = ctemp, false_expression = ccall));

		return ccomma;
	}
	
	private void visit_expression (Expression! expr) {
		if (expr.static_type != null &&
		    expr.static_type.is_ref &&
		    expr.static_type.floating_reference) {
			/* constructor of GInitiallyUnowned subtype
			 * returns floating reference, sink it
			 */
			var csink = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_object_ref_sink"));
			csink.add_argument ((CCodeExpression) expr.ccodenode);
			
			expr.ccodenode = csink;
		}
	
		if (expr.ref_leaked) {
			var decl = get_temp_variable_declarator (expr.static_type);
			temp_vars.prepend (decl);
			temp_ref_vars.prepend (decl);
			expr.ccodenode = new CCodeParenthesizedExpression (inner = new CCodeAssignment (left = new CCodeIdentifier (name = decl.name), right = expr.ccodenode));
		} else if (expr.ref_missing) {
			expr.ccodenode = get_ref_expression (expr);
		}
	}

	public override void visit_object_creation_expression (ObjectCreationExpression! expr) {
		var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_object_new"));
		
		ccall.add_argument (new CCodeConstant (name = expr.type_reference.get_upper_case_cname ("TYPE_")));

		foreach (NamedArgument arg in expr.named_argument_list) {
			ccall.add_argument (new CCodeConstant (name = "\"%s\"".printf (arg.name)));
			ccall.add_argument ((CCodeExpression) arg.argument.ccodenode);
		}
		ccall.add_argument (new CCodeConstant (name = "NULL"));
		
		expr.ccodenode = ccall;
		
		visit_expression (expr);
	}

	public override void visit_typeof_expression (TypeofExpression! expr) {
		expr.ccodenode = new CCodeIdentifier (name = expr.type_reference.type.get_type_id ());
	}

	public override void visit_unary_expression (UnaryExpression! expr) {
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
		
		visit_expression (expr);
	}

	public override void visit_cast_expression (CastExpression! expr) {
		if (expr.type_reference.type is Struct || expr.type_reference.type is Enum || expr.type_reference.type is Flags) {
			expr.ccodenode = expr.inner.ccodenode;
		} else {
			expr.ccodenode = new InstanceCast (type_reference = expr.type_reference.type, inner = (CCodeExpression) expr.inner.ccodenode);
		}
		
		visit_expression (expr);
	}

	public override void visit_binary_expression (BinaryExpression! expr) {
		expr.ccodenode = new CCodeBinaryExpression (operator = expr.operator, left = expr.left.ccodenode, right = expr.right.ccodenode);
		
		visit_expression (expr);
	}

	public override void visit_type_check (TypeCheck! expr) {
		var ccheck = new CCodeFunctionCall (call = new CCodeIdentifier (name = expr.type_reference.type.get_upper_case_cname ("IS_")));
		ccheck.add_argument ((CCodeExpression) expr.expression.ccodenode);
		expr.ccodenode = ccheck;
	}

	public override void visit_conditional_expression (ConditionalExpression! expr) {
		expr.ccodenode = new CCodeConditionalExpression (condition = (CCodeExpression) expr.condition.ccodenode, true_expression = (CCodeExpression) expr.true_expression.ccodenode, false_expression = (CCodeExpression) expr.false_expression.ccodenode);
	}

	public override void visit_end_lambda_expression (LambdaExpression! l) {
		l.ccodenode = new CCodeIdentifier (name = l.method.get_cname ());
	}

	public override void visit_end_assignment (Assignment! a) {
		var ma = (MemberAccess) a.left;

		if (a.left.symbol_reference.node is Property) {
			var prop = (Property) a.left.symbol_reference.node;
			var cl = (Class) prop.symbol.parent_symbol.node;

			var set_func = "g_object_set";
			
			if (!prop.no_accessor_method) {
				set_func = "%s_set_%s".printf (cl.get_lower_case_cname (null), prop.name);
			}
			
			var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = set_func));

			/* target instance is first argument */
			ref CCodeExpression instance;
			var req_cast = false;

			if (ma.inner == null) {
				instance = new CCodeIdentifier (name = "self");
				/* require casts for inherited properties */
				req_cast = (prop.symbol.parent_symbol != current_type_symbol);
			} else {
				instance = (CCodeExpression) ma.inner.ccodenode;
				/* require casts if the type of the used instance is
				 * different than the type which declared the property */
				req_cast = prop.symbol.parent_symbol.node != ma.inner.static_type.type;
			}
			
			if (req_cast && ((DataType) prop.symbol.parent_symbol.node).is_reference_type ()) {
				var ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = ((DataType) prop.symbol.parent_symbol.node).get_upper_case_cname (null)));
				ccast.add_argument (instance);
				instance = ccast;
			}

			ccall.add_argument (instance);
				
			ref CCodeExpression cexpr = (CCodeExpression) a.right.ccodenode;
			
			if (prop.no_accessor_method) {
				/* property name is second argument of g_object_set */
				ccall.add_argument (prop.get_canonical_cconstant ());
			} else if (prop.type_reference.type != null
			    && prop.type_reference.type.is_reference_type ()
			    && a.right.static_type.type != null
			    && prop.type_reference.type != a.right.static_type.type) {
				/* cast is necessary */
				var ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = prop.type_reference.type.get_upper_case_cname (null)));
				ccast.add_argument (cexpr);
				cexpr = ccast;
			}
				
			ccall.add_argument (cexpr);
			
			if (prop.no_accessor_method) {
				ccall.add_argument (new CCodeConstant (name = "NULL"));
			}
			
			a.ccodenode = ccall;
		} else if (a.left.symbol_reference.node is Signal) {
			var sig = (Signal) a.left.symbol_reference.node;
			
			var m = (Method) a.right.symbol_reference.node;
			var connect_func = "g_signal_connect_object";
			if (!m.instance) {
				connect_func = "g_signal_connect";
			}

			var ccall = new CCodeFunctionCall (call = new CCodeIdentifier (name = connect_func));
		
			if (ma.inner != null) {
				ccall.add_argument ((CCodeExpression) ma.inner.ccodenode);
			} else {
				ccall.add_argument (new CCodeIdentifier (name = "self"));
			}

			ccall.add_argument (new CCodeConstant (name = "\"%s\"".printf (sig.name)));

			ccall.add_argument (new CCodeCastExpression (inner = new CCodeIdentifier (name = m.get_cname ()), type_name = "GCallback"));

			if (m.instance) {
				if (a.right is MemberAccess) {
					var right_ma = (MemberAccess) a.right;
					if (right_ma.inner != null) {
						ccall.add_argument ((CCodeExpression) right_ma.inner.ccodenode);
					} else {
						ccall.add_argument (new CCodeIdentifier (name = "self"));
					}
				} else if (a.right is LambdaExpression) {
					ccall.add_argument (new CCodeIdentifier (name = "self"));
				}
				ccall.add_argument (new CCodeConstant (name = "0"));
			} else {
				ccall.add_argument (new CCodeConstant (name = "NULL"));
			}
			
			a.ccodenode = ccall;
		} else {
			/* explicitly use strong reference as ccast gets
			 * unrefed at end of inner block
			 */
			ref CCodeExpression rhs = (CCodeExpression) a.right.ccodenode;
			
			if (a.left.static_type.type != null
			    && a.right.static_type.type != null
			    && a.left.static_type.type.is_reference_type ()
			    && a.right.static_type.type != a.left.static_type.type) {
				var ccast = new CCodeFunctionCall (call = new CCodeIdentifier (name = a.left.static_type.type.get_upper_case_cname (null)));
				ccast.add_argument (rhs);
				rhs = ccast;
			}
			
			if (memory_management && a.left.static_type.is_lvalue_ref) {
				/* unref old value */
				var ccomma = new CCodeCommaExpression ();
				
				var temp_decl = get_temp_variable_declarator (a.left.static_type);
				temp_vars.prepend (temp_decl);
				ccomma.append_expression (new CCodeAssignment (left = new CCodeIdentifier (name = temp_decl.name), right = rhs));
				ccomma.append_expression (get_unref_expression ((CCodeExpression) a.left.ccodenode, a.left.static_type));
				ccomma.append_expression (new CCodeIdentifier (name = temp_decl.name));
				
				rhs = ccomma;
			}
			
			var cop = CCodeAssignmentOperator.SIMPLE;
			if (a.operator == AssignmentOperator.BITWISE_OR) {
				cop = CCodeAssignmentOperator.BITWISE_OR;
			} else if (a.operator == AssignmentOperator.BITWISE_AND) {
				cop = CCodeAssignmentOperator.BITWISE_AND;
			} else if (a.operator == AssignmentOperator.BITWISE_XOR) {
				cop = CCodeAssignmentOperator.BITWISE_XOR;
			} else if (a.operator == AssignmentOperator.ADD) {
				cop = CCodeAssignmentOperator.ADD;
			} else if (a.operator == AssignmentOperator.SUB) {
				cop = CCodeAssignmentOperator.SUB;
			} else if (a.operator == AssignmentOperator.MUL) {
				cop = CCodeAssignmentOperator.MUL;
			} else if (a.operator == AssignmentOperator.DIV) {
				cop = CCodeAssignmentOperator.DIV;
			} else if (a.operator == AssignmentOperator.PERCENT) {
				cop = CCodeAssignmentOperator.PERCENT;
			} else if (a.operator == AssignmentOperator.SHIFT_LEFT) {
				cop = CCodeAssignmentOperator.SHIFT_LEFT;
			} else if (a.operator == AssignmentOperator.SHIFT_RIGHT) {
				cop = CCodeAssignmentOperator.SHIFT_RIGHT;
			}
		
			a.ccodenode = new CCodeAssignment (left = (CCodeExpression) a.left.ccodenode, right = rhs, operator = cop);
		}
	}
}
