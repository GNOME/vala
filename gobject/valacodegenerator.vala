/* valacodegenerator.vala
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

/**
 * Code visitor generating C Code.
 */
public class Vala.CodeGenerator : CodeVisitor {
	/**
	 * Specifies whether automatic memory management is active.
	 */
	public bool memory_management { get; set; }
	
	private CodeContext context;
	
	Symbol root_symbol;
	Symbol current_symbol;
	Symbol current_type_symbol;
	Class current_class;
	Method current_method;
	TypeReference current_return_type;
	TryStatement current_try;

	CCodeFragment header_begin;
	CCodeFragment header_type_declaration;
	CCodeFragment header_type_definition;
	CCodeFragment header_type_member_declaration;
	CCodeFragment source_begin;
	CCodeFragment source_include_directives;
	CCodeFragment source_type_member_declaration;
	CCodeFragment source_signal_marshaller_declaration;
	CCodeFragment source_type_member_definition;
	CCodeFragment instance_init_fragment;
	CCodeFragment instance_dispose_fragment;
	CCodeFragment source_signal_marshaller_definition;
	CCodeFragment module_init_fragment;
	
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
	/* cache to check whether a certain marshaller has been created yet */
	HashTable<string,bool> user_marshal_list;
	/* (constant) hash table with all predefined marshallers */
	HashTable<string,bool> predefined_marshal_list;
	/* (constant) hash table with all C keywords */
	HashTable<string,bool> c_keywords;
	
	private int next_temp_var_id = 0;
	private int current_try_id = 0;
	private int next_try_id = 0;
	private bool in_creation_method = false;
	private bool current_method_inner_error = false;

	TypeReference bool_type;
	TypeReference char_type;
	TypeReference unichar_type;
	TypeReference short_type;
	TypeReference ushort_type;
	TypeReference int_type;
	TypeReference uint_type;
	TypeReference long_type;
	TypeReference ulong_type;
	TypeReference int64_type;
	TypeReference uint64_type;
	TypeReference string_type;
	TypeReference float_type;
	TypeReference double_type;
	DataType glist_type;
	DataType gslist_type;
	DataType gstring_type;
	TypeReference mutex_type;
	DataType type_module_type;
	DataType iterable_type;
	DataType iterator_type;
	DataType list_type;
	DataType map_type;

	Method substring_method;

	private bool in_plugin = false;
	private string module_init_param_name;
	
	private bool string_h_needed;
	private bool requires_free_checked;
	private bool requires_array_free;

	public CodeGenerator (bool manage_memory = true) {
		memory_management = manage_memory;
	}
	
	construct {
		predefined_marshal_list = new HashTable (str_hash, str_equal);
		predefined_marshal_list.insert ("VOID:VOID", true);
		predefined_marshal_list.insert ("VOID:BOOLEAN", true);
		predefined_marshal_list.insert ("VOID:CHAR", true);
		predefined_marshal_list.insert ("VOID:UCHAR", true);
		predefined_marshal_list.insert ("VOID:INT", true);
		predefined_marshal_list.insert ("VOID:UINT", true);
		predefined_marshal_list.insert ("VOID:LONG", true);
		predefined_marshal_list.insert ("VOID:ULONG", true);
		predefined_marshal_list.insert ("VOID:ENUM", true);
		predefined_marshal_list.insert ("VOID:FLAGS", true);
		predefined_marshal_list.insert ("VOID:FLOAT", true);
		predefined_marshal_list.insert ("VOID:DOUBLE", true);
		predefined_marshal_list.insert ("VOID:STRING", true);
		predefined_marshal_list.insert ("VOID:POINTER", true);
		predefined_marshal_list.insert ("VOID:OBJECT", true);
		predefined_marshal_list.insert ("STRING:OBJECT,POINTER", true);
		predefined_marshal_list.insert ("VOID:UINT,POINTER", true);
		predefined_marshal_list.insert ("BOOLEAN:FLAGS", true);

		c_keywords = new HashTable (str_hash, str_equal);

		// C99 keywords
		c_keywords.insert ("_Bool", true);
		c_keywords.insert ("_Complex", true);
		c_keywords.insert ("_Imaginary", true);
		c_keywords.insert ("auto", true);
		c_keywords.insert ("break", true);
		c_keywords.insert ("case", true);
		c_keywords.insert ("char", true);
		c_keywords.insert ("const", true);
		c_keywords.insert ("continue", true);
		c_keywords.insert ("default", true);
		c_keywords.insert ("do", true);
		c_keywords.insert ("double", true);
		c_keywords.insert ("else", true);
		c_keywords.insert ("enum", true);
		c_keywords.insert ("extern", true);
		c_keywords.insert ("float", true);
		c_keywords.insert ("for", true);
		c_keywords.insert ("goto", true);
		c_keywords.insert ("if", true);
		c_keywords.insert ("inline", true);
		c_keywords.insert ("int", true);
		c_keywords.insert ("long", true);
		c_keywords.insert ("register", true);
		c_keywords.insert ("restrict", true);
		c_keywords.insert ("return", true);
		c_keywords.insert ("short", true);
		c_keywords.insert ("signed", true);
		c_keywords.insert ("sizeof", true);
		c_keywords.insert ("static", true);
		c_keywords.insert ("struct", true);
		c_keywords.insert ("switch", true);
		c_keywords.insert ("typedef", true);
		c_keywords.insert ("union", true);
		c_keywords.insert ("unsigned", true);
		c_keywords.insert ("void", true);
		c_keywords.insert ("volatile", true);
		c_keywords.insert ("while", true);

		// MSVC keywords
		c_keywords.insert ("cdecl", true);
	}

