/* valaccodebasemodule.vala
 *
 * Copyright (C) 2006-2012  Jürg Billeter
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
public abstract class Vala.CCodeBaseModule : CodeGenerator {
	public class EmitContext {
		public Symbol? current_symbol;
		public ArrayList<Symbol> symbol_stack = new ArrayList<Symbol> ();
		public TryStatement current_try;
		public CatchClause current_catch;
		public CCodeFunction ccode;
		public ArrayList<CCodeFunction> ccode_stack = new ArrayList<CCodeFunction> ();
		public ArrayList<TargetValue> temp_ref_values = new ArrayList<TargetValue> ();
		public int next_temp_var_id;
		public bool current_method_inner_error;
		public bool current_method_return;
		public Map<string,string> variable_name_map = new HashMap<string,string> (str_hash, str_equal);
		public Map<string,int> closure_variable_count_map = new HashMap<string,int> (str_hash, str_equal);
		public Map<LocalVariable,int> closure_variable_clash_map = new HashMap<LocalVariable,int> ();

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

	public CCodeLineDirective? current_line = null;

	List<CCodeLineDirective> line_directive_stack = new ArrayList<CCodeLineDirective> ();

	public Symbol current_symbol { get { return emit_context.current_symbol; } }

	public TryStatement current_try {
		get { return emit_context.current_try; }
		set { emit_context.current_try = value; }
	}

	public CatchClause current_catch {
		get { return emit_context.current_catch; }
		set { emit_context.current_catch = value; }
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

	public Constructor? current_constructor {
		get {
			var sym = current_symbol;
			while (sym is Block) {
				sym = sym.parent_symbol;
			}
			return sym as Constructor;
		}
	}

	public Destructor? current_destructor {
		get {
			var sym = current_symbol;
			while (sym is Block) {
				sym = sym.parent_symbol;
			}
			return sym as Destructor;
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

			if (is_in_constructor () || is_in_destructor ()) {
				return void_type;
			}

			return null;
		}
	}

	public bool is_in_coroutine () {
		return current_method != null && current_method.coroutine;
	}

	public bool is_in_constructor () {
		if (current_method != null) {
			// make sure to not return true in lambda expression inside constructor
			return false;
		}
		var sym = current_symbol;
		while (sym != null) {
			if (sym is Constructor) {
				return true;
			}
			sym = sym.parent_symbol;
		}
		return false;
	}

	public bool is_in_destructor () {
		if (current_method != null) {
			// make sure to not return true in lambda expression inside constructor
			return false;
		}
		var sym = current_symbol;
		while (sym != null) {
			if (sym is Destructor) {
				return true;
			}
			sym = sym.parent_symbol;
		}
		return false;
	}

	public Block? current_closure_block {
		get {
			return next_closure_block (current_symbol);
		}
	}

	public unowned Block? next_closure_block (Symbol sym) {
		while (true) {
			unowned Method method = sym as Method;
			if (method != null && !method.closure) {
				// parent blocks are not captured by this method
				break;
			}

			unowned Block block = sym as Block;
			if (method == null && block == null) {
				// no closure block
				break;
			}

			if (block != null && block.captured) {
				// closure block found
				return block;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}

	public CCodeFile header_file;
	public CCodeFile internal_header_file;
	public CCodeFile cfile;

	public EmitContext class_init_context;
	public EmitContext base_init_context;
	public EmitContext class_finalize_context;
	public EmitContext base_finalize_context;
	public EmitContext instance_init_context;
	public EmitContext instance_finalize_context;
	
	public CCodeStruct param_spec_struct;
	public CCodeStruct closure_struct;
	public CCodeEnum prop_enum;

	public CCodeFunction ccode { get { return emit_context.ccode; } }

	/* temporary variables that own their content */
	public ArrayList<TargetValue> temp_ref_values { get { return emit_context.temp_ref_values; } }
	/* cache to check whether a certain marshaller has been created yet */
	public Set<string> user_marshal_set;
	/* (constant) hash table with all predefined marshallers */
	public Set<string> predefined_marshal_set;
	/* (constant) hash table with all reserved identifiers in the generated code */
	Set<string> reserved_identifiers;
	
	public int next_temp_var_id {
		get { return emit_context.next_temp_var_id; }
		set { emit_context.next_temp_var_id = value; }
	}

	public int next_regex_id = 0;
	public bool in_creation_method { get { return current_method is CreationMethod; } }

	public bool current_method_inner_error {
		get { return emit_context.current_method_inner_error; }
		set { emit_context.current_method_inner_error = value; }
	}

	public bool current_method_return {
		get { return emit_context.current_method_return; }
		set { emit_context.current_method_return = value; }
	}

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
	public Class gnode_type;
	public Class gqueue_type;
	public Class gvaluearray_type;
	public TypeSymbol gstringbuilder_type;
	public TypeSymbol garray_type;
	public TypeSymbol gbytearray_type;
	public TypeSymbol gptrarray_type;
	public TypeSymbol gthreadpool_type;
	public DataType gdestroynotify_type;
	public DataType gquark_type;
	public Struct gvalue_type;
	public Class gvariant_type;
	public Struct mutex_type;
	public Struct gmutex_type;
	public Struct grecmutex_type;
	public Struct grwlock_type;
	public Struct gcond_type;
	public Class gsource_type;
	public TypeSymbol type_module_type;
	public TypeSymbol dbus_proxy_type;
	public Class gtk_widget_type;

	public bool in_plugin = false;
	public string module_init_param_name;
	
	public bool gvaluecollector_h_needed;
	public bool requires_assert;
	public bool requires_array_free;
	public bool requires_array_move;
	public bool requires_array_length;
	public bool requires_clear_mutex;

	public Set<string> wrappers;
	Set<Symbol> generated_external_symbols;

	public Map<string,string> variable_name_map { get { return emit_context.variable_name_map; } }

	public static int ccode_attribute_cache_index = CodeNode.get_attribute_cache_index ();

	public CCodeBaseModule () {
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

		var glib_ns = root_symbol.scope.lookup ("GLib");

		gtype_type = (TypeSymbol) glib_ns.scope.lookup ("Type");
		gobject_type = (TypeSymbol) glib_ns.scope.lookup ("Object");
		gerror_type = new ErrorType (null, null);
		glist_type = (Class) glib_ns.scope.lookup ("List");
		gslist_type = (Class) glib_ns.scope.lookup ("SList");
		gnode_type = (Class) glib_ns.scope.lookup ("Node");
		gqueue_type = (Class) glib_ns.scope.lookup ("Queue");
		gvaluearray_type = (Class) glib_ns.scope.lookup ("ValueArray");
		gstringbuilder_type = (TypeSymbol) glib_ns.scope.lookup ("StringBuilder");
		garray_type = (TypeSymbol) glib_ns.scope.lookup ("Array");
		gbytearray_type = (TypeSymbol) glib_ns.scope.lookup ("ByteArray");
		gptrarray_type = (TypeSymbol) glib_ns.scope.lookup ("PtrArray");
		gthreadpool_type = (TypeSymbol) glib_ns.scope.lookup ("ThreadPool");
		gdestroynotify_type = new DelegateType ((Delegate) glib_ns.scope.lookup ("DestroyNotify"));

		gquark_type = new IntegerType ((Struct) glib_ns.scope.lookup ("Quark"));
		gvalue_type = (Struct) glib_ns.scope.lookup ("Value");
		gvariant_type = (Class) glib_ns.scope.lookup ("Variant");
		gsource_type = (Class) glib_ns.scope.lookup ("Source");

		if (context.require_glib_version (2, 32)) {
			gmutex_type = (Struct) glib_ns.scope.lookup ("Mutex");
			grecmutex_type = (Struct) glib_ns.scope.lookup ("RecMutex");
			grwlock_type = (Struct) glib_ns.scope.lookup ("RWLock");
			gcond_type = (Struct) glib_ns.scope.lookup ("Cond");

			mutex_type = grecmutex_type;
		} else {
			mutex_type = (Struct) glib_ns.scope.lookup ("StaticRecMutex");
		}

		type_module_type = (TypeSymbol) glib_ns.scope.lookup ("TypeModule");

		regex_type = new ObjectType ((Class) root_symbol.scope.lookup ("GLib").scope.lookup ("Regex"));

		if (context.module_init_method != null) {
			foreach (Parameter parameter in context.module_init_method.get_parameters ()) {
				if (parameter.variable_type.data_type == type_module_type) {
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

		var gtk_ns = root_symbol.scope.lookup ("Gtk");
		if (gtk_ns != null) {
			gtk_widget_type = (Class) gtk_ns.scope.lookup ("Widget");
		}

		header_file = new CCodeFile ();
		header_file.is_header = true;
		internal_header_file = new CCodeFile ();
		internal_header_file.is_header = true;

		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			if (file.file_type == SourceFileType.SOURCE ||
			    (context.header_filename != null && file.file_type == SourceFileType.FAST)) {
				file.accept (this);
			}
		}

		// generate symbols file for public API
		if (context.symbols_filename != null) {
			var stream = FileStream.open (context.symbols_filename, "w");
			if (stream == null) {
				Report.error (null, "unable to open `%s' for writing".printf (context.symbols_filename));
				return;
			}

			foreach (string symbol in header_file.get_symbols ()) {
				stream.puts (symbol);
				stream.putc ('\n');
			}

			stream = null;
		}

		// generate C header file for public API
		if (context.header_filename != null) {
			bool ret = header_file.store (context.header_filename, null, context.version_header, false, "G_BEGIN_DECLS", "G_END_DECLS");
			if (!ret) {
				Report.error (null, "unable to open `%s' for writing".printf (context.header_filename));
			}
		}

		// generate C header file for internal API
		if (context.internal_header_filename != null) {
			bool ret = internal_header_file.store (context.internal_header_filename, null, context.version_header, false, "G_BEGIN_DECLS", "G_END_DECLS");
			if (!ret) {
				Report.error (null, "unable to open `%s' for writing".printf (context.internal_header_filename));
			}
		}
	}

	public void push_context (EmitContext emit_context) {
		if (this.emit_context != null) {
			emit_context_stack.add (this.emit_context);
		}

		this.emit_context = emit_context;
		if (ccode != null) {
			ccode.current_line = current_line;
		}
	}

	public void pop_context () {
		if (emit_context_stack.size > 0) {
			this.emit_context = emit_context_stack[emit_context_stack.size - 1];
			emit_context_stack.remove_at (emit_context_stack.size - 1);
			if (ccode != null) {
				ccode.current_line = current_line;
			}
		} else {
			this.emit_context = null;
		}
	}

	public void push_line (SourceReference? source_reference) {
		line_directive_stack.add (current_line);
		if (source_reference != null) {
			current_line = new CCodeLineDirective (source_reference.file.filename, source_reference.begin.line);
			if (ccode != null) {
				ccode.current_line = current_line;
			}
		}
	}

	public void pop_line () {
		current_line = line_directive_stack[line_directive_stack.size - 1];
		line_directive_stack.remove_at (line_directive_stack.size - 1);
		if (ccode != null) {
			ccode.current_line = current_line;
		}
	}

	public void push_function (CCodeFunction func) {
		emit_context.ccode_stack.add (ccode);
		emit_context.ccode = func;
		ccode.current_line = current_line;
	}

	public void pop_function () {
		emit_context.ccode = emit_context.ccode_stack[emit_context.ccode_stack.size - 1];
		emit_context.ccode_stack.remove_at (emit_context.ccode_stack.size - 1);
		if (ccode != null) {
			ccode.current_line = current_line;
		}
	}

	public bool add_symbol_declaration (CCodeFile decl_space, Symbol sym, string name) {
		if (decl_space.add_declaration (name)) {
			return true;
		}
		if (sym.source_reference != null) {
			sym.source_reference.file.used = true;
		}
		if (sym.external_package || (!decl_space.is_header && CodeContext.get ().use_header && !sym.is_internal_symbol ())) {
			// add appropriate include file
			foreach (string header_filename in get_ccode_header_filenames (sym).split (",")) {
				decl_space.add_include (header_filename, !sym.external_package ||
				                                         (sym.external_package &&
				                                          sym.from_commandline));
			}
			// declaration complete
			return true;
		} else {
			// require declaration
			return false;
		}
	}

	public CCodeIdentifier get_value_setter_function (DataType type_reference) {
		var array_type = type_reference as ArrayType;
		if (type_reference.data_type != null) {
			return new CCodeIdentifier (get_ccode_set_value_function (type_reference.data_type));
		} else if (array_type != null && array_type.element_type.data_type == string_type.data_type) {
			// G_TYPE_STRV
			return new CCodeIdentifier ("g_value_set_boxed");
		} else {
			return new CCodeIdentifier ("g_value_set_pointer");
		}
	}

	public CCodeIdentifier get_value_taker_function (DataType type_reference) {
		var array_type = type_reference as ArrayType;
		if (type_reference.data_type != null) {
			return new CCodeIdentifier (get_ccode_take_value_function (type_reference.data_type));
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
			return new CCodeIdentifier (get_ccode_get_value_function (type_reference.data_type));
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

	public void append_vala_clear_mutex (string typename, string funcprefix) {
		// memset
		cfile.add_include ("string.h");

		var fun = new CCodeFunction ("_vala_clear_" + typename);
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeParameter ("mutex", typename + " *"));

		push_function (fun);

		ccode.add_declaration (typename, new CCodeVariableDeclarator.zero ("zero_mutex", new CCodeConstant ("{ 0 }")));

		var cmp = new CCodeFunctionCall (new CCodeIdentifier ("memcmp"));
		cmp.add_argument (new CCodeIdentifier ("mutex"));
		cmp.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("zero_mutex")));
		cmp.add_argument (new CCodeIdentifier ("sizeof (" + typename + ")"));
		ccode.open_if (cmp);

		var mutex_clear = new CCodeFunctionCall (new CCodeIdentifier (funcprefix + "_clear"));
		mutex_clear.add_argument (new CCodeIdentifier ("mutex"));
		ccode.add_expression (mutex_clear);

		var mset = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
		mset.add_argument (new CCodeIdentifier ("mutex"));
		mset.add_argument (new CCodeConstant ("0"));
		mset.add_argument (new CCodeIdentifier ("sizeof (" + typename + ")"));
		ccode.add_expression (mset);

		ccode.close ();

		pop_function ();

		cfile.add_function_declaration (fun);
		cfile.add_function (fun);
	}

	public override void visit_source_file (SourceFile source_file) {
		cfile = new CCodeFile ();
		
		user_marshal_set = new HashSet<string> (str_hash, str_equal);
		
		next_regex_id = 0;
		
		gvaluecollector_h_needed = false;
		requires_assert = false;
		requires_array_free = false;
		requires_array_move = false;
		requires_array_length = false;
		requires_clear_mutex = false;

		wrappers = new HashSet<string> (str_hash, str_equal);
		generated_external_symbols = new HashSet<Symbol> ();

		header_file.add_include ("glib.h");
		internal_header_file.add_include ("glib.h");
		cfile.add_include ("glib.h");
		cfile.add_include ("glib-object.h");

		source_file.accept_children (this);

		if (context.report.get_errors () > 0) {
			return;
		}

		/* For fast-vapi, we only wanted the header declarations
		 * to be emitted, so bail out here without writing the
		 * C code output.
		 */
		if (source_file.file_type == SourceFileType.FAST) {
			return;
		}

		if (requires_assert) {
			cfile.add_type_declaration (new CCodeMacroReplacement.with_expression ("_vala_assert(expr, msg)", new CCodeConstant ("if G_LIKELY (expr) ; else g_assertion_message_expr (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, msg);")));
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
		if (requires_clear_mutex) {
			append_vala_clear_mutex ("GMutex", "g_mutex");
			append_vala_clear_mutex ("GRecMutex", "g_rec_mutex");
			append_vala_clear_mutex ("GRWLock", "g_rw_lock");
			append_vala_clear_mutex ("GCond", "g_cond");
		}

		if (gvaluecollector_h_needed) {
			cfile.add_include ("gobject/gvaluecollector.h");
		}

		var comments = source_file.get_comments();
		if (comments != null) {
			foreach (Comment comment in comments) {
				var ccomment = new CCodeComment (comment.content);
				cfile.add_comment (ccomment);
			}
		}

		if (!cfile.store (source_file.get_csource_filename (), source_file.filename, context.version_header, context.debug)) {
			Report.error (null, "unable to open `%s' for writing".printf (source_file.get_csource_filename ()));
		}

		cfile = null;
	}

	public virtual bool generate_enum_declaration (Enum en, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, en, get_ccode_name (en))) {
			return false;
		}

		var cenum = new CCodeEnum (get_ccode_name (en));

		cenum.deprecated = en.deprecated;

		int flag_shift = 0;
		foreach (EnumValue ev in en.get_values ()) {
			CCodeEnumValue c_ev;
			if (ev.value == null) {
				c_ev = new CCodeEnumValue (get_ccode_name (ev));
				if (en.is_flags) {
					c_ev.value = new CCodeConstant ("1 << %d".printf (flag_shift));
					flag_shift += 1;
				}
			} else {
				ev.value.emit (this);
				c_ev = new CCodeEnumValue (get_ccode_name (ev), get_cvalue (ev.value));
			}
			c_ev.deprecated = ev.deprecated;
			cenum.add_value (c_ev);
		}

		decl_space.add_type_definition (cenum);
		decl_space.add_type_definition (new CCodeNewline ());

		if (!get_ccode_has_type_id (en)) {
			return true;
		}

		decl_space.add_type_declaration (new CCodeNewline ());

		var macro = "(%s_get_type ())".printf (get_ccode_lower_case_name (en, null));
		decl_space.add_type_declaration (new CCodeMacroReplacement (get_ccode_type_id (en), macro));

		var fun_name = "%s_get_type".printf (get_ccode_lower_case_name (en, null));
		var regfun = new CCodeFunction (fun_name, "GType");
		regfun.attributes = "G_GNUC_CONST";

		if (en.access == SymbolAccessibility.PRIVATE) {
			regfun.modifiers = CCodeModifiers.STATIC;
			// avoid C warning as this function is not always used
			regfun.attributes = "G_GNUC_UNUSED";
		}

		decl_space.add_function_declaration (regfun);

		return true;
	}

	public override void visit_enum (Enum en) {
		push_line (en.source_reference);

		en.accept_children (this);

		if (en.comment != null) {
			cfile.add_type_member_definition (new CCodeComment (en.comment.content));
		}

		generate_enum_declaration (en, cfile);

		if (!en.is_internal_symbol ()) {
			generate_enum_declaration (en, header_file);
		}
		if (!en.is_private_symbol ()) {
			generate_enum_declaration (en, internal_header_file);
		}

		pop_line ();
	}

	public void visit_member (Symbol m) {
		/* stuff meant for all lockable members */
		if (m is Lockable && ((Lockable) m).get_lock_used ()) {
			CCodeExpression l = new CCodeIdentifier ("self");
			var init_context = class_init_context;
			var finalize_context = class_finalize_context;

			if (m.is_instance_member ()) {
				l = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (l, "priv"), get_symbol_lock_name (m.name));
				init_context = instance_init_context;
				finalize_context = instance_finalize_context;
			} else if (m.is_class_member ()) {
				TypeSymbol parent = (TypeSymbol)m.parent_symbol;

				var get_class_private_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS_PRIVATE".printf(get_ccode_upper_case_name (parent))));
				get_class_private_call.add_argument (new CCodeIdentifier ("klass"));
				l = new CCodeMemberAccess.pointer (get_class_private_call, get_symbol_lock_name (m.name));
			} else {
				l = new CCodeIdentifier (get_symbol_lock_name ("%s_%s".printf(get_ccode_lower_case_name (m.parent_symbol), m.name)));
			}

			push_context (init_context);
			var initf = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_name (mutex_type.default_construction_method)));
			initf.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));
			ccode.add_expression (initf);
			pop_context ();

			if (finalize_context != null) {
				string mutex_clear;
				if (context.require_glib_version (2, 32)) {
					mutex_clear = "g_rec_mutex_clear";
				} else {
					mutex_clear = "g_static_rec_mutex_free";
				}

				push_context (finalize_context);
				var fc = new CCodeFunctionCall (new CCodeIdentifier (mutex_clear));
				fc.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));
				ccode.add_expression (fc);
				pop_context ();
			}
		}
	}

	public void generate_constant_declaration (Constant c, CCodeFile decl_space, bool definition = false) {
		if (c.parent_symbol is Block) {
			// local constant
			return;
		}

		if (add_symbol_declaration (decl_space, c, get_ccode_name (c))) {
			return;
		}

		if (!c.external) {
			generate_type_declaration (c.type_reference, decl_space);

			c.value.emit (this);

			var initializer_list = c.value as InitializerList;
			if (initializer_list != null) {
				var cdecl = new CCodeDeclaration (get_ccode_const_name (c.type_reference));
				var arr = "";
				if (c.type_reference is ArrayType) {
					arr = "[%d]".printf (initializer_list.size);
				}

				var cinitializer = get_cvalue (c.value);
				if (!definition) {
					// never output value in header
					// special case needed as this method combines declaration and definition
					cinitializer = null;
				}

				cdecl.add_declarator (new CCodeVariableDeclarator ("%s%s".printf (get_ccode_name (c), arr), cinitializer));
				if (c.is_private_symbol ()) {
					cdecl.modifiers = CCodeModifiers.STATIC;
				} else {
					cdecl.modifiers = CCodeModifiers.EXTERN;
				}

				decl_space.add_constant_declaration (cdecl);
			} else {
				var cdefine = new CCodeMacroReplacement.with_expression (get_ccode_name (c), get_cvalue (c.value));
				decl_space.add_type_member_declaration (cdefine);
			}
		}
	}

	public override void visit_constant (Constant c) {
		push_line (c.source_reference);

		if (c.parent_symbol is Block) {
			// local constant

			generate_type_declaration (c.type_reference, cfile);

			c.value.emit (this);

			string type_name = get_ccode_const_name (c.type_reference);
			string arr = "";
			if (c.type_reference is ArrayType) {
				arr = "[]";
			}

			if (c.type_reference.compatible (string_type)) {
				type_name = "const char";
				arr = "[]";
			}

			var cinitializer = get_cvalue (c.value);

			ccode.add_declaration (type_name, new CCodeVariableDeclarator ("%s%s".printf (get_ccode_name (c), arr), cinitializer), CCodeModifiers.STATIC);
		} else {
			generate_constant_declaration (c, cfile, true);

			if (!c.is_internal_symbol ()) {
				generate_constant_declaration (c, header_file);
			}
			if (!c.is_private_symbol ()) {
				generate_constant_declaration (c, internal_header_file);
			}
		}

		pop_line ();
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
		cdecl.add_declarator (new CCodeVariableDeclarator (get_ccode_name (f), null, get_ccode_declarator_suffix (f.variable_type)));
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
			var flock = new CCodeDeclaration (get_ccode_name (mutex_type));
			var flock_decl =  new CCodeVariableDeclarator (get_symbol_lock_name (get_ccode_name (f)), new CCodeConstant ("{0}"));
			flock.add_declarator (flock_decl);

			if (f.is_private_symbol ()) {
				flock.modifiers = CCodeModifiers.STATIC;
			} else {
				flock.modifiers = CCodeModifiers.EXTERN;
			}
			decl_space.add_type_member_declaration (flock);
		}

		if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
			var array_type = (ArrayType) f.variable_type;

			if (!array_type.fixed_length) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					var len_type = int_type.copy ();

					cdecl = new CCodeDeclaration (get_ccode_name (len_type));
					cdecl.add_declarator (new CCodeVariableDeclarator (get_array_length_cname (get_ccode_name (f), dim)));
					if (f.is_private_symbol ()) {
						cdecl.modifiers = CCodeModifiers.STATIC;
					} else {
						cdecl.modifiers = CCodeModifiers.EXTERN;
					}
					decl_space.add_type_member_declaration (cdecl);
				}
			}
		} else if (f.variable_type is DelegateType) {
			var delegate_type = (DelegateType) f.variable_type;
			if (delegate_type.delegate_symbol.has_target) {
				// create field to store delegate target

				cdecl = new CCodeDeclaration ("gpointer");
				cdecl.add_declarator (new CCodeVariableDeclarator (get_ccode_delegate_target_name (f)));
				if (f.is_private_symbol ()) {
					cdecl.modifiers = CCodeModifiers.STATIC;
				} else {
					cdecl.modifiers = CCodeModifiers.EXTERN;
				}
				decl_space.add_type_member_declaration (cdecl);

				if (delegate_type.value_owned && !delegate_type.is_called_once) {
					cdecl = new CCodeDeclaration ("GDestroyNotify");
					cdecl.add_declarator (new CCodeVariableDeclarator (get_delegate_target_destroy_notify_cname  (get_ccode_name (f))));
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
		push_line (f.source_reference);
		visit_member (f);

		check_type (f.variable_type);

		var cl = f.parent_symbol as Class;
		bool is_gtypeinstance = (cl != null && !cl.is_compact);

		CCodeExpression lhs = null;

		string field_ctype = get_ccode_name (f.variable_type);
		if (f.is_volatile) {
			field_ctype = "volatile " + field_ctype;
		}

		if (f.binding == MemberBinding.INSTANCE)  {
			if (is_gtypeinstance && f.access == SymbolAccessibility.PRIVATE) {
				lhs = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), get_ccode_name (f));
			} else {
				lhs = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), get_ccode_name (f));
			}

			if (f.initializer != null) {
				push_context (instance_init_context);

				f.initializer.emit (this);

				var rhs = get_cvalue (f.initializer);

				ccode.add_assignment (lhs, rhs);

				if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
					var array_type = (ArrayType) f.variable_type;
					var field_value = get_field_cvalue (f, load_this_parameter ((TypeSymbol) f.parent_symbol));

					var glib_value = (GLibValue) f.initializer.target_value;
					if (glib_value.array_length_cvalues != null) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							var array_len_lhs = get_array_length_cvalue (field_value, dim);
							ccode.add_assignment (array_len_lhs, get_array_length_cvalue (glib_value, dim));
						}
					} else if (glib_value.array_null_terminated) {
						requires_array_length = true;
						var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
						len_call.add_argument (get_cvalue_ (glib_value));

						ccode.add_assignment (get_array_length_cvalue (field_value, 1), len_call);
					} else {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							ccode.add_assignment (get_array_length_cvalue (field_value, dim), new CCodeConstant ("-1"));
						}
					}

					if (array_type.rank == 1 && f.is_internal_symbol ()) {
						var lhs_array_size = get_array_size_cvalue (field_value);
						var rhs_array_len = get_array_length_cvalue (field_value, 1);
						ccode.add_assignment (lhs_array_size, rhs_array_len);
					}
				}

				foreach (var value in temp_ref_values) {
					ccode.add_expression (destroy_value (value));
				}

				temp_ref_values.clear ();

				pop_context ();
			}
			
			if (requires_destroy (f.variable_type) && instance_finalize_context != null) {
				push_context (instance_finalize_context);
				ccode.add_expression (destroy_field (f, load_this_parameter ((TypeSymbol) f.parent_symbol)));
				pop_context ();
			}
		} else if (f.binding == MemberBinding.CLASS)  {
			if (!is_gtypeinstance) {
				Report.error (f.source_reference, "class fields are not supported in compact classes");
				f.error = true;
				return;
			}

			if (f.access == SymbolAccessibility.PRIVATE) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS_PRIVATE".printf (get_ccode_upper_case_name (cl))));
				ccall.add_argument (new CCodeIdentifier ("klass"));
				lhs = new CCodeMemberAccess (ccall, get_ccode_name (f), true);
			} else {
				lhs = new CCodeMemberAccess (new CCodeIdentifier ("klass"), get_ccode_name (f), true);
			}

			if (f.initializer != null) {
				push_context (class_init_context);

				f.initializer.emit (this);

				var rhs = get_cvalue (f.initializer);

				ccode.add_assignment (lhs, rhs);

				foreach (var value in temp_ref_values) {
					ccode.add_expression (destroy_value (value));
				}

				temp_ref_values.clear ();

				pop_context ();
			}
		} else {
			generate_field_declaration (f, cfile);

			if (!f.is_internal_symbol ()) {
				generate_field_declaration (f, header_file);
			}
			if (!f.is_private_symbol ()) {
				generate_field_declaration (f, internal_header_file);
			}

			if (!f.external) {
				lhs = new CCodeIdentifier (get_ccode_name (f));

				var var_decl = new CCodeVariableDeclarator (get_ccode_name (f), null, get_ccode_declarator_suffix (f.variable_type));
				var_decl.initializer = default_value_for_type (f.variable_type, true);

				if (class_init_context != null) {
					push_context (class_init_context);
				} else {
					push_context (new EmitContext ());
				}

				if (f.initializer != null) {
					f.initializer.emit (this);

					var init = get_cvalue (f.initializer);
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
				cfile.add_type_member_declaration (var_def);

				/* add array length fields where necessary */
				if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
					var array_type = (ArrayType) f.variable_type;

					if (!array_type.fixed_length) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							var len_type = int_type.copy ();

							var len_def = new CCodeDeclaration (get_ccode_name (len_type));
							len_def.add_declarator (new CCodeVariableDeclarator (get_array_length_cname (get_ccode_name (f), dim), new CCodeConstant ("0")));
							if (!f.is_private_symbol ()) {
								len_def.modifiers = CCodeModifiers.EXTERN;
							} else {
								len_def.modifiers = CCodeModifiers.STATIC;
							}
							cfile.add_type_member_declaration (len_def);
						}

						if (array_type.rank == 1 && f.is_internal_symbol ()) {
							var len_type = int_type.copy ();

							var cdecl = new CCodeDeclaration (get_ccode_name (len_type));
							cdecl.add_declarator (new CCodeVariableDeclarator (get_array_size_cname (get_ccode_name (f)), new CCodeConstant ("0")));
							cdecl.modifiers = CCodeModifiers.STATIC;
							cfile.add_type_member_declaration (cdecl);
						}
					}
				} else if (f.variable_type is DelegateType) {
					var delegate_type = (DelegateType) f.variable_type;
					if (delegate_type.delegate_symbol.has_target) {
						// create field to store delegate target

						var target_def = new CCodeDeclaration ("gpointer");
						target_def.add_declarator (new CCodeVariableDeclarator (get_ccode_delegate_target_name (f), new CCodeConstant ("NULL")));
						if (!f.is_private_symbol ()) {
							target_def.modifiers = CCodeModifiers.EXTERN;
						} else {
							target_def.modifiers = CCodeModifiers.STATIC;
						}
						cfile.add_type_member_declaration (target_def);

						if (delegate_type.is_disposable ()) {
							var target_destroy_notify_def = new CCodeDeclaration ("GDestroyNotify");
							target_destroy_notify_def.add_declarator (new CCodeVariableDeclarator (get_delegate_target_destroy_notify_cname (get_ccode_name (f)), new CCodeConstant ("NULL")));
							if (!f.is_private_symbol ()) {
								target_destroy_notify_def.modifiers = CCodeModifiers.EXTERN;
							} else {
								target_destroy_notify_def.modifiers = CCodeModifiers.STATIC;
							}
							cfile.add_type_member_declaration (target_destroy_notify_def);

						}
					}
				}

				if (f.initializer != null) {
					var rhs = get_cvalue (f.initializer);
					if (!is_constant_ccode_expression (rhs)) {
						if (is_gtypeinstance) {
							if (f.initializer is InitializerList) {
								ccode.open_block ();

								var temp_decl = get_temp_variable (f.variable_type);
								var vardecl = new CCodeVariableDeclarator.zero (temp_decl.name, rhs);
								ccode.add_declaration (get_ccode_name (temp_decl.variable_type), vardecl);

								var tmp = get_variable_cexpression (get_variable_cname (temp_decl.name));
								ccode.add_assignment (lhs, tmp);

								ccode.close ();
							} else {
								ccode.add_assignment (lhs, rhs);
							}

							if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
								var array_type = (ArrayType) f.variable_type;
								var field_value = get_field_cvalue (f, null);

								var glib_value = (GLibValue) f.initializer.target_value;
								if (glib_value.array_length_cvalues != null) {
									for (int dim = 1; dim <= array_type.rank; dim++) {
										var array_len_lhs = get_array_length_cvalue (field_value, dim);
										ccode.add_assignment (array_len_lhs, get_array_length_cvalue (glib_value, dim));
									}
								} else if (glib_value.array_null_terminated) {
									requires_array_length = true;
									var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
									len_call.add_argument (get_cvalue_ (glib_value));

									ccode.add_assignment (get_array_length_cvalue (field_value, 1), len_call);
								} else {
									for (int dim = 1; dim <= array_type.rank; dim++) {
										ccode.add_assignment (get_array_length_cvalue (field_value, dim), new CCodeConstant ("-1"));
									}
								}
							}
						} else {
							f.error = true;
							Report.error (f.source_reference, "Non-constant field initializers not supported in this context");
							return;
						}
					}
				}

				pop_context ();
			}
		}

		pop_line ();
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
		if (!p.ellipsis) {
			check_type (p.variable_type);
		}
	}

	public override void visit_property (Property prop) {
		visit_member (prop);

		check_type (prop.property_type);

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

	public virtual void generate_class_struct_declaration (Class cl, CCodeFile decl_space) {
	}

	public virtual void generate_struct_declaration (Struct st, CCodeFile decl_space) {
	}

	public virtual void generate_delegate_declaration (Delegate d, CCodeFile decl_space) {
	}

	public virtual void generate_cparameters (Method m, CCodeFile decl_space, Map<int,CCodeParameter> cparam_map, CCodeFunction func, CCodeFunctionDeclarator? vdeclarator = null, Map<int,CCodeExpression>? carg_map = null, CCodeFunctionCall? vcall = null, int direction = 3) {
	}

	public void generate_property_accessor_declaration (PropertyAccessor acc, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, acc, get_ccode_name (acc))) {
			return;
		}

		var prop = (Property) acc.prop;

		bool returns_real_struct = acc.readable && prop.property_type.is_real_non_null_struct_type ();


		CCodeParameter cvalueparam;
		if (returns_real_struct) {
			cvalueparam = new CCodeParameter ("result", get_ccode_name (acc.value_type) + "*");
		} else if (!acc.readable && prop.property_type.is_real_non_null_struct_type ()) {
			cvalueparam = new CCodeParameter ("value", get_ccode_name (acc.value_type) + "*");
		} else {
			cvalueparam = new CCodeParameter ("value", get_ccode_name (acc.value_type));
		}
		generate_type_declaration (acc.value_type, decl_space);

		CCodeFunction function;
		if (acc.readable && !returns_real_struct) {
			function = new CCodeFunction (get_ccode_name (acc), get_ccode_name (acc.value_type));
		} else {
			function = new CCodeFunction (get_ccode_name (acc), "void");
		}

		if (prop.binding == MemberBinding.INSTANCE) {
			var t = (TypeSymbol) prop.parent_symbol;
			var this_type = get_data_type_for_symbol (t);
			generate_type_declaration (this_type, decl_space);
			var cselfparam = new CCodeParameter ("self", get_ccode_name (this_type));
			if (t is Struct && !((Struct) t).is_simple_type ()) {
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
				function.add_parameter (new CCodeParameter (get_array_length_cname (acc.readable ? "result" : "value", dim), length_ctype));
			}
		} else if ((acc.value_type is DelegateType) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
			function.add_parameter (new CCodeParameter (get_delegate_target_cname (acc.readable ? "result" : "value"), acc.readable ? "gpointer*" : "gpointer"));
			if (!acc.readable && acc.value_type.value_owned) {
				function.add_parameter (new CCodeParameter (get_delegate_target_destroy_notify_cname ("value"), "GDestroyNotify"));
			}
		}

		if (prop.is_private_symbol () || (!acc.readable && !acc.writable) || acc.access == SymbolAccessibility.PRIVATE) {
			function.modifiers |= CCodeModifiers.STATIC;
		}
		decl_space.add_function_declaration (function);
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		push_context (new EmitContext (acc));
		push_line (acc.source_reference);

		var prop = (Property) acc.prop;

		if (acc.comment != null) {
			cfile.add_type_member_definition (new CCodeComment (acc.comment.content));
		}

		bool returns_real_struct = acc.readable && prop.property_type.is_real_non_null_struct_type ();

		if (acc.result_var != null) {
			acc.result_var.accept (this);
		}

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
			generate_property_accessor_declaration (acc, cfile);

			// do not declare construct-only properties in header files
			if (acc.readable || acc.writable) {
				if (!prop.is_internal_symbol ()
				    && (acc.access == SymbolAccessibility.PUBLIC
					|| acc.access == SymbolAccessibility.PROTECTED)) {
					generate_property_accessor_declaration (acc, header_file);
				}
				if (!prop.is_private_symbol () && acc.access != SymbolAccessibility.PRIVATE) {
					generate_property_accessor_declaration (acc, internal_header_file);
				}
			}
		}

		if (acc.source_type == SourceFileType.FAST) {
			pop_line ();
			return;
		}

		var this_type = get_data_type_for_symbol (t);
		var cselfparam = new CCodeParameter ("self", get_ccode_name (this_type));
		if (t is Struct && !((Struct) t).is_simple_type ()) {
			cselfparam.type_name += "*";
		}
		CCodeParameter cvalueparam;
		if (returns_real_struct) {
			cvalueparam = new CCodeParameter ("result", get_ccode_name (acc.value_type) + "*");
		} else if (!acc.readable && prop.property_type.is_real_non_null_struct_type ()) {
			cvalueparam = new CCodeParameter ("value", get_ccode_name (acc.value_type) + "*");
		} else {
			cvalueparam = new CCodeParameter ("value", get_ccode_name (acc.value_type));
		}

		if (prop.is_abstract || prop.is_virtual) {
			CCodeFunction function;
			if (acc.readable && !returns_real_struct) {
				function = new CCodeFunction (get_ccode_name (acc), get_ccode_name (current_return_type));
			} else {
				function = new CCodeFunction (get_ccode_name (acc), "void");
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
					function.add_parameter (new CCodeParameter (get_array_length_cname (acc.readable ? "result" : "value", dim), length_ctype));
				}
			} else if ((acc.value_type is DelegateType) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
				function.add_parameter (new CCodeParameter (get_delegate_target_cname (acc.readable ? "result" : "value"), acc.readable ? "gpointer*" : "gpointer"));
				if (!acc.readable && acc.value_type.value_owned) {
					function.add_parameter (new CCodeParameter (get_delegate_target_destroy_notify_cname ("value"), "GDestroyNotify"));
				}
			}

			if (prop.is_private_symbol () || !(acc.readable || acc.writable) || acc.access == SymbolAccessibility.PRIVATE) {
				// accessor function should be private if the property is an internal symbol or it's a construct-only setter
				function.modifiers |= CCodeModifiers.STATIC;
			}

			push_function (function);

			if (prop.binding == MemberBinding.INSTANCE) {
				if (!acc.readable || returns_real_struct) {
					create_property_type_check_statement (prop, false, t, true, "self");
				} else {
					create_property_type_check_statement (prop, true, t, true, "self");
				}
			}

			CCodeFunctionCall vcast = null;
			if (prop.parent_symbol is Interface) {
				var iface = (Interface) prop.parent_symbol;

				vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_INTERFACE".printf (get_ccode_upper_case_name (iface, null))));
			} else {
				var cl = (Class) prop.parent_symbol;

				vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS".printf (get_ccode_upper_case_name (cl, null))));
			}
			vcast.add_argument (new CCodeIdentifier ("self"));

			if (acc.readable) {
				var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "get_%s".printf (prop.name)));
				vcall.add_argument (new CCodeIdentifier ("self"));
				if (returns_real_struct) {
					vcall.add_argument (new CCodeIdentifier ("result"));
					ccode.add_expression (vcall);
				} else {
					if (acc.value_type is ArrayType) {
						var array_type = (ArrayType) acc.value_type;

						for (int dim = 1; dim <= array_type.rank; dim++) {
							var len_expr = new CCodeIdentifier (get_array_length_cname ("result", dim));
							vcall.add_argument (len_expr);
						}
					} else if ((acc.value_type is DelegateType) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
						vcall.add_argument (new CCodeIdentifier (get_delegate_target_cname ("result")));
					}

					ccode.add_return (vcall);
				}
			} else {
				var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "set_%s".printf (prop.name)));
				vcall.add_argument (new CCodeIdentifier ("self"));
				vcall.add_argument (new CCodeIdentifier ("value"));

				if (acc.value_type is ArrayType) {
					var array_type = (ArrayType) acc.value_type;

					for (int dim = 1; dim <= array_type.rank; dim++) {
						var len_expr = new CCodeIdentifier (get_array_length_cname ("value", dim));
						vcall.add_argument (len_expr);
					}
				} else if ((acc.value_type is DelegateType) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
					vcall.add_argument (new CCodeIdentifier (get_delegate_target_cname ("value")));
					if (!acc.readable && acc.value_type.value_owned) {
						vcall.add_argument (new CCodeIdentifier (get_delegate_target_destroy_notify_cname ("value")));
					}
				}

				ccode.add_expression (vcall);
			}

			pop_function ();

			cfile.add_function (function);
		}

		if (!prop.is_abstract) {
			bool is_virtual = prop.base_property != null || prop.base_interface_property != null;

			string cname = get_ccode_real_name (acc);

			CCodeFunction function;
			if (acc.writable || acc.construction || returns_real_struct) {
				function = new CCodeFunction (cname, "void");
			} else {
				function = new CCodeFunction (cname, get_ccode_name (acc.value_type));
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
					function.add_parameter (new CCodeParameter ("base", get_ccode_name (base_type)));
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
					function.add_parameter (new CCodeParameter (get_array_length_cname (acc.readable ? "result" : "value", dim), length_ctype));
				}
			} else if ((acc.value_type is DelegateType) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
				function.add_parameter (new CCodeParameter (get_delegate_target_cname (acc.readable ? "result" : "value"), acc.readable ? "gpointer*" : "gpointer"));
				if (!acc.readable && acc.value_type.value_owned) {
					function.add_parameter (new CCodeParameter (get_delegate_target_destroy_notify_cname ("value"), "GDestroyNotify"));
				}
			}

			if (!is_virtual) {
				if (prop.is_private_symbol () || !(acc.readable || acc.writable) || acc.access == SymbolAccessibility.PRIVATE) {
					// accessor function should be private if the property is an internal symbol or it's a construct-only setter
					function.modifiers |= CCodeModifiers.STATIC;
				}
			}

			push_function (function);

			if (prop.binding == MemberBinding.INSTANCE && !is_virtual) {
				if (!acc.readable || returns_real_struct) {
					create_property_type_check_statement (prop, false, t, true, "self");
				} else {
					create_property_type_check_statement (prop, true, t, true, "self");
				}
			}

			if (acc.readable && !returns_real_struct) {
				// do not declare result variable if exit block is known to be unreachable
				if (acc.return_block == null || acc.return_block.get_predecessors ().size > 0) {
					ccode.add_declaration (get_ccode_name (acc.value_type), new CCodeVariableDeclarator ("result"));
				}
			}

			if (is_virtual) {
				ccode.add_declaration (get_ccode_name (this_type), new CCodeVariableDeclarator ("self"));
				ccode.add_assignment (new CCodeIdentifier ("self"), get_cvalue_ (transform_value (new GLibValue (base_type, new CCodeIdentifier ("base"), true), this_type, acc)));
			}

			acc.body.emit (this);

			if (current_method_inner_error) {
				ccode.add_declaration ("GError *", new CCodeVariableDeclarator.zero ("_inner_error_", new CCodeConstant ("NULL")));
			}

			// notify on property changes
			if (is_gobject_property (prop) &&
			    get_ccode_notify (prop) &&
			    (acc.writable || acc.construction)) {
				var notify_call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_notify"));
				notify_call.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "GObject *"));
				notify_call.add_argument (get_property_canonical_cconstant (prop));
				ccode.add_expression (notify_call);
			}

			cfile.add_function (function);
		}

		pop_line ();
		pop_context ();
	}

	public override void visit_destructor (Destructor d) {
		if (d.binding == MemberBinding.STATIC && !in_plugin) {
			Report.error (d.source_reference, "static destructors are only supported for dynamic types");
			d.error = true;
			return;
		}
	}

	public int get_block_id (Block b) {
		int result = block_map[b];
		if (result == 0) {
			result = ++next_block_id;
			block_map[b] = result;
		}
		return result;
	}

	public bool no_implicit_copy (DataType type) {
		// note: implicit copy of array is planned to be forbidden
		var cl = type.data_type as Class;
		return (type is DelegateType ||
				type.is_array () ||
				(cl != null && !cl.is_immutable && !is_reference_counting (cl) && !get_ccode_is_gboxed (cl)));
	}

	void capture_parameter (Parameter param, CCodeStruct data, int block_id) {
		generate_type_declaration (param.variable_type, cfile);

		var param_type = param.variable_type.copy ();
		if (!param.variable_type.value_owned) {
			param_type.value_owned = !no_implicit_copy (param.variable_type);
		}
		data.add_field (get_ccode_name (param_type), get_variable_cname (param.name));

		// create copy if necessary as captured variables may need to be kept alive
		param.captured = false;
		var value = load_parameter (param);

		var array_type = param.variable_type as ArrayType;
		var deleg_type = param.variable_type as DelegateType;

		if (array_type != null && get_ccode_array_length (param)) {
			for (int dim = 1; dim <= array_type.rank; dim++) {
				data.add_field ("gint", get_parameter_array_length_cname (param, dim));
			}
		} else if (deleg_type != null && deleg_type.delegate_symbol.has_target) {
			data.add_field ("gpointer", get_ccode_delegate_target_name (param));
			if (param.variable_type.is_disposable ()) {
				data.add_field ("GDestroyNotify", get_delegate_target_destroy_notify_cname (get_variable_cname (param.name)));
				// reference transfer for delegates
				var lvalue = get_parameter_cvalue (param);
				((GLibValue) value).delegate_target_destroy_notify_cvalue = get_delegate_target_destroy_notify_cvalue (lvalue);
			}
		}
		param.captured = true;

		store_parameter (param, value, true);
	}

	public override void visit_block (Block b) {
		emit_context.push_symbol (b);

		var local_vars = b.get_local_variables ();

		if (b.parent_node is Block || b.parent_node is SwitchStatement || b.parent_node is TryStatement) {
			ccode.open_block ();
		}

		if (b.captured) {
			var parent_block = next_closure_block (b.parent_symbol);

			int block_id = get_block_id (b);
			string struct_name = "Block%dData".printf (block_id);

			var data = new CCodeStruct ("_" + struct_name);
			data.add_field ("int", "_ref_count_");
			if (parent_block != null) {
				int parent_block_id = get_block_id (parent_block);

				data.add_field ("Block%dData *".printf (parent_block_id), "_data%d_".printf (parent_block_id));
			} else {
				if (get_this_type () != null) {
					data.add_field ("%s *".printf (get_ccode_name (current_type_symbol)), "self");
				}

				if (current_method != null) {
					// allow capturing generic type parameters
					foreach (var type_param in current_method.get_type_parameters ()) {
						string func_name;

						func_name = "%s_type".printf (type_param.name.down ());
						data.add_field ("GType", func_name);

						func_name = "%s_dup_func".printf (type_param.name.down ());
						data.add_field ("GBoxedCopyFunc", func_name);

						func_name = "%s_destroy_func".printf (type_param.name.down ());
						data.add_field ("GDestroyNotify", func_name);
					}
				}
			}
			foreach (var local in local_vars) {
				if (local.captured) {
					generate_type_declaration (local.variable_type, cfile);

					data.add_field (get_ccode_name (local.variable_type), get_local_cname (local) + get_ccode_declarator_suffix (local.variable_type));

					if (local.variable_type is ArrayType) {
						var array_type = (ArrayType) local.variable_type;
						for (int dim = 1; dim <= array_type.rank; dim++) {
							data.add_field ("gint", get_array_length_cname (get_local_cname (local), dim));
						}
						data.add_field ("gint", get_array_size_cname (get_local_cname (local)));
					} else if (local.variable_type is DelegateType) {
						data.add_field ("gpointer", get_delegate_target_cname (get_local_cname (local)));
						if (local.variable_type.value_owned) {
							data.add_field ("GDestroyNotify", get_delegate_target_destroy_notify_cname (get_local_cname (local)));
						}
					}
				}
			}

			var data_alloc = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_new0"));
			data_alloc.add_argument (new CCodeIdentifier (struct_name));

			if (is_in_coroutine ()) {
				closure_struct.add_field (struct_name + "*", "_data%d_".printf (block_id));
			} else {
				ccode.add_declaration (struct_name + "*", new CCodeVariableDeclarator ("_data%d_".printf (block_id)));
			}
			ccode.add_assignment (get_variable_cexpression ("_data%d_".printf (block_id)), data_alloc);

			// initialize ref_count
			ccode.add_assignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "_ref_count_"), new CCodeIdentifier ("1"));

			if (parent_block != null) {
				int parent_block_id = get_block_id (parent_block);

				var ref_call = new CCodeFunctionCall (new CCodeIdentifier ("block%d_data_ref".printf (parent_block_id)));
				ref_call.add_argument (get_variable_cexpression ("_data%d_".printf (parent_block_id)));

				ccode.add_assignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "_data%d_".printf (parent_block_id)), ref_call);
			} else {
				// skip self assignment in toplevel block of creation methods with chainup as self is not set at the beginning of the method
				// the chainup statement takes care of assigning self in the closure struct
				bool in_creation_method_with_chainup = (current_method is CreationMethod && current_class != null && current_class.base_class != null);

				if (get_this_type () != null && (!in_creation_method_with_chainup || current_method.body != b)) {
					var ref_call = new CCodeFunctionCall (get_dup_func_expression (get_data_type_for_symbol (current_type_symbol), b.source_reference));
					ref_call.add_argument (get_result_cexpression ("self"));

					// never increase reference count for self in finalizers to avoid infinite recursion on following unref
					var instance = (is_in_destructor () ? (CCodeExpression) new CCodeIdentifier ("self") : (CCodeExpression) ref_call);

					ccode.add_assignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "self"), instance);
				}

				if (current_method != null) {
					// allow capturing generic type parameters
					var suffices = new string[] {"type", "dup_func", "destroy_func"};
					foreach (var type_param in current_method.get_type_parameters ()) {
						foreach (string suffix in suffices) {
							string func_name = "%s_%s".printf (type_param.name.down (), suffix);
							ccode.add_assignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), func_name), get_variable_cexpression (func_name));
						}
					}
				}
			}

			if (b.parent_symbol is Method) {
				var m = (Method) b.parent_symbol;

				// parameters are captured with the top-level block of the method
				foreach (var param in m.get_parameters ()) {
					if (param.captured) {
						capture_parameter (param, data, block_id);
					}
				}

				if (m.coroutine) {
					// capture async data to allow invoking callback from inside closure
					data.add_field ("gpointer", "_async_data_");

					// async method is suspended while waiting for callback,
					// so we never need to care about memory management of async data
					ccode.add_assignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "_async_data_"), new CCodeIdentifier ("_data_"));
				}
			} else if (b.parent_symbol is PropertyAccessor) {
				var acc = (PropertyAccessor) b.parent_symbol;

				if (!acc.readable && acc.value_parameter.captured) {
					capture_parameter (acc.value_parameter, data, block_id);
				}
			} else if (b.parent_symbol is ForeachStatement) {
				var stmt = (ForeachStatement) b.parent_symbol;
				if (!stmt.use_iterator && stmt.element_variable.captured) {
					ccode.add_assignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), get_local_cname (stmt.element_variable)), get_variable_cexpression (get_local_cname (stmt.element_variable)));
				}
			}

			var typedef = new CCodeTypeDefinition ("struct _" + struct_name, new CCodeVariableDeclarator (struct_name));
			cfile.add_type_declaration (typedef);
			cfile.add_type_definition (data);

			// create ref/unref functions
			var ref_fun = new CCodeFunction ("block%d_data_ref".printf (block_id), struct_name + "*");
			ref_fun.add_parameter (new CCodeParameter ("_data%d_".printf (block_id), struct_name + "*"));
			ref_fun.modifiers = CCodeModifiers.STATIC;

			push_function (ref_fun);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_atomic_int_inc"));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "_ref_count_")));
			ccode.add_expression (ccall);
			ccode.add_return (new CCodeIdentifier ("_data%d_".printf (block_id)));

			pop_function ();

			cfile.add_function_declaration (ref_fun);
			cfile.add_function (ref_fun);

			var unref_fun = new CCodeFunction ("block%d_data_unref".printf (block_id), "void");
			unref_fun.add_parameter (new CCodeParameter ("_userdata_", "void *"));
			unref_fun.modifiers = CCodeModifiers.STATIC;
			
			push_function (unref_fun);

			ccode.add_declaration (struct_name + "*", new CCodeVariableDeclarator ("_data%d_".printf (block_id), new CCodeCastExpression (new CCodeIdentifier ("_userdata_"), struct_name + "*")));
			ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_atomic_int_dec_and_test"));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "_ref_count_")));
			ccode.open_if (ccall);

			CCodeExpression outer_block = new CCodeIdentifier ("_data%d_".printf (block_id));
			unowned Block parent_closure_block = b;
			while (true) {
				parent_closure_block = next_closure_block (parent_closure_block.parent_symbol);
				if (parent_closure_block == null) {
					break;
				}
				int parent_block_id = get_block_id (parent_closure_block);
				outer_block = new CCodeMemberAccess.pointer (outer_block, "_data%d_".printf (parent_block_id));
			}

			if (get_this_type () != null) {
				// assign "self" for type parameters
				ccode.add_declaration ("%s *".printf (get_ccode_name (current_type_symbol)), new CCodeVariableDeclarator ("self"));
				ccode.add_assignment (new CCodeIdentifier ("self"), new CCodeMemberAccess.pointer (outer_block, "self"));
			}

			if (current_method != null) {
				// assign captured generic type parameters
				foreach (var type_param in current_method.get_type_parameters ()) {
					string func_name;

					func_name = "%s_type".printf (type_param.name.down ());
					ccode.add_declaration ("GType", new CCodeVariableDeclarator (func_name));
					ccode.add_assignment (new CCodeIdentifier (func_name), new CCodeMemberAccess.pointer (outer_block, func_name));

					func_name = "%s_dup_func".printf (type_param.name.down ());
					ccode.add_declaration ("GBoxedCopyFunc", new CCodeVariableDeclarator (func_name));
					ccode.add_assignment (new CCodeIdentifier (func_name), new CCodeMemberAccess.pointer (outer_block, func_name));

					func_name = "%s_destroy_func".printf (type_param.name.down ());
					ccode.add_declaration ("GDestroyNotify", new CCodeVariableDeclarator (func_name));
					ccode.add_assignment (new CCodeIdentifier (func_name), new CCodeMemberAccess.pointer (outer_block, func_name));
				}
			}

			// free in reverse order
			for (int i = local_vars.size - 1; i >= 0; i--) {
				var local = local_vars[i];
				if (local.captured) {
					if (requires_destroy (local.variable_type)) {
						bool old_coroutine = false;
						if (current_method != null) {
							old_coroutine = current_method.coroutine;
							current_method.coroutine = false;
						}

						ccode.add_expression (destroy_local (local));

						if (old_coroutine) {
							current_method.coroutine = true;
						}
					}
				}
			}

			if (b.parent_symbol is Method) {
				var m = (Method) b.parent_symbol;

				// parameters are captured with the top-level block of the method
				foreach (var param in m.get_parameters ()) {
					if (param.captured) {
						var param_type = param.variable_type.copy ();
						if (!param_type.value_owned) {
							param_type.value_owned = !no_implicit_copy (param_type);
						}

						if (requires_destroy (param_type)) {
							bool old_coroutine = false;
							if (m != null) {
								old_coroutine = m.coroutine;
								m.coroutine = false;
							}

							ccode.add_expression (destroy_parameter (param));

							if (old_coroutine) {
								m.coroutine = true;
							}
						}
					}
				}
			} else if (b.parent_symbol is PropertyAccessor) {
				var acc = (PropertyAccessor) b.parent_symbol;

				if (!acc.readable && acc.value_parameter.captured) {
					var param_type = acc.value_parameter.variable_type.copy ();
					if (!param_type.value_owned) {
						param_type.value_owned = !no_implicit_copy (param_type);
					}

					if (requires_destroy (param_type)) {
						ccode.add_expression (destroy_parameter (acc.value_parameter));
					}
				}
			}

			// free parent block and "self" after captured variables
			// because they may require type parameters
			if (parent_block != null) {
				int parent_block_id = get_block_id (parent_block);

				var unref_call = new CCodeFunctionCall (new CCodeIdentifier ("block%d_data_unref".printf (parent_block_id)));
				unref_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "_data%d_".printf (parent_block_id)));
				ccode.add_expression (unref_call);
				ccode.add_assignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (block_id)), "_data%d_".printf (parent_block_id)), new CCodeConstant ("NULL"));
			} else {
				if (get_this_type () != null) {
					// reference count for self is not increased in finalizers
					if (!is_in_destructor ()) {
						var this_value = new GLibValue (get_data_type_for_symbol (current_type_symbol), new CCodeIdentifier ("self"), true);
						ccode.add_expression (destroy_value (this_value));
					}
				}
			}

			var data_free = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_free"));
			data_free.add_argument (new CCodeIdentifier (struct_name));
			data_free.add_argument (new CCodeIdentifier ("_data%d_".printf (block_id)));
			ccode.add_expression (data_free);

			ccode.close ();

			pop_function ();

			cfile.add_function_declaration (unref_fun);
			cfile.add_function (unref_fun);
		}

		foreach (Statement stmt in b.get_statements ()) {
			push_line (stmt.source_reference);
			stmt.emit (this);
			pop_line ();
		}

		// free in reverse order
		for (int i = local_vars.size - 1; i >= 0; i--) {
			var local = local_vars[i];
			local.active = false;
			if (!local.unreachable && !local.floating && !local.captured && requires_destroy (local.variable_type)) {
				ccode.add_expression (destroy_local (local));
			}
		}

		if (b.parent_symbol is Method) {
			var m = (Method) b.parent_symbol;
			foreach (Parameter param in m.get_parameters ()) {
				if (!param.captured && !param.ellipsis && requires_destroy (param.variable_type) && param.direction == ParameterDirection.IN) {
					ccode.add_expression (destroy_parameter (param));
				} else if (param.direction == ParameterDirection.OUT && !m.coroutine) {
					return_out_parameter (param);
				}
			}
			// check postconditions
			foreach (var postcondition in m.get_postconditions ()) {
				create_postcondition_statement (postcondition);
			}
		} else if (b.parent_symbol is PropertyAccessor) {
			var acc = (PropertyAccessor) b.parent_symbol;
			if (acc.value_parameter != null && !acc.value_parameter.captured && requires_destroy (acc.value_parameter.variable_type)) {
				ccode.add_expression (destroy_parameter (acc.value_parameter));
			}
		}

		if (b.captured) {
			int block_id = get_block_id (b);

			var data_unref = new CCodeFunctionCall (new CCodeIdentifier ("block%d_data_unref".printf (block_id)));
			data_unref.add_argument (get_variable_cexpression ("_data%d_".printf (block_id)));
			ccode.add_expression (data_unref);
			ccode.add_assignment (get_variable_cexpression ("_data%d_".printf (block_id)), new CCodeConstant ("NULL"));
		}

		if (b.parent_node is Block || b.parent_node is SwitchStatement || b.parent_node is TryStatement) {
			ccode.close ();
		}

		emit_context.pop_symbol ();
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		stmt.declaration.accept (this);
	}

	public CCodeExpression get_local_cexpression (LocalVariable local) {
		if (is_in_coroutine ()) {
			return new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), get_local_cname (local));
		} else {
			return new CCodeIdentifier (get_local_cname (local));
		}
	}

	public CCodeExpression get_variable_cexpression (string name) {
		if (is_in_coroutine ()) {
			return new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), get_variable_cname (name));
		} else {
			return new CCodeIdentifier (get_variable_cname (name));
		}
	}

	public CCodeExpression get_this_cexpression () {
		if (is_in_coroutine ()) {
			return new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "self");
		} else {
			return new CCodeIdentifier ("self");
		}
	}

	public string get_local_cname (LocalVariable local) {
		var cname = get_variable_cname (local.name);
		if (is_in_coroutine ()) {
			var clash_index = emit_context.closure_variable_clash_map.get (local);
			if (clash_index > 0) {
				cname = "_vala%d_%s".printf (clash_index, cname);
			}
		}
		return cname;
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
		if (is_in_coroutine ()) {
			return new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), cname);
		} else {
			return new CCodeIdentifier (cname);
		}
	}

	public bool is_simple_struct_creation (Variable variable, Expression expr) {
		var st = variable.variable_type.data_type as Struct;
		var creation = expr as ObjectCreationExpression;
		if (creation != null && st != null && (!st.is_simple_type () || get_ccode_name (st) == "va_list") && !variable.variable_type.nullable &&
		    variable.variable_type.data_type != gvalue_type && creation.get_object_initializer ().size == 0) {
			return true;
		} else {
			return false;
		}
	}

	bool is_foreach_element_variable (LocalVariable local) {
		var block = local.parent_symbol;
		if (block != null) {
			var stmt = block.parent_symbol as ForeachStatement;
			if (stmt != null && !stmt.use_iterator && stmt.element_variable == local) {
				return true;
			}
		}
		return false;
	}

	public override void visit_local_variable (LocalVariable local) {
		check_type (local.variable_type);

		/* Declaration */

		generate_type_declaration (local.variable_type, cfile);

		// captured element variables of foreach statements (without iterator) require local declaration
		var declared = !local.captured || is_foreach_element_variable (local);
		if (declared) {
			if (is_in_coroutine ()) {
				var count = emit_context.closure_variable_count_map.get (local.name);
				if (count > 0) {
					emit_context.closure_variable_clash_map.set (local, count);
				}
				emit_context.closure_variable_count_map.set (local.name, count + 1);

				closure_struct.add_field (get_ccode_name (local.variable_type), get_local_cname (local) + get_ccode_declarator_suffix (local.variable_type));
			} else {
				var cvar = new CCodeVariableDeclarator (get_local_cname (local), null, get_ccode_declarator_suffix (local.variable_type));

				// try to initialize uninitialized variables
				// initialization not necessary for variables stored in closure
				cvar.initializer = default_value_for_type (local.variable_type, true);
				cvar.init0 = true;

				ccode.add_declaration (get_ccode_name (local.variable_type), cvar);
			}
		}

		/* Emit initializer */
		if (local.initializer != null) {
			local.initializer.emit (this);

			visit_end_full_expression (local.initializer);
		}


		CCodeExpression rhs = null;
		if (local.initializer != null && get_cvalue (local.initializer) != null) {
			rhs = get_cvalue (local.initializer);
		}

		/* Additional temp variables */

		if (declared) {
			if (local.variable_type is ArrayType) {
				// create variables to store array dimensions
				var array_type = (ArrayType) local.variable_type;

				if (!array_type.fixed_length) {
					for (int dim = 1; dim <= array_type.rank; dim++) {
						var len_var = new LocalVariable (int_type.copy (), get_array_length_cname (get_local_cname (local), dim));
						len_var.no_init = local.initializer != null;
						emit_temp_var (len_var);
					}

					if (array_type.rank == 1) {
						var size_var = new LocalVariable (int_type.copy (), get_array_size_cname (get_local_cname (local)));
						size_var.no_init = local.initializer != null;
						emit_temp_var (size_var);
					}
				}
			} else if (local.variable_type is DelegateType) {
				var deleg_type = (DelegateType) local.variable_type;
				var d = deleg_type.delegate_symbol;
				if (d.has_target) {
					// create variable to store delegate target
					var target_var = new LocalVariable (new PointerType (new VoidType ()), get_delegate_target_cname (get_local_cname (local)));
					target_var.no_init = local.initializer != null;
					emit_temp_var (target_var);
					if (deleg_type.value_owned) {
						var target_destroy_notify_var = new LocalVariable (gdestroynotify_type, get_delegate_target_destroy_notify_cname (get_local_cname (local)));
						target_destroy_notify_var.no_init = local.initializer != null;
						emit_temp_var (target_destroy_notify_var);
					}
				}
			}
		}

		/* Store the initializer */

		if (rhs != null) {
			if (!is_simple_struct_creation (local, local.initializer)) {
				store_local (local, local.initializer.target_value, true);
			}
		}

		if (local.initializer != null && local.initializer.tree_can_fail) {
			add_simple_check (local.initializer);
		}

		local.active = true;
	}

	/**
	 * Create a temporary variable and return lvalue access to it
	 */
	public TargetValue create_temp_value (DataType type, bool init, CodeNode node_reference, bool? value_owned = null) {
		var local = new LocalVariable (type.copy (), "_tmp%d_".printf (next_temp_var_id++), null, node_reference.source_reference);
		local.no_init = !init;
		if (value_owned != null) {
			local.variable_type.value_owned = value_owned;
		}

		var array_type = local.variable_type as ArrayType;
		var deleg_type = local.variable_type as DelegateType;

		emit_temp_var (local);
		if (array_type != null) {
			for (int dim = 1; dim <= array_type.rank; dim++) {
				var len_var = new LocalVariable (int_type.copy (), get_array_length_cname (local.name, dim), null, node_reference.source_reference);
				len_var.no_init = !init;
				emit_temp_var (len_var);
			}
		} else if (deleg_type != null && deleg_type.delegate_symbol.has_target) {
			var target_var = new LocalVariable (new PointerType (new VoidType ()), get_delegate_target_cname (local.name), null, node_reference.source_reference);
			target_var.no_init = !init;
			emit_temp_var (target_var);
			if (deleg_type.value_owned) {
				var target_destroy_notify_var = new LocalVariable (gdestroynotify_type.copy (), get_delegate_target_destroy_notify_cname (local.name), null, node_reference.source_reference);
				target_destroy_notify_var.no_init = !init;
				emit_temp_var (target_destroy_notify_var);
			}
		}

		var value = get_local_cvalue (local);
		set_array_size_cvalue (value, null);
		return value;
	}

	/**
	 * Load a temporary variable returning unowned or owned rvalue access to it, depending on the ownership of the value type.
	 */
	public TargetValue load_temp_value (TargetValue lvalue) {
		var value = ((GLibValue) lvalue).copy ();
		var deleg_type = value.value_type as DelegateType;
		if (deleg_type != null) {
			if (!deleg_type.delegate_symbol.has_target) {
				value.delegate_target_cvalue = new CCodeConstant ("NULL");
				((GLibValue) value).lvalue = false;
			} else if (!deleg_type.is_disposable ()) {
				value.delegate_target_destroy_notify_cvalue = new CCodeConstant ("NULL");
				((GLibValue) value).lvalue = false;
			}
		}
		return value;
	}

	/**
	 * Store a value in a temporary variable and return unowned or owned rvalue access to it, depending on the ownership of the given type.
	 */
	public TargetValue store_temp_value (TargetValue initializer, CodeNode node_reference, bool? value_owned = null) {
		var lvalue = create_temp_value (initializer.value_type, false, node_reference, value_owned);
		store_value (lvalue, initializer);
		return load_temp_value (lvalue);
	}

	public override void visit_initializer_list (InitializerList list) {
		if (list.target_type.data_type is Struct) {
			/* initializer is used as struct initializer */
			var st = (Struct) list.target_type.data_type;
			while (st.base_struct != null) {
				st = st.base_struct;
			}

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

					var cexpr = get_cvalue (expr);

					string ctype = get_ccode_type (field);
					if (ctype != null) {
						cexpr = new CCodeCastExpression (cexpr, ctype);
					}

					clist.append (cexpr);

					var array_type = field.variable_type as ArrayType;
					if (array_type != null && get_ccode_array_length (field) && !get_ccode_array_null_terminated (field)) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							clist.append (get_array_length_cvalue (expr.target_value, dim));
						}
					}
				}

				set_cvalue (list, clist);
			} else {
				// used as expression
				var instance = create_temp_value (list.value_type, true, list);

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

					store_field (field, instance, expr.target_value);
				}

				list.target_value = instance;
			}
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

	void require_generic_accessors (Interface iface) {
		if (iface.get_attribute ("GenericAccessors") == null) {
			Report.error (iface.source_reference,
			              "missing generic type for interface `%s', add GenericAccessors attribute to interface declaration"
			              .printf (iface.get_full_name ()));
		}
	}

	public CCodeExpression get_type_id_expression (DataType type, bool is_chainup = false) {
		if (type is GenericType) {
			string var_name = "%s_type".printf (type.type_parameter.name.down ());

			if (type.type_parameter.parent_symbol is Interface) {
				var iface = (Interface) type.type_parameter.parent_symbol;
				require_generic_accessors (iface);

				string method_name = "get_%s_type".printf (type.type_parameter.name.down ());
				var cast_self = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_INTERFACE".printf (get_ccode_upper_case_name (iface))));
				cast_self.add_argument (new CCodeIdentifier ("self"));
				var function_call = new CCodeFunctionCall (new CCodeMemberAccess.pointer (cast_self, method_name));
				function_call.add_argument (new CCodeIdentifier ("self"));
				return function_call;
			}

			if (is_in_generic_type (type) && !is_chainup && !in_creation_method) {
				return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (get_result_cexpression ("self"), "priv"), var_name);
			} else {
				return get_variable_cexpression (var_name);
			}
		} else {
			string type_id = get_ccode_type_id (type);
			if (type_id == "") {
				type_id = "G_TYPE_INVALID";
			} else {
				generate_type_declaration (type, cfile);
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
			if (is_reference_counting (type.data_type)) {
				dup_function = get_ccode_ref_function ((ObjectTypeSymbol) type.data_type);
				if (type.data_type is Interface && dup_function == null) {
					Report.error (source_reference, "missing class prerequisite for interface `%s', add GLib.Object to interface declaration if unsure".printf (type.data_type.get_full_name ()));
					return null;
				}
			} else if (cl != null && cl.is_immutable) {
				// allow duplicates of immutable instances as for example strings
				dup_function = get_ccode_dup_function (type.data_type);
				if (dup_function == null) {
					dup_function = "";
				}
			} else if (cl != null && get_ccode_is_gboxed (cl)) {
				// allow duplicates of gboxed instances
				dup_function = generate_dup_func_wrapper (type);
				if (dup_function == null) {
					dup_function = "";
				}
			} else if (type is ValueType) {
				dup_function = get_ccode_dup_function (type.data_type);
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

			if (type.type_parameter.parent_symbol is Interface) {
				var iface = (Interface) type.type_parameter.parent_symbol;
				require_generic_accessors (iface);

				string method_name = "get_%s_dup_func".printf (type.type_parameter.name.down ());
				var cast_self = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_INTERFACE".printf (get_ccode_upper_case_name (iface))));
				cast_self.add_argument (new CCodeIdentifier ("self"));
				var function_call = new CCodeFunctionCall (new CCodeMemberAccess.pointer (cast_self, method_name));
				function_call.add_argument (new CCodeIdentifier ("self"));
				return function_call;
			}

			if (is_in_generic_type (type) && !is_chainup && !in_creation_method) {
				return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (get_result_cexpression ("self"), "priv"), func_name);
			} else {
				return get_variable_cexpression (func_name);
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
		string equal_func = "_%sequal".printf (get_ccode_lower_case_prefix (st));

		if (!add_wrapper (equal_func)) {
			// wrapper already defined
			return equal_func;
		}

		if (st.base_struct != null) {
			return generate_struct_equal_function (st.base_struct);
		}

		var function = new CCodeFunction (equal_func, "gboolean");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("s1", "const " + get_ccode_name (st) + "*"));
		function.add_parameter (new CCodeParameter ("s2", "const " + get_ccode_name (st) + "*"));

		push_function (function);

		// if (s1 == s2) return TRUE;
		{
			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s1"), new CCodeIdentifier ("s2"));
			ccode.open_if (cexp);
			ccode.add_return (new CCodeConstant ("TRUE"));
			ccode.close ();
		}
		// if (s1 == NULL || s2 == NULL) return FALSE;
		{
			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s1"), new CCodeConstant ("NULL"));
			ccode.open_if (cexp);
			ccode.add_return (new CCodeConstant ("FALSE"));
			ccode.close ();

			cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s2"), new CCodeConstant ("NULL"));
			ccode.open_if (cexp);
			ccode.add_return (new CCodeConstant ("FALSE"));
			ccode.close ();
		}

		bool has_instance_fields = false;
		foreach (Field f in st.get_fields ()) {
			if (f.binding != MemberBinding.INSTANCE) {
				// we only compare instance fields
				continue;
			}

			has_instance_fields = true;

			CCodeExpression cexp; // if (cexp) return FALSE;
			var s1 = (CCodeExpression) new CCodeMemberAccess.pointer (new CCodeIdentifier ("s1"), f.name); // s1->f
			var s2 = (CCodeExpression) new CCodeMemberAccess.pointer (new CCodeIdentifier ("s2"), f.name); // s2->f

			var variable_type = f.variable_type.copy ();
			make_comparable_cexpression (ref variable_type, ref s1, ref variable_type, ref s2);

			if (!(f.variable_type is NullType) && f.variable_type.compatible (string_type)) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_strcmp0"));
				ccall.add_argument (s1);
				ccall.add_argument (s2);
				cexp = ccall;
			} else if (f.variable_type is StructValueType) {
				var equalfunc = generate_struct_equal_function (f.variable_type.data_type as Struct);
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (equalfunc));
				ccall.add_argument (s1);
				ccall.add_argument (s2);
				cexp = new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, ccall);
			} else {
				cexp = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, s1, s2);
			}

			ccode.open_if (cexp);
			ccode.add_return (new CCodeConstant ("FALSE"));
			ccode.close ();
		}

		if (!has_instance_fields) {
			// either opaque structure or simple type
			if (st.is_simple_type ()) {
				var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("s1")), new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("s2")));
				ccode.add_return (cexp);
			} else {
				ccode.add_return (new CCodeConstant ("FALSE"));
			}
		} else {
			ccode.add_return (new CCodeConstant ("TRUE"));
		}

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return equal_func;
	}

	private string generate_numeric_equal_function (TypeSymbol sym) {
		string equal_func = "_%sequal".printf (get_ccode_lower_case_prefix (sym));

		if (!add_wrapper (equal_func)) {
			// wrapper already defined
			return equal_func;
		}

		var function = new CCodeFunction (equal_func, "gboolean");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("s1", "const " + get_ccode_name (sym) + "*"));
		function.add_parameter (new CCodeParameter ("s2", "const " + get_ccode_name (sym) + "*"));

		push_function (function);

		// if (s1 == s2) return TRUE;
		{
			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s1"), new CCodeIdentifier ("s2"));
			ccode.open_if (cexp);
			ccode.add_return (new CCodeConstant ("TRUE"));
			ccode.close ();
		}
		// if (s1 == NULL || s2 == NULL) return FALSE;
		{
			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s1"), new CCodeConstant ("NULL"));
			ccode.open_if (cexp);
			ccode.add_return (new CCodeConstant ("FALSE"));
			ccode.close ();

			cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s2"), new CCodeConstant ("NULL"));
			ccode.open_if (cexp);
			ccode.add_return (new CCodeConstant ("FALSE"));
			ccode.close ();
		}
		// return (*s1 == *s2);
		{
			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("s1")), new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("s2")));
			ccode.add_return (cexp);
		}

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return equal_func;
	}

	private string generate_struct_dup_wrapper (ValueType value_type) {
		string dup_func = "_%sdup".printf (get_ccode_lower_case_prefix (value_type.type_symbol));

		if (!add_wrapper (dup_func)) {
			// wrapper already defined
			return dup_func;
		}

		var function = new CCodeFunction (dup_func, get_ccode_name (value_type));
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("self", get_ccode_name (value_type)));

		push_function (function);

		if (value_type.type_symbol == gvalue_type) {
			var dup_call = new CCodeFunctionCall (new CCodeIdentifier ("g_boxed_copy"));
			dup_call.add_argument (new CCodeIdentifier ("G_TYPE_VALUE"));
			dup_call.add_argument (new CCodeIdentifier ("self"));

			ccode.add_return (dup_call);
		} else {
			ccode.add_declaration (get_ccode_name (value_type), new CCodeVariableDeclarator ("dup"));

			var creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
			creation_call.add_argument (new CCodeConstant (get_ccode_name (value_type.data_type)));
			creation_call.add_argument (new CCodeConstant ("1"));
			ccode.add_assignment (new CCodeIdentifier ("dup"), creation_call);

			var st = value_type.data_type as Struct;
			if (st != null && st.is_disposable ()) {
				if (!get_ccode_has_copy_function (st)) {
					generate_struct_copy_function (st);
				}

				var copy_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_copy_function (st)));
				copy_call.add_argument (new CCodeIdentifier ("self"));
				copy_call.add_argument (new CCodeIdentifier ("dup"));
				ccode.add_expression (copy_call);
			} else {
				cfile.add_include ("string.h");

				var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				sizeof_call.add_argument (new CCodeConstant (get_ccode_name (value_type.data_type)));

				var copy_call = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
				copy_call.add_argument (new CCodeIdentifier ("dup"));
				copy_call.add_argument (new CCodeIdentifier ("self"));
				copy_call.add_argument (sizeof_call);
				ccode.add_expression (copy_call);
			}

			ccode.add_return (new CCodeIdentifier ("dup"));
		}

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return dup_func;
	}

	protected string generate_dup_func_wrapper (DataType type) {
		string destroy_func = "_vala_%s_copy".printf (get_ccode_name (type.data_type));

		if (!add_wrapper (destroy_func)) {
			// wrapper already defined
			return destroy_func;
		}

		var function = new CCodeFunction (destroy_func, get_ccode_name (type));
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeParameter ("self", get_ccode_name (type)));

		push_function (function);

		var cl = type.data_type as Class;
		assert (cl != null && get_ccode_is_gboxed (cl));

		var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_boxed_copy"));
		free_call.add_argument (new CCodeIdentifier (get_ccode_type_id (cl)));
		free_call.add_argument (new CCodeIdentifier ("self"));

		ccode.add_return (free_call);

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return destroy_func;
	}

	protected string generate_free_function_address_of_wrapper (DataType type) {
		string destroy_func = "_vala_%s_free_function_address_of".printf (get_ccode_name (type.data_type));

		if (!add_wrapper (destroy_func)) {
			// wrapper already defined
			return destroy_func;
		}

		var function = new CCodeFunction (destroy_func, "void");
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeParameter ("self", get_ccode_name (type)));

		push_function (function);

		var cl = type.data_type as Class;
		var free_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_free_function (cl)));
		free_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("self")));

		ccode.add_expression (free_call);

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return destroy_func;
	}

	protected string generate_free_func_wrapper (DataType type) {
		string destroy_func = "_vala_%s_free".printf (get_ccode_name (type.data_type));

		if (!add_wrapper (destroy_func)) {
			// wrapper already defined
			return destroy_func;
		}

		var function = new CCodeFunction (destroy_func, "void");
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeParameter ("self", get_ccode_name (type)));

		push_function (function);

		var cl = type.data_type as Class;
		if (cl != null && get_ccode_is_gboxed (cl)) {
			var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_boxed_free"));
			free_call.add_argument (new CCodeIdentifier (get_ccode_type_id (cl)));
			free_call.add_argument (new CCodeIdentifier ("self"));

			ccode.add_expression (free_call);
		} else {
			var st = type.data_type as Struct;
			if (st != null && st.is_disposable ()) {
				if (!get_ccode_has_destroy_function (st)) {
					generate_struct_destroy_function (st);
				}

				var destroy_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_destroy_function (st)));
				destroy_call.add_argument (new CCodeIdentifier ("self"));
				ccode.add_expression (destroy_call);
			}

			var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
			free_call.add_argument (new CCodeIdentifier ("self"));

			ccode.add_expression (free_call);
		}

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return destroy_func;
	}

	public CCodeExpression? get_destroy0_func_expression (DataType type, bool is_chainup = false) {
		var element_destroy_func_expression = get_destroy_func_expression (type, is_chainup);

		if (element_destroy_func_expression is CCodeIdentifier) {
			var freeid = (CCodeIdentifier) element_destroy_func_expression;
			string free0_func = "_%s0_".printf (freeid.name);

			if (add_wrapper (free0_func)) {
				var function = new CCodeFunction (free0_func, "void");
				function.modifiers = CCodeModifiers.STATIC;

				function.add_parameter (new CCodeParameter ("var", "gpointer"));

				push_function (function);

				ccode.add_expression (destroy_value (new GLibValue (type, new CCodeIdentifier ("var"), true), true));

				pop_function ();

				cfile.add_function_declaration (function);
				cfile.add_function (function);
			}

			element_destroy_func_expression = new CCodeIdentifier (free0_func);
		}

		return element_destroy_func_expression;
	}

	public CCodeExpression? get_destroy_func_expression (DataType type, bool is_chainup = false) {
		if (type.data_type == glist_type || type.data_type == gslist_type || type.data_type == gnode_type || type.data_type == gqueue_type) {
			// create wrapper function to free list elements if necessary

			bool elements_require_free = false;
			CCodeExpression element_destroy_func_expression = null;

			foreach (DataType type_arg in type.get_type_arguments ()) {
				elements_require_free = requires_destroy (type_arg);
				if (elements_require_free) {
					element_destroy_func_expression = get_destroy0_func_expression (type_arg);
				}
			}
			
			if (elements_require_free && element_destroy_func_expression is CCodeIdentifier) {
				return new CCodeIdentifier (generate_collection_free_wrapper (type, (CCodeIdentifier) element_destroy_func_expression));
			} else {
				return new CCodeIdentifier (get_ccode_free_function (type.data_type));
			}
		} else if (type is ErrorType) {
			return new CCodeIdentifier ("g_error_free");
		} else if (type.data_type != null) {
			string unref_function;
			if (type is ReferenceType) {
				if (is_reference_counting (type.data_type)) {
					unref_function = get_ccode_unref_function ((ObjectTypeSymbol) type.data_type);
					if (type.data_type is Interface && unref_function == null) {
						Report.error (type.source_reference, "missing class prerequisite for interface `%s', add GLib.Object to interface declaration if unsure".printf (type.data_type.get_full_name ()));
						return null;
					}
				} else {
					var cl = type.data_type as Class;
					if (cl != null && get_ccode_is_gboxed (cl)) {
						unref_function = generate_free_func_wrapper (type);
					} else {
						if (is_free_function_address_of (type)) {
							unref_function = generate_free_function_address_of_wrapper (type);
						} else {
							unref_function = get_ccode_free_function (type.data_type);
						}
					}
				}
			} else {
				if (type.nullable) {
					unref_function = get_ccode_free_function (type.data_type);
					if (unref_function == null) {
						if (type.data_type is Struct && ((Struct) type.data_type).is_disposable ()) {
							unref_function = generate_free_func_wrapper (type);
						} else {
							unref_function = "g_free";
						}
					}
				} else {
					var st = (Struct) type.data_type;
					if (!get_ccode_has_destroy_function (st)) {
						generate_struct_destroy_function (st);
					}
					unref_function = get_ccode_destroy_function (st);
				}
			}
			if (unref_function == null) {
				return new CCodeConstant ("NULL");
			}
			return new CCodeIdentifier (unref_function);
		} else if (type.type_parameter != null) {
			string func_name = "%s_destroy_func".printf (type.type_parameter.name.down ());

			if (type.type_parameter.parent_symbol is Interface) {
				var iface = (Interface) type.type_parameter.parent_symbol;
				require_generic_accessors (iface);

				string method_name = "get_%s_destroy_func".printf (type.type_parameter.name.down ());
				var cast_self = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_INTERFACE".printf (get_ccode_upper_case_name (iface))));
				cast_self.add_argument (new CCodeIdentifier ("self"));
				var function_call = new CCodeFunctionCall (new CCodeMemberAccess.pointer (cast_self, method_name));
				function_call.add_argument (new CCodeIdentifier ("self"));
				return function_call;
			}

			if (is_in_generic_type (type) && !is_chainup && !in_creation_method) {
				return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (get_result_cexpression ("self"), "priv"), func_name);
			} else {
				return get_variable_cexpression (func_name);
			}
		} else if (type is ArrayType) {
			return new CCodeIdentifier ("g_free");
		} else if (type is PointerType) {
			return new CCodeIdentifier ("g_free");
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	private string generate_collection_free_wrapper (DataType collection_type, CCodeIdentifier element_destroy_func_expression) {
		string destroy_func = "_%s_%s".printf (get_ccode_free_function (collection_type.data_type), element_destroy_func_expression.name);

		if (!add_wrapper (destroy_func)) {
			// wrapper already defined
			return destroy_func;
		}

		var function = new CCodeFunction (destroy_func, "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("self", get_ccode_name (collection_type)));

		push_function (function);

		CCodeFunctionCall element_free_call;
		if (collection_type.data_type == gnode_type) {
			/* A wrapper which converts GNodeTraverseFunc into GDestroyNotify */
			string destroy_node_func = "%s_node".printf (destroy_func);
			var wrapper = new CCodeFunction (destroy_node_func, "gboolean");
			wrapper.modifiers = CCodeModifiers.STATIC;
			wrapper.add_parameter (new CCodeParameter ("node", get_ccode_name (collection_type)));
			wrapper.add_parameter (new CCodeParameter ("unused", "gpointer"));
			push_function (wrapper);

			var free_call = new CCodeFunctionCall (element_destroy_func_expression);
			free_call.add_argument (new CCodeMemberAccess.pointer(new CCodeIdentifier("node"), "data"));
			ccode.add_expression (free_call);
			ccode.add_return (new CCodeConstant ("FALSE"));

			pop_function ();
			cfile.add_function_declaration (function);
			cfile.add_function (wrapper);

			/* Now the code to call g_traverse with the above */
			element_free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_node_traverse"));
			element_free_call.add_argument (new CCodeIdentifier("self"));
			element_free_call.add_argument (new CCodeConstant ("G_POST_ORDER"));
			element_free_call.add_argument (new CCodeConstant ("G_TRAVERSE_ALL"));
			element_free_call.add_argument (new CCodeConstant ("-1"));
			element_free_call.add_argument (new CCodeIdentifier (destroy_node_func));
			element_free_call.add_argument (new CCodeConstant ("NULL"));
		} else {
			if (collection_type.data_type == glist_type) {
				element_free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_list_foreach"));
			} else if (collection_type.data_type == gslist_type) {
				element_free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_slist_foreach"));
			} else {
				element_free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_queue_foreach"));
			}

			element_free_call.add_argument (new CCodeIdentifier ("self"));
			element_free_call.add_argument (new CCodeCastExpression (element_destroy_func_expression, "GFunc"));
			element_free_call.add_argument (new CCodeConstant ("NULL"));
		}

		ccode.add_expression (element_free_call);

		var cfreecall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_free_function (collection_type.data_type)));
		cfreecall.add_argument (new CCodeIdentifier ("self"));
		ccode.add_expression (cfreecall);

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return destroy_func;
	}

	public virtual string? append_struct_array_free (Struct st) {
		return null;
	}

	public CCodeExpression destroy_local (LocalVariable local) {
		return destroy_value (get_local_cvalue (local));
	}

	public CCodeExpression destroy_parameter (Parameter param) {
		return destroy_value (get_parameter_cvalue (param));
	}

	public CCodeExpression destroy_field (Field field, TargetValue? instance) {
		return destroy_value (get_field_cvalue (field, instance));
	}

	public virtual CCodeExpression destroy_value (TargetValue value, bool is_macro_definition = false) {
		var type = value.value_type;
		if (value.actual_value_type != null) {
			type = value.actual_value_type;
		}
		var cvar = get_cvalue_ (value);

		if (type is DelegateType) {
			var delegate_target = get_delegate_target_cvalue (value);
			var delegate_target_destroy_notify = get_delegate_target_destroy_notify_cvalue (value);

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
			} else if (context.require_glib_version (2, 32) &&
			           (type.data_type == gmutex_type ||
			            type.data_type == grecmutex_type ||
			            type.data_type == grwlock_type ||
			            type.data_type == gcond_type)) {
				// g_mutex_clear must not be called for uninitialized mutex
				// also, g_mutex_clear does not clear the struct
				requires_clear_mutex = true;
				ccall.call = new CCodeIdentifier ("_vala_clear_" + get_ccode_name (type.data_type));
				return ccall;
			} else {
				return ccall;
			}
		}

		if (ccall.call is CCodeIdentifier && !(type is ArrayType) && !is_macro_definition) {
			// generate and use NULL-aware free macro to simplify code

			var freeid = (CCodeIdentifier) ccall.call;
			string free0_func = "_%s0".printf (freeid.name);

			if (add_wrapper (free0_func)) {
				var macro = destroy_value (new GLibValue (type, new CCodeIdentifier ("var"), true), true);
				cfile.add_type_declaration (new CCodeMacroReplacement.with_expression ("%s(var)".printf (free0_func), macro));
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
			var parent = type.type_parameter.parent_symbol;
			var cl = parent as Class;
			if ((!(parent is Method) && !(parent is ObjectTypeSymbol)) || (cl != null && cl.is_compact)) {
				return new CCodeConstant ("NULL");
			}

			// unref functions are optional for type parameters
			var cunrefisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, get_destroy_func_expression (type), new CCodeConstant ("NULL"));
			cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cisnull, cunrefisnull);
		}

		ccall.add_argument (cvar);

		/* set freed references to NULL to prevent further use */
		var ccomma = new CCodeCommaExpression ();

		if (type.data_type != null && !is_reference_counting (type.data_type) &&
		    (type.data_type.is_subtype_of (gstringbuilder_type)
		     || type.data_type.is_subtype_of (garray_type)
		     || type.data_type.is_subtype_of (gbytearray_type)
		     || type.data_type.is_subtype_of (gptrarray_type))) {
			ccall.add_argument (new CCodeConstant ("TRUE"));
		} else if (type.data_type == gthreadpool_type) {
			ccall.add_argument (new CCodeConstant ("FALSE"));
			ccall.add_argument (new CCodeConstant ("TRUE"));
		} else if (type is ArrayType) {
			var array_type = (ArrayType) type;
			if (requires_destroy (array_type.element_type)) {
				CCodeExpression csizeexpr = null;
				if (((GLibValue) value).array_length_cvalues != null) {
					csizeexpr = get_array_length_cvalue (value);
				} else if (get_array_null_terminated (value)) {
					requires_array_length = true;
					var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
					len_call.add_argument (cvar);
					csizeexpr = len_call;
				} else {
					csizeexpr = get_array_length_cexpr (value);
				}

				if (csizeexpr != null) {
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
		bool uses_gfree = (type.data_type != null && !is_reference_counting (type.data_type) && get_ccode_free_function (type.data_type) == "g_free");
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
		if (temp_ref_values.size == 0) {
			/* nothing to do without temporary variables */
			return;
		}

		var local_decl = expr.parent_node as LocalVariable;
		if (!(local_decl != null && is_simple_struct_creation (local_decl, local_decl.initializer))) {
			expr.target_value = store_temp_value (expr.target_value, expr);
		}

		foreach (var value in temp_ref_values) {
			ccode.add_expression (destroy_value (value));
		}

		temp_ref_values.clear ();
	}
	
	public void emit_temp_var (LocalVariable local) {
		if (is_in_coroutine ()) {
			closure_struct.add_field (get_ccode_name (local.variable_type), local.name);

			// even though closure struct is zerod, we need to initialize temporary variables
			// as they might be used multiple times when declared in a loop

			var initializer = default_value_for_type (local.variable_type, false);
			if (initializer == null) {
				cfile.add_include ("string.h");
				var memset_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
				memset_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (local.name)));
				memset_call.add_argument (new CCodeConstant ("0"));
				memset_call.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (get_ccode_name (local.variable_type))));
				ccode.add_expression (memset_call);
			} else {
				ccode.add_assignment (get_variable_cexpression (local.name), initializer);
			}
		} else {
			var cvar = new CCodeVariableDeclarator (local.name, null, get_ccode_declarator_suffix (local.variable_type));
			cvar.initializer = default_value_for_type (local.variable_type, true);
			cvar.init0 = true;
			ccode.add_declaration (get_ccode_name (local.variable_type), cvar);
		}
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		if (stmt.expression.error) {
			stmt.error = true;
			return;
		}

		/* free temporary objects and handle errors */

		foreach (var value in temp_ref_values) {
			ccode.add_expression (destroy_value (value));
		}

		if (stmt.tree_can_fail && stmt.expression.tree_can_fail) {
			// simple case, no node breakdown necessary
			add_simple_check (stmt.expression);
		}

		temp_ref_values.clear ();
	}

	protected virtual void append_scope_free (Symbol sym, CodeNode? stop_at = null) {
		var b = (Block) sym;

		var local_vars = b.get_local_variables ();
		// free in reverse order
		for (int i = local_vars.size - 1; i >= 0; i--) {
			var local = local_vars[i];
			if (!local.unreachable && local.active && !local.floating && !local.captured && requires_destroy (local.variable_type)) {
				ccode.add_expression (destroy_local (local));
			}
		}

		if (b.captured) {
			int block_id = get_block_id (b);

			var data_unref = new CCodeFunctionCall (new CCodeIdentifier ("block%d_data_unref".printf (block_id)));
			data_unref.add_argument (get_variable_cexpression ("_data%d_".printf (block_id)));
			ccode.add_expression (data_unref);
			ccode.add_assignment (get_variable_cexpression ("_data%d_".printf (block_id)), new CCodeConstant ("NULL"));
		}
	}

	public void append_local_free (Symbol sym, bool stop_at_loop = false, CodeNode? stop_at = null) {
		var b = (Block) sym;

		append_scope_free (sym, stop_at);

		if (stop_at_loop) {
			if (b.parent_node is Loop ||
			    b.parent_node is ForeachStatement ||
			    b.parent_node is SwitchStatement) {
				return;
			}
		}

		if (stop_at != null && b.parent_node == stop_at) {
			return;
		}

		if (sym.parent_symbol is Block) {
			append_local_free (sym.parent_symbol, stop_at_loop, stop_at);
		} else if (sym.parent_symbol is Method) {
			append_param_free ((Method) sym.parent_symbol);
		} else if (sym.parent_symbol is PropertyAccessor) {
			var acc = (PropertyAccessor) sym.parent_symbol;
			if (acc.value_parameter != null && requires_destroy (acc.value_parameter.variable_type)) {
				ccode.add_expression (destroy_parameter (acc.value_parameter));
			}
		}
	}

	private void append_param_free (Method m) {
		foreach (Parameter param in m.get_parameters ()) {
			if (!param.captured && !param.ellipsis && requires_destroy (param.variable_type) && param.direction == ParameterDirection.IN) {
				ccode.add_expression (destroy_parameter (param));
			}
		}
	}

	public bool variable_accessible_in_finally (LocalVariable local) {
		if (current_try == null) {
			return false;
		}

		var sym = current_symbol;

		while (!(sym is Method || sym is PropertyAccessor) && sym.scope.lookup (local.name) == null) {
			if ((sym.parent_node is TryStatement && ((TryStatement) sym.parent_node).finally_body != null) ||
				(sym.parent_node is CatchClause && ((TryStatement) sym.parent_node.parent_node).finally_body != null)) {

				return true;
			}

			sym = sym.parent_symbol;
		}

		return false;
	}

	public void return_out_parameter (Parameter param) {
		var delegate_type = param.variable_type as DelegateType;

		var value = get_parameter_cvalue (param);

		var old_coroutine = is_in_coroutine ();
		current_method.coroutine = false;

		ccode.open_if (get_variable_cexpression (param.name));
		ccode.add_assignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_variable_cexpression (param.name)), get_cvalue_ (value));

		if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
			ccode.add_assignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_variable_cexpression (get_ccode_delegate_target_name (param))), get_delegate_target_cvalue (value));
			if (delegate_type.is_disposable ()) {
				ccode.add_assignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_variable_cexpression (get_delegate_target_destroy_notify_cname (param.name))), get_delegate_target_destroy_notify_cvalue (get_parameter_cvalue (param)));
			}
		}

		if (param.variable_type.is_disposable ()){
			ccode.add_else ();
			current_method.coroutine = old_coroutine;
			ccode.add_expression (destroy_parameter (param));
			current_method.coroutine = false;
		}
		ccode.close ();

		var array_type = param.variable_type as ArrayType;
		if (array_type != null && !array_type.fixed_length && get_ccode_array_length (param)) {
			for (int dim = 1; dim <= array_type.rank; dim++) {
				ccode.open_if (get_variable_cexpression (get_parameter_array_length_cname (param, dim)));
				ccode.add_assignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_variable_cexpression (get_parameter_array_length_cname (param, dim))), get_array_length_cvalue (value, dim));
				ccode.close ();
			}
		}

		current_method.coroutine = old_coroutine;
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		Symbol return_expression_symbol = null;

		if (stmt.return_expression != null) {
			// avoid unnecessary ref/unref pair
			var local = stmt.return_expression.symbol_reference as LocalVariable;
			if (local != null && !local.active) {
				/* return expression is local variable taking ownership and
				 * current method is transferring ownership */

				return_expression_symbol = local;
			}
		}

		// return array length if appropriate
		if (((current_method != null && get_ccode_array_length (current_method)) || current_property_accessor != null) && current_return_type is ArrayType) {
			var temp_value = store_temp_value (stmt.return_expression.target_value, stmt);

			var array_type = (ArrayType) current_return_type;
			for (int dim = 1; dim <= array_type.rank; dim++) {
				var len_l = get_result_cexpression (get_array_length_cname ("result", dim));
				var len_r = get_array_length_cvalue (temp_value, dim);
				if (!is_in_coroutine ()) {
					ccode.open_if (len_l);
					len_l = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, len_l);
					ccode.add_assignment (len_l, len_r);
					ccode.close ();
				} else {
					ccode.add_assignment (len_l, len_r);
				}
			}

			stmt.return_expression.target_value = temp_value;
		} else if ((current_method != null || current_property_accessor != null) && current_return_type is DelegateType) {
			var delegate_type = (DelegateType) current_return_type;
			if (delegate_type.delegate_symbol.has_target) {
				var temp_value = store_temp_value (stmt.return_expression.target_value, stmt);

				var target_l = get_result_cexpression (get_delegate_target_cname ("result"));
				if (!is_in_coroutine ()) {
					target_l = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, target_l);
				}
				var target_r = get_delegate_target_cvalue (temp_value);
				ccode.add_assignment (target_l, target_r);
				if (delegate_type.is_disposable ()) {
					var target_l_destroy_notify = get_result_cexpression (get_delegate_target_destroy_notify_cname ("result"));
					if (!is_in_coroutine ()) {
						target_l_destroy_notify = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, target_l_destroy_notify);
					}
					var target_r_destroy_notify = get_delegate_target_destroy_notify_cvalue (temp_value);
					ccode.add_assignment (target_l_destroy_notify, target_r_destroy_notify);
				}

				stmt.return_expression.target_value = temp_value;
			}
		}

		if (stmt.return_expression != null) {
			// assign method result to `result'
			CCodeExpression result_lhs = get_result_cexpression ();
			if (current_return_type.is_real_non_null_struct_type () && !is_in_coroutine ()) {
				result_lhs = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, result_lhs);
			}
			ccode.add_assignment (result_lhs, get_cvalue (stmt.return_expression));
		}

		// free local variables
		append_local_free (current_symbol);

		if (current_method != null) {
			// check postconditions
			foreach (Expression postcondition in current_method.get_postconditions ()) {
				create_postcondition_statement (postcondition);
			}
		}

		if (current_method != null && !current_method.coroutine) {
			// assign values to output parameters if they are not NULL
			// otherwise, free the value if necessary
			foreach (var param in current_method.get_parameters ()) {
				if (param.direction != ParameterDirection.OUT) {
					continue;
				}

				return_out_parameter (param);
			}
		}

		if (current_method != null && current_method.get_attribute ("Profile") != null) {
			string prefix = "_vala_prof_%s".printf (get_ccode_real_name (current_method));

			var timer = new CCodeIdentifier (prefix + "_timer");

			var stop_call = new CCodeFunctionCall (new CCodeIdentifier ("g_timer_stop"));
			stop_call.add_argument (timer);
			ccode.add_expression (stop_call);
		}

		if (is_in_constructor ()) {
			ccode.add_return (new CCodeIdentifier ("obj"));
		} else if (is_in_destructor ()) {
			// do not call return as member cleanup and chain up to base finalizer
			// stil need to be executed
			ccode.add_goto ("_return");
		} else if (is_in_coroutine ()) {
		} else if (current_method is CreationMethod) {
			ccode.add_return (new CCodeIdentifier ("self"));
		} else if (current_return_type is VoidType || current_return_type.is_real_non_null_struct_type ()) {
			// structs are returned via out parameter
			ccode.add_return ();
		} else {
			ccode.add_return (new CCodeIdentifier ("result"));
		}

		if (return_expression_symbol != null) {
			return_expression_symbol.active = true;
		}

		// required for destructors
		current_method_return = true;
	}

	public string get_symbol_lock_name (string symname) {
		return "__lock_%s".printf (symname);
	}

	private CCodeExpression get_lock_expression (Statement stmt, Expression resource) {
		CCodeExpression l = null;
		var inner_node = ((MemberAccess)resource).inner;
		var member = resource.symbol_reference;
		var parent = (TypeSymbol)resource.symbol_reference.parent_symbol;
		
		if (member.is_instance_member ()) {
			if (inner_node  == null) {
				l = new CCodeIdentifier ("self");
			} else if (resource.symbol_reference.parent_symbol != current_type_symbol) {
				l = generate_instance_cast (get_cvalue (inner_node), parent);
			} else {
				l = get_cvalue (inner_node);
			}

			l = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (l, "priv"), get_symbol_lock_name (resource.symbol_reference.name));
		} else if (member.is_class_member ()) {
			CCodeExpression klass;

			if (get_this_type () != null) {
				var k = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT_GET_CLASS"));
				k.add_argument (new CCodeIdentifier ("self"));
				klass = k;
			} else {
				klass = new CCodeIdentifier ("klass");
			}

			var get_class_private_call = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS_PRIVATE".printf(get_ccode_upper_case_name (parent))));
			get_class_private_call.add_argument (klass);
			l = new CCodeMemberAccess.pointer (get_class_private_call, get_symbol_lock_name (resource.symbol_reference.name));
		} else {
			string lock_name = "%s_%s".printf(get_ccode_lower_case_name (parent), resource.symbol_reference.name);
			l = new CCodeIdentifier (get_symbol_lock_name (lock_name));
		}
		return l;
	}
		
	public override void visit_lock_statement (LockStatement stmt) {
		var l = get_lock_expression (stmt, stmt.resource);

		var fc = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_name (mutex_type.scope.lookup ("lock"))));
		fc.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));

		ccode.add_expression (fc);
	}
		
	public override void visit_unlock_statement (UnlockStatement stmt) {
		var l = get_lock_expression (stmt, stmt.resource);
		
		var fc = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_name (mutex_type.scope.lookup ("unlock"))));
		fc.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));
		
		ccode.add_expression (fc);
	}

	public override void visit_delete_statement (DeleteStatement stmt) {
		var pointer_type = (PointerType) stmt.expression.value_type;
		DataType type = pointer_type;
		if (pointer_type.base_type.data_type != null && pointer_type.base_type.data_type.is_reference_type ()) {
			type = pointer_type.base_type;
		}

		var ccall = new CCodeFunctionCall (get_destroy_func_expression (type));
		ccall.add_argument (get_cvalue (stmt.expression));
		ccode.add_expression (ccall);
	}

	public override void visit_expression (Expression expr) {
		if (get_cvalue (expr) != null && !expr.lvalue) {
			if (expr.formal_value_type is GenericType && !(expr.value_type is GenericType)) {
				var st = expr.formal_value_type.type_parameter.parent_symbol.parent_symbol as Struct;
				if (expr.formal_value_type.type_parameter.parent_symbol != garray_type &&
				    (st == null || get_ccode_name (st) != "va_list")) {
					// GArray and va_list don't use pointer-based generics
					set_cvalue (expr, convert_from_generic_pointer (get_cvalue (expr), expr.value_type));
					((GLibValue) expr.target_value).lvalue = false;
				}
			}

			// memory management, implicit casts, and boxing/unboxing
			if (expr.value_type != null) {
				// FIXME: temporary workaround until the refactoring is complete, not all target_value have a value_type
				expr.target_value.value_type = expr.value_type;
				expr.target_value = transform_value (expr.target_value, expr.target_type, expr);
			}

			if (expr.target_value == null) {
				return;
			}

			if (expr.formal_target_type is GenericType && !(expr.target_type is GenericType)) {
				if (expr.formal_target_type.type_parameter.parent_symbol != garray_type) {
					// GArray doesn't use pointer-based generics
					set_cvalue (expr, convert_to_generic_pointer (get_cvalue (expr), expr.target_type));
					((GLibValue) expr.target_value).lvalue = false;
				}
			}

			if (!(expr.value_type is ValueType && !expr.value_type.nullable)) {
				((GLibValue) expr.target_value).non_null = expr.is_non_null ();
			}
		}
	}

	public override void visit_boolean_literal (BooleanLiteral expr) {
		set_cvalue (expr, new CCodeConstant (expr.value ? "TRUE" : "FALSE"));
	}

	public override void visit_character_literal (CharacterLiteral expr) {
		if (expr.get_char () >= 0x20 && expr.get_char () < 0x80) {
			set_cvalue (expr, new CCodeConstant (expr.value));
		} else {
			set_cvalue (expr, new CCodeConstant ("%uU".printf (expr.get_char ())));
		}
	}

	public override void visit_integer_literal (IntegerLiteral expr) {
		set_cvalue (expr, new CCodeConstant (expr.value + expr.type_suffix));
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
		set_cvalue (expr, new CCodeConstant.string (expr.value.replace ("\n", "\\n")));

		if (expr.translate) {
			// translated string constant

			var m = (Method) root_symbol.scope.lookup ("GLib").scope.lookup ("_");
			add_symbol_declaration (cfile, m, get_ccode_name (m));

			var translate = new CCodeFunctionCall (new CCodeIdentifier ("_"));
			translate.add_argument (get_cvalue (expr));
			set_cvalue (expr, translate);
		}
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

		var cdecl = new CCodeDeclaration ("GRegex*");

		var cname = "_tmp_regex_%d".printf (next_regex_id);
		if (this.next_regex_id == 0) {
			var fun = new CCodeFunction ("_thread_safe_regex_init", "GRegex*");
			fun.modifiers = CCodeModifiers.STATIC | CCodeModifiers.INLINE;
			fun.add_parameter (new CCodeParameter ("re", "GRegex**"));
			fun.add_parameter (new CCodeParameter ("pattern", "const gchar *"));
			fun.add_parameter (new CCodeParameter ("match_options", "GRegexMatchFlags"));

			push_function (fun);

			var once_enter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_once_init_enter"));
			once_enter_call.add_argument (new CCodeConstant ("(volatile gsize*) re"));
			ccode.open_if (once_enter_call);

			var regex_new_call = new CCodeFunctionCall (new CCodeIdentifier ("g_regex_new"));
			regex_new_call.add_argument (new CCodeConstant ("pattern"));
			regex_new_call.add_argument (new CCodeConstant ("match_options"));
			regex_new_call.add_argument (new CCodeConstant ("0"));
			regex_new_call.add_argument (new CCodeConstant ("NULL"));
			ccode.add_assignment (new CCodeIdentifier ("GRegex* val"), regex_new_call);

			var once_leave_call = new CCodeFunctionCall (new CCodeIdentifier ("g_once_init_leave"));
			once_leave_call.add_argument (new CCodeConstant ("(volatile gsize*) re"));
			once_leave_call.add_argument (new CCodeConstant ("(gsize) val"));
			ccode.add_expression (once_leave_call);

			ccode.close ();

			ccode.add_return (new CCodeIdentifier ("*re"));

			pop_function ();

			cfile.add_function (fun);
		}
		this.next_regex_id++;

		cdecl.add_declarator (new CCodeVariableDeclarator (cname + " = NULL"));
		cdecl.modifiers = CCodeModifiers.STATIC;

		var regex_const = new CCodeConstant ("_thread_safe_regex_init (&%s, \"%s\", %s)".printf (cname, re, flags));

		cfile.add_constant_declaration (cdecl);
		set_cvalue (expr, regex_const);
	}

	public override void visit_null_literal (NullLiteral expr) {
		set_cvalue (expr, new CCodeConstant ("NULL"));

		var array_type = expr.target_type as ArrayType;
		var delegate_type = expr.target_type as DelegateType;
		if (array_type != null) {
			for (int dim = 1; dim <= array_type.rank; dim++) {
				append_array_length (expr, new CCodeConstant ("0"));
			}
		} else if (delegate_type != null && delegate_type.delegate_symbol.has_target) {
			set_delegate_target (expr, new CCodeConstant ("NULL"));
			set_delegate_target_destroy_notify (expr, new CCodeConstant ("NULL"));
		}
	}

	public abstract TargetValue get_local_cvalue (LocalVariable local);

	public abstract TargetValue get_parameter_cvalue (Parameter param);

	public abstract TargetValue get_field_cvalue (Field field, TargetValue? instance);

	public abstract TargetValue load_variable (Variable variable, TargetValue value);

	public abstract TargetValue load_this_parameter (TypeSymbol sym);

	public abstract void store_value (TargetValue lvalue, TargetValue value);

	public virtual string get_delegate_target_cname (string delegate_cname) {
		assert_not_reached ();
	}

	public virtual CCodeExpression get_delegate_target_cexpression (Expression delegate_expr, out CCodeExpression delegate_target_destroy_notify) {
		assert_not_reached ();
	}

	public virtual CCodeExpression get_delegate_target_cvalue (TargetValue value) {
		return new CCodeInvalidExpression ();
	}

	public virtual CCodeExpression get_delegate_target_destroy_notify_cvalue (TargetValue value) {
		return new CCodeInvalidExpression ();
	}

	public virtual string get_delegate_target_destroy_notify_cname (string delegate_cname) {
		assert_not_reached ();
	}

	public override void visit_base_access (BaseAccess expr) {
		CCodeExpression this_access;
		if (is_in_coroutine ()) {
			// use closure
			this_access = new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "self");
		} else {
			this_access = new CCodeIdentifier ("self");
		}

		set_cvalue (expr, generate_instance_cast (this_access, expr.value_type.data_type));
	}

	public override void visit_postfix_expression (PostfixExpression expr) {
		MemberAccess ma = find_property_access (expr.inner);
		if (ma != null) {
			// property postfix expression
			var prop = (Property) ma.symbol_reference;

			// increment/decrement property
			var op = expr.increment ? CCodeBinaryOperator.PLUS : CCodeBinaryOperator.MINUS;
			var cexpr = new CCodeBinaryExpression (op, get_cvalue (expr.inner), new CCodeConstant ("1"));
			store_property (prop, ma.inner, new GLibValue (expr.value_type, cexpr));

			// return previous value
			expr.target_value = expr.inner.target_value;
			return;
		}

		// assign current value to temp variable
		var temp_value = store_temp_value (expr.inner.target_value, expr);

		// increment/decrement variable
		var op = expr.increment ? CCodeBinaryOperator.PLUS : CCodeBinaryOperator.MINUS;
		var cexpr = new CCodeBinaryExpression (op, get_cvalue_ (temp_value), new CCodeConstant ("1"));
		ccode.add_assignment (get_cvalue (expr.inner), cexpr);

		// return previous value
		expr.target_value = temp_value;
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
		if (cl != null && is_reference_counting (cl)
		    && get_ccode_ref_function (cl) == "") {
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
		if (cl != null && is_reference_counting (cl)
		    && get_ccode_unref_function (cl) == "") {
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
		if (cl != null) {
			return get_ccode_ref_function_void (cl);
		} else {
			return false;
		}
	}

	bool is_free_function_address_of (DataType type) {
		var cl = type.data_type as Class;
		if (cl != null) {
			return get_ccode_free_function_address_of (cl);
		} else {
			return false;
		}
	}

	public virtual TargetValue? copy_value (TargetValue value, CodeNode node) {
		var type = value.value_type;
		var cexpr = get_cvalue_ (value);
		var result = ((GLibValue) value).copy ();

		if (type is DelegateType) {
			var delegate_type = (DelegateType) type;
			if (delegate_type.delegate_symbol.has_target && !context.deprecated) {
				Report.deprecated (node.source_reference, "copying delegates is not supported");
			}
			result.delegate_target_destroy_notify_cvalue = new CCodeConstant ("NULL");
			return result;
		}

		if (type is ValueType && !type.nullable) {
			// normal value type, no null check

			var temp_value = create_temp_value (type, true, node, true);
			var ctemp = get_cvalue_ (temp_value);

			var vt = (ValueType) type;
			var st = (Struct) vt.type_symbol;
			var copy_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_copy_function (st)));
			copy_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr));
			copy_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));

			if (!get_ccode_has_copy_function (st)) {
				generate_struct_copy_function (st);
			}

			if (gvalue_type != null && type.data_type == gvalue_type) {
				var cisvalid = new CCodeFunctionCall (new CCodeIdentifier ("G_IS_VALUE"));
				cisvalid.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr));

				ccode.open_if (cisvalid);

				// GValue requires g_value_init in addition to g_value_copy
				var value_type_call = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_TYPE"));
				value_type_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr));

				var init_call = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
				init_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, ctemp));
				init_call.add_argument (value_type_call);
				ccode.add_expression (init_call);
				ccode.add_expression (copy_call);

				ccode.add_else ();

				// g_value_init/copy must not be called for uninitialized values
				store_value (temp_value, value);
				ccode.close ();
			} else {
				ccode.add_expression (copy_call);
			}

			return temp_value;
		}

		/* (temp = expr, temp == NULL ? NULL : ref (temp))
		 *
		 * can be simplified to
		 * ref (expr)
		 * if static type of expr is non-null
		 */
		 
		var dupexpr = get_dup_func_expression (type, node.source_reference);

		if (dupexpr == null) {
			node.error = true;
			return null;
		}

		if (dupexpr is CCodeIdentifier && !(type is ArrayType) && !(type is GenericType) && !is_ref_function_void (type)) {
			// generate and call NULL-aware ref function to reduce number
			// of temporary variables and simplify code

			var dupid = (CCodeIdentifier) dupexpr;
			string dup0_func = "_%s0".printf (dupid.name);

			// g_strdup is already NULL-safe
			if (dupid.name == "g_strdup") {
				dup0_func = dupid.name;
			} else if (add_wrapper (dup0_func)) {
				string pointer_cname = "gpointer";
				var dup0_fun = new CCodeFunction (dup0_func, pointer_cname);
				dup0_fun.add_parameter (new CCodeParameter ("self", pointer_cname));
				dup0_fun.modifiers = CCodeModifiers.STATIC;

				push_function (dup0_fun);

				var dup_call = new CCodeFunctionCall (dupexpr);
				dup_call.add_argument (new CCodeIdentifier ("self"));

				ccode.add_return (new CCodeConditionalExpression (new CCodeIdentifier ("self"), dup_call, new CCodeConstant ("NULL")));

				pop_function ();

				cfile.add_function (dup0_fun);
			}

			var ccall = new CCodeFunctionCall (new CCodeIdentifier (dup0_func));
			ccall.add_argument (cexpr);
			result.cvalue = ccall;
			result.value_type.value_owned = true;
			return store_temp_value (result, node);
		}

		var ccall = new CCodeFunctionCall (dupexpr);

		if (!(type is ArrayType) && get_non_null (value) && !is_ref_function_void (type)) {
			// expression is non-null
			ccall.add_argument (cexpr);
			
			return store_temp_value (new GLibValue (type, ccall), node);
		} else {
			var cnotnull = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, cexpr, new CCodeConstant ("NULL"));
			if (type.type_parameter != null) {
				// dup functions are optional for type parameters
				var cdupnotnull = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, get_dup_func_expression (type, node.source_reference), new CCodeConstant ("NULL"));
				cnotnull = new CCodeBinaryExpression (CCodeBinaryOperator.AND, cnotnull, cdupnotnull);
			}

			if (type.type_parameter != null) {
				// cast from gconstpointer to gpointer as GBoxedCopyFunc expects gpointer
				ccall.add_argument (new CCodeCastExpression (cexpr, "gpointer"));
			} else {
				ccall.add_argument (cexpr);
			}

			if (type is ArrayType) {
				var array_type = (ArrayType) type;
				ccall.add_argument (get_array_length_cvalue (value));

				if (array_type.element_type is GenericType) {
					var elem_dupexpr = get_dup_func_expression (array_type.element_type, node.source_reference);
					if (elem_dupexpr == null) {
						elem_dupexpr = new CCodeConstant ("NULL");
					}
					ccall.add_argument (elem_dupexpr);
				}
			}

			CCodeExpression cifnull;
			if (type.data_type != null) {
				cifnull = new CCodeConstant ("NULL");
			} else {
				// the value might be non-null even when the dup function is null,
				// so we may not just use NULL for type parameters

				// cast from gconstpointer to gpointer as methods in
				// generic classes may not return gconstpointer
				cifnull = new CCodeCastExpression (cexpr, "gpointer");
			}

			if (is_ref_function_void (type)) {
				ccode.open_if (cnotnull);
				ccode.add_expression (ccall);
				ccode.close ();
			} else {
				var ccond = new CCodeConditionalExpression (cnotnull, ccall, cifnull);
				result.cvalue = ccond;
				result = (GLibValue) store_temp_value (result, node, true);
			}
			return result;
		}
	}

	bool is_reference_type_argument (DataType type_arg) {
		if (type_arg is ErrorType || (type_arg.data_type != null && type_arg.data_type.is_reference_type ())) {
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
		if (type_arg is EnumValueType) {
			return true;
		} else if (type_arg.nullable) {
			return false;
		} else if (st == null) {
			return false;
		} else if (st.is_subtype_of (bool_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (char_type.data_type)) {
			return true;
		} else if (unichar_type != null && st.is_subtype_of (unichar_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (short_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (int_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (long_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (int8_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (int16_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (int32_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (gtype_type)) {
			return true;
		} else {
			return false;
		}
	}

	bool is_unsigned_integer_type_argument (DataType type_arg) {
		var st = type_arg.data_type as Struct;
		if (st == null) {
			return false;
		} else if (type_arg.nullable) {
			return false;
		} else if (st.is_subtype_of (uchar_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (ushort_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (uint_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (ulong_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (uint8_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (uint16_type.data_type)) {
			return true;
		} else if (st.is_subtype_of (uint32_type.data_type)) {
			return true;
		} else {
			return false;
		}
	}

	public void check_type (DataType type) {
		var array_type = type as ArrayType;
		if (array_type != null) {
			check_type (array_type.element_type);
			if (array_type.element_type is ArrayType) {
				Report.error (type.source_reference, "Stacked arrays are not supported");
			} else if (array_type.element_type is DelegateType) {
				var delegate_type = (DelegateType) array_type.element_type;
				if (delegate_type.delegate_symbol.has_target) {
					Report.error (type.source_reference, "Delegates with target are not supported as array element type");
				}
			}
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

	public virtual void generate_class_declaration (Class cl, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, cl, get_ccode_name (cl))) {
			return;
		}
	}

	public virtual void generate_interface_declaration (Interface iface, CCodeFile decl_space) {
	}

	public virtual void generate_method_declaration (Method m, CCodeFile decl_space) {
	}

	public virtual void generate_error_domain_declaration (ErrorDomain edomain, CCodeFile decl_space) {
	}

	public void add_generic_type_arguments (Map<int,CCodeExpression> arg_map, List<DataType> type_args, CodeNode expr, bool is_chainup = false, List<TypeParameter>? type_parameters = null) {
		int type_param_index = 0;
		foreach (var type_arg in type_args) {
			if (type_parameters != null) {
				var type_param_name = type_parameters.get (type_param_index).name.down ();
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeConstant ("\"%s_type\"".printf (type_param_name)));
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeConstant ("\"%s_dup_func\"".printf (type_param_name)));
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.05), new CCodeConstant ("\"%s_destroy_func\"".printf (type_param_name)));
			}

			arg_map.set (get_param_pos (0.1 * type_param_index + 0.02), get_type_id_expression (type_arg, is_chainup));
			if (requires_copy (type_arg)) {
				var dup_func = get_dup_func_expression (type_arg, type_arg.source_reference, is_chainup);
				if (dup_func == null) {
					// type doesn't contain a copy function
					expr.error = true;
					return;
				}
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.04), new CCodeCastExpression (dup_func, "GBoxedCopyFunc"));
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.06), get_destroy_func_expression (type_arg, is_chainup));
			} else {
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.04), new CCodeConstant ("NULL"));
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.06), new CCodeConstant ("NULL"));
			}
			type_param_index++;
		}
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		CCodeExpression instance = null;
		CCodeExpression creation_expr = null;

		check_type (expr.type_reference);

		var st = expr.type_reference.data_type as Struct;
		if ((st != null && (!st.is_simple_type () || get_ccode_name (st) == "va_list")) || expr.get_object_initializer ().size > 0) {
			// value-type initialization or object creation expression with object initializer

			var local = expr.parent_node as LocalVariable;
			var a = expr.parent_node as Assignment;
			if (local != null && is_simple_struct_creation (local, local.initializer)) {
				instance = get_cvalue_ (get_local_cvalue (local));
			} else if (a != null && a.left.symbol_reference is Variable && is_simple_struct_creation ((Variable) a.left.symbol_reference, a.right)) {
				if (requires_destroy (a.left.value_type)) {
					/* unref old value */
					ccode.add_expression (destroy_value (a.left.target_value));
				}

				local = a.left.symbol_reference as LocalVariable;
				var field = a.left.symbol_reference as Field;
				var param = a.left.symbol_reference as Parameter;
				if (local != null) {
					instance = get_cvalue_ (get_local_cvalue (local));
				} else if (field != null) {
					var inner = ((MemberAccess) a.left).inner;
					instance = get_cvalue_ (get_field_cvalue (field, inner != null ? inner.target_value : null));
				} else if (param != null) {
					instance = get_cvalue_ (get_parameter_cvalue (param));
				}
			} else {
				var temp_value = create_temp_value (expr.type_reference, true, expr);
				instance = get_cvalue_ (temp_value);
			}
		}

		if (expr.symbol_reference == null) {
			// no creation method
			if (expr.type_reference.data_type is Struct) {
				// memset needs string.h
				cfile.add_include ("string.h");
				var creation_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
				creation_call.add_argument (new CCodeConstant ("0"));
				creation_call.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (get_ccode_name (expr.type_reference))));

				creation_expr = creation_call;
			}
		} else if (expr.type_reference.data_type == glist_type ||
		           expr.type_reference.data_type == gslist_type) {
			// NULL is an empty list
			set_cvalue (expr, new CCodeConstant ("NULL"));
		} else if (expr.symbol_reference is Method) {
			// use creation method
			var m = (Method) expr.symbol_reference;
			var params = m.get_parameters ();
			CCodeFunctionCall creation_call;

			CCodeFunctionCall async_call = null;
			CCodeFunctionCall finish_call = null;

			generate_method_declaration (m, cfile);

			var cl = expr.type_reference.data_type as Class;

			if (!get_ccode_has_new_function (m)) {
				// use construct function directly
				creation_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_real_name (m)));
				creation_call.add_argument (new CCodeIdentifier (get_ccode_type_id (cl)));
			} else {
				creation_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_name (m)));
			}

			if ((st != null && !st.is_simple_type ()) && !(get_ccode_instance_pos (m) < 0)) {
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
			} else if (st != null && get_ccode_name (st) == "va_list") {
				creation_call.add_argument (instance);
				if (get_ccode_name (m) == "va_start") {
					if (in_creation_method) {
						creation_call = new CCodeFunctionCall (new CCodeIdentifier ("va_copy"));
						creation_call.add_argument (instance);
						creation_call.add_argument (new CCodeIdentifier ("_vala_va_list"));
					} else {
						Parameter last_param = null;
						// FIXME: this doesn't take into account exception handling parameters
						foreach (var param in current_method.get_parameters ()) {
							if (param.ellipsis) {
								break;
							}
							last_param = param;
						}
						int nParams = ccode.get_parameter_count ();
						if (nParams == 0 || !ccode.get_parameter (nParams - 1).ellipsis) {
							Report.error (expr.source_reference, "`va_list' used in method with fixed args");
						} else if (nParams == 1) {
							Report.error (expr.source_reference, "`va_list' used in method without parameter");
						} else {
							creation_call.add_argument (new CCodeIdentifier (ccode.get_parameter (nParams - 2).name));
						}
					}
				}
			}

			generate_type_declaration (expr.type_reference, cfile);

			var in_arg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);
			var out_arg_map = in_arg_map;

			if (m != null && m.coroutine) {
				// async call

				async_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_name (m)));
				finish_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_finish_name (m)));

				creation_call = finish_call;

				// output arguments used separately
				out_arg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);
				// pass GAsyncResult stored in closure to finish function
				out_arg_map.set (get_param_pos (0.1), new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "_res_"));
			}

			if (cl != null && !cl.is_compact) {
				add_generic_type_arguments (in_arg_map, expr.type_reference.get_type_arguments (), expr);
			} else if (cl != null && get_ccode_simple_generics (m)) {
				int type_param_index = 0;
				foreach (var type_arg in expr.type_reference.get_type_arguments ()) {
					if (requires_copy (type_arg)) {
						in_arg_map.set (get_param_pos (-1 + 0.1 * type_param_index + 0.03), get_destroy0_func_expression (type_arg));
					} else {
						in_arg_map.set (get_param_pos (-1 + 0.1 * type_param_index + 0.03), new CCodeConstant ("NULL"));
					}
					type_param_index++;
				}
			}

			bool ellipsis = false;

			int i = 1;
			int arg_pos;
			Iterator<Parameter> params_it = params.iterator ();
			foreach (Expression arg in expr.get_argument_list ()) {
				CCodeExpression cexpr = get_cvalue (arg);

				var carg_map = in_arg_map;

				Parameter param = null;
				if (params_it.next ()) {
					param = params_it.get ();
					ellipsis = param.ellipsis;
					if (!ellipsis) {
						if (param.direction == ParameterDirection.OUT) {
							carg_map = out_arg_map;
						}

						// g_array_new: element size
						if (cl == garray_type && param.name == "element_size") {
							var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
							csizeof.add_argument (new CCodeIdentifier (get_ccode_name (expr.type_reference.get_type_arguments ().get (0))));
							cexpr = csizeof;
						}

						if (get_ccode_array_length (param) && param.variable_type is ArrayType) {
							var array_type = (ArrayType) param.variable_type;
							for (int dim = 1; dim <= array_type.rank; dim++) {
								carg_map.set (get_param_pos (get_ccode_array_length_pos (param) + 0.01 * dim), get_array_length_cexpression (arg, dim));
							}
						} else if (param.variable_type is DelegateType) {
							var deleg_type = (DelegateType) param.variable_type;
							var d = deleg_type.delegate_symbol;
							if (d.has_target) {
								CCodeExpression delegate_target_destroy_notify;
								var delegate_target = get_delegate_target_cexpression (arg, out delegate_target_destroy_notify);
								carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), delegate_target);
								if (deleg_type.is_disposable ()) {
									carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param) + 0.01), delegate_target_destroy_notify);
								}
							}
						}

						cexpr = handle_struct_argument (param, arg, cexpr);

						if (get_ccode_type (param) != null) {
							cexpr = new CCodeCastExpression (cexpr, get_ccode_type (param));
						}
					} else {
						cexpr = handle_struct_argument (null, arg, cexpr);
					}

					arg_pos = get_param_pos (get_ccode_pos (param), ellipsis);
				} else {
					// default argument position
					cexpr = handle_struct_argument (null, arg, cexpr);
					arg_pos = get_param_pos (i, ellipsis);
				}
			
				carg_map.set (arg_pos, cexpr);

				i++;
			}
			if (params_it.next ()) {
				var param = params_it.get ();
				
				/* if there are more parameters than arguments,
				 * the additional parameter is an ellipsis parameter
				 * otherwise there is a bug in the semantic analyzer
				 */
				assert (param.params_array || param.ellipsis);
				ellipsis = true;
			}

			if (expr.tree_can_fail) {
				// method can fail
				current_method_inner_error = true;
				// add &inner_error before the ellipsis arguments
				out_arg_map.set (get_param_pos (-1), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression ("_inner_error_")));
			}

			if (ellipsis) {
				/* ensure variable argument list ends with NULL
				 * except when using printf-style arguments */
				if (m == null) {
					in_arg_map.set (get_param_pos (-1, true), new CCodeConstant ("NULL"));
				} else if (!m.printf_format && !m.scanf_format && get_ccode_sentinel (m) != "") {
					in_arg_map.set (get_param_pos (-1, true), new CCodeConstant (get_ccode_sentinel (m)));
				}
			}

			if ((st != null && !st.is_simple_type ()) && get_ccode_instance_pos (m) < 0) {
				// instance parameter is at the end in a struct creation method
				out_arg_map.set (get_param_pos (-3), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
			}

			if (m != null && m.coroutine) {
				if (expr.is_yield_expression) {
					// asynchronous call
					in_arg_map.set (get_param_pos (-1), new CCodeIdentifier (generate_ready_function (current_method)));
					in_arg_map.set (get_param_pos (-0.9), new CCodeIdentifier ("_data_"));
				}
			}

			// append C arguments in the right order

			int last_pos;
			int min_pos;

			if (async_call != creation_call) {
				// don't append out arguments for .begin() calls
				last_pos = -1;
				while (true) {
					min_pos = -1;
					foreach (int pos in out_arg_map.get_keys ()) {
						if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
							min_pos = pos;
						}
					}
					if (min_pos == -1) {
						break;
					}
					creation_call.add_argument (out_arg_map.get (min_pos));
					last_pos = min_pos;
				}
			}

			if (async_call != null) {
				last_pos = -1;
				while (true) {
					min_pos = -1;
					foreach (int pos in in_arg_map.get_keys ()) {
						if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
							min_pos = pos;
						}
					}
					if (min_pos == -1) {
						break;
					}
					async_call.add_argument (in_arg_map.get (min_pos));
					last_pos = min_pos;
				}
			}

			if (expr.is_yield_expression) {
				// set state before calling async function to support immediate callbacks
				int state = next_coroutine_state++;

				ccode.add_assignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "_state_"), new CCodeConstant (state.to_string ()));
				ccode.add_expression (async_call);
				ccode.add_return (new CCodeConstant ("FALSE"));
				ccode.add_label ("_state_%d".printf (state));
			}

			creation_expr = creation_call;

			// cast the return value of the creation method back to the intended type if
			// it requested a special C return type
			if (get_ccode_type (m) != null) {
				creation_expr = new CCodeCastExpression (creation_expr, get_ccode_name (expr.type_reference));
			}
		} else if (expr.symbol_reference is ErrorCode) {
			var ecode = (ErrorCode) expr.symbol_reference;
			var edomain = (ErrorDomain) ecode.parent_symbol;
			CCodeFunctionCall creation_call;

			generate_error_domain_declaration (edomain, cfile);

			if (expr.get_argument_list ().size == 1) {
				// must not be a format argument
				creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_error_new_literal"));
			} else {
				creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_error_new"));
			}
			creation_call.add_argument (new CCodeIdentifier (get_ccode_upper_case_name (edomain)));
			creation_call.add_argument (new CCodeIdentifier (get_ccode_name (ecode)));

			foreach (Expression arg in expr.get_argument_list ()) {
				creation_call.add_argument (get_cvalue (arg));
			}

			creation_expr = creation_call;
		} else {
			assert (false);
		}

		var local = expr.parent_node as LocalVariable;
		if (local != null && is_simple_struct_creation (local, local.initializer)) {
			// no temporary variable necessary
			ccode.add_expression (creation_expr);
			set_cvalue (expr, instance);
		} else if (instance != null) {
			if (expr.type_reference.data_type is Struct) {
				ccode.add_expression (creation_expr);
			} else {
				ccode.add_assignment (instance, creation_expr);
			}

			foreach (MemberInitializer init in expr.get_object_initializer ()) {
				if (init.symbol_reference is Field) {
					var f = (Field) init.symbol_reference;
					var instance_target_type = get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);
					var typed_inst = transform_value (new GLibValue (expr.type_reference, instance, true), instance_target_type, init);
					store_field (f, typed_inst, init.initializer.target_value);

					var cl = f.parent_symbol as Class;
					if (cl != null) {
						generate_class_struct_declaration (cl, cfile);
					}
				} else if (init.symbol_reference is Property) {
					var inst_ma = new MemberAccess.simple ("new");
					inst_ma.value_type = expr.type_reference;
					set_cvalue (inst_ma, instance);
					store_property ((Property) init.symbol_reference, inst_ma, init.initializer.target_value);
				}
			}

			set_cvalue (expr, instance);
		} else if (creation_expr != null) {
			var temp_value = create_temp_value (expr.value_type, false, expr);
			ccode.add_assignment (get_cvalue_ (temp_value), creation_expr);
			expr.target_value = temp_value;

			if (context.gobject_tracing) {
				// GObject creation tracing enabled

				var cl = expr.type_reference.data_type as Class;
				if (cl != null && cl.is_subtype_of (gobject_type)) {
					// creating GObject

					// instance can be NULL in error cases
					ccode.open_if (get_cvalue_ (expr.target_value));

					var set_data_call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_set_data"));
					set_data_call.add_argument (new CCodeCastExpression (get_cvalue_ (expr.target_value), "GObject *"));
					set_data_call.add_argument (new CCodeConstant ("\"vala-creation-function\""));

					string func_name = "";
					if (current_method != null) {
						func_name = current_method.get_full_name ();
					} else if (current_property_accessor != null) {
						func_name = current_property_accessor.get_full_name ();
					}

					set_data_call.add_argument (new CCodeConstant ("\"%s\"".printf (func_name)));

					ccode.add_expression (set_data_call);

					ccode.close ();
				}
			}
		}

		((GLibValue) expr.target_value).lvalue = true;
	}

	public CCodeExpression? handle_struct_argument (Parameter? param, Expression arg, CCodeExpression? cexpr) {
		DataType type;
		if (param != null) {
			type = param.variable_type;
		} else {
			// varargs
			type = arg.value_type;
		}

		var unary = arg as UnaryExpression;
		// pass non-simple struct instances always by reference
		if (!(arg.value_type is NullType) && type.is_real_struct_type ()) {
			// we already use a reference for arguments of ref, out, and nullable parameters
			if (!(unary != null && (unary.operator == UnaryOperator.OUT || unary.operator == UnaryOperator.REF)) && !type.nullable) {
				if (cexpr is CCodeIdentifier || cexpr is CCodeMemberAccess) {
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr);
				} else {
					// if cexpr is e.g. a function call, we can't take the address of the expression
					var temp_value = create_temp_value (type, false, arg);
					ccode.add_assignment (get_cvalue_ (temp_value), cexpr);
					return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue_ (temp_value));
				}
			}
		}

		return cexpr;
	}

	public override void visit_sizeof_expression (SizeofExpression expr) {
		generate_type_declaration (expr.type_reference, cfile);

		var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
		csizeof.add_argument (new CCodeIdentifier (get_ccode_name (expr.type_reference)));
		set_cvalue (expr, csizeof);
	}

	public override void visit_typeof_expression (TypeofExpression expr) {
		set_cvalue (expr, get_type_id_expression (expr.type_reference));
	}

	public override void visit_unary_expression (UnaryExpression expr) {
		if (expr.operator == UnaryOperator.REF || expr.operator == UnaryOperator.OUT) {
			var glib_value = (GLibValue) expr.inner.target_value;

			var ref_value = new GLibValue (glib_value.value_type);
			if (expr.target_type != null && glib_value.value_type.is_real_struct_type () && glib_value.value_type.nullable != expr.target_type.nullable) {
				// the only possibility is that value_type is nullable and target_type is non-nullable
				ref_value.cvalue = glib_value.cvalue;
			} else {
				ref_value.cvalue = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, glib_value.cvalue);
			}

			if (glib_value.array_length_cvalues != null) {
				for (int i = 0; i < glib_value.array_length_cvalues.size; i++) {
					ref_value.append_array_length_cvalue (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, glib_value.array_length_cvalues[i]));
				}
			}

			if (glib_value.delegate_target_cvalue != null) {
				ref_value.delegate_target_cvalue = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, glib_value.delegate_target_cvalue);
			}
			if (glib_value.delegate_target_destroy_notify_cvalue != null) {
				ref_value.delegate_target_destroy_notify_cvalue = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, glib_value.delegate_target_destroy_notify_cvalue);
			}

			expr.target_value = ref_value;
			return;
		}

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
		} else {
			assert_not_reached ();
		}
		set_cvalue (expr, new CCodeUnaryExpression (op, get_cvalue (expr.inner)));
	}

	public CCodeExpression? try_cast_value_to_type (CCodeExpression ccodeexpr, DataType from, DataType to, Expression? expr = null) {
		if (from == null || gvalue_type == null || from.data_type != gvalue_type || to.data_type == gvalue_type || get_ccode_type_id (to) == "") {
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
			append_array_length (expr, len_call);
		} else if (to is StructValueType) {
			CodeNode node = expr != null ? (CodeNode) expr : to;
			var temp_value = create_temp_value (to, true, node, true);
			var ctemp = get_cvalue_ (temp_value);

			rv = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeCastExpression (rv, get_ccode_name (new PointerType (to))));
			var holds = new CCodeFunctionCall (new CCodeIdentifier ("G_VALUE_HOLDS"));
			holds.add_argument (gvalue);
			holds.add_argument (new CCodeIdentifier (get_ccode_type_id (to)));
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

	public TargetValue? try_cast_variant_to_type (TargetValue value, DataType to, CodeNode? node = null) {
		if (value.value_type == null || gvariant_type == null || value.value_type.data_type != gvariant_type) {
			return null;
		}

		string variant_func = "_variant_get%d".printf (++next_variant_function_id);

		var variant = value;
		if (value.value_type.value_owned) {
			// value leaked, destroy it
			var temp_value = store_temp_value (value, node);
			temp_ref_values.insert (0, ((GLibValue) temp_value).copy ());
			variant = temp_value;
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (variant_func));
		ccall.add_argument (get_cvalue_ (variant));

		var result = create_temp_value (to, false, node);

		var cfunc = new CCodeFunction (variant_func);
		cfunc.modifiers = CCodeModifiers.STATIC;
		cfunc.add_parameter (new CCodeParameter ("value", "GVariant*"));

		if (!to.is_real_non_null_struct_type ()) {
			cfunc.return_type = get_ccode_name (to);
		}

		if (to.is_real_non_null_struct_type ()) {
			// structs are returned via out parameter
			cfunc.add_parameter (new CCodeParameter ("result", get_ccode_name (to) + "*"));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue_ (result)));
		} else if (to is ArrayType) {
			// return array length if appropriate
			// tmp = _variant_get (variant, &tmp_length);
			var array_type = (ArrayType) to;

			for (int dim = 1; dim <= array_type.rank; dim++) {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_array_length_cvalue (result, dim)));
				cfunc.add_parameter (new CCodeParameter (get_array_length_cname ("result", dim), "int*"));
			}
		}

		if (!to.is_real_non_null_struct_type ()) {
			ccode.add_assignment (get_cvalue_ (result), ccall);
		} else {
			ccode.add_expression (ccall);
		}

		push_function (cfunc);

		CCodeExpression func_result = deserialize_expression (to, new CCodeIdentifier ("value"), new CCodeIdentifier ("*result"));
		if (to.is_real_non_null_struct_type ()) {
			ccode.add_assignment (new CCodeIdentifier ("*result"), func_result);
		} else {
			ccode.add_return (func_result);
		}

		pop_function ();

		cfile.add_function_declaration (cfunc);
		cfile.add_function (cfunc);

		return load_temp_value (result);
	}

	public virtual CCodeExpression? deserialize_expression (DataType type, CCodeExpression variant_expr, CCodeExpression? expr, CCodeExpression? error_expr = null, out bool may_fail = null) {
		assert_not_reached ();
	}

	public virtual CCodeExpression? serialize_expression (DataType type, CCodeExpression expr) {
		assert_not_reached ();
	}

	public override void visit_cast_expression (CastExpression expr) {
		generate_type_declaration (expr.type_reference, cfile);

		if (!expr.is_non_null_cast) {
			var valuecast = try_cast_value_to_type (get_cvalue (expr.inner), expr.inner.value_type, expr.type_reference, expr);
			if (valuecast != null) {
				set_cvalue (expr, valuecast);
				return;
			}

			var variantcast = try_cast_variant_to_type (expr.inner.target_value, expr.type_reference, expr);
			if (variantcast != null) {
				expr.target_value = variantcast;
				return;
			}
		}

		var cl = expr.type_reference.data_type as Class;
		var iface = expr.type_reference.data_type as Interface;
		if (iface != null || (cl != null && !cl.is_compact)) {
			// checked cast for strict subtypes of GTypeInstance
			if (expr.is_silent_cast) {
				TargetValue to_cast = expr.inner.target_value;
				CCodeExpression cexpr;
				if (!get_lvalue (to_cast)) {
					to_cast = store_temp_value (to_cast, expr);
				}
				cexpr = get_cvalue_ (to_cast);
				var ccheck = create_type_check (cexpr, expr.type_reference);
				var ccast = new CCodeCastExpression (cexpr, get_ccode_name (expr.type_reference));
				var cnull = new CCodeConstant ("NULL");
				var cast_value = new GLibValue (expr.value_type, new CCodeConditionalExpression (ccheck, ccast, cnull));
				if (requires_destroy (expr.inner.value_type)) {
					var casted = store_temp_value (cast_value, expr);
					ccode.open_if (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, get_cvalue_ (casted), new CCodeConstant ("NULL")));
					ccode.add_expression (destroy_value (to_cast));
					ccode.close ();
					expr.target_value = ((GLibValue) casted).copy ();
				} else {
					expr.target_value = cast_value;
				}
			} else {
				set_cvalue (expr, generate_instance_cast (get_cvalue (expr.inner), expr.type_reference.data_type));
			}
		} else {
			if (expr.is_silent_cast) {
				expr.error = true;
				Report.error (expr.source_reference, "Operation not supported for this type");
				return;
			}

			// recompute array length when casting to other array type
			var array_type = expr.type_reference as ArrayType;
			if (array_type != null && expr.inner.value_type is ArrayType) {
				if (array_type.element_type is GenericType || ((ArrayType) expr.inner.value_type).element_type is GenericType) {
					// element size unknown for generic arrays, retain array length as is
					for (int dim = 1; dim <= array_type.rank; dim++) {
						append_array_length (expr, get_array_length_cexpression (expr.inner, dim));
					}
				} else {
					var sizeof_to = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
					sizeof_to.add_argument (new CCodeConstant (get_ccode_name (array_type.element_type)));

					var sizeof_from = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
					sizeof_from.add_argument (new CCodeConstant (get_ccode_name (((ArrayType) expr.inner.value_type).element_type)));

					for (int dim = 1; dim <= array_type.rank; dim++) {
						append_array_length (expr, new CCodeBinaryExpression (CCodeBinaryOperator.DIV, new CCodeBinaryExpression (CCodeBinaryOperator.MUL, get_array_length_cexpression (expr.inner, dim), sizeof_from), sizeof_to));
					}
				}
			} else if (array_type != null) {
				// cast from non-array to array, set invalid length
				// required by string.data, e.g.
				for (int dim = 1; dim <= array_type.rank; dim++) {
					append_array_length (expr, new CCodeConstant ("-1"));
				}
			}

			var innercexpr = get_cvalue (expr.inner);
			if (expr.type_reference is ValueType && !expr.type_reference.nullable &&
				expr.inner.value_type is ValueType && expr.inner.value_type.nullable) {
				// nullable integer or float or boolean or struct or enum cast to non-nullable
				innercexpr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, innercexpr);
			}
			set_cvalue (expr, new CCodeCastExpression (innercexpr, get_ccode_name (expr.type_reference)));

			if (expr.type_reference is DelegateType) {
				if (get_delegate_target (expr.inner) != null) {
					set_delegate_target (expr, get_delegate_target (expr.inner));
				} else {
					set_delegate_target (expr, new CCodeConstant ("NULL"));
				}
				if (get_delegate_target_destroy_notify (expr.inner) != null) {
					set_delegate_target_destroy_notify (expr, get_delegate_target_destroy_notify (expr.inner));
				} else {
					set_delegate_target_destroy_notify (expr, new CCodeConstant ("NULL"));
				}
			}
		}
	}
	
	public override void visit_named_argument (NamedArgument expr) {
		set_cvalue (expr, get_cvalue (expr.inner));
	}

	public override void visit_pointer_indirection (PointerIndirection expr) {
		set_cvalue (expr, new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_cvalue (expr.inner)));
	}

	public override void visit_addressof_expression (AddressofExpression expr) {
		set_cvalue (expr, new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue (expr.inner)));
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		/* tmp = expr.inner; expr.inner = NULL; expr = tmp; */
		expr.target_value = store_temp_value (expr.inner.target_value, expr);

		if (expr.inner.value_type is StructValueType && !expr.inner.value_type.nullable) {
			// memset needs string.h
			cfile.add_include ("string.h");
			var creation_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
			creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue (expr.inner)));
			creation_call.add_argument (new CCodeConstant ("0"));
			creation_call.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (get_ccode_name (expr.inner.value_type))));
			ccode.add_expression (creation_call);
		} else if (expr.value_type is DelegateType) {
			var target_destroy_notify = get_delegate_target_destroy_notify_cvalue (expr.inner.target_value);
			if (target_destroy_notify != null) {
				ccode.add_assignment (target_destroy_notify, new CCodeConstant ("NULL"));
			}
		} else {
			ccode.add_assignment (get_cvalue (expr.inner), new CCodeConstant ("NULL"));
		}
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		var cleft = get_cvalue (expr.left);
		var cright = get_cvalue (expr.right);

		CCodeExpression? left_chain = null;
		if (expr.chained) {
			var lbe = (BinaryExpression) expr.left;

			var temp_decl = get_temp_variable (lbe.right.target_type, true, null, false);
			emit_temp_var (temp_decl);
			var cvar = get_variable_cexpression (temp_decl.name);
			var clbe = (CCodeBinaryExpression) get_cvalue (lbe);
			if (lbe.chained) {
				clbe = (CCodeBinaryExpression) clbe.right;
			}
			ccode.add_assignment (cvar, get_cvalue (lbe.right));
			clbe.right = get_variable_cexpression (temp_decl.name);
			left_chain = cleft;
			cleft = cvar;
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
				cfile.add_include ("math.h");
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("fmod"));
				ccall.add_argument (cleft);
				ccall.add_argument (cright);
				set_cvalue (expr, ccall);
				return;
			} else if (expr.value_type.equals (float_type)) {
				cfile.add_include ("math.h");
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("fmodf"));
				ccall.add_argument (cleft);
				ccall.add_argument (cright);
				set_cvalue (expr, ccall);
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
				set_cvalue (expr, node);
			} else {
				set_cvalue (expr, new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeBinaryExpression (CCodeBinaryOperator.BITWISE_AND, cright, cleft), cleft));
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
			} else if ((left_type is IntegerType || left_type is FloatingType || left_type is BooleanType || left_type is EnumValueType) && left_type.nullable &&
			           (right_type is IntegerType || right_type is FloatingType || right_type is BooleanType || right_type is EnumValueType) && right_type.nullable) {
				var equalfunc = generate_numeric_equal_function ((TypeSymbol) left_type.data_type);
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

					set_cvalue (expr, new CCodeConstant ("%s %s".printf (left, right)));
					return;
				} else {
					// convert to g_strconcat (a, b, NULL)
					var temp_value = create_temp_value (expr.value_type, false, expr);

					var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_strconcat"));
					ccall.add_argument (cleft);
					ccall.add_argument (cright);
					ccall.add_argument (new CCodeConstant("NULL"));

					ccode.add_assignment (get_cvalue_ (temp_value), ccall);
					expr.target_value = temp_value;
					return;
				}
			} else if (expr.operator == BinaryOperator.EQUALITY
			           || expr.operator == BinaryOperator.INEQUALITY
			           || expr.operator == BinaryOperator.LESS_THAN
			           || expr.operator == BinaryOperator.GREATER_THAN
			           || expr.operator == BinaryOperator.LESS_THAN_OR_EQUAL
			           || expr.operator == BinaryOperator.GREATER_THAN_OR_EQUAL) {
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_strcmp0"));
				ccall.add_argument (cleft);
				ccall.add_argument (cright);
				cleft = ccall;
				cright = new CCodeConstant ("0");
			}
		}

		set_cvalue (expr, new CCodeBinaryExpression (op, cleft, cright));
		if (left_chain != null) {
			set_cvalue (expr, new CCodeBinaryExpression (CCodeBinaryOperator.AND, left_chain, get_cvalue (expr)));
		}
	}

	CCodeExpression? create_type_check (CCodeNode ccodenode, DataType type) {
		var et = type as ErrorType;
		if (et != null && et.error_code != null) {
			var matches_call = new CCodeFunctionCall (new CCodeIdentifier ("g_error_matches"));
			matches_call.add_argument ((CCodeExpression) ccodenode);
			matches_call.add_argument (new CCodeIdentifier (get_ccode_upper_case_name (et.error_domain)));
			matches_call.add_argument (new CCodeIdentifier (get_ccode_name (et.error_code)));
			return matches_call;
		} else if (et != null && et.error_domain != null) {
			var instance_domain = new CCodeMemberAccess.pointer ((CCodeExpression) ccodenode, "domain");
			var type_domain = new CCodeIdentifier (get_ccode_upper_case_name (et.error_domain));
			return new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, instance_domain, type_domain);
		} else {
			string type_id = get_ccode_type_id (type.data_type);
			if (type_id == "") {
				return new CCodeInvalidExpression ();
			}
			var ccheck = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_CHECK_INSTANCE_TYPE"));
			ccheck.add_argument ((CCodeExpression) ccodenode);
			ccheck.add_argument (new CCodeIdentifier (type_id));
			return ccheck;
		}
	}

	string generate_array_contains_wrapper (ArrayType array_type) {
		string array_contains_func = "_vala_%s_array_contains".printf (get_ccode_lower_case_name (array_type.element_type));

		if (!add_wrapper (array_contains_func)) {
			return array_contains_func;
		}

		var function = new CCodeFunction (array_contains_func, "gboolean");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("stack", "%s*".printf (get_ccode_name (array_type.element_type))));
		function.add_parameter (new CCodeParameter ("stack_length", "int"));
		if (array_type.element_type is StructValueType) {
			function.add_parameter (new CCodeParameter ("needle", get_ccode_name (array_type.element_type) + "*"));
		} else {
			function.add_parameter (new CCodeParameter ("needle", get_ccode_name (array_type.element_type)));
		}

		push_function (function);

		ccode.add_declaration ("int", new CCodeVariableDeclarator ("i"));

		var cloop_initializer = new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeConstant ("0"));
		var cloop_condition = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier ("i"), new CCodeIdentifier ("stack_length"));
		var cloop_iterator = new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("i"));
		ccode.open_for (cloop_initializer, cloop_condition, cloop_iterator);

		var celement = new CCodeElementAccess (new CCodeIdentifier ("stack"), new CCodeIdentifier ("i"));
		var cneedle = new CCodeIdentifier ("needle");
		CCodeBinaryExpression cif_condition;
		if (array_type.element_type.compatible (string_type)) {
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_strcmp0"));
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

		ccode.open_if (cif_condition);
		ccode.add_return (new CCodeConstant ("TRUE"));
		ccode.close ();

		ccode.close ();

		ccode.add_return (new CCodeConstant ("FALSE"));

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return array_contains_func;
	}

	public override void visit_type_check (TypeCheck expr) {
		generate_type_declaration (expr.type_reference, cfile);

		set_cvalue (expr, create_type_check (get_cvalue (expr.expression), expr.type_reference));
		if (get_cvalue (expr) is CCodeInvalidExpression) {
			Report.error (expr.source_reference, "type check expressions not supported for compact classes, structs, and enums");
		}
	}

	public override void visit_lambda_expression (LambdaExpression lambda) {
		var delegate_type = (DelegateType) lambda.target_type;
		var d = delegate_type.delegate_symbol;

		lambda.method.set_attribute_bool ("CCode", "array_length", d.get_attribute_bool ("CCode", "array_length"));
		lambda.method.set_attribute_bool ("CCode", "array_null_terminated", d.get_attribute_bool ("CCode", "array_null_terminated"));
		lambda.method.set_attribute_string ("CCode", "array_length_type", d.get_attribute_string ("CCode", "array_length_type"));

		lambda.accept_children (this);

		bool expr_owned = lambda.value_type.value_owned;

		set_cvalue (lambda, new CCodeIdentifier (get_ccode_name (lambda.method)));

		if (lambda.method.closure) {
			int block_id = get_block_id (current_closure_block);
			var delegate_target = get_variable_cexpression ("_data%d_".printf (block_id));
			if (expr_owned || delegate_type.is_called_once) {
				var ref_call = new CCodeFunctionCall (new CCodeIdentifier ("block%d_data_ref".printf (block_id)));
				ref_call.add_argument (delegate_target);
				delegate_target = ref_call;
				set_delegate_target_destroy_notify (lambda, new CCodeIdentifier ("block%d_data_unref".printf (block_id)));
			} else {
				set_delegate_target_destroy_notify (lambda, new CCodeConstant ("NULL"));
			}
			set_delegate_target (lambda, delegate_target);
		} else if (get_this_type () != null) {
			CCodeExpression delegate_target = get_result_cexpression ("self");
			if (expr_owned || delegate_type.is_called_once) {
				if (get_this_type () != null) {
					var ref_call = new CCodeFunctionCall (get_dup_func_expression (get_this_type (), lambda.source_reference));
					ref_call.add_argument (delegate_target);
					delegate_target = ref_call;
					set_delegate_target_destroy_notify (lambda, get_destroy_func_expression (get_this_type ()));
				} else {
					// in constructor
					var ref_call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_ref"));
					ref_call.add_argument (delegate_target);
					delegate_target = ref_call;
					set_delegate_target_destroy_notify (lambda, new CCodeIdentifier ("g_object_unref"));
				}
			} else {
				set_delegate_target_destroy_notify (lambda, new CCodeConstant ("NULL"));
			}
			set_delegate_target (lambda, delegate_target);
		} else {
			set_delegate_target (lambda, new CCodeConstant ("NULL"));
			set_delegate_target_destroy_notify (lambda, new CCodeConstant ("NULL"));
		}
	}

	public CCodeExpression convert_from_generic_pointer (CCodeExpression cexpr, DataType actual_type) {
		var result = cexpr;
		if (is_reference_type_argument (actual_type) || is_nullable_value_type_argument (actual_type)) {
			result = new CCodeCastExpression (cexpr, get_ccode_name (actual_type));
		} else if (is_signed_integer_type_argument (actual_type)) {
			result = new CCodeCastExpression (new CCodeCastExpression (cexpr, "gintptr"), get_ccode_name (actual_type));
		} else if (is_unsigned_integer_type_argument (actual_type)) {
			result = new CCodeCastExpression (new CCodeCastExpression (cexpr, "guintptr"), get_ccode_name (actual_type));
		}
		return result;
	}

	public CCodeExpression convert_to_generic_pointer (CCodeExpression cexpr, DataType actual_type) {
		var result = cexpr;
		if (is_signed_integer_type_argument (actual_type)) {
			result = new CCodeCastExpression (new CCodeCastExpression (cexpr, "gintptr"), "gpointer");
		} else if (is_unsigned_integer_type_argument (actual_type)) {
			result = new CCodeCastExpression (new CCodeCastExpression (cexpr, "guintptr"), "gpointer");
		}
		return result;
	}

	public TargetValue transform_value (TargetValue value, DataType? target_type, CodeNode node) {
		var type = value.value_type;
		var result = ((GLibValue) value).copy ();

		if (type.value_owned
		    && type.floating_reference) {
			/* floating reference, sink it.
			 */
			var cl = type.data_type as ObjectTypeSymbol;
			var sink_func = (cl != null) ? get_ccode_ref_sink_function (cl) : "";

			if (sink_func != "") {
				if (type.nullable) {
					var is_not_null = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, result.cvalue, new CCodeIdentifier ("NULL"));
					ccode.open_if (is_not_null);
				}

				var csink = new CCodeFunctionCall (new CCodeIdentifier (sink_func));
				csink.add_argument (result.cvalue);
				ccode.add_expression (csink);

				if (type.nullable) {
					ccode.close ();
				}
			} else {
				Report.error (null, "type `%s' does not support floating references".printf (type.data_type.name));
			}
		}

		bool boxing = (type is ValueType && !type.nullable
		               && target_type is ValueType && target_type.nullable);
		bool unboxing = (type is ValueType && type.nullable
		                 && target_type is ValueType && !target_type.nullable);

		bool gvalue_boxing = (target_type != null
		                      && target_type.data_type == gvalue_type
		                      && !(type is NullType)
		                      && get_ccode_type_id (type) != "G_TYPE_VALUE");
		bool gvariant_boxing = (target_type != null
		                        && target_type.data_type == gvariant_type
		                        && !(type is NullType)
		                        && type.data_type != gvariant_type);

		if (type.value_owned
		    && (target_type == null || !target_type.value_owned || boxing || unboxing || gvariant_boxing)
		    && !gvalue_boxing /* gvalue can assume ownership of value, no need to free it */) {
			// value leaked, destroy it
			if (target_type is PointerType) {
				// manual memory management for pointers
			} else if (requires_destroy (type)) {
				if (!is_lvalue_access_allowed (type)) {
					// cannot assign to a temporary variable
					temp_ref_values.insert (0, result.copy ());
				} else {
					var temp_value = create_temp_value (type, false, node);
					temp_ref_values.insert (0, ((GLibValue) temp_value).copy ());
					store_value (temp_value, result);
					result.cvalue = get_cvalue_ (temp_value);
				}
			}
		}

		if (target_type == null) {
			// value will be destroyed, no need for implicit casts
			return result;
		}

		result.value_type = target_type.copy ();

		if (gvalue_boxing) {
			// implicit conversion to GValue
			var temp_value = create_temp_value (target_type, true, node, true);

			if (!target_type.value_owned) {
				// boxed GValue leaked, destroy it
				temp_ref_values.insert (0, ((GLibValue) temp_value).copy ());
			}

			if (target_type.nullable) {
				var newcall = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
				newcall.add_argument (new CCodeConstant ("GValue"));
				newcall.add_argument (new CCodeConstant ("1"));
				var newassignment = new CCodeAssignment (get_cvalue_ (temp_value), newcall);
				ccode.add_expression (newassignment);
			}

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
			if (target_type.nullable) {
				ccall.add_argument (get_cvalue_ (temp_value));
			} else {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue_ (temp_value)));
			}
			var type_id = get_ccode_type_id (type);
			if (type_id == "") {
				Report.error (node.source_reference, "GValue boxing of type `%s' is not supported".printf (type.to_string ()));
			}
			ccall.add_argument (new CCodeIdentifier (type_id));
			ccode.add_expression (ccall);

			if (requires_destroy (type)) {
				ccall = new CCodeFunctionCall (get_value_taker_function (type));
			} else {
				ccall = new CCodeFunctionCall (get_value_setter_function (type));
			}
			if (target_type.nullable) {
				ccall.add_argument (get_cvalue_ (temp_value));
			} else {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue_ (temp_value)));
			}
			if (type.is_real_non_null_struct_type ()) {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, result.cvalue));
			} else {
				ccall.add_argument (result.cvalue);
			}

			ccode.add_expression (ccall);

			result = (GLibValue) temp_value;
		} else if (gvariant_boxing) {
			// implicit conversion to GVariant
			string variant_func = "_variant_new%d".printf (++next_variant_function_id);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier (variant_func));
			ccall.add_argument (result.cvalue);

			var cfunc = new CCodeFunction (variant_func, "GVariant*");
			cfunc.modifiers = CCodeModifiers.STATIC;
			cfunc.add_parameter (new CCodeParameter ("value", get_ccode_name (type)));

			if (type is ArrayType) {
				// return array length if appropriate
				var array_type = (ArrayType) type;

				for (int dim = 1; dim <= array_type.rank; dim++) {
					ccall.add_argument (get_array_length_cvalue (value, dim));
					cfunc.add_parameter (new CCodeParameter (get_array_length_cname ("value", dim), "gint"));
				}
			}

			push_function (cfunc);

			// sink floating reference
			var sink = new CCodeFunctionCall (new CCodeIdentifier ("g_variant_ref_sink"));
			sink.add_argument (serialize_expression (type, new CCodeIdentifier ("value")));
			ccode.add_return (sink);

			pop_function ();

			cfile.add_function_declaration (cfunc);
			cfile.add_function (cfunc);

			result.cvalue = ccall;
			result.value_type.value_owned = true;

			result = (GLibValue) store_temp_value (result, node);
			if (!target_type.value_owned) {
				// value leaked
				temp_ref_values.insert (0, ((GLibValue) result).copy ());
			}
		} else if (boxing) {
			// value needs to be boxed

			result.value_type.nullable = false;
			if (!result.lvalue || !result.value_type.equals (value.value_type)) {
				result.cvalue = get_implicit_cast_expression (result.cvalue, value.value_type, result.value_type, node);
				result = (GLibValue) store_temp_value (result, node);
			}
			result.cvalue = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, result.cvalue);
			result.lvalue = false;
			result.value_type.nullable = true;
		} else if (unboxing) {
			// unbox value

			result.cvalue = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, result.cvalue);
		} else {
			// TODO: rewrite get_implicit_cast_expression to return a GLibValue
			var old_cexpr = result.cvalue;
			result.cvalue = get_implicit_cast_expression (result.cvalue, type, target_type, node);
			result.lvalue = result.lvalue && result.cvalue == old_cexpr;
		}

		if (!gvalue_boxing && !gvariant_boxing && target_type.value_owned && (!type.value_owned || boxing || unboxing) && requires_copy (target_type) && !(type is NullType)) {
			// need to copy value
			var copy = (GLibValue) copy_value (result, node);
			if (target_type.data_type is Interface && copy == null) {
				Report.error (node.source_reference, "missing class prerequisite for interface `%s', add GLib.Object to interface declaration if unsure".printf (target_type.data_type.get_full_name ()));
				return result;
			}
			result = copy;
		}

		return result;
	}

	public virtual CCodeExpression get_implicit_cast_expression (CCodeExpression source_cexpr, DataType? expression_type, DataType? target_type, CodeNode? node) {
		var cexpr = source_cexpr;

		if (expression_type.data_type != null && expression_type.data_type == target_type.data_type) {
			// same type, no cast required
			return cexpr;
		}

		if (expression_type is NullType) {
			// null literal, no cast required when not converting to generic type pointer
			return cexpr;
		}

		generate_type_declaration (target_type, cfile);

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
		if (instance is BaseAccess) {
			if (prop.base_property != null) {
				var base_class = (Class) prop.base_property.parent_symbol;
				var vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_CLASS".printf (get_ccode_upper_case_name (base_class, null))));
				vcast.add_argument (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (current_class, null))));
				
				var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "set_%s".printf (prop.name)));
				ccall.add_argument ((CCodeExpression) get_ccodenode (instance));
				ccall.add_argument (get_cvalue_ (value));

				ccode.add_expression (ccall);
			} else if (prop.base_interface_property != null) {
				var base_iface = (Interface) prop.base_interface_property.parent_symbol;
				string parent_iface_var = "%s_%s_parent_iface".printf (get_ccode_lower_case_name (current_class), get_ccode_lower_case_name (base_iface));

				var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (new CCodeIdentifier (parent_iface_var), "set_%s".printf (prop.name)));
				ccall.add_argument ((CCodeExpression) get_ccodenode (instance));
				ccall.add_argument (get_cvalue_ (value));

				ccode.add_expression (ccall);
			}
			return;
		}

		var set_func = "g_object_set";
		
		var base_property = prop;
		if (!get_ccode_no_accessor_method (prop)) {
			if (prop.base_property != null) {
				base_property = prop.base_property;
			} else if (prop.base_interface_property != null) {
				base_property = prop.base_interface_property;
			}

			if (prop is DynamicProperty) {
				set_func = get_dynamic_property_setter_cname ((DynamicProperty) prop);
			} else {
				generate_property_accessor_declaration (base_property.set_accessor, cfile);
				set_func = get_ccode_name (base_property.set_accessor);

				if (!prop.external && prop.external_package) {
					// internal VAPI properties
					// only add them once per source file
					if (add_generated_external_symbol (prop)) {
						visit_property (prop);
					}
				}
			}
		}
		
		var ccall = new CCodeFunctionCall (new CCodeIdentifier (set_func));

		if (prop.binding == MemberBinding.INSTANCE) {
			/* target instance is first argument */
			var cinstance = (CCodeExpression) get_ccodenode (instance);

			if (prop.parent_symbol is Struct) {
				// we need to pass struct instance by reference
				var instance_value = instance.target_value;
				if (!get_lvalue (instance_value)) {
					instance_value = store_temp_value (instance_value, instance);
				}
				cinstance = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue_ (instance_value));
			}

			ccall.add_argument (cinstance);
		}

		if (get_ccode_no_accessor_method (prop)) {
			/* property name is second argument of g_object_set */
			ccall.add_argument (get_property_canonical_cconstant (prop));
		}

		var cexpr = get_cvalue_ (value);

		if (prop.property_type.is_real_non_null_struct_type ()) {
			cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr);
		}

		var array_type = prop.property_type as ArrayType;

		ccall.add_argument (cexpr);

		if (array_type != null && get_ccode_array_length (prop)) {
			for (int dim = 1; dim <= array_type.rank; dim++) {
				ccall.add_argument (get_array_length_cvalue (value, dim));
			}
		} else if (prop.property_type is DelegateType) {
			var delegate_type = (DelegateType) prop.property_type;
			if (delegate_type.delegate_symbol.has_target) {
				ccall.add_argument (get_delegate_target_cvalue (value));
				if (base_property.set_accessor.value_type.value_owned) {
					ccall.add_argument (get_delegate_target_destroy_notify_cvalue (value));
				}
			}
		}

		if (get_ccode_no_accessor_method (prop)) {
			ccall.add_argument (new CCodeConstant ("NULL"));
		}

		ccode.add_expression (ccall);
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
		if (type.data_type != null && !type.nullable && get_ccode_default_value (type.data_type) != "") {
			return new CCodeConstant (get_ccode_default_value (type.data_type));
		} else if (initializer_expression && !type.nullable &&
				   (st != null || (array_type != null && array_type.fixed_length))) {
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
		} else if (type.type_parameter != null) {
			return new CCodeConstant ("NULL");
		} else if (type is ErrorType) {
			return new CCodeConstant ("NULL");
		}
		return null;
	}
	
	private void create_property_type_check_statement (Property prop, bool check_return_type, TypeSymbol t, bool non_null, string var_name) {
		if (check_return_type) {
			create_type_check_statement (prop, prop.property_type, t, non_null, var_name);
		} else {
			create_type_check_statement (prop, new VoidType (), t, non_null, var_name);
		}
	}

	public virtual void create_type_check_statement (CodeNode method_node, DataType ret_type, TypeSymbol t, bool non_null, string var_name) {
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

	public CCodeExpression? get_ccodenode (Expression node) {
		if (get_cvalue (node) == null) {
			node.emit (this);
		}
		return get_cvalue (node);
	}

	public bool is_lvalue_access_allowed (DataType type) {
		var array_type = type as ArrayType;
		if (array_type != null && array_type.inline_allocated) {
			return false;
		}
		if (type.data_type != null) {
			return type.data_type.get_attribute_bool ("CCode", "lvalue_access", true);
		}
		return true;
	}

	public static CCodeAttribute get_ccode_attribute (CodeNode node) {
		var attr = node.get_attribute_cache (ccode_attribute_cache_index);
		if (attr == null) {
			attr = new CCodeAttribute (node);
			node.set_attribute_cache (ccode_attribute_cache_index, attr);
		}
		return (CCodeAttribute) attr;
	}

	public static string get_ccode_name (CodeNode node) {
		return get_ccode_attribute(node).name;
	}

	public static string get_ccode_const_name (CodeNode node) {
		return get_ccode_attribute(node).const_name;
	}

	public static string get_ccode_type_name (Interface iface) {
		return get_ccode_attribute(iface).type_name;
	}

	public static string get_ccode_lower_case_name (CodeNode node, string? infix = null) {
		var sym = node as Symbol;
		if (sym != null) {
			if (infix == null) {
				infix = "";
			}
			if (sym is Delegate) {
				return "%s%s%s".printf (get_ccode_lower_case_prefix (sym.parent_symbol), infix, Symbol.camel_case_to_lower_case (sym.name));
			} else if (sym is ErrorCode) {
				return get_ccode_name (sym).down ();
			} else {
				return "%s%s%s".printf (get_ccode_lower_case_prefix (sym.parent_symbol), infix, get_ccode_lower_case_suffix (sym));
			}
		} else if (node is ErrorType) {
			var type = (ErrorType) node;
			if (type.error_domain == null) {
				if (infix == null) {
					return "g_error";
				} else {
					return "g_%s_error".printf (infix);
				}
			} else if (type.error_code == null) {
				return get_ccode_lower_case_name (type.error_domain, infix);
			} else {
				return get_ccode_lower_case_name (type.error_code, infix);
			}
		} else {
			var type = (DataType) node;
			return get_ccode_lower_case_name (type.data_type, infix);
		}
	}

	public static string get_ccode_upper_case_name (Symbol sym, string? infix = null) {
		if (sym is Property) {
			return "%s_%s".printf (get_ccode_lower_case_name (sym.parent_symbol), Symbol.camel_case_to_lower_case (sym.name)).up ();
		} else {
			return get_ccode_lower_case_name (sym, infix).up ();
		}
	}

	public static string get_ccode_header_filenames (Symbol sym) {
		return get_ccode_attribute(sym).header_filenames;
	}

	public static string get_ccode_prefix (Symbol sym) {
		return get_ccode_attribute(sym).prefix;
	}

	public static string get_ccode_lower_case_prefix (Symbol sym) {
		return get_ccode_attribute(sym).lower_case_prefix;
	}

	public static string get_ccode_lower_case_suffix (Symbol sym) {
		return get_ccode_attribute(sym).lower_case_suffix;
	}

	public static string get_ccode_ref_function (TypeSymbol sym) {
		return get_ccode_attribute(sym).ref_function;
	}

	public static bool is_reference_counting (TypeSymbol sym) {
		if (sym is Class) {
			return get_ccode_ref_function (sym) != null;
		} else if (sym is Interface) {
			return true;
		} else {
			return false;
		}
	}

	public static bool get_ccode_ref_function_void (Class cl) {
		return get_ccode_attribute(cl).ref_function_void;
	}

	public static bool get_ccode_free_function_address_of (Class cl) {
		return get_ccode_attribute(cl).free_function_address_of;
	}

	public static string get_ccode_unref_function (ObjectTypeSymbol sym) {
		return get_ccode_attribute(sym).unref_function;
	}

	public static string get_ccode_ref_sink_function (ObjectTypeSymbol sym) {
		return get_ccode_attribute(sym).ref_sink_function;
	}

	public static string get_ccode_copy_function (TypeSymbol sym) {
		return get_ccode_attribute(sym).copy_function;
	}

	public static string get_ccode_destroy_function (TypeSymbol sym) {
		return get_ccode_attribute(sym).destroy_function;
	}

	public static string? get_ccode_dup_function (TypeSymbol sym) {
		if (sym is Struct) {
			if (sym.external_package) {
				return null;
			} else {
				return get_ccode_lower_case_prefix (sym) + "dup";
			}
		}
		return get_ccode_copy_function (sym);
	}

	public static string get_ccode_free_function (TypeSymbol sym) {
		return get_ccode_attribute(sym).free_function;
	}

	public static bool get_ccode_is_gboxed (TypeSymbol sym) {
		return get_ccode_free_function (sym) == "g_boxed_free";
	}

	public static string get_ccode_type_id (CodeNode node) {
		return get_ccode_attribute(node).type_id;
	}

	public static string get_ccode_marshaller_type_name (CodeNode node) {
		return get_ccode_attribute(node).marshaller_type_name;
	}

	public static string get_ccode_get_value_function (CodeNode sym) {
		return get_ccode_attribute(sym).get_value_function;
	}

	public static string get_ccode_set_value_function (CodeNode sym) {
		return get_ccode_attribute(sym).set_value_function;
	}

	public static string get_ccode_take_value_function (CodeNode sym) {
		return get_ccode_attribute(sym).take_value_function;
	}

	public static string get_ccode_param_spec_function (CodeNode sym) {
		return get_ccode_attribute(sym).param_spec_function;
	}

	public static string get_ccode_type_check_function (TypeSymbol sym) {
		var cl = sym as Class;
		var a = sym.get_attribute_string ("CCode", "type_check_function");
		if (cl != null && a != null) {
			return a;
		} else if ((cl != null && cl.is_compact) || sym is Struct || sym is Enum || sym is Delegate) {
			return "";
		} else {
			return get_ccode_upper_case_name (sym, "IS_");
		}
	}

	public static string get_ccode_default_value (TypeSymbol sym) {
		return get_ccode_attribute(sym).default_value;
	}

	public static bool get_ccode_has_copy_function (Struct st) {
		return st.get_attribute_bool ("CCode", "has_copy_function", true);
	}

	public static bool get_ccode_has_destroy_function (Struct st) {
		return st.get_attribute_bool ("CCode", "has_destroy_function", true);
	}

	public static double get_ccode_instance_pos (CodeNode node) {
		if (node is Delegate) {
			return node.get_attribute_double ("CCode", "instance_pos", -2);
		} else {
			return node.get_attribute_double ("CCode", "instance_pos", 0);
		}
	}

	public static bool get_ccode_array_length (CodeNode node) {
		return get_ccode_attribute(node).array_length;
	}

	public static string? get_ccode_array_length_type (CodeNode node) {
		return get_ccode_attribute(node).array_length_type;
	}

	public static bool get_ccode_array_null_terminated (CodeNode node) {
		return get_ccode_attribute(node).array_null_terminated;
	}

	public static string? get_ccode_array_length_name (CodeNode node) {
		return get_ccode_attribute(node).array_length_name;
	}

	public static string? get_ccode_array_length_expr (CodeNode node) {
		return get_ccode_attribute(node).array_length_expr;
	}

	public static double get_ccode_array_length_pos (CodeNode node) {
		var a = node.get_attribute ("CCode");
		if (a != null && a.has_argument ("array_length_pos")) {
			return a.get_double ("array_length_pos");
		}
		if (node is Parameter) {
			var param = (Parameter) node;
			return get_ccode_pos (param) + 0.1;
		} else {
			return -3;
		}
	}

	public static double get_ccode_delegate_target_pos (CodeNode node) {
		var a = node.get_attribute ("CCode");
		if (a != null && a.has_argument ("delegate_target_pos")) {
			return a.get_double ("delegate_target_pos");
		}
		if (node is Parameter) {
			var param = (Parameter) node;
			return get_ccode_pos (param) + 0.1;
		} else {
			return -3;
		}
	}

	public static double get_ccode_destroy_notify_pos (CodeNode node) {
		var a = node.get_attribute ("CCode");
		if (a != null && a.has_argument ("destroy_notify_pos")) {
			return a.get_double ("destroy_notify_pos");
		}
		if (node is Parameter) {
			var param = (Parameter) node;
			return get_ccode_pos (param) + 0.1;
		} else {
			return -3;
		}
	}

	public static bool get_ccode_delegate_target (CodeNode node) {
		return get_ccode_attribute(node).delegate_target;
	}

	public static string get_ccode_delegate_target_name (Variable variable) {
		return get_ccode_attribute(variable).delegate_target_name;
	}

	public static double get_ccode_pos (Parameter param) {
		return get_ccode_attribute(param).pos;
	}

	public static string? get_ccode_type (CodeNode node) {
		return get_ccode_attribute(node).ctype;
	}

	public static bool get_ccode_simple_generics (Method m) {
		return m.get_attribute_bool ("CCode", "simple_generics");
	}

	public static string get_ccode_real_name (Symbol sym) {
		return get_ccode_attribute(sym).real_name;
	}

	public static string get_ccode_constructv_name (CreationMethod m) {
		const string infix = "constructv";

		var parent = m.parent_symbol as Class;

		if (m.name == ".new") {
			return "%s%s".printf (get_ccode_lower_case_prefix (parent), infix);
		} else {
			return "%s%s_%s".printf (get_ccode_lower_case_prefix (parent), infix, m.name);
		}
	}

	public static string get_ccode_vfunc_name (Method m) {
		return get_ccode_attribute(m).vfunc_name;
	}

	public static string get_ccode_finish_name (Method m) {
		return get_ccode_attribute(m).finish_name;
	}

	public static string get_ccode_finish_vfunc_name (Method m) {
		return get_ccode_attribute(m).finish_vfunc_name;
	}

	public static string get_ccode_finish_real_name (Method m) {
		return get_ccode_attribute(m).finish_real_name;
	}

	public static bool get_ccode_no_accessor_method (Property p) {
		return p.get_attribute ("NoAccessorMethod") != null;
	}

	public static bool get_ccode_has_type_id (TypeSymbol sym) {
		return sym.get_attribute_bool ("CCode", "has_type_id", true);
	}

	public static bool get_ccode_has_new_function (Method m) {
		return m.get_attribute_bool ("CCode", "has_new_function", true);
	}

	public static bool get_ccode_has_generic_type_parameter (Method m) {
		var a = m.get_attribute ("CCode");
		return a != null && a.has_argument ("generic_type_pos");
	}

	public static double get_ccode_generic_type_pos (Method m) {
		return m.get_attribute_double ("CCode", "generic_type_pos");
	}

	public static string get_ccode_sentinel (Method m) {
		return get_ccode_attribute(m).sentinel;
	}

	public static bool get_ccode_notify (Property prop) {
		return prop.get_attribute_bool ("CCode", "notify", true);
	}

	public static string get_ccode_nick (Property prop) {
		var nick = prop.get_attribute_string ("Description", "nick");
		if (nick == null) {
			nick = prop.name.replace ("_", "-");
		}
		return nick;
	}

	public static string get_ccode_blurb (Property prop) {
		var blurb = prop.get_attribute_string ("Description", "blurb");
		if (blurb == null) {
			blurb = prop.name.replace ("_", "-");
		}
		return blurb;
	}

	public static string get_ccode_declarator_suffix (DataType type) {
		var array_type = type as ArrayType;
		if (array_type != null) {
			if (array_type.fixed_length) {
				return "[%d]".printf (array_type.length);
			} else if (array_type.inline_allocated) {
				return "[]";
			}
		}
		return "";
	}

	public CCodeConstant get_signal_canonical_constant (Signal sig, string? detail = null) {
		var str = new StringBuilder ("\"");

		string i = get_ccode_name (sig);

		while (i.length > 0) {
			unichar c = i.get_char ();
			if (c == '_') {
				str.append_c ('-');
			} else {
				str.append_unichar (c);
			}

			i = i.next_char ();
		}

		if (detail != null) {
			str.append ("::");
			str.append (detail);
		}

		str.append_c ('"');

		return new CCodeConstant (str.str);
	}

	public static CCodeConstant get_enum_value_canonical_cconstant (EnumValue ev) {
		var str = new StringBuilder ("\"");

		string i = ev.name;

		while (i.length > 0) {
			unichar c = i.get_char ();
			if (c == '_') {
				str.append_c ('-');
			} else {
				str.append_unichar (c.tolower ());
			}

			i = i.next_char ();
		}

		str.append_c ('"');

		return new CCodeConstant (str.str);
	}

	public bool get_signal_has_emitter (Signal sig) {
		return sig.get_attribute ("HasEmitter") != null;
	}

	public CCodeConstant get_property_canonical_cconstant (Property prop) {
		return new CCodeConstant ("\"%s\"".printf (prop.name.replace ("_", "-")));
	}

	public override void visit_class (Class cl) {
	}

	public void create_postcondition_statement (Expression postcondition) {
		var cassert = new CCodeFunctionCall (new CCodeIdentifier ("g_warn_if_fail"));

		postcondition.emit (this);

		cassert.add_argument (get_cvalue (postcondition));

		ccode.add_expression (cassert);
	}

	public virtual bool is_gobject_property (Property prop) {
		return false;
	}

	public DataType? get_this_type () {
		if (current_method != null && current_method.binding == MemberBinding.INSTANCE) {
			return current_method.this_parameter.variable_type;
		} else if (current_property_accessor != null && current_property_accessor.prop.binding == MemberBinding.INSTANCE) {
			return current_property_accessor.prop.this_parameter.variable_type;
		} else if (current_constructor != null && current_constructor.binding == MemberBinding.INSTANCE) {
			return current_constructor.this_parameter.variable_type;
		} else if (current_destructor != null && current_destructor.binding == MemberBinding.INSTANCE) {
			return current_destructor.this_parameter.variable_type;
		}
		return null;
	}

	public CCodeFunctionCall generate_instance_cast (CCodeExpression expr, TypeSymbol type) {
		var result = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_CHECK_INSTANCE_CAST"));
		result.add_argument (expr);
		result.add_argument (new CCodeIdentifier (get_ccode_type_id (type)));
		result.add_argument (new CCodeIdentifier (get_ccode_name (type)));
		return result;
	}

	void generate_struct_destroy_function (Struct st) {
		if (cfile.add_declaration (get_ccode_destroy_function (st))) {
			// only generate function once per source file
			return;
		}

		var function = new CCodeFunction (get_ccode_destroy_function (st), "void");
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeParameter ("self", get_ccode_name (st) + "*"));

		push_context (new EmitContext ());
		push_function (function);

		var this_value = load_this_parameter (st);
		foreach (Field f in st.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE) {
				if (requires_destroy (f.variable_type)) {
					ccode.add_expression (destroy_field (f, this_value));
				}
			}
		}

		pop_function ();
		pop_context ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);
	}

	void generate_struct_copy_function (Struct st) {
		if (cfile.add_declaration (get_ccode_copy_function (st))) {
			// only generate function once per source file
			return;
		}

		var function = new CCodeFunction (get_ccode_copy_function (st), "void");
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeParameter ("self", "const " + get_ccode_name (st) + "*"));
		function.add_parameter (new CCodeParameter ("dest", get_ccode_name (st) + "*"));

		push_context (new EmitContext ());
		push_function (function);

		var dest_struct = new GLibValue (get_data_type_for_symbol (st), new CCodeIdentifier ("(*dest)"), true);
		foreach (Field f in st.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE) {
				var value = load_field (f, load_this_parameter ((TypeSymbol) st));
				if (requires_copy (f.variable_type))  {
					value = copy_value (value, f);
					if (value == null) {
						// error case, continue to avoid critical
						continue;
					}
				}
				store_field (f, dest_struct, value);
			}
		}

		pop_function ();
		pop_context ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);
	}

	public void return_default_value (DataType return_type) {
		ccode.add_return (default_value_for_type (return_type, false));
	}

	public virtual void generate_dynamic_method_wrapper (DynamicMethod method) {
	}

	public virtual bool method_has_wrapper (Method method) {
		return false;
	}

	public virtual CCodeFunctionCall get_param_spec (Property prop) {
		return new CCodeFunctionCall (new CCodeIdentifier (""));
	}

	public virtual CCodeFunctionCall get_signal_creation (Signal sig, TypeSymbol type) {
		return new CCodeFunctionCall (new CCodeIdentifier (""));
	}

	public virtual void register_dbus_info (CCodeBlock block, ObjectTypeSymbol bindable) {
	}

	public virtual string get_dynamic_property_getter_cname (DynamicProperty node) {
		Report.error (node.source_reference, "dynamic properties are not supported for %s".printf (node.dynamic_type.to_string ()));
		return "";
	}

	public virtual string get_dynamic_property_setter_cname (DynamicProperty node) {
		Report.error (node.source_reference, "dynamic properties are not supported for %s".printf (node.dynamic_type.to_string ()));
		return "";
	}

	public virtual string get_dynamic_signal_cname (DynamicSignal node) {
		return "";
	}

	public virtual string get_dynamic_signal_connect_wrapper_name (DynamicSignal node) {
		return "";
	}

	public virtual string get_dynamic_signal_connect_after_wrapper_name (DynamicSignal node) {
		return "";
	}

	public virtual string get_dynamic_signal_disconnect_wrapper_name (DynamicSignal node) {
		return "";
	}

	public virtual string get_array_length_cname (string array_cname, int dim) {
		return "";
	}

	public virtual string get_parameter_array_length_cname (Parameter param, int dim) {
		return "";
	}

	public virtual CCodeExpression get_array_length_cexpression (Expression array_expr, int dim = -1) {
		return new CCodeConstant ("");
	}

	public virtual CCodeExpression get_array_length_cvalue (TargetValue value, int dim = -1) {
		return new CCodeInvalidExpression ();
	}

	public virtual string get_array_size_cname (string array_cname) {
		return "";
	}

	public virtual void add_simple_check (CodeNode node, bool always_fails = false) {
	}

	public virtual string generate_ready_function (Method m) {
		return "";
	}

	public CCodeExpression? get_cvalue (Expression expr) {
		if (expr.target_value == null) {
			return null;
		}
		var glib_value = (GLibValue) expr.target_value;
		return glib_value.cvalue;
	}

	public CCodeExpression? get_cvalue_ (TargetValue value) {
		var glib_value = (GLibValue) value;
		return glib_value.cvalue;
	}

	public void set_cvalue (Expression expr, CCodeExpression? cvalue) {
		var glib_value = (GLibValue) expr.target_value;
		if (glib_value == null) {
			glib_value = new GLibValue (expr.value_type);
			expr.target_value = glib_value;
		}
		glib_value.cvalue = cvalue;
	}

	public CCodeExpression? get_array_size_cvalue (TargetValue value) {
		var glib_value = (GLibValue) value;
		return glib_value.array_size_cvalue;
	}

	public void set_array_size_cvalue (TargetValue value, CCodeExpression? cvalue) {
		var glib_value = (GLibValue) value;
		glib_value.array_size_cvalue = cvalue;
	}

	public CCodeExpression? get_delegate_target (Expression expr) {
		if (expr.target_value == null) {
			return null;
		}
		var glib_value = (GLibValue) expr.target_value;
		return glib_value.delegate_target_cvalue;
	}

	public void set_delegate_target (Expression expr, CCodeExpression? delegate_target) {
		var glib_value = (GLibValue) expr.target_value;
		if (glib_value == null) {
			glib_value = new GLibValue (expr.value_type);
			expr.target_value = glib_value;
		}
		glib_value.delegate_target_cvalue = delegate_target;
	}

	public CCodeExpression? get_delegate_target_destroy_notify (Expression expr) {
		if (expr.target_value == null) {
			return null;
		}
		var glib_value = (GLibValue) expr.target_value;
		return glib_value.delegate_target_destroy_notify_cvalue;
	}

	public void set_delegate_target_destroy_notify (Expression expr, CCodeExpression? destroy_notify) {
		var glib_value = (GLibValue) expr.target_value;
		if (glib_value == null) {
			glib_value = new GLibValue (expr.value_type);
			expr.target_value = glib_value;
		}
		glib_value.delegate_target_destroy_notify_cvalue = destroy_notify;
	}

	public void append_array_length (Expression expr, CCodeExpression size) {
		var glib_value = (GLibValue) expr.target_value;
		if (glib_value == null) {
			glib_value = new GLibValue (expr.value_type);
			expr.target_value = glib_value;
		}
		glib_value.append_array_length_cvalue (size);
	}

	public List<CCodeExpression>? get_array_lengths (Expression expr) {
		var glib_value = (GLibValue) expr.target_value;
		if (glib_value == null) {
			glib_value = new GLibValue (expr.value_type);
			expr.target_value = glib_value;
		}
		return glib_value.array_length_cvalues;
	}

	public bool get_lvalue (TargetValue value) {
		var glib_value = (GLibValue) value;
		return glib_value.lvalue;
	}

	public bool get_non_null (TargetValue value) {
		var glib_value = (GLibValue) value;
		return glib_value.non_null;
	}

	public string? get_ctype (TargetValue value) {
		var glib_value = (GLibValue) value;
		return glib_value.ctype;
	}

	public bool get_array_null_terminated (TargetValue value) {
		var glib_value = (GLibValue) value;
		return glib_value.array_null_terminated;
	}

	public CCodeExpression get_array_length_cexpr (TargetValue value) {
		var glib_value = (GLibValue) value;
		return glib_value.array_length_cexpr;
	}
}

