/* valadovabasemodule.vala
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
internal class Vala.DovaBaseModule : CCodeModule {
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
	public CCodeDeclarationSpace source_declarations;

	string? csource_filename;

	public CCodeFragment source_type_member_definition;
	public CCodeFragment module_init_fragment;
	public CCodeFragment instance_init_fragment;
	public CCodeFragment instance_finalize_fragment;

	// code nodes to be inserted before the current statement
	// used by async method calls in coroutines
	public CCodeFragment pre_statement_fragment;

	/* all temporary variables */
	public ArrayList<LocalVariable> temp_vars = new ArrayList<LocalVariable> ();
	/* temporary variables that own their content */
	public ArrayList<LocalVariable> temp_ref_vars = new ArrayList<LocalVariable> ();
	/* (constant) hash table with all reserved identifiers in the generated code */
	Set<string> reserved_identifiers;

	public int next_temp_var_id = 0;
	public int next_wrapper_id = 0;
	public bool in_creation_method { get { return current_method is CreationMethod; } }
	int next_block_id = 0;
	Map<Block,int> block_map = new HashMap<Block,int> ();

	public DataType void_type = new VoidType ();
	public DataType bool_type;
	public DataType char_type;
	public DataType short_type;
	public DataType ushort_type;
	public DataType int_type;
	public DataType uint_type;
	public DataType long_type;
	public DataType ulong_type;
	public DataType string_type;
	public DataType float_type;
	public DataType double_type;
	public Class object_class;
	public Class type_class;
	public Class value_class;
	public Class array_class;
	public Class delegate_class;
	public Class error_class;

	Set<Symbol> generated_external_symbols;

	public Map<string,string> variable_name_map = new HashMap<string,string> (str_hash, str_equal);

	public DovaBaseModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);

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

		// reserved for Vala naming conventions
		reserved_identifiers.add ("result");
		reserved_identifiers.add ("this");
	}

	public override void emit (CodeContext context) {
		this.context = context;

		root_symbol = context.root;

		bool_type = new BooleanType ((Struct) root_symbol.scope.lookup ("bool"));
		char_type = new IntegerType ((Struct) root_symbol.scope.lookup ("char"));
		short_type = new IntegerType ((Struct) root_symbol.scope.lookup ("short"));
		ushort_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ushort"));
		int_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int"));
		uint_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint"));
		long_type = new IntegerType ((Struct) root_symbol.scope.lookup ("long"));
		ulong_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ulong"));
		float_type = new FloatingType ((Struct) root_symbol.scope.lookup ("float"));
		double_type = new FloatingType ((Struct) root_symbol.scope.lookup ("double"));
		string_type = new ObjectType ((Class) root_symbol.scope.lookup ("string"));

		var dova_ns = (Namespace) root_symbol.scope.lookup ("Dova");
		object_class = (Class) dova_ns.scope.lookup ("Object");
		type_class = (Class) dova_ns.scope.lookup ("Type");
		value_class = (Class) dova_ns.scope.lookup ("Value");
		array_class = (Class) dova_ns.scope.lookup ("Array");
		delegate_class = (Class) dova_ns.scope.lookup ("Delegate");
		error_class = (Class) dova_ns.scope.lookup ("Error");

		header_declarations = new CCodeDeclarationSpace ();

		source_declarations = new CCodeDeclarationSpace ();
		module_init_fragment = new CCodeFragment ();
		source_type_member_definition = new CCodeFragment ();

		if (context.nostdpkg) {
			header_declarations.add_include ("dova-types.h");
			source_declarations.add_include ("dova-types.h");
		} else {
			header_declarations.add_include ("dova-base.h");
			source_declarations.add_include ("dova-base.h");
		}

		next_temp_var_id = 0;
		variable_name_map.clear ();

		generated_external_symbols = new HashSet<Symbol> ();


		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (!file.external_package) {
				file.accept (codegen);
			}
		}

		if (csource_filename != null) {
			var writer = new CCodeWriter (csource_filename);
			if (!writer.open (context.version_header)) {
				Report.error (null, "unable to open `%s' for writing".printf (writer.filename));
				return;
			}
			writer.line_directives = context.debug;

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
			source_type_member_definition.write (writer);
			writer.write_newline ();
			writer.close ();
		}

		source_declarations = null;
		source_type_member_definition = null;


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

			once.append (new CCodeNewline ());
			once.append (header_declarations.type_declaration);
			once.append (new CCodeNewline ());
			once.append (header_declarations.type_definition);
			once.append (new CCodeNewline ());
			once.append (header_declarations.type_member_declaration);
			once.append (new CCodeNewline ());
			once.append (header_declarations.constant_declaration);
			once.append (new CCodeNewline ());

			once.append (new CCodeNewline ());
			once.write (writer);
			writer.close ();
		}
	}

	public override void visit_source_file (SourceFile source_file) {
		if (csource_filename == null) {
			csource_filename = source_file.get_csource_filename ();
		} else {
			var writer = new CCodeWriter (source_file.get_csource_filename ());
			if (!writer.open (context.version_header)) {
				Report.error (null, "unable to open `%s' for writing".printf (writer.filename));
				return;
			}
			writer.close ();
		}

		source_file.accept_children (codegen);

		if (context.report.get_errors () > 0) {
			return;
		}
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

		decl_space.add_type_definition (cenum);
		decl_space.add_type_definition (new CCodeNewline ());
	}

	public override void visit_enum (Enum en) {
		en.accept_children (codegen);

		generate_enum_declaration (en, source_declarations);

		if (!en.is_internal_symbol ()) {
			generate_enum_declaration (en, header_declarations);
		}
	}

	public void generate_constant_declaration (Constant c, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (c, c.get_cname ())) {
			return;
		}

		c.accept_children (codegen);

		if (!c.external) {
			if (c.value is InitializerList) {
				var cdecl = new CCodeDeclaration (c.type_reference.get_const_cname ());
				var arr = "";
				if (c.type_reference is ArrayType) {
					arr = "[]";
				}
				cdecl.add_declarator (new CCodeVariableDeclarator ("%s%s".printf (c.get_cname (), arr), (CCodeExpression) c.value.ccodenode));
				cdecl.modifiers = CCodeModifiers.STATIC;

				decl_space.add_constant_declaration (cdecl);
			} else {
				var cdefine = new CCodeMacroReplacement.with_expression (c.get_cname (), (CCodeExpression) c.value.ccodenode);
				decl_space.add_type_member_declaration (cdefine);
			}
		}
	}

	public override void visit_constant (Constant c) {
		generate_constant_declaration (c, source_declarations);

		if (!c.is_internal_symbol ()) {
			generate_constant_declaration (c, header_declarations);
		}
	}

	public void generate_field_declaration (Field f, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (f, f.get_cname ())) {
			return;
		}

		generate_type_declaration (f.variable_type, decl_space);

		string field_ctype = f.variable_type.get_cname ();
		if (f.is_volatile) {
			field_ctype = "volatile " + field_ctype;
		}

		var cdecl = new CCodeDeclaration (field_ctype);
		cdecl.add_declarator (new CCodeVariableDeclarator (f.get_cname ()));
		if (f.is_internal_symbol ()) {
			cdecl.modifiers = CCodeModifiers.STATIC;
		} else {
			cdecl.modifiers = CCodeModifiers.EXTERN;
		}

		if (f.get_attribute ("ThreadLocal") != null) {
			cdecl.modifiers |= CCodeModifiers.THREAD_LOCAL;
		}

		decl_space.add_type_member_declaration (cdecl);
	}

	public override void visit_field (Field f) {
		f.accept_children (codegen);

		var cl = f.parent_symbol as Class;

		CCodeExpression lhs = null;

		string field_ctype = f.variable_type.get_cname ();
		if (f.is_volatile) {
			field_ctype = "volatile " + field_ctype;
		}

		if (f.binding == MemberBinding.INSTANCE)  {
			if (cl != null && f.is_internal_symbol ()) {
				var priv_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_PRIVATE".printf (cl.get_upper_case_cname (null))));
				priv_call.add_argument (new CCodeIdentifier ("this"));
				lhs = new CCodeMemberAccess.pointer (priv_call, f.get_cname ());
			} else {
				lhs = new CCodeMemberAccess.pointer (new CCodeIdentifier ("this"), f.get_cname ());
			}

			if (f.initializer != null) {
				var rhs = (CCodeExpression) f.initializer.ccodenode;

				instance_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (lhs, rhs)));

				append_temp_decl (instance_init_fragment, temp_vars);
				temp_vars.clear ();
			}

			if (requires_destroy (f.variable_type) && instance_finalize_fragment != null) {
				var this_access = new MemberAccess.simple ("this");
				this_access.value_type = get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);

				var field_st = f.parent_symbol as Struct;
				if (field_st != null && !field_st.is_simple_type ()) {
					this_access.ccodenode = new CCodeIdentifier ("(*this)");
				} else {
					this_access.ccodenode = new CCodeIdentifier ("this");
				}

				var ma = new MemberAccess (this_access, f.name);
				ma.symbol_reference = f;
				instance_finalize_fragment.append (new CCodeExpressionStatement (get_unref_expression (lhs, f.variable_type, ma)));
			}
		} else {
			generate_field_declaration (f, source_declarations);

			if (!f.is_internal_symbol ()) {
				generate_field_declaration (f, header_declarations);
			}

			lhs = new CCodeIdentifier (f.get_cname ());

			var var_decl = new CCodeVariableDeclarator (f.get_cname ());
			var_decl.initializer = default_value_for_type (f.variable_type, true);

			if (f.initializer != null) {
				var rhs = (CCodeExpression) f.initializer.ccodenode;

				module_init_fragment.append (new CCodeExpressionStatement (new CCodeAssignment (lhs, rhs)));

				append_temp_decl (module_init_fragment, temp_vars);
				temp_vars.clear ();
			}

			var var_def = new CCodeDeclaration (field_ctype);
			var_def.add_declarator (var_decl);
			if (!f.is_internal_symbol ()) {
				var_def.modifiers = CCodeModifiers.EXTERN;
			} else {
				var_def.modifiers = CCodeModifiers.STATIC;
			}

			if (f.get_attribute ("ThreadLocal") != null) {
				var_def.modifiers |= CCodeModifiers.THREAD_LOCAL;
			}

			source_declarations.add_type_member_declaration (var_def);
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
		p.accept_children (codegen);
	}

	public override void visit_property (Property prop) {
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
		} else if (type is PointerType) {
			var pointer_type = (PointerType) type;
			generate_type_declaration (pointer_type.base_type, decl_space);
		}

		foreach (DataType type_arg in type.get_type_arguments ()) {
			generate_type_declaration (type_arg, decl_space);
		}
	}

	public virtual void generate_struct_declaration (Struct st, CCodeDeclarationSpace decl_space) {
	}

	public virtual void generate_delegate_declaration (Delegate d, CCodeDeclarationSpace decl_space) {
	}

	public virtual void generate_cparameters (Method m, CCodeDeclarationSpace decl_space, CCodeFunction func, CCodeFunctionDeclarator? vdeclarator = null, CCodeFunctionCall? vcall = null) {
	}

	public virtual void generate_property_accessor_declaration (PropertyAccessor acc, CCodeDeclarationSpace decl_space) {
	}

	public override void visit_destructor (Destructor d) {
		d.accept_children (codegen);

		CCodeFragment cfrag = new CCodeFragment ();

		cfrag.append (d.body.ccodenode);

		d.ccodenode = cfrag;
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
		generate_type_declaration (param.variable_type, source_declarations);

		var param_type = param.variable_type.copy ();
		param_type.value_owned = true;
		data.add_field (param_type.get_cname (), get_variable_cname (param.name));

		// create copy if necessary as captured variables may need to be kept alive
		CCodeExpression cparam = get_variable_cexpression (param.name);
		if (requires_copy (param_type) && !param.variable_type.value_owned)  {
			var ma = new MemberAccess.simple (param.name);
			ma.symbol_reference = param;
			ma.value_type = param.variable_type.copy ();
			// directly access parameters in ref expressions
			param.captured = false;
			cparam = get_ref_cexpression (param.variable_type, cparam, ma, param);
			param.captured = true;
		}

		cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), get_variable_cname (param.name)), cparam)));

		if (requires_destroy (param_type)) {
			var ma = new MemberAccess.simple (param.name);
			ma.symbol_reference = param;
			ma.value_type = param_type.copy ();
			free_block.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), get_variable_cname (param.name)), param.variable_type, ma)));
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
			data.add_field ("DovaType*", "type");
			data.add_field ("int", "_ref_count_");
			if (parent_block != null) {
				int parent_block_id = get_block_id (parent_block);

				data.add_field ("Block%dData *".printf (parent_block_id), "_data%d_".printf (parent_block_id));

				var unref_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_unref"));
				unref_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "_data%d_".printf (parent_block_id)));
				free_block.add_statement (new CCodeExpressionStatement (unref_call));
			} else if ((current_method != null && current_method.binding == MemberBinding.INSTANCE) ||
			           (current_property_accessor != null && current_property_accessor.prop.binding == MemberBinding.INSTANCE)) {
				data.add_field ("%s *".printf (current_class.get_cname ()), "this");

				var ma = new MemberAccess.simple ("this");
				ma.symbol_reference = current_class;
				free_block.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "this"), new ObjectType (current_class), ma)));
			}
			foreach (var local in local_vars) {
				if (local.captured) {
					generate_type_declaration (local.variable_type, source_declarations);

					data.add_field (local.variable_type.get_cname (), get_variable_cname (local.name) + local.variable_type.get_cdeclarator_suffix ());
				}
			}
			// free in reverse order
			for (int i = local_vars.size - 1; i >= 0; i--) {
				var local = local_vars[i];
				if (local.captured) {
					if (requires_destroy (local.variable_type)) {
						var ma = new MemberAccess.simple (local.name);
						ma.symbol_reference = local;
						ma.value_type = local.variable_type.copy ();
						free_block.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), get_variable_cname (local.name)), local.variable_type, ma)));
					}
				}
			}

			var data_alloc = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_alloc"));
			data_alloc.add_argument (new CCodeFunctionCall (new CCodeIdentifier ("block%d_data_type_get".printf (block_id))));

			var data_decl = new CCodeDeclaration (struct_name + "*");
			data_decl.add_declarator (new CCodeVariableDeclarator ("_data%d_".printf (block_id), data_alloc));
			cblock.add_statement (data_decl);

			if (parent_block != null) {
				int parent_block_id = get_block_id (parent_block);

				var ref_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_ref"));
				ref_call.add_argument (get_variable_cexpression ("_data%d_".printf (parent_block_id)));

				cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "_data%d_".printf (parent_block_id)), ref_call)));
			} else if ((current_method != null && current_method.binding == MemberBinding.INSTANCE) ||
			           (current_property_accessor != null && current_property_accessor.prop.binding == MemberBinding.INSTANCE)) {
				var ref_call = new CCodeFunctionCall (get_dup_func_expression (new ObjectType (current_class), b.source_reference));
				ref_call.add_argument (new CCodeIdentifier ("this"));

				cblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "this"), ref_call)));
			}

			if (b.parent_symbol is Method) {
				var m = (Method) b.parent_symbol;

				// parameters are captured with the top-level block of the method
				foreach (var param in m.get_parameters ()) {
					if (param.captured) {
						capture_parameter (param, data, cblock, block_id, free_block);
					}
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

			var data_free = new CCodeFunctionCall (new CCodeIdentifier ("free"));
			data_free.add_argument (new CCodeIdentifier ("_data%d_".printf (block_id)));
			free_block.add_statement (new CCodeExpressionStatement (data_free));

			// create type_get/finalize functions
			var type_get_fun = new CCodeFunction ("block%d_data_type_get".printf (block_id), "DovaType*");
			type_get_fun.modifiers = CCodeModifiers.STATIC;
			source_declarations.add_type_member_declaration (type_get_fun.copy ());
			type_get_fun.block = new CCodeBlock ();

			var cdecl = new CCodeDeclaration ("int");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_block%d_data_object_offset".printf (block_id), new CCodeConstant ("0")));
			cdecl.modifiers = CCodeModifiers.STATIC;
			source_declarations.add_type_member_declaration (cdecl);

			cdecl = new CCodeDeclaration ("int");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_block%d_data_type_offset".printf (block_id), new CCodeConstant ("0")));
			cdecl.modifiers = CCodeModifiers.STATIC;
			source_declarations.add_type_member_declaration (cdecl);

			cdecl = new CCodeDeclaration ("DovaType *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("block%d_data_type".printf (block_id), new CCodeConstant ("NULL")));
			cdecl.modifiers = CCodeModifiers.STATIC;
			source_declarations.add_type_member_declaration (cdecl);

			var type_init_block = new CCodeBlock ();
			var alloc_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_alloc"));
			alloc_call.add_argument (new CCodeFunctionCall (new CCodeIdentifier ("dova_object_type_get")));
			alloc_call.add_argument (new CCodeConstant ("sizeof (%s)".printf (struct_name)));
			alloc_call.add_argument (new CCodeConstant ("0"));
			alloc_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("block%d_data_type".printf (block_id))));
			alloc_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_block%d_data_object_offset".printf (block_id))));
			alloc_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("_block%d_data_type_offset".printf (block_id))));
			type_init_block.add_statement (new CCodeExpressionStatement (alloc_call));
			var type_init_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_type_init"));
			type_init_call.add_argument (new CCodeIdentifier ("block%d_data_type".printf (block_id)));
			type_init_block.add_statement (new CCodeExpressionStatement (type_init_call));
			type_get_fun.block.add_statement (new CCodeIfStatement (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("block%d_data_type".printf (block_id))), type_init_block));
			type_get_fun.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("block%d_data_type".printf (block_id))));

			source_type_member_definition.append (type_get_fun);

			var unref_fun = new CCodeFunction ("block%d_data_finalize".printf (block_id), "void");
			unref_fun.add_parameter (new CCodeFormalParameter ("_data%d_".printf (block_id), struct_name + "*"));
			unref_fun.modifiers = CCodeModifiers.STATIC;
			source_declarations.add_type_member_declaration (unref_fun.copy ());
			unref_fun.block = free_block;

			source_type_member_definition.append (unref_fun);
		}

		foreach (CodeNode stmt in b.get_statements ()) {
			if (stmt.error) {
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

		// free in reverse order
		for (int i = local_vars.size - 1; i >= 0; i--) {
			var local = local_vars[i];
			if (!local.floating && !local.captured && requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
			}
		}

		if (b.parent_symbol is Method) {
			var m = (Method) b.parent_symbol;
			foreach (FormalParameter param in m.get_parameters ()) {
				if (!param.captured && requires_destroy (param.variable_type) && param.direction == ParameterDirection.IN) {
					var ma = new MemberAccess.simple (param.name);
					ma.symbol_reference = param;
					cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (param.name), param.variable_type, ma)));
				}
			}
		}

		if (b.captured) {
			int block_id = get_block_id (b);

			var data_unref = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_unref"));
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
		return new CCodeIdentifier (get_variable_cname (name));
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
		local.accept_children (codegen);

		generate_type_declaration (local.variable_type, source_declarations);

		CCodeExpression rhs = null;
		if (local.initializer != null && local.initializer.ccodenode != null) {
			rhs = (CCodeExpression) local.initializer.ccodenode;
		}

		var cfrag = new CCodeFragment ();

		if (pre_statement_fragment != null) {
			cfrag.append (pre_statement_fragment);
			pre_statement_fragment = null;
		}

		if (local.captured) {
			if (local.initializer != null) {
				cfrag.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id ((Block) local.parent_symbol))), get_variable_cname (local.name)), rhs)));
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
				cvar.init0 = true;
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

	public CCodeExpression get_type_private_from_type (ObjectTypeSymbol type_symbol, CCodeExpression type_expression) {
		if (type_symbol is Class) {
			// class
			return new CCodeCastExpression (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeCastExpression (type_expression, "char *"), new CCodeIdentifier ("_%s_type_offset".printf (((Class) type_symbol).get_lower_case_cname ()))), "%sTypePrivate *".printf (((Class) type_symbol).get_cname ()));
		} else {
			// interface
			var get_interface = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_get_interface"));
			get_interface.add_argument (type_expression);
			get_interface.add_argument (new CCodeIdentifier ("%s_type".printf (((Interface) type_symbol).get_lower_case_cname ())));
			return new CCodeCastExpression (get_interface, "%sTypePrivate *".printf (((Interface) type_symbol).get_cname ()));
		}
	}

	public CCodeExpression get_type_id_expression (DataType type, bool is_chainup = false) {
		if (type is GenericType) {
			string var_name = "%s_type".printf (type.type_parameter.name.down ());
			if (is_in_generic_type (type) && !is_chainup) {
				return new CCodeMemberAccess.pointer (get_type_private_from_type ((ObjectTypeSymbol) type.type_parameter.parent_symbol, new CCodeMemberAccess.pointer (new CCodeIdentifier ("this"), "type")), var_name);
			} else {
				return new CCodeIdentifier (var_name);
			}
		} else {
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_get".printf (type.data_type.get_lower_case_cname ())));
			var object_type_symbol = type.data_type as ObjectTypeSymbol;
			if (object_type_symbol != null) {
				for (int i = 0; i < object_type_symbol.get_type_parameters ().size; i++) {
					if (type.get_type_arguments ().size == 0) {
						ccall.add_argument (new CCodeConstant ("NULL"));
					} else {
						ccall.add_argument (get_type_id_expression (type.get_type_arguments ().get (i)));
					}
				}
			}
			return ccall;
		}
	}

	public virtual CCodeExpression? get_dup_func_expression (DataType type, SourceReference? source_reference, bool is_chainup = false) {
		if (type.data_type != null) {
			string dup_function = "";
			if (type.data_type.is_reference_counting ()) {
				dup_function = type.data_type.get_ref_function ();
			} else if (type is ValueType) {
				dup_function = type.data_type.get_dup_function ();
				if (dup_function == null) {
					dup_function = "";
				}
			}

			return new CCodeIdentifier (dup_function);
		} else if (type.type_parameter != null) {
			return null;
		} else if (type is ArrayType) {
			return new CCodeIdentifier ("dova_object_ref");
		} else if (type is DelegateType) {
			return new CCodeIdentifier ("dova_object_ref");
		} else if (type is PointerType) {
			var pointer_type = (PointerType) type;
			return get_dup_func_expression (pointer_type.base_type, source_reference);
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	public CCodeExpression? get_destroy_func_expression (DataType type, bool is_chainup = false) {
		if (type.data_type != null) {
			string unref_function;
			if (type is ReferenceType) {
				if (type.data_type.is_reference_counting ()) {
					unref_function = type.data_type.get_unref_function ();
				} else {
					unref_function = type.data_type.get_free_function ();
				}
			} else {
				if (type.nullable) {
					unref_function = type.data_type.get_free_function ();
					if (unref_function == null) {
						unref_function = "free";
					}
				} else {
					var st = (Struct) type.data_type;
					unref_function = st.get_copy_function ();
				}
			}
			if (unref_function == null) {
				return new CCodeConstant ("NULL");
			}
			return new CCodeIdentifier (unref_function);
		} else if (type.type_parameter != null && current_type_symbol is Class) {
			// FIXME ask type for dup/ref function
			return new CCodeIdentifier ("dova_object_unref");
		} else if (type is ArrayType) {
			return new CCodeIdentifier ("dova_object_unref");
		} else if (type is DelegateType) {
			return new CCodeIdentifier ("dova_object_unref");
		} else if (type is PointerType) {
			return new CCodeIdentifier ("free");
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	public virtual CCodeExpression get_unref_expression (CCodeExpression cvar, DataType type, Expression? expr = null) {
		var ccall = new CCodeFunctionCall (get_destroy_func_expression (type));

		if (type is ValueType && !type.nullable) {
			// normal value type, no null check
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cvar));
			ccall.add_argument (new CCodeConstant ("0"));
			ccall.add_argument (new CCodeConstant ("NULL"));
			ccall.add_argument (new CCodeConstant ("0"));

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

		ccomma.append_expression (ccall);
		ccomma.append_expression (new CCodeConstant ("NULL"));

		var cassign = new CCodeAssignment (cvar, ccomma);

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
			} else if (local.variable_type is GenericType) {
				var value_size = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_get_value_size"));
				value_size.add_argument (get_type_id_expression (local.variable_type));

				var alloca_call = new CCodeFunctionCall (new CCodeIdentifier ("alloca"));
				alloca_call.add_argument (value_size);

				var memset_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
				memset_call.add_argument (alloca_call);
				memset_call.add_argument (new CCodeConstant ("0"));
				memset_call.add_argument (value_size);

				vardecl.initializer = memset_call;
				vardecl.init0 = true;
			} else if (!local.variable_type.nullable &&
			           (st != null && st.get_fields ().size > 0) ||
			           (array_type != null && array_type.fixed_length)) {
				// 0-initialize struct with struct initializer { 0 }
				// necessary as they will be passed by reference
				var clist = new CCodeInitializerList ();
				clist.append (new CCodeConstant ("0"));

				vardecl.initializer = clist;
				vardecl.init0 = true;
			} else if (local.variable_type.is_reference_type_or_type_parameter () ||
			       local.variable_type.nullable) {
				vardecl.initializer = new CCodeConstant ("NULL");
				vardecl.init0 = true;
			}

			cfrag.append (cdecl);
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

		if (((List<LocalVariable>) temp_vars).size == 0
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
		// free in reverse order
		for (int i = local_vars.size - 1; i >= 0; i--) {
			var local = local_vars[i];
			if (local.active && !local.floating && !local.captured && requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				cfrag.append (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
			}
		}

		if (b.captured) {
			int block_id = get_block_id (b);

			var data_unref = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_unref"));
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
		// free in reverse order
		for (int i = local_vars.size - 1; i >= 0; i--) {
			var local = local_vars[i];
			if (local.active && !local.floating && !local.captured && requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				cfrag.append (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
			}
		}

		if (b.captured) {
			int block_id = get_block_id (b);

			var data_unref = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_unref"));
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
			if (requires_destroy (param.variable_type) && param.direction == ParameterDirection.IN) {
				var ma = new MemberAccess.simple (param.name);
				ma.symbol_reference = param;
				cfrag.append (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (param.name), param.variable_type, ma)));
			}
		}
	}

	public void create_local_free (CodeNode stmt, bool stop_at_loop = false) {
		var cfrag = new CCodeFragment ();

		append_local_free (current_symbol, cfrag, stop_at_loop);

		cfrag.append (stmt.ccodenode);
		stmt.ccodenode = cfrag;
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		stmt.accept_children (codegen);

		var cfrag = new CCodeFragment ();

		// free local variables
		append_local_free (current_symbol, cfrag);

		cfrag.append (new CCodeReturnStatement ((current_return_type is VoidType) ? null : new CCodeIdentifier ("result")));

		stmt.ccodenode = cfrag;
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
			// memory management, implicit casts, and boxing/unboxing
			expr.ccodenode = transform_expression ((CCodeExpression) expr.ccodenode, expr.value_type, expr.target_type, expr);
		}
	}

	public override void visit_boolean_literal (BooleanLiteral expr) {
		expr.ccodenode = new CCodeConstant (expr.value ? "true" : "false");
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
		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("string_create_from_cstring"));
		// FIXME handle escaped characters in scanner/parser and escape them here again for C
		ccall.add_argument (new CCodeConstant (expr.value));

		expr.ccodenode = ccall;
	}

	public override void visit_null_literal (NullLiteral expr) {
		expr.ccodenode = new CCodeConstant ("NULL");
	}

	public override void visit_base_access (BaseAccess expr) {
		generate_type_declaration (expr.value_type, source_declarations);
		expr.ccodenode = new CCodeCastExpression (new CCodeIdentifier ("this"), expr.value_type.get_cname ());
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
			return false;
		}

		return true;
	}

	public bool requires_destroy (DataType type) {
		if (!type.is_disposable ()) {
			return false;
		}

		var array_type = type as ArrayType;
		if (array_type != null && array_type.inline_allocated) {
			return requires_destroy (array_type.element_type);
		}

		var cl = type.data_type as Class;
		if (cl != null && cl.is_reference_counting ()
		    && cl.get_unref_function () == "") {
			// empty unref_function => no unref necessary
			return false;
		}

		if (type.type_parameter != null) {
			return false;
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
			// (copy (&temp, 0, &expr, 0), temp)

			var decl = get_temp_variable (expression_type, false, node);
			temp_vars.insert (0, decl);

			var ctemp = get_variable_cexpression (decl.name);

			var vt = (ValueType) expression_type;
			var st = (Struct) vt.type_symbol;
			var copy_call = new CCodeFunctionCall (new CCodeIdentifier (st.get_copy_function ()));
			copy_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
			copy_call.add_argument (new CCodeConstant ("0"));
			copy_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr));
			copy_call.add_argument (new CCodeConstant ("0"));

			var ccomma = new CCodeCommaExpression ();

			ccomma.append_expression (copy_call);
			ccomma.append_expression (ctemp);

			return ccomma;
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

		if (expr != null && expr.is_non_null ()
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
				// dup functions are optional for type parameters
				var cdupisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, get_dup_func_expression (expression_type, node.source_reference), new CCodeConstant ("NULL"));
				cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cisnull, cdupisnull);
			}

			ccall.add_argument (ctemp);

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (ctemp, cexpr));

			var cifnull = new CCodeConstant ("NULL");
			ccomma.append_expression (new CCodeConditionalExpression (cisnull, cifnull, ccall));

			// repeat temp variable at the end of the comma expression
			// if the ref function returns void
			if (is_ref_function_void (expression_type)) {
				ccomma.append_expression (ctemp);
			}

			return ccomma;
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

	public void add_generic_type_arguments (CCodeFunctionCall ccall, List<DataType> type_args, CodeNode expr, bool is_chainup = false) {
		foreach (var type_arg in type_args) {
			ccall.add_argument (get_type_id_expression (type_arg, is_chainup));
		}
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		expr.accept_children (codegen);

		CCodeExpression instance = null;
		CCodeExpression creation_expr = null;

		var st = expr.type_reference.data_type as Struct;

		bool struct_by_ref = false;
		if (st != null && !st.is_boolean_type () && !st.is_integer_type () && !st.is_floating_type ()) {
			struct_by_ref = true;
		}

		if (struct_by_ref || expr.get_object_initializer ().size > 0) {
			// value-type initialization or object creation expression with object initializer
			var temp_decl = get_temp_variable (expr.type_reference, false, expr);
			temp_vars.add (temp_decl);

			instance = get_variable_cexpression (get_variable_cname (temp_decl.name));
		}

		if (expr.symbol_reference == null) {
			// no creation method
			if (expr.type_reference.data_type is Struct) {
				var creation_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
				creation_call.add_argument (new CCodeConstant ("0"));
				creation_call.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (expr.type_reference.get_cname ())));

				creation_expr = creation_call;
			}
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

			if (struct_by_ref && !(m.cinstance_parameter_position < 0)) {
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
			}

			generate_type_declaration (expr.type_reference, source_declarations);

			if (cl != null && !cl.is_compact) {
				add_generic_type_arguments (creation_call, expr.type_reference.get_type_arguments (), expr);
			}

			bool ellipsis = false;

			int i = 1;
			Iterator<FormalParameter> params_it = params.iterator ();
			foreach (Expression arg in expr.get_argument_list ()) {
				CCodeExpression cexpr = (CCodeExpression) arg.ccodenode;
				FormalParameter param = null;
				if (params_it.next ()) {
					param = params_it.get ();
					ellipsis = param.ellipsis;
					if (!ellipsis) {
						cexpr = handle_struct_argument (param, arg, cexpr);
					}
				}

				creation_call.add_argument (cexpr);

				i++;
			}
			while (params_it.next ()) {
				var param = params_it.get ();

				if (param.ellipsis) {
					ellipsis = true;
					break;
				}

				if (param.initializer == null) {
					Report.error (expr.source_reference, "no default expression for argument %d".printf (i));
					return;
				}

				/* evaluate default expression here as the code
				 * generator might not have visited the formal
				 * parameter yet */
				param.initializer.accept (codegen);

				creation_call.add_argument ((CCodeExpression) param.initializer.ccodenode);
				i++;
			}

			if (struct_by_ref && m.cinstance_parameter_position < 0) {
				// instance parameter is at the end in a struct creation method
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
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
		if (arg.formal_target_type is GenericType && !(arg.target_type is GenericType)) {
			// we already use a reference for arguments of ref and out parameters
			if (param.direction == ParameterDirection.IN) {
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

					var temp_var = get_temp_variable (arg.target_type);
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
		if (expr.is_silent_cast) {
			expr.error = true;
			Report.error (expr.source_reference, "Operation not supported for this type");
			return;
		}

		if (expr.type_reference.data_type != null && expr.type_reference.data_type.get_full_name () == "Dova.Value") {
			// box value
			var temp_decl = get_temp_variable (expr.inner.value_type, true, expr);
			temp_vars.insert (0, temp_decl);
			var cvar = get_variable_cexpression (temp_decl.name);

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (cvar, (CCodeExpression) expr.inner.ccodenode));

			var to_any  = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_value_to_any"));
			to_any.add_argument (get_type_id_expression (expr.inner.value_type));
			to_any.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cvar));
			to_any.add_argument (new CCodeConstant ("0"));
			ccomma.append_expression (to_any);

			expr.ccodenode = ccomma;
			return;
		} else if (expr.inner.value_type.data_type != null && expr.inner.value_type.data_type.get_full_name () == "Dova.Value") {
			// unbox value
			var temp_decl = get_temp_variable (expr.type_reference, true, expr);
			temp_vars.insert (0, temp_decl);
			var cvar = get_variable_cexpression (temp_decl.name);

			var ccomma = new CCodeCommaExpression ();

			var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_call.add_argument (new CCodeIdentifier (expr.type_reference.get_cname ()));

			var to_any  = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_value_from_any"));
			to_any.add_argument (get_type_id_expression (expr.type_reference));
			to_any.add_argument ((CCodeExpression) expr.inner.ccodenode);
			to_any.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cvar));
			to_any.add_argument (new CCodeConstant ("0"));
			ccomma.append_expression (to_any);

			ccomma.append_expression (cvar);

			expr.ccodenode = ccomma;
			return;
		}

		generate_type_declaration (expr.type_reference, source_declarations);

		if (expr.inner.value_type is GenericType && !(expr.type_reference is GenericType)) {
			// generic types use an extra pointer, dereference that pointer
			expr.ccodenode = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeCastExpression ((CCodeExpression) expr.inner.ccodenode, expr.type_reference.get_cname () + "*"));
		} else {
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
						cleft = generate_instance_cast (cleft, right_cl);
					} else if (right_cl.is_subtype_of (left_cl)) {
						cright = generate_instance_cast (cright, left_cl);
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

		expr.ccodenode = new CCodeBinaryExpression (op, cleft, cright);
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
		string type_check_func = get_type_check_function (type.data_type);
		if (type_check_func == null) {
			return new CCodeInvalidExpression ();
		}
		var ccheck = new CCodeFunctionCall (new CCodeIdentifier (type_check_func));
		ccheck.add_argument ((CCodeExpression) ccodenode);
		return ccheck;
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

	// manage memory and implicit casts
	public CCodeExpression transform_expression (CCodeExpression source_cexpr, DataType? expression_type, DataType? target_type, Expression? expr = null) {
		var cexpr = source_cexpr;
		if (expression_type == null) {
			return cexpr;
		}


		if (expression_type.value_owned
		    && (target_type == null || !target_type.value_owned)) {
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
			}
		}

		if (target_type == null) {
			// value will be destroyed, no need for implicit casts
			return cexpr;
		}

		cexpr = get_implicit_cast_expression (cexpr, expression_type, target_type, expr);

		if (target_type.value_owned && !expression_type.value_owned) {
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

		if (target_type is DelegateType && expression_type is MethodType) {
			var deleg_type = (DelegateType) target_type;
			var method_type = (MethodType) expression_type;
			CCodeExpression delegate_target;
			if (expr is LambdaExpression) {
				var lambda = (LambdaExpression) expr;
				if (lambda.method.closure) {
					int block_id = get_block_id (current_closure_block);
					delegate_target = get_variable_cexpression ("_data%d_".printf (block_id));
				} else if (get_this_type () != null) {
					delegate_target = new CCodeIdentifier ("this");
				} else {
					delegate_target = new CCodeConstant ("NULL");
				}
			} else {
				if (method_type.method_symbol.binding == MemberBinding.INSTANCE) {
					var ma = (MemberAccess) expr;
					delegate_target = (CCodeExpression) get_ccodenode (ma.inner);
				} else {
					delegate_target = new CCodeConstant ("NULL");
				}
			}

			var d = deleg_type.delegate_symbol;

			string wrapper_name = "_wrapper%d_".printf (next_wrapper_id++);
			var wrapper = new CCodeFunction (wrapper_name);
			wrapper.modifiers = CCodeModifiers.STATIC;
			var call = new CCodeFunctionCall (source_cexpr);

			if (method_type.method_symbol.binding == MemberBinding.INSTANCE) {
				wrapper.add_parameter (new CCodeFormalParameter ("this", "void *"));
				call.add_argument (new CCodeIdentifier ("this"));
			}

			var method_param_iter = method_type.method_symbol.get_parameters ().iterator ();
			foreach (FormalParameter param in d.get_parameters ()) {
				method_param_iter.next ();
				var method_param = method_param_iter.get ();
				string ctype = param.variable_type.get_cname ();
				if (param.variable_type is GenericType && !(method_param.variable_type is GenericType)) {
					ctype = method_param.variable_type.get_cname () + "*";
					call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (param.name)));
				} else if (!(param.variable_type is GenericType) && method_param.variable_type is GenericType) {
					call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
				} else {
					call.add_argument (new CCodeIdentifier (param.name));
				}

				wrapper.add_parameter (new CCodeFormalParameter (param.name, ctype));
			}

			wrapper.block = new CCodeBlock ();
			if (d.return_type is VoidType) {
				wrapper.block.add_statement (new CCodeExpressionStatement (call));
			} else {
				var method_return_type = method_type.method_symbol.return_type;
				if (d.return_type is GenericType && !(method_return_type is GenericType)) {
					wrapper.add_parameter (new CCodeFormalParameter ("result", method_return_type.get_cname () + "*"));
					wrapper.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("result")), call)));
				} else if (!(d.return_type is GenericType) && method_return_type is GenericType) {
					wrapper.return_type = d.return_type.get_cname ();
					var cdecl = new CCodeDeclaration (d.return_type.get_cname ());
					cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
					call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
					wrapper.block.add_statement (new CCodeExpressionStatement (call));
					wrapper.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));
				} else if (d.return_type is GenericType) {
					wrapper.add_parameter (new CCodeFormalParameter ("result", "void *"));
					wrapper.block.add_statement (new CCodeExpressionStatement (call));
				} else {
					wrapper.return_type = d.return_type.get_cname ();
					wrapper.block.add_statement (new CCodeReturnStatement (call));
				}
			}

			source_type_member_definition.append (wrapper);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_new".printf (deleg_type.delegate_symbol.get_lower_case_cname ())));
			ccall.add_argument (delegate_target);
			ccall.add_argument (new CCodeIdentifier (wrapper_name));
			return ccall;
		}

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

	public CCodeFunctionCall get_property_set_call (Property prop, MemberAccess ma, CCodeExpression cexpr, Expression? rhs = null) {
		string set_func;

		var base_property = prop;
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

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (set_func));

		if (prop.binding == MemberBinding.INSTANCE) {
			/* target instance is first argument */
			ccall.add_argument ((CCodeExpression) get_ccodenode (ma.inner));
		}

		ccall.add_argument (cexpr);

		return ccall;
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
		} else {
			Report.error (null, "internal error: `%s' is not a supported type".printf (sym.get_full_name ()));
			return new InvalidType ();
		}

		return type;
	}

	public CCodeExpression? default_value_for_type (DataType type, bool initializer_expression) {
		var st = type.data_type as Struct;
		var array_type = type as ArrayType;
		if (type is GenericType) {
			var value_size = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_get_value_size"));
			value_size.add_argument (get_type_id_expression (type));

			var alloca_call = new CCodeFunctionCall (new CCodeIdentifier ("alloca"));
			alloca_call.add_argument (value_size);

			var memset_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
			memset_call.add_argument (alloca_call);
			memset_call.add_argument (new CCodeConstant ("0"));
			memset_call.add_argument (value_size);

			return memset_call;
		} else if (initializer_expression && !type.nullable &&
		    ((st != null && st.get_fields ().size > 0) ||
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
		}
		return null;
	}

	public CCodeNode? get_ccodenode (CodeNode node) {
		if (node.ccodenode == null) {
			node.accept (codegen);
		}
		return node.ccodenode;
	}

	public override void visit_class (Class cl) {
	}

	public DataType? get_this_type () {
		if (current_method != null && current_method.binding == MemberBinding.INSTANCE) {
			return current_method.this_parameter.variable_type;
		} else if (current_property_accessor != null && current_property_accessor.prop.binding == MemberBinding.INSTANCE) {
			return current_property_accessor.prop.this_parameter.variable_type;
		}
		return null;
	}

	public CCodeExpression generate_instance_cast (CCodeExpression expr, TypeSymbol type) {
		return new CCodeCastExpression (expr, type.get_cname () + "*");
	}
}
