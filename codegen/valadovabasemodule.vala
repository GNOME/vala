/* valadovabasemodule.vala
 *
 * Copyright (C) 2006-2011  Jürg Billeter
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
public abstract class Vala.DovaBaseModule : CodeGenerator {
	public class EmitContext {
		public Symbol? current_symbol;
		public ArrayList<Symbol> symbol_stack = new ArrayList<Symbol> ();
		public TryStatement current_try;
		public CCodeFunction ccode;
		public ArrayList<CCodeFunction> ccode_stack = new ArrayList<CCodeFunction> ();
		public ArrayList<LocalVariable> temp_ref_vars = new ArrayList<LocalVariable> ();
		public int next_temp_var_id;
		public Map<string,string> variable_name_map = new HashMap<string,string> (str_hash, str_equal);

		public EmitContext (Symbol? symbol = null) {
			current_symbol = symbol;
		}

		public void push_symbol (Symbol symbol) {
			symbol_stack.add (current_symbol);
			current_symbol = symbol;
		}

		public void pop_symbol () {
			current_symbol = symbol_stack[symbol_stack.size - 1];
			symbol_stack.remove_at (symbol_stack.size - 1);
		}
	}

	public CodeContext context { get; set; }

	public Symbol root_symbol;

	public EmitContext emit_context = new EmitContext ();

	List<EmitContext> emit_context_stack = new ArrayList<EmitContext> ();

	public Symbol current_symbol { get { return emit_context.current_symbol; } }

	public TryStatement current_try {
		get { return emit_context.current_try; }
		set { emit_context.current_try = value; }
	}

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

	public CCodeFile header_file;
	public CCodeFile cfile;

	string? csource_filename;

	public CCodeFunction ccode { get { return emit_context.ccode; } }

	/* temporary variables that own their content */
	public ArrayList<LocalVariable> temp_ref_vars { get { return emit_context.temp_ref_vars; } }
	/* (constant) hash table with all reserved identifiers in the generated code */
	Set<string> reserved_identifiers;

	public List<Field> static_fields = new ArrayList<Field> ();

	public int next_temp_var_id {
		get { return emit_context.next_temp_var_id; }
		set { emit_context.next_temp_var_id = value; }
	}

	public int next_wrapper_id = 0;
	public bool in_creation_method { get { return current_method is CreationMethod; } }
	int next_block_id = 0;
	Map<Block,int> block_map = new HashMap<Block,int> ();

	public DataType void_type = new VoidType ();
	public DataType bool_type;
	public DataType char_type;
	public DataType int_type;
	public DataType uint_type;
	public DataType string_type;
	public Class object_class;
	public Class type_class;
	public Class value_class;
	public Class string_class;
	public Struct array_struct;
	public Class delegate_class;
	public Class error_class;

	Set<Symbol> generated_external_symbols;

	public Map<string,string> variable_name_map { get { return emit_context.variable_name_map; } }

	public DovaBaseModule () {
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
		int_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int"));
		uint_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint"));
		string_type = new ObjectType ((Class) root_symbol.scope.lookup ("string"));

		var dova_ns = (Namespace) root_symbol.scope.lookup ("Dova");
		object_class = (Class) dova_ns.scope.lookup ("Object");
		type_class = (Class) dova_ns.scope.lookup ("Type");
		value_class = (Class) dova_ns.scope.lookup ("Value");
		string_class = (Class) root_symbol.scope.lookup ("string");
		array_struct = (Struct) dova_ns.scope.lookup ("Array");
		delegate_class = (Class) dova_ns.scope.lookup ("Delegate");
		error_class = (Class) dova_ns.scope.lookup ("Error");

		header_file = new CCodeFile ();
		header_file.is_header = true;

		cfile = new CCodeFile ();

		if (context.nostdpkg) {
			header_file.add_include ("dova-types.h");
			cfile.add_include ("dova-types.h");
		} else {
			header_file.add_include ("dova-base.h");
			cfile.add_include ("dova-base.h");
		}

		generated_external_symbols = new HashSet<Symbol> ();


		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (file.file_type == SourceFileType.SOURCE) {
				file.accept (this);
			}
		}

		if (csource_filename != null) {
			if (!cfile.store (csource_filename, null, context.version_header, context.debug)) {
				Report.error (null, "unable to open `%s' for writing".printf (csource_filename));
			}
		}

		cfile = null;


		// generate C header file for public API
		if (context.header_filename != null) {
			if (!header_file.store (context.header_filename, null, context.version_header, false)) {
				Report.error (null, "unable to open `%s' for writing".printf (context.header_filename));
			}
		}
	}

	public void push_context (EmitContext emit_context) {
		if (this.emit_context != null) {
			emit_context_stack.add (this.emit_context);
		}

		this.emit_context = emit_context;
	}

	public void pop_context () {
		if (emit_context_stack.size > 0) {
			this.emit_context = emit_context_stack[emit_context_stack.size - 1];
			emit_context_stack.remove_at (emit_context_stack.size - 1);
		} else {
			this.emit_context = null;
		}
	}

	public void push_function (CCodeFunction func) {
		emit_context.ccode_stack.add (ccode);
		emit_context.ccode = func;
	}

	public void pop_function () {
		emit_context.ccode = emit_context.ccode_stack[emit_context.ccode_stack.size - 1];
		emit_context.ccode_stack.remove_at (emit_context.ccode_stack.size - 1);
	}

	public bool add_symbol_declaration (CCodeFile decl_space, Symbol sym, string name) {
		if (decl_space.add_declaration (name)) {
			return true;
		}
		if (sym.external_package || (!decl_space.is_header && CodeContext.get ().use_header && !sym.is_internal_symbol ())) {
			// add appropriate include file
			foreach (string header_filename in CCodeBaseModule.get_ccode_header_filenames (sym).split (",")) {
				decl_space.add_include (header_filename, !sym.external_package);
			}
			// declaration complete
			return true;
		} else {
			// require declaration
			return false;
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

		source_file.accept_children (this);

		if (context.report.get_errors () > 0) {
			return;
		}
	}

	public void generate_enum_declaration (Enum en, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, en, get_ccode_name (en))) {
			return;
		}

		var cenum = new CCodeEnum (get_ccode_name (en));

		foreach (EnumValue ev in en.get_values ()) {
			if (ev.value == null) {
				cenum.add_value (new CCodeEnumValue (get_ccode_name (ev)));
			} else {
				ev.value.emit (this);
				cenum.add_value (new CCodeEnumValue (get_ccode_name (ev), get_cvalue (ev.value)));
			}
		}

		decl_space.add_type_definition (cenum);
		decl_space.add_type_definition (new CCodeNewline ());
	}

	public override void visit_enum (Enum en) {
		en.accept_children (this);

		generate_enum_declaration (en, cfile);

		if (!en.is_internal_symbol ()) {
			generate_enum_declaration (en, header_file);
		}
	}

	public void generate_constant_declaration (Constant c, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, c, get_ccode_name (c))) {
			return;
		}

		if (!c.external) {
			c.value.emit (this);

			if (c.value is InitializerList) {
				var cdecl = new CCodeDeclaration (get_ccode_const_name (c.type_reference));
				var arr = "";
				if (c.type_reference is ArrayType) {
					arr = "[]";
				}
				cdecl.add_declarator (new CCodeVariableDeclarator ("%s%s".printf (get_ccode_name (c), arr), get_cvalue (c.value)));
				cdecl.modifiers = CCodeModifiers.STATIC;

				decl_space.add_constant_declaration (cdecl);
			} else {
				var cdefine = new CCodeMacroReplacement.with_expression (get_ccode_name (c), get_cvalue (c.value));
				decl_space.add_type_member_declaration (cdefine);
			}
		}
	}

	public override void visit_constant (Constant c) {
		generate_constant_declaration (c, cfile);

		if (!c.is_internal_symbol ()) {
			generate_constant_declaration (c, header_file);
		}
	}

	public void generate_field_declaration (Field f, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, f, get_ccode_name (f))) {
			return;
		}

		generate_type_declaration (f.variable_type, decl_space);

		string field_ctype = get_ccode_name (f.variable_type);
		if (f.is_volatile) {
			field_ctype = "volatile " + field_ctype;
		}

		var cdecl = new CCodeDeclaration (field_ctype);
		cdecl.add_declarator (new CCodeVariableDeclarator (get_ccode_name (f)));
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
		if (f.binding == MemberBinding.STATIC)  {
			generate_field_declaration (f, cfile);

			if (!f.is_internal_symbol ()) {
				generate_field_declaration (f, header_file);
			}

			var var_decl = new CCodeVariableDeclarator (get_ccode_name (f));
			var_decl.initializer = default_value_for_type (f.variable_type, true);

			if (f.initializer != null) {
				static_fields.add (f);
			}

			string field_ctype = get_ccode_name (f.variable_type);
			if (f.is_volatile) {
				field_ctype = "volatile " + field_ctype;
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

			cfile.add_type_member_declaration (var_def);
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

	public override void visit_formal_parameter (Parameter p) {
	}

	public override void visit_property (Property prop) {
		if (prop.get_accessor != null) {
			prop.get_accessor.accept (this);
		}
		if (prop.set_accessor != null) {
			prop.set_accessor.accept (this);
		}
	}

	public void generate_type_declaration (DataType type, CCodeFile decl_space) {
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
			generate_struct_declaration (array_struct, decl_space);
			generate_type_declaration (array_type.element_type, decl_space);
		} else if (type is PointerType) {
			var pointer_type = (PointerType) type;
			generate_type_declaration (pointer_type.base_type, decl_space);
		}

		foreach (DataType type_arg in type.get_type_arguments ()) {
			generate_type_declaration (type_arg, decl_space);
		}
	}

	public virtual void generate_struct_declaration (Struct st, CCodeFile decl_space) {
	}

	public virtual void generate_delegate_declaration (Delegate d, CCodeFile decl_space) {
	}

	public virtual void generate_cparameters (Method m, CCodeFile decl_space, CCodeFunction func, CCodeFunctionDeclarator? vdeclarator = null, CCodeFunctionCall? vcall = null) {
	}

	public virtual void generate_property_accessor_declaration (PropertyAccessor acc, CCodeFile decl_space) {
	}

	public int get_block_id (Block b) {
		int result = block_map[b];
		if (result == 0) {
			result = ++next_block_id;
			block_map[b] = result;
		}
		return result;
	}

	void capture_parameter (Parameter param, CCodeStruct data, int block_id, CCodeBlock free_block) {
		generate_type_declaration (param.variable_type, cfile);

		var param_type = param.variable_type.copy ();
		param_type.value_owned = true;
		data.add_field (get_ccode_name (param_type), get_variable_cname (param.name));

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

		ccode.add_assignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), get_variable_cname (param.name)), cparam);

		if (requires_destroy (param_type)) {
			var ma = new MemberAccess.simple (param.name);
			ma.symbol_reference = param;
			ma.value_type = param_type.copy ();
			free_block.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), get_variable_cname (param.name)), param.variable_type, ma)));
		}
	}

	public override void visit_block (Block b) {
		emit_context.push_symbol (b);

		var local_vars = b.get_local_variables ();

		if (b.parent_node is Block || b.parent_node is SwitchStatement) {
			ccode.open_block ();
		}

		if (b.captured) {
			var parent_block = next_closure_block (b.parent_symbol);

			int block_id = get_block_id (b);
			string struct_name = "Block%dData".printf (block_id);

			var free_block = new CCodeBlock ();

			var data = new CCodeStruct ("_" + struct_name);
			data.add_field ("DovaType*", "type");
			data.add_field ("int32_t", "_ref_count_");
			if (parent_block != null) {
				int parent_block_id = get_block_id (parent_block);

				data.add_field ("Block%dData *".printf (parent_block_id), "_data%d_".printf (parent_block_id));

				var unref_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_unref"));
				unref_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "_data%d_".printf (parent_block_id)));
				free_block.add_statement (new CCodeExpressionStatement (unref_call));
			} else if ((current_method != null && current_method.binding == MemberBinding.INSTANCE) ||
			           (current_property_accessor != null && current_property_accessor.prop.binding == MemberBinding.INSTANCE)) {
				data.add_field ("%s *".printf (get_ccode_name (current_class)), "this");

				var ma = new MemberAccess.simple ("this");
				ma.symbol_reference = current_class;
				free_block.add_statement (new CCodeExpressionStatement (get_unref_expression (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "this"), new ObjectType (current_class), ma)));
			}
			foreach (var local in local_vars) {
				if (local.captured) {
					generate_type_declaration (local.variable_type, cfile);

					data.add_field (get_ccode_name (local.variable_type), get_variable_cname (local.name) + get_ccode_declarator_suffix (local.variable_type));
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
			ccode.add_statement (data_decl);

			if (parent_block != null) {
				int parent_block_id = get_block_id (parent_block);

				var ref_call = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_ref"));
				ref_call.add_argument (get_variable_cexpression ("_data%d_".printf (parent_block_id)));

				ccode.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "_data%d_".printf (parent_block_id)), ref_call)));
			} else if ((current_method != null && current_method.binding == MemberBinding.INSTANCE) ||
			           (current_property_accessor != null && current_property_accessor.prop.binding == MemberBinding.INSTANCE)) {
				var ref_call = new CCodeFunctionCall (get_dup_func_expression (new ObjectType (current_class), b.source_reference));
				ref_call.add_argument (new CCodeIdentifier ("this"));

				ccode.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "this"), ref_call)));
			}

			if (b.parent_symbol is Method) {
				var m = (Method) b.parent_symbol;

				// parameters are captured with the top-level block of the method
				foreach (var param in m.get_parameters ()) {
					if (param.captured) {
						capture_parameter (param, data, block_id, free_block);
					}
				}
			} else if (b.parent_symbol is PropertyAccessor) {
				var acc = (PropertyAccessor) b.parent_symbol;

				if (!acc.readable && acc.value_parameter.captured) {
					capture_parameter (acc.value_parameter, data, block_id, free_block);
				}
			}

			var typedef = new CCodeTypeDefinition ("struct _" + struct_name, new CCodeVariableDeclarator (struct_name));
			cfile.add_type_declaration (typedef);
			cfile.add_type_definition (data);

			var data_free = new CCodeFunctionCall (new CCodeIdentifier ("free"));
			data_free.add_argument (new CCodeIdentifier ("_data%d_".printf (block_id)));
			free_block.add_statement (new CCodeExpressionStatement (data_free));

			// create type_get/finalize functions
			var type_get_fun = new CCodeFunction ("block%d_data_type_get".printf (block_id), "DovaType*");
			type_get_fun.modifiers = CCodeModifiers.STATIC;
			cfile.add_function_declaration (type_get_fun);
			type_get_fun.block = new CCodeBlock ();

			var cdecl = new CCodeDeclaration ("intptr_t");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_block%d_data_object_offset".printf (block_id), new CCodeConstant ("0")));
			cdecl.modifiers = CCodeModifiers.STATIC;
			cfile.add_type_member_declaration (cdecl);

			cdecl = new CCodeDeclaration ("intptr_t");
			cdecl.add_declarator (new CCodeVariableDeclarator ("_block%d_data_type_offset".printf (block_id), new CCodeConstant ("0")));
			cdecl.modifiers = CCodeModifiers.STATIC;
			cfile.add_type_member_declaration (cdecl);

			cdecl = new CCodeDeclaration ("DovaType *");
			cdecl.add_declarator (new CCodeVariableDeclarator ("block%d_data_type".printf (block_id), new CCodeConstant ("NULL")));
			cdecl.modifiers = CCodeModifiers.STATIC;
			cfile.add_type_member_declaration (cdecl);

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

			cfile.add_function (type_get_fun);

			var unref_fun = new CCodeFunction ("block%d_data_finalize".printf (block_id), "void");
			unref_fun.add_parameter (new CCodeParameter ("_data%d_".printf (block_id), struct_name + "*"));
			unref_fun.modifiers = CCodeModifiers.STATIC;
			cfile.add_function_declaration (unref_fun);
			unref_fun.block = free_block;

			cfile.add_function (unref_fun);
		}

		foreach (Statement stmt in b.get_statements ()) {
			stmt.emit (this);
		}

		// free in reverse order
		for (int i = local_vars.size - 1; i >= 0; i--) {
			var local = local_vars[i];
			if (!local.floating && !local.captured && requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				ccode.add_statement (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
			}
		}

		if (b.parent_symbol is Method) {
			var m = (Method) b.parent_symbol;
			foreach (Parameter param in m.get_parameters ()) {
				if (!param.captured && requires_destroy (param.variable_type) && param.direction == ParameterDirection.IN) {
					var ma = new MemberAccess.simple (param.name);
					ma.symbol_reference = param;
					ccode.add_statement (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (param.name), param.variable_type, ma)));
				}
			}
		}

		if (b.captured) {
			int block_id = get_block_id (b);

			var data_unref = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_unref"));
			data_unref.add_argument (get_variable_cexpression ("_data%d_".printf (block_id)));
			ccode.add_statement (new CCodeExpressionStatement (data_unref));
		}

		if (b.parent_node is Block || b.parent_node is SwitchStatement) {
			ccode.close ();
		}

		emit_context.pop_symbol ();
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		stmt.declaration.accept (this);
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
		if (local.initializer != null) {
			local.initializer.emit (this);

			visit_end_full_expression (local.initializer);
		}

		generate_type_declaration (local.variable_type, cfile);

		CCodeExpression rhs = null;
		if (local.initializer != null && get_cvalue (local.initializer) != null) {
			rhs = get_cvalue (local.initializer);
		}

		if (local.captured) {
			if (local.initializer != null) {
				ccode.add_assignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (get_block_id ((Block) local.parent_symbol))), get_variable_cname (local.name)), rhs);
			}
		} else {
			var cvar = new CCodeVariableDeclarator (get_variable_cname (local.name), rhs, get_ccode_declarator_suffix (local.variable_type));

			var cdecl = new CCodeDeclaration (get_ccode_name (local.variable_type));
			cdecl.add_declarator (cvar);
			ccode.add_statement (cdecl);

			// try to initialize uninitialized variables
			// initialization not necessary for variables stored in closure
			if (cvar.initializer == null) {
				cvar.initializer = default_value_for_type (local.variable_type, true);
				cvar.init0 = true;
			}
		}

		if (local.initializer != null && local.initializer.tree_can_fail) {
			add_simple_check (local.initializer);
		}

		local.active = true;
	}

	public override void visit_initializer_list (InitializerList list) {
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

				var cexpr = get_cvalue (expr);

				string ctype = field.get_ctype ();
				if (ctype != null) {
					cexpr = new CCodeCastExpression (cexpr, ctype);
				}

				clist.append (cexpr);
			}

			set_cvalue (list, clist);
		} else {
			var clist = new CCodeInitializerList ();
			foreach (Expression expr in list.get_initializers ()) {
				clist.append (get_cvalue (expr));
			}
			set_cvalue (list, clist);
		}
	}

	public override LocalVariable create_local (DataType type) {
		var result = get_temp_variable (type, type.value_owned);
		emit_temp_var (result);
		return result;
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
			return new CCodeCastExpression (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeCastExpression (type_expression, "char *"), new CCodeIdentifier ("_%s_type_offset".printf (CCodeBaseModule.get_ccode_lower_case_name (type_symbol)))), "%sTypePrivate *".printf (get_ccode_name (type_symbol)));
		} else {
			// interface
			var get_interface = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_get_interface"));
			get_interface.add_argument (type_expression);
			get_interface.add_argument (new CCodeIdentifier ("%s_type".printf (get_ccode_lower_case_name (type_symbol))));
			return new CCodeCastExpression (get_interface, "%sTypePrivate *".printf (CCodeBaseModule.get_ccode_name (type_symbol)));
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
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_type_get".printf (CCodeBaseModule.get_ccode_lower_case_name (type.data_type))));
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
			if (is_reference_counting (type.data_type)) {
				dup_function = get_ccode_ref_function (type.data_type);
			} else if (type is ValueType) {
				dup_function = get_ccode_dup_function (type.data_type);
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
				if (is_reference_counting (type.data_type)) {
					unref_function = get_ccode_unref_function ((ObjectTypeSymbol) type.data_type);
				} else {
					unref_function = get_ccode_free_function (type.data_type);
				}
			} else {
				if (type.nullable) {
					unref_function = get_ccode_free_function (type.data_type);
					if (unref_function == null) {
						unref_function = "free";
					}
				} else {
					var st = (Struct) type.data_type;
					unref_function = get_ccode_copy_function (st);
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

	public CCodeExpression get_unref_expression (CCodeExpression cvar, DataType type, Expression? expr = null) {
		return destroy_value (new DovaValue (type, cvar));
	}

	public CCodeExpression destroy_value (TargetValue value) {
		var type = value.value_type;
		var cvar = get_cvalue_ (value);

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

		if (((List<LocalVariable>) temp_ref_vars).size == 0) {
			/* nothing to do without temporary variables */
			return;
		}

		var expr_type = expr.value_type;
		if (expr.target_type != null) {
			expr_type = expr.target_type;
		}

		var full_expr_var = get_temp_variable (expr_type, true, expr);
		emit_temp_var (full_expr_var);

		var expr_list = new CCodeCommaExpression ();
		expr_list.append_expression (new CCodeAssignment (get_variable_cexpression (full_expr_var.name), get_cvalue (expr)));

		foreach (LocalVariable local in temp_ref_vars) {
			var ma = new MemberAccess.simple (local.name);
			ma.symbol_reference = local;
			expr_list.append_expression (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma));
		}

		expr_list.append_expression (get_variable_cexpression (full_expr_var.name));

		set_cvalue (expr, expr_list);

		temp_ref_vars.clear ();
	}

	public void emit_temp_var (LocalVariable local) {
		var cdecl = new CCodeDeclaration (get_ccode_name (local.variable_type));

		var vardecl = new CCodeVariableDeclarator (local.name, null, get_ccode_declarator_suffix (local.variable_type));
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
		           array_type != null) {
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

		ccode.add_statement (cdecl);
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		if (stmt.expression.error) {
			stmt.error = true;
			return;
		}

		if (get_cvalue (stmt.expression) != null) {
			ccode.add_expression (get_cvalue (stmt.expression));
		}
		/* free temporary objects and handle errors */

		foreach (LocalVariable local in temp_ref_vars) {
			var ma = new MemberAccess.simple (local.name);
			ma.symbol_reference = local;
			ma.value_type = local.variable_type.copy ();
			ccode.add_expression (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma));
		}

		if (stmt.tree_can_fail && stmt.expression.tree_can_fail) {
			// simple case, no node breakdown necessary
			add_simple_check (stmt.expression);
		}

		temp_ref_vars.clear ();
	}

	public virtual void append_local_free (Symbol sym, bool stop_at_loop = false, CodeNode? stop_at = null) {
		var b = (Block) sym;

		var local_vars = b.get_local_variables ();
		// free in reverse order
		for (int i = local_vars.size - 1; i >= 0; i--) {
			var local = local_vars[i];
			if (local.active && !local.floating && !local.captured && requires_destroy (local.variable_type)) {
				var ma = new MemberAccess.simple (local.name);
				ma.symbol_reference = local;
				ccode.add_expression (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma));
			}
		}

		if (b.captured) {
			int block_id = get_block_id (b);

			var data_unref = new CCodeFunctionCall (new CCodeIdentifier ("dova_object_unref"));
			data_unref.add_argument (get_variable_cexpression ("_data%d_".printf (block_id)));
			ccode.add_expression (data_unref);
		}

		if (stop_at_loop) {
			if (b.parent_node is Loop ||
			    b.parent_node is ForeachStatement ||
			    b.parent_node is SwitchStatement) {
				return;
			}
		}

		if (b.parent_node == stop_at) {
			return;
		}

		if (sym.parent_symbol is Block) {
			append_local_free (sym.parent_symbol, stop_at_loop, stop_at);
		} else if (sym.parent_symbol is Method) {
			append_param_free ((Method) sym.parent_symbol);
		}
	}

	private void append_param_free (Method m) {
		foreach (Parameter param in m.get_parameters ()) {
			if (requires_destroy (param.variable_type) && param.direction == ParameterDirection.IN) {
				var ma = new MemberAccess.simple (param.name);
				ma.symbol_reference = param;
				ccode.add_expression (get_unref_expression (get_variable_cexpression (param.name), param.variable_type, ma));
			}
		}
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		// free local variables
		append_local_free (current_symbol);

		ccode.add_return ((current_return_type is VoidType) ? null : new CCodeIdentifier ("result"));
	}

	public override void visit_delete_statement (DeleteStatement stmt) {
		var pointer_type = stmt.expression.value_type as PointerType;
		var array_type = stmt.expression.value_type as ArrayType;

		if (pointer_type != null) {
			DataType type = pointer_type;
			if (pointer_type.base_type.data_type != null && pointer_type.base_type.data_type.is_reference_type ()) {
				type = pointer_type.base_type;
			}

			var ccall = new CCodeFunctionCall (get_destroy_func_expression (type));
			ccall.add_argument (get_cvalue (stmt.expression));
			ccode.add_expression (ccall);
		} else if (array_type != null) {
			// TODO free elements
			var free_call = new CCodeFunctionCall (new CCodeIdentifier ("free"));
			free_call.add_argument (new CCodeMemberAccess (get_cvalue (stmt.expression), "data"));
			ccode.add_expression (free_call);

			ccode.add_assignment (new CCodeMemberAccess (get_cvalue (stmt.expression), "data"), new CCodeConstant ("NULL"));
			ccode.add_assignment (new CCodeMemberAccess (get_cvalue (stmt.expression), "length"), new CCodeConstant ("0"));
		} else {
			assert_not_reached ();
		}
	}

	public override void visit_expression (Expression expr) {
		if (get_cvalue (expr) != null && !expr.lvalue) {
			// memory management, implicit casts, and boxing/unboxing
			set_cvalue (expr, transform_expression (get_cvalue (expr), expr.value_type, expr.target_type, expr));
		}
	}

	public override void visit_boolean_literal (BooleanLiteral expr) {
		set_cvalue (expr, new CCodeConstant (expr.value ? "true" : "false"));
	}

	public override void visit_character_literal (CharacterLiteral expr) {
		if (expr.get_char () >= 0x20 && expr.get_char () < 0x80) {
			set_cvalue (expr, new CCodeConstant (expr.value));
		} else {
			set_cvalue (expr, new CCodeConstant ("%uU".printf (expr.get_char ())));
		}
	}

	public override void visit_integer_literal (IntegerLiteral expr) {
		set_cvalue (expr, new CCodeConstant (expr.value));
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
		set_cvalue (expr, new CCodeConstant (c_literal));
	}

	public override void visit_string_literal (StringLiteral expr) {
		// FIXME handle escaped characters in scanner/parser and escape them here again for C
		var cliteral = new CCodeConstant ("\"\\0\" " + expr.value);

		var cbinary = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, cliteral, new CCodeConstant ("1"));
		set_cvalue (expr, new CCodeCastExpression (cbinary, "string_t"));
	}

	public override void visit_null_literal (NullLiteral expr) {
		set_cvalue (expr, new CCodeConstant ("NULL"));
	}

	public override void visit_base_access (BaseAccess expr) {
		generate_type_declaration (expr.value_type, cfile);
		set_cvalue (expr, new CCodeCastExpression (new CCodeIdentifier ("this"), get_ccode_name (expr.value_type)));
	}

	public override void visit_postfix_expression (PostfixExpression expr) {
		MemberAccess ma = find_property_access (expr.inner);
		if (ma != null) {
			// property postfix expression
			var prop = (Property) ma.symbol_reference;

			// assign current value to temp variable
			var temp_decl = get_temp_variable (prop.property_type, true, expr);
			emit_temp_var (temp_decl);
			ccode.add_assignment (get_variable_cexpression (temp_decl.name), get_cvalue (expr.inner));

			// increment/decrement property
			var op = expr.increment ? CCodeBinaryOperator.PLUS : CCodeBinaryOperator.MINUS;
			var cexpr = new CCodeBinaryExpression (op, get_variable_cexpression (temp_decl.name), new CCodeConstant ("1"));
			store_property (prop, ma.inner, new DovaValue (expr.value_type, cexpr));

			// return previous value
			set_cvalue (expr, new CCodeIdentifier (temp_decl.name));
			return;
		}

		var op = expr.increment ? CCodeUnaryOperator.POSTFIX_INCREMENT : CCodeUnaryOperator.POSTFIX_DECREMENT;

		set_cvalue (expr, new CCodeUnaryExpression (op, get_cvalue (expr.inner)));
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
		if (cl != null && is_reference_counting (cl)
		    && get_ccode_ref_function (cl) == "") {
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
		if (cl != null && is_reference_counting (cl)
		    && get_ccode_unref_function (cl) == "") {
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
		if (cl != null && get_ccode_ref_function_void (cl)) {
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
			emit_temp_var (decl);

			var ctemp = get_variable_cexpression (decl.name);

			var vt = (ValueType) expression_type;
			var st = (Struct) vt.type_symbol;
			var copy_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_copy_function (st)));
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
			ccall.add_argument (get_cvalue (expr));

			return ccall;
		} else {
			var decl = get_temp_variable (expression_type, false, node);
			emit_temp_var (decl);

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

	public virtual void generate_class_declaration (Class cl, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, cl, get_ccode_name (cl))) {
			return;
		}
	}

	public virtual void generate_interface_declaration (Interface iface, CCodeFile decl_space) {
	}

	public virtual void generate_method_declaration (Method m, CCodeFile decl_space) {
	}

	public void add_generic_type_arguments (CCodeFunctionCall ccall, List<DataType> type_args, CodeNode expr, bool is_chainup = false) {
		foreach (var type_arg in type_args) {
			ccall.add_argument (get_type_id_expression (type_arg, is_chainup));
		}
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
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
			emit_temp_var (temp_decl);

			instance = get_variable_cexpression (get_variable_cname (temp_decl.name));
		}

		if (expr.symbol_reference == null) {
			// no creation method
			if (expr.type_reference.data_type is Struct) {
				var creation_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
				creation_call.add_argument (new CCodeConstant ("0"));
				creation_call.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (get_ccode_name (expr.type_reference))));

				creation_expr = creation_call;
			}
		} else if (expr.symbol_reference is Method) {
			// use creation method
			var m = (Method) expr.symbol_reference;
			var params = m.get_parameters ();
			CCodeFunctionCall creation_call;

			generate_method_declaration (m, cfile);

			var cl = expr.type_reference.data_type as Class;

			if (!CCodeBaseModule.get_ccode_has_new_function (m)) {
				// use construct function directly
				creation_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_real_name (m)));
				creation_call.add_argument (new CCodeIdentifier (CCodeBaseModule.get_ccode_type_id (cl)));
			} else {
				creation_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_name (m)));
			}

			if (struct_by_ref && !(get_ccode_instance_pos (m) < 0)) {
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
			}

			generate_type_declaration (expr.type_reference, cfile);

			if (cl != null && !cl.is_compact) {
				add_generic_type_arguments (creation_call, expr.type_reference.get_type_arguments (), expr);
			}

			bool ellipsis = false;

			int i = 1;
			Iterator<Parameter> params_it = params.iterator ();
			foreach (Expression arg in expr.get_argument_list ()) {
				CCodeExpression cexpr = get_cvalue (arg);
				Parameter param = null;
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
				param.initializer.emit (this);

				creation_call.add_argument (get_cvalue (param.initializer));
				i++;
			}

			if (struct_by_ref && get_ccode_instance_pos (m) < 0) {
				// instance parameter is at the end in a struct creation method
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
			}

			if (ellipsis) {
				/* ensure variable argument list ends with NULL
				 * except when using printf-style arguments */
				if (!m.printf_format && !m.scanf_format && get_ccode_sentinel (m) != "") {
					creation_call.add_argument (new CCodeConstant (get_ccode_sentinel (m)));
				}
			}

			creation_expr = creation_call;

			// cast the return value of the creation method back to the intended type if
			// it requested a special C return type
			if (get_custom_creturn_type (m) != null) {
				creation_expr = new CCodeCastExpression (creation_expr, get_ccode_name (expr.type_reference));
			}
		} else {
			assert (false);
		}

		if (instance != null) {
			if (expr.type_reference.data_type is Struct) {
				ccode.add_expression (creation_expr);
			} else {
				ccode.add_assignment (instance, creation_expr);
			}

			foreach (MemberInitializer init in expr.get_object_initializer ()) {
				if (init.symbol_reference is Field) {
					var f = (Field) init.symbol_reference;
					var instance_target_type = get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);
					var typed_inst = transform_expression (instance, expr.type_reference, instance_target_type);
					CCodeExpression lhs;
					if (expr.type_reference.data_type is Struct) {
						lhs = new CCodeMemberAccess (typed_inst, get_ccode_name (f));
					} else {
						lhs = new CCodeMemberAccess.pointer (typed_inst, get_ccode_name (f));
					}
					ccode.add_assignment (lhs, get_cvalue (init.initializer));
				} else if (init.symbol_reference is Property) {
					var inst_ma = new MemberAccess.simple ("new");
					inst_ma.value_type = expr.type_reference;
					set_cvalue (inst_ma, instance);
					store_property ((Property) init.symbol_reference, inst_ma, init.initializer.target_value);
				}
			}

			creation_expr = instance;
		}

		if (creation_expr != null) {
			var temp_var = get_temp_variable (expr.value_type);
			var temp_ref = get_variable_cexpression (temp_var.name);

			emit_temp_var (temp_var);

			ccode.add_assignment (temp_ref, creation_expr);
			set_cvalue (expr, temp_ref);
		}
	}

	public CCodeExpression? handle_struct_argument (Parameter param, Expression arg, CCodeExpression? cexpr) {
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
					emit_temp_var (temp_var);
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
		csizeof.add_argument (new CCodeIdentifier (get_ccode_name (expr.type_reference)));
		set_cvalue (expr, csizeof);
	}

	public override void visit_typeof_expression (TypeofExpression expr) {
		set_cvalue (expr, get_type_id_expression (expr.type_reference));
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
		set_cvalue (expr, new CCodeUnaryExpression (op, get_cvalue (expr.inner)));
	}

	public override void visit_cast_expression (CastExpression expr) {
		if (expr.is_silent_cast) {
			if (expr.inner.value_type is ObjectType) {
				var ccomma = new CCodeCommaExpression ();
				var temp_decl = get_temp_variable (expr.inner.value_type, true, expr);

				emit_temp_var (temp_decl);

				var ctemp = get_variable_cexpression (temp_decl.name);
				var cinit = new CCodeAssignment (ctemp, get_cvalue (expr.inner));
				var ccheck = create_type_check (ctemp, expr.type_reference);
				var ccast = new CCodeCastExpression (ctemp, get_ccode_name (expr.type_reference));
				var cnull = new CCodeConstant ("NULL");

				ccomma.append_expression (cinit);
				ccomma.append_expression (new CCodeConditionalExpression (ccheck, ccast, cnull));

				set_cvalue (expr, ccomma);
			} else {
				expr.error = true;
				Report.error (expr.source_reference, "Operation not supported for this type");
			}
			return;
		}

		if (expr.type_reference.data_type != null && expr.type_reference.data_type.get_full_name () == "Dova.Value") {
			// box value
			var temp_decl = get_temp_variable (expr.inner.value_type, true, expr);
			emit_temp_var (temp_decl);
			var cvar = get_variable_cexpression (temp_decl.name);

			var ccomma = new CCodeCommaExpression ();
			ccomma.append_expression (new CCodeAssignment (cvar, get_cvalue (expr.inner)));

			var to_any  = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_value_to_any"));
			to_any.add_argument (get_type_id_expression (expr.inner.value_type));
			to_any.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cvar));
			to_any.add_argument (new CCodeConstant ("0"));
			ccomma.append_expression (to_any);

			set_cvalue (expr, ccomma);
			return;
		} else if (expr.inner.value_type.data_type != null && expr.inner.value_type.data_type.get_full_name () == "Dova.Value") {
			// unbox value
			var temp_decl = get_temp_variable (expr.type_reference, true, expr);
			emit_temp_var (temp_decl);
			var cvar = get_variable_cexpression (temp_decl.name);

			var ccomma = new CCodeCommaExpression ();

			var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_call.add_argument (new CCodeIdentifier (get_ccode_name (expr.type_reference)));

			var to_any  = new CCodeFunctionCall (new CCodeIdentifier ("dova_type_value_from_any"));
			to_any.add_argument (get_type_id_expression (expr.type_reference));
			to_any.add_argument (get_cvalue (expr.inner));
			to_any.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cvar));
			to_any.add_argument (new CCodeConstant ("0"));
			ccomma.append_expression (to_any);

			ccomma.append_expression (cvar);

			set_cvalue (expr, ccomma);
			return;
		}

		if (expr.inner.value_type is ArrayType && expr.type_reference is PointerType) {
			var array_type = (ArrayType) expr.inner.value_type;
			if (!array_type.fixed_length) {
				set_cvalue (expr, new CCodeMemberAccess (get_cvalue (expr.inner), "data"));
				return;
			}
		}

		generate_type_declaration (expr.type_reference, cfile);

		if (expr.inner.value_type is GenericType && !(expr.type_reference is GenericType)) {
			// generic types use an extra pointer, dereference that pointer
			set_cvalue (expr, new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeCastExpression (get_cvalue (expr.inner), get_ccode_name (expr.type_reference) + "*")));
		} else {
			set_cvalue (expr, new CCodeCastExpression (get_cvalue (expr.inner), get_ccode_name (expr.type_reference)));
		}
	}

	public override void visit_pointer_indirection (PointerIndirection expr) {
		set_cvalue (expr, new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_cvalue (expr.inner)));
	}

	public override void visit_addressof_expression (AddressofExpression expr) {
		set_cvalue (expr, new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue (expr.inner)));
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		/* (tmp = var, var = null, tmp) */
		var ccomma = new CCodeCommaExpression ();
		var temp_decl = get_temp_variable (expr.value_type, true, expr);
		emit_temp_var (temp_decl);
		var cvar = get_variable_cexpression (temp_decl.name);

		ccomma.append_expression (new CCodeAssignment (cvar, get_cvalue (expr.inner)));
		ccomma.append_expression (new CCodeAssignment (get_cvalue (expr.inner), new CCodeConstant ("NULL")));
		ccomma.append_expression (cvar);
		set_cvalue (expr, ccomma);
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		var cleft = get_cvalue (expr.left);
		var cright = get_cvalue (expr.right);

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
			set_cvalue (expr, new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeBinaryExpression (CCodeBinaryOperator.BITWISE_AND, cright, cleft), cleft));
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

		set_cvalue (expr, new CCodeBinaryExpression (op, cleft, cright));
	}

	CCodeExpression? create_type_check (CCodeNode ccodenode, DataType type) {
		var ccheck = new CCodeFunctionCall (new CCodeIdentifier ("any_is_a"));
		ccheck.add_argument ((CCodeExpression) ccodenode);
		ccheck.add_argument (get_type_id_expression (type));
		return ccheck;
	}

	public override void visit_type_check (TypeCheck expr) {
		generate_type_declaration (expr.type_reference, cfile);

		set_cvalue (expr, create_type_check (get_cvalue (expr.expression), expr.type_reference));
		if (get_cvalue (expr) is CCodeInvalidExpression) {
			Report.error (expr.source_reference, "type check expressions not supported for compact classes, structs, and enums");
		}
	}

	public override void visit_lambda_expression (LambdaExpression l) {
		l.accept_children (this);

		set_cvalue (l, new CCodeIdentifier (get_ccode_name (l.method)));
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
				emit_temp_var (decl);
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
			if (target_type is ArrayType) {
				var array = new CCodeFunctionCall (new CCodeIdentifier ("dova_array"));
				array.add_argument (new CCodeConstant ("NULL"));
				array.add_argument (new CCodeConstant ("0"));
				return array;
			}

			// null literal, no cast required when not converting to generic type pointer
			return cexpr;
		}

		if (expression_type is ArrayType && target_type is PointerType) {
			var array_type = (ArrayType) expression_type;
			if (!array_type.inline_allocated) {
				return new CCodeMemberAccess (cexpr, "data");
			}
		}

		if (expression_type is ArrayType && target_type is ArrayType) {
			var source_array_type = (ArrayType) expression_type;
			var target_array_type = (ArrayType) target_type;
			if (source_array_type.inline_allocated && !target_array_type.inline_allocated) {
				var array = new CCodeFunctionCall (new CCodeIdentifier ("dova_array"));
				array.add_argument (cexpr);

				var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				csizeof.add_argument (cexpr);
				var csizeofelement = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				csizeofelement.add_argument (new CCodeElementAccess (cexpr, new CCodeConstant ("0")));
				array.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.DIV, csizeof, csizeofelement));

				return array;
			}
		}

		generate_type_declaration (target_type, cfile);

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
				wrapper.add_parameter (new CCodeParameter ("this", "void *"));
				call.add_argument (new CCodeIdentifier ("this"));
			}

			var method_param_iter = method_type.method_symbol.get_parameters ().iterator ();
			foreach (Parameter param in d.get_parameters ()) {
				method_param_iter.next ();
				var method_param = method_param_iter.get ();
				string ctype = get_ccode_name (param.variable_type);
				if (param.variable_type is GenericType && !(method_param.variable_type is GenericType)) {
					ctype = get_ccode_name (method_param.variable_type) + "*";
					call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (param.name)));
				} else if (!(param.variable_type is GenericType) && method_param.variable_type is GenericType) {
					call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier (param.name)));
				} else {
					call.add_argument (new CCodeIdentifier (param.name));
				}

				wrapper.add_parameter (new CCodeParameter (param.name, ctype));
			}

			wrapper.block = new CCodeBlock ();
			if (d.return_type is VoidType) {
				wrapper.block.add_statement (new CCodeExpressionStatement (call));
			} else {
				var method_return_type = method_type.method_symbol.return_type;
				if (d.return_type is GenericType && !(method_return_type is GenericType)) {
					wrapper.add_parameter (new CCodeParameter ("result", get_ccode_name (method_return_type) + "*"));
					wrapper.block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("result")), call)));
				} else if (!(d.return_type is GenericType) && method_return_type is GenericType) {
					wrapper.return_type = get_ccode_name (d.return_type);
					var cdecl = new CCodeDeclaration (get_ccode_name (d.return_type));
					cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
					call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("result")));
					wrapper.block.add_statement (new CCodeExpressionStatement (call));
					wrapper.block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));
				} else if (d.return_type is GenericType) {
					wrapper.add_parameter (new CCodeParameter ("result", "void *"));
					wrapper.block.add_statement (new CCodeExpressionStatement (call));
				} else {
					wrapper.return_type = get_ccode_name (d.return_type);
					wrapper.block.add_statement (new CCodeReturnStatement (call));
				}
			}

			cfile.add_function (wrapper);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_new".printf (get_ccode_lower_case_name (deleg_type.delegate_symbol))));
			ccall.add_argument (delegate_target);
			ccall.add_argument (new CCodeIdentifier (wrapper_name));
			return ccall;
		}

		var cl = target_type.data_type as Class;
		var iface = target_type.data_type as Interface;
		if (context.checking && (iface != null || (cl != null && !cl.is_compact))) {
			// checked cast for strict subtypes of GTypeInstance
			return generate_instance_cast (cexpr, target_type.data_type);
		} else if (target_type.data_type != null && get_ccode_name (expression_type) != get_ccode_name (target_type)) {
			var st = target_type.data_type as Struct;
			if (target_type.data_type.is_reference_type () || (st != null && st.is_simple_type ())) {
				// don't cast non-simple structs
				return new CCodeCastExpression (cexpr, get_ccode_name (target_type));
			} else {
				return cexpr;
			}
		} else {
			return cexpr;
		}
	}

	public void store_property (Property prop, Expression? instance, TargetValue value) {
		string set_func;

		var base_property = prop;
		if (prop.base_property != null) {
			base_property = prop.base_property;
		} else if (prop.base_interface_property != null) {
			base_property = prop.base_interface_property;
		}

		generate_property_accessor_declaration (base_property.set_accessor, cfile);
		set_func = get_ccode_name (base_property.set_accessor);

		if (!prop.external && prop.external_package) {
			// internal VAPI properties
			// only add them once per source file
			if (add_generated_external_symbol (prop)) {
				visit_property (prop);
			}
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (set_func));

		if (prop.binding == MemberBinding.INSTANCE) {
			/* target instance is first argument */
			ccall.add_argument ((CCodeExpression) get_ccodenode (instance));
		}

		ccall.add_argument (get_cvalue_ (value));

		ccode.add_expression (ccall);
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
		     array_type != null)) {
			// 0-initialize struct with struct initializer { 0 }
			// only allowed as initializer expression in C
			var clist = new CCodeInitializerList ();
			clist.append (new CCodeConstant ("0"));
			return clist;
		} else if ((type.data_type != null && type.data_type.is_reference_type ())
		           || type.nullable
		           || type is PointerType || type is DelegateType) {
			return new CCodeConstant ("NULL");
		} else if (type.data_type != null && get_ccode_default_value (type.data_type) != "") {
			return new CCodeConstant (get_ccode_default_value (type.data_type));
		}
		return null;
	}

	public CCodeExpression? get_ccodenode (Expression node) {
		if (get_cvalue (node) == null) {
			node.emit (this);
		}
		return get_cvalue (node);
	}

	public string get_ccode_name (CodeNode node) {
		return CCodeBaseModule.get_ccode_name (node);
	}

	public string get_ccode_const_name (CodeNode node) {
		return CCodeBaseModule.get_ccode_const_name (node);
	}

	public string get_ccode_copy_function (TypeSymbol node) {
		return CCodeBaseModule.get_ccode_copy_function (node);
	}

	public string get_ccode_dup_function (TypeSymbol node) {
		return CCodeBaseModule.get_ccode_dup_function (node);
	}

	public string get_ccode_ref_function (TypeSymbol node) {
		return CCodeBaseModule.get_ccode_ref_function (node);
	}

	public string get_ccode_unref_function (ObjectTypeSymbol node) {
		return CCodeBaseModule.get_ccode_unref_function (node);
	}

	public string get_ccode_free_function (TypeSymbol node) {
		return CCodeBaseModule.get_ccode_free_function (node);
	}

	public bool is_reference_counting (TypeSymbol node) {
		return CCodeBaseModule.is_reference_counting (node);
	}

	public bool get_ccode_ref_function_void (Class node) {
		return CCodeBaseModule.get_ccode_ref_function_void (node);
	}

	public string get_ccode_default_value (TypeSymbol node) {
		return CCodeBaseModule.get_ccode_default_value (node);
	}

	public string get_ccode_real_name (Method node) {
		return CCodeBaseModule.get_ccode_real_name (node);
	}

	public string get_ccode_lower_case_name (CodeNode node, string? infix = null) {
		return CCodeBaseModule.get_ccode_lower_case_name (node, infix);
	}

	public string get_ccode_upper_case_name (Symbol node, string? infix = null) {
		return CCodeBaseModule.get_ccode_upper_case_name (node, infix);
	}

	public string get_ccode_lower_case_prefix (Symbol node) {
		return CCodeBaseModule.get_ccode_lower_case_prefix (node);
	}

	public double get_ccode_instance_pos (CodeNode node) {
		return CCodeBaseModule.get_ccode_instance_pos (node);
	}

	public string get_ccode_vfunc_name (Method node) {
		return CCodeBaseModule.get_ccode_vfunc_name (node);
	}

	public string get_ccode_sentinel (Method m) {
		return CCodeBaseModule.get_ccode_sentinel (m);
	}

	public string get_ccode_declarator_suffix (DataType type) {
		return CCodeBaseModule.get_ccode_declarator_suffix (type);
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
		return new CCodeCastExpression (expr, get_ccode_name (type) + "*");
	}

	public virtual string? get_custom_creturn_type (Method m) {
		return null;
	}

	public virtual bool method_has_wrapper (Method method) {
		return false;
	}

	public virtual void add_simple_check (CodeNode node, bool always_fails = false) {
	}

	public CCodeExpression? get_cvalue (Expression expr) {
		if (expr.target_value == null) {
			return null;
		}
		var dova_value = (DovaValue) expr.target_value;
		return dova_value.cvalue;
	}

	public CCodeExpression? get_cvalue_ (TargetValue value) {
		var dova_value = (DovaValue) value;
		return dova_value.cvalue;
	}

	public void set_cvalue (Expression expr, CCodeExpression? cvalue) {
		var dova_value = (DovaValue) expr.target_value;
		if (dova_value == null) {
			dova_value = new DovaValue (expr.value_type);
			expr.target_value = dova_value;
		}
		dova_value.cvalue = cvalue;
	}
}

public class Vala.DovaValue : TargetValue {
	public CCodeExpression cvalue;

	public DovaValue (DataType? value_type = null, CCodeExpression? cvalue = null) {
		base (value_type);
		this.cvalue = cvalue;
	}
}
