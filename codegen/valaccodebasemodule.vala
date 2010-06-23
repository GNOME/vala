/* valaccodebasemodule.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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


/**
 * Code visitor generating C Code.
 */
public class Vala.CCodeBaseModule : CCodeModule {
	public CodeContext context { get; set; }

	public Symbol root_symbol;
	public Symbol current_symbol;
	public TryStatement current_try;

	public TypeSymbol? current_type_symbol {
		get {
			var sym = current_symbol;
			while (sym != null) {
				if (sym is TypeSymbol) {
					return (TypeSymbol) sym;
				}
				sym = sym.parent_symbol;
			}
			return null;
		}
	}

	public Class? current_class {
		get { return current_type_symbol as Class; }
	}

	public Method? current_method {
		get {
			var sym = current_symbol;
			while (sym is Block) {
				sym = sym.parent_symbol;
			}
			return sym as Method;
		}
	}

	public PropertyAccessor? current_property_accessor {
		get {
			var sym = current_symbol;
			while (sym is Block) {
				sym = sym.parent_symbol;
			}
			return sym as PropertyAccessor;
		}
	}

	public DataType? current_return_type {
		get {
			var m = current_method;
			if (m != null) {
				return m.return_type;
			}

			var acc = current_property_accessor;
			if (acc != null) {
				if (acc.readable) {
					return acc.value_type;
				} else {
					return void_type;
				}
			}

			return null;
		}
	}

	public Block? current_closure_block {
		get {
			return next_closure_block (current_symbol);
		}
	}

	public unowned Block? next_closure_block (Symbol sym) {
		unowned Block block = null;
		while (true) {
			block = sym as Block;
			if (!(sym is Block || sym is Method)) {
				// no closure block
				break;
			}
			if (block != null && block.captured) {
				// closure block found
				break;
			}
			sym = sym.parent_symbol;
		}
		return block;
	}

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
	
	public CCodeStruct param_spec_struct;
	public CCodeStruct closure_struct;
	public CCodeEnum prop_enum;
	public CCodeFunction function;

	// code nodes to be inserted before the current statement
	// used by async method calls in coroutines
	public CCodeFragment pre_statement_fragment;
	// case statements to be inserted for the couroutine state
	public CCodeSwitchStatement state_switch_statement;

	/* all temporary variables */
	public ArrayList<LocalVariable> temp_vars = new ArrayList<LocalVariable> ();
	/* temporary variables that own their content */
	public ArrayList<LocalVariable> temp_ref_vars = new ArrayList<LocalVariable> ();
	/* cache to check whether a certain marshaller has been created yet */
	public Set<string> user_marshal_set;
	/* (constant) hash table with all predefined marshallers */
	public Set<string> predefined_marshal_set;
	/* (constant) hash table with all reserved identifiers in the generated code */
	Set<string> reserved_identifiers;
	
	public int next_temp_var_id = 0;
	public int next_regex_id = 0;
	public bool in_creation_method { get { return current_method is CreationMethod; } }
	public bool in_constructor = false;
	public bool in_static_or_class_context = false;
	public bool current_method_inner_error = false;
	public int next_coroutine_state = 1;
	int next_block_id = 0;
	Map<Block,int> block_map = new HashMap<Block,int> ();

	public DataType void_type = new VoidType ();
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
	public DataType regex_type;
	public DataType float_type;
	public DataType double_type;
	public TypeSymbol gtype_type;
	public TypeSymbol gobject_type;
	public ErrorType gerror_type;
	public Class glist_type;
	public Class gslist_type;
	public Class gvaluearray_type;
	public TypeSymbol gstringbuilder_type;
	public TypeSymbol garray_type;
	public TypeSymbol gbytearray_type;
	public TypeSymbol gptrarray_type;
	public TypeSymbol gthreadpool_type;
	public DataType gquark_type;
	public DataType genumvalue_type;
	public Struct gvalue_type;
	public Class gvariant_type;
	public Struct mutex_type;
	public TypeSymbol type_module_type;
	public TypeSymbol dbus_proxy_type;
	public TypeSymbol dbus_object_type;

	public bool in_plugin = false;
	public string module_init_param_name;
	
	public bool gvaluecollector_h_needed;
	public bool requires_array_free;
	public bool requires_array_move;
	public bool requires_array_length;
	public bool requires_strcmp0;

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
		reserved_identifiers.add ("asm");
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
			gvaluearray_type = (Class) glib_ns.scope.lookup ("ValueArray");
			gstringbuilder_type = (TypeSymbol) glib_ns.scope.lookup ("StringBuilder");
			garray_type = (TypeSymbol) glib_ns.scope.lookup ("Array");
			gbytearray_type = (TypeSymbol) glib_ns.scope.lookup ("ByteArray");
			gptrarray_type = (TypeSymbol) glib_ns.scope.lookup ("PtrArray");
			gthreadpool_type = (TypeSymbol) glib_ns.scope.lookup ("ThreadPool");

			gquark_type = new IntegerType ((Struct) glib_ns.scope.lookup ("Quark"));
			genumvalue_type = new ObjectType ((Class) glib_ns.scope.lookup ("EnumValue"));
			gvalue_type = (Struct) glib_ns.scope.lookup ("Value");
			gvariant_type = (Class) glib_ns.scope.lookup ("Variant");
			mutex_type = (Struct) glib_ns.scope.lookup ("StaticRecMutex");

			type_module_type = (TypeSymbol) glib_ns.scope.lookup ("TypeModule");

			regex_type = new ObjectType ((Class) root_symbol.scope.lookup ("GLib").scope.lookup ("Regex"));

			if (context.module_init_method != null) {
				foreach (FormalParameter parameter in context.module_init_method.get_parameters ()) {
					if (parameter.parameter_type.data_type == type_module_type) {
						in_plugin = true;
						module_init_param_name = parameter.name;
						break;
					}
				}
				if (!in_plugin) {
					Report.error (context.module_init_method.source_reference, "[ModuleInit] requires a parameter of type `GLib.TypeModule'");
				}
			}

			dbus_proxy_type = (TypeSymbol) glib_ns.scope.lookup ("DBusProxy");

