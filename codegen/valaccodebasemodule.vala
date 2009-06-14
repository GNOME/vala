/* valaccodebasemodule.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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
internal class Vala.CCodeBaseModule : CCodeModule {
	public CodeContext context { get; set; }

	public Symbol root_symbol;
	public Symbol current_symbol;
	public TypeSymbol current_type_symbol;
	public Class current_class;
	public Method current_method;
	public DataType current_return_type;
	public TryStatement current_try;
	public PropertyAccessor current_property_accessor;

	public CCodeDeclarationSpace header_declarations;
	public CCodeDeclarationSpace internal_header_declarations;
	public CCodeDeclarationSpace source_declarations;

	public CCodeFragment source_signal_marshaller_declaration;
	public CCodeFragment source_type_member_definition;
	public CCodeFragment class_init_fragment;
	public CCodeFragment base_init_fragment;
	public CCodeFragment class_finalize_fragment;
	public CCodeFragment base_finalize_fragment;
	public CCodeFragment instance_init_fragment;
	public CCodeFragment instance_finalize_fragment;
	public CCodeFragment source_signal_marshaller_definition;
	public CCodeFragment module_init_fragment;
	
	public CCodeStruct param_spec_struct;
	public CCodeStruct closure_struct;
	public CCodeEnum prop_enum;
	public CCodeFunction function;

	// code nodes to be inserted before the current statement
	// used by async method calls in coroutines
	public CCodeFragment pre_statement_fragment;

	/* all temporary variables */
	public ArrayList<LocalVariable> temp_vars = new ArrayList<LocalVariable> ();
	/* temporary variables that own their content */
	public ArrayList<LocalVariable> temp_ref_vars = new ArrayList<LocalVariable> ();
	/* cache to check whether a certain marshaller has been created yet */
	public Gee.Set<string> user_marshal_set;
	/* (constant) hash table with all predefined marshallers */
	public Gee.Set<string> predefined_marshal_set;
	/* (constant) hash table with all reserved identifiers in the generated code */
	Gee.Set<string> reserved_identifiers;
	
	public int next_temp_var_id = 0;
	public bool in_creation_method = false;
	public bool in_constructor = false;
	public bool in_static_or_class_ctor = false;
	public bool current_method_inner_error = false;
	public int next_coroutine_state = 1;

	public DataType bool_type;
	public DataType char_type;
	public DataType uchar_type;
	public DataType? unichar_type;
	public DataType short_type;
	public DataType ushort_type;
	public DataType int_type;
	public DataType uint_type;
	public DataType long_type;
	public DataType ulong_type;
	public DataType int8_type;
	public DataType uint8_type;
	public DataType int16_type;
	public DataType uint16_type;
	public DataType int32_type;
	public DataType uint32_type;
	public DataType int64_type;
	public DataType uint64_type;
	public DataType string_type;
	public DataType float_type;
	public DataType double_type;
	public TypeSymbol gtype_type;
	public TypeSymbol gobject_type;
	public ErrorType gerror_type;
	public Class glist_type;
	public Class gslist_type;
	public TypeSymbol gstringbuilder_type;
	public TypeSymbol garray_type;
	public TypeSymbol gbytearray_type;
	public TypeSymbol gptrarray_type;
	public DataType gquark_type;
	public Struct gvalue_type;
	public Struct mutex_type;
	public TypeSymbol type_module_type;
	public TypeSymbol dbus_object_type;

	public bool in_plugin = false;
	public string module_init_param_name;
	
	public bool gvaluecollector_h_needed;
	public bool requires_array_free;
	public bool requires_array_move;
	public bool requires_array_length;
	public bool requires_strcmp0;
	public bool dbus_glib_h_needed;
	public bool dbus_glib_h_needed_in_header;

	public Set<string> wrappers;
	Set<Symbol> generated_external_symbols;

	public Map<string,string> variable_name_map = new HashMap<string,string> (str_hash, str_equal);

	public CCodeBaseModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);

		predefined_marshal_set = new HashSet<string> (str_hash, str_equal);
		predefined_marshal_set.add ("VOID:VOID");
		predefined_marshal_set.add ("VOID:BOOLEAN");
		predefined_marshal_set.add ("VOID:CHAR");
		predefined_marshal_set.add ("VOID:UCHAR");
		predefined_marshal_set.add ("VOID:INT");
		predefined_marshal_set.add ("VOID:UINT");
		predefined_marshal_set.add ("VOID:LONG");
		predefined_marshal_set.add ("VOID:ULONG");
		predefined_marshal_set.add ("VOID:ENUM");
		predefined_marshal_set.add ("VOID:FLAGS");
		predefined_marshal_set.add ("VOID:FLOAT");
		predefined_marshal_set.add ("VOID:DOUBLE");
		predefined_marshal_set.add ("VOID:STRING");
		predefined_marshal_set.add ("VOID:POINTER");
		predefined_marshal_set.add ("VOID:OBJECT");
		predefined_marshal_set.add ("STRING:OBJECT,POINTER");
		predefined_marshal_set.add ("VOID:UINT,POINTER");
		predefined_marshal_set.add ("BOOLEAN:FLAGS");

		reserved_identifiers = new HashSet<string> (str_hash, str_equal);

		// C99 keywords
		reserved_identifiers.add ("_Bool");
		reserved_identifiers.add ("_Complex");
		reserved_identifiers.add ("_Imaginary");
		reserved_identifiers.add ("auto");
		reserved_identifiers.add ("break");
		reserved_identifiers.add ("case");
		reserved_identifiers.add ("char");
		reserved_identifiers.add ("const");
		reserved_identifiers.add ("continue");
		reserved_identifiers.add ("default");
		reserved_identifiers.add ("do");
		reserved_identifiers.add ("double");
		reserved_identifiers.add ("else");
		reserved_identifiers.add ("enum");
		reserved_identifiers.add ("extern");
		reserved_identifiers.add ("float");
		reserved_identifiers.add ("for");
		reserved_identifiers.add ("goto");
		reserved_identifiers.add ("if");
		reserved_identifiers.add ("inline");
		reserved_identifiers.add ("int");
		reserved_identifiers.add ("long");
		reserved_identifiers.add ("register");
		reserved_identifiers.add ("restrict");
		reserved_identifiers.add ("return");
		reserved_identifiers.add ("short");
		reserved_identifiers.add ("signed");
		reserved_identifiers.add ("sizeof");
		reserved_identifiers.add ("static");
		reserved_identifiers.add ("struct");
		reserved_identifiers.add ("switch");
		reserved_identifiers.add ("typedef");
		reserved_identifiers.add ("union");
		reserved_identifiers.add ("unsigned");
		reserved_identifiers.add ("void");
		reserved_identifiers.add ("volatile");
		reserved_identifiers.add ("while");

		// MSVC keywords
		reserved_identifiers.add ("cdecl");

		// reserved for Vala/GObject naming conventions
		reserved_identifiers.add ("error");
		reserved_identifiers.add ("result");
		reserved_identifiers.add ("self");
	}

	public override void emit (CodeContext context) {
		this.context = context;

		root_symbol = context.root;

		bool_type = new BooleanType ((Struct) root_symbol.scope.lookup ("bool"));
		char_type = new IntegerType ((Struct) root_symbol.scope.lookup ("char"));
		uchar_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uchar"));
		short_type = new IntegerType ((Struct) root_symbol.scope.lookup ("short"));
		ushort_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ushort"));
		int_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int"));
		uint_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint"));
		long_type = new IntegerType ((Struct) root_symbol.scope.lookup ("long"));
		ulong_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ulong"));
		int8_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int8"));
		uint8_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint8"));
		int16_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int16"));
		uint16_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint16"));
		int32_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int32"));
		uint32_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint32"));
		int64_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int64"));
		uint64_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint64"));
		float_type = new FloatingType ((Struct) root_symbol.scope.lookup ("float"));
		double_type = new FloatingType ((Struct) root_symbol.scope.lookup ("double"));
		string_type = new ObjectType ((Class) root_symbol.scope.lookup ("string"));

		var unichar_struct = (Struct) root_symbol.scope.lookup ("unichar");
		if (unichar_struct != null) {
			unichar_type = new IntegerType (unichar_struct);
		}

		if (context.profile == Profile.GOBJECT) {
			var glib_ns = root_symbol.scope.lookup ("GLib");

			gtype_type = (TypeSymbol) glib_ns.scope.lookup ("Type");
			gobject_type = (TypeSymbol) glib_ns.scope.lookup ("Object");
			gerror_type = new ErrorType (null, null);
			glist_type = (Class) glib_ns.scope.lookup ("List");
			gslist_type = (Class) glib_ns.scope.lookup ("SList");
			gstringbuilder_type = (TypeSymbol) glib_ns.scope.lookup ("StringBuilder");
			garray_type = (TypeSymbol) glib_ns.scope.lookup ("Array");
			gbytearray_type = (TypeSymbol) glib_ns.scope.lookup ("ByteArray");
			gptrarray_type = (TypeSymbol) glib_ns.scope.lookup ("PtrArray");

			gquark_type = new IntegerType ((Struct) glib_ns.scope.lookup ("Quark"));
			gvalue_type = (Struct) glib_ns.scope.lookup ("Value");
			mutex_type = (Struct) glib_ns.scope.lookup ("StaticRecMutex");

			type_module_type = (TypeSymbol) glib_ns.scope.lookup ("TypeModule");

			if (context.module_init_method != null) {
				module_init_fragment = new CCodeFragment ();
				foreach (FormalParameter parameter in context.module_init_method.get_parameters ()) {
					if (parameter.parameter_type.data_type == type_module_type) {
						in_plugin = true;
						module_init_param_name = parameter.name;
						break;
					}
				}
			}

			var dbus_ns = root_symbol.scope.lookup ("DBus");
			if (dbus_ns != null) {
				dbus_object_type = (TypeSymbol) dbus_ns.scope.lookup ("Object");
			}
		}

		header_declarations = new CCodeDeclarationSpace ();
		internal_header_declarations = new CCodeDeclarationSpace ();

		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (!file.external_package) {
				file.accept (codegen);
			}
		}

		// generate C header file for public API
		if (context.header_filename != null) {
			var writer = new CCodeWriter (context.header_filename);
			if (!writer.open ()) {
				Report.error (null, "unable to open `%s' for writing".printf (writer.filename));
				return;
			}
			writer.write_newline ();

			var once = new CCodeOnceSection (get_define_for_filename (writer.filename));
			once.append (new CCodeNewline ());
			once.append (header_declarations.include_directives);
			once.append (new CCodeNewline ());

			if (context.profile == Profile.GOBJECT) {
				once.append (new CCodeIdentifier ("G_BEGIN_DECLS"));
				once.append (new CCodeNewline ());
			}

			once.append (new CCodeNewline ());
			once.append (header_declarations.type_declaration);
			once.append (new CCodeNewline ());
			once.append (header_declarations.type_definition);
			once.append (new CCodeNewline ());
			once.append (header_declarations.type_member_declaration);
			once.append (new CCodeNewline ());
			once.append (header_declarations.constant_declaration);
			once.append (new CCodeNewline ());

			if (context.profile == Profile.GOBJECT) {
				once.append (new CCodeIdentifier ("G_END_DECLS"));
				once.append (new CCodeNewline ());
			}

			once.append (new CCodeNewline ());
			once.write (writer);
			writer.close ();
		}

		// generate C header file for internal API
		if (context.internal_header_filename != null) {
			var writer = new CCodeWriter (context.internal_header_filename);
			if (!writer.open ()) {
				Report.error (null, "unable to open `%s' for writing".printf (writer.filename));
				return;
			}
			writer.write_newline ();

			var once = new CCodeOnceSection (get_define_for_filename (writer.filename));
			once.append (new CCodeNewline ());
			once.append (internal_header_declarations.include_directives);
			once.append (new CCodeNewline ());

			if (context.profile == Profile.GOBJECT) {
				once.append (new CCodeIdentifier ("G_BEGIN_DECLS"));
				once.append (new CCodeNewline ());
			}

			once.append (new CCodeNewline ());
			once.append (internal_header_declarations.type_declaration);
			once.append (new CCodeNewline ());
			once.append (internal_header_declarations.type_definition);
			once.append (new CCodeNewline ());
			once.append (internal_header_declarations.type_member_declaration);
			once.append (new CCodeNewline ());
			once.append (internal_header_declarations.constant_declaration);
			once.append (new CCodeNewline ());

			if (context.profile == Profile.GOBJECT) {
				once.append (new CCodeIdentifier ("G_END_DECLS"));
				once.append (new CCodeNewline ());
			}

			once.append (new CCodeNewline ());
			once.write (writer);
			writer.close ();
		}
	}

	public override CCodeIdentifier get_value_setter_function (DataType type_reference) {
		if (type_reference.data_type != null) {
			return new CCodeIdentifier (type_reference.data_type.get_set_value_function ());
		} else {
			return new CCodeIdentifier ("g_value_set_pointer");
		}
	}

	public virtual void append_vala_array_free () {
	}

	public virtual void append_vala_array_move () {
	}

	public virtual void append_vala_array_length () {
	}

	private void append_vala_strcmp0 () {
		var fun = new CCodeFunction ("_vala_strcmp0", "int");
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeFormalParameter ("str1", "const char *"));
		fun.add_parameter (new CCodeFormalParameter ("str2", "const char *"));
		source_declarations.add_type_member_declaration (fun.copy ());

		// (str1 != str2)
		var cineq = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("str1"), new CCodeIdentifier ("str2"));

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

		source_type_member_definition.append (fun);
	}

	public override void visit_source_file (SourceFile source_file) {
		source_declarations = new CCodeDeclarationSpace ();
		source_type_member_definition = new CCodeFragment ();
		source_signal_marshaller_definition = new CCodeFragment ();
		source_signal_marshaller_declaration = new CCodeFragment ();
		
		user_marshal_set = new HashSet<string> (str_hash, str_equal);
		
		next_temp_var_id = 0;
		variable_name_map.clear ();
		
		gvaluecollector_h_needed = false;
		dbus_glib_h_needed = false;
		dbus_glib_h_needed_in_header = false;
		requires_array_free = false;
		requires_array_move = false;
		requires_array_length = false;
		requires_strcmp0 = false;

		wrappers = new HashSet<string> (str_hash, str_equal);
		generated_external_symbols = new HashSet<Symbol> ();

		if (context.profile == Profile.GOBJECT) {
			header_declarations.add_include ("glib.h");
			internal_header_declarations.add_include ("glib.h");
			source_declarations.add_include ("glib.h");
			source_declarations.add_include ("glib-object.h");
		}

		source_file.accept_children (codegen);

		if (context.report.get_errors () > 0) {
			return;
		}

		if (requires_array_free) {
			append_vala_array_free ();
		}
		if (requires_array_move) {
			append_vala_array_move ();
		}
		if (requires_array_length) {
			append_vala_array_length ();
		}
		if (requires_strcmp0) {
			append_vala_strcmp0 ();
		}

		if (gvaluecollector_h_needed) {
			source_declarations.add_include ("gobject/gvaluecollector.h");
		}

		if (dbus_glib_h_needed) {
			source_declarations.add_include ("dbus/dbus.h");
			source_declarations.add_include ("dbus/dbus-glib.h");
			source_declarations.add_include ("dbus/dbus-glib-lowlevel.h");
		}
		if (dbus_glib_h_needed_in_header || dbus_glib_h_needed) {
			var dbusvtable = new CCodeStruct ("_DBusObjectVTable");
			dbusvtable.add_field ("void", "(*register_object) (DBusConnection*, const char*, void*)");
			source_declarations.add_type_definition (dbusvtable);

			source_declarations.add_type_declaration (new CCodeTypeDefinition ("struct _DBusObjectVTable", new CCodeVariableDeclarator ("_DBusObjectVTable")));

			var cfunc = new CCodeFunction ("_vala_dbus_register_object", "void");
			cfunc.add_parameter (new CCodeFormalParameter ("connection", "DBusConnection*"));
			cfunc.add_parameter (new CCodeFormalParameter ("path", "const char*"));
			cfunc.add_parameter (new CCodeFormalParameter ("object", "void*"));

			cfunc.modifiers |= CCodeModifiers.STATIC;
			source_declarations.add_type_member_declaration (cfunc.copy ());

			var block = new CCodeBlock ();
			cfunc.block = block;

			var cdecl = new CCodeDeclaration ("const _DBusObjectVTable *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("vtable"));
			block.add_statement (cdecl);

			var quark = new CCodeFunctionCall (new CCodeIdentifier ("g_quark_from_static_string"));
			quark.add_argument (new CCodeConstant ("\"DBusObjectVTable\""));

			var get_qdata = new CCodeFunctionCall (new CCodeIdentifier ("g_type_get_qdata"));
			get_qdata.add_argument (new CCodeIdentifier ("G_TYPE_FROM_INSTANCE (object)"));
			get_qdata.add_argument (quark);

			block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("vtable"), get_qdata)));

			var cregister = new CCodeFunctionCall (new CCodeMemberAccess.pointer (new CCodeIdentifier ("vtable"), "register_object"));
			cregister.add_argument (new CCodeIdentifier ("connection"));
			cregister.add_argument (new CCodeIdentifier ("path"));
			cregister.add_argument (new CCodeIdentifier ("object"));

			var ifblock = new CCodeBlock ();
			ifblock.add_statement (new CCodeExpressionStatement (cregister));

			var elseblock = new CCodeBlock ();

			var warn = new CCodeFunctionCall (new CCodeIdentifier ("g_warning"));
			warn.add_argument (new CCodeConstant ("\"Object does not implement any D-Bus interface\""));

			elseblock.add_statement (new CCodeExpressionStatement(warn));

			block.add_statement (new CCodeIfStatement (new CCodeIdentifier ("vtable"), ifblock, elseblock));

			source_type_member_definition.append (cfunc);

			// unregister function
			cfunc = new CCodeFunction ("_vala_dbus_unregister_object", "void");
			cfunc.add_parameter (new CCodeFormalParameter ("connection", "gpointer"));
			cfunc.add_parameter (new CCodeFormalParameter ("object", "GObject*"));

			cfunc.modifiers |= CCodeModifiers.STATIC;
			source_declarations.add_type_member_declaration (cfunc.copy ());

			block = new CCodeBlock ();
			cfunc.block = block;

			cdecl = new CCodeDeclaration ("char*");
			cdecl.add_declarator (new CCodeVariableDeclarator ("path"));
			block.add_statement (cdecl);

			var path = new CCodeFunctionCall (new CCodeIdentifier ("g_object_steal_data"));
			path.add_argument (new CCodeCastExpression (new CCodeIdentifier ("object"), "GObject*"));
			path.add_argument (new CCodeConstant ("\"dbus_object_path\""));
			block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("path"), path)));

			var unregister_call = new CCodeFunctionCall (new CCodeIdentifier ("dbus_connection_unregister_object_path"));
			unregister_call.add_argument (new CCodeIdentifier ("connection"));
			unregister_call.add_argument (new CCodeIdentifier ("path"));
			block.add_statement (new CCodeExpressionStatement (unregister_call));

			var path_free = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
			path_free.add_argument (new CCodeIdentifier ("path"));
			block.add_statement (new CCodeExpressionStatement (path_free));

			source_type_member_definition.append (cfunc);
		}

		CCodeComment comment = null;
		if (source_file.comment != null) {
			comment = new CCodeComment (source_file.comment);
		}
		
		var writer = new CCodeWriter (source_file.get_csource_filename ());
		if (!writer.open ()) {
			Report.error (null, "unable to open `%s' for writing".printf (writer.filename));
			return;
		}
		writer.line_directives = context.debug;
		if (comment != null) {
			comment.write (writer);
		}
		writer.write_newline ();
		source_declarations.include_directives.write (writer);
		writer.write_newline ();
		source_declarations.type_declaration.write_combined (writer);
		writer.write_newline ();
		source_declarations.type_definition.write_combined (writer);
		writer.write_newline ();
		source_declarations.type_member_declaration.write_declaration (writer);
		writer.write_newline ();
		source_declarations.type_member_declaration.write (writer);
		writer.write_newline ();
		source_declarations.constant_declaration.write (writer);
		writer.write_newline ();
		source_signal_marshaller_declaration.write_declaration (writer);
		source_signal_marshaller_declaration.write (writer);
		writer.write_newline ();
		source_type_member_definition.write (writer);
		writer.write_newline ();
		source_signal_marshaller_definition.write (writer);
		writer.write_newline ();
		writer.close ();

		source_declarations = null;
		source_type_member_definition = null;
		source_signal_marshaller_definition = null;
		source_signal_marshaller_declaration = null;
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

	public void generate_enum_declaration (Enum en, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (en, en.get_cname ())) {
			return;
		}

		var cenum = new CCodeEnum (en.get_cname ());

		foreach (EnumValue ev in en.get_values ()) {
			if (ev.value == null) {
				cenum.add_value (new CCodeEnumValue (ev.get_cname ()));
			} else {
				ev.value.accept (codegen);
				cenum.add_value (new CCodeEnumValue (ev.get_cname (), (CCodeExpression) ev.value.ccodenode));
			}
		}
		
		if (en.source_reference.comment != null) {
			decl_space.add_type_definition (new CCodeComment (en.source_reference.comment));
		}

		decl_space.add_type_definition (cenum);
		decl_space.add_type_definition (new CCodeNewline ());

		if (!en.has_type_id) {
			return;
		}

		decl_space.add_type_declaration (new CCodeNewline ());

		var macro = "(%s_get_type ())".printf (en.get_lower_case_cname (null));
		decl_space.add_type_declaration (new CCodeMacroReplacement (en.get_type_id (), macro));

		var fun_name = "%s_get_type".printf (en.get_lower_case_cname (null));
		var regfun = new CCodeFunction (fun_name, "GType");

		if (en.access == SymbolAccessibility.PRIVATE) {
			regfun.modifiers = CCodeModifiers.STATIC;
		}

		decl_space.add_type_member_declaration (regfun);
	}

	public override void visit_enum (Enum en) {
		en.accept_children (codegen);

		generate_enum_declaration (en, source_declarations);

		if (!en.is_internal_symbol ()) {
			generate_enum_declaration (en, header_declarations);
		}
		generate_enum_declaration (en, internal_header_declarations);

		if (!en.has_type_id) {
			return;
		}

		var clist = new CCodeInitializerList (); /* or during visit time? */
		CCodeInitializerList clist_ev = null;
		foreach (EnumValue ev in en.get_values ()) {
			clist_ev = new CCodeInitializerList ();
			clist_ev.append (new CCodeConstant (ev.get_cname ()));
			clist_ev.append (new CCodeIdentifier ("\"%s\"".printf (ev.get_cname ())));
			clist_ev.append (ev.get_canonical_cconstant ());
			clist.append (clist_ev);
		}

		clist_ev = new CCodeInitializerList ();
		clist_ev.append (new CCodeConstant ("0"));
		clist_ev.append (new CCodeConstant ("NULL"));
		clist_ev.append (new CCodeConstant ("NULL"));
		clist.append (clist_ev);

		var enum_decl = new CCodeVariableDeclarator ("values[]", clist);

		CCodeDeclaration cdecl = null;
		if (en.is_flags) {
			cdecl = new CCodeDeclaration ("const GFlagsValue");
		} else {
			cdecl = new CCodeDeclaration ("const GEnumValue");
		}

		cdecl.add_declarator (enum_decl);
		cdecl.modifiers = CCodeModifiers.STATIC;

		var type_init = new CCodeBlock ();

		type_init.add_statement (cdecl);

		var fun_name = "%s_get_type".printf (en.get_lower_case_cname (null));
		var regfun = new CCodeFunction (fun_name, "GType");
		var regblock = new CCodeBlock ();

		cdecl = new CCodeDeclaration ("GType");
		string type_id_name = "%s_type_id".printf (en.get_lower_case_cname (null));
		cdecl.add_declarator (new CCodeVariableDeclarator (type_id_name, new CCodeConstant ("0")));
		cdecl.modifiers = CCodeModifiers.STATIC;
		regblock.add_statement (cdecl);

		CCodeFunctionCall reg_call;
		if (en.is_flags) {
			reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_flags_register_static"));
		} else {
			reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_enum_register_static"));
		}

		reg_call.add_argument (new CCodeConstant ("\"%s\"".printf (en.get_cname())));
		reg_call.add_argument (new CCodeIdentifier ("values"));

		type_init.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier (type_id_name), reg_call)));

		var cond = new CCodeFunctionCall (new CCodeIdentifier ("G_UNLIKELY"));
		cond.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier (type_id_name), new CCodeConstant ("0")));
		var cif = new CCodeIfStatement (cond, type_init);
		regblock.add_statement (cif);

		regblock.add_statement (new CCodeReturnStatement (new CCodeConstant (type_id_name)));

		if (en.access == SymbolAccessibility.PRIVATE) {
			regfun.modifiers = CCodeModifiers.STATIC;
		}
		regfun.block = regblock;

		source_type_member_definition.append (new CCodeNewline ());
		source_type_member_definition.append (regfun);
	}

	public override void visit_member (Member m) {
		/* stuff meant for all lockable members */
		if (m is Lockable && ((Lockable) m).get_lock_used ()) {
			CCodeExpression l = new CCodeIdentifier ("self");
			l = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (l, "priv"), get_symbol_lock_name (m));

			var initf = new CCodeFunctionCall (new CCodeIdentifier (mutex_type.default_construction_method.get_cname ()));
			initf.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));
			instance_init_fragment.append (new CCodeExpressionStatement (initf));

			if (instance_finalize_fragment != null) {
				var fc = new CCodeFunctionCall (new CCodeIdentifier ("g_static_rec_mutex_free"));
				fc.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));
				instance_finalize_fragment.append (new CCodeExpressionStatement (fc));
			}
		}
	}

	public void generate_constant_declaration (Constant c, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (c, c.get_cname ())) {
			return;
		}

		c.accept_children (codegen);

		if (!c.external) {
			if (c.initializer is InitializerList) {
				var cdecl = new CCodeDeclaration (c.type_reference.get_const_cname ());
				var arr = "";
				if (c.type_reference is ArrayType) {
					arr = "[]";
				}
				cdecl.add_declarator (new CCodeVariableDeclarator ("%s%s".printf (c.get_cname (), arr), (CCodeExpression) c.initializer.ccodenode));
				cdecl.modifiers = CCodeModifiers.STATIC;
		
				decl_space.add_constant_declaration (cdecl);
			} else {
				var cdefine = new CCodeMacroReplacement.with_expression (c.get_cname (), (CCodeExpression) c.initializer.ccodenode);
				decl_space.add_type_member_declaration (cdefine);
			}
		}
	}

	public override void visit_constant (Constant c) {
		generate_constant_declaration (c, source_declarations);

		if (!c.is_internal_symbol ()) {
			generate_constant_declaration (c, header_declarations);
		}
		generate_constant_declaration (c, internal_header_declarations);
	}

	public void generate_field_declaration (Field f, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (f, f.get_cname ())) {
			return;
		}

		string field_ctype = f.field_type.get_cname ();
		if (f.is_volatile) {
			field_ctype = "volatile " + field_ctype;
		}

		var cdecl = new CCodeDeclaration (field_ctype);
		cdecl.add_declarator (new CCodeVariableDeclarator (f.get_cname ()));
		if (f.is_private_symbol ()) {
			cdecl.modifiers = CCodeModifiers.STATIC;
		} else {
			cdecl.modifiers = CCodeModifiers.EXTERN;
		}
		decl_space.add_type_member_declaration (cdecl);

		if (f.field_type is ArrayType && !f.no_array_length) {
			var array_type = (ArrayType) f.field_type;

			for (int dim = 1; dim <= array_type.rank; dim++) {
				var len_type = int_type.copy ();

				cdecl = new CCodeDeclaration (len_type.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator (head.get_array_length_cname (f.get_cname (), dim)));
				if (f.is_private_symbol ()) {
					cdecl.modifiers = CCodeModifiers.STATIC;
				} else {
					cdecl.modifiers = CCodeModifiers.EXTERN;
				}
				decl_space.add_type_member_declaration (cdecl);
			}
		} else if (f.field_type is DelegateType) {
			var delegate_type = (DelegateType) f.field_type;
			if (delegate_type.delegate_symbol.has_target) {
				// create field to store delegate target

				cdecl = new CCodeDeclaration ("gpointer");
				cdecl.add_declarator (new CCodeVariableDeclarator (get_delegate_target_cname  (f.get_cname ())));
				if (f.is_private_symbol ()) {
					cdecl.modifiers = CCodeModifiers.STATIC;
				} else {
					cdecl.modifiers = CCodeModifiers.EXTERN;
				}
				decl_space.add_type_member_declaration (cdecl);
			}
		}
	}

	public override void visit_field (Field f) {
		check_type (f.field_type);

		f.accept_children (codegen);

		var cl = f.parent_symbol as Class;
		bool is_gtypeinstance = (cl != null && !cl.is_compact);

		CCodeExpression lhs = null;

		string field_ctype = f.field_type.get_cname ();
		if (f.is_volatile) {
			field_ctype = "volatile " + field_ctype;
		}

		if (f.binding == MemberBinding.INSTANCE)  {
			if (is_gtypeinstance && f.access == SymbolAccessibility.PRIVATE) {
				lhs = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), f.get_cname ());
			} else {
				lhs = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), f.get_cname ());
			}

			if (f.initializer != null) {
				var rhs = (CCodeExpression) f.initializer.ccodenode;

				instance_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (lhs, rhs)));

				if (f.field_type is ArrayType && !f.no_array_length &&
				    f.initializer is ArrayCreationExpression) {
					var array_type = (ArrayType) f.field_type;
					var this_access = new MemberAccess.simple ("this");
					this_access.value_type = get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);
					this_access.ccodenode = new CCodeIdentifier ("self");
					var ma = new MemberAccess (this_access, f.name);
					ma.symbol_reference = f;
					
					Gee.List<Expression> sizes = ((ArrayCreationExpression) f.initializer).get_sizes ();
					for (int dim = 1; dim <= array_type.rank; dim++) {
						var array_len_lhs = head.get_array_length_cexpression (ma, dim);
						var size = sizes[dim - 1];
						instance_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (array_len_lhs, (CCodeExpression) size.ccodenode)));
					}
				}

				append_temp_decl (instance_init_fragment, temp_vars);
				temp_vars.clear ();
			}
			
			if (requires_destroy (f.field_type) && instance_finalize_fragment != null) {
				var this_access = new MemberAccess.simple ("this");
				this_access.value_type = get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);

				var field_st = f.parent_symbol as Struct;
				if (field_st != null && !field_st.is_simple_type ()) {
					this_access.ccodenode = new CCodeIdentifier ("(*self)");
				} else {
					this_access.ccodenode = new CCodeIdentifier ("self");
				}

				var ma = new MemberAccess (this_access, f.name);
				ma.symbol_reference = f;
				instance_finalize_fragment.append (new CCodeExpressionStatement (get_unref_expression (lhs, f.field_type, ma)));
			}
		} else if (f.binding == MemberBinding.CLASS)  {
			if (!is_gtypeinstance) {
				Report.error (f.source_reference, "class fields are not supported in compact classes");
				f.error = true;
				return;
			}
		} else {
			generate_field_declaration (f, source_declarations);

			if (!f.is_internal_symbol ()) {
				generate_field_declaration (f, header_declarations);
			}
			generate_field_declaration (f, internal_header_declarations);

			lhs = new CCodeIdentifier (f.get_cname ());

			var var_decl = new CCodeVariableDeclarator (f.get_cname ());
			var_decl.initializer = default_value_for_type (f.field_type, true);

			if (f.initializer != null) {
				var init = (CCodeExpression) f.initializer.ccodenode;
				if (is_constant_ccode_expression (init)) {
					var_decl.initializer = init;
				}
			}

			var var_def = new CCodeDeclaration (field_ctype);
			var_def.add_declarator (var_decl);
			if (!f.is_private_symbol ()) {
				var_def.modifiers = CCodeModifiers.EXTERN;
			} else {
				var_def.modifiers = CCodeModifiers.STATIC;
			}
			source_declarations.add_type_member_declaration (var_def);

			/* add array length fields where necessary */
			if (f.field_type is ArrayType && !f.no_array_length) {
				var array_type = (ArrayType) f.field_type;

				for (int dim = 1; dim <= array_type.rank; dim++) {
					var len_type = int_type.copy ();

					var len_def = new CCodeDeclaration (len_type.get_cname ());
					len_def.add_declarator (new CCodeVariableDeclarator (head.get_array_length_cname (f.get_cname (), dim), new CCodeConstant ("0")));
					if (!f.is_private_symbol ()) {
						len_def.modifiers = CCodeModifiers.EXTERN;
					} else {
						len_def.modifiers = CCodeModifiers.STATIC;
					}
					source_declarations.add_type_member_declaration (len_def);
				}

				if (array_type.rank == 1 && f.is_internal_symbol ()) {
					var len_type = int_type.copy ();

					var cdecl = new CCodeDeclaration (len_type.get_cname ());
					cdecl.add_declarator (new CCodeVariableDeclarator (head.get_array_size_cname (f.get_cname ()), new CCodeConstant ("0")));
					cdecl.modifiers = CCodeModifiers.STATIC;
					source_declarations.add_type_member_declaration (cdecl);
				}
			} else if (f.field_type is DelegateType) {
				var delegate_type = (DelegateType) f.field_type;
				if (delegate_type.delegate_symbol.has_target) {
					// create field to store delegate target

					var target_def = new CCodeDeclaration ("gpointer");
					target_def.add_declarator (new CCodeVariableDeclarator (get_delegate_target_cname  (f.get_cname ()), new CCodeConstant ("NULL")));
					if (!f.is_private_symbol ()) {
						target_def.modifiers = CCodeModifiers.EXTERN;
					} else {
						target_def.modifiers = CCodeModifiers.STATIC;
					}
					source_declarations.add_type_member_declaration (target_def);
				}
			}

			if (f.initializer != null) {
				var rhs = (CCodeExpression) f.initializer.ccodenode;
				if (!is_constant_ccode_expression (rhs)) {
					if (f.parent_symbol is Class) {
						class_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (lhs, rhs)));

						if (f.field_type is ArrayType && !f.no_array_length &&
						    f.initializer is ArrayCreationExpression) {
							var array_type = (ArrayType) f.field_type;
							var ma = new MemberAccess.simple (f.name);
							ma.symbol_reference = f;
					
							Gee.List<Expression> sizes = ((ArrayCreationExpression) f.initializer).get_sizes ();
							for (int dim = 1; dim <= array_type.rank; dim++) {
								var array_len_lhs = head.get_array_length_cexpression (ma, dim);
								var size = sizes[dim - 1];
								class_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (array_len_lhs, (CCodeExpression) size.ccodenode)));
							}
						}

						append_temp_decl (class_init_fragment, temp_vars);
						temp_vars.clear ();
					} else {
						f.error = true;
						Report.error (f.source_reference, "Non-constant field initializers not supported in this context");
						return;
					}
				}
			}
		}
	}

	public bool is_constant_ccode_expression (CCodeExpression cexpr) {
		if (cexpr is CCodeConstant) {
			return true;
		} else if (cexpr is CCodeBinaryExpression) {
			var cbinary = (CCodeBinaryExpression) cexpr;
			return is_constant_ccode_expression (cbinary.left) && is_constant_ccode_expression (cbinary.right);
		}

		var cparenthesized = (cexpr as CCodeParenthesizedExpression);
		return (null != cparenthesized && is_constant_ccode_expression (cparenthesized.inner));
	}

	/**
	 * Returns whether the passed cexpr is a pure expression, i.e. an
	 * expression without side-effects.
	 */
	public bool is_pure_ccode_expression (CCodeExpression cexpr) {
		if (cexpr is CCodeConstant || cexpr is CCodeIdentifier) {
			return true;
		} else if (cexpr is CCodeBinaryExpression) {
			var cbinary = (CCodeBinaryExpression) cexpr;
			return is_pure_ccode_expression (cbinary.left) && is_constant_ccode_expression (cbinary.right);
		} else if (cexpr is CCodeUnaryExpression) {
			var cunary = (CCodeUnaryExpression) cexpr;
			switch (cunary.operator) {
			case CCodeUnaryOperator.PREFIX_INCREMENT:
			case CCodeUnaryOperator.PREFIX_DECREMENT:
			case CCodeUnaryOperator.POSTFIX_INCREMENT:
			case CCodeUnaryOperator.POSTFIX_DECREMENT:
				return false;
			default:
				return is_pure_ccode_expression (cunary.inner);
			}
		} else if (cexpr is CCodeMemberAccess) {
			var cma = (CCodeMemberAccess) cexpr;
			return is_pure_ccode_expression (cma.inner);
		} else if (cexpr is CCodeElementAccess) {
			var cea = (CCodeElementAccess) cexpr;
			return is_pure_ccode_expression (cea.container) && is_pure_ccode_expression (cea.index);
		} else if (cexpr is CCodeCastExpression) {
			var ccast = (CCodeCastExpression) cexpr;
			return is_pure_ccode_expression (ccast.inner);
		} else if (cexpr is CCodeParenthesizedExpression) {
			var cparenthesized = (CCodeParenthesizedExpression) cexpr;
			return is_pure_ccode_expression (cparenthesized.inner);
		}

		return false;
	}

	public override void visit_formal_parameter (FormalParameter p) {
		check_type (p.parameter_type);

		p.accept_children (codegen);
	}

	public override void visit_property (Property prop) {
		check_type (prop.property_type);

		int old_next_temp_var_id = next_temp_var_id;
		var old_temp_vars = temp_vars;
		var old_temp_ref_vars = temp_ref_vars;
		var old_variable_name_map = variable_name_map;
		next_temp_var_id = 0;
		temp_vars = new ArrayList<LocalVariable> ();
		temp_ref_vars = new ArrayList<LocalVariable> ();
		variable_name_map = new HashMap<string,string> (str_hash, str_equal);

		prop.accept_children (codegen);

		next_temp_var_id = old_next_temp_var_id;
		temp_vars = old_temp_vars;
		temp_ref_vars = old_temp_ref_vars;
		variable_name_map = old_variable_name_map;
	}

	public void generate_type_declaration (DataType type, CCodeDeclarationSpace decl_space) {
		if (type is ObjectType) {
			var object_type = (ObjectType) type;
			if (object_type.type_symbol is Class) {
				generate_class_declaration ((Class) object_type.type_symbol, decl_space);
			} else if (object_type.type_symbol is Interface) {
				generate_interface_declaration ((Interface) object_type.type_symbol, decl_space);
			}
		} else if (type is DelegateType) {
			var deleg_type = (DelegateType) type;
			var d = deleg_type.delegate_symbol;
			generate_delegate_declaration (d, decl_space);
		} else if (type.data_type is Enum) {
			var en = (Enum) type.data_type;
			generate_enum_declaration (en, decl_space);
		} else if (type is ValueType) {
			var value_type = (ValueType) type;
			generate_struct_declaration ((Struct) value_type.type_symbol, decl_space);
		} else if (type is ArrayType) {
			var array_type = (ArrayType) type;
			generate_type_declaration (array_type.element_type, decl_space);
		} else if (type is ErrorType) {
			var error_type = (ErrorType) type;
			if (error_type.error_domain != null) {
				generate_error_domain_declaration (error_type.error_domain, decl_space);
			}
		} else if (type is PointerType) {
			var pointer_type = (PointerType) type;
			generate_type_declaration (pointer_type.base_type, decl_space);
		}

		foreach (DataType type_arg in type.get_type_arguments ()) {
			generate_type_declaration (type_arg, decl_space);
		}
	}

	public virtual void generate_class_struct_declaration (Class cl, CCodeDeclarationSpace decl_space) {
	}

	public virtual void generate_struct_declaration (Struct st, CCodeDeclarationSpace decl_space) {
	}

	public virtual void generate_delegate_declaration (Delegate d, CCodeDeclarationSpace decl_space) {
	}

	public virtual void generate_cparameters (Method m, CCodeDeclarationSpace decl_space, Map<int,CCodeFormalParameter> cparam_map, CCodeFunction func, CCodeFunctionDeclarator? vdeclarator = null, Map<int,CCodeExpression>? carg_map = null, CCodeFunctionCall? vcall = null, int direction = 3) {
	}

	public void generate_property_accessor_declaration (PropertyAccessor acc, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (acc.prop, acc.get_cname ())) {
			return;
		}

		var prop = (Property) acc.prop;

		bool returns_real_struct = prop.property_type.is_real_struct_type ();

		var t = (ObjectTypeSymbol) prop.parent_symbol;

		var this_type = new ObjectType (t);
		generate_type_declaration (this_type, decl_space);
		var cselfparam = new CCodeFormalParameter ("self", this_type.get_cname ());

		CCodeFormalParameter cvalueparam;
		if (returns_real_struct) {
			cvalueparam = new CCodeFormalParameter ("value", acc.value_type.get_cname () + "*");
		} else {
			cvalueparam = new CCodeFormalParameter ("value", acc.value_type.get_cname ());
		}
		generate_type_declaration (acc.value_type, decl_space);

		if (acc.readable && !returns_real_struct) {
			function = new CCodeFunction (acc.get_cname (), acc.value_type.get_cname ());
		} else {
			function = new CCodeFunction (acc.get_cname (), "void");
		}
		function.add_parameter (cselfparam);
		if (acc.writable || acc.construction || returns_real_struct) {
			function.add_parameter (cvalueparam);
		}

		if (acc.value_type is ArrayType) {
			var array_type = (ArrayType) acc.value_type;

			var length_ctype = "int";
			if (acc.readable) {
				length_ctype = "int*";
			}

			for (int dim = 1; dim <= array_type.rank; dim++) {
				function.add_parameter (new CCodeFormalParameter (head.get_array_length_cname (acc.readable ? "result" : "value", dim), length_ctype));
			}
		}

		if (prop.is_private_symbol () || (!acc.readable && !acc.writable) || acc.access == SymbolAccessibility.PRIVATE) {
			function.modifiers |= CCodeModifiers.STATIC;
		}
		decl_space.add_type_member_declaration (function);
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		var old_property_accessor = current_property_accessor;
		bool old_method_inner_error = current_method_inner_error;
		current_property_accessor = acc;
		current_method_inner_error = false;

		var prop = (Property) acc.prop;

		bool returns_real_struct = prop.property_type.is_real_struct_type ();

		var old_return_type = current_return_type;
		if (acc.readable && !returns_real_struct) {
			current_return_type = acc.value_type;
		} else {
			current_return_type = new VoidType ();
		}

		acc.accept_children (codegen);

		var t = (ObjectTypeSymbol) prop.parent_symbol;

		if (acc.construction && !t.is_subtype_of (gobject_type)) {
			Report.error (acc.source_reference, "construct properties require GLib.Object");
			acc.error = true;
			return;
		}

		// do not declare overriding properties and interface implementations
		if (prop.is_abstract || prop.is_virtual
		    || (prop.base_property == null && prop.base_interface_property == null)) {
			generate_property_accessor_declaration (acc, source_declarations);

			// do not declare construct-only properties in header files
			if (acc.readable || acc.writable) {
				if (!prop.is_internal_symbol ()
				    && (acc.access == SymbolAccessibility.PUBLIC
					|| acc.access == SymbolAccessibility.PROTECTED)) {
					generate_property_accessor_declaration (acc, header_declarations);
				}
				generate_property_accessor_declaration (acc, internal_header_declarations);
			}
		}

		var this_type = new ObjectType (t);
		var cselfparam = new CCodeFormalParameter ("self", this_type.get_cname ());
		CCodeFormalParameter cvalueparam;
		if (returns_real_struct) {
			cvalueparam = new CCodeFormalParameter ("value", acc.value_type.get_cname () + "*");
		} else {
			cvalueparam = new CCodeFormalParameter ("value", acc.value_type.get_cname ());
		}

		if (prop.is_abstract || prop.is_virtual) {
			if (acc.readable) {
				function = new CCodeFunction (acc.get_cname (), current_return_type.get_cname ());
			} else {
				function = new CCodeFunction (acc.get_cname (), "void");
			}
			function.add_parameter (cselfparam);
			if (acc.writable || acc.construction || returns_real_struct) {
				function.add_parameter (cvalueparam);
			}

			if (acc.value_type is ArrayType) {
				var array_type = (ArrayType) acc.value_type;

				var length_ctype = "int";
				if (acc.readable) {
					length_ctype = "int*";
				}

				for (int dim = 1; dim <= array_type.rank; dim++) {
					function.add_parameter (new CCodeFormalParameter (head.get_array_length_cname (acc.readable ? "result" : "value", dim), length_ctype));
				}
			}

			if (prop.is_private_symbol () || !(acc.readable || acc.writable) || acc.access == SymbolAccessibility.PRIVATE) {
				// accessor function should be private if the property is an internal symbol or it's a construct-only setter
				function.modifiers |= CCodeModifiers.STATIC;
			}

			var block = new CCodeBlock ();
			function.block = block;

			CCodeFunctionCall vcast = null;
			if (prop.parent_symbol is Interface) {
				var iface = (Interface) prop.parent_symbol;

				vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_INTERFACE".printf (iface.get_upper_case_cname (null))));
			} else {
				var cl = (Class) prop.parent_symbol;

				vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS".printf (cl.get_upper_case_cname (null))));
			}
			vcast.add_argument (new CCodeIdentifier ("self"));

			if (acc.readable) {
				var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "get_%s".printf (prop.name)));
				vcall.add_argument (new CCodeIdentifier ("self"));
				if (returns_real_struct) {
					vcall.add_argument (new CCodeIdentifier ("value"));
					block.add_statement (new CCodeExpressionStatement (vcall));
				} else {
					block.add_statement (new CCodeReturnStatement (vcall));
				}
			} else {
				var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "set_%s".printf (prop.name)));
				vcall.add_argument (new CCodeIdentifier ("self"));
				vcall.add_argument (new CCodeIdentifier ("value"));
				block.add_statement (new CCodeExpressionStatement (vcall));
			}

			source_type_member_definition.append (function);
		}

		if (!prop.is_abstract) {
			bool is_virtual = prop.base_property != null || prop.base_interface_property != null;

			string cname;
			if (is_virtual) {
				if (acc.readable) {
					cname = "%s_real_get_%s".printf (t.get_lower_case_cname (null), prop.name);
				} else {
					cname = "%s_real_set_%s".printf (t.get_lower_case_cname (null), prop.name);
				}
			} else {
				cname = acc.get_cname ();
			}

			if (acc.writable || acc.construction || returns_real_struct) {
				function = new CCodeFunction (cname, "void");
			} else {
				function = new CCodeFunction (cname, acc.value_type.get_cname ());
			}

			ObjectType base_type = null;
			if (prop.binding == MemberBinding.INSTANCE) {
				if (is_virtual) {
					if (prop.base_property != null) {
						base_type = new ObjectType ((ObjectTypeSymbol) prop.base_property.parent_symbol);
					} else if (prop.base_interface_property != null) {
						base_type = new ObjectType ((ObjectTypeSymbol) prop.base_interface_property.parent_symbol);
					}
					function.modifiers |= CCodeModifiers.STATIC;
					function.add_parameter (new CCodeFormalParameter ("base", base_type.get_cname ()));
				} else {
					function.add_parameter (cselfparam);
				}
			}
			if (acc.writable || acc.construction || returns_real_struct) {
				function.add_parameter (cvalueparam);
			}

			if (acc.value_type is ArrayType) {
				var array_type = (ArrayType) acc.value_type;

				var length_ctype = "int";
				if (acc.readable) {
					length_ctype = "int*";
				}

				for (int dim = 1; dim <= array_type.rank; dim++) {
					function.add_parameter (new CCodeFormalParameter (head.get_array_length_cname (acc.readable ? "result" : "value", dim), length_ctype));
				}
			}

			if (!is_virtual) {
				if (prop.is_private_symbol () || !(acc.readable || acc.writable) || acc.access == SymbolAccessibility.PRIVATE) {
					// accessor function should be private if the property is an internal symbol or it's a construct-only setter
					function.modifiers |= CCodeModifiers.STATIC;
				}
			}

			function.block = (CCodeBlock) acc.body.ccodenode;

			if (is_virtual) {
				var cdecl = new CCodeDeclaration (this_type.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator ("self", transform_expression (new CCodeIdentifier ("base"), base_type, this_type)));
				function.block.prepend_statement (cdecl);
			}

			if (acc.readable) {
				var cdecl = new CCodeDeclaration (acc.value_type.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
				function.block.prepend_statement (cdecl);
			}

			if (current_method_inner_error) {
				var cdecl = new CCodeDeclaration ("GError *");
				cdecl.add_declarator (new CCodeVariableDeclarator ("_inner_error_", new CCodeConstant ("NULL")));
				function.block.prepend_statement (cdecl);
			}

			if (prop.binding == MemberBinding.INSTANCE && !is_virtual) {
				CCodeStatement check_stmt;
				if (returns_real_struct) {
					check_stmt = create_property_type_check_statement (prop, false, t, true, "self");
				} else {
					check_stmt = create_property_type_check_statement (prop, acc.readable, t, true, "self");
				}
				if (check_stmt != null) {
					function.block.prepend_statement (check_stmt);
				}
			}

			// notify on property changes
			var typesymbol = (TypeSymbol) prop.parent_symbol;
			var st = prop.property_type.data_type as Struct;
			if (typesymbol.is_subtype_of (gobject_type) &&
			    (st == null || st.has_type_id) &&
			    prop.notify &&
			    prop.access != SymbolAccessibility.PRIVATE && // FIXME: use better means to detect gobject properties
			    prop.binding == MemberBinding.INSTANCE &&
			    (acc.writable || acc.construction)) {
				var notify_call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_notify"));
				notify_call.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "GObject *"));
				notify_call.add_argument (prop.get_canonical_cconstant ());
				function.block.add_statement (new CCodeExpressionStatement (notify_call));
			}

			source_type_member_definition.append (function);
		}

		current_property_accessor = old_property_accessor;
		current_return_type = old_return_type;
		current_method_inner_error = old_method_inner_error;
	}

	public override void visit_destructor (Destructor d) {
		bool old_method_inner_error = current_method_inner_error;
		current_method_inner_error = false;

		d.accept_children (codegen);

		if (d.binding == MemberBinding.STATIC && !in_plugin) {
			Report.error (d.source_reference, "static destructors are only supported for dynamic types");
			d.error = true;
			return;
		}

		CCodeFragment cfrag = new CCodeFragment ();

		if (current_method_inner_error) {
			var cdecl = new CCodeDeclaration ("GError *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_inner_error_", new CCodeConstant ("NULL")));
			cfrag.append (cdecl);
		}

		cfrag.append (d.body.ccodenode);

		d.ccodenode = cfrag;

		current_method_inner_error = old_method_inner_error;
	}

	public override void visit_block (Block b) {
		var old_symbol = current_symbol;
		current_symbol = b;

		b.accept_children (codegen);

		var local_vars = b.get_local_variables ();
		foreach (LocalVariable local in local_vars) {
			local.active = false;
		}
		
		var cblock = new CCodeBlock ();
		
		foreach (CodeNode stmt in b.get_statements ()) {
			if (stmt.error) {
				continue;
			}

			var src = stmt.source_reference;
			if (src != null && src.comment != null) {
				cblock.add_statement (new CCodeComment (src.comment));
			}
			
			if (stmt.ccodenode is CCodeFragment) {
				foreach (CCodeNode cstmt in ((CCodeFragment) stmt.ccodenode).get_children ()) {
					cblock.add_statement (cstmt);
				}
			} else {
				cblock.add_statement (stmt.ccodenode);
			}
		}

		foreach (LocalVariable local in local_vars) {
			if (!local.floating && requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
			}
		}

		if (b.parent_symbol is Method) {
			var m = (Method) b.parent_symbol;
			foreach (FormalParameter param in m.get_parameters ()) {
				if (requires_destroy (param.parameter_type) && param.direction == ParameterDirection.IN) {
					var ma = new MemberAccess.simple (param.name);
					ma.symbol_reference = param;
					cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (param.name), param.parameter_type, ma)));
				}
			}
		}

		b.ccodenode = cblock;

		current_symbol = old_symbol;
	}

	public override void visit_empty_statement (EmptyStatement stmt) {
		stmt.ccodenode = new CCodeEmptyStatement ();
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		stmt.declaration.accept (codegen);

		stmt.ccodenode = stmt.declaration.ccodenode;

		var local = stmt.declaration as LocalVariable;
		if (local != null && local.initializer != null) {
			create_temp_decl (stmt, local.initializer.temp_vars);
		}

		create_temp_decl (stmt, temp_vars);
		temp_vars.clear ();
	}

	public CCodeExpression get_variable_cexpression (string name) {
		if (current_method != null && current_method.coroutine) {
			return new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_variable_cname (name));
		} else {
			return new CCodeIdentifier (get_variable_cname (name));
		}
	}

	public string get_variable_cname (string name) {
		if (name[0] == '.') {
			// compiler-internal variable
			if (!variable_name_map.contains (name)) {
				variable_name_map.set (name, "_tmp%d_".printf (next_temp_var_id));
				next_temp_var_id++;
			}
			return variable_name_map.get (name);
		} else if (reserved_identifiers.contains (name)) {
			return "_%s_".printf (name);
		} else {
			return name;
		}
	}

	public override void visit_local_variable (LocalVariable local) {
		check_type (local.variable_type);

		local.accept_children (codegen);

		generate_type_declaration (local.variable_type, source_declarations);

		if (local.variable_type is ArrayType) {
			// create variables to store array dimensions
			var array_type = (ArrayType) local.variable_type;

			if (!array_type.fixed_length) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					var len_var = new LocalVariable (int_type.copy (), head.get_array_length_cname (get_variable_cname (local.name), dim));
					temp_vars.insert (0, len_var);
				}

				if (array_type.rank == 1) {
					var size_var = new LocalVariable (int_type.copy (), head.get_array_size_cname (get_variable_cname (local.name)));
					temp_vars.insert (0, size_var);
				}
			}
		} else if (local.variable_type is DelegateType) {
			var deleg_type = (DelegateType) local.variable_type;
			var d = deleg_type.delegate_symbol;
			if (d.has_target) {
				// create variable to store delegate target
				var target_var = new LocalVariable (new PointerType (new VoidType ()), get_delegate_target_cname (get_variable_cname (local.name)));
				temp_vars.insert (0, target_var);
			}
		}
	
		CCodeExpression rhs = null;
		if (local.initializer != null && local.initializer.ccodenode != null) {
			rhs = (CCodeExpression) local.initializer.ccodenode;

			if (local.variable_type is ArrayType) {
				var array_type = (ArrayType) local.variable_type;

				if (array_type.fixed_length) {
					rhs = null;
				} else {
					var ccomma = new CCodeCommaExpression ();

					var temp_var = get_temp_variable (local.variable_type, true, local);
					temp_vars.insert (0, temp_var);
					ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), rhs));

					for (int dim = 1; dim <= array_type.rank; dim++) {
						var lhs_array_len = get_variable_cexpression (head.get_array_length_cname (get_variable_cname (local.name), dim));
						var rhs_array_len = head.get_array_length_cexpression (local.initializer, dim);
						ccomma.append_expression (new CCodeAssignment (lhs_array_len, rhs_array_len));
					}
					if (array_type.rank == 1) {
						var lhs_array_size = get_variable_cexpression (head.get_array_size_cname (get_variable_cname (local.name)));
						var rhs_array_len = get_variable_cexpression (head.get_array_length_cname (get_variable_cname (local.name), 1));
						ccomma.append_expression (new CCodeAssignment (lhs_array_size, rhs_array_len));
					}
				
					ccomma.append_expression (get_variable_cexpression (temp_var.name));
				
					rhs = ccomma;
				}
			} else if (local.variable_type is DelegateType) {
				var deleg_type = (DelegateType) local.variable_type;
				var d = deleg_type.delegate_symbol;
				if (d.has_target) {
					var ccomma = new CCodeCommaExpression ();

					var temp_var = get_temp_variable (local.variable_type, true, local);
					temp_vars.insert (0, temp_var);
					ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), rhs));

					var lhs_delegate_target = get_variable_cexpression (get_delegate_target_cname (get_variable_cname (local.name)));
					var rhs_delegate_target = get_delegate_target_cexpression (local.initializer);
					ccomma.append_expression (new CCodeAssignment (lhs_delegate_target, rhs_delegate_target));
				
					ccomma.append_expression (get_variable_cexpression (temp_var.name));
				
					rhs = ccomma;
				}
			}
		} else if (local.variable_type.is_reference_type_or_type_parameter ()) {
			rhs = new CCodeConstant ("NULL");

			if (local.variable_type is ArrayType) {
				// initialize array length variables
				var array_type = (ArrayType) local.variable_type;

				if (array_type.fixed_length) {
					rhs = null;
				} else {
					var ccomma = new CCodeCommaExpression ();

					for (int dim = 1; dim <= array_type.rank; dim++) {
						ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (head.get_array_length_cname (get_variable_cname (local.name), dim)), new CCodeConstant ("0")));
					}

					ccomma.append_expression (rhs);

					rhs = ccomma;
				}
			}
		}

		var cfrag = new CCodeFragment ();

		if (pre_statement_fragment != null) {
			cfrag.append (pre_statement_fragment);
			pre_statement_fragment = null;
		}

		if (current_method != null && current_method.coroutine) {
			closure_struct.add_field (local.variable_type.get_cname (), get_variable_cname (local.name) + local.variable_type.get_cdeclarator_suffix ());

			if (local.initializer != null) {
				cfrag.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_variable_cname (local.name)), rhs)));
			}
		} else {
			var cvar = new CCodeVariableDeclarator (get_variable_cname (local.name), rhs, local.variable_type.get_cdeclarator_suffix ());

			var cdecl = new CCodeDeclaration (local.variable_type.get_cname ());
			cdecl.add_declarator (cvar);
			cfrag.append (cdecl);

			// try to initialize uninitialized variables
			// initialization not necessary for variables stored in closure
			if (cvar.initializer == null) {
				cvar.initializer = default_value_for_type (local.variable_type, true);
			}
		}

		if (local.initializer != null && local.variable_type is ArrayType) {
			var array_type = (ArrayType) local.variable_type;

			if (array_type.fixed_length) {
				source_declarations.add_include ("string.h");

				// it is necessary to use memcpy for fixed-length (stack-allocated) arrays
				// simple assignments do not work in C
				var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				sizeof_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
				var size = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeConstant ("%d".printf (array_type.length)), sizeof_call);

				var ccopy = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
				ccopy.add_argument (get_variable_cexpression (local.name));
				ccopy.add_argument ((CCodeExpression) local.initializer.ccodenode);
				ccopy.add_argument (size);
				cfrag.append (new CCodeExpressionStatement (ccopy));
			}
		}

		if (local.initializer != null && local.initializer.tree_can_fail) {
			head.add_simple_check (local.initializer, cfrag);
		}

		local.ccodenode = cfrag;

		local.active = true;
	}

	public override void visit_initializer_list (InitializerList list) {
		list.accept_children (codegen);

		if (list.target_type.data_type is Struct) {
			/* initializer is used as struct initializer */
			var st = (Struct) list.target_type.data_type;

			var clist = new CCodeInitializerList ();

			var field_it = st.get_fields ().iterator ();
			foreach (Expression expr in list.get_initializers ()) {
				Field field = null;
				while (field == null) {
					field_it.next ();
					field = field_it.get ();
					if (field.binding != MemberBinding.INSTANCE) {
						// we only initialize instance fields
						field = null;
					}
				}

				var cexpr = (CCodeExpression) expr.ccodenode;

				string ctype = field.get_ctype ();
				if (ctype != null) {
					cexpr = new CCodeCastExpression (cexpr, ctype);
				}

				clist.append (cexpr);
			}

			list.ccodenode = clist;
		} else {
			var clist = new CCodeInitializerList ();
			foreach (Expression expr in list.get_initializers ()) {
				clist.append ((CCodeExpression) expr.ccodenode);
			}
			list.ccodenode = clist;
		}
	}

	public LocalVariable get_temp_variable (DataType type, bool value_owned = true, CodeNode? node_reference = null) {
		var var_type = type.copy ();
		var_type.value_owned = value_owned;
		var local = new LocalVariable (var_type, "_tmp%d_".printf (next_temp_var_id));

		if (node_reference != null) {
			local.source_reference = node_reference.source_reference;
		}

		next_temp_var_id++;
		
		return local;
	}

	bool is_in_generic_type (DataType type) {
		if (type.type_parameter.parent_symbol is TypeSymbol
		    && (current_method == null || current_method.binding == MemberBinding.INSTANCE)) {
			return true;
		} else {
			return false;
		}
	}

	private CCodeExpression get_type_id_expression (DataType type) {
		if (type is GenericType) {
			string var_name = "%s_type".printf (type.type_parameter.name.down ());
			if (is_in_generic_type (type)) {
				return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), var_name);
			} else {
				return new CCodeIdentifier (var_name);
			}
		} else {
			string type_id = type.get_type_id ();
			if (type_id == null) {
				type_id = "G_TYPE_INVALID";
			} else {
				generate_type_declaration (type, source_declarations);
			}
			return new CCodeIdentifier (type_id);
		}
	}

	public virtual CCodeExpression? get_dup_func_expression (DataType type, SourceReference? source_reference) {
		if (type is ErrorType) {
			return new CCodeIdentifier ("g_error_copy");
		} else if (type.data_type != null) {
			string dup_function;
			var cl = type.data_type as Class;
			if (type.data_type.is_reference_counting ()) {
				dup_function = type.data_type.get_ref_function ();
				if (type.data_type is Interface && dup_function == null) {
					Report.error (source_reference, "missing class prerequisite for interface `%s', add GLib.Object to interface declaration if unsure".printf (type.data_type.get_full_name ()));
					return null;
				}
			} else if (cl != null && cl.is_immutable) {
				// allow duplicates of immutable instances as for example strings
				dup_function = type.data_type.get_dup_function ();
				if (dup_function == null) {
					dup_function = "";
				}
			} else if (type is ValueType) {
				dup_function = type.data_type.get_dup_function ();
				if (dup_function == null && type.nullable) {
					dup_function = generate_struct_dup_wrapper ((ValueType) type);
				} else if (dup_function == null) {
					dup_function = "";
				}
			} else {
				// duplicating non-reference counted objects may cause side-effects (and performance issues)
				Report.error (source_reference, "duplicating %s instance, use unowned variable or explicitly invoke copy method".printf (type.data_type.name));
				return null;
			}

			return new CCodeIdentifier (dup_function);
		} else if (type.type_parameter != null && current_type_symbol is Class) {
			string func_name = "%s_dup_func".printf (type.type_parameter.name.down ());
			if (is_in_generic_type (type)) {
				return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			} else {
				return new CCodeIdentifier (func_name);
			}
		} else if (type is PointerType) {
			var pointer_type = (PointerType) type;
			return get_dup_func_expression (pointer_type.base_type, source_reference);
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	private string generate_struct_dup_wrapper (ValueType value_type) {
		string dup_func = "_%sdup".printf (value_type.type_symbol.get_lower_case_cprefix ());

		if (!add_wrapper (dup_func)) {
			// wrapper already defined
			return dup_func;
		}

		// declaration

		var function = new CCodeFunction (dup_func, value_type.get_cname ());
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("self", value_type.get_cname ()));

		// definition

		var block = new CCodeBlock ();

		if (value_type.type_symbol == gvalue_type) {
			var dup_call = new CCodeFunctionCall (new CCodeIdentifier ("g_boxed_copy"));
			dup_call.add_argument (new CCodeIdentifier ("G_TYPE_VALUE"));
			dup_call.add_argument (new CCodeIdentifier ("self"));

			block.add_statement (new CCodeReturnStatement (dup_call));
		} else {
			var cdecl = new CCodeDeclaration (value_type.get_cname ());
			cdecl.add_declarator (new CCodeVariableDeclarator ("dup"));
			block.add_statement (cdecl);

			var creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
			creation_call.add_argument (new CCodeConstant (value_type.data_type.get_cname ()));
			creation_call.add_argument (new CCodeConstant ("1"));
			block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("dup"), creation_call)));

			var st = value_type.data_type as Struct;
			if (st != null && st.is_disposable ()) {
				var copy_call = new CCodeFunctionCall (new CCodeIdentifier (st.get_copy_function ()));
				copy_call.add_argument (new CCodeIdentifier ("self"));
				copy_call.add_argument (new CCodeIdentifier ("dup"));
				block.add_statement (new CCodeExpressionStatement (copy_call));
			} else {
				source_declarations.add_include ("string.h");

				var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				sizeof_call.add_argument (new CCodeConstant (value_type.data_type.get_cname ()));

				var copy_call = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
				copy_call.add_argument (new CCodeIdentifier ("dup"));
				copy_call.add_argument (new CCodeIdentifier ("self"));
				copy_call.add_argument (sizeof_call);
				block.add_statement (new CCodeExpressionStatement (copy_call));
			}

			block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("dup")));
		}

		// append to file

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return dup_func;
	}

	public CCodeExpression? get_destroy_func_expression (DataType type) {
		if (type.data_type == glist_type || type.data_type == gslist_type) {
			// create wrapper function to free list elements if necessary

			bool elements_require_free = false;
			CCodeExpression element_destroy_func_expression = null;

			foreach (DataType type_arg in type.get_type_arguments ()) {
				elements_require_free = requires_destroy (type_arg);
				if (elements_require_free) {
					element_destroy_func_expression = get_destroy_func_expression (type_arg);
				}
			}
			
			if (elements_require_free && element_destroy_func_expression is CCodeIdentifier) {
				return new CCodeIdentifier (generate_glist_free_wrapper (type, (CCodeIdentifier) element_destroy_func_expression));
			} else {
				return new CCodeIdentifier (type.data_type.get_free_function ());
			}
		} else if (type is ErrorType) {
			return new CCodeIdentifier ("g_error_free");
		} else if (type.data_type != null) {
			string unref_function;
			if (type is ReferenceType) {
				if (type.data_type.is_reference_counting ()) {
					unref_function = type.data_type.get_unref_function ();
					if (type.data_type is Interface && unref_function == null) {
						Report.error (type.source_reference, "missing class prerequisite for interface `%s', add GLib.Object to interface declaration if unsure".printf (type.data_type.get_full_name ()));
						return null;
					}
				} else {
					unref_function = type.data_type.get_free_function ();
				}
			} else {
				if (type.nullable) {
					unref_function = type.data_type.get_free_function ();
					if (unref_function == null) {
						unref_function = "g_free";
					}
				} else {
					var st = (Struct) type.data_type;
					unref_function = st.get_destroy_function ();
				}
			}
			if (unref_function == null) {
				return new CCodeConstant ("NULL");
			}
			return new CCodeIdentifier (unref_function);
		} else if (type.type_parameter != null && current_type_symbol is Class) {
			string func_name = "%s_destroy_func".printf (type.type_parameter.name.down ());
			if (is_in_generic_type (type)) {
				return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
			} else {
				return new CCodeIdentifier (func_name);
			}
		} else if (type is ArrayType) {
			return new CCodeIdentifier ("g_free");
		} else if (type is PointerType) {
			return new CCodeIdentifier ("g_free");
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	private string generate_glist_free_wrapper (DataType list_type, CCodeIdentifier element_destroy_func_expression) {
		string destroy_func = "_%s_%s".printf (list_type.data_type.get_free_function (), element_destroy_func_expression.name);

		if (!add_wrapper (destroy_func)) {
			// wrapper already defined
			return destroy_func;
		}

		// declaration

		var function = new CCodeFunction (destroy_func, "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("self", list_type.get_cname ()));

		// definition

		var block = new CCodeBlock ();

		CCodeFunctionCall element_free_call;
		if (list_type.data_type == glist_type) {
			element_free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_list_foreach"));
		} else {
			element_free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_slist_foreach"));
		}
		element_free_call.add_argument (new CCodeIdentifier ("self"));
		element_free_call.add_argument (new CCodeCastExpression (element_destroy_func_expression, "GFunc"));
		element_free_call.add_argument (new CCodeConstant ("NULL"));
		block.add_statement (new CCodeExpressionStatement (element_free_call));

		var cfreecall = new CCodeFunctionCall (new CCodeIdentifier (list_type.data_type.get_free_function ()));
		cfreecall.add_argument (new CCodeIdentifier ("self"));
		block.add_statement (new CCodeExpressionStatement (cfreecall));

		// append to file

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return destroy_func;
	}

	public virtual CCodeExpression get_unref_expression (CCodeExpression cvar, DataType type, Expression expr) {
		var ccall = new CCodeFunctionCall (get_destroy_func_expression (type));

		if (type is ValueType && !type.nullable) {
			// normal value type, no null check
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cvar));

			if (type.data_type == gvalue_type) {
				// g_value_unset must not be called for already unset values
				var cisvalid = new CCodeFunctionCall (new CCodeIdentifier ("G_IS_VALUE"));
				cisvalid.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cvar));

				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (ccall);
				ccomma.append_expression (new CCodeConstant ("NULL"));

				return new CCodeConditionalExpression (cisvalid, ccomma, new CCodeConstant ("NULL"));
			} else {
				return ccall;
			}
		}

		/* (foo == NULL ? NULL : foo = (unref (foo), NULL)) */
		
		/* can be simplified to
		 * foo = (unref (foo), NULL)
		 * if foo is of static type non-null
		 */

		var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, cvar, new CCodeConstant ("NULL"));
		if (type.type_parameter != null) {
			if (!(current_type_symbol is Class) || current_class.is_compact) {
				return new CCodeConstant ("NULL");
			}

			// unref functions are optional for type parameters
			var cunrefisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, get_destroy_func_expression (type), new CCodeConstant ("NULL"));
			cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cisnull, cunrefisnull);
		}

		ccall.add_argument (cvar);

		/* set freed references to NULL to prevent further use */
		var ccomma = new CCodeCommaExpression ();

		if (type.data_type == gstringbuilder_type
		     || type.data_type == garray_type
		     || type.data_type == gbytearray_type
		     || type.data_type == gptrarray_type) {
			ccall.add_argument (new CCodeConstant ("TRUE"));
		} else if (type is ArrayType) {
			var array_type = (ArrayType) type;
			if (array_type.element_type.data_type == null || array_type.element_type.data_type.is_reference_type ()) {
				requires_array_free = true;

				CCodeExpression csizeexpr = null;
				bool first = true;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					if (first) {
						csizeexpr = head.get_array_length_cexpression (expr, dim);
						first = false;
					} else {
						csizeexpr = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, csizeexpr, head.get_array_length_cexpression (expr, dim));
					}
				}

				ccall.call = new CCodeIdentifier ("_vala_array_free");
				ccall.add_argument (csizeexpr);
				ccall.add_argument (new CCodeCastExpression (get_destroy_func_expression (array_type.element_type), "GDestroyNotify"));
			}
		}
		
		ccomma.append_expression (ccall);
		ccomma.append_expression (new CCodeConstant ("NULL"));
		
		var cassign = new CCodeAssignment (cvar, ccomma);

		// g_free (NULL) is allowed
		bool uses_gfree = (type.data_type != null && !type.data_type.is_reference_counting () && type.data_type.get_free_function () == "g_free");
		uses_gfree = uses_gfree || type is ArrayType;
		if (uses_gfree) {
			return cassign;
		}

		return new CCodeConditionalExpression (cisnull, new CCodeConstant ("NULL"), cassign);
	}
	
	public override void visit_end_full_expression (Expression expr) {
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
		expr.temp_vars.clear ();
		foreach (LocalVariable local in temp_vars) {
			expr.temp_vars.add (local);
		}
		temp_vars.clear ();

		if (((Gee.List<LocalVariable>) temp_ref_vars).size == 0) {
			/* nothing to do without temporary variables */
			return;
		}

		var expr_type = expr.value_type;
		if (expr.target_type != null) {
			expr_type = expr.target_type;
		}

		var full_expr_var = get_temp_variable (expr_type, true, expr);
		expr.temp_vars.add (full_expr_var);
		
		var expr_list = new CCodeCommaExpression ();
		expr_list.append_expression (new CCodeAssignment (get_variable_cexpression (full_expr_var.name), (CCodeExpression) expr.ccodenode));
		
		foreach (LocalVariable local in temp_ref_vars) {
			var ma = new MemberAccess.simple (local.name);
			ma.symbol_reference = local;
			expr_list.append_expression (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma));
		}
		
		expr_list.append_expression (get_variable_cexpression (full_expr_var.name));
		
		expr.ccodenode = expr_list;
		
		temp_ref_vars.clear ();
	}
	
	public void append_temp_decl (CCodeFragment cfrag, Gee.List<LocalVariable> temp_vars) {
		foreach (LocalVariable local in temp_vars) {
			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (local.variable_type.get_cname (), local.name);

				// no initialization necessary, closure struct is zeroed
			} else {
				var cdecl = new CCodeDeclaration (local.variable_type.get_cname ());
		
				var vardecl = new CCodeVariableDeclarator (local.name, null, local.variable_type.get_cdeclarator_suffix ());
				// sets #line
				local.ccodenode = vardecl;
				cdecl.add_declarator (vardecl);

				var st = local.variable_type.data_type as Struct;
				var array_type = local.variable_type as ArrayType;

				if (local.name.has_prefix ("*")) {
					// do not dereference unintialized variable
					// initialization is not needed for these special
					// pointer temp variables
					// used to avoid side-effects in assignments
				} else if (!local.variable_type.nullable &&
				           (st != null && !st.is_simple_type ()) ||
				           (array_type != null && array_type.fixed_length)) {
					// 0-initialize struct with struct initializer { 0 }
					// necessary as they will be passed by reference
					var clist = new CCodeInitializerList ();
					clist.append (new CCodeConstant ("0"));

					vardecl.initializer = clist;
				} else if (local.variable_type.is_reference_type_or_type_parameter () ||
				       local.variable_type.nullable) {
					vardecl.initializer = new CCodeConstant ("NULL");
				}
			
				cfrag.append (cdecl);
			}
		}
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		stmt.accept_children (codegen);

		if (stmt.expression.error) {
			stmt.error = true;
			return;
		}

		stmt.ccodenode = new CCodeExpressionStatement ((CCodeExpression) stmt.expression.ccodenode);

		if (stmt.tree_can_fail && stmt.expression.tree_can_fail) {
			// simple case, no node breakdown necessary

			var cfrag = new CCodeFragment ();

			cfrag.append (stmt.ccodenode);

			head.add_simple_check (stmt.expression, cfrag);

			stmt.ccodenode = cfrag;
		}

		/* free temporary objects */

		if (((Gee.List<LocalVariable>) temp_vars).size == 0
		     && pre_statement_fragment == null) {
			/* nothing to do without temporary variables */
			return;
		}
		
		var cfrag = new CCodeFragment ();
		append_temp_decl (cfrag, temp_vars);

		if (pre_statement_fragment != null) {
			cfrag.append (pre_statement_fragment);
			pre_statement_fragment = null;
		}

		cfrag.append (stmt.ccodenode);
		
		foreach (LocalVariable local in temp_ref_vars) {
			var ma = new MemberAccess.simple (local.name);
			ma.symbol_reference = local;
			cfrag.append (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (local.name), local.variable_type, ma)));
		}
		
		stmt.ccodenode = cfrag;
		
		temp_vars.clear ();
		temp_ref_vars.clear ();
	}
	
	public void create_temp_decl (Statement stmt, Gee.List<LocalVariable> temp_vars) {
		/* declare temporary variables */
		
		if (temp_vars.size == 0) {
			/* nothing to do without temporary variables */
			return;
		}
		
		var cfrag = new CCodeFragment ();
		append_temp_decl (cfrag, temp_vars);
		
		cfrag.append (stmt.ccodenode);
		
		stmt.ccodenode = cfrag;
	}

	public void append_local_free (Symbol sym, CCodeFragment cfrag, bool stop_at_loop = false) {
		var b = (Block) sym;

		var local_vars = b.get_local_variables ();
		foreach (LocalVariable local in local_vars) {
			if (local.active && !local.floating && requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				cfrag.append (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
			}
		}
		
		if (stop_at_loop) {
			if (b.parent_node is Loop ||
			    b.parent_node is ForeachStatement ||
			    b.parent_node is SwitchStatement) {
				return;
			}
		}

		if (sym.parent_symbol is Block) {
			append_local_free (sym.parent_symbol, cfrag, stop_at_loop);
		} else if (sym.parent_symbol is Method) {
			append_param_free ((Method) sym.parent_symbol, cfrag);
		}
	}

	public void append_error_free (Symbol sym, CCodeFragment cfrag, TryStatement current_try) {
		var b = (Block) sym;

		var local_vars = b.get_local_variables ();
		foreach (LocalVariable local in local_vars) {
			if (local.active && !local.floating && requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				cfrag.append (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
			}
		}

		if (sym == current_try.body) {
			return;
		}

		if (sym.parent_symbol is Block) {
			append_error_free (sym.parent_symbol, cfrag, current_try);
		} else if (sym.parent_symbol is Method) {
			append_param_free ((Method) sym.parent_symbol, cfrag);
		}
	}

	private void append_param_free (Method m, CCodeFragment cfrag) {
		foreach (FormalParameter param in m.get_parameters ()) {
			if (requires_destroy (param.parameter_type) && param.direction == ParameterDirection.IN) {
				var ma = new MemberAccess.simple (param.name);
				ma.symbol_reference = param;
				cfrag.append (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (param.name), param.parameter_type, ma)));
			}
		}
	}

	public void create_local_free (CodeNode stmt, bool stop_at_loop = false) {
		var cfrag = new CCodeFragment ();
	
		append_local_free (current_symbol, cfrag, stop_at_loop);

		cfrag.append (stmt.ccodenode);
		stmt.ccodenode = cfrag;
	}

	private bool append_local_free_expr (Symbol sym, CCodeCommaExpression ccomma, bool stop_at_loop = false) {
		bool found = false;
	
		var b = (Block) sym;

		var local_vars = b.get_local_variables ();
		foreach (LocalVariable local in local_vars) {
			if (local.active && !local.floating && requires_destroy (local.variable_type)) {
				found = true;
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				ccomma.append_expression (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma));
			}
		}
		
		if (sym.parent_symbol is Block) {
			found = append_local_free_expr (sym.parent_symbol, ccomma, stop_at_loop) || found;
		} else if (sym.parent_symbol is Method) {
			found = append_param_free_expr ((Method) sym.parent_symbol, ccomma) || found;
		}
		
		return found;
	}

	private bool append_param_free_expr (Method m, CCodeCommaExpression ccomma) {
		bool found = false;

		foreach (FormalParameter param in m.get_parameters ()) {
			if (requires_destroy (param.parameter_type) && param.direction == ParameterDirection.IN) {
				found = true;
				var ma = new MemberAccess.simple (param.name);
				ma.symbol_reference = param;
				ccomma.append_expression (get_unref_expression (get_variable_cexpression (param.name), param.parameter_type, ma));
			}
		}

		return found;
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		// avoid unnecessary ref/unref pair
		if (stmt.return_expression != null) {
			var local = stmt.return_expression.symbol_reference as LocalVariable;
			if (current_return_type.value_owned
			    && local != null && local.variable_type.value_owned) {
				/* return expression is local variable taking ownership and
				 * current method is transferring ownership */

				// don't ref expression
				stmt.return_expression.value_type.value_owned = true;
			}
		}

		stmt.accept_children (codegen);

		if (stmt.return_expression == null) {
			var cfrag = new CCodeFragment ();

			// free local variables
			append_local_free (current_symbol, cfrag);

			if (current_method != null) {
				// check postconditions
				foreach (Expression postcondition in current_method.get_postconditions ()) {
					cfrag.append (create_postcondition_statement (postcondition));
				}
			}

			cfrag.append (new CCodeReturnStatement ());

			stmt.ccodenode = cfrag;
		} else {
			Symbol return_expression_symbol = null;

			// avoid unnecessary ref/unref pair
			var local = stmt.return_expression.symbol_reference as LocalVariable;
			if (current_return_type.value_owned
			    && local != null && local.variable_type.value_owned) {
				/* return expression is local variable taking ownership and
				 * current method is transferring ownership */

				// don't unref variable
				return_expression_symbol = local;
				return_expression_symbol.active = false;
			}

			// return array length if appropriate
			if (((current_method != null && !current_method.no_array_length) || current_property_accessor != null) && current_return_type is ArrayType) {
				var return_expr_decl = get_temp_variable (stmt.return_expression.value_type, true, stmt);

				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (return_expr_decl.name), (CCodeExpression) stmt.return_expression.ccodenode));

				var array_type = (ArrayType) current_return_type;

				for (int dim = 1; dim <= array_type.rank; dim++) {
					var len_l = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (head.get_array_length_cname ("result", dim)));
					var len_r = head.get_array_length_cexpression (stmt.return_expression, dim);
					ccomma.append_expression (new CCodeAssignment (len_l, len_r));
				}

				ccomma.append_expression (get_variable_cexpression (return_expr_decl.name));
				
				stmt.return_expression.ccodenode = ccomma;
				stmt.return_expression.temp_vars.add (return_expr_decl);
			}

			var cfrag = new CCodeFragment ();

			// assign method result to `result'
			cfrag.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("result"), (CCodeExpression) stmt.return_expression.ccodenode)));

			// free local variables
			append_local_free (current_symbol, cfrag);

			if (current_method != null) {
				// check postconditions
				foreach (Expression postcondition in current_method.get_postconditions ()) {
					cfrag.append (create_postcondition_statement (postcondition));
				}
			}

			// Property getters of non simple structs shall return the struct value as out parameter,
			// therefore replace any return statement with an assignment statement to the out formal
			// paramenter and insert an empty return statement afterwards.
			if (current_property_accessor != null &&
			    current_property_accessor.readable &&
			    current_property_accessor.prop.property_type.is_real_struct_type()) {
				cfrag.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("*value"), new CCodeIdentifier ("result"))));
				cfrag.append (new CCodeReturnStatement ());
			} else {
				cfrag.append (new CCodeReturnStatement (new CCodeIdentifier ("result")));
			}

			stmt.ccodenode = cfrag;

			create_temp_decl (stmt, stmt.return_expression.temp_vars);

			if (return_expression_symbol != null) {
				return_expression_symbol.active = true;
			}
		}
	}

	public string get_symbol_lock_name (Symbol sym) {
		return "__lock_%s".printf (sym.name);
	}

	public override void visit_lock_statement (LockStatement stmt) {
		var cn = new CCodeFragment ();
		CCodeExpression l = null;
		CCodeFunctionCall fc;
		var inner_node = ((MemberAccess)stmt.resource).inner;
		
		if (inner_node  == null) {
			l = new CCodeIdentifier ("self");
		} else if (stmt.resource.symbol_reference.parent_symbol != current_type_symbol) {
			 l = new InstanceCast ((CCodeExpression) inner_node.ccodenode, (TypeSymbol) stmt.resource.symbol_reference.parent_symbol);
		} else {
			l = (CCodeExpression) inner_node.ccodenode;
		}
		l = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (l, "priv"), get_symbol_lock_name (stmt.resource.symbol_reference));
		
		fc = new CCodeFunctionCall (new CCodeIdentifier (((Method) mutex_type.scope.lookup ("lock")).get_cname ()));
		fc.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));

		cn.append (new CCodeExpressionStatement (fc));
		
		cn.append (stmt.body.ccodenode);
		
		fc = new CCodeFunctionCall (new CCodeIdentifier (((Method) mutex_type.scope.lookup ("unlock")).get_cname ()));
		fc.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));
		cn.append (new CCodeExpressionStatement (fc));
		
		stmt.ccodenode = cn;
	}

	public override void visit_delete_statement (DeleteStatement stmt) {
		stmt.accept_children (codegen);

		var pointer_type = (PointerType) stmt.expression.value_type;
		DataType type = pointer_type;
		if (pointer_type.base_type.data_type != null && pointer_type.base_type.data_type.is_reference_type ()) {
			type = pointer_type.base_type;
		}

		var ccall = new CCodeFunctionCall (get_destroy_func_expression (type));
		ccall.add_argument ((CCodeExpression) stmt.expression.ccodenode);
		stmt.ccodenode = new CCodeExpressionStatement (ccall);
	}

	public override void visit_expression (Expression expr) {
		if (expr.ccodenode != null && !expr.lvalue) {
			if (expr.formal_value_type is GenericType && !(expr.value_type is GenericType)) {
				if (expr.formal_value_type.type_parameter.parent_symbol != garray_type) {
					// GArray doesn't use pointer-based generics
					expr.ccodenode = convert_from_generic_pointer ((CCodeExpression) expr.ccodenode, expr.value_type);
				}
			}

			// memory management, implicit casts, and boxing/unboxing
			expr.ccodenode = transform_expression ((CCodeExpression) expr.ccodenode, expr.value_type, expr.target_type, expr);

			if (expr.formal_target_type is GenericType && !(expr.target_type is GenericType)) {
				if (expr.formal_target_type.type_parameter.parent_symbol != garray_type) {
					// GArray doesn't use pointer-based generics
					expr.ccodenode = convert_to_generic_pointer ((CCodeExpression) expr.ccodenode, expr.target_type);
				}
			}
		}
	}

	public override void visit_boolean_literal (BooleanLiteral expr) {
		if (context.profile == Profile.GOBJECT) {
			expr.ccodenode = new CCodeConstant (expr.value ? "TRUE" : "FALSE");
		} else {
			source_declarations.add_include ("stdbool.h");
			expr.ccodenode = new CCodeConstant (expr.value ? "true" : "false");
		}
	}

	public override void visit_character_literal (CharacterLiteral expr) {
		if (expr.get_char () >= 0x20 && expr.get_char () < 0x80) {
			expr.ccodenode = new CCodeConstant (expr.value);
		} else {
			expr.ccodenode = new CCodeConstant ("%uU".printf (expr.get_char ()));
		}
	}

	public override void visit_integer_literal (IntegerLiteral expr) {
		expr.ccodenode = new CCodeConstant (expr.value);
	}

	public override void visit_real_literal (RealLiteral expr) {
		string c_literal = expr.value;
		if (c_literal.has_suffix ("d") || c_literal.has_suffix ("D")) {
			// there is no suffix for double in C
			c_literal = c_literal.substring (0, c_literal.length - 1);
		}
		if (!("." in c_literal || "e" in c_literal || "E" in c_literal)) {
			// C requires period or exponent part for floating constants
			if ("f" in c_literal || "F" in c_literal) {
				c_literal = c_literal.substring (0, c_literal.length - 1) + ".f";
			} else {
				c_literal += ".";
			}
		}
		expr.ccodenode = new CCodeConstant (c_literal);
	}

	public override void visit_string_literal (StringLiteral expr) {
		expr.ccodenode = new CCodeConstant (expr.value);
	}

	public override void visit_null_literal (NullLiteral expr) {
		if (context.profile != Profile.GOBJECT) {
			source_declarations.add_include ("stddef.h");
		}
		expr.ccodenode = new CCodeConstant ("NULL");
	}

	public virtual string get_delegate_target_cname (string delegate_cname) {
		assert_not_reached ();
	}

	public virtual CCodeExpression get_delegate_target_cexpression (Expression delegate_expr) {
		assert_not_reached ();
	}

	public virtual string get_delegate_target_destroy_notify_cname (string delegate_cname) {
		assert_not_reached ();
	}

	public override void visit_base_access (BaseAccess expr) {
		expr.ccodenode = new InstanceCast (new CCodeIdentifier ("self"), expr.value_type.data_type);
	}

	public override void visit_postfix_expression (PostfixExpression expr) {
		MemberAccess ma = find_property_access (expr.inner);
		if (ma != null) {
			// property postfix expression
			var prop = (Property) ma.symbol_reference;
			
			var ccomma = new CCodeCommaExpression ();
			
			// assign current value to temp variable
			var temp_decl = get_temp_variable (prop.property_type, true, expr);
			temp_vars.insert (0, temp_decl);
			ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_decl.name), (CCodeExpression) expr.inner.ccodenode));
			
			// increment/decrement property
			var op = expr.increment ? CCodeBinaryOperator.PLUS : CCodeBinaryOperator.MINUS;
			var cexpr = new CCodeBinaryExpression (op, get_variable_cexpression (temp_decl.name), new CCodeConstant ("1"));
			var ccall = get_property_set_call (prop, ma, cexpr);
			ccomma.append_expression (ccall);
			
			// return previous value
			ccomma.append_expression (new CCodeIdentifier (temp_decl.name));
			
			expr.ccodenode = ccomma;
			return;
		}
	
		var op = expr.increment ? CCodeUnaryOperator.POSTFIX_INCREMENT : CCodeUnaryOperator.POSTFIX_DECREMENT;
	
		expr.ccodenode = new CCodeUnaryExpression (op, (CCodeExpression) expr.inner.ccodenode);
	}
	
	private MemberAccess? find_property_access (Expression expr) {
		if (!(expr is MemberAccess)) {
			return null;
		}
		
		var ma = (MemberAccess) expr;
		if (ma.symbol_reference is Property) {
			return ma;
		}
		
		return null;
	}

	public bool requires_copy (DataType type) {
		if (!type.is_disposable ()) {
			return false;
		}

		var cl = type.data_type as Class;
		if (cl != null && cl.is_reference_counting ()
		    && cl.get_ref_function () == "") {
			// empty ref_function => no ref necessary
			return false;
		}

		if (type.type_parameter != null) {
			if (!(current_type_symbol is Class) || current_class.is_compact) {
				return false;
			}
		}

		return true;
	}

	public bool requires_destroy (DataType type) {
		if (!type.is_disposable ()) {
			return false;
		}

		var array_type = type as ArrayType;
		if (array_type != null && array_type.fixed_length) {
			return requires_destroy (array_type.element_type);
		}

		var cl = type.data_type as Class;
		if (cl != null && cl.is_reference_counting ()
		    && cl.get_unref_function () == "") {
			// empty unref_function => no unref necessary
			return false;
		}

		if (type.type_parameter != null) {
			if (!(current_type_symbol is Class) || current_class.is_compact) {
				return false;
			}
		}

		return true;
	}

	bool is_ref_function_void (DataType type) {
		var cl = type.data_type as Class;
		if (cl != null && cl.ref_function_void) {
			return true;
		} else {
			return false;
		}
	}

	public virtual CCodeExpression? get_ref_cexpression (DataType expression_type, CCodeExpression cexpr, Expression? expr, CodeNode node) {
		if (expression_type is ValueType && !expression_type.nullable) {
			// normal value type, no null check
			// (copy (&expr, &temp), temp)

			var decl = get_temp_variable (expression_type, false, node);
			temp_vars.insert (0, decl);

			var ctemp = get_variable_cexpression (decl.name);
			
			var vt = (ValueType) expression_type;
			var st = (Struct) vt.type_symbol;
			var copy_call = new CCodeFunctionCall (new CCodeIdentifier (st.get_copy_function ()));
			copy_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr));
			copy_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));

			var ccomma = new CCodeCommaExpression ();

			if (st.get_copy_function () == "g_value_copy") {
				// GValue requires g_value_init in addition to g_value_copy

				var value_type_call = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_TYPE"));
				value_type_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr));

				var init_call = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
				init_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
				init_call.add_argument (value_type_call);

				ccomma.append_expression (init_call);
			}

			ccomma.append_expression (copy_call);
			ccomma.append_expression (ctemp);

			if (expression_type.data_type == gvalue_type) {
				// g_value_init/copy must not be called for uninitialized values
				var cisvalid = new CCodeFunctionCall (new CCodeIdentifier ("G_IS_VALUE"));
				cisvalid.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr));

				return new CCodeConditionalExpression (cisvalid, ccomma, cexpr);
			} else {
				return ccomma;
			}
		}

		/* (temp = expr, temp == NULL ? NULL : ref (temp))
		 *
		 * can be simplified to
		 * ref (expr)
		 * if static type of expr is non-null
		 */
		 
		var dupexpr = get_dup_func_expression (expression_type, node.source_reference);

		if (dupexpr == null) {
			node.error = true;
			return null;
		}

		var ccall = new CCodeFunctionCall (dupexpr);

		if (!(expression_type is ArrayType) && expr != null && expr.is_non_null ()
		    && !is_ref_function_void (expression_type)) {
			// expression is non-null
			ccall.add_argument ((CCodeExpression) expr.ccodenode);
			
			return ccall;
		} else {
			var decl = get_temp_variable (expression_type, false, node);
			temp_vars.insert (0, decl);

			var ctemp = get_variable_cexpression (decl.name);
			
			var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ctemp, new CCodeConstant ("NULL"));
			if (expression_type.type_parameter != null) {
				if (!(current_type_symbol is Class)) {
					return cexpr;
				}

				// dup functions are optional for type parameters
				var cdupisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, get_dup_func_expression (expression_type, node.source_reference), new CCodeConstant ("NULL"));
				cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cisnull, cdupisnull);
			}

			if (expression_type.type_parameter != null) {
				// cast from gconstpointer to gpointer as GBoxedCopyFunc expects gpointer
				ccall.add_argument (new CCodeCastExpression (ctemp, "gpointer"));
			} else {
				ccall.add_argument (ctemp);
			}

			if (expression_type is ArrayType) {
				var array_type = (ArrayType) expression_type;
				bool first = true;
				CCodeExpression csizeexpr = null;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					if (first) {
						csizeexpr = head.get_array_length_cexpression (expr, dim);
						first = false;
					} else {
						csizeexpr = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, csizeexpr, head.get_array_length_cexpression (expr, dim));
					}
				}

				ccall.add_argument (csizeexpr);
			}

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (ctemp, cexpr));

			CCodeExpression cifnull;
			if (expression_type.data_type != null) {
				cifnull = new CCodeConstant ("NULL");
			} else {
				// the value might be non-null even when the dup function is null,
				// so we may not just use NULL for type parameters

				// cast from gconstpointer to gpointer as methods in
				// generic classes may not return gconstpointer
				cifnull = new CCodeCastExpression (ctemp, "gpointer");
			}
			ccomma.append_expression (new CCodeConditionalExpression (cisnull, cifnull, ccall));

			// repeat temp variable at the end of the comma expression
			// if the ref function returns void
			if (is_ref_function_void (expression_type)) {
				ccomma.append_expression (ctemp);
			}

			return ccomma;
		}
	}

	bool is_reference_type_argument (DataType type_arg) {
		if (type_arg.data_type != null && type_arg.data_type.is_reference_type ()) {
			return true;
		} else {
			return false;
		}
	}

	bool is_nullable_value_type_argument (DataType type_arg) {
		if (type_arg is ValueType && type_arg.nullable) {
			return true;
		} else {
			return false;
		}
	}

	bool is_signed_integer_type_argument (DataType type_arg) {
		var st = type_arg.data_type as Struct;
		if (type_arg.nullable) {
			return false;
		} else if (st == bool_type.data_type) {
			return true;
		} else if (st == char_type.data_type) {
			return true;
		} else if (unichar_type != null && st == unichar_type.data_type) {
			return true;
		} else if (st == short_type.data_type) {
			return true;
		} else if (st == int_type.data_type) {
			return true;
		} else if (st == long_type.data_type) {
			return true;
		} else if (st == int8_type.data_type) {
			return true;
		} else if (st == int16_type.data_type) {
			return true;
		} else if (st == int32_type.data_type) {
			return true;
		} else if (st == gtype_type) {
			return true;
		} else {
			return false;
		}
	}

	bool is_unsigned_integer_type_argument (DataType type_arg) {
		var st = type_arg.data_type as Struct;
		if (type_arg.nullable) {
			return false;
		} else if (st == uchar_type.data_type) {
			return true;
		} else if (st == ushort_type.data_type) {
			return true;
		} else if (st == uint_type.data_type) {
			return true;
		} else if (st == ulong_type.data_type) {
			return true;
		} else if (st == uint8_type.data_type) {
			return true;
		} else if (st == uint16_type.data_type) {
			return true;
		} else if (st == uint32_type.data_type) {
			return true;
		} else {
			return false;
		}
	}

	public void check_type (DataType type) {
		var array_type = type as ArrayType;
		if (array_type != null) {
			check_type (array_type.element_type);
		}
		foreach (var type_arg in type.get_type_arguments ()) {
			check_type (type_arg);
			check_type_argument (type_arg);
		}
	}

	void check_type_argument (DataType type_arg) {
		if (type_arg is GenericType
		    || type_arg is PointerType
		    || is_reference_type_argument (type_arg)
		    || is_nullable_value_type_argument (type_arg)
		    || is_signed_integer_type_argument (type_arg)
		    || is_unsigned_integer_type_argument (type_arg)) {
			// no error
		} else {
			Report.error (type_arg.source_reference, "`%s' is not a supported generic type argument, use `?' to box value types".printf (type_arg.to_string ()));
		}
	}

	public virtual void generate_class_declaration (Class cl, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (cl, cl.get_cname ())) {
			return;
		}
	}

	public virtual void generate_interface_declaration (Interface iface, CCodeDeclarationSpace decl_space) {
	}

	public virtual void generate_method_declaration (Method m, CCodeDeclarationSpace decl_space) {
	}

	public virtual void generate_error_domain_declaration (ErrorDomain edomain, CCodeDeclarationSpace decl_space) {
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		expr.accept_children (codegen);

		CCodeExpression instance = null;
		CCodeExpression creation_expr = null;

		check_type (expr.type_reference);

		var st = expr.type_reference.data_type as Struct;
		if ((st != null && !st.is_simple_type ()) || expr.get_object_initializer ().size > 0) {
			// value-type initialization or object creation expression with object initializer
			var temp_decl = get_temp_variable (expr.type_reference, false, expr);
			temp_vars.add (temp_decl);

			instance = get_variable_cexpression (get_variable_cname (temp_decl.name));
		}

		if (expr.symbol_reference == null) {
			CCodeFunctionCall creation_call = null;

			// no creation method
			if (expr.type_reference.data_type == glist_type ||
			    expr.type_reference.data_type == gslist_type) {
				// NULL is an empty list
				expr.ccodenode = new CCodeConstant ("NULL");
			} else if (expr.type_reference.data_type is Class && expr.type_reference.data_type.is_subtype_of (gobject_type)) {
				generate_class_declaration ((Class) expr.type_reference.data_type, source_declarations);

				creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_new"));
				creation_call.add_argument (new CCodeConstant (expr.type_reference.data_type.get_type_id ()));
				creation_call.add_argument (new CCodeConstant ("NULL"));
			} else if (expr.type_reference.data_type is Class) {
				creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
				creation_call.add_argument (new CCodeConstant (expr.type_reference.data_type.get_cname ()));
				creation_call.add_argument (new CCodeConstant ("1"));
			} else if (expr.type_reference.data_type is Struct) {
				// memset needs string.h
				source_declarations.add_include ("string.h");
				creation_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
				creation_call.add_argument (new CCodeConstant ("0"));
				creation_call.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (expr.type_reference.get_cname ())));
			}

			creation_expr = creation_call;
		} else if (expr.symbol_reference is Method) {
			// use creation method
			var m = (Method) expr.symbol_reference;
			var params = m.get_parameters ();
			CCodeFunctionCall creation_call;

			generate_method_declaration (m, source_declarations);

			creation_call = new CCodeFunctionCall (new CCodeIdentifier (m.get_cname ()));

			if ((st != null && !st.is_simple_type ()) && !(m.cinstance_parameter_position < 0)) {
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
			}

			generate_type_declaration (expr.type_reference, source_declarations);

			var cl = expr.type_reference.data_type as Class;
			if (cl != null && !cl.is_compact) {
				foreach (DataType type_arg in expr.type_reference.get_type_arguments ()) {
					creation_call.add_argument (get_type_id_expression (type_arg));
					if (requires_copy (type_arg)) {
						var dup_func = get_dup_func_expression (type_arg, type_arg.source_reference);
						if (dup_func == null) {
							// type doesn't contain a copy function
							expr.error = true;
							return;
						}
						creation_call.add_argument (new CCodeCastExpression (dup_func, "GBoxedCopyFunc"));
						creation_call.add_argument (get_destroy_func_expression (type_arg));
					} else {
						creation_call.add_argument (new CCodeConstant ("NULL"));
						creation_call.add_argument (new CCodeConstant ("NULL"));
					}
				}
			}

			var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

			bool ellipsis = false;

			int i = 1;
			int arg_pos;
			Iterator<FormalParameter> params_it = params.iterator ();
			foreach (Expression arg in expr.get_argument_list ()) {
				CCodeExpression cexpr = (CCodeExpression) arg.ccodenode;
				FormalParameter param = null;
				if (params_it.next ()) {
					param = params_it.get ();
					ellipsis = param.ellipsis;
					if (!ellipsis) {
						if (!param.no_array_length && param.parameter_type is ArrayType) {
							var array_type = (ArrayType) param.parameter_type;
							for (int dim = 1; dim <= array_type.rank; dim++) {
								carg_map.set (get_param_pos (param.carray_length_parameter_position + 0.01 * dim), head.get_array_length_cexpression (arg, dim));
							}
						} else if (param.parameter_type is DelegateType) {
							var deleg_type = (DelegateType) param.parameter_type;
							var d = deleg_type.delegate_symbol;
							if (d.has_target) {
								var delegate_target = get_delegate_target_cexpression (arg);
								carg_map.set (get_param_pos (param.cdelegate_target_parameter_position), delegate_target);
							}
						}

						cexpr = handle_struct_argument (param, arg, cexpr);
					}

					arg_pos = get_param_pos (param.cparameter_position, ellipsis);
				} else {
					// default argument position
					arg_pos = get_param_pos (i, ellipsis);
				}
			
				carg_map.set (arg_pos, cexpr);

				i++;
			}
			while (params_it.next ()) {
				var param = params_it.get ();
				
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
				param.default_expression.accept (codegen);
			
				carg_map.set (get_param_pos (param.cparameter_position), (CCodeExpression) param.default_expression.ccodenode);
				i++;
			}

			// append C arguments in the right order
			int last_pos = -1;
			int min_pos;
			while (true) {
				min_pos = -1;
				foreach (int pos in carg_map.get_keys ()) {
					if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
						min_pos = pos;
					}
				}
				if (min_pos == -1) {
					break;
				}
				creation_call.add_argument (carg_map.get (min_pos));
				last_pos = min_pos;
			}

			if ((st != null && !st.is_simple_type ()) && m.cinstance_parameter_position < 0) {
				// instance parameter is at the end in a struct creation method
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
			}

			if (expr.tree_can_fail) {
				// method can fail
				current_method_inner_error = true;
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_inner_error_")));
			}

			if (ellipsis) {
				/* ensure variable argument list ends with NULL
				 * except when using printf-style arguments */
				if (!m.printf_format && m.sentinel != "") {
					creation_call.add_argument (new CCodeConstant (m.sentinel));
				}
			}

			creation_expr = creation_call;

			// cast the return value of the creation method back to the intended type if
			// it requested a special C return type
			if (head.get_custom_creturn_type (m) != null) {
				creation_expr = new CCodeCastExpression (creation_expr, expr.type_reference.get_cname ());
			}
		} else if (expr.symbol_reference is ErrorCode) {
			var ecode = (ErrorCode) expr.symbol_reference;
			var edomain = (ErrorDomain) ecode.parent_symbol;
			CCodeFunctionCall creation_call;

			generate_error_domain_declaration (edomain, source_declarations);

			if (expr.get_argument_list ().size == 1) {
				// must not be a format argument
				creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_error_new_literal"));
			} else {
				creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_error_new"));
			}
			creation_call.add_argument (new CCodeIdentifier (edomain.get_upper_case_cname ()));
			creation_call.add_argument (new CCodeIdentifier (ecode.get_cname ()));

			foreach (Expression arg in expr.get_argument_list ()) {
				creation_call.add_argument ((CCodeExpression) arg.ccodenode);
			}

			creation_expr = creation_call;
		} else {
			assert (false);
		}
			
		if (instance != null) {
			var ccomma = new CCodeCommaExpression ();

			if (expr.type_reference.data_type is Struct) {
				ccomma.append_expression (creation_expr);
			} else {
				ccomma.append_expression (new CCodeAssignment (instance, creation_expr));
			}

			foreach (MemberInitializer init in expr.get_object_initializer ()) {
				if (init.symbol_reference is Field) {
					var f = (Field) init.symbol_reference;
					var instance_target_type = get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);
					var typed_inst = transform_expression (instance, expr.type_reference, instance_target_type);
					CCodeExpression lhs;
					if (expr.type_reference.data_type is Struct) {
						lhs = new CCodeMemberAccess (typed_inst, f.get_cname ());
					} else {
						lhs = new CCodeMemberAccess.pointer (typed_inst, f.get_cname ());
					}
					ccomma.append_expression (new CCodeAssignment (lhs, (CCodeExpression) init.initializer.ccodenode));

					if (f.field_type is ArrayType && !f.no_array_length) {
						var array_type = (ArrayType) f.field_type;
						for (int dim = 1; dim <= array_type.rank; dim++) {
							if (expr.type_reference.data_type is Struct) {
								lhs = new CCodeMemberAccess (typed_inst, head.get_array_length_cname (f.get_cname (), dim));
							} else {
								lhs = new CCodeMemberAccess.pointer (typed_inst, head.get_array_length_cname (f.get_cname (), dim));
							}
							var rhs_array_len = head.get_array_length_cexpression (init.initializer, dim);
							ccomma.append_expression (new CCodeAssignment (lhs, rhs_array_len));
						}
					} else if (f.field_type is DelegateType && !f.no_delegate_target) {
						if (expr.type_reference.data_type is Struct) {
							lhs = new CCodeMemberAccess (typed_inst, get_delegate_target_cname (f.get_cname ()));
						} else {
							lhs = new CCodeMemberAccess.pointer (typed_inst, get_delegate_target_cname (f.get_cname ()));
						}
						var rhs_delegate_target = get_delegate_target_cexpression (init.initializer);
						ccomma.append_expression (new CCodeAssignment (lhs, rhs_delegate_target));
					}
				} else if (init.symbol_reference is Property) {
					var inst_ma = new MemberAccess.simple ("new");
					inst_ma.value_type = expr.type_reference;
					inst_ma.ccodenode = instance;
					var ma = new MemberAccess (inst_ma, init.name);
					ccomma.append_expression (get_property_set_call ((Property) init.symbol_reference, ma, (CCodeExpression) init.initializer.ccodenode));
				}
			}

			ccomma.append_expression (instance);

			expr.ccodenode = ccomma;
		} else if (creation_expr != null) {
			expr.ccodenode = creation_expr;
		}
	}

	public CCodeExpression? handle_struct_argument (FormalParameter param, Expression arg, CCodeExpression? cexpr) {
		// pass non-simple struct instances always by reference
		if (!(arg.value_type is NullType) && param.parameter_type.data_type is Struct && !((Struct) param.parameter_type.data_type).is_simple_type ()) {
			// we already use a reference for arguments of ref, out, and nullable parameters
			if (param.direction == ParameterDirection.IN && !param.parameter_type.nullable) {
				var unary = cexpr as CCodeUnaryExpression;
				if (unary != null && unary.operator == CCodeUnaryOperator.POINTER_INDIRECTION) {
					// *expr => expr
					return unary.inner;
				} else if (cexpr is CCodeIdentifier || cexpr is CCodeMemberAccess) {
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr);
				} else {
					// if cexpr is e.g. a function call, we can't take the address of the expression
					// (tmp = expr, &tmp)
					var ccomma = new CCodeCommaExpression ();

					var temp_var = get_temp_variable (param.parameter_type);
					temp_vars.insert (0, temp_var);
					ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), cexpr));
					ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_var.name)));

					return ccomma;
				}
			}
		}

		return cexpr;
	}

	public override void visit_sizeof_expression (SizeofExpression expr) {
		var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
		csizeof.add_argument (new CCodeIdentifier (expr.type_reference.get_cname ()));
		expr.ccodenode = csizeof;
	}

	public override void visit_typeof_expression (TypeofExpression expr) {
		expr.ccodenode = get_type_id_expression (expr.type_reference);
	}

	public override void visit_unary_expression (UnaryExpression expr) {
		expr.accept_children (codegen);

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
		} else {
			assert_not_reached ();
		}
		expr.ccodenode = new CCodeUnaryExpression (op, (CCodeExpression) expr.inner.ccodenode);
	}

	public override void visit_cast_expression (CastExpression expr) {
		if (expr.inner.value_type != null && expr.inner.value_type.data_type == gvalue_type
		    && expr.type_reference.get_type_id () != null) {
			// explicit conversion from GValue
			var ccall = new CCodeFunctionCall (new CCodeIdentifier (expr.type_reference.data_type.get_get_value_function ()));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, (CCodeExpression) expr.inner.ccodenode));
			expr.ccodenode = ccall;
			return;
		}

		var cl = expr.type_reference.data_type as Class;
		var iface = expr.type_reference.data_type as Interface;
		if (iface != null || (cl != null && !cl.is_compact)) {
			// checked cast for strict subtypes of GTypeInstance
			if (expr.is_silent_cast) {
				var ccomma = new CCodeCommaExpression ();
				var temp_decl = get_temp_variable (expr.inner.value_type, true, expr);

				temp_vars.add (temp_decl);

				var ctemp = get_variable_cexpression (temp_decl.name);
				var cinit = new CCodeAssignment (ctemp, (CCodeExpression) expr.inner.ccodenode);
				var ccheck = create_type_check (ctemp, expr.type_reference);
				var ccast = new CCodeCastExpression (ctemp, expr.type_reference.get_cname ());
				var cnull = new CCodeConstant ("NULL");

				ccomma.append_expression (cinit);
				ccomma.append_expression (new CCodeConditionalExpression (ccheck, ccast, cnull));
	
				expr.ccodenode = ccomma;
			} else {
				expr.ccodenode = new InstanceCast ((CCodeExpression) expr.inner.ccodenode, expr.type_reference.data_type);
			}
		} else {
			if (expr.is_silent_cast) {
				expr.error = true;
				Report.error (expr.source_reference, "Operation not supported for this type");
				return;
			}
			expr.ccodenode = new CCodeCastExpression ((CCodeExpression) expr.inner.ccodenode, expr.type_reference.get_cname ());
		}
	}
	
	public override void visit_pointer_indirection (PointerIndirection expr) {
		expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, (CCodeExpression) expr.inner.ccodenode);
	}

	public override void visit_addressof_expression (AddressofExpression expr) {
		expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, (CCodeExpression) expr.inner.ccodenode);
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		expr.accept_children (codegen);

		/* (tmp = var, var = null, tmp) */
		var ccomma = new CCodeCommaExpression ();
		var temp_decl = get_temp_variable (expr.value_type, true, expr);
		temp_vars.insert (0, temp_decl);
		var cvar = get_variable_cexpression (temp_decl.name);

		ccomma.append_expression (new CCodeAssignment (cvar, (CCodeExpression) expr.inner.ccodenode));
		ccomma.append_expression (new CCodeAssignment ((CCodeExpression) expr.inner.ccodenode, new CCodeConstant ("NULL")));
		ccomma.append_expression (cvar);
		expr.ccodenode = ccomma;
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		expr.accept_children (codegen);

		var cleft = (CCodeExpression) expr.left.ccodenode;
		var cright = (CCodeExpression) expr.right.ccodenode;
		
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
		} else if (expr.operator == BinaryOperator.IN) {
			expr.ccodenode = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeBinaryExpression (CCodeBinaryOperator.BITWISE_AND, cright, cleft), cleft);
			return;
		} else {
			assert_not_reached ();
		}
		
		if (expr.operator == BinaryOperator.EQUALITY ||
		    expr.operator == BinaryOperator.INEQUALITY) {
			var left_type_as_struct = expr.left.value_type.data_type as Struct;
			var right_type_as_struct = expr.right.value_type.data_type as Struct;

			if (expr.left.value_type.data_type is Class && !((Class) expr.left.value_type.data_type).is_compact &&
			    expr.right.value_type.data_type is Class && !((Class) expr.right.value_type.data_type).is_compact) {
				var left_cl = (Class) expr.left.value_type.data_type;
				var right_cl = (Class) expr.right.value_type.data_type;
				
				if (left_cl != right_cl) {
					if (left_cl.is_subtype_of (right_cl)) {
						cleft = new InstanceCast (cleft, right_cl);
					} else if (right_cl.is_subtype_of (left_cl)) {
						cright = new InstanceCast (cright, left_cl);
					}
				}
			} else if (left_type_as_struct != null && right_type_as_struct != null) {
				// FIXME generate and use compare/equal function for real structs
				if (expr.left.value_type.nullable && expr.right.value_type.nullable) {
					// FIXME also compare contents, not just address
				} else if (expr.left.value_type.nullable) {
					// FIXME check left value is not null
					cleft = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, cleft);
				} else if (expr.right.value_type.nullable) {
					// FIXME check right value is not null
					cright = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, cright);
				}
			}
		}

		if (!(expr.left.value_type is NullType)
		    && expr.left.value_type.compatible (string_type)
		    && !(expr.right.value_type is NullType)
		    && expr.right.value_type.compatible (string_type)) {
			if (expr.operator == BinaryOperator.PLUS) {
				// string concatenation
				if (expr.left.is_constant () && expr.right.is_constant ()) {
					string left, right;

					if (cleft is CCodeIdentifier) {
						left = ((CCodeIdentifier) cleft).name;
					} else if (cleft is CCodeConstant) {
						left = ((CCodeConstant) cleft).name;
					} else {
						assert_not_reached ();
					}
					if (cright is CCodeIdentifier) {
						right = ((CCodeIdentifier) cright).name;
					} else if (cright is CCodeConstant) {
						right = ((CCodeConstant) cright).name;
					} else {
						assert_not_reached ();
					}

					expr.ccodenode = new CCodeConstant ("%s %s".printf (left, right));
					return;
				} else {
					// convert to g_strconcat (a, b, NULL)
					var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_strconcat"));
					ccall.add_argument (cleft);
					ccall.add_argument (cright);
					ccall.add_argument (new CCodeConstant("NULL"));
					expr.ccodenode = ccall;
					return;
				}
			} else if (expr.operator == BinaryOperator.EQUALITY
			           || expr.operator == BinaryOperator.INEQUALITY
			           || expr.operator == BinaryOperator.LESS_THAN
			           || expr.operator == BinaryOperator.GREATER_THAN
			           || expr.operator == BinaryOperator.LESS_THAN_OR_EQUAL
			           || expr.operator == BinaryOperator.GREATER_THAN_OR_EQUAL) {
				requires_strcmp0 = true;
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("_vala_strcmp0"));
				ccall.add_argument (cleft);
				ccall.add_argument (cright);
				cleft = ccall;
				cright = new CCodeConstant ("0");
			}
		}

		expr.ccodenode = new CCodeBinaryExpression (op, cleft, cright);
	}

	public string get_type_check_function (TypeSymbol type) {
		var cl = type as Class;
		if (cl != null && cl.type_check_function != null) {
			return cl.type_check_function;
		} else {
			return type.get_upper_case_cname ("IS_");
		}
	}

	CCodeExpression create_type_check (CCodeNode ccodenode, DataType type) {
		var et = type as ErrorType;
		if (et != null && et.error_code != null) {
			var matches_call = new CCodeFunctionCall (new CCodeIdentifier ("g_error_matches"));
			matches_call.add_argument ((CCodeExpression) ccodenode);
			matches_call.add_argument (new CCodeIdentifier (et.error_domain.get_upper_case_cname ()));
			matches_call.add_argument (new CCodeIdentifier (et.error_code.get_cname ()));
			return matches_call;
		} else if (et != null && et.error_domain != null) {
			var instance_domain = new CCodeMemberAccess.pointer ((CCodeExpression) ccodenode, "domain");
			var type_domain = new CCodeIdentifier (et.error_domain.get_upper_case_cname ());
			return new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, instance_domain, type_domain);
		} else {
			var ccheck = new CCodeFunctionCall (new CCodeIdentifier (get_type_check_function (type.data_type)));
			ccheck.add_argument ((CCodeExpression) ccodenode);
			return ccheck;
		}
	}

	public override void visit_type_check (TypeCheck expr) {
		generate_type_declaration (expr.type_reference, source_declarations);

		expr.ccodenode = create_type_check (expr.expression.ccodenode, expr.type_reference);
	}

	public override void visit_lambda_expression (LambdaExpression l) {
		// use instance position from delegate
		var dt = (DelegateType) l.target_type;
		l.method.cinstance_parameter_position = dt.delegate_symbol.cinstance_parameter_position;

		var old_temp_vars = temp_vars;
		var old_temp_ref_vars = temp_ref_vars;
		temp_vars = new ArrayList<LocalVariable> ();
		temp_ref_vars = new ArrayList<LocalVariable> ();

		l.accept_children (codegen);

		temp_vars = old_temp_vars;
		temp_ref_vars = old_temp_ref_vars;

		l.ccodenode = new CCodeIdentifier (l.method.get_cname ());
	}

	public CCodeExpression convert_from_generic_pointer (CCodeExpression cexpr, DataType actual_type) {
		var result = cexpr;
		if (is_reference_type_argument (actual_type) || is_nullable_value_type_argument (actual_type)) {
			result = new CCodeCastExpression (cexpr, actual_type.get_cname ());
		} else if (is_signed_integer_type_argument (actual_type)) {
			var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GPOINTER_TO_INT"));
			cconv.add_argument (cexpr);
			result = cconv;
		} else if (is_unsigned_integer_type_argument (actual_type)) {
			var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GPOINTER_TO_UINT"));
			cconv.add_argument (cexpr);
			result = cconv;
		}
		return result;
	}

	public CCodeExpression convert_to_generic_pointer (CCodeExpression cexpr, DataType actual_type) {
		var result = cexpr;
		if (is_signed_integer_type_argument (actual_type)) {
			var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GINT_TO_POINTER"));
			cconv.add_argument (cexpr);
			result = cconv;
		} else if (is_unsigned_integer_type_argument (actual_type)) {
			var cconv = new CCodeFunctionCall (new CCodeIdentifier ("GUINT_TO_POINTER"));
			cconv.add_argument (cexpr);
			result = cconv;
		}
		return result;
	}

	// manage memory and implicit casts
	public CCodeExpression transform_expression (CCodeExpression source_cexpr, DataType? expression_type, DataType? target_type, Expression? expr = null) {
		var cexpr = source_cexpr;
		if (expression_type == null) {
			return cexpr;
		}


		if (expression_type.value_owned
		    && expression_type.floating_reference) {
			/* floating reference, sink it.
			 */
			var cl = expression_type.data_type as ObjectTypeSymbol;
			var sink_func = (cl != null) ? cl.get_ref_sink_function () : null;

			if (sink_func != null) {
				var csink = new CCodeFunctionCall (new CCodeIdentifier (sink_func));
				csink.add_argument (cexpr);
				
				cexpr = csink;
			} else {
				Report.error (null, "type `%s' does not support floating references".printf (expression_type.data_type.name));
			}
		}

		bool boxing = (expression_type is ValueType && !expression_type.nullable
		               && target_type is ValueType && target_type.nullable);
		bool unboxing = (expression_type is ValueType && expression_type.nullable
		                 && target_type is ValueType && !target_type.nullable);

		bool gvalue_boxing = (target_type != null
		                      && target_type.data_type == gvalue_type
		                      && expression_type.data_type != gvalue_type);

		if (expression_type.value_owned
		    && (target_type == null || !target_type.value_owned || boxing || unboxing || gvalue_boxing)) {
			// value leaked, destroy it
			var pointer_type = target_type as PointerType;
			if (pointer_type != null && !(pointer_type.base_type is VoidType)) {
				// manual memory management for non-void pointers
				// treat void* special to not leak memory with void* method parameters
			} else if (requires_destroy (expression_type)) {
				var decl = get_temp_variable (expression_type, true, expression_type);
				temp_vars.insert (0, decl);
				temp_ref_vars.insert (0, decl);
				cexpr = new CCodeAssignment (get_variable_cexpression (decl.name), cexpr);

				if (expression_type is ArrayType && expr != null) {
					var array_type = (ArrayType) expression_type;
					var ccomma = new CCodeCommaExpression ();
					ccomma.append_expression (cexpr);
					for (int dim = 1; dim <= array_type.rank; dim++) {
						var len_decl = new LocalVariable (int_type.copy (), head.get_array_length_cname (decl.name, dim));
						temp_vars.insert (0, len_decl);
						ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (len_decl.name), head.get_array_length_cexpression (expr, dim)));
					}
					ccomma.append_expression (get_variable_cexpression (decl.name));
					cexpr = ccomma;
				}
			}
		}

		if (target_type == null) {
			// value will be destroyed, no need for implicit casts
			return cexpr;
		}

		if (gvalue_boxing) {
			// implicit conversion to GValue
			var decl = get_temp_variable (target_type, true, target_type);
			temp_vars.insert (0, decl);

			var ccomma = new CCodeCommaExpression ();

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (decl.name)));
			ccall.add_argument (new CCodeIdentifier (expression_type.get_type_id ()));
			ccomma.append_expression (ccall);

			ccall = new CCodeFunctionCall (get_value_setter_function (expression_type));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (decl.name)));
			ccall.add_argument (cexpr);
			ccomma.append_expression (ccall);

			ccomma.append_expression (get_variable_cexpression (decl.name));
			cexpr = ccomma;

			return cexpr;
		} else if (boxing) {
			// value needs to be boxed

			var unary = cexpr as CCodeUnaryExpression;
			if (unary != null && unary.operator == CCodeUnaryOperator.POINTER_INDIRECTION) {
				// *expr => expr
				cexpr = unary.inner;
			} else if (cexpr is CCodeIdentifier || cexpr is CCodeMemberAccess) {
				cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr);
			} else {
				var decl = get_temp_variable (expression_type, expression_type.value_owned, expression_type);
				temp_vars.insert (0, decl);

				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (decl.name), cexpr));
				ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (decl.name)));
				cexpr = ccomma;
			}
		} else if (unboxing) {
			// unbox value

			cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, cexpr);
		} else {
			cexpr = get_implicit_cast_expression (cexpr, expression_type, target_type, expr);
		}

		if (target_type.value_owned && (!expression_type.value_owned || boxing || unboxing)) {
			// need to copy value
			if (requires_copy (target_type) && !(expression_type is NullType)) {
				CodeNode node = expr;
				if (node == null) {
					node = expression_type;
				}
				cexpr = get_ref_cexpression (target_type, cexpr, expr, node);
			}
		}

		return cexpr;
	}

	public virtual CCodeExpression get_implicit_cast_expression (CCodeExpression source_cexpr, DataType? expression_type, DataType? target_type, Expression? expr = null) {
		var cexpr = source_cexpr;

		if (expression_type.data_type != null && expression_type.data_type == target_type.data_type) {
			// same type, no cast required
			return cexpr;
		}

		if (expression_type is NullType) {
			// null literal, no cast required when not converting to generic type pointer
			return cexpr;
		}

		generate_type_declaration (target_type, source_declarations);

		var cl = target_type.data_type as Class;
		var iface = target_type.data_type as Interface;
		if (context.checking && (iface != null || (cl != null && !cl.is_compact))) {
			// checked cast for strict subtypes of GTypeInstance
			return new InstanceCast (cexpr, target_type.data_type);
		} else if (target_type.data_type != null && expression_type.get_cname () != target_type.get_cname ()) {
			var st = target_type.data_type as Struct;
			if (target_type.data_type.is_reference_type () || (st != null && st.is_simple_type ())) {
				// don't cast non-simple structs
				return new CCodeCastExpression (cexpr, target_type.get_cname ());
			} else {
				return cexpr;
			}
		} else {
			return cexpr;
		}
	}

	public CCodeFunctionCall get_property_set_call (Property prop, MemberAccess ma, CCodeExpression cexpr, Expression? rhs = null) {
		if (ma.inner is BaseAccess) {
			if (prop.base_property != null) {
				var base_class = (Class) prop.base_property.parent_symbol;
				var vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (base_class.get_upper_case_cname (null))));
				vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (current_class.get_lower_case_cname (null))));
				
				var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "set_%s".printf (prop.name)));
				ccall.add_argument ((CCodeExpression) get_ccodenode (ma.inner));
				ccall.add_argument (cexpr);
				return ccall;
			} else if (prop.base_interface_property != null) {
				var base_iface = (Interface) prop.base_interface_property.parent_symbol;
				string parent_iface_var = "%s_%s_parent_iface".printf (current_class.get_lower_case_cname (null), base_iface.get_lower_case_cname (null));

				var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), "set_%s".printf (prop.name)));
				ccall.add_argument ((CCodeExpression) get_ccodenode (ma.inner));
				ccall.add_argument (cexpr);
				return ccall;
			}
		}

		var set_func = "g_object_set";
		
		var base_property = prop;
		if (!prop.no_accessor_method) {
			if (prop.base_property != null) {
				base_property = prop.base_property;
			} else if (prop.base_interface_property != null) {
				base_property = prop.base_interface_property;
			}

			if (prop is DynamicProperty) {
				set_func = head.get_dynamic_property_setter_cname ((DynamicProperty) prop);
			} else {
				generate_property_accessor_declaration (base_property.set_accessor, source_declarations);
				set_func = base_property.set_accessor.get_cname ();
			}
		}
		
		var ccall = new CCodeFunctionCall (new CCodeIdentifier (set_func));

		if (prop.binding == MemberBinding.INSTANCE) {
			/* target instance is first argument */
			ccall.add_argument ((CCodeExpression) get_ccodenode (ma.inner));
		}

		if (prop.no_accessor_method) {
			/* property name is second argument of g_object_set */
			ccall.add_argument (prop.get_canonical_cconstant ());
		}

		ccall.add_argument (cexpr);

		var array_type = prop.property_type as ArrayType;
		if (array_type != null && rhs != null) {
			for (int dim = 1; dim <= array_type.rank; dim++) {
				ccall.add_argument (head.get_array_length_cexpression (rhs, dim));
			}
		}

		if (prop.no_accessor_method) {
			ccall.add_argument (new CCodeConstant ("NULL"));
		}

		return ccall;
	}

	/* indicates whether a given Expression eligable for an ADDRESS_OF operator
	 * from a vala to C point of view all expressions denoting locals, fields and
	 * parameters are eligable to an ADDRESS_OF operator */
	public bool is_address_of_possible (Expression e) {
		var ma = e as MemberAccess;

		if (ma == null) {
			return false;
		}
		if (ma.symbol_reference == null) {
			return false;
		}
		if (ma.symbol_reference is FormalParameter) {
			return true;
		}
		if (ma.symbol_reference is LocalVariable) {
			return true;
		}
		if (ma.symbol_reference is Field) {
			return true;
		}
		return false;
	}

	/* retrieve the correct address_of expression for a give expression, creates temporary variables
	 * where necessary, ce is the corresponding ccode expression for e */
	public CCodeExpression get_address_of_expression (Expression e, CCodeExpression ce) {
		// is address of trivially possible?
		if (is_address_of_possible (e)) {
			return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ce);
		}

		var ccomma = new CCodeCommaExpression ();
		var temp_decl = get_temp_variable (e.value_type);
		var ctemp = get_variable_cexpression (temp_decl.name);
		temp_vars.add (temp_decl);
		ccomma.append_expression (new CCodeAssignment (ctemp, ce));
		ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
		return ccomma;
	}

	public bool add_wrapper (string wrapper_name) {
		return wrappers.add (wrapper_name);
	}

	public bool add_generated_external_symbol (Symbol external_symbol) {
		return generated_external_symbols.add (external_symbol);
	}

	public static DataType get_data_type_for_symbol (TypeSymbol sym) {
		DataType type = null;

		if (sym is Class) {
			type = new ObjectType ((Class) sym);
		} else if (sym is Interface) {
			type = new ObjectType ((Interface) sym);
		} else if (sym is Struct) {
			var st = (Struct) sym;
			if (st.is_boolean_type ()) {
				type = new BooleanType (st);
			} else if (st.is_integer_type ()) {
				type = new IntegerType (st);
			} else if (st.is_floating_type ()) {
				type = new FloatingType (st);
			} else {
				type = new StructValueType (st);
			}
		} else if (sym is Enum) {
			type = new EnumValueType ((Enum) sym);
		} else if (sym is ErrorDomain) {
			type = new ErrorType ((ErrorDomain) sym, null);
		} else if (sym is ErrorCode) {
			type = new ErrorType ((ErrorDomain) sym.parent_symbol, (ErrorCode) sym);
		} else {
			Report.error (null, "internal error: `%s' is not a supported type".printf (sym.get_full_name ()));
			return new InvalidType ();
		}

		return type;
	}

	public CCodeExpression? default_value_for_type (DataType type, bool initializer_expression) {
		var st = type.data_type as Struct;
		var array_type = type as ArrayType;
		if (initializer_expression && !type.nullable &&
		    ((st != null && !st.is_simple_type ()) ||
		     (array_type != null && array_type.fixed_length))) {
			// 0-initialize struct with struct initializer { 0 }
			// only allowed as initializer expression in C
			var clist = new CCodeInitializerList ();
			clist.append (new CCodeConstant ("0"));
			return clist;
		} else if ((type.data_type != null && type.data_type.is_reference_type ())
		           || type.nullable
		           || type is PointerType || type is DelegateType
		           || (array_type != null && !array_type.fixed_length)) {
			return new CCodeConstant ("NULL");
		} else if (type.data_type != null && type.data_type.get_default_value () != null) {
			return new CCodeConstant (type.data_type.get_default_value ());
		} else if (type.type_parameter != null) {
			return new CCodeConstant ("NULL");
		} else if (type is ErrorType) {
			return new CCodeConstant ("NULL");
		}
		return null;
	}
	
	private CCodeStatement? create_property_type_check_statement (Property prop, bool check_return_type, TypeSymbol t, bool non_null, string var_name) {
		if (check_return_type) {
			return create_type_check_statement (prop, prop.property_type, t, non_null, var_name);
		} else {
			return create_type_check_statement (prop, new VoidType (), t, non_null, var_name);
		}
	}

	public CCodeStatement? create_type_check_statement (CodeNode method_node, DataType ret_type, TypeSymbol t, bool non_null, string var_name) {
		var ccheck = new CCodeFunctionCall ();

		if (!context.assert) {
			return null;
		} else if (context.checking && ((t is Class && !((Class) t).is_compact) || t is Interface)) {
			var ctype_check = new CCodeFunctionCall (new CCodeIdentifier (get_type_check_function (t)));
			ctype_check.add_argument (new CCodeIdentifier (var_name));
			
			CCodeExpression cexpr = ctype_check;
			if (!non_null) {
				var cnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier (var_name), new CCodeConstant ("NULL"));
			
				cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cnull, ctype_check);
			}
			ccheck.add_argument (cexpr);
		} else if (!non_null) {
			return null;
		} else if (t == glist_type || t == gslist_type) {
			// NULL is empty list
			return null;
		} else {
			var cnonnull = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier (var_name), new CCodeConstant ("NULL"));
			ccheck.add_argument (cnonnull);
		}

		var cm = method_node as CreationMethod;
		if (cm != null && cm.parent_symbol is ObjectTypeSymbol) {
			ccheck.call = new CCodeIdentifier ("g_return_val_if_fail");
			ccheck.add_argument (new CCodeConstant ("NULL"));
		} else if (ret_type is VoidType) {
			/* void function */
			ccheck.call = new CCodeIdentifier ("g_return_if_fail");
		} else {
			ccheck.call = new CCodeIdentifier ("g_return_val_if_fail");

			var cdefault = default_value_for_type (ret_type, false);
			if (cdefault != null) {
				ccheck.add_argument (cdefault);
			} else {
				return null;
			}
		}
		
		return new CCodeExpressionStatement (ccheck);
	}

	public int get_param_pos (double param_pos, bool ellipsis = false) {
		if (!ellipsis) {
			if (param_pos >= 0) {
				return (int) (param_pos * 1000);
			} else {
				return (int) ((100 + param_pos) * 1000);
			}
		} else {
			if (param_pos >= 0) {
				return (int) ((100 + param_pos) * 1000);
			} else {
				return (int) ((200 + param_pos) * 1000);
			}
		}
	}

	public CCodeNode? get_ccodenode (CodeNode node) {
		if (node.ccodenode == null) {
			node.accept (codegen);
		}
		return node.ccodenode;
	}

	public override void visit_class (Class cl) {
	}

	public CCodeStatement create_postcondition_statement (Expression postcondition) {
		var cassert = new CCodeFunctionCall (new CCodeIdentifier ("g_warn_if_fail"));

		cassert.add_argument ((CCodeExpression) postcondition.ccodenode);

		return new CCodeExpressionStatement (cassert);
	}
}

// vim:sw=8 noet