public class Vala.GLibValue : TargetValue {
	public CCodeExpression cvalue;
	public bool lvalue;
	public bool non_null;
	public string? ctype;

	public List<CCodeExpression> array_length_cvalues;
	public CCodeExpression? array_size_cvalue;
	public bool array_null_terminated;
	public CCodeExpression? array_length_cexpr;

	public CCodeExpression? delegate_target_cvalue;
	public CCodeExpression? delegate_target_destroy_notify_cvalue;

	public GLibValue (DataType? value_type = null, CCodeExpression? cvalue = null, bool lvalue = false) {
		base (value_type);
		this.cvalue = cvalue;
		this.lvalue = lvalue;
	}

	public void append_array_length_cvalue (CCodeExpression length_cvalue) {
		if (array_length_cvalues == null) {
			array_length_cvalues = new ArrayList<CCodeExpression> ();
		}
		array_length_cvalues.add (length_cvalue);
	}

	public GLibValue copy () {
		var result = new GLibValue (value_type.copy (), cvalue, lvalue);
		result.actual_value_type = actual_value_type;
		result.non_null = non_null;
		result.ctype = ctype;

		if (array_length_cvalues != null) {
			foreach (var cexpr in array_length_cvalues) {
				result.append_array_length_cvalue (cexpr);
			}
		}
		result.array_size_cvalue = array_size_cvalue;
		result.array_null_terminated = array_null_terminated;
		result.array_length_cexpr = array_length_cexpr;

		result.delegate_target_cvalue = delegate_target_cvalue;
		result.delegate_target_destroy_notify_cvalue = delegate_target_destroy_notify_cvalue;

		return result;
	}
}