	/**
	 * Generate and emit C code for the specified code context.
	 *
	 * @param context a code context
	 */
	public void emit (CodeContext! context) {
		this.context = context;
	
		context.find_header_cycles ();

		root_symbol = context.root;

		bool_type = new TypeReference ();
		bool_type.data_type = (DataType) root_symbol.scope.lookup ("bool");

		char_type = new TypeReference ();
		char_type.data_type = (DataType) root_symbol.scope.lookup ("char");

		unichar_type = new TypeReference ();
		unichar_type.data_type = (DataType) root_symbol.scope.lookup ("unichar");

		short_type = new TypeReference ();
		short_type.data_type = (DataType) root_symbol.scope.lookup ("short");
		
		ushort_type = new TypeReference ();
		ushort_type.data_type = (DataType) root_symbol.scope.lookup ("ushort");

		int_type = new TypeReference ();
		int_type.data_type = (DataType) root_symbol.scope.lookup ("int");
		
		uint_type = new TypeReference ();
		uint_type.data_type = (DataType) root_symbol.scope.lookup ("uint");
		
		long_type = new TypeReference ();
		long_type.data_type = (DataType) root_symbol.scope.lookup ("long");
		
		ulong_type = new TypeReference ();
		ulong_type.data_type = (DataType) root_symbol.scope.lookup ("ulong");

		int64_type = new TypeReference ();
		int64_type.data_type = (DataType) root_symbol.scope.lookup ("int64");
		
		uint64_type = new TypeReference ();
		uint64_type.data_type = (DataType) root_symbol.scope.lookup ("uint64");
		
		float_type = new TypeReference ();
		float_type.data_type = (DataType) root_symbol.scope.lookup ("float");

		double_type = new TypeReference ();
		double_type.data_type = (DataType) root_symbol.scope.lookup ("double");

		string_type = new TypeReference ();
		string_type.data_type = (DataType) root_symbol.scope.lookup ("string");
		substring_method = (Method) string_type.data_type.scope.lookup ("substring");

		var glib_ns = root_symbol.scope.lookup ("GLib");
		
		glist_type = (DataType) glib_ns.scope.lookup ("List");
		gslist_type = (DataType) glib_ns.scope.lookup ("SList");
		gstring_type = (DataType) glib_ns.scope.lookup ("String");
		
		mutex_type = new TypeReference ();
		mutex_type.data_type = (DataType) glib_ns.scope.lookup ("Mutex");
		
		type_module_type = (DataType) glib_ns.scope.lookup ("TypeModule");

		if (context.module_init_method != null) {
			module_init_fragment = new CCodeFragment ();
			foreach (FormalParameter parameter in context.module_init_method.get_parameters ()) {
				if (parameter.type_reference.data_type == type_module_type) {
					in_plugin = true;
					module_init_param_name = parameter.name;
					break;
				}
			}
		}

		var gee_ns = root_symbol.scope.lookup ("Gee");
		if (gee_ns != null) {
			iterable_type = (DataType) gee_ns.scope.lookup ("Iterable");
			iterator_type = (DataType) gee_ns.scope.lookup ("Iterator");
			list_type = (DataType) gee_ns.scope.lookup ("List");
			map_type = (DataType) gee_ns.scope.lookup ("Map");
		}
	
		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (!file.pkg) {
				file.accept (this);
			}
		}
	}

	public override void visit_enum (Enum! en) {
		cenum = new CCodeEnum (en.get_cname ());

		if (en.source_reference.comment != null) {
			header_type_definition.append (new CCodeComment (en.source_reference.comment));
		}
		header_type_definition.append (cenum);

		en.accept_children (this);

		if (en.error_domain) {
			string quark_fun_name = en.get_lower_case_cprefix () + "quark";

			var error_domain_define = new CCodeMacroReplacement (en.get_upper_case_cname (), quark_fun_name + " ()");
			header_type_definition.append (error_domain_define);

			var cquark_fun = new CCodeFunction (quark_fun_name, "GQuark");
			var cquark_block = new CCodeBlock ();

			var cquark_call = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
			cquark_call.add_argument (new CCodeConstant ("\"" + en.get_lower_case_cname () + "-quark\""));

			cquark_block.add_statement (new CCodeReturnStatement (cquark_call));

			header_type_member_declaration.append (cquark_fun.copy ());

			cquark_fun.block = cquark_block;
			source_type_member_definition.append (cquark_fun);
		}
	}

	public override void visit_enum_value (EnumValue! ev) {
		string val;
		if (ev.value is LiteralExpression) {
			var lit = ((LiteralExpression) ev.value).literal;
			if (lit is IntegerLiteral) {
				val = ((IntegerLiteral) lit).value;
			}
		}
		cenum.add_value (ev.get_cname (), val);
	}

	public override void visit_callback (Callback! cb) {
		cb.accept_children (this);

		var cfundecl = new CCodeFunctionDeclarator (cb.get_cname ());
		foreach (FormalParameter param in cb.get_parameters ()) {
			cfundecl.add_parameter ((CCodeFormalParameter) param.ccodenode);
		}
		
		var ctypedef = new CCodeTypeDefinition (cb.return_type.get_cname (), cfundecl);
		
		if (cb.access != MemberAccessibility.PRIVATE) {
			header_type_definition.append (ctypedef);
		} else {
			source_type_member_declaration.append (ctypedef);
		}
	}
	
	public override void visit_member (Member! m) {
		/* stuff meant for all lockable members */
		if (m is Lockable && ((Lockable)m).get_lock_used ()) {
			instance_priv_struct.add_field (mutex_type.get_cname (), get_symbol_lock_name (m));
			
			instance_init_fragment.append (
				new CCodeExpressionStatement (
					new CCodeAssignment (
						new CCodeMemberAccess.pointer (
							new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"),
							get_symbol_lock_name (m)),
					new CCodeFunctionCall (new CCodeIdentifier (((Struct)mutex_type.data_type).default_construction_method.get_cname ())))));
			
			requires_free_checked = true;
			var fc = new CCodeFunctionCall (new CCodeIdentifier ("VALA_FREE_CHECKED"));
			fc.add_argument (
				new CCodeMemberAccess.pointer (
					new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"),
					get_symbol_lock_name (m)));
			fc.add_argument (new CCodeIdentifier (mutex_type.data_type.get_free_function ()));
			if (instance_dispose_fragment != null) {
				instance_dispose_fragment.append (new CCodeExpressionStatement (fc));
			}
		}
	}

	public override void visit_constant (Constant! c) {
		c.accept_children (this);

		if (c.parent_symbol is DataType) {
			var t = (DataType) c.parent_symbol;
			var cdecl = new CCodeDeclaration (c.type_reference.get_const_cname ());
			var arr = "";
			if (c.type_reference.data_type is Array) {
				arr = "[]";
			}
			cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("%s%s".printf (c.get_cname (), arr), (CCodeExpression) c.initializer.ccodenode));
			cdecl.modifiers = CCodeModifiers.STATIC;
			
			if (c.access != MemberAccessibility.PRIVATE) {
				header_type_member_declaration.append (cdecl);
			} else {
				source_type_member_declaration.append (cdecl);
			}
		}
	}
	
	public override void visit_field (Field! f) {
		f.accept_children (this);

		CCodeExpression lhs = null;
		CCodeStruct st = null;
		
		if (f.access != MemberAccessibility.PRIVATE) {
			st = instance_struct;
			if (f.instance) {
				lhs = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), f.get_cname ());
			}
		} else if (f.access == MemberAccessibility.PRIVATE) {
			if (f.instance) {
				st = instance_priv_struct;
				lhs = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), f.get_cname ());
			} else {
				if (f.parent_symbol is DataType) {
					var t = (DataType) f.parent_symbol;
					var cdecl = new CCodeDeclaration (f.type_reference.get_cname ());
					var var_decl = new CCodeVariableDeclarator (f.get_cname ());
					if (f.initializer != null) {
						var_decl.initializer = (CCodeExpression) f.initializer.ccodenode;
					}
					cdecl.add_declarator (var_decl);
					cdecl.modifiers = CCodeModifiers.STATIC;
					source_type_member_declaration.append (cdecl);
				}
			}
		}

		if (f.instance)  {
			st.add_field (f.type_reference.get_cname (), f.get_cname ());
			if (f.type_reference.data_type is Array && !f.no_array_length) {
				// create fields to store array dimensions
				var arr = (Array) f.type_reference.data_type;
				
				for (int dim = 1; dim <= arr.rank; dim++) {
					var len_type = new TypeReference ();
					len_type.data_type = int_type.data_type;

					st.add_field (len_type.get_cname (), get_array_length_cname (f.name, dim));
				}
			}

			if (f.initializer != null) {
				instance_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (lhs, (CCodeExpression) f.initializer.ccodenode)));
				
				if (f.type_reference.data_type is Array && !f.no_array_length &&
				    f.initializer is ArrayCreationExpression) {
					var ma = new MemberAccess.simple (f.name);
					ma.symbol_reference = f;
					
					var array_len_lhs = get_array_length_cexpression (ma, 1);
					var sizes = ((ArrayCreationExpression) f.initializer).get_sizes ();
					var size = (Expression) sizes.data;
					instance_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (array_len_lhs, (CCodeExpression) size.ccodenode)));
				}
			}
			
			if (f.type_reference.takes_ownership && instance_dispose_fragment != null) {
				var ma = new MemberAccess.simple (f.name);
				ma.symbol_reference = f;
				instance_dispose_fragment.append (new CCodeExpressionStatement (get_unref_expression (lhs, f.type_reference, ma)));
			}
		}
	}

	public override void visit_formal_parameter (FormalParameter! p) {
		p.accept_children (this);

		if (!p.ellipsis) {
			p.ccodenode = new CCodeFormalParameter (p.name, p.type_reference.get_cname (false, !p.type_reference.takes_ownership));
		}
	}

	public override void visit_property (Property! prop) {
		prop.accept_children (this);

		if (prop.parent_symbol is Class) {
			prop_enum.add_value (prop.get_upper_case_cname (), null);
		}
	}

	public override void visit_property_accessor (PropertyAccessor! acc) {
		var prop = (Property) acc.prop;
		
		if (acc.readable) {
			current_return_type = prop.type_reference;
		} else {
			// void
			current_return_type = new TypeReference ();
		}

		acc.accept_children (this);

		current_return_type = null;

		var t = (DataType) prop.parent_symbol;

		var this_type = new TypeReference ();
		this_type.data_type = t;
		var cselfparam = new CCodeFormalParameter ("self", this_type.get_cname ());
		var cvalueparam = new CCodeFormalParameter ("value", prop.type_reference.get_cname (false, true));

		if (prop.is_abstract || prop.is_virtual) {
			if (acc.readable) {
				function = new CCodeFunction ("%s_get_%s".printf (t.get_lower_case_cname (null), prop.name), prop.type_reference.get_cname ());
			} else {
				function = new CCodeFunction ("%s_set_%s".printf (t.get_lower_case_cname (null), prop.name), "void");
			}
			function.add_parameter (cselfparam);
			if (acc.writable || acc.construction) {
				function.add_parameter (cvalueparam);
			}
			
			if (t.access != MemberAccessibility.PRIVATE) {
				header_type_member_declaration.append (function.copy ());
			} else {
				function.modifiers |= CCodeModifiers.STATIC;
				source_type_member_declaration.append (function.copy ());
			}
			
			var block = new CCodeBlock ();
			function.block = block;

			if (acc.readable) {
				// declare temporary variable to save the property value
				var decl = new CCodeDeclaration (prop.type_reference.get_cname ());
				decl.add_declarator (new CCodeVariableDeclarator ("value"));
				block.add_statement (decl);
			
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_get"));
			
				var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT"));
				ccast.add_argument (new CCodeIdentifier ("self"));
				ccall.add_argument (ccast);
				
				// property name is second argument of g_object_get
				ccall.add_argument (prop.get_canonical_cconstant ());

				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("value")));

				ccall.add_argument (new CCodeConstant ("NULL"));
				
				block.add_statement (new CCodeExpressionStatement (ccall));
				block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("value")));
			} else {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_set"));
			
				var ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT"));
				ccast.add_argument (new CCodeIdentifier ("self"));
				ccall.add_argument (ccast);
				
				// property name is second argument of g_object_set
				ccall.add_argument (prop.get_canonical_cconstant ());

				ccall.add_argument (new CCodeIdentifier ("value"));

				ccall.add_argument (new CCodeConstant ("NULL"));
				
				block.add_statement (new CCodeExpressionStatement (ccall));
			}

			source_type_member_definition.append (function);
		}

		if (!prop.is_abstract) {
			bool is_virtual = prop.base_property != null || prop.base_interface_property != null;

			string prefix = t.get_lower_case_cname (null);
			if (is_virtual) {
				prefix += "_real";
			}
			if (acc.readable) {
				function = new CCodeFunction ("%s_get_%s".printf (prefix, prop.name), prop.type_reference.get_cname ());
			} else {
				function = new CCodeFunction ("%s_set_%s".printf (prefix, prop.name), "void");
			}
			if (is_virtual) {
				function.modifiers |= CCodeModifiers.STATIC;
			}
			function.add_parameter (cselfparam);
			if (acc.writable || acc.construction) {
				function.add_parameter (cvalueparam);
			}

			if (!is_virtual) {
				if (t.access != MemberAccessibility.PRIVATE) {
					header_type_member_declaration.append (function.copy ());
				} else {
					function.modifiers |= CCodeModifiers.STATIC;
					source_type_member_declaration.append (function.copy ());
				}
			}
			
			if (acc.body != null) {
				function.block = (CCodeBlock) acc.body.ccodenode;

				function.block.prepend_statement (create_property_type_check_statement (prop, acc.readable, t, true, "self"));
			}
			
			source_type_member_definition.append (function);
		}
	}

	public override void visit_constructor (Constructor! c) {
		current_method_inner_error = false;

		c.accept_children (this);

		var cl = (Class) c.parent_symbol;
	
		function = new CCodeFunction ("%s_constructor".printf (cl.get_lower_case_cname (null)), "GObject *");
		function.modifiers = CCodeModifiers.STATIC;
		
		function.add_parameter (new CCodeFormalParameter ("type", "GType"));
		function.add_parameter (new CCodeFormalParameter ("n_construct_properties", "guint"));
		function.add_parameter (new CCodeFormalParameter ("construct_properties", "GObjectConstructParam *"));
		
		source_type_member_declaration.append (function.copy ());


		var cblock = new CCodeBlock ();
		var cdecl = new CCodeDeclaration ("GObject *");
		cdecl.add_declarator (new CCodeVariableDeclarator ("obj"));
		cblock.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("%sClass *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator ("klass"));
		cblock.add_statement (cdecl);

		cdecl = new CCodeDeclaration ("GObjectClass *");
		cdecl.add_declarator (new CCodeVariableDeclarator ("parent_class"));
		cblock.add_statement (cdecl);


		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_peek"));
		ccall.add_argument (new CCodeIdentifier (cl.get_upper_case_cname ("TYPE_")));
		var ccast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (cl.get_upper_case_cname (null))));
		ccast.add_argument (ccall);
		cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("klass"), ccast)));

		ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_class_peek_parent"));
		ccall.add_argument (new CCodeIdentifier ("klass"));
		ccast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_CLASS"));
		ccast.add_argument (ccall);
		cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("parent_class"), ccast)));

		
		ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (new CCodeIdentifier ("parent_class"), "constructor"));
		ccall.add_argument (new CCodeIdentifier ("type"));
		ccall.add_argument (new CCodeIdentifier ("n_construct_properties"));
		ccall.add_argument (new CCodeIdentifier ("construct_properties"));
		cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("obj"), ccall)));


		ccall = new CCodeFunctionCall (new CCodeIdentifier (cl.get_upper_case_cname (null)));
		ccall.add_argument (new CCodeIdentifier ("obj"));
		
		cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
		
		cblock.add_statement (cdecl);

		if (current_method_inner_error) {
			/* always separate error parameter and inner_error local variable
			 * as error may be set to NULL but we're always interested in inner errors
			 */
			var cdecl = new CCodeDeclaration ("GError *");
			cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("inner_error", new CCodeConstant ("NULL")));
			cblock.add_statement (cdecl);
		}


		cblock.add_statement (c.body.ccodenode);
		
		cblock.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("obj")));
		
		function.block = cblock;

		if (c.source_reference.comment != null) {
			source_type_member_definition.append (new CCodeComment (c.source_reference.comment));
		}
		source_type_member_definition.append (function);
	}

	public override void visit_destructor (Destructor! d) {
		d.accept_children (this);
	}

	public override void visit_begin_block (Block! b) {
		current_symbol = b;
	}

	private void add_object_creation (CCodeBlock! b, bool has_params) {
		var cl = (Class) current_type_symbol;
	
		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_newv"));
		ccall.add_argument (new CCodeConstant (cl.get_type_id ()));
		if (has_params) {
			ccall.add_argument (new CCodeConstant ("__params_it - __params"));
			ccall.add_argument (new CCodeConstant ("__params"));
		} else {
			ccall.add_argument (new CCodeConstant ("0"));
			ccall.add_argument (new CCodeConstant ("NULL"));
		}
		
		var cdecl = new CCodeVariableDeclarator ("self");
		cdecl.initializer = ccall;
		
		var cdeclaration = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdeclaration.add_declarator (cdecl);
		
		b.add_statement (cdeclaration);
	}

	public override void visit_end_block (Block! b) {
		var local_vars = b.get_local_variables ();
		foreach (VariableDeclarator decl in local_vars) {
			decl.active = false;
		}
		
		var cblock = new CCodeBlock ();
		
		foreach (CodeNode stmt in b.get_statements ()) {
			var src = stmt.source_reference;
			if (src != null && src.comment != null) {
				cblock.add_statement (new CCodeComment (src.comment));
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
				if (decl.type_reference.takes_ownership) {
					var ma = new MemberAccess.simple (decl.name);
					ma.symbol_reference = decl;
					cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (get_variable_cname (decl.name)), decl.type_reference, ma)));
				}
			}
		}
		
		b.ccodenode = cblock;

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_empty_statement (EmptyStatement! stmt) {
		stmt.ccodenode = new CCodeEmptyStatement ();
	}
	
	private bool struct_has_instance_fields (Struct! st) {
		foreach (Field f in st.get_fields ()) {
			if (f.instance) {
				return true;
			}
		}
		
		return false;
	}

	public override void visit_declaration_statement (DeclarationStatement! stmt) {
		/* split declaration statement as var declarators
		 * might have different types */
	
		var cfrag = new CCodeFragment ();
		
		foreach (VariableDeclarator decl in stmt.declaration.get_variable_declarators ()) {
			var cdecl = new CCodeDeclaration (decl.type_reference.get_cname (false, !decl.type_reference.takes_ownership));
		
			cdecl.add_declarator ((CCodeVariableDeclarator) decl.ccodenode);

			cfrag.append (cdecl);

			if (decl.initializer != null && decl.initializer.can_fail) {
				add_simple_check (decl.initializer, cfrag);
			}

			/* try to initialize uninitialized variables */
			if (decl.initializer == null && decl.type_reference.data_type is Struct) {
				if (decl.type_reference.data_type.is_reference_type ()) {
					((CCodeVariableDeclarator) decl.ccodenode).initializer = new CCodeConstant ("NULL");
				} else if (decl.type_reference.data_type.get_default_value () != null) {
					((CCodeVariableDeclarator) decl.ccodenode).initializer = new CCodeConstant (decl.type_reference.data_type.get_default_value ());
				} else if (decl.type_reference.data_type is Struct &&
				           struct_has_instance_fields ((Struct) decl.type_reference.data_type)) {
					var st = (Struct) decl.type_reference.data_type;

					/* memset needs string.h */
					string_h_needed = true;

					var czero = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
					czero.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (get_variable_cname (decl.name))));
					czero.add_argument (new CCodeConstant ("0"));
					czero.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (decl.type_reference.get_cname ())));

					cfrag.append (new CCodeExpressionStatement (czero));
				} else {
					Report.warning (decl.source_reference, "unable to initialize a variable of type `%s'".printf (decl.type_reference.data_type.get_full_name ()));
				}
			}
		}
		
		stmt.ccodenode = cfrag;

		foreach (VariableDeclarator decl in stmt.declaration.get_variable_declarators ()) {
			if (decl.initializer != null) {
				create_temp_decl (stmt, decl.initializer.temp_vars);
			}
		}

		create_temp_decl (stmt, temp_vars);
		temp_vars = null;
	}

	private string! get_variable_cname (string! name) {
		if (c_keywords.lookup (name)) {
			return name + "_";
		} else {
			return name;
		}
	}

	public override void visit_variable_declarator (VariableDeclarator! decl) {
		if (decl.type_reference.data_type is Array) {
			// create variables to store array dimensions
			var arr = (Array) decl.type_reference.data_type;
			
			for (int dim = 1; dim <= arr.rank; dim++) {
				var len_decl = new VariableDeclarator (get_array_length_cname (decl.name, dim));
				len_decl.type_reference = new TypeReference ();
				len_decl.type_reference.data_type = int_type.data_type;

				temp_vars.prepend (len_decl);
			}
		}
	
		CCodeExpression rhs = null;
		if (decl.initializer != null) {
			rhs = (CCodeExpression) decl.initializer.ccodenode;
			
			if (decl.type_reference.data_type != null
			    && decl.initializer.static_type.data_type != null
			    && decl.type_reference.data_type.is_reference_type ()
			    && decl.initializer.static_type.data_type != decl.type_reference.data_type) {
				// FIXME: use C cast if debugging disabled
				rhs = new InstanceCast (rhs, decl.type_reference.data_type);
			}

			if (decl.type_reference.data_type is Array) {
				var arr = (Array) decl.type_reference.data_type;

				var ccomma = new CCodeCommaExpression ();

				var temp_decl = get_temp_variable_declarator (decl.type_reference);
				temp_vars.prepend (temp_decl);
				ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_decl.name), rhs));

				for (int dim = 1; dim <= arr.rank; dim++) {
					var lhs_array_len = new CCodeIdentifier (get_array_length_cname (decl.name, dim));
					var rhs_array_len = get_array_length_cexpression (decl.initializer, dim);
					ccomma.append_expression (new CCodeAssignment (lhs_array_len, rhs_array_len));
				}
				
				ccomma.append_expression (new CCodeIdentifier (temp_decl.name));
				
				rhs = ccomma;
			}
		} else if (decl.type_reference.data_type != null && decl.type_reference.data_type.is_reference_type ()) {
			rhs = new CCodeConstant ("NULL");
		}
			
		decl.ccodenode = new CCodeVariableDeclarator.with_initializer (get_variable_cname (decl.name), rhs);

		decl.active = true;
	}

	public override void visit_end_initializer_list (InitializerList! list) {
		if (list.expected_type != null && list.expected_type.data_type is Array) {
			/* TODO */
		} else {
			var clist = new CCodeInitializerList ();
			foreach (Expression expr in list.get_initializers ()) {
				clist.append ((CCodeExpression) expr.ccodenode);
			}
			list.ccodenode = clist;
		}
	}
	
	private VariableDeclarator get_temp_variable_declarator (TypeReference! type, bool takes_ownership = true) {
		var decl = new VariableDeclarator ("__temp%d".printf (next_temp_var_id));
		decl.type_reference = type.copy ();
		decl.type_reference.is_ref = false;
		decl.type_reference.is_out = false;
		decl.type_reference.takes_ownership = takes_ownership;
		
		next_temp_var_id++;
		
		return decl;
	}

	private CCodeExpression get_dup_func_expression (TypeReference! type) {
		if (type.data_type != null) {
			string dup_function;
			if (type.data_type.is_reference_counting ()) {
				dup_function = type.data_type.get_ref_function ();
			} else {
				if (type.data_type != string_type.data_type) {
					// duplicating non-reference counted structs may cause side-effects (and performance issues)
					Report.warning (type.source_reference, "duplicating %s instance, use weak variable or explicitly invoke copy method".printf (type.data_type.name));
				}
				dup_function = type.data_type.get_dup_function ();
			}
			return new CCodeIdentifier (dup_function);
		} else if (type.type_parameter != null && current_type_symbol is Class) {
			string func_name = "%s_dup_func".printf (type.type_parameter.name.down ());
			return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	private CCodeExpression get_destroy_func_expression (TypeReference! type) {
		if (type.data_type != null) {
			string unref_function;
			if (type.data_type.is_reference_counting ()) {
				unref_function = type.data_type.get_unref_function ();
			} else {
				unref_function = type.data_type.get_free_function ();
			}
			return new CCodeIdentifier (unref_function);
		} else if (type.type_parameter != null && current_type_symbol is Class) {
			string func_name = "%s_destroy_func".printf (type.type_parameter.name.down ());
			return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	private CCodeExpression get_unref_expression (CCodeExpression! cvar, TypeReference! type, Expression expr) {
		/* (foo == NULL ? NULL : foo = (unref (foo), NULL)) */
		
		/* can be simplified to
		 * foo = (unref (foo), NULL)
		 * if foo is of static type non-null
		 */

		if (type.is_null) {
			return new CCodeConstant ("NULL");
		}

		var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, cvar, new CCodeConstant ("NULL"));
		if (type.data_type == null) {
			if (!(current_type_symbol is Class)) {
				return new CCodeConstant ("NULL");
			}

			// unref functions are optional for type parameters
			var cunrefisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, get_destroy_func_expression (type), new CCodeConstant ("NULL"));
			cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cisnull, cunrefisnull);
		}

		var ccall = new CCodeFunctionCall (get_destroy_func_expression (type));
		ccall.add_argument (cvar);
		
		/* set freed references to NULL to prevent further use */
		var ccomma = new CCodeCommaExpression ();

		if (type.data_type == glist_type) {
			bool is_ref = false;
			bool is_class = false;
			bool is_interface = false;

			foreach (TypeReference type_arg in type.get_type_arguments ()) {
				is_ref |= type_arg.takes_ownership;
				is_class |= type_arg.data_type is Class;
				is_interface |= type_arg.data_type is Interface;
			}
			
			if (is_ref) {
				var cunrefcall = new CCodeFunctionCall (new CCodeIdentifier ("g_list_foreach"));
				cunrefcall.add_argument (cvar);
				if (is_class || is_interface) {
					cunrefcall.add_argument (new CCodeIdentifier ("(GFunc) g_object_unref"));
				} else {
					cunrefcall.add_argument (new CCodeIdentifier ("(GFunc) g_free"));
				}
				cunrefcall.add_argument (new CCodeConstant ("NULL"));
				ccomma.append_expression (cunrefcall);
			}
		} else if (type.data_type == gstring_type) {
			ccall.add_argument (new CCodeConstant ("TRUE"));
		} else if (type.data_type is Array) {
			var arr = (Array) type.data_type;
			if (arr.element_type == string_type.data_type) {
				ccall.call = new CCodeIdentifier ("g_strfreev");
			} else if (arr.element_type == null || arr.element_type.is_reference_type ()) {
				requires_array_free = true;

				bool first = true;
				CCodeExpression csizeexpr = null;
				for (int dim = 1; dim <= arr.rank; dim++) {
					if (first) {
						csizeexpr = get_array_length_cexpression (expr, dim);
						first = false;
					} else {
						csizeexpr = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, csizeexpr, get_array_length_cexpression (expr, dim));
					}
				}

				ccall.call = new CCodeIdentifier ("_vala_array_free");
				ccall.add_argument (csizeexpr);
				var element_type = new TypeReference ();
				element_type.data_type = arr.element_type;
				element_type.type_parameter = arr.element_type_parameter;
				ccall.add_argument (new CCodeCastExpression (get_destroy_func_expression (element_type), "GDestroyNotify"));
			}
		}
		
		ccomma.append_expression (ccall);
		ccomma.append_expression (new CCodeConstant ("NULL"));
		
		var cassign = new CCodeAssignment (cvar, ccomma);

		// g_free (NULL) is allowed
		if (type.non_null || (type.data_type != null && !type.data_type.is_reference_counting () && type.data_type.get_free_function () == "g_free")) {
			return new CCodeParenthesizedExpression (cassign);
		}

		return new CCodeConditionalExpression (cisnull, new CCodeConstant ("NULL"), new CCodeParenthesizedExpression (cassign));
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
		expr_list.append_expression (new CCodeAssignment (new CCodeIdentifier (full_expr_decl.name), (CCodeExpression) expr.ccodenode));
		
		foreach (VariableDeclarator decl in temp_ref_vars) {
			var ma = new MemberAccess.simple (decl.name);
			ma.symbol_reference = decl;
			expr_list.append_expression (get_unref_expression (new CCodeIdentifier (decl.name), decl.type_reference, ma));
		}
		
		expr_list.append_expression (new CCodeIdentifier (full_expr_decl.name));
		
		expr.ccodenode = expr_list;
		
		temp_ref_vars = null;
	}
	
	private void append_temp_decl (CCodeFragment! cfrag, List<VariableDeclarator> temp_vars) {
		foreach (VariableDeclarator decl in temp_vars) {
			var cdecl = new CCodeDeclaration (decl.type_reference.get_cname (true, !decl.type_reference.takes_ownership));
		
			var vardecl = new CCodeVariableDeclarator (decl.name);
			cdecl.add_declarator (vardecl);
			
			if (decl.type_reference.data_type != null && decl.type_reference.data_type.is_reference_type ()) {
				vardecl.initializer = new CCodeConstant ("NULL");
			}
			
			cfrag.append (cdecl);
		}
	}

	private void add_simple_check (CodeNode! node, CCodeFragment! cfrag) {
		var cprint_frag = new CCodeFragment ();
		var ccritical = new CCodeFunctionCall (new CCodeIdentifier ("g_critical"));
		ccritical.add_argument (new CCodeConstant ("\"file %s: line %d: uncaught error: %s\""));
		ccritical.add_argument (new CCodeConstant ("__FILE__"));
		ccritical.add_argument (new CCodeConstant ("__LINE__"));
		ccritical.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("inner_error"), "message"));
		cprint_frag.append (new CCodeExpressionStatement (ccritical));
		var cclear = new CCodeFunctionCall (new CCodeIdentifier ("g_clear_error"));
		cclear.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("inner_error")));
		cprint_frag.append (new CCodeExpressionStatement (cclear));

		if (current_try != null) {
			// surrounding try found
			// TODO might be the wrong one when using nested try statements

			var cerror_block = new CCodeBlock ();
			foreach (CatchClause clause in current_try.get_catch_clauses ()) {
				// go to catch clause if error domain matches
				var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeMemberAccess.pointer (new CCodeIdentifier ("inner_error"), "domain"), new CCodeIdentifier (clause.type_reference.data_type.get_upper_case_cname ()));

				var cgoto_block = new CCodeBlock ();
				cgoto_block.add_statement (new CCodeGotoStatement ("__catch%d_%s".printf (current_try_id, clause.type_reference.data_type.get_lower_case_cname ())));

				cerror_block.add_statement (new CCodeIfStatement (ccond, cgoto_block));
			}
			// print critical message if no catch clause matches
			cerror_block.add_statement (cprint_frag);

			// check error domain if expression failed
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("inner_error"), new CCodeConstant ("NULL"));

			cfrag.append (new CCodeIfStatement (ccond, cerror_block));
		} else if (current_method != null && current_method.get_error_domains ().length () > 0) {
			// current method can fail, propagate error
			// TODO ensure one of the error domains matches

			var cpropagate = new CCodeFunctionCall (new CCodeIdentifier ("g_propagate_error"));
			cpropagate.add_argument (new CCodeIdentifier ("error"));
			cpropagate.add_argument (new CCodeIdentifier ("inner_error"));

			var cerror_block = new CCodeBlock ();
			cerror_block.add_statement (new CCodeExpressionStatement (cpropagate));

			if (current_return_type != null && current_return_type.data_type != null) {
				cerror_block.add_statement (new CCodeReturnStatement (default_value_for_type (current_return_type.data_type)));
			} else {
				cerror_block.add_statement (new CCodeReturnStatement ());
			}

			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("inner_error"), new CCodeConstant ("NULL"));

			cfrag.append (new CCodeIfStatement (ccond, cerror_block));
		} else {
			// TODO improve check and move to semantic analyzer
			Report.warning (node.source_reference, "unhandled error");

			var cerror_block = new CCodeBlock ();
			// print critical message
			cerror_block.add_statement (cprint_frag);

			// check error domain if expression failed
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("inner_error"), new CCodeConstant ("NULL"));

			cfrag.append (new CCodeIfStatement (ccond, cerror_block));
		}
	}

	public override void visit_expression_statement (ExpressionStatement! stmt) {
		stmt.ccodenode = new CCodeExpressionStatement ((CCodeExpression) stmt.expression.ccodenode);

		if (stmt.tree_can_fail && stmt.expression.can_fail) {
			// simple case, no node breakdown necessary

			var cfrag = new CCodeFragment ();

			cfrag.append (stmt.ccodenode);

			add_simple_check (stmt.expression, cfrag);

			stmt.ccodenode = cfrag;
		}

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
			var ma = new MemberAccess.simple (decl.name);
			ma.symbol_reference = decl;
			cfrag.append (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (decl.name), decl.type_reference, ma)));
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
		
		// FIXME cast to CodeNode shouldn't be necessary as Statement requires CodeNode
		cfrag.append (((CodeNode) stmt).ccodenode);
		
		((CodeNode) stmt).ccodenode = cfrag;
	}

	public override void visit_if_statement (IfStatement! stmt) {
		if (stmt.false_statement != null) {
			stmt.ccodenode = new CCodeIfStatement ((CCodeExpression) stmt.condition.ccodenode, (CCodeStatement) stmt.true_statement.ccodenode, (CCodeStatement) stmt.false_statement.ccodenode);
		} else {
			stmt.ccodenode = new CCodeIfStatement ((CCodeExpression) stmt.condition.ccodenode, (CCodeStatement) stmt.true_statement.ccodenode);
		}
		
		create_temp_decl (stmt, stmt.condition.temp_vars);
	}

	public override void visit_switch_statement (SwitchStatement! stmt) {
		// we need a temporary variable to save the property value
		var temp_decl = get_temp_variable_declarator (stmt.expression.static_type);
		stmt.expression.temp_vars.prepend (temp_decl);

		var ctemp = new CCodeIdentifier (temp_decl.name);
		
		var cinit = new CCodeAssignment (ctemp, (CCodeExpression) stmt.expression.ccodenode);
		
		var cswitchblock = new CCodeFragment ();
		cswitchblock.append (new CCodeExpressionStatement (cinit));
		stmt.ccodenode = cswitchblock;

		create_temp_decl (stmt, stmt.expression.temp_vars);

		List<weak Statement> default_statements = null;
		
		// generate nested if statements		
		CCodeStatement ctopstmt = null;
		CCodeIfStatement coldif = null;
		foreach (SwitchSection section in stmt.get_sections ()) {
			if (section.has_default_label ()) {
				default_statements = section.get_statements ();
			} else {
				CCodeBinaryExpression cor = null;
				foreach (SwitchLabel label in section.get_labels ()) {
					var ccmp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ctemp, (CCodeExpression) label.expression.ccodenode);
					if (cor == null) {
						cor = ccmp;
					} else {
						cor = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cor, ccmp);
					}
				}
				
				var cblock = new CCodeBlock ();
				foreach (CodeNode body_stmt in section.get_statements ()) {
					if (body_stmt.ccodenode is CCodeFragment) {
						foreach (CCodeStatement cstmt in ((CCodeFragment) body_stmt.ccodenode).get_children ()) {
							cblock.add_statement (cstmt);
						}
					} else {
						cblock.add_statement ((CCodeStatement) body_stmt.ccodenode);
					}
				}
				
				var cdo = new CCodeDoStatement (cblock, new CCodeConstant ("0"));
				
				var cif = new CCodeIfStatement (cor, cdo);
				if (coldif != null) {
					coldif.false_statement = cif;
				} else {
					ctopstmt = cif;
				}
				coldif = cif;
			}
		}
		
		if (default_statements != null) {
			var cblock = new CCodeBlock ();
			foreach (CodeNode body_stmt in default_statements) {
				cblock.add_statement ((CCodeStatement) body_stmt.ccodenode);
			}
			
			var cdo = new CCodeDoStatement (cblock, new CCodeConstant ("0"));

			if (coldif == null) {
				// there is only one section and that section
				// contains a default label
				ctopstmt = cdo;
			} else {
				coldif.false_statement = cdo;
			}
		}
		
		cswitchblock.append (ctopstmt);
	}

	public override void visit_while_statement (WhileStatement! stmt) {
		stmt.ccodenode = new CCodeWhileStatement ((CCodeExpression) stmt.condition.ccodenode, (CCodeStatement) stmt.body.ccodenode);
		
		create_temp_decl (stmt, stmt.condition.temp_vars);
	}

	public override void visit_do_statement (DoStatement! stmt) {
		stmt.ccodenode = new CCodeDoStatement ((CCodeStatement) stmt.body.ccodenode, (CCodeExpression) stmt.condition.ccodenode);
		
		create_temp_decl (stmt, stmt.condition.temp_vars);
	}

	public override void visit_for_statement (ForStatement! stmt) {
		var cfor = new CCodeForStatement ((CCodeExpression) stmt.condition.ccodenode, (CCodeStatement) stmt.body.ccodenode);
		stmt.ccodenode = cfor;
		
		foreach (Expression init_expr in stmt.get_initializer ()) {
			cfor.add_initializer ((CCodeExpression) init_expr.ccodenode);
			create_temp_decl (stmt, init_expr.temp_vars);
		}
		
		foreach (Expression it_expr in stmt.get_iterator ()) {
			cfor.add_iterator ((CCodeExpression) it_expr.ccodenode);
			create_temp_decl (stmt, it_expr.temp_vars);
		}

		create_temp_decl (stmt, stmt.condition.temp_vars);
	}

	public override void visit_end_foreach_statement (ForeachStatement! stmt) {
		var cblock = new CCodeBlock ();
		CCodeForStatement cfor;
		VariableDeclarator collection_backup = get_temp_variable_declarator (stmt.collection.static_type);
		
		stmt.collection.temp_vars.prepend (collection_backup);
		var cfrag = new CCodeFragment ();
		append_temp_decl (cfrag, stmt.collection.temp_vars);
		cblock.add_statement (cfrag);
		cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier (collection_backup.name), (CCodeExpression) stmt.collection.ccodenode)));
		
		stmt.ccodenode = cblock;
		
		if (stmt.collection.static_type.data_type is Array) {
			var arr = (Array) stmt.collection.static_type.data_type;
			
			var array_len = get_array_length_cexpression (stmt.collection, 1);
			
			/* the array has no length parameter i.e. is NULL-terminated array */
			if (array_len is CCodeConstant) {
				var it_name = "%s_it".printf (stmt.variable_name);
			
				var citdecl = new CCodeDeclaration (stmt.collection.static_type.get_cname ());
				citdecl.add_declarator (new CCodeVariableDeclarator (it_name));
				cblock.add_statement (citdecl);
				
				var cbody = new CCodeBlock ();
				
				var cdecl = new CCodeDeclaration (stmt.type_reference.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (stmt.variable_name, new CCodeIdentifier ("*%s".printf (it_name))));
				cbody.add_statement (cdecl);
				
				cbody.add_statement (stmt.body.ccodenode);
				
				var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("*%s".printf (it_name)), new CCodeConstant ("NULL"));
				
				var cfor = new CCodeForStatement (ccond, cbody);

				cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier (it_name), new CCodeIdentifier (collection_backup.name)));
		
				cfor.add_iterator (new CCodeAssignment (new CCodeIdentifier (it_name), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier (it_name), new CCodeConstant ("1"))));
				cblock.add_statement (cfor);
			/* the array has a length parameter */
			} else {
				var it_name = (stmt.variable_name + "_it");
			
				var citdecl = new CCodeDeclaration ("int");
				citdecl.add_declarator (new CCodeVariableDeclarator (it_name));
				cblock.add_statement (citdecl);
				
				var cbody = new CCodeBlock ();
				
				var cdecl = new CCodeDeclaration (stmt.type_reference.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (stmt.variable_name, new CCodeElementAccess (new CCodeIdentifier (collection_backup.name), new CCodeIdentifier (it_name))));
				cbody.add_statement (cdecl);

				cbody.add_statement (stmt.body.ccodenode);
				
				var ccond_ind1 = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, array_len, new CCodeConstant ("-1"));
				var ccond_ind2 = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier (it_name), array_len);
				var ccond_ind = new CCodeBinaryExpression (CCodeBinaryOperator.AND, ccond_ind1, ccond_ind2);
				
				/* only check for null if the containers elements are of reference-type */
				CCodeBinaryExpression ccond;
				if (arr.element_type.is_reference_type ()) {
					var ccond_term1 = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, array_len, new CCodeConstant ("-1"));
					var ccond_term2 = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeElementAccess (new CCodeIdentifier (collection_backup.name), new CCodeIdentifier (it_name)), new CCodeConstant ("NULL"));
					var ccond_term = new CCodeBinaryExpression (CCodeBinaryOperator.AND, ccond_term1, ccond_term2);

					ccond = new CCodeBinaryExpression (CCodeBinaryOperator.OR, new CCodeParenthesizedExpression (ccond_ind), new CCodeParenthesizedExpression (ccond_term));
				} else {
					/* assert when trying to iterate over value-type arrays of unknown length */
					var cassert = new CCodeFunctionCall (new CCodeIdentifier ("g_assert"));
					cassert.add_argument (ccond_ind1);
					cblock.add_statement (new CCodeExpressionStatement (cassert));

					ccond = ccond_ind2;
				}
				
				var cfor = new CCodeForStatement (ccond, cbody);
				cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier (it_name), new CCodeConstant ("0")));
				cfor.add_iterator (new CCodeAssignment (new CCodeIdentifier (it_name), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier (it_name), new CCodeConstant ("1"))));
				cblock.add_statement (cfor);
			}
		} else if (stmt.collection.static_type.data_type == glist_type ||
		           stmt.collection.static_type.data_type == gslist_type) {
			var it_name = "%s_it".printf (stmt.variable_name);
		
			var citdecl = new CCodeDeclaration (stmt.collection.static_type.get_cname ());
			citdecl.add_declarator (new CCodeVariableDeclarator (it_name));
			cblock.add_statement (citdecl);
			
			var cbody = new CCodeBlock ();

			CCodeExpression element_expr = new CCodeMemberAccess.pointer (new CCodeIdentifier (it_name), "data");

			element_expr = convert_from_generic_pointer (element_expr, stmt.type_reference);

			var cdecl = new CCodeDeclaration (stmt.type_reference.get_cname ());
			cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (stmt.variable_name, element_expr));
			cbody.add_statement (cdecl);
			
			cbody.add_statement (stmt.body.ccodenode);
			
			var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier (it_name), new CCodeConstant ("NULL"));
			
			var cfor = new CCodeForStatement (ccond, cbody);
			
			cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier (it_name), new CCodeIdentifier (collection_backup.name)));

			cfor.add_iterator (new CCodeAssignment (new CCodeIdentifier (it_name), new CCodeMemberAccess.pointer (new CCodeIdentifier (it_name), "next")));
			cblock.add_statement (cfor);
		} else if (stmt.collection.static_type.data_type == iterable_type ||
		           stmt.collection.static_type.data_type.is_subtype_of (iterable_type)) {
			var it_name = "%s_it".printf (stmt.variable_name);

			var citdecl = new CCodeDeclaration (iterator_type.get_cname () + "*");
			var it_method = (Method) iterable_type.scope.lookup ("iterator");
			var it_ccall = new CCodeFunctionCall (new CCodeIdentifier (it_method.get_cname ()));
			it_ccall.add_argument (new InstanceCast (new CCodeIdentifier (collection_backup.name), iterable_type));
			citdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (it_name, it_ccall));
			cblock.add_statement (citdecl);
			
			var cbody = new CCodeBlock ();

			var get_method = (Method) iterator_type.scope.lookup ("get");
			var get_ccall = new CCodeFunctionCall (new CCodeIdentifier (get_method.get_cname ()));
			get_ccall.add_argument (new CCodeIdentifier (it_name));
			CCodeExpression element_expr = get_ccall;

			element_expr = convert_from_generic_pointer (element_expr, stmt.type_reference);

			var cdecl = new CCodeDeclaration (stmt.type_reference.get_cname ());
			cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (stmt.variable_name, element_expr));
			cbody.add_statement (cdecl);
			
			cbody.add_statement (stmt.body.ccodenode);

			cbody.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (stmt.variable_name), stmt.type_reference, null)));
			
			var next_method = (Method) iterator_type.scope.lookup ("next");
			var next_ccall = new CCodeFunctionCall (new CCodeIdentifier (next_method.get_cname ()));
			next_ccall.add_argument (new CCodeIdentifier (it_name));

			cblock.add_statement (new CCodeWhileStatement (next_ccall, cbody));

			var it_unref_ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_unref"));
			it_unref_ccall.add_argument (new CCodeIdentifier (it_name));
			cblock.add_statement (new CCodeExpressionStatement (it_unref_ccall));
		}
		
		if (memory_management && stmt.collection.static_type.transfers_ownership) {
			var ma = new MemberAccess.simple (collection_backup.name);
			ma.symbol_reference = collection_backup;
			cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (collection_backup.name), stmt.collection.static_type, ma)));
		}
	}

	public override void visit_break_statement (BreakStatement! stmt) {
		stmt.ccodenode = new CCodeBreakStatement ();
	}

	public override void visit_continue_statement (ContinueStatement! stmt) {
		stmt.ccodenode = new CCodeContinueStatement ();
	}
	
	private void append_local_free (Symbol sym, CCodeFragment cfrag, bool stop_at_loop) {
		var b = (Block) sym;

		var local_vars = b.get_local_variables ();
		foreach (VariableDeclarator decl in local_vars) {
			if (decl.active && decl.type_reference.data_type.is_reference_type () && decl.type_reference.takes_ownership) {
				var ma = new MemberAccess.simple (decl.name);
				ma.symbol_reference = decl;
				cfrag.append (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (get_variable_cname (decl.name)), decl.type_reference, ma)));
			}
		}
		
		if (sym.parent_symbol is Block) {
			append_local_free (sym.parent_symbol, cfrag, stop_at_loop);
		}
	}

	private void create_local_free (CodeNode stmt) {
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
	
		var b = (Block) sym;

		var local_vars = b.get_local_variables ();
		foreach (VariableDeclarator decl in local_vars) {
			if (decl.active && decl.type_reference.data_type.is_reference_type () && decl.type_reference.takes_ownership) {
				found = true;
				var ma = new MemberAccess.simple (decl.name);
				ma.symbol_reference = decl;
				ccomma.append_expression (get_unref_expression (new CCodeIdentifier (get_variable_cname (decl.name)), decl.type_reference, ma));
			}
		}
		
		if (sym.parent_symbol is Block) {
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
		ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (return_expr_decl.name), (CCodeExpression) expr.ccodenode));

		if (!append_local_free_expr (current_symbol, ccomma, false)) {
			/* no local variables need to be freed */
			return;
		}

		ccomma.append_expression (new CCodeIdentifier (return_expr_decl.name));
		
		expr.ccodenode = ccomma;
		expr.temp_vars.append (return_expr_decl);
	}

	public override void visit_begin_return_statement (ReturnStatement! stmt) {
		if (stmt.return_expression != null) {
			// avoid unnecessary ref/unref pair
			if (stmt.return_expression.ref_missing &&
			    stmt.return_expression.symbol_reference is VariableDeclarator) {
				var decl = (VariableDeclarator) stmt.return_expression.symbol_reference;
				if (decl.type_reference.takes_ownership) {
					/* return expression is local variable taking ownership and
					 * current method is transferring ownership */
					
					stmt.return_expression.ref_sink = true;

					// don't ref expression
					stmt.return_expression.ref_missing = false;
				}
			}
		}
	}

	public override void visit_end_return_statement (ReturnStatement! stmt) {
		if (stmt.return_expression == null) {
			stmt.ccodenode = new CCodeReturnStatement ();
			
			create_local_free (stmt);
		} else {
			Symbol return_expression_symbol = null;
		
			// avoid unnecessary ref/unref pair
			if (stmt.return_expression.ref_sink &&
			    stmt.return_expression.symbol_reference is VariableDeclarator) {
				var decl = (VariableDeclarator) stmt.return_expression.symbol_reference;
				if (decl.type_reference.takes_ownership) {
					/* return expression is local variable taking ownership and
					 * current method is transferring ownership */
					
					// don't unref expression
					return_expression_symbol = decl;
					return_expression_symbol.active = false;
				}
			}

			// return array length if appropriate
			if (current_method != null && !current_method.no_array_length && current_return_type.data_type is Array) {
				var return_expr_decl = get_temp_variable_declarator (stmt.return_expression.static_type);

				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (return_expr_decl.name), (CCodeExpression) stmt.return_expression.ccodenode));

				var arr = (Array) current_return_type.data_type;

				for (int dim = 1; dim <= arr.rank; dim++) {
					var len_l = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (get_array_length_cname ("result", dim)));
					var len_r = get_array_length_cexpression (stmt.return_expression, dim);
					ccomma.append_expression (new CCodeAssignment (len_l, len_r));
				}

				ccomma.append_expression (new CCodeIdentifier (return_expr_decl.name));
				
				stmt.return_expression.ccodenode = ccomma;
				stmt.return_expression.temp_vars.append (return_expr_decl);
			}

			create_local_free_expr (stmt.return_expression);
			
			if (stmt.return_expression.static_type != null &&
			    stmt.return_expression.static_type.data_type != current_return_type.data_type) {
				/* cast required */
				if (current_return_type.data_type is Class || current_return_type.data_type is Interface) {
					stmt.return_expression.ccodenode = new InstanceCast ((CCodeExpression) stmt.return_expression.ccodenode, current_return_type.data_type);
				}
			}

			stmt.ccodenode = new CCodeReturnStatement ((CCodeExpression) stmt.return_expression.ccodenode);
		
			create_temp_decl (stmt, stmt.return_expression.temp_vars);

			if (return_expression_symbol != null) {
				return_expression_symbol.active = true;
			}
		}
	}

	public override void visit_throw_statement (ThrowStatement! stmt) {
		stmt.accept_children (this);

		var cfrag = new CCodeFragment ();

		cfrag.append (new CCodeExpressionStatement ((CCodeExpression) stmt.error_expression.ccodenode));

		if (current_return_type != null && current_return_type.data_type != null) {
			cfrag.append (new CCodeReturnStatement (default_value_for_type (current_return_type.data_type)));
		} else {
			cfrag.append (new CCodeReturnStatement ());
		}

		stmt.ccodenode = cfrag;
	}

	public override void visit_try_statement (TryStatement! stmt) {
		var old_try = current_try;
		var old_try_id = current_try_id;
		current_try = stmt;
		current_try_id = next_try_id++;

		stmt.accept_children (this);

		var cfrag = new CCodeFragment ();
		cfrag.append (stmt.body.ccodenode);

		foreach (CatchClause clause in stmt.get_catch_clauses ()) {
			cfrag.append (new CCodeGotoStatement ("__finally%d".printf (current_try_id)));

			cfrag.append (clause.ccodenode);
		}

		cfrag.append (new CCodeLabel ("__finally%d".printf (current_try_id)));
		if (stmt.finally_body != null) {
			cfrag.append (stmt.finally_body.ccodenode);
		} else {
			// avoid gcc error: label at end of compound statement
			cfrag.append (new CCodeEmptyStatement ());
		}

		stmt.ccodenode = cfrag;

		current_try = old_try;
		current_try_id = old_try_id;
	}

	public override void visit_catch_clause (CatchClause! clause) {
		clause.accept_children (this);

		var cfrag = new CCodeFragment ();
		cfrag.append (new CCodeLabel ("__catch%d_%s".printf (current_try_id, clause.type_reference.data_type.get_lower_case_cname ())));

		var cblock = new CCodeBlock ();

		var cdecl = new CCodeDeclaration ("GError *");
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer (clause.variable_name, new CCodeIdentifier ("inner_error")));
		cblock.add_statement (cdecl);
		cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("inner_error"), new CCodeConstant ("NULL"))));

		cblock.add_statement (clause.body.ccodenode);

		cfrag.append (cblock);

		clause.ccodenode = cfrag;
	}

	private string get_symbol_lock_name (Symbol! sym) {
		return "__lock_%s".printf (sym.name);
	}
	
	/**
	 * Visit operation called for lock statements.
	 *
	 * @param stmt a lock statement
	 */
	public override void visit_lock_statement (LockStatement! stmt) {
		var cn = new CCodeFragment ();
		CCodeExpression l = null;
		CCodeFunctionCall fc;
		var inner_node = ((MemberAccess)stmt.resource).inner;
		
		if (inner_node  == null) {
			l = new CCodeIdentifier ("self");
		} else if (stmt.resource.symbol_reference.parent_symbol != current_type_symbol) {
			 l = new CCodeFunctionCall (new CCodeIdentifier (((DataType) stmt.resource.symbol_reference.parent_symbol).get_upper_case_cname ()));
			((CCodeFunctionCall) l).add_argument ((CCodeExpression)inner_node.ccodenode);
		} else {
			l = (CCodeExpression)inner_node.ccodenode;
		}
		l = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (l, "priv"), get_symbol_lock_name (stmt.resource.symbol_reference));
		
		fc = new CCodeFunctionCall (new CCodeIdentifier (((Method) mutex_type.data_type.scope.lookup ("lock")).get_cname ()));
		fc.add_argument (l);
		cn.append (new CCodeExpressionStatement (fc));
		
		cn.append (stmt.body.ccodenode);
		
		fc = new CCodeFunctionCall (new CCodeIdentifier (((Method) mutex_type.data_type.scope.lookup ("unlock")).get_cname ()));
		fc.add_argument (l);
		cn.append (new CCodeExpressionStatement (fc));
		
		stmt.ccodenode = cn;
	}
	
	/**
	 * Visit operations called for array creation expresions.
	 *
	 * @param expr an array creation expression
	 */
	public override void visit_end_array_creation_expression (ArrayCreationExpression! expr) {
		var gnew = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
		gnew.add_argument (new CCodeIdentifier (expr.element_type.get_cname ()));
		bool first = true;
		CCodeExpression cexpr = null;
		foreach (Expression size in expr.get_sizes ()) {
			if (first) {
				cexpr = (CCodeExpression) size.ccodenode;
				first = false;
			} else {
				cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, cexpr, (CCodeExpression) size.ccodenode);
			}
		}
		gnew.add_argument (cexpr);

		if (expr.initializer_list != null) {
			// FIXME rank > 1 not supported yet
			if (expr.rank > 1) {
				expr.error = true;
				Report.error (expr.source_reference, "Creating arrays with rank greater than 1 with initializers is not supported yet");
			}

			var ce = new CCodeCommaExpression ();
			var temp_var = get_temp_variable_declarator (expr.static_type);
			var name_cnode = new CCodeIdentifier (temp_var.name);
			int i = 0;
			
			temp_vars.prepend (temp_var);
			
			ce.append_expression (new CCodeAssignment (name_cnode, gnew));
			
			foreach (Expression e in expr.initializer_list.get_initializers ()) {
				ce.append_expression (new CCodeAssignment (new CCodeElementAccess (name_cnode, new CCodeConstant (i.to_string ())), (CCodeExpression) e.ccodenode));
				i++;
			}
			
			ce.append_expression (name_cnode);
			
			expr.ccodenode = ce;
		} else {
			expr.ccodenode = gnew;
		}
	}

	public override void visit_boolean_literal (BooleanLiteral! expr) {
		expr.ccodenode = new CCodeConstant (expr.value ? "TRUE" : "FALSE");
	}

	public override void visit_character_literal (CharacterLiteral! expr) {
		if (expr.get_char () >= 0x20 && expr.get_char () < 0x80) {
			expr.ccodenode = new CCodeConstant (expr.value);
		} else {
			expr.ccodenode = new CCodeConstant ("%uU".printf (expr.get_char ()));
		}
	}

	public override void visit_integer_literal (IntegerLiteral! expr) {
		expr.ccodenode = new CCodeConstant (expr.value);
	}

	public override void visit_real_literal (RealLiteral! expr) {
		expr.ccodenode = new CCodeConstant (expr.value);
	}

	public override void visit_string_literal (StringLiteral! expr) {
		expr.ccodenode = new CCodeConstant (expr.value);
	}

	public override void visit_null_literal (NullLiteral! expr) {
		expr.ccodenode = new CCodeConstant ("NULL");
	}

	public override void visit_literal_expression (LiteralExpression! expr) {
		expr.ccodenode = expr.literal.ccodenode;
		
		visit_expression (expr);
	}

	public override void visit_parenthesized_expression (ParenthesizedExpression! expr) {
		expr.ccodenode = new CCodeParenthesizedExpression ((CCodeExpression) expr.inner.ccodenode);

		visit_expression (expr);
	}

	private CCodeExpression! get_array_length_cexpression (Expression! array_expr, int dim) {
		bool is_out = false;
	
		if (array_expr is UnaryExpression) {
			var unary_expr = (UnaryExpression) array_expr;
			if (unary_expr.operator == UnaryOperator.OUT) {
				array_expr = unary_expr.inner;
				is_out = true;
			}
		} else if (array_expr is ReferenceTransferExpression) {
			var reftransfer_expr = (ReferenceTransferExpression) array_expr;
			array_expr = reftransfer_expr.inner;
		}
		
		if (array_expr is ArrayCreationExpression) {
			List<weak Expression> size = ((ArrayCreationExpression) array_expr).get_sizes ();
			var length_expr = size.nth_data (dim - 1);
			return (CCodeExpression) length_expr.ccodenode;
		} else if (array_expr is InvocationExpression) {
			var invocation_expr = (InvocationExpression) array_expr;
			List<weak CCodeExpression> size = invocation_expr.get_array_sizes ();
			return size.nth_data (dim - 1);
		} else if (array_expr.symbol_reference != null) {
			if (array_expr.symbol_reference is FormalParameter) {
				var param = (FormalParameter) array_expr.symbol_reference;
				if (!param.no_array_length) {
					var length_expr = new CCodeIdentifier (get_array_length_cname (param.name, dim));
					if (is_out) {
						return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, length_expr);
					} else {
						return length_expr;
					}
				}
			} else if (array_expr.symbol_reference is VariableDeclarator) {
				var decl = (VariableDeclarator) array_expr.symbol_reference;
				var length_expr = new CCodeIdentifier (get_array_length_cname (decl.name, dim));
				if (is_out) {
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, length_expr);
				} else {
					return length_expr;
				}
			} else if (array_expr.symbol_reference is Field) {
				var field = (Field) array_expr.symbol_reference;
				if (!field.no_array_length) {
					var length_cname = get_array_length_cname (field.name, dim);

					var ma = (MemberAccess) array_expr;

					CCodeExpression pub_inst = null;
					DataType base_type = null;
					CCodeExpression length_expr = null;
				
					if (ma.inner == null) {
						pub_inst = new CCodeIdentifier ("self");

						if (current_type_symbol != null) {
							/* base type is available if this is a type method */
							base_type = (DataType) current_type_symbol;
						}
					} else {
						pub_inst = (CCodeExpression) ma.inner.ccodenode;

						if (ma.inner.static_type != null) {
							base_type = ma.inner.static_type.data_type;
						}
					}

					if (field.instance) {
						CCodeExpression typed_inst;
						if (field.parent_symbol != base_type) {
							// FIXME: use C cast if debugging disabled
							typed_inst = new CCodeFunctionCall (new CCodeIdentifier (((DataType) field.parent_symbol).get_upper_case_cname (null)));
							((CCodeFunctionCall) typed_inst).add_argument (pub_inst);
						} else {
							typed_inst = pub_inst;
						}
						CCodeExpression inst;
						if (field.access == MemberAccessibility.PRIVATE) {
							inst = new CCodeMemberAccess.pointer (typed_inst, "priv");
						} else {
							inst = typed_inst;
						}
						if (((DataType) field.parent_symbol).is_reference_type ()) {
							length_expr = new CCodeMemberAccess.pointer (inst, length_cname);
						} else {
							length_expr = new CCodeMemberAccess (inst, length_cname);
						}
					} else {
						length_expr = new CCodeIdentifier (length_cname);
					}

					if (is_out) {
						return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, length_expr);
					} else {
						return length_expr;
					}
				}
			}
		}

		if (!is_out) {
			/* allow arrays with unknown length even for value types
			 * as else it may be impossible to bind some libraries
			 * users of affected libraries should explicitly set
			 * the array length as early as possible
			 * by setting the virtual length field of the array
			 */
			return new CCodeConstant ("-1");
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	public override void visit_element_access (ElementAccess! expr)
	{
		List<weak Expression> indices = expr.get_indices ();
		int rank = indices.length ();

		var container_type = expr.container.static_type.data_type;

		var ccontainer = (CCodeExpression) expr.container.ccodenode;
		var cindex = (CCodeExpression) indices.nth_data (0).ccodenode;
		if (container_type == string_type.data_type) {
			// access to unichar in a string
			var coffsetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_utf8_offset_to_pointer"));
			coffsetcall.add_argument (ccontainer);
			coffsetcall.add_argument (cindex);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_utf8_get_char"));
			ccall.add_argument (coffsetcall);

			expr.ccodenode = ccall;
		} else if (container_type != null && list_type != null && map_type != null &&
		           (container_type == list_type || container_type.is_subtype_of (list_type) ||
		            container_type == map_type || container_type.is_subtype_of (map_type))) {
			var get_method = (Method) container_type.scope.lookup ("get");
			List<weak FormalParameter> get_params = get_method.get_parameters ();
			var get_param = (FormalParameter) get_params.data;

			if (get_param.type_reference.type_parameter != null) {
				var index_type = SemanticAnalyzer.get_actual_type (expr.container.static_type, get_method, get_param.type_reference.type_parameter, expr);
				cindex = convert_to_generic_pointer (cindex, index_type);
			}

			var get_ccall = new CCodeFunctionCall (new CCodeIdentifier (get_method.get_cname ()));
			get_ccall.add_argument (new CCodeCastExpression (ccontainer, container_type.get_cname () + "*"));
			get_ccall.add_argument (cindex);

			expr.ccodenode = convert_from_generic_pointer (get_ccall, expr.static_type);
		} else {
			// access to element in an array
			for (int i = 1; i < rank; i++) {
				var cmul = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, cindex, get_array_length_cexpression (expr.container, i + 1));
				cindex = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, cmul, (CCodeExpression) indices.nth_data (i).ccodenode);
			}
			expr.ccodenode = new CCodeElementAccess (ccontainer, cindex);
		}

		visit_expression (expr);
	}

	public override void visit_base_access (BaseAccess! expr) {
		expr.ccodenode = new InstanceCast (new CCodeIdentifier ("self"), expr.static_type.data_type);
	}

	public override void visit_postfix_expression (PostfixExpression! expr) {
		MemberAccess ma = find_property_access (expr.inner);
		if (ma != null) {
			// property postfix expression
			var prop = (Property) ma.symbol_reference;
			
			var ccomma = new CCodeCommaExpression ();
			
			// assign current value to temp variable
			var temp_decl = get_temp_variable_declarator (prop.type_reference);
			temp_vars.prepend (temp_decl);
			ccomma.append_expression (new CCodeAssignment (new CCodeIdentifier (temp_decl.name), (CCodeExpression) expr.inner.ccodenode));
			
			// increment/decrement property
			var op = expr.increment ? CCodeBinaryOperator.PLUS : CCodeBinaryOperator.MINUS;
			var cexpr = new CCodeBinaryExpression (op, new CCodeIdentifier (temp_decl.name), new CCodeConstant ("1"));
			var ccall = get_property_set_call (prop, ma, cexpr);
			ccomma.append_expression (ccall);
			
			// return previous value
			ccomma.append_expression (new CCodeIdentifier (temp_decl.name));
			
			expr.ccodenode = ccomma;
			return;
		}
	
		var op = expr.increment ? CCodeUnaryOperator.POSTFIX_INCREMENT : CCodeUnaryOperator.POSTFIX_DECREMENT;
	
		expr.ccodenode = new CCodeUnaryExpression (op, (CCodeExpression) expr.inner.ccodenode);
		
		visit_expression (expr);
	}
	
	private MemberAccess find_property_access (Expression! expr) {
		if (expr is ParenthesizedExpression) {
			var pe = (ParenthesizedExpression) expr;
			return find_property_access (pe.inner);
		}
	
		if (!(expr is MemberAccess)) {
			return null;
		}
		
		var ma = (MemberAccess) expr;
		if (ma.symbol_reference is Property) {
			return ma;
		}
		
		return null;
	}
	
	private CCodeExpression get_ref_expression (Expression! expr) {
		/* (temp = expr, temp == NULL ? NULL : ref (temp))
		 *
		 * can be simplified to
		 * ref (expr)
		 * if static type of expr is non-null
		 */
		 
		var ccall = new CCodeFunctionCall (get_dup_func_expression (expr.static_type));

		if (expr.static_type.non_null && expr.static_type.type_parameter == null) {
			ccall.add_argument ((CCodeExpression) expr.ccodenode);
			
			return ccall;
		} else {
			var decl = get_temp_variable_declarator (expr.static_type, false);
			temp_vars.prepend (decl);

			var ctemp = new CCodeIdentifier (decl.name);
			
			var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ctemp, new CCodeConstant ("NULL"));
			if (expr.static_type.data_type == null) {
				if (!(current_type_symbol is Class)) {
					return (CCodeExpression) expr.ccodenode;
				}

				// dup functions are optional for type parameters
				var cdupisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, get_dup_func_expression (expr.static_type), new CCodeConstant ("NULL"));
				cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cisnull, cdupisnull);
			}
			
			ccall.add_argument (ctemp);
			
			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (ctemp, (CCodeExpression) expr.ccodenode));

			if (expr.static_type.data_type == glist_type) {
				bool is_ref = false;
				bool is_class = false;
				bool is_interface = false;

				foreach (TypeReference type_arg in expr.static_type.get_type_arguments ()) {
					is_ref |= type_arg.takes_ownership;
					is_class |= type_arg.data_type is Class;
					is_interface |= type_arg.data_type is Interface;
				}
			
				if (is_ref && (is_class || is_interface)) {
					var crefcall = new CCodeFunctionCall (new CCodeIdentifier ("g_list_foreach"));

					crefcall.add_argument (ctemp);
					crefcall.add_argument (new CCodeIdentifier ("(GFunc) g_object_ref"));
					crefcall.add_argument (new CCodeConstant ("NULL"));

					ccomma.append_expression (crefcall);
				}
			}

			CCodeExpression cifnull;
			if (expr.static_type.data_type != null) {
				cifnull = new CCodeConstant ("NULL");
			} else {
				// the value might be non-null even when the dup function is null,
				// so we may not just use NULL for type parameters
				cifnull = ctemp;
			}
			ccomma.append_expression (new CCodeConditionalExpression (cisnull, cifnull, ccall));

			return ccomma;
		}
	}
	
	private void visit_expression (Expression! expr) {
		if (expr.static_type != null &&
		    expr.static_type.transfers_ownership &&
		    expr.static_type.floating_reference) {
			/* constructor of GInitiallyUnowned subtype
			 * returns floating reference, sink it
			 */
			var csink = new CCodeFunctionCall (new CCodeIdentifier ("g_object_ref_sink"));
			csink.add_argument ((CCodeExpression) expr.ccodenode);
			
			expr.ccodenode = csink;
		}
	
		if (expr.ref_leaked) {
			var decl = get_temp_variable_declarator (expr.static_type);
			temp_vars.prepend (decl);
			temp_ref_vars.prepend (decl);
			expr.ccodenode = new CCodeParenthesizedExpression (new CCodeAssignment (new CCodeIdentifier (get_variable_cname (decl.name)), (CCodeExpression) expr.ccodenode));
		} else if (expr.ref_missing) {
			expr.ccodenode = get_ref_expression (expr);
		}
	}

	public override void visit_end_object_creation_expression (ObjectCreationExpression! expr) {
		if (expr.symbol_reference == null) {
			// no creation method
			if (expr.type_reference.data_type is Class) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_new"));
				
				ccall.add_argument (new CCodeConstant (expr.type_reference.data_type.get_type_id ()));

				ccall.add_argument (new CCodeConstant ("NULL"));
				
				expr.ccodenode = ccall;
			} else if (expr.type_reference.data_type == glist_type ||
			           expr.type_reference.data_type == gslist_type) {
				// NULL is an empty list
				expr.ccodenode = new CCodeConstant ("NULL");
			} else {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
				
				ccall.add_argument (new CCodeConstant (expr.type_reference.data_type.get_cname ()));
				
				ccall.add_argument (new CCodeConstant ("1"));
				
				expr.ccodenode = ccall;
			}
		} else if (expr.symbol_reference is Method) {
			// use creation method
			var m = (Method) expr.symbol_reference;
			var params = m.get_parameters ();

			var ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_cname ()));

			if (expr.type_reference.data_type is Class) {
				foreach (TypeReference type_arg in expr.type_reference.get_type_arguments ()) {
					if (type_arg.takes_ownership) {
						ccall.add_argument (get_dup_func_expression (type_arg));
						ccall.add_argument (get_destroy_func_expression (type_arg));
					} else {
						ccall.add_argument (new CCodeConstant ("NULL"));
						ccall.add_argument (new CCodeConstant ("NULL"));
					}
				}
			}

			bool ellipsis = false;

			int i = 1;
			weak List<weak FormalParameter> params_it = params;
			foreach (Expression arg in expr.get_argument_list ()) {
				CCodeExpression cexpr = (CCodeExpression) arg.ccodenode;
				if (params_it != null) {
					var param = (FormalParameter) params_it.data;
					ellipsis = param.ellipsis;
					if (!param.ellipsis
					    && param.type_reference.data_type != null
					    && param.type_reference.data_type.is_reference_type ()
					    && arg.static_type.data_type != null
					    && param.type_reference.data_type != arg.static_type.data_type) {
						// FIXME: use C cast if debugging disabled
						var ccall = new CCodeFunctionCall (new CCodeIdentifier (param.type_reference.data_type.get_upper_case_cname (null)));
						ccall.add_argument (cexpr);
						cexpr = ccall;
					}
				}
			
				ccall.add_argument (cexpr);
				i++;
				
				if (params_it != null) {
					params_it = params_it.next;
				}
			}
			while (params_it != null) {
				var param = (FormalParameter) params_it.data;
				
				if (param.ellipsis) {
					ellipsis = true;
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
			
				params_it = params_it.next;
			}

			if (expr.can_fail) {
				// method can fail
				current_method_inner_error = true;
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("inner_error")));
			}

			if (ellipsis) {
				// ensure variable argument list ends with NULL
				ccall.add_argument (new CCodeConstant ("NULL"));
			}
			
			expr.ccodenode = ccall;
		} else if (expr.symbol_reference is EnumValue) {
			// error code
			var ev = (EnumValue) expr.symbol_reference;
			var en = (Enum) ev.parent_symbol;

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_set_error"));
			ccall.add_argument (new CCodeIdentifier ("error"));
			ccall.add_argument (new CCodeIdentifier (en.get_upper_case_cname ()));
			ccall.add_argument (new CCodeIdentifier (ev.get_cname ()));

			foreach (Expression arg in expr.get_argument_list ()) {
				ccall.add_argument ((CCodeExpression) arg.ccodenode);
			}

			expr.ccodenode = ccall;
		} else {
			assert (false);
		}
			
		visit_expression (expr);
	}

	public override void visit_sizeof_expression (SizeofExpression! expr) {
		var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
		csizeof.add_argument (new CCodeIdentifier (expr.type_reference.data_type.get_cname ()));
		expr.ccodenode = csizeof;
	}

	public override void visit_typeof_expression (TypeofExpression! expr) {
		expr.ccodenode = new CCodeIdentifier (expr.type_reference.data_type.get_type_id ());
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
		} else if (expr.operator == UnaryOperator.INCREMENT) {
			op = CCodeUnaryOperator.PREFIX_INCREMENT;
		} else if (expr.operator == UnaryOperator.DECREMENT) {
			op = CCodeUnaryOperator.PREFIX_DECREMENT;
		} else if (expr.operator == UnaryOperator.REF) {
			op = CCodeUnaryOperator.ADDRESS_OF;
		} else if (expr.operator == UnaryOperator.OUT) {
			op = CCodeUnaryOperator.ADDRESS_OF;
		}
		expr.ccodenode = new CCodeUnaryExpression (op, (CCodeExpression) expr.inner.ccodenode);

		visit_expression (expr);
	}

	public override void visit_cast_expression (CastExpression! expr) {
		if (expr.type_reference.data_type is Class || expr.type_reference.data_type is Interface) {
			// GObject cast
			expr.ccodenode = new InstanceCast ((CCodeExpression) expr.inner.ccodenode, expr.type_reference.data_type);
		} else {
			expr.ccodenode = new CCodeCastExpression ((CCodeExpression) expr.inner.ccodenode, expr.type_reference.get_cname ());
		}

		visit_expression (expr);
	}
	
	public override void visit_pointer_indirection (PointerIndirection! expr) {
		expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, (CCodeExpression) expr.inner.ccodenode);
	}

	public override void visit_addressof_expression (AddressofExpression! expr) {
		expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, (CCodeExpression) expr.inner.ccodenode);
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression! expr) {
		/* (tmp = var, var = null, tmp) */
		var ccomma = new CCodeCommaExpression ();
		var temp_decl = get_temp_variable_declarator (expr.static_type);
		temp_vars.prepend (temp_decl);
		var cvar = new CCodeIdentifier (temp_decl.name);

		ccomma.append_expression (new CCodeAssignment (cvar, (CCodeExpression) expr.inner.ccodenode));
		ccomma.append_expression (new CCodeAssignment ((CCodeExpression) expr.inner.ccodenode, new CCodeConstant ("NULL")));
		ccomma.append_expression (cvar);
		expr.ccodenode = ccomma;

		visit_expression (expr);
	}

	public override void visit_binary_expression (BinaryExpression! expr) {
		CCodeBinaryOperator op;
		if (expr.operator == BinaryOperator.PLUS) {
			op = CCodeBinaryOperator.PLUS;
		} else if (expr.operator == BinaryOperator.MINUS) {
			op = CCodeBinaryOperator.MINUS;
		} else if (expr.operator == BinaryOperator.MUL) {
			op = CCodeBinaryOperator.MUL;
		} else if (expr.operator == BinaryOperator.DIV) {
			op = CCodeBinaryOperator.DIV;
		} else if (expr.operator == BinaryOperator.MOD) {
			op = CCodeBinaryOperator.MOD;
		} else if (expr.operator == BinaryOperator.SHIFT_LEFT) {
			op = CCodeBinaryOperator.SHIFT_LEFT;
		} else if (expr.operator == BinaryOperator.SHIFT_RIGHT) {
			op = CCodeBinaryOperator.SHIFT_RIGHT;
		} else if (expr.operator == BinaryOperator.LESS_THAN) {
			op = CCodeBinaryOperator.LESS_THAN;
		} else if (expr.operator == BinaryOperator.GREATER_THAN) {
			op = CCodeBinaryOperator.GREATER_THAN;
		} else if (expr.operator == BinaryOperator.LESS_THAN_OR_EQUAL) {
			op = CCodeBinaryOperator.LESS_THAN_OR_EQUAL;
		} else if (expr.operator == BinaryOperator.GREATER_THAN_OR_EQUAL) {
			op = CCodeBinaryOperator.GREATER_THAN_OR_EQUAL;
		} else if (expr.operator == BinaryOperator.EQUALITY) {
			op = CCodeBinaryOperator.EQUALITY;
		} else if (expr.operator == BinaryOperator.INEQUALITY) {
			op = CCodeBinaryOperator.INEQUALITY;
		} else if (expr.operator == BinaryOperator.BITWISE_AND) {
			op = CCodeBinaryOperator.BITWISE_AND;
		} else if (expr.operator == BinaryOperator.BITWISE_OR) {
			op = CCodeBinaryOperator.BITWISE_OR;
		} else if (expr.operator == BinaryOperator.BITWISE_XOR) {
			op = CCodeBinaryOperator.BITWISE_XOR;
		} else if (expr.operator == BinaryOperator.AND) {
			op = CCodeBinaryOperator.AND;
		} else if (expr.operator == BinaryOperator.OR) {
			op = CCodeBinaryOperator.OR;
		}
		
		var cleft = (CCodeExpression) expr.left.ccodenode;
		var cright = (CCodeExpression) expr.right.ccodenode;
		
		if (expr.operator == BinaryOperator.EQUALITY ||
		    expr.operator == BinaryOperator.INEQUALITY) {
			if (expr.left.static_type != null && expr.right.static_type != null &&
			    expr.left.static_type.data_type is Class && expr.right.static_type.data_type is Class) {
				var left_cl = (Class) expr.left.static_type.data_type;
				var right_cl = (Class) expr.right.static_type.data_type;
				
				if (left_cl != right_cl) {
					if (left_cl.is_subtype_of (right_cl)) {
						cleft = new InstanceCast (cleft, right_cl);
					} else if (right_cl.is_subtype_of (left_cl)) {
						cright = new InstanceCast (cright, left_cl);
					}
				}
			}
		}
		
		expr.ccodenode = new CCodeBinaryExpression (op, cleft, cright);
		
		visit_expression (expr);
	}

	public override void visit_type_check (TypeCheck! expr) {
		var ccheck = new CCodeFunctionCall (new CCodeIdentifier (expr.type_reference.data_type.get_upper_case_cname ("IS_")));
		ccheck.add_argument ((CCodeExpression) expr.expression.ccodenode);
		expr.ccodenode = ccheck;
	}

	public override void visit_conditional_expression (ConditionalExpression! expr) {
		expr.ccodenode = new CCodeConditionalExpression ((CCodeExpression) expr.condition.ccodenode, (CCodeExpression) expr.true_expression.ccodenode, (CCodeExpression) expr.false_expression.ccodenode);
	}

	public override void visit_end_lambda_expression (LambdaExpression! l) {
		l.ccodenode = new CCodeIdentifier (l.method.get_cname ());
	}

	private CCodeExpression! convert_from_generic_pointer (CCodeExpression! cexpr, TypeReference! actual_type) {
		var result = cexpr;
		if (actual_type.data_type is Struct) {
			var st = (Struct) actual_type.data_type;
			if (st == uint_type.data_type) {
				var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GPOINTER_TO_UINT"));
				cconv.add_argument (cexpr);
				result = cconv;
			} else if (st == bool_type.data_type || st.is_integer_type ()) {
				var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GPOINTER_TO_INT"));
				cconv.add_argument (cexpr);
				result = cconv;
			}
		}
		return result;
	}

	private CCodeExpression! convert_to_generic_pointer (CCodeExpression! cexpr, TypeReference! actual_type) {
		var result = cexpr;
		if (actual_type.data_type is Struct) {
			var st = (Struct) actual_type.data_type;
			if (st == uint_type.data_type) {
				var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GUINT_TO_POINTER"));
				cconv.add_argument (cexpr);
				result = cconv;
			} else if (st == bool_type.data_type || st.is_integer_type ()) {
				var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GINT_TO_POINTER"));
				cconv.add_argument (cexpr);
				result = cconv;
			}
		}
		return result;
	}
}