			var dbus_ns = root_symbol.scope.lookup ("DBus");
			if (dbus_ns != null) {
				dbus_object_type = (TypeSymbol) dbus_ns.scope.lookup ("Object");
			}
		}

		header_declarations = new CCodeDeclarationSpace ();
		header_declarations.is_header = true;
		internal_header_declarations = new CCodeDeclarationSpace ();
		internal_header_declarations.is_header = true;

		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (!file.external_package) {
				file.accept (codegen);
			}
		}

		// generate symbols file for public API
		if (context.symbols_filename != null) {
			var stream = FileStream.open (context.symbols_filename, "w");
			if (stream == null) {
				Report.error (null, "unable to open `%s' for writing".printf (context.symbols_filename));
				return;
			}

			foreach (CCodeNode node in header_declarations.type_member_declaration.get_children ()) {
				if (node is CCodeFunction) {
					var func = (CCodeFunction) node;
					stream.puts (func.name);
					stream.putc ('\n');
				}
			}

			stream = null;
		}

		// generate C header file for public API
		if (context.header_filename != null) {
			var writer = new CCodeWriter (context.header_filename);
			if (!writer.open (context.version_header)) {
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
			if (!writer.open (context.version_header)) {
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
		var array_type = type_reference as ArrayType;
		if (type_reference.data_type != null) {
			return new CCodeIdentifier (type_reference.data_type.get_set_value_function ());
		} else if (array_type != null && array_type.element_type.data_type == string_type.data_type) {
			// G_TYPE_STRV
			return new CCodeIdentifier ("g_value_set_boxed");
		} else {
			return new CCodeIdentifier ("g_value_set_pointer");
		}
	}

	public override CCodeIdentifier get_value_taker_function (DataType type_reference) {
		var array_type = type_reference as ArrayType;
		if (type_reference.data_type != null) {
			return new CCodeIdentifier (type_reference.data_type.get_take_value_function ());
		} else if (array_type != null && array_type.element_type.data_type == string_type.data_type) {
			// G_TYPE_STRV
			return new CCodeIdentifier ("g_value_take_boxed");
		} else {
			return new CCodeIdentifier ("g_value_set_pointer");
		}
	}

	CCodeIdentifier get_value_getter_function (DataType type_reference) {
		var array_type = type_reference as ArrayType;
		if (type_reference.data_type != null) {
			return new CCodeIdentifier (type_reference.data_type.get_get_value_function ());
		} else if (array_type != null && array_type.element_type.data_type == string_type.data_type) {
			// G_TYPE_STRV
			return new CCodeIdentifier ("g_value_get_boxed");
		} else {
			return new CCodeIdentifier ("g_value_get_pointer");
		}
	}

	public virtual void append_vala_array_free () {
	}

	public virtual void append_vala_array_move () {
	}

	public virtual void append_vala_array_length () {
	}

	private void append_vala_strcmp0 () {
		source_declarations.add_include ("string.h");;

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
		next_regex_id = 0;
		variable_name_map.clear ();
		
		gvaluecollector_h_needed = false;
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

		var writer = new CCodeWriter (source_file.get_csource_filename (), source_file.filename);
		if (!writer.open (context.version_header)) {
			Report.error (null, "unable to open `%s' for writing".printf (writer.filename));
			return;
		}
		writer.line_directives = context.debug;

		var comments = source_file.get_comments();
		if (comments != null) {
			foreach (Comment comment in comments) {
				var ccomment = new CCodeComment (comment.content);
				ccomment.write (writer);
			}
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
		source_declarations.constant_declaration.write_combined (writer);
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

	public virtual bool generate_enum_declaration (Enum en, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (en, en.get_cname ())) {
			return false;
		}

		var cenum = new CCodeEnum (en.get_cname ());

		cenum.deprecated = en.deprecated;

		foreach (EnumValue ev in en.get_values ()) {
			CCodeEnumValue c_ev;
			if (ev.value == null) {
				c_ev = new CCodeEnumValue (ev.get_cname ());
			} else {
				ev.value.accept (codegen);
				c_ev = new CCodeEnumValue (ev.get_cname (), (CCodeExpression) ev.value.ccodenode);
			}
			c_ev.deprecated = ev.deprecated;
			cenum.add_value (c_ev);
		}

		decl_space.add_type_definition (cenum);
		decl_space.add_type_definition (new CCodeNewline ());

		if (!en.has_type_id) {
			return true;
		}

		decl_space.add_type_declaration (new CCodeNewline ());

		var macro = "(%s_get_type ())".printf (en.get_lower_case_cname (null));
		decl_space.add_type_declaration (new CCodeMacroReplacement (en.get_type_id (), macro));

		var fun_name = "%s_get_type".printf (en.get_lower_case_cname (null));
		var regfun = new CCodeFunction (fun_name, "GType");

		if (en.access == SymbolAccessibility.PRIVATE) {
			regfun.modifiers = CCodeModifiers.STATIC;
			// avoid C warning as this function is not always used
			regfun.attributes = "G_GNUC_UNUSED";
		}

		decl_space.add_type_member_declaration (regfun);

		return true;
	}

	public override void visit_enum (Enum en) {
		en.accept_children (codegen);

		generate_enum_declaration (en, source_declarations);

		if (!en.is_internal_symbol ()) {
			generate_enum_declaration (en, header_declarations);
		}
		if (!en.is_private_symbol ()) {
			generate_enum_declaration (en, internal_header_declarations);
		}
	}

	public override void visit_member (Member m) {
		/* stuff meant for all lockable members */
		if (m is Lockable && ((Lockable) m).get_lock_used ()) {
			CCodeExpression l = new CCodeIdentifier ("self");
			CCodeFragment init_fragment = class_init_fragment;
			CCodeFragment finalize_fragment = class_finalize_fragment;

			if (m.is_instance_member ()) {
				l = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (l, "priv"), get_symbol_lock_name (m.name));
				init_fragment = instance_init_fragment;
				finalize_fragment = instance_finalize_fragment;
			} else if (m.is_class_member ()) {
				TypeSymbol parent = (TypeSymbol)m.parent_symbol;

				var get_class_private_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS_PRIVATE".printf(parent.get_upper_case_cname ())));
				get_class_private_call.add_argument (new CCodeIdentifier ("klass"));
				l = new CCodeMemberAccess.pointer (get_class_private_call, get_symbol_lock_name (m.name));
			} else {
				l = new CCodeIdentifier (get_symbol_lock_name ("%s_%s".printf(m.parent_symbol.get_lower_case_cname (), m.name)));
			}

			var initf = new CCodeFunctionCall (new CCodeIdentifier (mutex_type.default_construction_method.get_cname ()));
			initf.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));
			init_fragment.append (new CCodeExpressionStatement (initf));

			if (finalize_fragment != null) {
				var fc = new CCodeFunctionCall (new CCodeIdentifier ("g_static_rec_mutex_free"));
				fc.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));
				finalize_fragment.append (new CCodeExpressionStatement (fc));
			}
		}
	}

	public void generate_constant_declaration (Constant c, CCodeDeclarationSpace decl_space, bool definition = false) {
		if (decl_space.add_symbol_declaration (c, c.get_cname ())) {
			return;
		}

		c.accept_children (codegen);

		if (!c.external) {
			generate_type_declaration (c.type_reference, decl_space);

			var initializer_list = c.initializer as InitializerList;
			if (initializer_list != null) {
				var cdecl = new CCodeDeclaration (c.type_reference.get_const_cname ());
				var arr = "";
				if (c.type_reference is ArrayType) {
					arr = "[%d]".printf (initializer_list.size);
				}

				var cinitializer = (CCodeExpression) c.initializer.ccodenode;
				if (!definition) {
					// never output value in header
					// special case needed as this method combines declaration and definition
					cinitializer = null;
				}

				cdecl.add_declarator (new CCodeVariableDeclarator ("%s%s".printf (c.get_cname (), arr), cinitializer));
				if (c.is_private_symbol ()) {
					cdecl.modifiers = CCodeModifiers.STATIC;
				} else {
					cdecl.modifiers = CCodeModifiers.EXTERN;
				}

				decl_space.add_constant_declaration (cdecl);
			} else {
				var cdefine = new CCodeMacroReplacement.with_expression (c.get_cname (), (CCodeExpression) c.initializer.ccodenode);
				decl_space.add_type_member_declaration (cdefine);
			}
		}
	}

	public override void visit_constant (Constant c) {
		generate_constant_declaration (c, source_declarations, true);

		if (!c.is_internal_symbol ()) {
			generate_constant_declaration (c, header_declarations);
		}
		if (!c.is_private_symbol ()) {
			generate_constant_declaration (c, internal_header_declarations);
		}
	}

	public void generate_field_declaration (Field f, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (f, f.get_cname ())) {
			return;
		}

		generate_type_declaration (f.field_type, decl_space);

		string field_ctype = f.field_type.get_cname ();
		if (f.is_volatile) {
			field_ctype = "volatile " + field_ctype;
		}

		var cdecl = new CCodeDeclaration (field_ctype);
		cdecl.add_declarator (new CCodeVariableDeclarator (f.get_cname (), null, f.field_type.get_cdeclarator_suffix ()));
		if (f.is_private_symbol ()) {
			cdecl.modifiers = CCodeModifiers.STATIC;
		} else {
			cdecl.modifiers = CCodeModifiers.EXTERN;
		}
		if (f.deprecated) {
			cdecl.modifiers |= CCodeModifiers.DEPRECATED;
		}
		decl_space.add_type_member_declaration (cdecl);

		if (f.get_lock_used ()) {
			// Declare mutex for static member
			var flock = new CCodeDeclaration (mutex_type.get_cname ());
			var flock_decl =  new CCodeVariableDeclarator (get_symbol_lock_name (f.get_cname ()), new CCodeConstant ("{0}"));
			flock.add_declarator (flock_decl);

			if (f.is_private_symbol ()) {
				flock.modifiers = CCodeModifiers.STATIC;
			} else {
				flock.modifiers = CCodeModifiers.EXTERN;
			}
			decl_space.add_type_member_declaration (flock);
		}

		if (f.field_type is ArrayType && !f.no_array_length) {
			var array_type = (ArrayType) f.field_type;

			if (!array_type.fixed_length) {
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

				if (delegate_type.value_owned) {
					cdecl = new CCodeDeclaration ("GDestroyNotify");
					cdecl.add_declarator (new CCodeVariableDeclarator (get_delegate_target_destroy_notify_cname  (f.get_cname ())));
					if (f.is_private_symbol ()) {
						cdecl.modifiers = CCodeModifiers.STATIC;
					} else {
						cdecl.modifiers = CCodeModifiers.EXTERN;
					}
					decl_space.add_type_member_declaration (cdecl);
				}
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
					
					List<Expression> sizes = ((ArrayCreationExpression) f.initializer).get_sizes ();
					for (int dim = 1; dim <= array_type.rank; dim++) {
						var array_len_lhs = head.get_array_length_cexpression (ma, dim);
						var size = sizes[dim - 1];
						instance_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (array_len_lhs, (CCodeExpression) size.ccodenode)));
					}

					if (array_type.rank == 1 && f.is_internal_symbol ()) {
						var lhs_array_size = head.get_array_size_cexpression (ma);
						var rhs_array_len = head.get_array_length_cexpression (ma, 1);
						instance_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (lhs_array_size, rhs_array_len)));
					}
				}

				append_temp_decl (instance_init_fragment, temp_vars);

				foreach (LocalVariable local in temp_ref_vars) {
					var ma = new MemberAccess.simple (local.name);
					ma.symbol_reference = local;
					ma.value_type = local.variable_type.copy ();
					instance_init_fragment.append (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
				}

				temp_vars.clear ();
				temp_ref_vars.clear ();
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
				ma.value_type = f.field_type.copy ();
				instance_finalize_fragment.append (new CCodeExpressionStatement (get_unref_expression (lhs, f.field_type, ma)));
			}
		} else if (f.binding == MemberBinding.CLASS)  {
			if (!is_gtypeinstance) {
				Report.error (f.source_reference, "class fields are not supported in compact classes");
				f.error = true;
				return;
			}

			if (f.access == SymbolAccessibility.PRIVATE) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS_PRIVATE".printf (cl.get_upper_case_cname ())));
				ccall.add_argument (new CCodeIdentifier ("klass"));
				lhs = new CCodeMemberAccess (ccall, f.get_cname (), true);
			} else {
				lhs = new CCodeMemberAccess (new CCodeIdentifier ("klass"), f.get_cname (), true);
			}

			if (f.initializer != null) {
				var rhs = (CCodeExpression) f.initializer.ccodenode;

				class_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (lhs, rhs)));

				append_temp_decl (class_init_fragment, temp_vars);

				foreach (LocalVariable local in temp_ref_vars) {
					var ma = new MemberAccess.simple (local.name);
					ma.symbol_reference = local;
					ma.value_type = local.variable_type.copy ();
					class_init_fragment.append (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
				}

				temp_vars.clear ();
				temp_ref_vars.clear ();
			}
		} else {
			generate_field_declaration (f, source_declarations);

			if (!f.is_internal_symbol ()) {
				generate_field_declaration (f, header_declarations);
			}
			if (!f.is_private_symbol ()) {
				generate_field_declaration (f, internal_header_declarations);
			}

			lhs = new CCodeIdentifier (f.get_cname ());

			var var_decl = new CCodeVariableDeclarator (f.get_cname (), null, f.field_type.get_cdeclarator_suffix ());
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

				if (!array_type.fixed_length) {
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

					if (delegate_type.value_owned) {
						var target_destroy_notify_def = new CCodeDeclaration ("GDestroyNotify");
						target_destroy_notify_def.add_declarator (new CCodeVariableDeclarator (get_delegate_target_destroy_notify_cname  (f.get_cname ()), new CCodeConstant ("NULL")));
						if (!f.is_private_symbol ()) {
							target_destroy_notify_def.modifiers = CCodeModifiers.EXTERN;
						} else {
							target_destroy_notify_def.modifiers = CCodeModifiers.STATIC;
						}
						source_declarations.add_type_member_declaration (target_destroy_notify_def);

					}
				}
			}

			if (f.initializer != null) {
				var rhs = (CCodeExpression) f.initializer.ccodenode;
				if (!is_constant_ccode_expression (rhs)) {
					if (f.parent_symbol is Class) {
						if (f.initializer is InitializerList) {
							var block = new CCodeBlock ();
							var frag = new CCodeFragment ();

							var temp_decl = get_temp_variable (f.field_type);
							var cdecl = new CCodeDeclaration (temp_decl.variable_type.get_cname ());
							var vardecl = new CCodeVariableDeclarator (temp_decl.name, rhs);
							cdecl.add_declarator (vardecl);
							vardecl.init0 = true;
							frag.append (cdecl);

							var tmp = get_variable_cexpression (get_variable_cname (temp_decl.name));
							frag.append (new CCodeExpressionStatement (new CCodeAssignment (lhs, tmp)));

							block.add_statement (frag);
							class_init_fragment.append (block);
						} else {
							class_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (lhs, rhs)));
						}

						if (f.field_type is ArrayType && !f.no_array_length &&
						    f.initializer is ArrayCreationExpression) {
							var array_type = (ArrayType) f.field_type;
							var ma = new MemberAccess.simple (f.name);
							ma.symbol_reference = f;
					
							List<Expression> sizes = ((ArrayCreationExpression) f.initializer).get_sizes ();
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
		} else if (cexpr is CCodeCastExpression) {
			var ccast = (CCodeCastExpression) cexpr;
			return is_constant_ccode_expression (ccast.inner);
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
		if (!p.ellipsis) {
			check_type (p.parameter_type);
		}
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
		if (decl_space.add_symbol_declaration (acc, acc.get_cname ())) {
			return;
		}

		var prop = (Property) acc.prop;

		bool returns_real_struct = acc.readable && prop.property_type.is_real_non_null_struct_type ();


		CCodeFormalParameter cvalueparam;
		if (returns_real_struct) {
			cvalueparam = new CCodeFormalParameter ("result", acc.value_type.get_cname () + "*");
		} else if (!acc.readable && prop.property_type.is_real_non_null_struct_type ()) {
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

		if (prop.binding == MemberBinding.INSTANCE) {
			var t = (TypeSymbol) prop.parent_symbol;
			var this_type = get_data_type_for_symbol (t);
			generate_type_declaration (this_type, decl_space);
			var cselfparam = new CCodeFormalParameter ("self", this_type.get_cname ());
			if (t is Struct) {
				cselfparam.type_name += "*";
			}

			function.add_parameter (cselfparam);
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
		} else if ((acc.value_type is DelegateType) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
			function.add_parameter (new CCodeFormalParameter (get_delegate_target_cname (acc.readable ? "result" : "value"), acc.readable ? "gpointer*" : "gpointer"));
		}

		if (prop.is_private_symbol () || (!acc.readable && !acc.writable) || acc.access == SymbolAccessibility.PRIVATE) {
			function.modifiers |= CCodeModifiers.STATIC;
		}
		decl_space.add_type_member_declaration (function);
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		var old_symbol = current_symbol;
		bool old_method_inner_error = current_method_inner_error;
		current_symbol = acc;
		current_method_inner_error = false;

		var prop = (Property) acc.prop;

		bool returns_real_struct = acc.readable && prop.property_type.is_real_non_null_struct_type ();

		acc.accept_children (codegen);

		var t = (TypeSymbol) prop.parent_symbol;

		if (acc.construction && !t.is_subtype_of (gobject_type)) {
			Report.error (acc.source_reference, "construct properties require GLib.Object");
			acc.error = true;
			return;
		} else if (acc.construction && !is_gobject_property (prop)) {
			Report.error (acc.source_reference, "construct properties not supported for specified property type");
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
				if (!prop.is_private_symbol () && acc.access != SymbolAccessibility.PRIVATE) {
					generate_property_accessor_declaration (acc, internal_header_declarations);
				}
			}
		}

		var this_type = get_data_type_for_symbol (t);
		var cselfparam = new CCodeFormalParameter ("self", this_type.get_cname ());
		if (t is Struct) {
			cselfparam.type_name += "*";
		}
		CCodeFormalParameter cvalueparam;
		if (returns_real_struct) {
			cvalueparam = new CCodeFormalParameter ("result", acc.value_type.get_cname () + "*");
		} else if (!acc.readable && prop.property_type.is_real_non_null_struct_type ()) {
			cvalueparam = new CCodeFormalParameter ("value", acc.value_type.get_cname () + "*");
		} else {
			cvalueparam = new CCodeFormalParameter ("value", acc.value_type.get_cname ());
		}

		if (prop.is_abstract || prop.is_virtual) {
			if (acc.readable && !returns_real_struct) {
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
			} else if ((acc.value_type is DelegateType) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
				function.add_parameter (new CCodeFormalParameter (get_delegate_target_cname (acc.readable ? "result" : "value"), acc.readable ? "gpointer*" : "gpointer"));
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
					vcall.add_argument (new CCodeIdentifier ("result"));
					block.add_statement (new CCodeExpressionStatement (vcall));
				} else {
					if (acc.value_type is ArrayType) {
						var array_type = (ArrayType) acc.value_type;

						for (int dim = 1; dim <= array_type.rank; dim++) {
							var len_expr = new CCodeIdentifier (head.get_array_length_cname ("result", dim));
							vcall.add_argument (len_expr);
						}
					}

					block.add_statement (new CCodeReturnStatement (vcall));
				}
			} else {
				var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "set_%s".printf (prop.name)));
				vcall.add_argument (new CCodeIdentifier ("self"));
				vcall.add_argument (new CCodeIdentifier ("value"));

				if (acc.value_type is ArrayType) {
					var array_type = (ArrayType) acc.value_type;

					for (int dim = 1; dim <= array_type.rank; dim++) {
						var len_expr = new CCodeIdentifier (head.get_array_length_cname ("value", dim));
						vcall.add_argument (len_expr);
					}
				}

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
			} else if ((acc.value_type is DelegateType) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
				function.add_parameter (new CCodeFormalParameter (get_delegate_target_cname (acc.readable ? "result" : "value"), acc.readable ? "gpointer*" : "gpointer"));
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

			if (acc.readable && !returns_real_struct) {
				// do not declare result variable if exit block is known to be unreachable
				if (acc.return_block == null || acc.return_block.get_predecessors ().size > 0) {
					var cdecl = new CCodeDeclaration (acc.value_type.get_cname ());
					cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
					function.block.prepend_statement (cdecl);
				}
			}

			if (current_method_inner_error) {
				var cdecl = new CCodeDeclaration ("GError *");
				cdecl.add_declarator (new CCodeVariableDeclarator ("_inner_error_", new CCodeConstant ("NULL")));
				function.block.prepend_statement (cdecl);
			}

			if (prop.binding == MemberBinding.INSTANCE && !is_virtual) {
				CCodeStatement check_stmt;
				if (!acc.readable || returns_real_struct) {
					check_stmt = create_property_type_check_statement (prop, false, t, true, "self");
				} else {
					check_stmt = create_property_type_check_statement (prop, true, t, true, "self");
				}
				if (check_stmt != null) {
					function.block.prepend_statement (check_stmt);
				}
			}

			// notify on property changes
			if (is_gobject_property (prop) &&
			    prop.notify &&
			    (acc.writable || acc.construction)) {
				var notify_call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_notify"));
				notify_call.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "GObject *"));
				notify_call.add_argument (prop.get_canonical_cconstant ());
				function.block.add_statement (new CCodeExpressionStatement (notify_call));
			}

			source_type_member_definition.append (function);
		}

		current_symbol = old_symbol;
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

	public int get_block_id (Block b) {
		int result = block_map[b];
		if (result == 0) {
			result = ++next_block_id;
			block_map[b] = result;
		}
		return result;
	}

	void capture_parameter (FormalParameter param, CCodeStruct data, CCodeBlock cblock, int block_id, CCodeBlock free_block) {
		generate_type_declaration (param.parameter_type, source_declarations);

		var param_type = param.parameter_type.copy ();
		param_type.value_owned = true;
		data.add_field (param_type.get_cname (), get_variable_cname (param.name));

		bool is_unowned_delegate = param.parameter_type is DelegateType && !param.parameter_type.value_owned;

		// create copy if necessary as captured variables may need to be kept alive
		CCodeExpression cparam = get_variable_cexpression (param.name);
		if (param.parameter_type.is_real_non_null_struct_type ()) {
			cparam = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, cparam);
		}
		if (requires_copy (param_type) && !param.parameter_type.value_owned && !is_unowned_delegate)  {
			var ma = new MemberAccess.simple (param.name);
			ma.symbol_reference = param;
			ma.value_type = param.parameter_type.copy ();
			// directly access parameters in ref expressions
			param.captured = false;
			cparam = get_ref_cexpression (param.parameter_type, cparam, ma, param);
			param.captured = true;
		}

		cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), get_variable_cname (param.name)), cparam)));

		if (param.parameter_type is ArrayType) {
			var array_type = (ArrayType) param.parameter_type;
			for (int dim = 1; dim <= array_type.rank; dim++) {
				data.add_field ("gint", get_array_length_cname (get_variable_cname (param.name), dim));
				cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), get_array_length_cname (get_variable_cname (param.name), dim)), new CCodeIdentifier (get_array_length_cname (get_variable_cname (param.name), dim)))));
			}
		} else if (param.parameter_type is DelegateType) {
			data.add_field ("gpointer", get_delegate_target_cname (get_variable_cname (param.name)));
			cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), get_delegate_target_cname (get_variable_cname (param.name))), new CCodeIdentifier (get_delegate_target_cname (get_variable_cname (param.name))))));
			if (param.parameter_type.value_owned) {
				data.add_field ("GDestroyNotify", get_delegate_target_destroy_notify_cname (get_variable_cname (param.name)));
				cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), get_delegate_target_destroy_notify_cname (get_variable_cname (param.name))), new CCodeIdentifier (get_delegate_target_destroy_notify_cname (get_variable_cname (param.name))))));
			}
		}

		if (requires_destroy (param_type) && !is_unowned_delegate) {
			bool old_coroutine = false;
			if (current_method != null) {
				old_coroutine = current_method.coroutine;
				current_method.coroutine = false;
			}

			var ma = new MemberAccess.simple (param.name);
			ma.symbol_reference = param;
			ma.value_type = param_type.copy ();
			free_block.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), get_variable_cname (param.name)), param.parameter_type, ma)));

			if (old_coroutine) {
				current_method.coroutine = true;
			}
		}
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

		if (b.captured) {
			var parent_block = next_closure_block (b.parent_symbol);

			int block_id = get_block_id (b);
			string struct_name = "Block%dData".printf (block_id);

			var free_block = new CCodeBlock ();

			var data = new CCodeStruct ("_" + struct_name);
			data.add_field ("int", "_ref_count_");
			if (parent_block != null) {
				int parent_block_id = get_block_id (parent_block);

				data.add_field ("Block%dData *".printf (parent_block_id), "_data%d_".printf (parent_block_id));

				var unref_call = new CCodeFunctionCall (new CCodeIdentifier ("block%d_data_unref".printf (parent_block_id)));
				unref_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "_data%d_".printf (parent_block_id)));
				free_block.add_statement (new CCodeExpressionStatement (unref_call));
			} else if (in_constructor || (current_method != null && current_method.binding == MemberBinding.INSTANCE) ||
			           (current_property_accessor != null && current_property_accessor.prop.binding == MemberBinding.INSTANCE)) {
				data.add_field ("%s *".printf (current_class.get_cname ()), "self");

				var ma = new MemberAccess.simple ("this");
				ma.symbol_reference = current_class;
				free_block.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "self"), new ObjectType (current_class), ma)));
			}
			foreach (var local in local_vars) {
				if (local.captured) {
					generate_type_declaration (local.variable_type, source_declarations);

					data.add_field (local.variable_type.get_cname (), get_variable_cname (local.name) + local.variable_type.get_cdeclarator_suffix ());

					if (local.variable_type is ArrayType) {
						var array_type = (ArrayType) local.variable_type;
						for (int dim = 1; dim <= array_type.rank; dim++) {
							data.add_field ("gint", get_array_length_cname (get_variable_cname (local.name), dim));
						}
						data.add_field ("gint", get_array_size_cname (get_variable_cname (local.name)));
					} else if (local.variable_type is DelegateType) {
						data.add_field ("gpointer", get_delegate_target_cname (get_variable_cname (local.name)));
						if (local.variable_type.value_owned) {
							data.add_field ("GDestroyNotify", get_delegate_target_destroy_notify_cname (get_variable_cname (local.name)));
						}
					}

					if (requires_destroy (local.variable_type)) {
						bool old_coroutine = false;
						if (current_method != null) {
							old_coroutine = current_method.coroutine;
							current_method.coroutine = false;
						}

						var ma = new MemberAccess.simple (local.name);
						ma.symbol_reference = local;
						ma.value_type = local.variable_type.copy ();
						free_block.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), get_variable_cname (local.name)), local.variable_type, ma)));

						if (old_coroutine) {
							current_method.coroutine = true;
						}
					}
				}
			}

			var data_alloc = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_new0"));
			data_alloc.add_argument (new CCodeIdentifier (struct_name));

			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (struct_name + "*", "_data%d_".printf (block_id));
				cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (get_variable_cexpression ("_data%d_".printf (block_id)), data_alloc)));
			} else {
				var data_decl = new CCodeDeclaration (struct_name + "*");
				data_decl.add_declarator (new CCodeVariableDeclarator ("_data%d_".printf (block_id), data_alloc));
				cblock.add_statement (data_decl);
			}

			// initialize ref_count
			cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "_ref_count_"), new CCodeIdentifier ("1"))));

			if (parent_block != null) {
				int parent_block_id = get_block_id (parent_block);

				var ref_call = new CCodeFunctionCall (new CCodeIdentifier ("block%d_data_ref".printf (parent_block_id)));
				ref_call.add_argument (get_variable_cexpression ("_data%d_".printf (parent_block_id)));

				cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "_data%d_".printf (parent_block_id)), ref_call)));
			} else if (in_constructor || (current_method != null && current_method.binding == MemberBinding.INSTANCE &&
			                              (!(current_method is CreationMethod) || current_method.body != b)) ||
			           (current_property_accessor != null && current_property_accessor.prop.binding == MemberBinding.INSTANCE)) {
				var ref_call = new CCodeFunctionCall (get_dup_func_expression (new ObjectType (current_class), b.source_reference));
				ref_call.add_argument (get_result_cexpression ("self"));

				cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "self"), ref_call)));
			}

			if (b.parent_symbol is Method) {
				var m = (Method) b.parent_symbol;

				// parameters are captured with the top-level block of the method
				foreach (var param in m.get_parameters ()) {
					if (param.captured) {
						capture_parameter (param, data, cblock, block_id, free_block);
					}
				}

				if (m.coroutine) {
					// capture async data to allow invoking callback from inside closure
					data.add_field ("gpointer", "_async_data_");

					// async method is suspended while waiting for callback,
					// so we never need to care about memory management of async data
					cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "_async_data_"), new CCodeIdentifier ("data"))));
				}

				var cfrag = new CCodeFragment ();
				append_temp_decl (cfrag, temp_vars);
				temp_vars.clear ();
				cblock.add_statement (cfrag);
			} else if (b.parent_symbol is PropertyAccessor) {
				var acc = (PropertyAccessor) b.parent_symbol;

				if (!acc.readable && acc.value_parameter.captured) {
					capture_parameter (acc.value_parameter, data, cblock, block_id, free_block);
				}

				var cfrag = new CCodeFragment ();
				append_temp_decl (cfrag, temp_vars);
				temp_vars.clear ();
				cblock.add_statement (cfrag);
			}

			var typedef = new CCodeTypeDefinition ("struct _" + struct_name, new CCodeVariableDeclarator (struct_name));
			source_declarations.add_type_declaration (typedef);
			source_declarations.add_type_definition (data);

			var data_free = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_free"));
			data_free.add_argument (new CCodeIdentifier (struct_name));
			data_free.add_argument (new CCodeIdentifier ("_data%d_".printf (block_id)));
			free_block.add_statement (new CCodeExpressionStatement (data_free));

			// create ref/unref functions
			var ref_fun = new CCodeFunction ("block%d_data_ref".printf (block_id), struct_name + "*");
			ref_fun.add_parameter (new CCodeFormalParameter ("_data%d_".printf (block_id), struct_name + "*"));
			ref_fun.modifiers = CCodeModifiers.STATIC;
			source_declarations.add_type_member_declaration (ref_fun.copy ());
			ref_fun.block = new CCodeBlock ();

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_atomic_int_inc"));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "_ref_count_")));
			ref_fun.block.add_statement (new CCodeExpressionStatement (ccall));
			ref_fun.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("_data%d_".printf (block_id))));
			source_type_member_definition.append (ref_fun);

			var unref_fun = new CCodeFunction ("block%d_data_unref".printf (block_id), "void");
			unref_fun.add_parameter (new CCodeFormalParameter ("_data%d_".printf (block_id), struct_name + "*"));
			unref_fun.modifiers = CCodeModifiers.STATIC;
			source_declarations.add_type_member_declaration (unref_fun.copy ());
			unref_fun.block = new CCodeBlock ();
			
			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_atomic_int_dec_and_test"));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "_ref_count_")));
			unref_fun.block.add_statement (new CCodeIfStatement (ccall, free_block));

			source_type_member_definition.append (unref_fun);
		}

		foreach (CodeNode stmt in b.get_statements ()) {
			if (stmt.error || stmt.unreachable) {
				continue;
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
			if (!local.unreachable && !local.floating && !local.captured && requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				ma.value_type = local.variable_type.copy ();
				cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
			}
		}

		if (b.parent_symbol is Method) {
			var m = (Method) b.parent_symbol;
			foreach (FormalParameter param in m.get_parameters ()) {
				if (!param.captured && !param.ellipsis && requires_destroy (param.parameter_type) && param.direction == ParameterDirection.IN) {
					var ma = new MemberAccess.simple (param.name);
					ma.symbol_reference = param;
					ma.value_type = param.parameter_type.copy ();
					cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (param.name), param.parameter_type, ma)));
				}
			}
		}

		if (b.captured) {
			int block_id = get_block_id (b);

			var data_unref = new CCodeFunctionCall (new CCodeIdentifier ("block%d_data_unref".printf (block_id)));
			data_unref.add_argument (get_variable_cexpression ("_data%d_".printf (block_id)));
			cblock.add_statement (new CCodeExpressionStatement (data_unref));
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
			if (name == ".result") {
				return "result";
			}
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

	public CCodeExpression get_result_cexpression (string cname = "result") {
		if (current_method != null && current_method.coroutine) {
			return new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), cname);
		} else {
			return new CCodeIdentifier (cname);
		}
	}

	bool has_simple_struct_initializer (LocalVariable local) {
		var st = local.variable_type.data_type as Struct;
		var initializer = local.initializer as ObjectCreationExpression;
		if (st != null && (!st.is_simple_type () || st.get_cname () == "va_list") && !local.variable_type.nullable &&
		    initializer != null && initializer.get_object_initializer ().size == 0) {
			return true;
		} else {
			return false;
		}
	}

	public override void visit_local_variable (LocalVariable local) {
		check_type (local.variable_type);

		local.accept_children (codegen);

		generate_type_declaration (local.variable_type, source_declarations);

		if (!local.captured) {
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
					if (deleg_type.value_owned) {
						var target_destroy_notify_var = new LocalVariable (new DelegateType ((Delegate) context.root.scope.lookup ("GLib").scope.lookup ("DestroyNotify")), get_delegate_target_destroy_notify_cname (get_variable_cname (local.name)));
						temp_vars.insert (0, target_destroy_notify_var);
					}
				}
			}
		}
	
		CCodeExpression rhs = null;
		if (local.initializer != null && local.initializer.ccodenode != null) {
			var ma = new MemberAccess.simple (local.name);
			ma.symbol_reference = local;
			ma.value_type = local.variable_type.copy ();

			rhs = (CCodeExpression) local.initializer.ccodenode;

			if (local.variable_type is ArrayType) {
				var array_type = (ArrayType) local.variable_type;

				if (array_type.fixed_length) {
					rhs = null;
				} else {
					var ccomma = new CCodeCommaExpression ();

					var temp_var = get_temp_variable (local.variable_type, true, local, false);
					temp_vars.insert (0, temp_var);
					ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), rhs));

					for (int dim = 1; dim <= array_type.rank; dim++) {
						var lhs_array_len = head.get_array_length_cexpression (ma, dim);
						var rhs_array_len = head.get_array_length_cexpression (local.initializer, dim);
						ccomma.append_expression (new CCodeAssignment (lhs_array_len, rhs_array_len));
					}
					if (array_type.rank == 1 && !local.captured) {
						var lhs_array_size = head.get_array_size_cexpression (ma);
						var rhs_array_len = head.get_array_length_cexpression (ma, 1);
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

					var temp_var = get_temp_variable (local.variable_type, true, local, false);
					temp_vars.insert (0, temp_var);
					ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), rhs));

					CCodeExpression lhs_delegate_target_destroy_notify;
					var lhs_delegate_target = get_delegate_target_cexpression (ma, out lhs_delegate_target_destroy_notify);
					if (local.captured) {
						var block = (Block) local.parent_symbol;
						lhs_delegate_target = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_delegate_target_cname (local.name));
					}
					CCodeExpression rhs_delegate_target_destroy_notify;
					var rhs_delegate_target = get_delegate_target_cexpression (local.initializer, out rhs_delegate_target_destroy_notify);
					ccomma.append_expression (new CCodeAssignment (lhs_delegate_target, rhs_delegate_target));

					if (deleg_type.value_owned) {
						if (local.captured) {
							var block = (Block) local.parent_symbol;
							lhs_delegate_target = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_delegate_target_destroy_notify_cname (local.name));
						}
						ccomma.append_expression (new CCodeAssignment (lhs_delegate_target_destroy_notify, rhs_delegate_target_destroy_notify));
					}

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

		if (local.captured) {
			if (local.initializer != null) {
				if (has_simple_struct_initializer (local)) {
					cfrag.append (new CCodeExpressionStatement (rhs));
				} else {
					cfrag.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id ((Block) local.parent_symbol))), get_variable_cname (local.name)), rhs)));
				}
			}
		} else if (current_method != null && current_method.coroutine) {
			closure_struct.add_field (local.variable_type.get_cname (), get_variable_cname (local.name) + local.variable_type.get_cdeclarator_suffix ());

			if (local.initializer != null) {
				if (has_simple_struct_initializer (local)) {
					cfrag.append (new CCodeExpressionStatement (rhs));
				} else {
					cfrag.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_variable_cname (local.name)), rhs)));
				}
			}
		} else {
			CCodeStatement post_stmt = null;
			if (has_simple_struct_initializer (local)) {
				post_stmt = new CCodeExpressionStatement (rhs);
				rhs = null;
			}

			var cvar = new CCodeVariableDeclarator (get_variable_cname (local.name), rhs, local.variable_type.get_cdeclarator_suffix ());
			if (rhs != null) {
				cvar.line = rhs.line;
			}

			var cdecl = new CCodeDeclaration (local.variable_type.get_cname ());
			cdecl.add_declarator (cvar);
			cfrag.append (cdecl);

			// try to initialize uninitialized variables
			// initialization not necessary for variables stored in closure
			if (cvar.initializer == null) {
				cvar.initializer = default_value_for_type (local.variable_type, true);
				cvar.init0 = true;
			}

			if (post_stmt != null) {
				cfrag.append (post_stmt);
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

			if (list.parent_node is Constant || list.parent_node is Field || list.parent_node is InitializerList) {
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
				// used as expression
				var temp_decl = get_temp_variable (list.target_type, false, list);
				temp_vars.add (temp_decl);

				var instance = get_variable_cexpression (get_variable_cname (temp_decl.name));

				var ccomma = new CCodeCommaExpression ();

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

					var lhs = new CCodeMemberAccess (instance, field.get_cname ());;
					ccomma.append_expression (new CCodeAssignment (lhs, cexpr));
				}

				ccomma.append_expression (instance);
				list.ccodenode = ccomma;
			}
		} else {
			var clist = new CCodeInitializerList ();
			foreach (Expression expr in list.get_initializers ()) {
				clist.append ((CCodeExpression) expr.ccodenode);
			}
			list.ccodenode = clist;
		}
	}

	public LocalVariable get_temp_variable (DataType type, bool value_owned = true, CodeNode? node_reference = null, bool init = true) {
		var var_type = type.copy ();
		var_type.value_owned = value_owned;
		var local = new LocalVariable (var_type, "_tmp%d_".printf (next_temp_var_id));
		local.no_init = !init;

		if (node_reference != null) {
			local.source_reference = node_reference.source_reference;
		}

		next_temp_var_id++;
		
		return local;
	}

	bool is_in_generic_type (DataType type) {
		if (current_symbol != null && type.type_parameter.parent_symbol is TypeSymbol
		    && (current_method == null || current_method.binding == MemberBinding.INSTANCE)) {
			return true;
		} else {
			return false;
		}
	}

	private CCodeExpression get_type_id_expression (DataType type, bool is_chainup = false) {
		if (type is GenericType) {
			string var_name = "%s_type".printf (type.type_parameter.name.down ());
			if (is_in_generic_type (type) && !is_chainup && !in_creation_method) {
				return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (get_result_cexpression ("self"), "priv"), var_name);
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

	public virtual CCodeExpression? get_dup_func_expression (DataType type, SourceReference? source_reference, bool is_chainup = false) {
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
		} else if (type.type_parameter != null) {
			string func_name = "%s_dup_func".printf (type.type_parameter.name.down ());
			if (is_in_generic_type (type) && !is_chainup && !in_creation_method) {
				return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (get_result_cexpression ("self"), "priv"), func_name);
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

	void make_comparable_cexpression (ref DataType left_type, ref CCodeExpression cleft, ref DataType right_type, ref CCodeExpression cright) {
		var left_type_as_struct = left_type.data_type as Struct;
		var right_type_as_struct = right_type.data_type as Struct;

		// GValue support
		var valuecast = try_cast_value_to_type (cleft, left_type, right_type);
		if (valuecast != null) {
			cleft = valuecast;
			left_type = right_type;
			make_comparable_cexpression (ref left_type, ref cleft, ref right_type, ref cright);
			return;
		}

		valuecast = try_cast_value_to_type (cright, right_type, left_type);
		if (valuecast != null) {
			cright = valuecast;
			right_type = left_type;
			make_comparable_cexpression (ref left_type, ref cleft, ref right_type, ref cright);
			return;
		}

		if (left_type.data_type is Class && !((Class) left_type.data_type).is_compact &&
		    right_type.data_type is Class && !((Class) right_type.data_type).is_compact) {
			var left_cl = (Class) left_type.data_type;
			var right_cl = (Class) right_type.data_type;

			if (left_cl != right_cl) {
				if (left_cl.is_subtype_of (right_cl)) {
					cleft = generate_instance_cast (cleft, right_cl);
				} else if (right_cl.is_subtype_of (left_cl)) {
					cright = generate_instance_cast (cright, left_cl);
				}
			}
		} else if (left_type_as_struct != null && right_type_as_struct != null) {
			if (left_type is StructValueType) {
				// real structs (uses compare/equal function)
				if (!left_type.nullable) {
					cleft = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cleft);
				}
				if (!right_type.nullable) {
					cright = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cright);
				}
			} else {
				// integer or floating or boolean type
				if (left_type.nullable && right_type.nullable) {
					// FIXME also compare contents, not just address
				} else if (left_type.nullable) {
					// FIXME check left value is not null
					cleft = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, cleft);
				} else if (right_type.nullable) {
					// FIXME check right value is not null
					cright = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, cright);
				}
			}
		}
	}

	private string generate_struct_equal_function (Struct st) {
		string equal_func = "_%sequal".printf (st.get_lower_case_cprefix ());

		if (!add_wrapper (equal_func)) {
			// wrapper already defined
			return equal_func;
		}
		// declaration

		var function = new CCodeFunction (equal_func, "gboolean");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("s1", "const " + st.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("s2", "const " + st.get_cname () + "*"));

		// definition
		var cblock = new CCodeBlock ();

		// if (s1 == s2) return TRUE;
		{
			var block = new CCodeBlock ();
			block.add_statement (new CCodeReturnStatement (new CCodeConstant ("TRUE")));

			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s1"), new CCodeIdentifier ("s2"));
			var cif = new CCodeIfStatement (cexp, block);
			cblock.add_statement (cif);
		}
		// if (s1 == NULL || s2 == NULL) return FALSE;
		{
			var block = new CCodeBlock ();
			block.add_statement (new CCodeReturnStatement (new CCodeConstant ("FALSE")));

			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s1"), new CCodeConstant ("NULL"));
			var cif = new CCodeIfStatement (cexp, block);
			cblock.add_statement (cif);

			cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s2"), new CCodeConstant ("NULL"));
			cif = new CCodeIfStatement (cexp, block);
			cblock.add_statement (cif);
		}

		foreach (Field f in st.get_fields ()) {
			if (f.binding != MemberBinding.INSTANCE) {
				// we only compare instance fields
				continue;
			}

			CCodeExpression cexp; // if (cexp) return FALSE;
			var s1 = (CCodeExpression) new CCodeMemberAccess.pointer (new CCodeIdentifier ("s1"), f.name); // s1->f
			var s2 = (CCodeExpression) new CCodeMemberAccess.pointer (new CCodeIdentifier ("s2"), f.name); // s2->f

			var field_type = f.field_type.copy ();
			make_comparable_cexpression (ref field_type, ref s1, ref field_type, ref s2);

			if (!(f.field_type is NullType) && f.field_type.compatible (string_type)) {
				requires_strcmp0 = true;
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("_vala_strcmp0"));
				ccall.add_argument (s1);
				ccall.add_argument (s2);
				cexp = ccall;
			} else if (f.field_type is StructValueType) {
				var equalfunc = generate_struct_equal_function (f.field_type.data_type as Struct);
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (equalfunc));
				ccall.add_argument (s1);
				ccall.add_argument (s2);
				cexp = new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, ccall);
			} else {
				cexp = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, s1, s2);
			}

			var block = new CCodeBlock ();
			block.add_statement (new CCodeReturnStatement (new CCodeConstant ("FALSE")));
			var cif = new CCodeIfStatement (cexp, block);
			cblock.add_statement (cif);
		}

		if (st.get_fields().size == 0) {
			// either opaque structure or simple type
			if (st.is_simple_type ()) {
				var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("s1")), new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("s2")));
				cblock.add_statement (new CCodeReturnStatement (cexp));
			} else {
				cblock.add_statement (new CCodeReturnStatement (new CCodeConstant ("FALSE")));
			}
		} else {
			cblock.add_statement (new CCodeReturnStatement (new CCodeConstant ("TRUE")));
		}

		// append to file

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = cblock;
		source_type_member_definition.append (function);

		return equal_func;
	}

	private string generate_numeric_equal_function (Struct st) {
		string equal_func = "_%sequal".printf (st.get_lower_case_cprefix ());

		if (!add_wrapper (equal_func)) {
			// wrapper already defined
			return equal_func;
		}
		// declaration

		var function = new CCodeFunction (equal_func, "gboolean");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("s1", "const " + st.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("s2", "const " + st.get_cname () + "*"));

		// definition
		var cblock = new CCodeBlock ();

		// if (s1 == s2) return TRUE;
		{
			var block = new CCodeBlock ();
			block.add_statement (new CCodeReturnStatement (new CCodeConstant ("TRUE")));

			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s1"), new CCodeIdentifier ("s2"));
			var cif = new CCodeIfStatement (cexp, block);
			cblock.add_statement (cif);
		}
		// if (s1 == NULL || s2 == NULL) return FALSE;
		{
			var block = new CCodeBlock ();
			block.add_statement (new CCodeReturnStatement (new CCodeConstant ("FALSE")));

			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s1"), new CCodeConstant ("NULL"));
			var cif = new CCodeIfStatement (cexp, block);
			cblock.add_statement (cif);

			cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s2"), new CCodeConstant ("NULL"));
			cif = new CCodeIfStatement (cexp, block);
			cblock.add_statement (cif);
		}
		// return (*s1 == *s2);
		{
			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("s1")), new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("s2")));
			cblock.add_statement (new CCodeReturnStatement (cexp));
		}

		// append to file

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = cblock;
		source_type_member_definition.append (function);

		return equal_func;
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
				if (!st.has_copy_function) {
					generate_struct_copy_function (st);
				}

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

	protected string generate_destroy_func_wrapper (DataType type) {
		string destroy_func = "_vala_%s_free".printf (type.data_type.get_cname ());

		if (!add_wrapper (destroy_func)) {
			// wrapper already defined
			return destroy_func;
		}

		// declaration

		var function = new CCodeFunction (destroy_func, "void");
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeFormalParameter ("self", type.get_cname ()));

		// definition

		var block = new CCodeBlock ();

		var free_call = new CCodeFunctionCall (new CCodeIdentifier (type.data_type.get_free_function ()));
		free_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("self")));

		block.add_statement (new CCodeExpressionStatement (free_call));

		// append to file

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return destroy_func;
	}

	public CCodeExpression? get_destroy_func_expression (DataType type, bool is_chainup = false) {
		if (context.profile == Profile.GOBJECT && (type.data_type == glist_type || type.data_type == gslist_type)) {
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
					var cl = type.data_type as Class;
					if (cl != null && cl.free_function_address_of) {
						unref_function = generate_destroy_func_wrapper (type);
					} else {
						unref_function = type.data_type.get_free_function ();
					}
				}
			} else {
				if (type.nullable) {
					unref_function = type.data_type.get_free_function ();
					if (unref_function == null) {
						unref_function = "g_free";
					}
				} else {
					var st = (Struct) type.data_type;
					if (!st.has_destroy_function) {
						generate_struct_destroy_function (st);
					}
					unref_function = st.get_destroy_function ();
				}
			}
			if (unref_function == null) {
				return new CCodeConstant ("NULL");
			}
			return new CCodeIdentifier (unref_function);
		} else if (type.type_parameter != null && current_type_symbol is Class) {
			string func_name = "%s_destroy_func".printf (type.type_parameter.name.down ());
			if (is_in_generic_type (type) && !is_chainup && !in_creation_method) {
				return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (get_result_cexpression ("self"), "priv"), func_name);
			} else {
				return new CCodeIdentifier (func_name);
			}
		} else if (type is ArrayType) {
			if (context.profile == Profile.POSIX) {
				return new CCodeIdentifier ("free");
			} else {
				return new CCodeIdentifier ("g_free");
			}
		} else if (type is PointerType) {
			if (context.profile == Profile.POSIX) {
				return new CCodeIdentifier ("free");
			} else {
				return new CCodeIdentifier ("g_free");
			}
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

	public virtual string? append_struct_array_free (Struct st) {
		return null;
	}

	public virtual CCodeExpression get_unref_expression (CCodeExpression cvar, DataType type, Expression? expr, bool is_macro_definition = false) {
		if (type is DelegateType) {
			CCodeExpression delegate_target_destroy_notify;
			var delegate_target = get_delegate_target_cexpression (expr, out delegate_target_destroy_notify);

			var ccall = new CCodeFunctionCall (delegate_target_destroy_notify);
			ccall.add_argument (delegate_target);

			var destroy_call = new CCodeCommaExpression ();
			destroy_call.append_expression (ccall);
			destroy_call.append_expression (new CCodeConstant ("NULL"));

			var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, delegate_target_destroy_notify, new CCodeConstant ("NULL"));

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeConditionalExpression (cisnull, new CCodeConstant ("NULL"), destroy_call));
			ccomma.append_expression (new CCodeAssignment (cvar, new CCodeConstant ("NULL")));
			ccomma.append_expression (new CCodeAssignment (delegate_target, new CCodeConstant ("NULL")));
			ccomma.append_expression (new CCodeAssignment (delegate_target_destroy_notify, new CCodeConstant ("NULL")));

			return ccomma;
		}

		var ccall = new CCodeFunctionCall (get_destroy_func_expression (type));

		if (type is ValueType && !type.nullable) {
			// normal value type, no null check
			var st = type.data_type as Struct;
			if (st != null && st.is_simple_type ()) {
				// used for va_list
				ccall.add_argument (cvar);
			} else {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cvar));
			}

			if (gvalue_type != null && type.data_type == gvalue_type) {
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

		if (ccall.call is CCodeIdentifier && !(type is ArrayType) && !is_macro_definition) {
			// generate and use NULL-aware free macro to simplify code

			var freeid = (CCodeIdentifier) ccall.call;
			string free0_func = "_%s0".printf (freeid.name);

			if (add_wrapper (free0_func)) {
				var macro = get_unref_expression (new CCodeIdentifier ("var"), type, expr, true);
				source_declarations.add_type_declaration (new CCodeMacroReplacement.with_expression ("%s(var)".printf (free0_func), macro));
			}

			ccall = new CCodeFunctionCall (new CCodeIdentifier (free0_func));
			ccall.add_argument (cvar);
			return ccall;
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

		if (context.profile == Profile.GOBJECT) {
			if (type.data_type != null && !type.data_type.is_reference_counting () &&
			    (type.data_type == gstringbuilder_type
			     || type.data_type == garray_type
			     || type.data_type == gbytearray_type
			     || type.data_type == gptrarray_type)) {
				ccall.add_argument (new CCodeConstant ("TRUE"));
			} else if (type.data_type == gthreadpool_type) {
				ccall.add_argument (new CCodeConstant ("FALSE"));
				ccall.add_argument (new CCodeConstant ("TRUE"));
			} else if (type is ArrayType) {
				var array_type = (ArrayType) type;
				if (requires_destroy (array_type.element_type)) {
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

					var st = array_type.element_type.data_type as Struct;
					if (st != null && !array_type.element_type.nullable) {
						ccall.call = new CCodeIdentifier (append_struct_array_free (st));
						ccall.add_argument (csizeexpr);
					} else {
						requires_array_free = true;
						ccall.call = new CCodeIdentifier ("_vala_array_free");
						ccall.add_argument (csizeexpr);
						ccall.add_argument (new CCodeCastExpression (get_destroy_func_expression (array_type.element_type), "GDestroyNotify"));
					}
				}
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

		if (((List<LocalVariable>) temp_ref_vars).size == 0) {
			/* nothing to do without temporary variables */
			return;
		}

		var expr_list = new CCodeCommaExpression ();

		LocalVariable full_expr_var = null;

		var local_decl = expr.parent_node as LocalVariable;
		if (local_decl != null && has_simple_struct_initializer (local_decl)) {
			expr_list.append_expression ((CCodeExpression) expr.ccodenode);
		} else {
			var expr_type = expr.value_type;
			if (expr.target_type != null) {
				expr_type = expr.target_type;
			}

			full_expr_var = get_temp_variable (expr_type, true, expr, false);
			expr.temp_vars.add (full_expr_var);
		
			expr_list.append_expression (new CCodeAssignment (get_variable_cexpression (full_expr_var.name), (CCodeExpression) expr.ccodenode));
		}
		
		foreach (LocalVariable local in temp_ref_vars) {
			var ma = new MemberAccess.simple (local.name);
			ma.symbol_reference = local;
			ma.value_type = local.variable_type.copy ();
			expr_list.append_expression (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma));
		}

		if (full_expr_var != null) {
			expr_list.append_expression (get_variable_cexpression (full_expr_var.name));
		}

		expr.ccodenode = expr_list;
		
		temp_ref_vars.clear ();
	}
	
	public void append_temp_decl (CCodeFragment cfrag, List<LocalVariable> temp_vars) {
		foreach (LocalVariable local in temp_vars) {
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
			} else if (local.no_init) {
				// no initialization necessary for this temp var
			} else if (!local.variable_type.nullable &&
			           (st != null && !st.is_simple_type ()) ||
			           (array_type != null && array_type.fixed_length)) {
				// 0-initialize struct with struct initializer { 0 }
				// necessary as they will be passed by reference
				var clist = new CCodeInitializerList ();
				clist.append (new CCodeConstant ("0"));

				vardecl.initializer = clist;
				vardecl.init0 = true;
			} else if (local.variable_type.is_reference_type_or_type_parameter () ||
			       local.variable_type.nullable ||
			       local.variable_type is DelegateType) {
				vardecl.initializer = new CCodeConstant ("NULL");
				vardecl.init0 = true;
			}

			if (current_method != null && current_method.coroutine) {
				closure_struct.add_field (local.variable_type.get_cname (), local.name);

				// even though closure struct is zerod, we need to initialize temporary variables
				// as they might be used multiple times when declared in a loop

				if (vardecl.initializer  is CCodeInitializerList) {
					// C does not support initializer lists in assignments, use memset instead
					source_declarations.add_include ("string.h");
					var memset_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
					memset_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (local.name)));
					memset_call.add_argument (new CCodeConstant ("0"));
					memset_call.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (local.variable_type.get_cname ())));
					cfrag.append (new CCodeExpressionStatement (memset_call));
				} else if (vardecl.initializer != null) {
					cfrag.append (new CCodeExpressionStatement (new CCodeAssignment (get_variable_cexpression (local.name), vardecl.initializer)));
				}
			} else {
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

		/* free temporary objects and handle errors */

		if (((List<LocalVariable>) temp_vars).size == 0
		     && pre_statement_fragment == null
		     && (!stmt.tree_can_fail || !stmt.expression.tree_can_fail)) {
			/* nothing to do without temporary variables and errors */
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
			ma.value_type = local.variable_type.copy ();
			cfrag.append (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
		}

		if (stmt.tree_can_fail && stmt.expression.tree_can_fail) {
			// simple case, no node breakdown necessary
			head.add_simple_check (stmt.expression, cfrag);
		}

		stmt.ccodenode = cfrag;

		temp_vars.clear ();
		temp_ref_vars.clear ();
	}
	
	public void create_temp_decl (Statement stmt, List<LocalVariable> temp_vars) {
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

	public virtual void append_local_free (Symbol sym, CCodeFragment cfrag, bool stop_at_loop = false) {
		var b = (Block) sym;

		var local_vars = b.get_local_variables ();
		foreach (LocalVariable local in local_vars) {
			if (!local.unreachable && local.active && !local.floating && !local.captured && requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				ma.value_type = local.variable_type.copy ();
				cfrag.append (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
			}
		}

		if (b.captured) {
			int block_id = get_block_id (b);

			var data_unref = new CCodeFunctionCall (new CCodeIdentifier ("block%d_data_unref".printf (block_id)));
			data_unref.add_argument (get_variable_cexpression ("_data%d_".printf (block_id)));
			cfrag.append (new CCodeExpressionStatement (data_unref));
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
			if (!local.unreachable && local.active && !local.floating && !local.captured && requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				cfrag.append (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
			}
		}

		if (b.captured) {
			int block_id = get_block_id (b);

			var data_unref = new CCodeFunctionCall (new CCodeIdentifier ("block%d_data_unref".printf (block_id)));
			data_unref.add_argument (get_variable_cexpression ("_data%d_".printf (block_id)));
			cfrag.append (new CCodeExpressionStatement (data_unref));
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
			if (!param.ellipsis && requires_destroy (param.parameter_type) && param.direction == ParameterDirection.IN) {
				var ma = new MemberAccess.simple (param.name);
				ma.symbol_reference = param;
				ma.value_type = param.parameter_type.copy ();
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

	public virtual bool variable_accessible_in_finally (LocalVariable local) {
		if (current_try == null) {
			return false;
		}

		var sym = current_symbol;

		while (!(sym is Method) && sym.scope.lookup (local.name) == null) {
			if ((sym.parent_node is TryStatement && ((TryStatement) sym.parent_node).finally_body != null) ||
				(sym.parent_node is CatchClause && ((TryStatement) sym.parent_node.parent_node).finally_body != null)) {

				return true;
			}

			sym = sym.parent_symbol;
		}

		return false;
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		// avoid unnecessary ref/unref pair
		if (stmt.return_expression != null) {
			var local = stmt.return_expression.symbol_reference as LocalVariable;
			if (current_return_type.value_owned
			    && local != null && local.variable_type.value_owned
			    && !local.captured
			    && !variable_accessible_in_finally (local)) {
				/* return expression is local variable taking ownership and
				 * current method is transferring ownership */

				// don't ref expression
				stmt.return_expression.value_type.value_owned = true;
			}
		}

		stmt.accept_children (codegen);

		Symbol return_expression_symbol = null;

		if (stmt.return_expression != null) {
			// avoid unnecessary ref/unref pair
			var local = stmt.return_expression.symbol_reference as LocalVariable;
			if (current_return_type.value_owned
			    && local != null && local.variable_type.value_owned
			    && !local.captured
			    && !variable_accessible_in_finally (local)) {
				/* return expression is local variable taking ownership and
				 * current method is transferring ownership */

				// don't unref variable
				return_expression_symbol = local;
				return_expression_symbol.active = false;
			}
		}

		// return array length if appropriate
		if (((current_method != null && !current_method.no_array_length) || current_property_accessor != null) && current_return_type is ArrayType) {
			var return_expr_decl = get_temp_variable (stmt.return_expression.value_type, true, stmt, false);

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (return_expr_decl.name), (CCodeExpression) stmt.return_expression.ccodenode));

			var array_type = (ArrayType) current_return_type;

			for (int dim = 1; dim <= array_type.rank; dim++) {
				var len_l = get_result_cexpression (head.get_array_length_cname ("result", dim));
				if (current_method == null || !current_method.coroutine) {
					len_l = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, len_l);
				}
				var len_r = head.get_array_length_cexpression (stmt.return_expression, dim);
				ccomma.append_expression (new CCodeAssignment (len_l, len_r));
			}

			ccomma.append_expression (get_variable_cexpression (return_expr_decl.name));

			stmt.return_expression.ccodenode = ccomma;
			stmt.return_expression.temp_vars.add (return_expr_decl);
		} else if ((current_method != null || current_property_accessor != null) && current_return_type is DelegateType) {
			var delegate_type = (DelegateType) current_return_type;
			if (delegate_type.delegate_symbol.has_target) {
				var return_expr_decl = get_temp_variable (stmt.return_expression.value_type, true, stmt, false);

				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (return_expr_decl.name), (CCodeExpression) stmt.return_expression.ccodenode));

				var target_l = get_result_cexpression (get_delegate_target_cname ("result"));
				if (current_method == null || !current_method.coroutine) {
					target_l = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, target_l);
				}
				CCodeExpression target_r_destroy_notify;
				var target_r = get_delegate_target_cexpression (stmt.return_expression, out target_r_destroy_notify);
				ccomma.append_expression (new CCodeAssignment (target_l, target_r));
				if (delegate_type.value_owned) {
					var target_l_destroy_notify = get_result_cexpression (get_delegate_target_destroy_notify_cname ("result"));
					if (current_method == null || !current_method.coroutine) {
						target_l_destroy_notify = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, target_l_destroy_notify);
					}
					ccomma.append_expression (new CCodeAssignment (target_l_destroy_notify, target_r_destroy_notify));
				}

				ccomma.append_expression (get_variable_cexpression (return_expr_decl.name));

				stmt.return_expression.ccodenode = ccomma;
				stmt.return_expression.temp_vars.add (return_expr_decl);
			}
		}

		var cfrag = new CCodeFragment ();

		if (stmt.return_expression != null) {
			// assign method result to `result'
			CCodeExpression result_lhs = get_result_cexpression ();
			if (current_return_type.is_real_non_null_struct_type () && (current_method == null || !current_method.coroutine)) {
				result_lhs = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, result_lhs);
			}
			cfrag.append (new CCodeExpressionStatement (new CCodeAssignment (result_lhs, (CCodeExpression) stmt.return_expression.ccodenode)));
		}

		// free local variables
		append_local_free (current_symbol, cfrag);

		if (current_method != null) {
			// check postconditions
			foreach (Expression postcondition in current_method.get_postconditions ()) {
				cfrag.append (create_postcondition_statement (postcondition));
			}
		}

		CCodeReturnStatement creturn = null;
		if (current_method is CreationMethod) {
			creturn = new CCodeReturnStatement (new CCodeIdentifier ("self"));
			cfrag.append (creturn);
		} else if (current_method != null && current_method.coroutine) {
		} else if (current_return_type is VoidType || current_return_type.is_real_non_null_struct_type ()) {
			// structs are returned via out parameter
			creturn = new CCodeReturnStatement ();
			cfrag.append (creturn);
		} else {
			creturn = new CCodeReturnStatement (new CCodeIdentifier ("result"));
			cfrag.append (creturn);
		}

		stmt.ccodenode = cfrag;
		if (creturn != null) {
			creturn.line = stmt.ccodenode.line;
		}

		if (stmt.return_expression != null) {
			create_temp_decl (stmt, stmt.return_expression.temp_vars);
		}

		if (return_expression_symbol != null) {
			return_expression_symbol.active = true;
		}
	}

	public string get_symbol_lock_name (string symname) {
		return "__lock_%s".printf (symname);
	}

	private CCodeExpression get_lock_expression (Statement stmt, Expression resource) {
		CCodeExpression l = null;
		var inner_node = ((MemberAccess)resource).inner;
		var member = (Member)resource.symbol_reference;
		var parent = (TypeSymbol)resource.symbol_reference.parent_symbol;
		
		if (member.is_instance_member ()) {
			if (inner_node  == null) {
				l = new CCodeIdentifier ("self");
			} else if (resource.symbol_reference.parent_symbol != current_type_symbol) {
				l = generate_instance_cast ((CCodeExpression) inner_node.ccodenode, parent);
			} else {
				l = (CCodeExpression) inner_node.ccodenode;
			}

			l = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (l, "priv"), get_symbol_lock_name (resource.symbol_reference.name));
		} else if (member.is_class_member ()) {
			CCodeExpression klass;

			if (current_method != null && current_method.binding == MemberBinding.INSTANCE ||
			    current_property_accessor != null && current_property_accessor.prop.binding == MemberBinding.INSTANCE ||
			    (in_constructor && !in_static_or_class_context)) {
				var k = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_GET_CLASS"));
				k.add_argument (new CCodeIdentifier ("self"));
				klass = k;
			} else {
				klass = new CCodeIdentifier ("klass");
			}

			var get_class_private_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS_PRIVATE".printf(parent.get_upper_case_cname ())));
			get_class_private_call.add_argument (klass);
			l = new CCodeMemberAccess.pointer (get_class_private_call, get_symbol_lock_name (resource.symbol_reference.name));
		} else {
			string lock_name = "%s_%s".printf(parent.get_lower_case_cname (), resource.symbol_reference.name);
			l = new CCodeIdentifier (get_symbol_lock_name (lock_name));
		}
		return l;
	}
		
	public override void visit_lock_statement (LockStatement stmt) {
		var l = get_lock_expression (stmt, stmt.resource);

		var fc = new CCodeFunctionCall (new CCodeIdentifier (((Method) mutex_type.scope.lookup ("lock")).get_cname ()));
		fc.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));

		var cn = new CCodeFragment ();
		cn.append (new CCodeExpressionStatement (fc));
		stmt.ccodenode = cn;
	}
		
	public override void visit_unlock_statement (UnlockStatement stmt) {
		var l = get_lock_expression (stmt, stmt.resource);
		
		var fc = new CCodeFunctionCall (new CCodeIdentifier (((Method) mutex_type.scope.lookup ("unlock")).get_cname ()));
		fc.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));
		
		var cn = new CCodeFragment ();
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
				var st = expr.formal_value_type.type_parameter.parent_symbol.parent_symbol as Struct;
				if (expr.formal_value_type.type_parameter.parent_symbol != garray_type &&
				    (st == null || st.get_cname () != "va_list")) {
					// GArray and va_list don't use pointer-based generics
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
		expr.ccodenode = new CCodeConstant (expr.value + expr.type_suffix);
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
		expr.ccodenode = new CCodeConstant.string (expr.value);
	}

	public override void visit_regex_literal (RegexLiteral expr) {
		string[] parts = expr.value.split ("/", 3);
		string re = parts[2].escape ("");
		string flags = "0";

		if (parts[1].contains ("i")) {
			flags += " | G_REGEX_CASELESS";
		}
		if (parts[1].contains ("m")) {
			flags += " | G_REGEX_MULTILINE";
		}
		if (parts[1].contains ("s")) {
			flags += " | G_REGEX_DOTALL";
		}
		if (parts[1].contains ("x")) {
			flags += " | G_REGEX_EXTENDED";
		}

		var regex_var = get_temp_variable (regex_type, true, expr, false);
		expr.temp_vars.add (regex_var);

		var cdecl = new CCodeDeclaration ("GRegex*");

		var cname = regex_var.name + "regex_" + next_regex_id.to_string ();
		if (this.next_regex_id == 0) {
			var fun = new CCodeFunction ("_thread_safe_regex_init", "GRegex*");
			fun.modifiers = CCodeModifiers.STATIC | CCodeModifiers.INLINE;
			fun.add_parameter (new CCodeFormalParameter ("re", "GRegex**"));
			fun.add_parameter (new CCodeFormalParameter ("pattern", "const gchar *"));
			fun.add_parameter (new CCodeFormalParameter ("match_options", "GRegexMatchFlags"));
			fun.block = new CCodeBlock ();

			var once_enter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_once_init_enter"));
			once_enter_call.add_argument (new CCodeConstant ("(volatile gsize*) re"));

			var if_block = new CCodeBlock ();

			var regex_new_call = new CCodeFunctionCall (new CCodeIdentifier ("g_regex_new"));
			regex_new_call.add_argument (new CCodeConstant ("pattern"));
			regex_new_call.add_argument (new CCodeConstant ("match_options"));
			regex_new_call.add_argument (new CCodeConstant ("0"));
			regex_new_call.add_argument (new CCodeConstant ("NULL"));
			if_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("GRegex* val"), regex_new_call)));

			var once_leave_call = new CCodeFunctionCall (new CCodeIdentifier ("g_once_init_leave"));
			once_leave_call.add_argument (new CCodeConstant ("(volatile gsize*) re"));
			once_leave_call.add_argument (new CCodeConstant ("(gsize) val"));
			if_block.add_statement (new CCodeExpressionStatement (once_leave_call));

			var if_stat = new CCodeIfStatement (once_enter_call, if_block);
			fun.block.add_statement (if_stat);
			fun.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("*re")));

			source_type_member_definition.append (fun);
		}
		this.next_regex_id++;

		cdecl.add_declarator (new CCodeVariableDeclarator (cname + " = NULL"));
		cdecl.modifiers = CCodeModifiers.STATIC;

		var regex_const = new CCodeConstant ("_thread_safe_regex_init (&%s, \"%s\", %s)".printf (cname, re, flags));

		source_declarations.add_constant_declaration (cdecl);
		expr.ccodenode = regex_const;
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

	public virtual CCodeExpression get_delegate_target_cexpression (Expression delegate_expr, out CCodeExpression delegate_target_destroy_notify) {
		assert_not_reached ();
	}

	public virtual string get_delegate_target_destroy_notify_cname (string delegate_cname) {
		assert_not_reached ();
	}

	public override void visit_base_access (BaseAccess expr) {
		CCodeExpression this_access;
		if (current_method != null && current_method.coroutine) {
			// use closure
			this_access = new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "self");
		} else {
			this_access = new CCodeIdentifier ("self");
		}

		expr.ccodenode = generate_instance_cast (this_access, expr.value_type.data_type);
	}

	public override void visit_postfix_expression (PostfixExpression expr) {
		MemberAccess ma = find_property_access (expr.inner);
		if (ma != null) {
			// property postfix expression
			var prop = (Property) ma.symbol_reference;
			
			var ccomma = new CCodeCommaExpression ();
			
			// assign current value to temp variable
			var temp_decl = get_temp_variable (prop.property_type, true, expr, false);
			temp_vars.insert (0, temp_decl);
			ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_decl.name), (CCodeExpression) expr.inner.ccodenode));
			
			// increment/decrement property
			var op = expr.increment ? CCodeBinaryOperator.PLUS : CCodeBinaryOperator.MINUS;
			var cexpr = new CCodeBinaryExpression (op, get_variable_cexpression (temp_decl.name), new CCodeConstant ("1"));
			var ccall = get_property_set_call (prop, ma, cexpr);
			ccomma.append_expression (ccall);
			
			// return previous value
			ccomma.append_expression (get_variable_cexpression (temp_decl.name));
			
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

	bool is_limited_generic_type (DataType type) {
		var cl = type.type_parameter.parent_symbol as Class;
		var st = type.type_parameter.parent_symbol as Struct;
		if ((cl != null && cl.is_compact) || st != null) {
			// compact classes and structs only
			// have very limited generics support
			return true;
		}
		return false;
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
			if (is_limited_generic_type (type)) {
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
			if (is_limited_generic_type (type)) {
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
		if (expression_type is DelegateType) {
			return cexpr;
		}

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

			if (!st.has_copy_function) {
				generate_struct_copy_function (st);
			}

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

			if (gvalue_type != null && expression_type.data_type == gvalue_type) {
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

		if (dupexpr is CCodeIdentifier && !(expression_type is ArrayType) && !(expression_type is GenericType) && !is_ref_function_void (expression_type)) {
			// generate and call NULL-aware ref function to reduce number
			// of temporary variables and simplify code

			var dupid = (CCodeIdentifier) dupexpr;
			string dup0_func = "_%s0".printf (dupid.name);

			// g_strdup is already NULL-safe
			if (dupid.name == "g_strdup") {
				dup0_func = dupid.name;
			} else if (add_wrapper (dup0_func)) {
				string pointer_cname = "gpointer";
				if (context.profile == Profile.POSIX) {
					pointer_cname = "void*";
				}
				var dup0_fun = new CCodeFunction (dup0_func, pointer_cname);
				dup0_fun.add_parameter (new CCodeFormalParameter ("self", pointer_cname));
				dup0_fun.modifiers = CCodeModifiers.STATIC;
				dup0_fun.block = new CCodeBlock ();

				var dup_call = new CCodeFunctionCall (dupexpr);
				dup_call.add_argument (new CCodeIdentifier ("self"));

				dup0_fun.block.add_statement (new CCodeReturnStatement (new CCodeConditionalExpression (new CCodeIdentifier ("self"), dup_call, new CCodeConstant ("NULL"))));

				source_type_member_definition.append (dup0_fun);
			}

			var ccall = new CCodeFunctionCall (new CCodeIdentifier (dup0_func));
			ccall.add_argument (cexpr);
			return ccall;
		}

		var ccall = new CCodeFunctionCall (dupexpr);

		if (!(expression_type is ArrayType) && expr != null && expr.is_non_null ()
		    && !is_ref_function_void (expression_type)) {
			// expression is non-null
			ccall.add_argument ((CCodeExpression) expr.ccodenode);
			
			return ccall;
		} else {
			var decl = get_temp_variable (expression_type, false, node, false);
			temp_vars.insert (0, decl);

			var ctemp = get_variable_cexpression (decl.name);
			
			var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ctemp, new CCodeConstant ("NULL"));
			if (expression_type.type_parameter != null) {
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

				if (array_type.element_type is GenericType) {
					var elem_dupexpr = get_dup_func_expression (array_type.element_type, node.source_reference);
					if (elem_dupexpr == null) {
						elem_dupexpr = new CCodeConstant ("NULL");
					}
					ccall.add_argument (elem_dupexpr);
				}
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
		} else if (type_arg is EnumValueType) {
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
		} else if (type_arg is DelegateType) {
			var delegate_type = (DelegateType) type_arg;
			if (delegate_type.delegate_symbol.has_target) {
				Report.error (type_arg.source_reference, "Delegates with target are not supported as generic type arguments");
			}
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

	public void add_generic_type_arguments (Map<int,CCodeExpression> arg_map, List<DataType> type_args, CodeNode expr, bool is_chainup = false) {
		int type_param_index = 0;
		foreach (var type_arg in type_args) {
			arg_map.set (get_param_pos (0.1 * type_param_index + 0.01), get_type_id_expression (type_arg, is_chainup));
			if (requires_copy (type_arg)) {
				var dup_func = get_dup_func_expression (type_arg, type_arg.source_reference, is_chainup);
				if (dup_func == null) {
					// type doesn't contain a copy function
					expr.error = true;
					return;
				}
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeCastExpression (dup_func, "GBoxedCopyFunc"));
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.03), get_destroy_func_expression (type_arg, is_chainup));
			} else {
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeConstant ("NULL"));
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeConstant ("NULL"));
			}
			type_param_index++;
		}
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		expr.accept_children (codegen);

		CCodeExpression instance = null;
		CCodeExpression creation_expr = null;

		check_type (expr.type_reference);

		var st = expr.type_reference.data_type as Struct;
		if ((st != null && (!st.is_simple_type () || st.get_cname () == "va_list")) || expr.get_object_initializer ().size > 0) {
			// value-type initialization or object creation expression with object initializer

			var local = expr.parent_node as LocalVariable;
			if (local != null && has_simple_struct_initializer (local)) {
				if (local.captured) {
					var block = (Block) local.parent_symbol;
					instance = new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id (block))), get_variable_cname (local.name));
				} else {
					instance = get_variable_cexpression (get_variable_cname (local.name));
				}
			} else {
				var temp_decl = get_temp_variable (expr.type_reference, false, expr);
				temp_vars.add (temp_decl);

				instance = get_variable_cexpression (get_variable_cname (temp_decl.name));
			}
		}

		if (expr.symbol_reference == null) {
			// no creation method
			if (expr.type_reference.data_type is Struct) {
				// memset needs string.h
				source_declarations.add_include ("string.h");
				var creation_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
				creation_call.add_argument (new CCodeConstant ("0"));
				creation_call.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (expr.type_reference.get_cname ())));

				creation_expr = creation_call;
			}
		} else if (expr.type_reference.data_type == glist_type ||
		           expr.type_reference.data_type == gslist_type) {
			// NULL is an empty list
			expr.ccodenode = new CCodeConstant ("NULL");
		} else if (expr.symbol_reference is Method) {
			// use creation method
			var m = (Method) expr.symbol_reference;
			var params = m.get_parameters ();
			CCodeFunctionCall creation_call;

			generate_method_declaration (m, source_declarations);

			var cl = expr.type_reference.data_type as Class;

			if (!m.has_new_function) {
				// use construct function directly
				creation_call = new CCodeFunctionCall (new CCodeIdentifier (m.get_real_cname ()));
				creation_call.add_argument (new CCodeIdentifier (cl.get_type_id ()));
			} else {
				creation_call = new CCodeFunctionCall (new CCodeIdentifier (m.get_cname ()));
			}

			if ((st != null && !st.is_simple_type ()) && !(m.cinstance_parameter_position < 0)) {
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
			} else if (st != null && st.get_cname () == "va_list") {
				creation_call.add_argument (instance);
				if (m.get_cname () == "va_start") {
					FormalParameter last_param = null;
					foreach (var param in current_method.get_parameters ()) {
						if (param.ellipsis) {
							break;
						}
						last_param = param;
					}
					creation_call.add_argument (new CCodeIdentifier (get_variable_cname (last_param.name)));
				}
			}

			generate_type_declaration (expr.type_reference, source_declarations);

			var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

			if (cl != null && !cl.is_compact) {
				add_generic_type_arguments (carg_map, expr.type_reference.get_type_arguments (), expr);
			} else if (cl != null && m.simple_generics) {
				int type_param_index = 0;
				foreach (var type_arg in expr.type_reference.get_type_arguments ()) {
					if (requires_copy (type_arg)) {
						carg_map.set (get_param_pos (-1 + 0.1 * type_param_index + 0.03), get_destroy_func_expression (type_arg));
					} else {
						carg_map.set (get_param_pos (-1 + 0.1 * type_param_index + 0.03), new CCodeConstant ("NULL"));
					}
					type_param_index++;
				}
			}

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
								CCodeExpression delegate_target_destroy_notify;
								var delegate_target = get_delegate_target_cexpression (arg, out delegate_target_destroy_notify);
								carg_map.set (get_param_pos (param.cdelegate_target_parameter_position), delegate_target);
								if (deleg_type.value_owned) {
									carg_map.set (get_param_pos (param.cdelegate_target_parameter_position + 0.01), delegate_target_destroy_notify);
								}
							}
						}

						cexpr = handle_struct_argument (param, arg, cexpr);

						if (param.ctype != null) {
							cexpr = new CCodeCastExpression (cexpr, param.ctype);
						}
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
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression ("_inner_error_")));
			}

			if (ellipsis) {
				/* ensure variable argument list ends with NULL
				 * except when using printf-style arguments */
				if (!m.printf_format && !m.scanf_format && m.sentinel != "") {
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

		var local = expr.parent_node as LocalVariable;
		if (local != null && has_simple_struct_initializer (local)) {
			// no comma expression necessary
			expr.ccodenode = creation_expr;
		} else if (instance != null) {
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
						CCodeExpression rhs_delegate_target_destroy_notify;
						var rhs_delegate_target = get_delegate_target_cexpression (init.initializer, out rhs_delegate_target_destroy_notify);
						ccomma.append_expression (new CCodeAssignment (lhs, rhs_delegate_target));
					}

					var cl = f.parent_symbol as Class;
					if (cl != null) {
						generate_class_struct_declaration (cl, source_declarations);
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

					var temp_var = get_temp_variable (param.parameter_type, true, null, false);
					temp_vars.insert (0, temp_var);
					ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), cexpr));
					ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (temp_var.name)));

					return ccomma;
				}
			}
		}

		return cexpr;
	}

	public override void visit_sizeof_expression (SizeofExpression expr) {
		generate_type_declaration (expr.type_reference, source_declarations);

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

	public CCodeExpression? try_cast_value_to_type (CCodeExpression ccodeexpr, DataType from, DataType to, Expression? expr = null) {
		if (from == null || gvalue_type == null || from.data_type != gvalue_type || to.get_type_id () == null) {
			return null;
		}

		// explicit conversion from GValue
		var ccall = new CCodeFunctionCall (get_value_getter_function (to));
		CCodeExpression gvalue;
		if (from.nullable) {
			gvalue = ccodeexpr;
		} else {
			gvalue = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ccodeexpr);
		}
		ccall.add_argument (gvalue);

		CCodeExpression rv = ccall;

		if (expr != null && to is ArrayType) {
			// null-terminated string array
			var len_call = new CCodeFunctionCall (new CCodeIdentifier ("g_strv_length"));
			len_call.add_argument (rv);
			expr.append_array_size (len_call);
		} else if (to is StructValueType) {
			var temp_decl = get_temp_variable (to, true, null, true);
			temp_vars.add (temp_decl);
			var ctemp = get_variable_cexpression (temp_decl.name);

			rv = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeCastExpression (rv, (new PointerType(to)).get_cname ()));
			var holds = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_HOLDS"));
			holds.add_argument (gvalue);
			holds.add_argument (new CCodeIdentifier (to.get_type_id ()));
			var cond = new CCodeBinaryExpression (CCodeBinaryOperator.AND, holds, ccall);
			var warn = new CCodeFunctionCall (new CCodeIdentifier ("g_warning"));
			warn.add_argument (new CCodeConstant ("\"Invalid GValue unboxing (wrong type or NULL)\""));
			var fail = new CCodeCommaExpression ();
			fail.append_expression (warn);
			fail.append_expression (ctemp);
			rv = new CCodeConditionalExpression (cond, rv,  fail);
		}

		return rv;
	}

	int next_variant_function_id = 0;

	public CCodeExpression? try_cast_variant_to_type (CCodeExpression ccodeexpr, DataType from, DataType to, Expression? expr = null) {
		if (from == null || gvariant_type == null || from.data_type != gvariant_type) {
			return null;
		}

		string variant_func = "_variant_get%d".printf (++next_variant_function_id);

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (variant_func));
		ccall.add_argument (ccodeexpr);

		var cfunc = new CCodeFunction (variant_func);
		cfunc.modifiers = CCodeModifiers.STATIC;
		cfunc.add_parameter (new CCodeFormalParameter ("value", "GVariant*"));

		if (!to.is_real_non_null_struct_type ()) {
			cfunc.return_type = to.get_cname ();
		}

		if (to.is_real_non_null_struct_type ()) {
			// structs are returned via out parameter
			cfunc.add_parameter (new CCodeFormalParameter ("result", to.get_cname () + "*"));
		} else if (to is ArrayType) {
			// return array length if appropriate
			var array_type = (ArrayType) to;

			for (int dim = 1; dim <= array_type.rank; dim++) {
				var temp_decl = get_temp_variable (int_type, false, expr);
				temp_vars.add (temp_decl);

				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (temp_decl.name)));
				cfunc.add_parameter (new CCodeFormalParameter (head.get_array_length_cname ("result", dim), "int*"));
				expr.append_array_size (new CCodeIdentifier (temp_decl.name));
			}
		}

		var block = new CCodeBlock ();
		var fragment = new CCodeFragment ();
		var result = deserialize_expression (fragment, to, new CCodeIdentifier ("value"), new CCodeIdentifier ("*result"));

		block.add_statement (fragment);
		block.add_statement (new CCodeReturnStatement (result));

		source_declarations.add_type_member_declaration (cfunc.copy ());

		cfunc.block = block;
		source_type_member_definition.append (cfunc);

		return ccall;
	}

	public virtual CCodeExpression? deserialize_expression (CCodeFragment fragment, DataType type, CCodeExpression variant_expr, CCodeExpression? expr) {
		return null;
	}

	public virtual CCodeExpression? serialize_expression (CCodeFragment fragment, DataType type, CCodeExpression expr) {
		return null;
	}

	public override void visit_cast_expression (CastExpression expr) {
		var valuecast = try_cast_value_to_type ((CCodeExpression) expr.inner.ccodenode, expr.inner.value_type, expr.type_reference, expr);
		if (valuecast != null) {
			expr.ccodenode = valuecast;
			return;
		}

		var variantcast = try_cast_variant_to_type ((CCodeExpression) expr.inner.ccodenode, expr.inner.value_type, expr.type_reference, expr);
		if (variantcast != null) {
			expr.ccodenode = variantcast;
			return;
		}

		generate_type_declaration (expr.type_reference, source_declarations);

		var cl = expr.type_reference.data_type as Class;
		var iface = expr.type_reference.data_type as Interface;
		if (context.profile == Profile.GOBJECT && (iface != null || (cl != null && !cl.is_compact))) {
			// checked cast for strict subtypes of GTypeInstance
			if (expr.is_silent_cast) {
				var ccomma = new CCodeCommaExpression ();
				var temp_decl = get_temp_variable (expr.inner.value_type, true, expr, false);

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
				expr.ccodenode = generate_instance_cast ((CCodeExpression) expr.inner.ccodenode, expr.type_reference.data_type);
			}
		} else {
			if (expr.is_silent_cast) {
				expr.error = true;
				Report.error (expr.source_reference, "Operation not supported for this type");
				return;
			}

			// retain array length
			var array_type = expr.type_reference as ArrayType;
			if (array_type != null && expr.inner.value_type is ArrayType) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					expr.append_array_size (get_array_length_cexpression (expr.inner, dim));
				}
			}

			var innercexpr = (CCodeExpression) expr.inner.ccodenode;
			if (expr.type_reference.data_type is Struct && !expr.type_reference.nullable &&
				expr.inner.value_type.data_type is Struct && expr.inner.value_type.nullable) {
				// nullable integer or float or boolean or struct cast to non-nullable
				innercexpr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, innercexpr);
			}
			expr.ccodenode = new CCodeCastExpression (innercexpr, expr.type_reference.get_cname ());
		}
	}
	
	public override void visit_named_argument (NamedArgument expr) {
		expr.accept_children (codegen);

		expr.ccodenode = expr.inner.ccodenode;
	}

	public override void visit_pointer_indirection (PointerIndirection expr) {
		expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, (CCodeExpression) expr.inner.ccodenode);
	}

	public override void visit_addressof_expression (AddressofExpression expr) {
		if (expr.inner.ccodenode is CCodeCommaExpression) {
			var ccomma = expr.inner.ccodenode as CCodeCommaExpression;
			var inner = ccomma.get_inner ();
			var last = inner.get (inner.size - 1);
			ccomma.set_expression (inner.size - 1, new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, (CCodeExpression) last));
			expr.ccodenode = ccomma;
		} else {
			expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, (CCodeExpression) expr.inner.ccodenode);
		}
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		expr.accept_children (codegen);

		/* (tmp = var, var = null, tmp) */
		var ccomma = new CCodeCommaExpression ();
		var temp_decl = get_temp_variable (expr.value_type, true, expr, false);
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

		CCodeExpression? left_chain = null;
		if (expr.chained) {
			var lbe = (BinaryExpression) expr.left;

			var temp_decl = get_temp_variable (lbe.right.value_type, true, null, false);
			temp_vars.insert (0, temp_decl);
			var cvar = get_variable_cexpression (temp_decl.name);
			var ccomma = new CCodeCommaExpression ();
			var clbe = (CCodeBinaryExpression) lbe.ccodenode;
			if (lbe.chained) {
				clbe = (CCodeBinaryExpression) clbe.right;
			}
			ccomma.append_expression (new CCodeAssignment (cvar, (CCodeExpression)lbe.right.ccodenode));
			clbe.right = get_variable_cexpression (temp_decl.name);
			ccomma.append_expression (cleft);
			cleft = cvar;
			left_chain = ccomma;
		}

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
			if (expr.value_type.equals (double_type)) {
				source_declarations.add_include ("math.h");
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("fmod"));
				ccall.add_argument (cleft);
				ccall.add_argument (cright);
				expr.ccodenode = ccall;
				return;
			} else if (expr.value_type.equals (float_type)) {
				source_declarations.add_include ("math.h");
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("fmodf"));
				ccall.add_argument (cleft);
				ccall.add_argument (cright);
				expr.ccodenode = ccall;
				return;
			} else {
				op = CCodeBinaryOperator.MOD;
			}
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
			if (expr.right.value_type is ArrayType) {
				var array_type = (ArrayType) expr.right.value_type;
				var node = new CCodeFunctionCall (new CCodeIdentifier (generate_array_contains_wrapper (array_type)));
				node.add_argument (cright);
				node.add_argument (get_array_length_cexpression (expr.right));
				if (array_type.element_type is StructValueType) {
					node.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cleft));
				} else {
					node.add_argument (cleft);
				}
				expr.ccodenode = node;
			} else {
				expr.ccodenode = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeBinaryExpression (CCodeBinaryOperator.BITWISE_AND, cright, cleft), cleft);
			}
			return;
		} else {
			assert_not_reached ();
		}
		
		if (expr.operator == BinaryOperator.EQUALITY ||
		    expr.operator == BinaryOperator.INEQUALITY) {
			var left_type = expr.left.target_type;
			var right_type = expr.right.target_type;
			make_comparable_cexpression (ref left_type, ref cleft, ref right_type, ref cright);

			if (left_type is StructValueType && right_type is StructValueType) {
				var equalfunc = generate_struct_equal_function ((Struct) left_type.data_type as Struct);
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (equalfunc));
				ccall.add_argument (cleft);
				ccall.add_argument (cright);
				cleft = ccall;
				cright = new CCodeConstant ("TRUE");
			} else if ((left_type is IntegerType || left_type is FloatingType || left_type is BooleanType) && left_type.nullable &&
			           (right_type is IntegerType || right_type is FloatingType || right_type is BooleanType) && right_type.nullable) {
				var equalfunc = generate_numeric_equal_function ((Struct) left_type.data_type as Struct);
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (equalfunc));
				ccall.add_argument (cleft);
				ccall.add_argument (cright);
				cleft = ccall;
				cright = new CCodeConstant ("TRUE");
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
					if (context.profile == Profile.POSIX) {
						// convert to strcat(strcpy(malloc(1+strlen(a)+strlen(b)),a),b)
						var strcat = new CCodeFunctionCall (new CCodeIdentifier ("strcat"));
						var strcpy = new CCodeFunctionCall (new CCodeIdentifier ("strcpy"));
						var malloc = new CCodeFunctionCall (new CCodeIdentifier ("malloc"));

						var strlen_a = new CCodeFunctionCall (new CCodeIdentifier ("strlen"));
						strlen_a.add_argument(cleft);
						var strlen_b = new CCodeFunctionCall (new CCodeIdentifier ("strlen"));
						strlen_b.add_argument(cright);
						var newlength = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier("1"),
							new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, strlen_a, strlen_b));
						malloc.add_argument(newlength);

						strcpy.add_argument(malloc);
						strcpy.add_argument(cleft);

						strcat.add_argument(strcpy);
						strcat.add_argument(cright);
						expr.ccodenode = strcat;
					} else {
						// convert to g_strconcat (a, b, NULL)
						var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_strconcat"));
						ccall.add_argument (cleft);
						ccall.add_argument (cright);
						ccall.add_argument (new CCodeConstant("NULL"));
						expr.ccodenode = ccall;
					}
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
		if (left_chain != null) {
			expr.ccodenode = new CCodeBinaryExpression (CCodeBinaryOperator.AND, left_chain, (CCodeExpression) expr.ccodenode);
		}
	}

	public string? get_type_check_function (TypeSymbol type) {
		var cl = type as Class;
		if (cl != null && cl.type_check_function != null) {
			return cl.type_check_function;
		} else if ((cl != null && cl.is_compact) || type is Struct || type is Enum || type is Delegate) {
			return null;
		} else {
			return type.get_upper_case_cname ("IS_");
		}
	}

	CCodeExpression? create_type_check (CCodeNode ccodenode, DataType type) {
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
			string type_check_func = get_type_check_function (type.data_type);
			if (type_check_func == null) {
				return new CCodeInvalidExpression ();
			}
			var ccheck = new CCodeFunctionCall (new CCodeIdentifier (type_check_func));
			ccheck.add_argument ((CCodeExpression) ccodenode);
			return ccheck;
		}
	}

	string generate_array_contains_wrapper (ArrayType array_type) {
		string array_contains_func = "_vala_%s_array_contains".printf (array_type.element_type.get_lower_case_cname ());

		if (!add_wrapper (array_contains_func)) {
			return array_contains_func;
		}

		var function = new CCodeFunction (array_contains_func, "gboolean");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("stack", array_type.get_cname ()));
		function.add_parameter (new CCodeFormalParameter ("stack_length", "int"));
		if (array_type.element_type is StructValueType) {
			function.add_parameter (new CCodeFormalParameter ("needle", array_type.element_type.get_cname () + "*"));
		} else {
			function.add_parameter (new CCodeFormalParameter ("needle", array_type.element_type.get_cname ()));
		}
		var block = new CCodeBlock ();

		var idx_decl = new CCodeDeclaration ("int");
		idx_decl.add_declarator (new CCodeVariableDeclarator ("i"));
		block.add_statement (idx_decl);

		var celement = new CCodeElementAccess (new CCodeIdentifier ("stack"), new CCodeIdentifier ("i"));
		var cneedle = new CCodeIdentifier ("needle");
		CCodeBinaryExpression cif_condition;
		if (array_type.element_type.compatible (string_type)) {
			requires_strcmp0 = true;
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("_vala_strcmp0"));
			ccall.add_argument (celement);
			ccall.add_argument (cneedle);
			cif_condition = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ccall, new CCodeConstant ("0"));
		} else if (array_type.element_type is StructValueType) {
			var equalfunc = generate_struct_equal_function ((Struct) array_type.element_type.data_type as Struct);
			var ccall = new CCodeFunctionCall (new CCodeIdentifier (equalfunc));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, celement));
			ccall.add_argument (cneedle);
			cif_condition = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ccall, new CCodeConstant ("TRUE"));
		} else {
			cif_condition = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, cneedle, celement);
		}
		var cif_found = new CCodeBlock ();
		cif_found.add_statement (new CCodeReturnStatement (new CCodeConstant ("TRUE")));
		var cloop_body = new CCodeBlock ();
		cloop_body.add_statement (new CCodeIfStatement (cif_condition, cif_found));

		var cloop_condition = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier ("i"), new CCodeIdentifier ("stack_length"));
		var cloop = new CCodeForStatement (cloop_condition, cloop_body);
		cloop.add_initializer (new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeConstant ("0")));
		cloop.add_iterator (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("i")));

		block.add_statement (cloop);
		block.add_statement (new CCodeReturnStatement (new CCodeConstant ("FALSE")));
		source_declarations.add_type_member_declaration (function.copy ());
		function.block = block;
		source_type_member_definition.append (function);

		return array_contains_func;
	}

	public override void visit_type_check (TypeCheck expr) {
		generate_type_declaration (expr.type_reference, source_declarations);

		expr.ccodenode = create_type_check (expr.expression.ccodenode, expr.type_reference);
		if (expr.ccodenode is CCodeInvalidExpression) {
			Report.error (expr.source_reference, "type check expressions not supported for compact classes, structs, and enums");
		}
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

		bool gvalue_boxing = (context.profile == Profile.GOBJECT
		                      && target_type != null
		                      && target_type.data_type == gvalue_type
		                      && !(expression_type is NullType)
		                      && expression_type.get_type_id () != "G_TYPE_VALUE");
		bool gvariant_boxing = (context.profile == Profile.GOBJECT
		                        && target_type != null
		                        && target_type.data_type == gvariant_type
		                        && expression_type.data_type != gvariant_type);

		if (expression_type.value_owned
		    && (target_type == null || !target_type.value_owned || boxing || unboxing)) {
			// value leaked, destroy it
			var pointer_type = target_type as PointerType;
			if (pointer_type != null && !(pointer_type.base_type is VoidType)) {
				// manual memory management for non-void pointers
				// treat void* special to not leak memory with void* method parameters
			} else if (requires_destroy (expression_type)) {
				var decl = get_temp_variable (expression_type, true, expression_type, false);
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
				} else if (expression_type is DelegateType && expr != null) {
					var ccomma = new CCodeCommaExpression ();
					ccomma.append_expression (cexpr);

					var target_decl = new LocalVariable (new PointerType (new VoidType ()), get_delegate_target_cname (decl.name));
					temp_vars.insert (0, target_decl);
					var target_destroy_notify_decl = new LocalVariable (new DelegateType ((Delegate) context.root.scope.lookup ("GLib").scope.lookup ("DestroyNotify")), get_delegate_target_destroy_notify_cname (decl.name));
					temp_vars.insert (0, target_destroy_notify_decl);
					CCodeExpression target_destroy_notify;
					ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (target_decl.name), get_delegate_target_cexpression (expr, out target_destroy_notify)));
					ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (target_destroy_notify_decl.name), target_destroy_notify));

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

			if (target_type.nullable) {
				var newcall = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
				newcall.add_argument (new CCodeConstant ("GValue"));
				newcall.add_argument (new CCodeConstant ("1"));
				var newassignment = new CCodeAssignment (get_variable_cexpression (decl.name), newcall);
				ccomma.append_expression (newassignment);
			}

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
			if (target_type.nullable) {
				ccall.add_argument (get_variable_cexpression (decl.name));
			} else {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (decl.name)));
			}
			ccall.add_argument (new CCodeIdentifier (expression_type.get_type_id ()));
			ccomma.append_expression (ccall);

			if (requires_destroy (expression_type)) {
				ccall = new CCodeFunctionCall (get_value_taker_function (expression_type));
			} else {
				ccall = new CCodeFunctionCall (get_value_setter_function (expression_type));
			}
			if (target_type.nullable) {
				ccall.add_argument (get_variable_cexpression (decl.name));
			} else {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (decl.name)));
			}
			if (expression_type.is_real_non_null_struct_type ()) {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr));
			} else {
				ccall.add_argument (cexpr);
			}

			ccomma.append_expression (ccall);

			ccomma.append_expression (get_variable_cexpression (decl.name));
			cexpr = ccomma;

			return cexpr;
		} else if (gvariant_boxing) {
			// implicit conversion to GVariant
			string variant_func = "_variant_new%d".printf (++next_variant_function_id);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier (variant_func));
			ccall.add_argument (cexpr);

			var cfunc = new CCodeFunction (variant_func, "GVariant*");
			cfunc.modifiers = CCodeModifiers.STATIC;
			cfunc.add_parameter (new CCodeFormalParameter ("value", expression_type.get_cname ()));

			if (expression_type is ArrayType) {
				// return array length if appropriate
				var array_type = (ArrayType) expression_type;

				for (int dim = 1; dim <= array_type.rank; dim++) {
					ccall.add_argument (head.get_array_length_cexpression (expr, dim));
					cfunc.add_parameter (new CCodeFormalParameter (head.get_array_length_cname ("value", dim), "gint"));
				}
			}

			var block = new CCodeBlock ();
			var fragment = new CCodeFragment ();
			var result = serialize_expression (fragment, expression_type, new CCodeIdentifier ("value"));

			// sink floating reference
			var sink = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_ref_sink"));
			sink.add_argument (result);

			block.add_statement (fragment);
			block.add_statement (new CCodeReturnStatement (sink));

			source_declarations.add_type_member_declaration (cfunc.copy ());

			cfunc.block = block;
			source_type_member_definition.append (cfunc);

			return ccall;
		} else if (boxing) {
			// value needs to be boxed

			var unary = cexpr as CCodeUnaryExpression;
			if (unary != null && unary.operator == CCodeUnaryOperator.POINTER_INDIRECTION) {
				// *expr => expr
				cexpr = unary.inner;
			} else if (cexpr is CCodeIdentifier || cexpr is CCodeMemberAccess) {
				cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr);
			} else {
				var decl = get_temp_variable (expression_type, expression_type.value_owned, expression_type, false);
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
			return generate_instance_cast (cexpr, target_type.data_type);
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

	public CCodeExpression get_property_set_call (Property prop, MemberAccess ma, CCodeExpression cexpr, Expression? rhs = null) {
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
			var instance = (CCodeExpression) get_ccodenode (ma.inner);

			if (prop.parent_symbol is Struct) {
				// we need to pass struct instance by reference
				var unary = instance as CCodeUnaryExpression;
				if (unary != null && unary.operator == CCodeUnaryOperator.POINTER_INDIRECTION) {
					// *expr => expr
					instance = unary.inner;
				} else if (instance is CCodeIdentifier || instance is CCodeMemberAccess) {
					instance = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance);
				} else {
					// if instance is e.g. a function call, we can't take the address of the expression
					// (tmp = expr, &tmp)
					var ccomma = new CCodeCommaExpression ();

					var temp_var = get_temp_variable (ma.inner.target_type, true, null, false);
					temp_vars.insert (0, temp_var);
					ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), instance));
					ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (temp_var.name)));

					instance = ccomma;
				}
			}

			ccall.add_argument (instance);
		}

		if (prop.no_accessor_method) {
			/* property name is second argument of g_object_set */
			ccall.add_argument (prop.get_canonical_cconstant ());
		}

		var array_type = prop.property_type as ArrayType;

		CCodeExpression rv;
		if (array_type != null && !prop.no_array_length) {
			var temp_var = get_temp_variable (prop.property_type, true, null, false);
			temp_vars.insert (0, temp_var);
			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (get_variable_cexpression (temp_var.name), cexpr));
			ccall.add_argument (get_variable_cexpression (temp_var.name));
			ccomma.append_expression (ccall);
			rv = ccomma;
		} else {
			ccall.add_argument (cexpr);
			rv = ccall;
		}

		if (array_type != null && !prop.no_array_length && rhs != null) {
			for (int dim = 1; dim <= array_type.rank; dim++) {
				ccall.add_argument (head.get_array_length_cexpression (rhs, dim));
			}
		} else if (prop.property_type is DelegateType && rhs != null) {
			var delegate_type = (DelegateType) prop.property_type;
			if (delegate_type.delegate_symbol.has_target) {
				CCodeExpression delegate_target_destroy_notify;
				ccall.add_argument (get_delegate_target_cexpression (rhs, out delegate_target_destroy_notify));
			}
		}

		if (prop.no_accessor_method) {
			ccall.add_argument (new CCodeConstant ("NULL"));
		}

		return rv;
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
		var temp_decl = get_temp_variable (e.value_type, true, null, false);
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

	public virtual bool is_gobject_property (Property prop) {
		return false;
	}

	public DataType? get_this_type () {
		if (current_method != null && current_method.binding == MemberBinding.INSTANCE) {
			return current_method.this_parameter.parameter_type;
		} else if (current_property_accessor != null && current_property_accessor.prop.binding == MemberBinding.INSTANCE) {
			return current_property_accessor.prop.this_parameter.parameter_type;
		}
		return null;
	}

	public CCodeFunctionCall generate_instance_cast (CCodeExpression expr, TypeSymbol type) {
		var result = new CCodeFunctionCall (new CCodeIdentifier (type.get_upper_case_cname (null)));
		result.add_argument (expr);
		return result;
	}

	void generate_struct_destroy_function (Struct st) {
		if (source_declarations.add_declaration (st.get_destroy_function ())) {
			// only generate function once per source file
			return;
		}

		var function = new CCodeFunction (st.get_destroy_function (), "void");
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeFormalParameter ("self", st.get_cname () + "*"));

		var cblock = new CCodeBlock ();
		foreach (Field f in st.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE) {
				if (requires_destroy (f.field_type)) {
					var lhs = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), f.get_cname ());

					var this_access = new MemberAccess.simple ("this");
					this_access.value_type = get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);
					this_access.ccodenode = new CCodeIdentifier ("(*self)");

					var ma = new MemberAccess (this_access, f.name);
					ma.symbol_reference = f;
					cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (lhs, f.field_type, ma)));
				}
			}
		}

		source_declarations.add_type_member_declaration (function.copy ());
		function.block = cblock;
		source_type_member_definition.append (function);
	}

	void generate_struct_copy_function (Struct st) {
		if (source_declarations.add_declaration (st.get_copy_function ())) {
			// only generate function once per source file
			return;
		}

		var function = new CCodeFunction (st.get_copy_function (), "void");
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeFormalParameter ("self", "const " + st.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("dest", st.get_cname () + "*"));

		int old_next_temp_var_id = next_temp_var_id;
		var old_temp_vars = temp_vars;
		var old_temp_ref_vars = temp_ref_vars;
		var old_variable_name_map = variable_name_map;
		next_temp_var_id = 0;
		temp_vars = new ArrayList<LocalVariable> ();
		temp_ref_vars = new ArrayList<LocalVariable> ();
		variable_name_map = new HashMap<string,string> (str_hash, str_equal);

		var cblock = new CCodeBlock ();
		var cfrag = new CCodeFragment ();
		cblock.add_statement (cfrag);

		foreach (Field f in st.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE) {
				CCodeExpression copy = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), f.name);
				if (requires_copy (f.field_type))  {
					var this_access = new MemberAccess.simple ("this");
					this_access.value_type = get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);
					this_access.ccodenode = new CCodeIdentifier ("(*self)");
					var ma = new MemberAccess (this_access, f.name);
					ma.symbol_reference = f;
					copy = get_ref_cexpression (f.field_type, copy, ma, f);
				}
				var dest = new CCodeMemberAccess.pointer (new CCodeIdentifier ("dest"), f.name);

				var array_type = f.field_type as ArrayType;
				if (array_type != null && array_type.fixed_length) {
					// fixed-length (stack-allocated) arrays
					source_declarations.add_include ("string.h");

					var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
					sizeof_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
					var size = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeConstant ("%d".printf (array_type.length)), sizeof_call);

					var array_copy_call = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
					array_copy_call.add_argument (dest);
					array_copy_call.add_argument (copy);
					array_copy_call.add_argument (size);
					cblock.add_statement (new CCodeExpressionStatement (array_copy_call));
				} else {
					cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (dest, copy)));

					if (array_type != null && !f.no_array_length) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							var len_src = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), get_array_length_cname (f.name, dim));
							var len_dest = new CCodeMemberAccess.pointer (new CCodeIdentifier ("dest"), get_array_length_cname (f.name, dim));
							cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (len_dest, len_src)));
						}
					}
				}
			}
		}

		append_temp_decl (cfrag, temp_vars);
		temp_vars.clear ();

		next_temp_var_id = old_next_temp_var_id;
		temp_vars = old_temp_vars;
		temp_ref_vars = old_temp_ref_vars;
		variable_name_map = old_variable_name_map;

		source_declarations.add_type_member_declaration (function.copy ());
		function.block = cblock;
		source_type_member_definition.append (function);
	}
}

// vim:sw=8 noet
