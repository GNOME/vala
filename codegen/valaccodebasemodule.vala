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
		public int current_try_id;
		public int next_try_id;
		public CatchClause current_catch;
		public CCodeFunction ccode;
		public ArrayList<CCodeFunction> ccode_stack = new ArrayList<CCodeFunction> ();
		public ArrayList<TargetValue> temp_ref_values = new ArrayList<TargetValue> ();
		public int next_temp_var_id;
		public int current_inner_error_id;
		public bool current_method_inner_error;
		public bool current_method_return;
		public int next_coroutine_state = 1;
		public Map<string,string> variable_name_map = new HashMap<string,string> (str_hash, str_equal);
		public Map<string,int> closure_variable_count_map = new HashMap<string,int> (str_hash, str_equal);
		public Map<LocalVariable,int> closure_variable_clash_map = new HashMap<LocalVariable,int> ();
		public bool is_in_method_precondition;

		public EmitContext (Symbol? symbol = null) {
			current_symbol = symbol;
		}

		public void push_symbol (Symbol symbol) {
			symbol_stack.add (current_symbol);
			current_symbol = symbol;
		}

		public void pop_symbol () {
			current_symbol = symbol_stack.remove_at (symbol_stack.size - 1);
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

	public int current_try_id {
		get { return emit_context.current_try_id; }
		set { emit_context.current_try_id = value; }
	}

	public int next_try_id {
		get { return emit_context.next_try_id; }
		set { emit_context.next_try_id = value; }
	}

	public CatchClause current_catch {
		get { return emit_context.current_catch; }
		set { emit_context.current_catch = value; }
	}

	public int current_inner_error_id {
		get { return emit_context.current_inner_error_id; }
		set { emit_context.current_inner_error_id = value; }
	}

	public bool is_in_method_precondition {
		get { return emit_context.is_in_method_precondition; }
		set { emit_context.is_in_method_precondition = value; }
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
	public CCodeEnum signal_enum;

	public CCodeFunction ccode { get { return emit_context.ccode; } }

	/* temporary variables that own their content */
	public ArrayList<TargetValue> temp_ref_values { get { return emit_context.temp_ref_values; } }
	/* cache to check whether a certain marshaller has been created yet */
	public Set<string> user_marshal_set;
	/* (constant) hash table with all predefined marshallers */
	public Set<string> predefined_marshal_set;
	/* (constant) hash table with all reserved identifiers in the generated code */
	public static Set<string> reserved_identifiers;
	public static Set<string> reserved_vala_identifiers;

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

	int next_block_id = 0;
	Map<Block,int> block_map = new HashMap<Block,int> ();

	/* count of emitted inner_error variables in methods */
	Map<weak Method,int> method_inner_error_var_count = new HashMap<weak Method,int> ();

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
	public DataType size_t_type;
	public DataType ssize_t_type;
	public DataType string_type;
	public DataType regex_type;
	public DataType float_type;
	public DataType double_type;
	public DataType pointer_type;
	public TypeSymbol gtype_type;
	public TypeSymbol gobject_type;
	public ErrorType gerror_type;
	public Class glist_type;
	public Class gslist_type;
	public Class gnode_type;
	public Class gqueue_type;
	public Class gvaluearray_type;
	public TypeSymbol gstringbuilder_type;
	public Class garray_type;
	public TypeSymbol gbytearray_type;
	public TypeSymbol genericarray_type;
	public Class gsequence_type;
	public Class gsequence_iter_type;
	public TypeSymbol gthreadpool_type;
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
	public DataType delegate_target_type;
	public DelegateType delegate_target_destroy_type;
	Delegate destroy_notify;
	Class gerror;

	public bool in_plugin = false;
	public string module_init_param_name;

	public bool requires_assert;
	public bool requires_array_free;
	public bool requires_array_move;
	public bool requires_array_length;
	public bool requires_array_n_elements;
	public bool requires_clear_mutex;
	public bool requires_memdup2;
	public bool requires_vala_extern;

	public Set<string> wrappers;
	Set<Symbol> generated_external_symbols;

	public Map<string,string> variable_name_map { get { return emit_context.variable_name_map; } }

	public static int ccode_attribute_cache_index = CodeNode.get_attribute_cache_index ();

	protected CCodeBaseModule () {
		if (Vala.get_build_version () != Vala.BUILD_VERSION) {
			Report.error (null, "Integrity check failed (libvala %s doesn't match ccodegen %s)", Vala.get_build_version (), Vala.BUILD_VERSION);
		}

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
		predefined_marshal_set.add ("VOID:BOXED");
		predefined_marshal_set.add ("VOID:VARIANT");
		predefined_marshal_set.add ("BOOLEAN:BOXED,BOXED");

		init ();
	}

	public static void init () {
		if (reserved_identifiers != null) {
			return;
		}

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

		// C11 keywords
		reserved_identifiers.add ("_Alignas");
		reserved_identifiers.add ("_Alignof");
		reserved_identifiers.add ("_Atomic");
		reserved_identifiers.add ("_Generic");
		reserved_identifiers.add ("_Noreturn");
		reserved_identifiers.add ("_Static_assert");
		reserved_identifiers.add ("_Thread_local");

		// MSVC keywords
		reserved_identifiers.add ("cdecl");

		reserved_vala_identifiers = new HashSet<string> (str_hash, str_equal);

		// reserved for Vala/GObject naming conventions
		reserved_vala_identifiers.add ("error");
		reserved_vala_identifiers.add ("result");
		reserved_vala_identifiers.add ("self");
	}

	public override void emit (CodeContext context) {
		this.context = context;

		ccode_init (context.profile);

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
		size_t_type = new IntegerType ((Struct) root_symbol.scope.lookup ("size_t"));
		ssize_t_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ssize_t"));
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
			gnode_type = (Class) glib_ns.scope.lookup ("Node");
			gqueue_type = (Class) glib_ns.scope.lookup ("Queue");
			gvaluearray_type = (Class) glib_ns.scope.lookup ("ValueArray");
			gstringbuilder_type = (TypeSymbol) glib_ns.scope.lookup ("StringBuilder");
			garray_type = (Class) glib_ns.scope.lookup ("Array");
			gbytearray_type = (TypeSymbol) glib_ns.scope.lookup ("ByteArray");
			genericarray_type = (TypeSymbol) glib_ns.scope.lookup ("GenericArray");
			gsequence_type = (Class) glib_ns.scope.lookup ("Sequence");
			gsequence_iter_type = (Class) glib_ns.scope.lookup ("SequenceIter");
			gthreadpool_type = (TypeSymbol) glib_ns.scope.lookup ("ThreadPool");

			gerror = (Class) glib_ns.scope.lookup ("Error");
			gquark_type = new IntegerType ((Struct) glib_ns.scope.lookup ("Quark"));
			gvalue_type = (Struct) glib_ns.scope.lookup ("Value");
			gvariant_type = (Class) glib_ns.scope.lookup ("Variant");
			gsource_type = (Class) glib_ns.scope.lookup ("Source");

			gmutex_type = (Struct) glib_ns.scope.lookup ("Mutex");
			grecmutex_type = (Struct) glib_ns.scope.lookup ("RecMutex");
			grwlock_type = (Struct) glib_ns.scope.lookup ("RWLock");
			gcond_type = (Struct) glib_ns.scope.lookup ("Cond");

			mutex_type = grecmutex_type;

			type_module_type = (TypeSymbol) glib_ns.scope.lookup ("TypeModule");

			regex_type = new ObjectType ((Class) glib_ns.scope.lookup ("Regex"));

			if (context.module_init_method != null) {
				foreach (Parameter parameter in context.module_init_method.get_parameters ()) {
					if (parameter.variable_type.type_symbol.is_subtype_of (type_module_type)) {
						in_plugin = true;
						module_init_param_name = parameter.name;
						break;

					}
				}
			}

			dbus_proxy_type = (TypeSymbol) glib_ns.scope.lookup ("DBusProxy");

			pointer_type = new StructValueType ((Struct) glib_ns.scope.lookup ("pointer"));

			delegate_target_type = pointer_type;
			destroy_notify = (Delegate) glib_ns.scope.lookup ("DestroyNotify");
			delegate_target_destroy_type = new DelegateType (destroy_notify);
		} else {
			pointer_type = new PointerType (new VoidType ());

			delegate_target_type = pointer_type;
			destroy_notify = new Delegate ("ValaDestroyNotify", new VoidType ());
			destroy_notify.add_parameter (new Parameter ("data", new PointerType (new VoidType ())));
			destroy_notify.has_target = false;
			destroy_notify.owner = root_symbol.scope;
			delegate_target_destroy_type = new DelegateType (destroy_notify);
		}

		var gtk_ns = root_symbol.scope.lookup ("Gtk");
		if (gtk_ns != null) {
			gtk_widget_type = (Class) gtk_ns.scope.lookup ("Widget");
		}

		header_file = new CCodeFile (CCodeFileType.PUBLIC_HEADER);
		internal_header_file = new CCodeFile (CCodeFileType.INTERNAL_HEADER);

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
				Report.error (null, "unable to open `%s' for writing", context.symbols_filename);
				this.context = null;
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
			bool ret;
			if (context.profile == Profile.GOBJECT) {
				header_file.add_include ("glib.h");
				ret = header_file.store (context.header_filename, null, context.version_header, false, "G_BEGIN_DECLS", "G_END_DECLS");
			} else {
				ret = header_file.store (context.header_filename, null, context.version_header, false, "#ifdef  __cplusplus\nextern \"C\" {\n#endif", "#ifdef  __cplusplus\n}\n#endif");
			}
			if (!ret) {
				Report.error (null, "unable to open `%s' for writing", context.header_filename);
			}
		}

		// generate C header file for internal API
		if (context.internal_header_filename != null) {
			bool ret;
			if (context.profile == Profile.GOBJECT) {
				internal_header_file.add_include ("glib.h");
				ret = internal_header_file.store (context.internal_header_filename, null, context.version_header, false, "G_BEGIN_DECLS", "G_END_DECLS");
			} else {
				ret = internal_header_file.store (context.internal_header_filename, null, context.version_header, false, "#ifdef  __cplusplus\nextern \"C\" {\n#endif", "#ifdef  __cplusplus\n}\n#endif");
			}
			if (!ret) {
				Report.error (null, "unable to open `%s' for writing", context.internal_header_filename);
			}
		}

		this.context = null;
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
			this.emit_context = emit_context_stack.remove_at (emit_context_stack.size - 1);
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
			current_line = new CCodeLineDirective (source_reference.file.get_relative_filename (), source_reference.begin.line);
			if (ccode != null) {
				ccode.current_line = current_line;
			}
		}
	}

	public void pop_line () {
		current_line = line_directive_stack.remove_at (line_directive_stack.size - 1);
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
		emit_context.ccode = emit_context.ccode_stack.remove_at (emit_context.ccode_stack.size - 1);
		if (ccode != null) {
			ccode.current_line = current_line;
		}
	}

	public bool add_symbol_declaration (CCodeFile decl_space, Symbol sym, string name) {
		bool in_generated_header = context.header_filename != null
		                           && (decl_space.file_type != CCodeFileType.PUBLIC_HEADER && !sym.is_internal_symbol () && !(sym is Class && ((Class) sym).is_opaque));
		if (decl_space.add_declaration (name)) {
			return true;
		}
		if (sym.source_reference != null) {
			sym.source_reference.file.used = true;
		}
		if (sym.anonymous) {
			return in_generated_header;
		}
		// constants with initializer-list are special
		if (sym is Constant && ((Constant) sym).value is InitializerList) {
			return false;
		}
		// sealed classes are special
		if (!sym.external_package && sym is Class && ((Class) sym).is_sealed) {
			return false;
		}
		if (sym.external_package || in_generated_header
		    || (sym.is_extern && get_ccode_header_filenames (sym).length > 0)) {
			// add feature test macros
			foreach (unowned string feature_test_macro in get_ccode_feature_test_macros (sym).split (",")) {
				decl_space.add_feature_test_macro (feature_test_macro);
			}
			// add appropriate include file
			foreach (unowned string header_filename in get_ccode_header_filenames (sym).split (",")) {
				decl_space.add_include (header_filename,
					!sym.is_extern && (!sym.external_package || (sym.external_package && sym.from_commandline)));
			}
			// declaration complete
			return true;
		} else {
			// require declaration
			return false;
		}
	}

	public virtual void append_vala_array_free () {
	}

	public virtual void append_vala_array_move () {
	}

	public virtual void append_vala_array_length () {
	}

	public virtual void append_params_array (Method m) {
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

	void append_vala_memdup2 () {
		// g_malloc
		cfile.add_include ("glib.h");
		// memcpy
		cfile.add_include ("string.h");

		var fun = new CCodeFunction ("_vala_memdup2", "gpointer");
		fun.modifiers = CCodeModifiers.STATIC | CCodeModifiers.INLINE;
		fun.add_parameter (new CCodeParameter ("mem", "gconstpointer"));
		fun.add_parameter (new CCodeParameter ("byte_size", "gsize"));

		push_function (fun);

		ccode.add_declaration ("gpointer", new CCodeVariableDeclarator ("new_mem"));

		ccode.open_if (new CCodeIdentifier ("mem && byte_size != 0"));

		var malloc = new CCodeFunctionCall (new CCodeIdentifier ("g_malloc"));
		malloc.add_argument (new CCodeIdentifier ("byte_size"));
		ccode.add_assignment (new CCodeIdentifier ("new_mem"), malloc);
		var mcpy = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
		mcpy.add_argument (new CCodeIdentifier ("new_mem"));
		mcpy.add_argument (new CCodeIdentifier ("mem"));
		mcpy.add_argument (new CCodeIdentifier ("byte_size"));
		ccode.add_expression (mcpy);

		ccode.add_else ();

		ccode.add_assignment (new CCodeIdentifier ("new_mem"), new CCodeConstant ("NULL"));

		ccode.close ();

		ccode.add_return (new CCodeIdentifier ("new_mem"));

		pop_function ();

		cfile.add_function_declaration (fun);
		cfile.add_function (fun);
	}

	/**
	 * Define a macro hint for exporting a symbol in a portable way.
	 */
	void append_vala_extern_define (CCodeFile decl_space) {
		var extern_define = new CCodeIfSection ("!defined(VALA_EXTERN)");

		CCodeIfSection if_section;
		if_section = new CCodeIfSection ("defined(_WIN32) || defined(__CYGWIN__)");
		extern_define.append (if_section);
		if_section.append (new CCodeDefine ("VALA_EXTERN", "__declspec(dllexport) extern"));
		if_section = if_section.append_else ("__GNUC__ >= 4");
		if_section.append (new CCodeDefine ("VALA_EXTERN", "__attribute__((visibility(\"default\"))) extern"));
		if_section = if_section.append_else ();
		if_section.append (new CCodeDefine ("VALA_EXTERN", "extern"));

		decl_space.add_define (extern_define);
	}

	void append_c_compiler_mitigations (CCodeFile decl_space) {
		var vala_strict_c = new CCodeIfSection ("!defined(VALA_STRICT_C)");

		CCodeIfSection if_section;
		if_section = new CCodeIfSection ("!defined(__clang__) && defined(__GNUC__) && (__GNUC__ >= 14)");
		vala_strict_c.append (if_section);
		if_section.append (new CCodePragma ("GCC", "diagnostic", "warning \"-Wincompatible-pointer-types\""));
		if_section = if_section.append_else ("defined(__clang__) && (__clang_major__ >= 16)");
		if_section.append (new CCodePragma ("clang", "diagnostic", "ignored \"-Wincompatible-function-pointer-types\""));
		if_section.append (new CCodePragma ("clang", "diagnostic", "ignored \"-Wincompatible-pointer-types\""));

		decl_space.add_define (vala_strict_c);
	}

	public override void visit_source_file (SourceFile source_file) {
		cfile = new CCodeFile (CCodeFileType.SOURCE, source_file);

		user_marshal_set = new HashSet<string> (str_hash, str_equal);

		next_regex_id = 0;

		requires_assert = false;
		requires_array_free = false;
		requires_array_move = false;
		requires_array_length = false;
		requires_array_n_elements = false;
		requires_clear_mutex = false;
		requires_vala_extern = false;

		wrappers = new HashSet<string> (str_hash, str_equal);
		generated_external_symbols = new HashSet<Symbol> ();

		source_file.accept_children (this);

		if (context.report.get_errors () > 0) {
			return;
		}

		/* For fast-vapi, we only wanted the header declarations
		 * to be emitted, so bail out here without writing the
		 * C code output.
		 */
		if (source_file.file_type == SourceFileType.FAST) {
			if (requires_vala_extern) {
				if (context.header_filename != null) {
					if (!header_file.add_declaration ("VALA_EXTERN")) {
						append_vala_extern_define (header_file);
					}
					internal_header_file.add_include (source_file.get_cinclude_filename (), true);
				}
			}
			return;
		}

		append_c_compiler_mitigations (cfile);

		if (requires_assert) {
			cfile.add_type_declaration (new CCodeMacroReplacement.with_expression ("_vala_assert(expr, msg)", new CCodeConstant ("if G_LIKELY (expr) ; else g_assertion_message_expr (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, msg);")));
			cfile.add_type_declaration (new CCodeMacroReplacement.with_expression ("_vala_return_if_fail(expr, msg)", new CCodeConstant ("if G_LIKELY (expr) ; else { g_return_if_fail_warning (G_LOG_DOMAIN, G_STRFUNC, msg); return; }")));
			cfile.add_type_declaration (new CCodeMacroReplacement.with_expression ("_vala_return_val_if_fail(expr, msg, val)", new CCodeConstant ("if G_LIKELY (expr) ; else { g_return_if_fail_warning (G_LOG_DOMAIN, G_STRFUNC, msg); return val; }")));
			cfile.add_type_declaration (new CCodeMacroReplacement.with_expression ("_vala_warn_if_fail(expr, msg)", new CCodeConstant ("if G_LIKELY (expr) ; else g_warn_message (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, msg);")));
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
		if (requires_array_n_elements) {
			cfile.add_type_declaration (new CCodeMacroReplacement.with_expression ("VALA_N_ELEMENTS(arr)", new CCodeConstant ("(sizeof (arr) / sizeof ((arr)[0]))")));
		}
		if (requires_clear_mutex) {
			append_vala_clear_mutex ("GMutex", "g_mutex");
			append_vala_clear_mutex ("GRecMutex", "g_rec_mutex");
			append_vala_clear_mutex ("GRWLock", "g_rw_lock");
			append_vala_clear_mutex ("GCond", "g_cond");
		}
		if (requires_memdup2) {
			append_vala_memdup2 ();
		}
		if (requires_vala_extern) {
			if (context.header_filename != null) {
				if (!header_file.add_declaration ("VALA_EXTERN")) {
					append_vala_extern_define (header_file);
				}
				cfile.add_include (source_file.get_cinclude_filename (), true);
				internal_header_file.add_include (source_file.get_cinclude_filename (), true);
			} else {
				if (!cfile.add_declaration ("VALA_EXTERN")) {
					append_vala_extern_define (cfile);
					append_vala_extern_define (internal_header_file);
				}
			}
		}

		var comments = source_file.get_comments();
		if (comments != null) {
			foreach (Comment comment in comments) {
				var ccomment = new CCodeComment (comment.content);
				cfile.add_comment (ccomment);
			}
		}

		if (!cfile.store (source_file.get_csource_filename (), source_file.filename, context.version_header, context.debug)) {
			Report.error (null, "unable to open `%s' for writing", source_file.get_csource_filename ());
		}

		cfile = null;
	}

	public virtual bool generate_enum_declaration (Enum en, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, en, get_ccode_name (en))) {
			return false;
		}

		var cenum = new CCodeEnum (get_ccode_name (en));

		if (en.version.deprecated) {
			if (context.profile == Profile.GOBJECT) {
				decl_space.add_include ("glib.h");
			}
			cenum.modifiers |= CCodeModifiers.DEPRECATED;
		}

		var current_cfile = cfile;
		cfile = decl_space;

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
			c_ev.modifiers |= (ev.version.deprecated ? CCodeModifiers.DEPRECATED : 0);
			cenum.add_value (c_ev);
		}

		cfile = current_cfile;

		decl_space.add_type_declaration (cenum);
		decl_space.add_type_declaration (new CCodeNewline ());

		if (context.profile != Profile.GOBJECT || !get_ccode_has_type_id (en)) {
			return true;
		}

		decl_space.add_include ("glib-object.h");
		decl_space.add_type_declaration (new CCodeNewline ());

		var fun_name = get_ccode_type_function (en);

		var macro = "(%s ())".printf (fun_name);
		decl_space.add_type_declaration (new CCodeMacroReplacement (get_ccode_type_id (en), macro));

		var regfun = new CCodeFunction (fun_name, "GType");
		regfun.modifiers = CCodeModifiers.CONST;

		if (en.is_private_symbol ()) {
			// avoid C warning as this function is not always used
			regfun.modifiers |= CCodeModifiers.STATIC | CCodeModifiers.UNUSED;
		} else if (context.hide_internal && en.is_internal_symbol ()) {
			regfun.modifiers |= CCodeModifiers.INTERNAL;
		} else {
			regfun.modifiers |= CCodeModifiers.EXTERN;
			requires_vala_extern = true;
		}

		decl_space.add_function_declaration (regfun);

		return true;
	}

	public override void visit_enum (Enum en) {
		push_line (en.source_reference);

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

		en.accept_children (this);

		pop_line ();
	}

	public void visit_member (Symbol m) {
		/* stuff meant for all lockable members */
		if (m is Lockable && ((Lockable) m).lock_used) {
			CCodeExpression l = new CCodeIdentifier ("self");
			var init_context = class_init_context;
			var finalize_context = class_finalize_context;

			if (m.is_instance_member ()) {
				l = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (l, "priv"), get_symbol_lock_name (get_ccode_name (m)));
				init_context = instance_init_context;
				finalize_context = instance_finalize_context;
			} else if (m.is_class_member ()) {
				var get_class_private_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_get_private_function ((Class) m.parent_symbol)));
				get_class_private_call.add_argument (new CCodeIdentifier ("klass"));
				l = new CCodeMemberAccess.pointer (get_class_private_call, get_symbol_lock_name (get_ccode_name (m)));
			} else {
				l = new CCodeIdentifier (get_symbol_lock_name ("%s_%s".printf (get_ccode_lower_case_name (m.parent_symbol), get_ccode_name (m))));
			}

			push_context (init_context);
			var initf = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_name (mutex_type.default_construction_method)));
			initf.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));
			ccode.add_expression (initf);
			pop_context ();

			if (finalize_context != null) {
				push_context (finalize_context);
				var fc = new CCodeFunctionCall (new CCodeIdentifier ("g_rec_mutex_clear"));
				fc.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, l));
				ccode.add_expression (fc);
				pop_context ();
			}
		}
	}

	static void constant_array_ranks_sizes (InitializerList initializer_list, int[] sizes, int rank = 0) {
		sizes[rank] = int.max (sizes[rank], initializer_list.size);
		rank++;
		foreach (var expr in initializer_list.get_initializers()) {
			if (expr is InitializerList && ((InitializerList) expr).target_type is ArrayType) {
				constant_array_ranks_sizes ((InitializerList) expr, sizes, rank);
			}
		}
	}

	CCodeDeclaratorSuffix? get_constant_declarator_suffix (Constant c) {
		unowned ArrayType? array = c.type_reference as ArrayType;
		unowned InitializerList? initializer_list = c.value as InitializerList;
		if (array == null || initializer_list == null) {
			if (c.type_reference.compatible (string_type)) {
				return new CCodeDeclaratorSuffix.with_array ();
			}
			return null;
		}

		var lengths = new ArrayList<CCodeExpression> ();
		int[] sizes = new int[array.rank];
		constant_array_ranks_sizes (initializer_list, sizes);
		for (int i = 0; i < array.rank; i++) {
			lengths.add (new CCodeConstant ("%d".printf (sizes[i])));
		}
		return new CCodeDeclaratorSuffix.with_multi_array (lengths);
	}

	public void generate_constant_declaration (Constant c, CCodeFile decl_space, bool definition = false) {
		if (c.parent_symbol is Block) {
			// local constant
			return;
		}

		if (add_symbol_declaration (decl_space, c, get_ccode_name (c))) {
			return;
		}

		if (!c.external && c.value != null) {
			generate_type_declaration (c.type_reference, decl_space);

			c.value.emit (this);

			var initializer_list = c.value as InitializerList;
			if (initializer_list != null) {
				var cdecl = new CCodeDeclaration (get_ccode_const_name (c.type_reference));
				var cinitializer = get_cvalue (c.value);
				if (!definition) {
					// never output value in header
					// special case needed as this method combines declaration and definition
					cinitializer = null;
				}

				cdecl.add_declarator (new CCodeVariableDeclarator (get_ccode_name (c), cinitializer, get_constant_declarator_suffix (c)));
				if (c.is_private_symbol ()) {
					cdecl.modifiers = CCodeModifiers.STATIC;
				} else {
					cdecl.modifiers = CCodeModifiers.EXTERN;
					requires_vala_extern = true;
				}

				decl_space.add_constant_declaration (cdecl);
			} else {
				if (c.value is StringLiteral && ((StringLiteral) c.value).translate) {
					// translated string constant
					var m = (Method) root_symbol.scope.lookup ("GLib").scope.lookup ("_");
					add_symbol_declaration (decl_space, m, get_ccode_name (m));
				}

				var cdefine = new CCodeDefine.with_expression (get_ccode_name (c), get_cvalue (c.value));
				decl_space.add_define (cdefine);
			}
		}
	}

	public override void visit_constant (Constant c) {
		push_line (c.source_reference);

		if (c.parent_symbol is Block) {
			// local constant

			generate_type_declaration (c.type_reference, cfile);

			c.value.emit (this);

			string type_name;
			if (c.type_reference.compatible (string_type)) {
				type_name = "const char";
			} else {
				type_name = get_ccode_const_name (c.type_reference);
			}

			var cinitializer = get_cvalue (c.value);

			ccode.add_declaration (type_name, new CCodeVariableDeclarator (get_ccode_name (c), cinitializer, get_constant_declarator_suffix (c)), CCodeModifiers.STATIC);
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

	public void append_field (CCodeStruct ccode_struct, Field f, CCodeFile decl_space) {
		generate_type_declaration (f.variable_type, decl_space);

		CCodeModifiers modifiers = (f.is_volatile ? CCodeModifiers.VOLATILE : 0) | (f.version.deprecated ? CCodeModifiers.DEPRECATED : 0);
		ccode_struct.add_field (get_ccode_name (f.variable_type), get_ccode_name (f), modifiers, get_ccode_declarator_suffix (f.variable_type));

		if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
			// create fields to store array dimensions
			var array_type = (ArrayType) f.variable_type;
			if (!array_type.fixed_length) {
				var length_ctype = get_ccode_array_length_type (f);
				for (int dim = 1; dim <= array_type.rank; dim++) {
					string length_cname = get_variable_array_length_cname (f, dim);
					ccode_struct.add_field (length_ctype, length_cname);
				}
				if (array_type.rank == 1 && f.is_internal_symbol ()) {
					ccode_struct.add_field (length_ctype, get_array_size_cname (get_ccode_name (f)));
				}
			}
		} else if (get_ccode_delegate_target (f)) {
			var delegate_type = (DelegateType) f.variable_type;
			if (delegate_type.delegate_symbol.has_target) {
				// create field to store delegate target
				ccode_struct.add_field (get_ccode_name (delegate_target_type), get_ccode_delegate_target_name (f));
				if (delegate_type.is_disposable ()) {
					ccode_struct.add_field (get_ccode_name (delegate_target_destroy_type), get_ccode_delegate_target_destroy_notify_name (f));
				}
			}
		}
	}

	public void generate_field_declaration (Field f, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, f, get_ccode_name (f))) {
			return;
		}

		generate_type_declaration (f.variable_type, decl_space);

		var cdecl = new CCodeDeclaration (get_ccode_name (f.variable_type));
		cdecl.add_declarator (new CCodeVariableDeclarator (get_ccode_name (f), null, get_ccode_declarator_suffix (f.variable_type)));
		if (f.is_private_symbol ()) {
			cdecl.modifiers = CCodeModifiers.STATIC;
		} else {
			cdecl.modifiers = CCodeModifiers.EXTERN;
			requires_vala_extern = true;
		}
		if (f.version.deprecated) {
			cdecl.modifiers |= CCodeModifiers.DEPRECATED;
		}
		if (f.is_volatile) {
			cdecl.modifiers |= CCodeModifiers.VOLATILE;
		}
		decl_space.add_type_member_declaration (cdecl);

		if (f.lock_used) {
			// Declare mutex for static member
			var flock = new CCodeDeclaration (get_ccode_name (mutex_type));
			var flock_decl = new CCodeVariableDeclarator (get_symbol_lock_name ("%s_%s".printf (get_ccode_lower_case_name (f.parent_symbol), get_ccode_name (f))), new CCodeConstant ("{0}"));
			flock.add_declarator (flock_decl);

			if (f.is_private_symbol ()) {
				flock.modifiers = CCodeModifiers.STATIC;
			} else {
				flock.modifiers = CCodeModifiers.EXTERN;
				requires_vala_extern = true;
			}
			decl_space.add_type_member_declaration (flock);
		}

		if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
			var array_type = (ArrayType) f.variable_type;

			if (!array_type.fixed_length) {
				var length_ctype = get_ccode_array_length_type (f);

				for (int dim = 1; dim <= array_type.rank; dim++) {
					cdecl = new CCodeDeclaration (length_ctype);
					cdecl.add_declarator (new CCodeVariableDeclarator (get_variable_array_length_cname (f, dim)));
					if (f.is_private_symbol ()) {
						cdecl.modifiers = CCodeModifiers.STATIC;
					} else {
						cdecl.modifiers = CCodeModifiers.EXTERN;
						requires_vala_extern = true;
					}
					decl_space.add_type_member_declaration (cdecl);
				}
			}
		} else if (get_ccode_delegate_target (f)) {
			var delegate_type = (DelegateType) f.variable_type;
			if (delegate_type.delegate_symbol.has_target) {
				// create field to store delegate target

				cdecl = new CCodeDeclaration (get_ccode_name (delegate_target_type));
				cdecl.add_declarator (new CCodeVariableDeclarator (get_ccode_delegate_target_name (f)));
				if (f.is_private_symbol ()) {
					cdecl.modifiers = CCodeModifiers.STATIC;
				} else {
					cdecl.modifiers = CCodeModifiers.EXTERN;
					requires_vala_extern = true;
				}
				decl_space.add_type_member_declaration (cdecl);

				if (delegate_type.is_disposable ()) {
					cdecl = new CCodeDeclaration (get_ccode_name (delegate_target_destroy_type));
					cdecl.add_declarator (new CCodeVariableDeclarator (get_ccode_delegate_target_destroy_notify_name (f)));
					if (f.is_private_symbol ()) {
						cdecl.modifiers = CCodeModifiers.STATIC;
					} else {
						cdecl.modifiers = CCodeModifiers.EXTERN;
						requires_vala_extern = true;
					}
					decl_space.add_type_member_declaration (cdecl);
				}
			}
		}
	}

	public override void visit_field (Field f) {
		push_line (f.source_reference);
		visit_member (f);

		var cl = f.parent_symbol as Class;
		bool is_gtypeinstance = (cl != null && !cl.is_compact);

		if (f.binding == MemberBinding.INSTANCE)  {
			if (f.initializer != null) {
				push_context (instance_init_context);

				f.initializer.emit (this);

				if (!is_simple_struct_creation (f, f.initializer)) {
					// otherwise handled in visit_object_creation_expression
					store_field (f, new GLibValue (null, new CCodeIdentifier ("self")), f.initializer.target_value, true, f.source_reference);
				}

				foreach (var value in temp_ref_values) {
					ccode.add_expression (destroy_value (value));
				}

				temp_ref_values.clear ();

				pop_context ();
			}

			if ((!(f.variable_type is DelegateType) || get_ccode_delegate_target (f)) && requires_destroy (f.variable_type) && instance_finalize_context != null) {
				push_context (instance_finalize_context);
				ccode.add_expression (destroy_field (f, load_this_parameter ((TypeSymbol) f.parent_symbol)));
				pop_context ();
			}
		} else if (f.binding == MemberBinding.CLASS)  {
			if (f.initializer != null) {
				push_context (class_init_context);

				f.initializer.emit (this);

				store_field (f, null, f.initializer.target_value, true, f.source_reference);

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
				var var_decl = new CCodeVariableDeclarator (get_ccode_name (f), null, get_ccode_declarator_suffix (f.variable_type));
				var initializer = default_value_for_type (f.variable_type, true);
				// error: initializer element is not constant (-std=c99 -pedantic-errors)
				while (initializer is CCodeCastExpression) {
					initializer = ((CCodeCastExpression) initializer).inner;
				}
				var_decl.initializer = initializer;

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

				var var_def = new CCodeDeclaration (get_ccode_name (f.variable_type));
				var_def.add_declarator (var_decl);
				if (!f.is_private_symbol ()) {
					var_def.modifiers = CCodeModifiers.EXTERN;
					requires_vala_extern = true;
				} else {
					var_def.modifiers = CCodeModifiers.STATIC;
				}
				if (f.version.deprecated) {
					var_def.modifiers |= CCodeModifiers.DEPRECATED;
				}
				if (f.is_volatile) {
					var_def.modifiers |= CCodeModifiers.VOLATILE;
				}
				cfile.add_type_member_declaration (var_def);

				/* add array length fields where necessary */
				if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
					var array_type = (ArrayType) f.variable_type;

					if (!array_type.fixed_length) {
						var length_ctype = get_ccode_array_length_type (f);

						for (int dim = 1; dim <= array_type.rank; dim++) {
							var len_def = new CCodeDeclaration (length_ctype);
							len_def.add_declarator (new CCodeVariableDeclarator (get_variable_array_length_cname (f, dim), new CCodeConstant ("0")));
							if (!f.is_private_symbol ()) {
								len_def.modifiers = CCodeModifiers.EXTERN;
								requires_vala_extern = true;
							} else {
								len_def.modifiers = CCodeModifiers.STATIC;
							}
							cfile.add_type_member_declaration (len_def);
						}

						if (array_type.rank == 1 && f.is_internal_symbol ()) {
							var cdecl = new CCodeDeclaration (length_ctype);
							cdecl.add_declarator (new CCodeVariableDeclarator (get_array_size_cname (get_ccode_name (f)), new CCodeConstant ("0")));
							cdecl.modifiers = CCodeModifiers.STATIC;
							cfile.add_type_member_declaration (cdecl);
						}
					}
				} else if (get_ccode_delegate_target (f)) {
					var delegate_type = (DelegateType) f.variable_type;
					if (delegate_type.delegate_symbol.has_target) {
						// create field to store delegate target

						var target_def = new CCodeDeclaration (get_ccode_name (delegate_target_type));
						target_def.add_declarator (new CCodeVariableDeclarator (get_ccode_delegate_target_name (f), new CCodeConstant ("NULL")));
						if (!f.is_private_symbol ()) {
							target_def.modifiers = CCodeModifiers.EXTERN;
							requires_vala_extern = true;
						} else {
							target_def.modifiers = CCodeModifiers.STATIC;
						}
						cfile.add_type_member_declaration (target_def);

						if (delegate_type.is_disposable ()) {
							var target_destroy_notify_def = new CCodeDeclaration (get_ccode_name (delegate_target_destroy_type));
							target_destroy_notify_def.add_declarator (new CCodeVariableDeclarator (get_ccode_delegate_target_destroy_notify_name (f), new CCodeConstant ("NULL")));
							if (!f.is_private_symbol ()) {
								target_destroy_notify_def.modifiers = CCodeModifiers.EXTERN;
								requires_vala_extern = true;
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
							store_field (f, null, f.initializer.target_value, true, f.source_reference);
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

	public static bool is_constant_ccode_expression (CCodeExpression cexpr) {
		if (cexpr is CCodeConstant || cexpr is CCodeConstantIdentifier) {
			return true;
		} else if (cexpr is CCodeInitializerList) {
			return true;
		} else if (cexpr is CCodeCastExpression) {
			var ccast = (CCodeCastExpression) cexpr;
			return is_constant_ccode_expression (ccast.inner);
		} else if (cexpr is CCodeUnaryExpression) {
			var cunary = (CCodeUnaryExpression) cexpr;
			switch (cunary.operator) {
				case CCodeUnaryOperator.PREFIX_INCREMENT:
				case CCodeUnaryOperator.PREFIX_DECREMENT:
				case CCodeUnaryOperator.POSTFIX_INCREMENT:
				case CCodeUnaryOperator.POSTFIX_DECREMENT:
					return false;
				default:
					break;
			}
			return is_constant_ccode_expression (cunary.inner);
		} else if (cexpr is CCodeBinaryExpression) {
			var cbinary = (CCodeBinaryExpression) cexpr;
			return is_constant_ccode_expression (cbinary.left) && is_constant_ccode_expression (cbinary.right);
		}

		var cparenthesized = (cexpr as CCodeParenthesizedExpression);
		return (null != cparenthesized && is_constant_ccode_expression (cparenthesized.inner));
	}

	public static bool is_constant_ccode (CodeNode expr) {
		if (expr is Constant) {
			// Local constants are not considered constant in C
			return !(((Constant) expr).parent_symbol is Block);
		} else if (expr is IntegerLiteral) {
			return ((IntegerLiteral) expr).is_constant ();
		} else if (expr is MemberAccess) {
			return is_constant_ccode (((MemberAccess) expr).symbol_reference);
		} else if (expr is CastExpression) {
			return is_constant_ccode (((CastExpression) expr).inner);
		}

		return false;
	}

	/**
	 * Returns whether the passed cexpr is a pure expression, i.e. an
	 * expression without side-effects.
	 */
	public static bool is_pure_ccode_expression (CCodeExpression cexpr) {
		if (cexpr is CCodeConstant || cexpr is CCodeIdentifier) {
			return true;
		} else if (cexpr is CCodeBinaryExpression) {
			var cbinary = (CCodeBinaryExpression) cexpr;
			return is_pure_ccode_expression (cbinary.left) && is_pure_ccode_expression (cbinary.right);
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
			return is_pure_ccode_expression (cea.container) && is_pure_ccode_expression (cea.indices[0]);
		} else if (cexpr is CCodeCastExpression) {
			var ccast = (CCodeCastExpression) cexpr;
			return is_pure_ccode_expression (ccast.inner);
		} else if (cexpr is CCodeParenthesizedExpression) {
			var cparenthesized = (CCodeParenthesizedExpression) cexpr;
			return is_pure_ccode_expression (cparenthesized.inner);
		}

		return false;
	}

	public override void visit_property (Property prop) {
		visit_member (prop);

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
				var cl = (Class) object_type.type_symbol;
				generate_class_declaration (cl, decl_space);
				if (!cl.is_compact && cl.has_type_parameters ()) {
					generate_struct_declaration ((Struct) gtype_type, decl_space);
				}
			} else if (object_type.type_symbol is Interface) {
				var iface = (Interface) object_type.type_symbol;
				generate_interface_declaration (iface, decl_space);
				if (iface.has_type_parameters ()) {
					generate_struct_declaration ((Struct) gtype_type, decl_space);
				}
			}
		} else if (type is DelegateType) {
			var deleg_type = (DelegateType) type;
			var d = deleg_type.delegate_symbol;
			generate_delegate_declaration (d, decl_space);
			if (d.has_target) {
				generate_type_declaration (delegate_target_type, decl_space);
				if (deleg_type.is_disposable ()) {
					generate_type_declaration (delegate_target_destroy_type, decl_space);
				}
			}
		} else if (type.type_symbol is Enum) {
			var en = (Enum) type.type_symbol;
			generate_enum_declaration (en, decl_space);
		} else if (type is ValueType) {
			var value_type = (ValueType) type;
			generate_struct_declaration ((Struct) value_type.type_symbol, decl_space);
		} else if (type is ArrayType) {
			var array_type = (ArrayType) type;
			generate_type_declaration (array_type.element_type, decl_space);
			if (array_type.length_type != null) {
				generate_type_declaration (array_type.length_type, decl_space);
			}
		} else if (type is ErrorType) {
			var error_type = (ErrorType) type;
			if (error_type.error_domain != null) {
				generate_error_domain_declaration (error_type.error_domain, decl_space);
			} else {
				generate_class_declaration (gerror, decl_space);
			}
		} else if (type is PointerType) {
			var pointer_type = (PointerType) type;
			generate_type_declaration (pointer_type.base_type, decl_space);
		} else if (type is MethodType) {
			var method = ((MethodType) type).method_symbol;
			if (method.has_type_parameters () && !get_ccode_simple_generics (method)) {
				generate_struct_declaration ((Struct) gtype_type, decl_space);
			}
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
			cvalueparam = new CCodeParameter ("result", "%s *".printf (get_ccode_name (acc.value_type)));
		} else if (!acc.readable && prop.property_type.is_real_non_null_struct_type ()) {
			cvalueparam = new CCodeParameter ("value", "%s *".printf (get_ccode_name (acc.value_type)));
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
			var this_type = SemanticAnalyzer.get_data_type_for_symbol (t);
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

		if (acc.value_type is ArrayType && get_ccode_array_length (prop)) {
			var array_type = (ArrayType) acc.value_type;
			var length_ctype = get_ccode_array_length_type (prop);
			for (int dim = 1; dim <= array_type.rank; dim++) {
				function.add_parameter (new CCodeParameter (get_array_length_cname (acc.readable ? "result" : "value", dim), acc.readable ? length_ctype + "*" : length_ctype));
			}
		} else if ((acc.value_type is DelegateType) && get_ccode_delegate_target (prop) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
			function.add_parameter (new CCodeParameter (get_delegate_target_cname (acc.readable ? "result" : "value"), acc.readable ? get_ccode_name (delegate_target_type) + "*" : get_ccode_name (delegate_target_type)));
			if (!acc.readable && acc.value_type.value_owned) {
				function.add_parameter (new CCodeParameter (get_delegate_target_destroy_notify_cname ("value"), get_ccode_name (delegate_target_destroy_type)));
			}
		}

		if (prop.version.deprecated) {
			if (context.profile == Profile.GOBJECT) {
				decl_space.add_include ("glib.h");
			}
			function.modifiers |= CCodeModifiers.DEPRECATED;
		}

		if (!prop.is_abstract
		    && (prop.is_private_symbol () || (!acc.readable && !acc.writable) || acc.access == SymbolAccessibility.PRIVATE)) {
			function.modifiers |= CCodeModifiers.STATIC;
		} else if (context.hide_internal && (prop.is_internal_symbol () || acc.access == SymbolAccessibility.INTERNAL)) {
			function.modifiers |= CCodeModifiers.INTERNAL;
		} else {
			function.modifiers |= CCodeModifiers.EXTERN;
			requires_vala_extern = true;
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
			pop_context ();
			return;
		}

		var this_type = SemanticAnalyzer.get_data_type_for_symbol (t);
		var cselfparam = new CCodeParameter ("self", get_ccode_name (this_type));
		if (t is Struct && !((Struct) t).is_simple_type ()) {
			cselfparam.type_name += "*";
		}
		CCodeParameter cvalueparam;
		if (returns_real_struct) {
			cvalueparam = new CCodeParameter ("result", "%s *".printf (get_ccode_name (acc.value_type)));
		} else if (!acc.readable && prop.property_type.is_real_non_null_struct_type ()) {
			cvalueparam = new CCodeParameter ("value", "%s *".printf (get_ccode_name (acc.value_type)));
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

			if (acc.value_type is ArrayType && get_ccode_array_length (prop)) {
				var array_type = (ArrayType) acc.value_type;
				var length_ctype = get_ccode_array_length_type (prop);
				for (int dim = 1; dim <= array_type.rank; dim++) {
					function.add_parameter (new CCodeParameter (get_array_length_cname (acc.readable ? "result" : "value", dim), acc.readable ? length_ctype + "*": length_ctype));
				}
			} else if ((acc.value_type is DelegateType) && get_ccode_delegate_target (prop) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
				function.add_parameter (new CCodeParameter (get_delegate_target_cname (acc.readable ? "result" : "value"), acc.readable ? get_ccode_name (delegate_target_type) + "*" : get_ccode_name (delegate_target_type)));
				if (!acc.readable && acc.value_type.value_owned) {
					function.add_parameter (new CCodeParameter (get_delegate_target_destroy_notify_cname ("value"), get_ccode_name (delegate_target_destroy_type)));
				}
			}

			if (!prop.is_abstract
			    && (prop.is_private_symbol () || !(acc.readable || acc.writable) || acc.access == SymbolAccessibility.PRIVATE)) {
				// accessor function should be private if the property is an internal symbol or it's a construct-only setter
				function.modifiers |= CCodeModifiers.STATIC;
			} else if (context.hide_internal && (prop.is_internal_symbol () || acc.access == SymbolAccessibility.INTERNAL)) {
				function.modifiers |= CCodeModifiers.INTERNAL;
			}

			push_function (function);

			if (acc.value_type.is_non_null_simple_type () && default_value_for_type (acc.value_type, false) == null) {
				var vardecl = new CCodeVariableDeclarator ("result", default_value_for_type (acc.value_type, true));
				vardecl.init0 = true;
				ccode.add_declaration (get_ccode_name (acc.value_type), vardecl);
			}

			if (prop.binding == MemberBinding.INSTANCE) {
				if (!acc.readable || returns_real_struct) {
					create_property_type_check_statement (prop, false, t, true, "self");
				} else {
					create_property_type_check_statement (prop, true, t, true, "self");
				}
			}

			CCodeExpression vcast;
			if (prop.parent_symbol is Interface) {
				var iface = (Interface) prop.parent_symbol;

				vcast = new CCodeIdentifier ("_iface_");
				var vcastcall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_get_function (iface)));
				((CCodeFunctionCall) vcastcall).add_argument (new CCodeIdentifier ("self"));
				ccode.add_declaration ("%s*".printf (get_ccode_type_name (iface)), new CCodeVariableDeclarator ("_iface_"));
				ccode.add_assignment (vcast, vcastcall);
			} else {
				var cl = (Class) prop.parent_symbol;
				if (!cl.is_compact) {
					vcast = new CCodeIdentifier ("_klass_");
					var vcastcall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_get_function (cl)));
					((CCodeFunctionCall) vcastcall).add_argument (new CCodeIdentifier ("self"));
					ccode.add_declaration ("%s*".printf (get_ccode_type_name (cl)), new CCodeVariableDeclarator ("_klass_"));
					ccode.add_assignment (vcast, vcastcall);
				} else {
					vcast = new CCodeIdentifier ("self");
				}
			}

			if (acc.readable) {
				var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "get_%s".printf (prop.name)));
				vcall.add_argument (new CCodeIdentifier ("self"));

				// check if vfunc pointer is properly set
				ccode.open_if (vcall.call);

				if (returns_real_struct) {
					vcall.add_argument (new CCodeIdentifier ("result"));
					ccode.add_expression (vcall);
				} else {
					if (acc.value_type is ArrayType && get_ccode_array_length (prop)) {
						var array_type = (ArrayType) acc.value_type;

						for (int dim = 1; dim <= array_type.rank; dim++) {
							var len_expr = new CCodeIdentifier (get_array_length_cname ("result", dim));
							vcall.add_argument (len_expr);
						}
					} else if ((acc.value_type is DelegateType) && get_ccode_delegate_target (prop) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
						vcall.add_argument (new CCodeIdentifier (get_delegate_target_cname ("result")));
					}

					ccode.add_return (vcall);
				}
				ccode.close ();

				if (acc.value_type.is_non_null_simple_type () && default_value_for_type (acc.value_type, false) == null) {
					ccode.add_return (new CCodeIdentifier ("result"));
				} else if (!(acc.value_type is VoidType)) {
					ccode.add_return (default_value_for_type (acc.value_type, false, true));
				}
			} else {
				var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "set_%s".printf (prop.name)));
				vcall.add_argument (new CCodeIdentifier ("self"));
				vcall.add_argument (new CCodeIdentifier ("value"));

				// check if vfunc pointer is properly set
				ccode.open_if (vcall.call);

				if (acc.value_type is ArrayType && get_ccode_array_length (prop)) {
					var array_type = (ArrayType) acc.value_type;

					for (int dim = 1; dim <= array_type.rank; dim++) {
						var len_expr = new CCodeIdentifier (get_array_length_cname ("value", dim));
						vcall.add_argument (len_expr);
					}
				} else if ((acc.value_type is DelegateType) && get_ccode_delegate_target (prop) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
					vcall.add_argument (new CCodeIdentifier (get_delegate_target_cname ("value")));
					if (!acc.readable && acc.value_type.value_owned) {
						vcall.add_argument (new CCodeIdentifier (get_delegate_target_destroy_notify_cname ("value")));
					}
				}

				ccode.add_expression (vcall);
				ccode.close ();
			}

			pop_function ();

			cfile.add_function (function);
		}

		if (!prop.is_abstract && acc.body != null) {
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

			if (acc.value_type is ArrayType && get_ccode_array_length (prop)) {
				var array_type = (ArrayType) acc.value_type;
				var length_ctype = get_ccode_array_length_type (prop);
				for (int dim = 1; dim <= array_type.rank; dim++) {
					function.add_parameter (new CCodeParameter (get_array_length_cname (acc.readable ? "result" : "value", dim), acc.readable ? length_ctype + "*" : length_ctype));
				}
			} else if ((acc.value_type is DelegateType) && get_ccode_delegate_target (prop) && ((DelegateType) acc.value_type).delegate_symbol.has_target) {
				function.add_parameter (new CCodeParameter (get_delegate_target_cname (acc.readable ? "result" : "value"), acc.readable ? get_ccode_name (delegate_target_type) + "*" : get_ccode_name (delegate_target_type)));
				if (!acc.readable && acc.value_type.value_owned) {
					function.add_parameter (new CCodeParameter (get_delegate_target_destroy_notify_cname ("value"), get_ccode_name (delegate_target_destroy_type)));
				}
			}

			if (!is_virtual) {
				if (prop.is_private_symbol () || !(acc.readable || acc.writable) || acc.access == SymbolAccessibility.PRIVATE) {
					// accessor function should be private if the property is an internal symbol or it's a construct-only setter
					function.modifiers |= CCodeModifiers.STATIC;
				} else if (context.hide_internal && (prop.is_internal_symbol () || acc.access == SymbolAccessibility.INTERNAL)) {
					function.modifiers |= CCodeModifiers.INTERNAL;
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

			// notify on property changes
			if (context.analyzer.is_gobject_property (prop) &&
			    prop.notify &&
			    (acc.writable || acc.construction)) {
				var notify_call = new CCodeFunctionCall (new CCodeIdentifier ("g_object_notify_by_pspec"));
				notify_call.add_argument (new CCodeCastExpression (new CCodeIdentifier ("self"), "GObject *"));
				notify_call.add_argument (get_param_spec_cexpression (prop));

				var get_accessor = prop.get_accessor;
				if (get_accessor != null && get_accessor.automatic_body) {
					var property_type = prop.property_type;
					var get_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_real_name (get_accessor)));
					get_call.add_argument (new CCodeIdentifier (is_virtual ? "base" : "self"));

					if (property_type is ArrayType && get_ccode_array_length (prop)) {
						ccode.add_declaration (get_ccode_name (property_type), new CCodeVariableDeclarator ("old_value"));
						ccode.add_declaration (get_ccode_array_length_type (prop), new CCodeVariableDeclarator ("old_value_length"));
						get_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("old_value_length")));
						ccode.add_assignment (new CCodeIdentifier ("old_value"), get_call);
						ccode.open_if (new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("old_value"), new CCodeIdentifier ("value")));
					} else if (property_type.compatible (string_type)) {
						ccode.add_declaration (get_ccode_name (property_type), new CCodeVariableDeclarator ("old_value"));
						ccode.add_assignment (new CCodeIdentifier ("old_value"), get_call);
						CCodeFunctionCall ccall;
						if (context.profile == Profile.POSIX) {
							cfile.add_include ("string.h");
							ccall = new CCodeFunctionCall (new CCodeIdentifier (generate_cmp_wrapper (new CCodeIdentifier ("strcmp"))));
						} else {
							ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_strcmp0"));
						}
						ccall.add_argument (new CCodeIdentifier ("value"));
						ccall.add_argument (new CCodeIdentifier ("old_value"));
						ccode.open_if (new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, ccall, new CCodeConstant ("0")));
					} else if (property_type is StructValueType) {
						ccode.add_declaration (get_ccode_name (property_type), new CCodeVariableDeclarator ("old_value"));
						if (property_type.nullable) {
							ccode.add_assignment (new CCodeIdentifier ("old_value"), get_call);
						} else {
							get_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("old_value")));
							ccode.add_expression (get_call);
						}
						var equalfunc = generate_struct_equal_function ((Struct) property_type.type_symbol);
						var ccall = new CCodeFunctionCall (new CCodeIdentifier (equalfunc));
						ccall.add_argument (new CCodeIdentifier ("value"));
						if (property_type.nullable) {
							ccall.add_argument (new CCodeIdentifier ("old_value"));
						} else {
							ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("old_value")));
						}
						ccode.open_if (new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, ccall, new CCodeConstant ("TRUE")));
					} else {
						ccode.add_declaration (get_ccode_name (property_type), new CCodeVariableDeclarator ("old_value"));
						ccode.add_assignment (new CCodeIdentifier ("old_value"), get_call);
						ccode.open_if (new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("old_value"), new CCodeIdentifier ("value")));
					}

					acc.body.emit (this);
					ccode.add_expression (notify_call);
					ccode.close ();

					if (prop.get_accessor.value_type.is_disposable ()) {
						var old_value = new GLibValue (prop.get_accessor.value_type, new CCodeIdentifier ("old_value"), true);
						if (property_type is ArrayType && get_ccode_array_length (prop)) {
							old_value.append_array_length_cvalue (new CCodeIdentifier ("old_value_length"));
						}
						ccode.add_expression (destroy_value (old_value));
					}
				} else {
					acc.body.emit (this);
					ccode.add_expression (notify_call);
				}
			} else {
				acc.body.emit (this);
			}

			if (current_method_inner_error) {
				ccode.add_declaration ("GError*", new CCodeVariableDeclarator.zero ("_inner_error%d_".printf (current_inner_error_id), new CCodeConstant ("NULL")));
			}

			pop_function ();

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
		unowned Class? cl = type.type_symbol as Class;
		return (type is DelegateType ||
				type is ArrayType ||
				(cl != null && !cl.is_immutable && !is_reference_counting (cl) && !get_ccode_is_gboxed (cl)));
	}

	void capture_parameter (Parameter param, CCodeStruct data, int block_id) {
		generate_type_declaration (param.variable_type, cfile);

		var param_type = param.variable_type.copy ();
		if (!param.variable_type.value_owned) {
			param_type.value_owned = !no_implicit_copy (param.variable_type);
		}
		data.add_field (get_ccode_name (param_type), get_ccode_name (param), 0, get_ccode_declarator_suffix (param_type));

		// create copy if necessary as captured variables may need to be kept alive
		param.captured = false;
		var value = load_parameter (param);

		var array_type = param.variable_type as ArrayType;
		var deleg_type = param.variable_type as DelegateType;

		if (array_type != null && get_ccode_array_length (param) && !((ArrayType) array_type).fixed_length) {
			var length_ctype = get_ccode_array_length_type (param);
			for (int dim = 1; dim <= array_type.rank; dim++) {
				data.add_field (length_ctype, get_variable_array_length_cname (param, dim));
			}
		} else if (deleg_type != null && deleg_type.delegate_symbol.has_target) {
			data.add_field (get_ccode_name (delegate_target_type), get_ccode_delegate_target_name (param));
			if (param.variable_type.is_disposable ()) {
				data.add_field (get_ccode_name (delegate_target_destroy_type), get_ccode_delegate_target_destroy_notify_name (param));
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

		if (b.parent_node is TryStatement && b == ((TryStatement) b.parent_node).finally_body) {
			// finally-block with nested error handling
			if (((TryStatement) b.parent_node).body.tree_can_fail) {
				if (is_in_coroutine ()) {
					// _inner_error0_ gets added to closure_struct in CCodeMethodModule.visit_method()
					if (current_inner_error_id > 0
					    && (!method_inner_error_var_count.contains (current_method)
					    || method_inner_error_var_count.get (current_method) < current_inner_error_id)) {
						// no initialization necessary, closure struct is zeroed
						closure_struct.add_field ("GError*", "_inner_error%d_".printf (current_inner_error_id));
						method_inner_error_var_count.set (current_method, current_inner_error_id);
					}
				} else {
					ccode.add_declaration ("GError*", new CCodeVariableDeclarator.zero ("_inner_error%d_".printf (current_inner_error_id), new CCodeConstant ("NULL")));
				}
			}
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
				unowned DataType? this_type = get_this_type ();
				if (this_type != null) {
					data.add_field (get_ccode_name (this_type), "self");
				}

				if (current_method != null) {
					// allow capturing generic type parameters
					foreach (var type_param in current_method.get_type_parameters ()) {
						data.add_field ("GType", get_ccode_type_id (type_param));
						data.add_field ("GBoxedCopyFunc", get_ccode_copy_function (type_param));
						data.add_field ("GDestroyNotify", get_ccode_destroy_function (type_param));
					}
				}
			}
			foreach (var local in local_vars) {
				if (local.captured) {
					generate_type_declaration (local.variable_type, cfile);

					data.add_field (get_ccode_name (local.variable_type), get_local_cname (local), 0, get_ccode_declarator_suffix (local.variable_type));

					if (local.variable_type is ArrayType && !((ArrayType) local.variable_type).fixed_length) {
						var array_type = (ArrayType) local.variable_type;
						var length_ctype = get_ccode_array_length_type (array_type);
						for (int dim = 1; dim <= array_type.rank; dim++) {
							data.add_field (length_ctype, get_array_length_cname (get_local_cname (local), dim));
						}
						data.add_field (length_ctype, get_array_size_cname (get_local_cname (local)));
					} else if (local.variable_type is DelegateType && ((DelegateType) local.variable_type).delegate_symbol.has_target) {
						data.add_field (get_ccode_name (delegate_target_type), get_delegate_target_cname (get_local_cname (local)));
						if (local.variable_type.is_disposable ()) {
							data.add_field (get_ccode_name (delegate_target_destroy_type), get_delegate_target_destroy_notify_cname (get_local_cname (local)));
						}
					} else if (local.variable_type.type_symbol == context.analyzer.va_list_type.type_symbol) {
						Report.error (local.source_reference, "internal: Capturing `va_list' variable `%s' is not allowed", local.get_full_name ());
						b.error = true;
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

				unowned DataType? this_type = get_this_type ();
				if (this_type != null && (!in_creation_method_with_chainup || current_method.body != b)) {
					CCodeExpression instance;
					if (is_in_destructor ()) {
						// never increase reference count for self in finalizers to avoid infinite recursion on following unref
						instance = new CCodeIdentifier ("self");
					} else {
						var ref_call = new CCodeFunctionCall (get_dup_func_expression (this_type, b.source_reference));
						ref_call.add_argument (get_this_cexpression ());
						instance = ref_call;
					}

					ccode.add_assignment (new CCodeMemberAccess.pointer (get_variable_cexpression ("_data%d_".printf (block_id)), "self"), instance);
				}

				if (current_method != null) {
					// allow capturing generic type parameters
					var data_var = get_variable_cexpression ("_data%d_".printf (block_id));
					foreach (var type_param in current_method.get_type_parameters ()) {
						var type = get_ccode_type_id (type_param);
						var dup_func = get_ccode_copy_function (type_param);
						var destroy_func = get_ccode_destroy_function (type_param);
						ccode.add_assignment (new CCodeMemberAccess.pointer (data_var, type), get_variable_cexpression (type));
						ccode.add_assignment (new CCodeMemberAccess.pointer (data_var, dup_func), get_variable_cexpression (dup_func));
						ccode.add_assignment (new CCodeMemberAccess.pointer (data_var, destroy_func), get_variable_cexpression (destroy_func));
					}
				}
			}

			if (b.parent_symbol is Method) {
				var m = (Method) b.parent_symbol;

				// parameters are captured with the top-level block of the method
				foreach (var param in m.get_parameters ()) {
					if (param.captured) {
						capture_parameter (param, data, block_id);

						if (param.variable_type.type_symbol == context.analyzer.va_list_type.type_symbol) {
							Report.error (param.source_reference, "internal: Capturing `va_list' parameter `%s' is not allowed", param.get_full_name ());
							b.error = true;
						}
					}
				}

				if (m.coroutine) {
					// capture async data to allow invoking callback from inside closure
					data.add_field (get_ccode_name (pointer_type), "_async_data_");

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

			var this_type = get_this_type ();
			if (this_type != null) {
				// assign "self" for type parameters
				ccode.add_declaration(get_ccode_name (this_type), new CCodeVariableDeclarator ("self"));
				ccode.add_assignment (new CCodeIdentifier ("self"), new CCodeMemberAccess.pointer (outer_block, "self"));
			}

			if (current_method != null) {
				// assign captured generic type parameters
				foreach (var type_param in current_method.get_type_parameters ()) {
					var type = get_ccode_type_id (type_param);
					var dup_func = get_ccode_copy_function (type_param);
					var destroy_func = get_ccode_destroy_function (type_param);
					ccode.add_declaration ("GType", new CCodeVariableDeclarator (type));
					ccode.add_declaration ("GBoxedCopyFunc", new CCodeVariableDeclarator (dup_func));
					ccode.add_declaration ("GDestroyNotify", new CCodeVariableDeclarator (destroy_func));
					ccode.add_assignment (new CCodeIdentifier (type), new CCodeMemberAccess.pointer (outer_block, type));
					ccode.add_assignment (new CCodeIdentifier (dup_func), new CCodeMemberAccess.pointer (outer_block, dup_func));
					ccode.add_assignment (new CCodeIdentifier (destroy_func), new CCodeMemberAccess.pointer (outer_block, destroy_func));
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
				this_type = get_this_type ();
				if (this_type != null) {
					this_type = this_type.copy ();
					this_type.value_owned = true;
					if (this_type.is_disposable () && !is_in_destructor ()) {
						// reference count for self is not increased in finalizers
						var this_value = new GLibValue (this_type, new CCodeIdentifier ("self"), true);
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

		if (!b.unreachable_exit) {
			if (b.parent_symbol is Method) {
				unowned Method m = (Method) b.parent_symbol;
				// check postconditions
				foreach (var postcondition in m.get_postconditions ()) {
					create_postcondition_statement (postcondition);
				}
			}

			// free in reverse order
			for (int i = local_vars.size - 1; i >= 0; i--) {
				var local = local_vars[i];
				local.active = false;
				if (!local.unreachable && !local.captured && requires_destroy (local.variable_type)) {
					ccode.add_expression (destroy_local (local));
				}
			}

			if (b.parent_symbol is Method) {
				var m = (Method) b.parent_symbol;
				foreach (Parameter param in m.get_parameters ()) {
					if (!param.captured && !param.ellipsis && !param.params_array && requires_destroy (param.variable_type) && param.direction == ParameterDirection.IN) {
						ccode.add_expression (destroy_parameter (param));
					} else if (param.direction == ParameterDirection.OUT && !m.coroutine) {
						return_out_parameter (param);
					}
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
		}

		if (b.parent_node is Block || b.parent_node is SwitchStatement || b.parent_node is TryStatement) {
			ccode.close ();
		}

		emit_context.pop_symbol ();
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		stmt.declaration.accept (this);
	}

	public CCodeExpression get_cexpression (string name) {
		if (is_in_coroutine ()) {
			return new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), name);
		} else {
			return new CCodeIdentifier (name);
		}
	}

	public CCodeExpression get_local_cexpression (LocalVariable local) {
		return get_cexpression (get_local_cname (local));
	}

	public CCodeExpression get_parameter_cexpression (Parameter param) {
		return get_cexpression (get_ccode_name (param));
	}

	public CCodeExpression get_variable_cexpression (string name) {
		return get_cexpression (get_variable_cname (name));
	}

	public CCodeExpression get_this_cexpression () {
		return get_cexpression ("self");
	}

	public CCodeExpression get_this_class_cexpression (Class cl, TargetValue? instance = null) {
		CCodeExpression cast;
		CCodeFunctionCall call;
		if (instance != null) {
			// Accessing the member of an instance
			if (cl.external_package) {
				call = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_INSTANCE_GET_CLASS"));
				call.add_argument (get_cvalue_ (instance));
				call.add_argument (new CCodeIdentifier (get_ccode_type_id (cl)));
				call.add_argument (new CCodeIdentifier (get_ccode_type_name (cl)));
			} else {
				call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_get_function (cl)));
				call.add_argument (get_cvalue_ (instance));
			}
			cast = call;
		} else if (get_this_type () != null) {
			// Accessing the member from within an instance method
			if (cl.external_package) {
				call = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_INSTANCE_GET_CLASS"));
				call.add_argument (get_this_cexpression ());
				call.add_argument (new CCodeIdentifier (get_ccode_type_id (cl)));
				call.add_argument (new CCodeIdentifier (get_ccode_type_name (cl)));
			} else {
				call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_get_function (cl)));
				call.add_argument (get_this_cexpression ());
			}
			cast = call;
		} else {
			// Accessing the member from a static or class constructor
			if (current_class == cl) {
				cast = new CCodeIdentifier ("klass");
			} else {
				call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_type_function (cl)));
				call.add_argument (new CCodeIdentifier ("klass"));
				cast = call;
			}
		}
		return cast;
	}

	public CCodeExpression get_this_interface_cexpression (Interface iface, TargetValue? instance = null) {
		unowned Class? cl = current_class;
		if (instance == null && cl != null && cl.implements (iface)) {
			return new CCodeIdentifier ("%s_%s_parent_iface".printf (get_ccode_lower_case_name (cl), get_ccode_lower_case_name (iface)));
		}

		CCodeExpression cast;
		CCodeFunctionCall call;
		if (instance != null) {
			if (iface.external_package) {
				call = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_INSTANCE_GET_INTERFACE"));
				call.add_argument (get_cvalue_ (instance));
				call.add_argument (new CCodeIdentifier (get_ccode_type_id (iface)));
				call.add_argument (new CCodeIdentifier (get_ccode_type_name (iface)));
			} else {
				call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_get_function (iface)));
				call.add_argument (get_cvalue_ (instance));
			}
			cast = call;
		} else if (get_this_type () != null) {
			if (iface.external_package) {
				call = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_INSTANCE_GET_INTERFACE"));
				call.add_argument (get_this_cexpression ());
				call.add_argument (new CCodeIdentifier (get_ccode_type_id (iface)));
				call.add_argument (new CCodeIdentifier (get_ccode_type_name (iface)));
			} else {
				call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_get_function (iface)));
				call.add_argument (get_this_cexpression ());
			}
			cast = call;
		} else {
			Report.error (null, "internal: missing instance");
			cast = null;
			assert_not_reached ();
		}
		return cast;
	}

	public CCodeExpression get_inner_error_cexpression () {
		return get_cexpression ("_inner_error%d_".printf (current_inner_error_id));
	}

	public string get_local_cname (LocalVariable local) {
		var cname = get_variable_cname (local.name);
		if (cname[0].isdigit ()) {
			cname = "_%s_".printf (cname);
		}
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
		} else if (reserved_identifiers.contains (name) || reserved_vala_identifiers.contains (name)) {
			return "_%s_".printf (name);
		} else {
			return name;
		}
	}

	public bool is_simple_struct_creation (Variable variable, Expression expr) {
		unowned Struct? st = variable.variable_type.type_symbol as Struct;
		var creation = expr as ObjectCreationExpression;
		if (creation != null && st != null && (!st.is_simple_type () || get_ccode_name (st) == "va_list") && !variable.variable_type.nullable &&
		    variable.variable_type.type_symbol != gvalue_type && creation.get_object_initializer ().size == 0) {
			return true;
		} else {
			return false;
		}
	}

	static bool is_foreach_element_variable (LocalVariable local) {
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

				closure_struct.add_field (get_ccode_name (local.variable_type), get_local_cname (local), 0, get_ccode_declarator_suffix (local.variable_type));
			} else {
				var cvar = new CCodeVariableDeclarator (get_local_cname (local), null, get_ccode_declarator_suffix (local.variable_type));

				// try to initialize uninitialized variables
				// initialization not necessary for variables stored in closure
				CCodeExpression? size = null;
				if (!requires_memset_init (local, out size)) {
					cvar.initializer = default_value_for_type (local.variable_type, true);
					cvar.init0 = true;
				} else if (size != null && local.initializer == null) {
					cfile.add_include ("string.h");
					var memset_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
					memset_call.add_argument (get_variable_cexpression (local.name));
					memset_call.add_argument (new CCodeConstant ("0"));
					memset_call.add_argument (size);
					ccode.add_expression (memset_call);
				}

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
						var len_var = new LocalVariable (array_type.length_type.copy (), get_array_length_cname (get_local_cname (local), dim));
						len_var.init = local.initializer == null;
						emit_temp_var (len_var);
					}

					if (array_type.rank == 1) {
						var size_var = new LocalVariable (array_type.length_type.copy (), get_array_size_cname (get_local_cname (local)));
						size_var.init = local.initializer == null;
						emit_temp_var (size_var);
					}
				}
			} else if (local.variable_type is DelegateType) {
				var deleg_type = (DelegateType) local.variable_type;
				if (deleg_type.delegate_symbol.has_target) {
					// create variable to store delegate target
					var target_var = new LocalVariable (delegate_target_type.copy (), get_delegate_target_cname (get_local_cname (local)));
					target_var.init = local.initializer == null;
					emit_temp_var (target_var);
					if (deleg_type.is_disposable ()) {
						var target_destroy_notify_var = new LocalVariable (delegate_target_destroy_type.copy (), get_delegate_target_destroy_notify_cname (get_local_cname (local)));
						target_destroy_notify_var.init = local.initializer == null;
						emit_temp_var (target_destroy_notify_var);
					}
				}
			}
		}

		/* Store the initializer */

		if (rhs != null) {
			if (!is_simple_struct_creation (local, local.initializer)) {
				store_local (local, local.initializer.target_value, true, local.source_reference);
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
		if (type is VoidType) {
			Report.error (node_reference.source_reference, "internal: 'void' not supported as variable type");
		}

		var local = new LocalVariable (type.copy (), "_tmp%d_".printf (next_temp_var_id++), null, node_reference.source_reference);
		local.init = init;
		if (value_owned != null) {
			local.variable_type.value_owned = value_owned;
		}

		var array_type = local.variable_type as ArrayType;
		var deleg_type = local.variable_type as DelegateType;

		emit_temp_var (local);
		if (array_type != null) {
			for (int dim = 1; dim <= array_type.rank; dim++) {
				var len_var = new LocalVariable (array_type.length_type.copy (), get_array_length_cname (local.name, dim), null, node_reference.source_reference);
				len_var.init = init;
				emit_temp_var (len_var);
			}
		} else if (deleg_type != null && deleg_type.delegate_symbol.has_target) {
			var target_var = new LocalVariable (delegate_target_type.copy (), get_delegate_target_cname (local.name), null, node_reference.source_reference);
			target_var.init = init;
			emit_temp_var (target_var);
			if (deleg_type.is_disposable ()) {
				var target_destroy_notify_var = new LocalVariable (delegate_target_destroy_type.copy (), get_delegate_target_destroy_notify_cname (local.name), null, node_reference.source_reference);
				target_destroy_notify_var.init = init;
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
		store_value (lvalue, initializer, node_reference.source_reference);
		return load_temp_value (lvalue);
	}

	bool is_static_field_initializer (CodeNode node) {
		if (node is InitializerList) {
			return is_static_field_initializer (node.parent_node);
		}
		return node is Constant || (node is Field && ((Field) node).binding == MemberBinding.STATIC);
	}

	public override void visit_initializer_list (InitializerList list) {
		if (list.target_type.type_symbol is Struct) {
			/* initializer is used as struct initializer */
			unowned Struct st = (Struct) list.target_type.type_symbol;
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
					if (array_type != null && !array_type.fixed_length && get_ccode_array_length (field) && !get_ccode_array_null_terminated (field)) {
						for (int dim = 1; dim <= array_type.rank; dim++) {
							clist.append (get_array_length_cvalue (expr.target_value, dim));
						}
						if (array_type.rank == 1 && field.is_internal_symbol ()) {
							clist.append (get_array_length_cvalue (expr.target_value, 1));
						}
					}
				}

				if (list.size <= 0) {
					clist.append (new CCodeConstant ("0"));
				}

				if (is_static_field_initializer (list.parent_node)
				    || (list.parent_node is Expression && ((Expression) list.parent_node).value_type is ArrayType)) {
					set_cvalue (list, clist);
				} else {
					set_cvalue (list, new CCodeCastExpression (clist, get_ccode_name (list.target_type.type_symbol)));
				}
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

					store_field (field, instance, expr.target_value, false, expr.source_reference);
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

	public LocalVariable get_temp_variable (DataType type, bool value_owned = true, CodeNode? node_reference = null, bool init = false) {
		var var_type = type.copy ();
		var_type.value_owned = value_owned;
		var local = new LocalVariable (var_type, "_tmp%d_".printf (next_temp_var_id));
		local.init = init;

		if (node_reference != null) {
			local.source_reference = node_reference.source_reference;
		}

		next_temp_var_id++;

		return local;
	}

	bool is_in_generic_type (GenericType type) {
		if (current_symbol != null && type.type_parameter.parent_symbol is TypeSymbol
		    && (current_method == null || current_method.binding == MemberBinding.INSTANCE)) {
			return true;
		} else {
			return false;
		}
	}

	void require_generic_accessors (Interface iface) {
		if (!iface.has_attribute ("GenericAccessors")) {
			Report.error (iface.source_reference,
			              "missing generic type for interface `%s', add GenericAccessors attribute to interface declaration",
			              iface.get_full_name ());
		}
	}

	CCodeExpression get_generic_type_expression (string identifier, GenericType type, bool is_chainup = false) {
		if (type.type_parameter.parent_symbol is Interface) {
			unowned Interface iface = (Interface) type.type_parameter.parent_symbol;
			require_generic_accessors (iface);

			var cast_self = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_get_function (iface)));
			cast_self.add_argument (get_this_cexpression ());
			var function_call = new CCodeFunctionCall (new CCodeMemberAccess.pointer (cast_self, "get_%s".printf (identifier)));
			function_call.add_argument (get_this_cexpression ());
			return function_call;
		}

		if (is_in_generic_type (type) && !is_chainup && !in_creation_method) {
			return new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (get_this_cexpression (), "priv"), identifier);
		} else {
			return get_variable_cexpression (identifier);
		}
	}

	public CCodeExpression get_type_id_expression (DataType type, bool is_chainup = false) {
		if (type is GenericType) {
			var type_parameter = ((GenericType) type).type_parameter;
			unowned Symbol? parent = type_parameter.owner.owner;
			if (parent is Class && ((Class) parent).is_compact) {
				Report.error (type.source_reference, "static type-parameter `%s' can not be used in runtime context", type.type_symbol.get_full_name ());
				return new CCodeInvalidExpression();
			}
			string identifier = get_ccode_type_id (type_parameter);
			return get_generic_type_expression (identifier, (GenericType) type, is_chainup);
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
		} else if (type is GenericType) {
			var type_parameter = ((GenericType) type).type_parameter;
			string identifier = get_ccode_copy_function (type_parameter);
			return get_generic_type_expression (identifier, (GenericType) type, is_chainup);
		} else if (type.type_symbol != null) {
			string dup_function;
			unowned Class? cl = type.type_symbol as Class;
			if (is_reference_counting (type.type_symbol)) {
				if (is_ref_function_void (type)) {
					dup_function = generate_ref_wrapper ((ObjectType) type);
				} else {
					dup_function = get_ccode_ref_function ((ObjectTypeSymbol) type.type_symbol);
				}
				if (type.type_symbol is Interface && dup_function == null) {
					Report.error (source_reference, "missing class prerequisite for interface `%s', add GLib.Object to interface declaration if unsure", type.type_symbol.get_full_name ());
					return new CCodeInvalidExpression();
				}
			} else if (cl != null && cl.is_immutable) {
				// allow duplicates of immutable instances as for example strings
				dup_function = get_ccode_dup_function (type.type_symbol);
				if (dup_function == null) {
					dup_function = "";
				}
			} else if (get_ccode_is_gboxed (type.type_symbol)) {
				// allow duplicates of gboxed instances
				dup_function = generate_dup_func_wrapper (type);
				if (dup_function == null) {
					dup_function = "";
				}
			} else if (type is ValueType) {
				dup_function = get_ccode_dup_function (type.type_symbol);
				if (dup_function == null && type.nullable) {
					dup_function = generate_struct_dup_wrapper ((ValueType) type);
				} else if (dup_function == null) {
					dup_function = "";
				}
			} else {
				// duplicating non-reference counted objects may cause side-effects (and performance issues)
				Report.error (source_reference, "duplicating `%s' instance, use unowned variable or explicitly invoke copy method", type.type_symbol.name);
				return new CCodeInvalidExpression();
			}

			return new CCodeIdentifier (dup_function);
		} else if (type is PointerType) {
			var pointer_type = (PointerType) type;
			return get_dup_func_expression (pointer_type.base_type, source_reference);
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	void make_comparable_cexpression (ref DataType left_type, ref CCodeExpression cleft, ref DataType right_type, ref CCodeExpression cright) {
		unowned Struct? left_type_as_struct = left_type.type_symbol as Struct;
		unowned Struct? right_type_as_struct = right_type.type_symbol as Struct;
		unowned ObjectTypeSymbol? left_type_as_object_type = left_type.type_symbol as ObjectTypeSymbol;
		unowned ObjectTypeSymbol? right_type_as_object_type = right_type.type_symbol as ObjectTypeSymbol;

		if (left_type_as_object_type != null && (!(left_type_as_object_type is Class) || !((Class) left_type_as_object_type).is_compact)
		    && right_type_as_object_type != null && (!(right_type_as_object_type is Class) || !((Class) right_type_as_object_type).is_compact)) {
			if (left_type_as_object_type != right_type_as_object_type) {
				if (left_type_as_object_type.is_subtype_of (right_type_as_object_type)) {
					cleft = generate_instance_cast (cleft, right_type_as_object_type);
				} else if (right_type_as_object_type.is_subtype_of (left_type_as_object_type)) {
					cright = generate_instance_cast (cright, left_type_as_object_type);
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
		if (st.base_struct != null) {
			return generate_struct_equal_function (st.base_struct);
		}

		string equal_func = "_%sequal".printf (get_ccode_lower_case_prefix (st));

		if (!add_wrapper (equal_func)) {
			// wrapper already defined
			return equal_func;
		}

		var function = new CCodeFunction (equal_func, get_ccode_name (bool_type));
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("s1", "const %s *".printf (get_ccode_name (st))));
		function.add_parameter (new CCodeParameter ("s2", "const %s *".printf (get_ccode_name (st))));

		push_function (function);

		// if (s1 == s2) return TRUE;
		{
			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s1"), new CCodeIdentifier ("s2"));
			ccode.open_if (cexp);
			ccode.add_return (get_boolean_cconstant (true));
			ccode.close ();
		}
		// if (s1 == NULL || s2 == NULL) return FALSE;
		{
			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s1"), new CCodeConstant ("NULL"));
			ccode.open_if (cexp);
			ccode.add_return (get_boolean_cconstant (false));
			ccode.close ();

			cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s2"), new CCodeConstant ("NULL"));
			ccode.open_if (cexp);
			ccode.add_return (get_boolean_cconstant (false));
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
			var s1 = (CCodeExpression) new CCodeMemberAccess.pointer (new CCodeIdentifier ("s1"), get_ccode_name (f)); // s1->f
			var s2 = (CCodeExpression) new CCodeMemberAccess.pointer (new CCodeIdentifier ("s2"), get_ccode_name (f)); // s2->f

			var variable_type = f.variable_type.copy ();
			make_comparable_cexpression (ref variable_type, ref s1, ref variable_type, ref s2);

			if (!(f.variable_type is NullType) && f.variable_type.compatible (string_type)) {
				CCodeFunctionCall ccall;
				if (context.profile == Profile.POSIX) {
					cfile.add_include ("string.h");
					ccall = new CCodeFunctionCall (new CCodeIdentifier (generate_cmp_wrapper (new CCodeIdentifier ("strcmp"))));
				} else {
					ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_strcmp0"));
				}
				ccall.add_argument (s1);
				ccall.add_argument (s2);
				cexp = ccall;
			} else if (f.variable_type is StructValueType) {
				var equalfunc = generate_struct_equal_function (f.variable_type.type_symbol as Struct);
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (equalfunc));
				ccall.add_argument (s1);
				ccall.add_argument (s2);
				cexp = new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, ccall);
			} else {
				cexp = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, s1, s2);
			}

			ccode.open_if (cexp);
			ccode.add_return (get_boolean_cconstant (false));
			ccode.close ();
		}

		if (!has_instance_fields) {
			// either opaque structure or simple type
			if (st.is_simple_type ()) {
				var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("s1")), new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("s2")));
				ccode.add_return (cexp);
			} else {
				ccode.add_return (get_boolean_cconstant (false));
			}
		} else {
			ccode.add_return (get_boolean_cconstant (true));
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

		var function = new CCodeFunction (equal_func, get_ccode_name (bool_type));
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("s1", "const %s *".printf (get_ccode_name (sym))));
		function.add_parameter (new CCodeParameter ("s2", "const %s *".printf (get_ccode_name (sym))));

		push_function (function);

		// if (s1 == s2) return TRUE;
		{
			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s1"), new CCodeIdentifier ("s2"));
			ccode.open_if (cexp);
			ccode.add_return (get_boolean_cconstant (true));
			ccode.close ();
		}
		// if (s1 == NULL || s2 == NULL) return FALSE;
		{
			var cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s1"), new CCodeConstant ("NULL"));
			ccode.open_if (cexp);
			ccode.add_return (get_boolean_cconstant (false));
			ccode.close ();

			cexp = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("s2"), new CCodeConstant ("NULL"));
			ccode.open_if (cexp);
			ccode.add_return (get_boolean_cconstant (false));
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

	string generate_ref_wrapper (ObjectType type) {
		string ref_func = "_vala_%s".printf (get_ccode_ref_function (type.object_type_symbol));

		if (!add_wrapper (ref_func)) {
			// wrapper already defined
			return ref_func;
		}

		var function = new CCodeFunction (ref_func, get_ccode_name (type));
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("self", get_ccode_name (type)));

		push_function (function);

		ccode.open_if (new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("self"), new CCodeConstant ("NULL")));

		var ref_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_ref_function (type.object_type_symbol)));
		ref_call.add_argument (new CCodeIdentifier ("self"));
		ccode.add_expression (ref_call);

		ccode.close ();

		ccode.add_return (new CCodeIdentifier ("self"));

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return ref_func;
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

			CCodeFunctionCall creation_call;
			if (context.profile == Profile.POSIX) {
				cfile.add_include ("stdlib.h");
				creation_call = new CCodeFunctionCall (new CCodeIdentifier ("calloc"));
				creation_call.add_argument (new CCodeConstant ("1"));
				var csizeof = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
				csizeof.add_argument (new CCodeIdentifier (get_ccode_name (value_type.type_symbol)));
				creation_call.add_argument (csizeof);
			} else {
				cfile.add_include ("glib.h");
				creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
				creation_call.add_argument (new CCodeIdentifier (get_ccode_name (value_type.type_symbol)));
				creation_call.add_argument (new CCodeConstant ("1"));
			}
			ccode.add_assignment (new CCodeIdentifier ("dup"), creation_call);

			var st = value_type.type_symbol as Struct;
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
				sizeof_call.add_argument (new CCodeConstant (get_ccode_name (value_type.type_symbol)));

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
		string destroy_func = "_vala_%s_copy".printf (get_ccode_name (type.type_symbol));

		if (!add_wrapper (destroy_func)) {
			// wrapper already defined
			return destroy_func;
		}

		var function = new CCodeFunction (destroy_func, get_ccode_name (type));
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeParameter ("self", get_ccode_name (type)));

		push_function (function);

		var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_boxed_copy"));
		free_call.add_argument (new CCodeIdentifier (get_ccode_type_id (type.type_symbol)));
		free_call.add_argument (new CCodeIdentifier ("self"));

		ccode.add_return (free_call);

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return destroy_func;
	}

	protected string generate_free_function_address_of_wrapper (DataType type) {
		string destroy_func = "_vala_%s_free_function_address_of".printf (get_ccode_name (type.type_symbol));

		if (!add_wrapper (destroy_func)) {
			// wrapper already defined
			return destroy_func;
		}

		var function = new CCodeFunction (destroy_func, "void");
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeParameter ("self", get_ccode_name (type)));

		push_function (function);

		unowned Class? cl = type.type_symbol as Class;
		assert (cl != null);

		var free_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_free_function (cl)));
		free_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeIdentifier ("self")));

		ccode.add_expression (free_call);

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return destroy_func;
	}

	protected string generate_destroy_function_content_of_wrapper (DataType type) {
		// g_array_set_clear_func has a specific GDestroyNotify where the content of an element is given
		string destroy_func = "_vala_%s_free_function_content_of".printf (get_ccode_name (type.type_symbol));

		if (!add_wrapper (destroy_func)) {
			// wrapper already defined
			return destroy_func;
		}

		var function = new CCodeFunction (destroy_func, "void");
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeParameter ("data", get_ccode_name (pointer_type)));
		push_function (function);

		ccode.add_declaration (get_ccode_name (type), new CCodeVariableDeclarator ("self"));
		var cast = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeCastExpression (new CCodeIdentifier ("data"), get_ccode_name (type) + "*"));
		ccode.add_assignment (new CCodeIdentifier ("self"), cast);

		var free_call = new CCodeFunctionCall (get_destroy0_func_expression (type));
		free_call.add_argument (new CCodeIdentifier ("self"));

		ccode.add_expression (free_call);

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return destroy_func;
	}

	protected string generate_free_func_wrapper (DataType type) {
		string destroy_func = "_vala_%s_free".printf (get_ccode_name (type.type_symbol));

		if (!add_wrapper (destroy_func)) {
			// wrapper already defined
			return destroy_func;
		}

		var function = new CCodeFunction (destroy_func, "void");
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeParameter ("self", get_ccode_name (type)));

		push_function (function);

		if (get_ccode_is_gboxed (type.type_symbol) || (gvalue_type != null && type.type_symbol == gvalue_type)) {
			var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_boxed_free"));
			free_call.add_argument (new CCodeIdentifier (get_ccode_type_id (type.type_symbol)));
			free_call.add_argument (new CCodeIdentifier ("self"));

			ccode.add_expression (free_call);
		} else {
			unowned Struct? st = type.type_symbol as Struct;
			if (st != null && st.is_disposable ()) {
				if (!get_ccode_has_destroy_function (st)) {
					generate_struct_destroy_function (st);
				}

				var destroy_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_destroy_function (st)));
				destroy_call.add_argument (new CCodeIdentifier ("self"));
				ccode.add_expression (destroy_call);
			}

			CCodeFunctionCall free_call;
			if (context.profile == Profile.POSIX) {
				cfile.add_include ("stdlib.h");
				free_call = new CCodeFunctionCall (new CCodeIdentifier ("free"));
			} else {
				cfile.add_include ("glib.h");
				free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
			}
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

		if (!(type is GenericType) && element_destroy_func_expression is CCodeIdentifier) {
			var freeid = (CCodeIdentifier) element_destroy_func_expression;
			string free0_func = "_%s0_".printf (freeid.name);

			if (add_wrapper (free0_func)) {
				var function = new CCodeFunction (free0_func, "void");
				function.modifiers = CCodeModifiers.STATIC;

				function.add_parameter (new CCodeParameter ("var", get_ccode_name (pointer_type)));

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
		if (context.profile == Profile.GOBJECT && (type.type_symbol == glist_type || type.type_symbol == gslist_type || type.type_symbol == gnode_type || type.type_symbol == gqueue_type)) {
			// create wrapper function to free list elements if necessary

			bool elements_require_free = false;
			bool generic_elements = false;
			CCodeExpression element_destroy_func_expression = null;

			foreach (DataType type_arg in type.get_type_arguments ()) {
				elements_require_free = requires_destroy (type_arg);
				if (elements_require_free) {
					element_destroy_func_expression = get_destroy0_func_expression (type_arg);
					generic_elements = (type_arg is GenericType);
				}
			}

			if (elements_require_free) {
				CCodeExpression? cexpr = null;
				if (element_destroy_func_expression is CCodeIdentifier || element_destroy_func_expression is CCodeMemberAccess) {
					cexpr = new CCodeIdentifier (generate_collection_free_wrapper (type, (generic_elements ? null : element_destroy_func_expression as CCodeIdentifier)));
					if (generic_elements) {
						// adding second argument early, instance parameter will be inserted by destroy_value()
						cexpr = new CCodeFunctionCall (cexpr);
						((CCodeFunctionCall) cexpr).add_argument (element_destroy_func_expression);
					}
				} else {
					Report.error (null, "internal error: No useable element_destroy_function found");
				}
				return cexpr;
			} else {
				return new CCodeIdentifier (get_ccode_free_function (type.type_symbol));
			}
		} else if (type is ErrorType) {
			cfile.add_include ("glib.h");
			return new CCodeIdentifier ("g_error_free");
		} else if (type is GenericType) {
			var type_parameter = ((GenericType) type).type_parameter;
			string identifier = get_ccode_destroy_function (type_parameter);
			return get_generic_type_expression (identifier, (GenericType) type, is_chainup);
		} else if (type.type_symbol != null) {
			string unref_function;
			if (type is ReferenceType) {
				if (is_reference_counting (type.type_symbol)) {
					unref_function = get_ccode_unref_function ((ObjectTypeSymbol) type.type_symbol);
					if (type.type_symbol is Interface && unref_function == null) {
						Report.error (type.source_reference, "missing class prerequisite for interface `%s', add GLib.Object to interface declaration if unsure", type.type_symbol.get_full_name ());
						return new CCodeInvalidExpression ();
					}
				} else {
					if (get_ccode_is_gboxed (type.type_symbol)) {
						unref_function = generate_free_func_wrapper (type);
					} else {
						if (is_free_function_address_of (type)) {
							unref_function = generate_free_function_address_of_wrapper (type);
						} else {
							unref_function = get_ccode_free_function (type.type_symbol);
						}
					}
				}
			} else {
				if (type.nullable) {
					if (get_ccode_is_gboxed (type.type_symbol)) {
						unref_function = generate_free_func_wrapper (type);
					} else {
						unref_function = get_ccode_free_function (type.type_symbol);
					}
					if (unref_function == null) {
						if (type.type_symbol is Struct && ((Struct) type.type_symbol).is_disposable ()) {
							unref_function = generate_free_func_wrapper (type);
						} else {
							if (context.profile == Profile.POSIX) {
								cfile.add_include ("stdlib.h");
								unref_function = "free";
							} else {
								cfile.add_include ("glib.h");
								unref_function = "g_free";
							}
						}
					}
				} else if (type is EnumValueType) {
					unref_function = null;
				} else {
					unowned Struct? st = type.type_symbol as Struct;
					if (st != null && st.is_disposable ()) {
						if (!get_ccode_has_destroy_function (st)) {
							generate_struct_destroy_function (st);
						}
						unref_function = get_ccode_destroy_function (st);
					} else {
						unref_function = null;
					}
				}
			}
			if (unref_function == null) {
				return new CCodeConstant ("NULL");
			}
			return new CCodeIdentifier (unref_function);
		} else if (type is ArrayType) {
			if (context.profile == Profile.POSIX) {
				cfile.add_include ("stdlib.h");
				return new CCodeIdentifier ("free");
			} else {
				cfile.add_include ("glib.h");
				return new CCodeIdentifier ("g_free");
			}
		} else if (type is PointerType) {
			if (context.profile == Profile.POSIX) {
				cfile.add_include ("stdlib.h");
				return new CCodeIdentifier ("free");
			} else {
				cfile.add_include ("glib.h");
				return new CCodeIdentifier ("g_free");
			}
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	private string generate_collection_free_wrapper (DataType collection_type, CCodeIdentifier? element_destroy_func_expression) {
		string destroy_func;

		string? destroy_func_wrapper = null;
		if (element_destroy_func_expression != null) {
			destroy_func_wrapper = "_%s_%s".printf (get_ccode_free_function (collection_type.type_symbol), element_destroy_func_expression.name);
			if (!add_wrapper (destroy_func_wrapper)) {
				// wrapper already defined
				return destroy_func_wrapper;
			}
		}

		if (collection_type.type_symbol == gnode_type) {
			destroy_func = "_g_node_free_all";
			if (!add_wrapper (destroy_func)) {
				// wrapper already defined
				return destroy_func;
			}

			var function = new CCodeFunction (destroy_func, "void");
			function.add_parameter (new CCodeParameter ("self", get_ccode_name (collection_type)));
			function.add_parameter (new CCodeParameter ("free_func", "GDestroyNotify"));

			push_function (function);

			CCodeFunctionCall element_free_call;
			string destroy_node_func = "%s_node".printf (destroy_func);
			var wrapper = new CCodeFunction (destroy_node_func, get_ccode_name (bool_type));
			wrapper.modifiers = CCodeModifiers.STATIC;
			wrapper.add_parameter (new CCodeParameter ("node", get_ccode_name (collection_type)));
			wrapper.add_parameter (new CCodeParameter ("free_func", "GDestroyNotify"));
			push_function (wrapper);

			var free_call = new CCodeFunctionCall (new CCodeIdentifier ("free_func"));
			free_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier("node"), "data"));

			var data_isnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeMemberAccess.pointer (new CCodeIdentifier("node"), "data"), new CCodeConstant ("NULL"));
			var ccomma_free = new CCodeCommaExpression ();
			ccomma_free.append_expression (free_call);
			ccomma_free.append_expression (new CCodeConstant ("NULL"));
			ccode.add_expression (new CCodeConditionalExpression (data_isnull, new CCodeConstant ("NULL"), ccomma_free));

			ccode.add_return (new CCodeConstant ("FALSE"));

			pop_function ();
			cfile.add_function_declaration (wrapper);
			cfile.add_function (wrapper);

			/* Now the code to call g_traverse with the above */
			element_free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_node_traverse"));
			element_free_call.add_argument (new CCodeIdentifier("self"));
			element_free_call.add_argument (new CCodeConstant ("G_POST_ORDER"));
			element_free_call.add_argument (new CCodeConstant ("G_TRAVERSE_ALL"));
			element_free_call.add_argument (new CCodeConstant ("-1"));
			element_free_call.add_argument (new CCodeCastExpression (new CCodeIdentifier (destroy_node_func), "GNodeTraverseFunc"));
			element_free_call.add_argument (new CCodeIdentifier ("free_func"));

			var free_func_isnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("free_func"), new CCodeConstant ("NULL"));
			var ccomma_element_free = new CCodeCommaExpression ();
			ccomma_element_free.append_expression (element_free_call);
			ccomma_element_free.append_expression (new CCodeConstant ("NULL"));
			ccode.add_expression (new CCodeConditionalExpression (free_func_isnull, new CCodeConstant ("NULL"), ccomma_element_free));

			var cfreecall = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_free_function (gnode_type)));
			cfreecall.add_argument (new CCodeIdentifier ("self"));
			ccode.add_expression (cfreecall);

			function.modifiers = CCodeModifiers.STATIC;
			pop_function ();

			cfile.add_function_declaration (function);
			cfile.add_function (function);
		} else if (collection_type.type_symbol == glist_type) {
			destroy_func = "g_list_free_full";
		} else if (collection_type.type_symbol == gslist_type) {
			destroy_func = "g_slist_free_full";
		} else if (collection_type.type_symbol == gqueue_type) {
			destroy_func = "g_queue_free_full";
		} else {
			Report.error (null, "internal error: type of collection not supported");
			return "";
		}

		if (element_destroy_func_expression != null) {
			var function = new CCodeFunction (destroy_func_wrapper, "void");
			function.add_parameter (new CCodeParameter ("self", get_ccode_name (collection_type)));

			push_function (function);

			var collection_free_call = new CCodeFunctionCall (new CCodeIdentifier (destroy_func));
			collection_free_call.add_argument (new CCodeIdentifier ("self"));
			collection_free_call.add_argument (new CCodeCastExpression (element_destroy_func_expression, "GDestroyNotify"));
			ccode.add_expression (collection_free_call);

			function.modifiers = CCodeModifiers.STATIC | CCodeModifiers.INLINE;
			pop_function ();

			cfile.add_function_declaration (function);
			cfile.add_function (function);

			return destroy_func_wrapper;
		}

		return destroy_func;
	}

	public virtual string? append_struct_array_destroy (Struct st) {
		return null;
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
			if (context.profile != Profile.GOBJECT) {
				// Required for NULL
				cfile.add_include ("stddef.h");
			}

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

		bool is_gcollection = (type.type_symbol == glist_type || type.type_symbol == gslist_type || type.type_symbol == gnode_type || type.type_symbol == gqueue_type);
		CCodeFunctionCall ccall;
		var cexpr = get_destroy_func_expression (type);
		if (is_gcollection && cexpr is CCodeFunctionCall) {
			ccall = (CCodeFunctionCall) cexpr;
		} else {
			ccall = new CCodeFunctionCall (cexpr);
		}

		if (type is ValueType && !type.nullable) {
			// normal value type, no null check
			unowned Struct? st = type.type_symbol as Struct;
			if (st != null && st.is_simple_type ()) {
				// used for va_list
				ccall.add_argument (cvar);
			} else {
				ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cvar));
			}

			if (gvalue_type != null && type.type_symbol == gvalue_type) {
				// g_value_unset must not be called for already unset values
				var cisvalid = new CCodeFunctionCall (new CCodeIdentifier ("G_IS_VALUE"));
				cisvalid.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cvar));

				var ccomma = new CCodeCommaExpression ();
				ccomma.append_expression (ccall);
				ccomma.append_expression (new CCodeConstant ("NULL"));

				return new CCodeConditionalExpression (cisvalid, ccomma, new CCodeConstant ("NULL"));
			} else if ((type.type_symbol == gmutex_type ||
			            type.type_symbol == grecmutex_type ||
			            type.type_symbol == grwlock_type ||
			            type.type_symbol == gcond_type)) {
				// g_mutex_clear must not be called for uninitialized mutex
				// also, g_mutex_clear does not clear the struct
				requires_clear_mutex = true;
				ccall.call = new CCodeIdentifier ("_vala_clear_" + get_ccode_name (type.type_symbol));
				return ccall;
			} else {
				return ccall;
			}
		}

		if (!is_gcollection && ccall.call is CCodeIdentifier && !(type is ArrayType) && !(type is GenericType) && !is_macro_definition) {
			// generate and use NULL-aware free macro to simplify code

			var freeid = (CCodeIdentifier) ccall.call;
			string free0_func = "_%s0".printf (freeid.name);

			if (add_wrapper (free0_func)) {
				var macro = destroy_value (new GLibValue (type, new CCodeIdentifier ("var"), true), true);
				cfile.add_type_declaration (new CCodeMacroReplacement.with_expression ("%s(var)".printf (free0_func), macro));
			}

			// FIXME this breaks in our macro, so this should not happen
			while (cvar is CCodeCastExpression) {
				cvar = ((CCodeCastExpression) cvar).inner;
			}
			if (cvar is CCodeFunctionCall) {
				cvar = ((CCodeFunctionCall) cvar).get_arguments ()[0];
			}

			ccall = new CCodeFunctionCall (new CCodeIdentifier (free0_func));
			ccall.add_argument (cvar);
			return ccall;
		}

		if (context.profile != Profile.GOBJECT) {
			// Required for NULL
			cfile.add_include ("stddef.h");
		}

		/* (foo == NULL ? NULL : foo = (unref (foo), NULL)) */

		/* can be simplified to
		 * foo = (unref (foo), NULL)
		 * if foo is of static type non-null
		 */

		var cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, cvar, new CCodeConstant ("NULL"));
		if (type is GenericType) {
			var parent = ((GenericType) type).type_parameter.parent_symbol;
			var cl = parent as Class;
			if ((!(parent is Method) && !(parent is ObjectTypeSymbol)) || (cl != null && cl.is_compact)) {
				return new CCodeConstant ("NULL");
			}

			// unref functions are optional for type parameters
			var cunrefisnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, get_destroy_func_expression (type), new CCodeConstant ("NULL"));
			cisnull = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cisnull, cunrefisnull);
		}

		// glib collections already have the free_func argument, so make sure the instance parameter gets first
		ccall.insert_argument (0, cvar);

		/* set freed references to NULL to prevent further use */
		var ccomma = new CCodeCommaExpression ();

		if (context.profile == Profile.GOBJECT
		    && type.type_symbol != null && !is_reference_counting (type.type_symbol)
		    && type.type_symbol.is_subtype_of (gstringbuilder_type)) {
			ccall.add_argument (new CCodeConstant ("TRUE"));
		} else if (context.profile == Profile.GOBJECT
		    && type.type_symbol == gthreadpool_type) {
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
					unowned Struct? st = array_type.element_type.type_symbol as Struct;
					if (st != null && !array_type.element_type.nullable) {
						ccall.call = new CCodeIdentifier (append_struct_array_free (st));
						ccall.add_argument (csizeexpr);
					} else {
						requires_array_free = true;
						generate_type_declaration (delegate_target_destroy_type, cfile);

						ccall.call = new CCodeIdentifier ("_vala_array_free");
						ccall.add_argument (csizeexpr);
						ccall.add_argument (new CCodeCastExpression (get_destroy_func_expression (array_type.element_type), get_ccode_name (delegate_target_destroy_type)));
					}
				}
			}
		}

		ccomma.append_expression (ccall);
		ccomma.append_expression (new CCodeConstant ("NULL"));

		var cassign = new CCodeAssignment (cvar, ccomma);

		// g_free (NULL) is allowed
		bool uses_gfree = (type.type_symbol != null && !is_reference_counting (type.type_symbol) && get_ccode_free_function (type.type_symbol) == "g_free");
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

	public void emit_temp_var (LocalVariable local, bool on_error = false) {
		generate_type_declaration (local.variable_type, cfile);

		var init = (!local.name.has_prefix ("*") && local.init);
		if (is_in_coroutine ()) {
			closure_struct.add_field (get_ccode_name (local.variable_type), local.name, 0, get_ccode_declarator_suffix (local.variable_type));

			// even though closure struct is zerod, we need to initialize temporary variables
			// as they might be used multiple times when declared in a loop

			if (init) {
				var initializer = default_value_for_type (local.variable_type, false, on_error);
				if (initializer == null) {
					cfile.add_include ("string.h");
					var memset_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
					memset_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_variable_cexpression (local.name)));
					memset_call.add_argument (new CCodeConstant ("0"));
					CCodeExpression? size = null;
					requires_memset_init (local, out size);
					if (size == null) {
						size = new CCodeIdentifier ("sizeof (%s)".printf (get_ccode_name (local.variable_type)));
					}
					memset_call.add_argument (size);
					ccode.add_expression (memset_call);
				} else {
					ccode.add_assignment (get_variable_cexpression (local.name), initializer);
				}
			}
		} else {
			var cvar = new CCodeVariableDeclarator (local.name, null, get_ccode_declarator_suffix (local.variable_type));
			CCodeExpression? size = null;
			if (init && !requires_memset_init (local, out size)) {
				cvar.initializer = default_value_for_type (local.variable_type, true, on_error);
				cvar.init0 = true;
			} else if (init && size != null && local.initializer == null) {
				cfile.add_include ("string.h");
				var memset_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
				memset_call.add_argument (get_variable_cexpression (local.name));
				memset_call.add_argument (new CCodeConstant ("0"));
				memset_call.add_argument (size);
				ccode.add_expression (memset_call);
			}
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
			if (!local.unreachable && local.active && !local.captured && requires_destroy (local.variable_type)) {
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

	public void append_local_free (Symbol sym, Statement? jump_stmt = null, CodeNode? stop_at = null) {
		var b = (Block) sym;

		append_scope_free (sym, stop_at);

		if (jump_stmt is BreakStatement) {
			if (b.parent_node is LoopStatement ||
			    b.parent_node is ForeachStatement ||
			    b.parent_node is SwitchStatement) {
				return;
			}
		} else if (jump_stmt is ContinueStatement) {
			if (b.parent_node is LoopStatement ||
			    b.parent_node is ForeachStatement) {
				return;
			}
		}

		if (stop_at != null && b.parent_node == stop_at) {
			return;
		}

		if (sym.parent_symbol is Block) {
			append_local_free (sym.parent_symbol, jump_stmt, stop_at);
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
			if (!param.captured && !param.ellipsis && !param.params_array && requires_destroy (param.variable_type) && param.direction == ParameterDirection.IN) {
				ccode.add_expression (destroy_parameter (param));
			}
		}
	}

	public void append_out_param_free (Method? m) {
		if (m == null) {
			return;
		}
		foreach (Parameter param in m.get_parameters ()) {
			if (param.direction == ParameterDirection.OUT && param.variable_type.is_disposable ()) {
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

		ccode.open_if (get_parameter_cexpression (param));
		ccode.add_assignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_parameter_cexpression (param)), get_cvalue_ (value));

		if (get_ccode_delegate_target (param) && delegate_type != null && delegate_type.delegate_symbol.has_target) {
			ccode.add_assignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_cexpression (get_ccode_delegate_target_name (param))), get_delegate_target_cvalue (value));
			if (delegate_type.is_disposable ()) {
				ccode.add_assignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_cexpression (get_ccode_delegate_target_destroy_notify_name (param))), get_delegate_target_destroy_notify_cvalue (get_parameter_cvalue (param)));
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
				string length_cname = get_variable_array_length_cname (param, dim);
				ccode.open_if (get_cexpression (length_cname));
				ccode.add_assignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_cexpression (length_cname)), get_array_length_cvalue (value, dim));
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
		if (((current_method != null && get_ccode_array_length (current_method)) || (current_property_accessor != null && get_ccode_array_length (current_property_accessor))) && current_return_type is ArrayType) {
			var temp_value = store_temp_value (stmt.return_expression.target_value, stmt);

			var array_type = (ArrayType) current_return_type;
			for (int dim = 1; dim <= array_type.rank; dim++) {
				var len_l = get_cexpression (get_array_length_cname ("result", dim));
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
		} else if (((current_method != null && get_ccode_delegate_target (current_method)) || (current_property_accessor != null && get_ccode_delegate_target (current_property_accessor))) && current_return_type is DelegateType) {
			var delegate_type = (DelegateType) current_return_type;
			if (delegate_type.delegate_symbol.has_target) {
				var temp_value = store_temp_value (stmt.return_expression.target_value, stmt);

				var target_l = get_cexpression (get_delegate_target_cname ("result"));
				if (!is_in_coroutine ()) {
					target_l = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, target_l);
				}
				var target_r = get_delegate_target_cvalue (temp_value);
				ccode.add_assignment (target_l, target_r);
				if (delegate_type.is_disposable ()) {
					var target_l_destroy_notify = get_cexpression (get_delegate_target_destroy_notify_cname ("result"));
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
			CCodeExpression result_lhs = get_cexpression ("result");
			if (current_return_type.is_real_non_null_struct_type () && !is_in_coroutine ()) {
				result_lhs = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, result_lhs);
			} else if (current_return_type is GenericType) {
				set_cvalue (stmt.return_expression, convert_to_generic_pointer (get_cvalue (stmt.return_expression), stmt.return_expression.value_type));
			}
			ccode.add_assignment (result_lhs, get_cvalue (stmt.return_expression));
		}

		if (current_method != null) {
			// check postconditions
			foreach (Expression postcondition in current_method.get_postconditions ()) {
				create_postcondition_statement (postcondition);
			}
		}

		// free local variables
		append_local_free (current_symbol);

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

		// TODO: don't duplicate the code in CCodeMethodModule, we do this right now because it needs to be before return
		if (current_method != null && current_method.has_attribute ("Profile")) {
			string prefix = "_vala_prof_%s".printf (get_ccode_real_name (current_method));

			var level = new CCodeIdentifier (prefix + "_level");
			ccode.open_if (new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeUnaryExpression (CCodeUnaryOperator.PREFIX_DECREMENT, level)));

			var timer = new CCodeIdentifier (prefix + "_timer");

			var stop_call = new CCodeFunctionCall (new CCodeIdentifier ("g_timer_stop"));
			stop_call.add_argument (timer);
			ccode.add_expression (stop_call);

			ccode.close ();
		}

		if (is_in_constructor ()) {
			ccode.add_return (new CCodeIdentifier ("obj"));
		} else if (is_in_destructor ()) {
			// do not call return as member cleanup and chain up to base finalizer
			// still need to be executed
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
		return "__lock_%s".printf (symname.replace ("-", "_"));
	}

	private CCodeExpression get_lock_expression (Statement stmt, Expression resource) {
		CCodeExpression l = null;
		var member = resource.symbol_reference;
		var parent = (TypeSymbol)resource.symbol_reference.parent_symbol;

		if (member.is_instance_member ()) {
			l = get_cvalue (((MemberAccess) resource).inner);
			l = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (l, "priv"), get_symbol_lock_name (get_ccode_name (member)));
		} else if (member.is_class_member ()) {
			unowned Class cl = (Class) parent;
			var cast = get_this_class_cexpression (cl);
			var get_class_private_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_get_private_function (cl)));
			get_class_private_call.add_argument (cast);
			l = new CCodeMemberAccess.pointer (get_class_private_call, get_symbol_lock_name (get_ccode_name (member)));
		} else {
			string lock_name = "%s_%s".printf (get_ccode_lower_case_name (parent), get_ccode_name (member));
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
		unowned DataType type = stmt.expression.value_type;
		unowned PointerType? pointer_type = type as PointerType;
		if (pointer_type != null && pointer_type.base_type.type_symbol != null && pointer_type.base_type.type_symbol.is_reference_type ()) {
			type = pointer_type.base_type;
		}

		ccode.add_expression (destroy_value (new GLibValue (type, get_cvalue (stmt.expression))));
	}

	static bool is_compact_class_destructor_call (Expression expr) {
		unowned Class? cl = expr.value_type.type_symbol as Class;
		if (cl != null && cl.is_compact && expr.parent_node is MemberAccess) {
			unowned MethodType? mt = ((MemberAccess) expr.parent_node).value_type as MethodType;
			if (mt != null && mt.method_symbol != null && mt.method_symbol.has_attribute ("DestroysInstance")) {
				return true;
			}
		}
		return false;
	}

	public override void visit_expression (Expression expr) {
		if (get_cvalue (expr) != null && !expr.lvalue) {
			if (expr.formal_value_type is GenericType && !(expr.value_type is GenericType)) {
				var type_parameter = ((GenericType) expr.formal_value_type).type_parameter;
				var st = type_parameter.parent_symbol.parent_symbol as Struct;
				if (type_parameter.parent_symbol != garray_type &&
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
				if (((GenericType) expr.formal_target_type).type_parameter.parent_symbol != garray_type) {
					// GArray doesn't use pointer-based generics
					set_cvalue (expr, convert_to_generic_pointer (get_cvalue (expr), expr.target_type));
					((GLibValue) expr.target_value).lvalue = false;
				}
			} else if (expr.formal_target_type is GenericType && !(expr.value_type is GenericType)) {
				set_cvalue (expr, convert_to_generic_pointer (get_cvalue (expr), expr.value_type));
			}

			// Allow null to initialize non-null struct inside initializer list
			if (expr is NullLiteral && expr.parent_node is InitializerList
			    && expr.target_type != null && expr.target_type.is_real_non_null_struct_type ()) {
				var clist = new CCodeInitializerList ();
				clist.append (new CCodeConstant ("0"));
				set_cvalue (expr, new CCodeCastExpression (clist, get_ccode_name (expr.target_type.type_symbol)));
			}

			if (!(expr.value_type is ValueType && !expr.value_type.nullable)) {
				((GLibValue) expr.target_value).non_null = expr.is_non_null ();
			}
		} else if (expr.value_type != null && is_compact_class_destructor_call (expr)) {
			// transfer ownership here and consume given instance
			var temp_value = store_temp_value (expr.target_value, expr);
			ccode.add_assignment (get_cvalue (expr), new CCodeConstant ("NULL"));
			expr.target_value = temp_value;
		}
	}

	public override void visit_boolean_literal (BooleanLiteral expr) {
		set_cvalue (expr, get_boolean_cconstant (expr.value));
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
		if (parts[1].contains ("o")) {
			flags += " | G_REGEX_OPTIMIZE";
		}

		var cdecl = new CCodeDeclaration ("GRegex*");

		var cname = "_tmp_regex_%d".printf (next_regex_id);
		if (this.next_regex_id == 0) {
			var fun = new CCodeFunction ("_thread_safe_regex_init", "GRegex*");
			fun.modifiers = CCodeModifiers.STATIC | CCodeModifiers.INLINE;
			fun.add_parameter (new CCodeParameter ("re", "GRegex**"));
			fun.add_parameter (new CCodeParameter ("pattern", "const gchar *"));
			fun.add_parameter (new CCodeParameter ("compile_flags", "GRegexCompileFlags"));

			push_function (fun);

			CCodeFunctionCall once_enter_call;
			if (context.require_glib_version (2, 80)) {
				once_enter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_once_init_enter_pointer"));
				once_enter_call.add_argument (new CCodeConstant ("re"));
			} else if (context.require_glib_version (2, 68)) {
				once_enter_call	= new CCodeFunctionCall (new CCodeIdentifier ("g_once_init_enter"));
				once_enter_call.add_argument (new CCodeConstant ("(gsize*) re"));
			} else {
				once_enter_call = new CCodeFunctionCall (new CCodeIdentifier ("g_once_init_enter"));
				once_enter_call.add_argument (new CCodeConstant ("(volatile gsize*) re"));
			}
			ccode.open_if (once_enter_call);

			var regex_new_call = new CCodeFunctionCall (new CCodeIdentifier ("g_regex_new"));
			regex_new_call.add_argument (new CCodeConstant ("pattern"));
			regex_new_call.add_argument (new CCodeConstant ("compile_flags"));
			regex_new_call.add_argument (new CCodeConstant ("0"));
			regex_new_call.add_argument (new CCodeConstant ("NULL"));
			ccode.add_assignment (new CCodeIdentifier ("GRegex* val"), regex_new_call);

			CCodeFunctionCall once_leave_call;
			if (context.require_glib_version (2, 80)) {
				once_leave_call = new CCodeFunctionCall (new CCodeIdentifier ("g_once_init_leave_pointer"));
				once_leave_call.add_argument (new CCodeConstant ("re"));
				once_leave_call.add_argument (new CCodeConstant ("val"));
			} else if (context.require_glib_version (2, 68)) {
				once_leave_call	= new CCodeFunctionCall (new CCodeIdentifier ("g_once_init_leave"));
				once_leave_call.add_argument (new CCodeConstant ("(gsize*) re"));
				once_leave_call.add_argument (new CCodeConstant ("(gsize) val"));
			} else {
				once_leave_call = new CCodeFunctionCall (new CCodeIdentifier ("g_once_init_leave"));
				once_leave_call.add_argument (new CCodeConstant ("(volatile gsize*) re"));
				once_leave_call.add_argument (new CCodeConstant ("(gsize) val"));
			}
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
		if (context.profile == Profile.GOBJECT) {
			cfile.add_include ("glib.h");
		} else {
			cfile.add_include ("stddef.h");
		}
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

	public abstract TargetValue load_variable (Variable variable, TargetValue value, Expression? expr = null);

	public abstract TargetValue load_this_parameter (TypeSymbol sym);

	public abstract void store_value (TargetValue lvalue, TargetValue value, SourceReference? source_reference = null);

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
		unowned Class? cl = expr.value_type.type_symbol as Class;
		if (cl != null && !cl.is_compact) {
			set_cvalue (expr, generate_instance_cast (get_this_cexpression (), cl));
		} else {
			expr.target_value = load_this_parameter (expr.value_type.type_symbol);
		}
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

	static bool is_limited_generic_type (GenericType type) {
		unowned Class? cl = type.type_parameter.parent_symbol as Class;
		unowned Struct? st = type.type_parameter.parent_symbol as Struct;
		if ((cl != null && cl.is_compact) || st != null) {
			// compact classes and structs only
			// have very limited generics support
			return true;
		}
		return false;
	}

	public static bool requires_copy (DataType type) {
		if (!type.is_disposable ()) {
			return false;
		}

		unowned Class? cl = type.type_symbol as Class;
		if (cl != null && is_reference_counting (cl)
		    && get_ccode_ref_function (cl) == "") {
			// empty ref_function => no ref necessary
			return false;
		}

		if (type is GenericType) {
			if (is_limited_generic_type ((GenericType) type)) {
				return false;
			}
		}

		return true;
	}

	public static bool requires_destroy (DataType type) {
		if (!type.is_disposable ()) {
			return false;
		}

		var array_type = type as ArrayType;
		if (array_type != null && array_type.fixed_length) {
			return requires_destroy (array_type.element_type);
		}

		unowned Class? cl = type.type_symbol as Class;
		if (cl != null && is_reference_counting (cl)
		    && get_ccode_unref_function (cl) == "") {
			// empty unref_function => no unref necessary
			return false;
		}

		if (type is GenericType) {
			if (is_limited_generic_type ((GenericType) type)) {
				return false;
			}
		}

		return true;
	}

	public virtual TargetValue? copy_value (TargetValue value, CodeNode node) {
		var type = value.value_type;
		var cexpr = get_cvalue_ (value);
		var result = ((GLibValue) value).copy ();

		if (type is DelegateType) {
			var delegate_type = (DelegateType) type;
			if (get_ccode_delegate_target (node) && delegate_type.delegate_symbol.has_target && !context.deprecated) {
				Report.deprecated (node.source_reference, "copying delegates is not supported");
			}
			result.delegate_target_destroy_notify_cvalue = new CCodeConstant ("NULL");
			return result;
		}

		if (type is ValueType && !type.nullable) {
			// normal value type, no null check

			// use temp-var for upcoming address-of operator
			var temp_cvalue = create_temp_value (type, false, node);
			store_value (temp_cvalue, value, node.source_reference);
			cexpr = get_cvalue_ (temp_cvalue);

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

			if (gvalue_type != null && type.type_symbol == gvalue_type) {
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
				store_value (temp_value, temp_cvalue, node.source_reference);
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
				var dup0_fun = new CCodeFunction (dup0_func, get_ccode_name (pointer_type));
				dup0_fun.add_parameter (new CCodeParameter ("self", get_ccode_name (pointer_type)));
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
			CCodeExpression ccallarg;
			if (node is SliceExpression) {
				ccallarg = cexpr;
				cexpr = get_cvalue (((SliceExpression) node).container);
			} else {
				ccallarg = cexpr;
			}
			var cnotnull = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, cexpr, new CCodeConstant ("NULL"));
			if (type is GenericType) {
				// dup functions are optional for type parameters
				var cdupnotnull = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, get_dup_func_expression (type, node.source_reference), new CCodeConstant ("NULL"));
				cnotnull = new CCodeBinaryExpression (CCodeBinaryOperator.AND, cnotnull, cdupnotnull);
			}

			if (type is GenericType) {
				// cast from gconstpointer to gpointer as GBoxedCopyFunc expects gpointer
				ccall.add_argument (new CCodeCastExpression (ccallarg, get_ccode_name (pointer_type)));
			} else {
				ccall.add_argument (ccallarg);
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
			if (type is GenericType) {
				// the value might be non-null even when the dup function is null,
				// so we may not just use NULL for type parameters

				// cast from gconstpointer to gpointer as methods in
				// generic classes may not return gconstpointer
				cifnull = new CCodeCastExpression (cexpr, get_ccode_name (pointer_type));
			} else if (type.type_symbol != null) {
				cifnull = new CCodeConstant ("NULL");
			} else {
				cifnull = cexpr;
			}

			if (is_ref_function_void (type)) {
				ccode.open_if (cnotnull);
				ccode.add_expression (ccall);
				ccode.close ();
			} else {
				if (get_non_null (value)) {
					result.cvalue = ccall;
				} else {
					var ccond = new CCodeConditionalExpression (cnotnull, ccall, cifnull);
					result.cvalue = ccond;
				}
				result = (GLibValue) store_temp_value (result, node, true);
			}
			return result;
		}
	}

	public virtual void generate_class_declaration (Class cl, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, cl, get_ccode_name (cl))) {
			return;
		}
	}

	public virtual void generate_interface_declaration (Interface iface, CCodeFile decl_space) {
	}

	public virtual bool generate_method_declaration (Method m, CCodeFile decl_space) {
		return false;
	}

	public virtual void generate_error_domain_declaration (ErrorDomain edomain, CCodeFile decl_space) {
	}

	public void add_generic_type_arguments (Method m, Map<int,CCodeExpression> arg_map, List<DataType> type_args, CodeNode expr, bool is_chainup = false, List<TypeParameter>? type_parameters = null) {
		int type_param_index = 0;
		foreach (var type_arg in type_args) {
			if (get_ccode_simple_generics (m)) {
				if (requires_copy (type_arg)) {
					arg_map.set (get_param_pos (-1 + 0.1 * type_param_index + 0.03), get_destroy0_func_expression (type_arg, is_chainup));
				} else {
					arg_map.set (get_param_pos (-1 + 0.1 * type_param_index + 0.03), new CCodeConstant ("NULL"));
				}
				type_param_index++;
				continue;
			}

			if (type_parameters != null) {
				var type_param_name = type_parameters.get (type_param_index).name.ascii_down ().replace ("_", "-");
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeConstant ("\"%s-type\"".printf (type_param_name)));
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeConstant ("\"%s-dup-func\"".printf (type_param_name)));
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.05), new CCodeConstant ("\"%s-destroy-func\"".printf (type_param_name)));
			}

			arg_map.set (get_param_pos (0.1 * type_param_index + 0.02), get_type_id_expression (type_arg, is_chainup));
			if (requires_copy (type_arg)) {
				var dup_func = get_dup_func_expression (type_arg, type_arg.source_reference ?? expr.source_reference, is_chainup);
				if (dup_func == null) {
					// type doesn't contain a copy function
					expr.error = true;
					return;
				}
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.04), new CCodeCastExpression (dup_func, "GBoxedCopyFunc"));
				arg_map.set (get_param_pos (0.1 * type_param_index + 0.06), new CCodeCastExpression (get_destroy_func_expression (type_arg, is_chainup), "GDestroyNotify"));
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

		unowned Struct? st = expr.type_reference.type_symbol as Struct;
		if ((st != null && (!st.is_simple_type () || get_ccode_name (st) == "va_list")) || expr.get_object_initializer ().size > 0) {
			// value-type initialization or object creation expression with object initializer

			var local = expr.parent_node as LocalVariable;
			var field = expr.parent_node as Field;
			var a = expr.parent_node as Assignment;
			if (local != null && is_simple_struct_creation (local, local.initializer)) {
				instance = get_cvalue_ (get_local_cvalue (local));
			} else if (field != null && is_simple_struct_creation (field, field.initializer)) {
				// field initialization
				var thisparam = load_this_parameter ((TypeSymbol) field.parent_symbol);
				instance = get_cvalue_ (get_field_cvalue (field, thisparam));
			} else if (a != null && a.left.symbol_reference is Variable && is_simple_struct_creation ((Variable) a.left.symbol_reference, a.right)) {
				if (requires_destroy (a.left.value_type)) {
					/* unref old value */
					ccode.add_expression (destroy_value (a.left.target_value));
				}

				local = a.left.symbol_reference as LocalVariable;
				field = a.left.symbol_reference as Field;
				var param = a.left.symbol_reference as Parameter;
				if (local != null) {
					instance = get_cvalue_ (get_local_cvalue (local));
				} else if (field != null) {
					var inner = ((MemberAccess) a.left).inner;
					instance = get_cvalue_ (get_field_cvalue (field, inner != null ? inner.target_value : null));
				} else if (param != null) {
					instance = get_cvalue_ (get_parameter_cvalue (param));
				}
			} else if (expr.is_chainup) {
				instance = get_this_cexpression ();
			} else {
				var temp_value = create_temp_value (expr.type_reference, true, expr);
				instance = get_cvalue_ (temp_value);
			}
		}

		if (expr.symbol_reference == null) {
			// no creation method
			if (expr.type_reference.type_symbol is Struct) {
				// memset needs string.h
				cfile.add_include ("string.h");
				var creation_call = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
				creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
				creation_call.add_argument (new CCodeConstant ("0"));
				creation_call.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (get_ccode_name (expr.type_reference))));

				creation_expr = creation_call;
			}
		} else if (expr.type_reference.type_symbol == glist_type ||
		           expr.type_reference.type_symbol == gslist_type) {
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

			if (m is CreationMethod && !m.external && m.external_package) {
				unowned CreationMethod cm = (CreationMethod) m;
				if (!cm.chain_up) {
					Report.error (cm.source_reference, "internal: Creation method implementation in binding must be chained up");
				}
				// internal VAPI creation methods
				// only add them once per source file
				if (add_generated_external_symbol (cm)) {
					visit_creation_method (cm);
				}
			}

			unowned Class? cl = expr.type_reference.type_symbol as Class;

			if (!get_ccode_has_new_function (m)) {
				// use construct function directly
				creation_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_real_name (m)));
				creation_call.add_argument (new CCodeIdentifier (get_ccode_type_id (cl)));
			} else {
				creation_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_name (m)));
			}

			if ((st != null && !st.is_simple_type ()) && !(get_ccode_instance_pos (m) < 0)) {
				if (expr.is_chainup) {
					creation_call.add_argument (instance);
				} else {
					creation_call.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, instance));
				}
			} else if (st != null && get_ccode_name (st) == "va_list") {
				creation_call.add_argument (instance);
				if (get_ccode_name (m) == "va_start") {
					unowned Class? parent = current_method.parent_symbol as Class;
					if (in_creation_method && parent != null && !parent.is_compact) {
						creation_call = new CCodeFunctionCall (new CCodeIdentifier ("va_copy"));
						creation_call.add_argument (instance);
						creation_call.add_argument (new CCodeIdentifier ("_vala_va_list"));
					} else {
						Parameter last_param = null;
						// FIXME: this doesn't take into account exception handling parameters
						foreach (var param in current_method.get_parameters ()) {
							if (param.ellipsis || param.params_array) {
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
				out_arg_map.set (get_param_pos (get_ccode_async_result_pos (m)), new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "_res_"));
			}

			if (cl != null && (!cl.is_compact || get_ccode_simple_generics (m))) {
				add_generic_type_arguments (m, in_arg_map, expr.type_reference.get_type_arguments (), expr);
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
					ellipsis = param.ellipsis || param.params_array;
					if (!ellipsis) {
						if (param.direction == ParameterDirection.OUT) {
							carg_map = out_arg_map;
						}

						if (get_ccode_array_length (param) && param.variable_type is ArrayType) {
							var array_type = (ArrayType) param.variable_type;
							for (int dim = 1; dim <= array_type.rank; dim++) {
								carg_map.set (get_param_pos (get_ccode_array_length_pos (param) + 0.01 * dim), get_array_length_cexpression (arg, dim));
							}
						} else if (get_ccode_delegate_target (param) && param.variable_type is DelegateType) {
							var deleg_type = (DelegateType) param.variable_type;
							var d = deleg_type.delegate_symbol;
							if (d.has_target) {
								CCodeExpression delegate_target_destroy_notify;
								var delegate_target = get_delegate_target_cexpression (arg, out delegate_target_destroy_notify);
								carg_map.set (get_param_pos (get_ccode_delegate_target_pos (param)), delegate_target);
								if (deleg_type.is_disposable ()) {
									carg_map.set (get_param_pos (get_ccode_destroy_notify_pos (param)), delegate_target_destroy_notify);
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
				out_arg_map.set (get_param_pos (-1), new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_inner_error_cexpression ()));
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

			if (m != null && m.coroutine && m.parent_symbol is Class) {
				if (get_ccode_finish_instance (m)) {
					var tmp = new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data_"), "_source_object_");
					out_arg_map.set (get_param_pos (get_ccode_instance_pos (m)), tmp);
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
				int state = emit_context.next_coroutine_state++;

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
			if (expr.type_reference.type_symbol is Struct) {
				ccode.add_expression (creation_expr);
			} else {
				ccode.add_assignment (instance, creation_expr);
			}

			foreach (MemberInitializer init in expr.get_object_initializer ()) {
				if (init.symbol_reference is Field) {
					var f = (Field) init.symbol_reference;
					var instance_target_type = SemanticAnalyzer.get_data_type_for_symbol ((TypeSymbol) f.parent_symbol);
					var typed_inst = transform_value (new GLibValue (expr.type_reference, instance, true), instance_target_type, init);
					store_field (f, typed_inst, init.initializer.target_value, false, init.source_reference);

					var cl = f.parent_symbol as Class;
					if (cl != null) {
						generate_class_struct_declaration (cl, cfile);
					}
				} else if (init.symbol_reference is Property) {
					var p = (Property) init.symbol_reference;
					if (p.base_property != null) {
						p = p.base_property;
					} else if (p.base_interface_property != null) {
						p = p.base_interface_property;
					}
					var instance_target_type = SemanticAnalyzer.get_data_type_for_symbol ((TypeSymbol) p.parent_symbol);
					var typed_inst = transform_value (new GLibValue (expr.type_reference, instance), instance_target_type, init);
					var inst_ma = new MemberAccess.simple ("fake");
					inst_ma.target_value = typed_inst;
					store_property (p, inst_ma, init.initializer.target_value);
					// FIXME Do not ref/copy in the first place
					if (!p.set_accessor.value_type.value_owned && requires_destroy (init.initializer.target_value.value_type)) {
						ccode.add_expression (destroy_value (init.initializer.target_value));
					}
				} else {
					Report.error (init.source_reference, "internal: Unsupported symbol");
				}
			}

			set_cvalue (expr, instance);
		} else if (creation_expr != null) {
			var temp_value = create_temp_value (expr.value_type, false, expr);
			ccode.add_assignment (get_cvalue_ (temp_value), creation_expr);
			expr.target_value = temp_value;

			unowned Class? cl = expr.type_reference.type_symbol as Class;
			if (context.gobject_tracing) {
				// GObject creation tracing enabled

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

			// create a special GDestroyNotify for created GArray and set with g_array_set_clear_func (since glib 2.32)
			if (cl != null && cl == garray_type) {
				var type_arg = expr.type_reference.get_type_arguments ().get (0);
				if (requires_destroy (type_arg)) {
					var clear_func = new CCodeFunctionCall (new CCodeIdentifier ("g_array_set_clear_func"));
					clear_func.add_argument (get_cvalue_ (expr.target_value));
					string destroy_func;
					if (type_arg.is_non_null_simple_type () || type_arg.is_real_non_null_struct_type ()) {
						destroy_func = get_ccode_destroy_function (type_arg.type_symbol);
					} else {
						destroy_func = generate_destroy_function_content_of_wrapper (type_arg);
					}
					clear_func.add_argument (new CCodeCastExpression (new CCodeIdentifier (destroy_func), "GDestroyNotify"));
					ccode.add_expression (clear_func);
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
		cfile.add_include ("glib-object.h");

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

		if (expr.operator == UnaryOperator.INCREMENT || expr.operator == UnaryOperator.DECREMENT) {
			// increment/decrement variable
			var op = expr.operator == UnaryOperator.INCREMENT ? CCodeBinaryOperator.PLUS : CCodeBinaryOperator.MINUS;
			var cexpr = new CCodeBinaryExpression (op, get_cvalue_ (expr.inner.target_value), new CCodeConstant ("1"));
			ccode.add_assignment (get_cvalue (expr.inner), cexpr);

			// assign new value to temp variable
			var temp_value = store_temp_value (expr.inner.target_value, expr);

			MemberAccess ma = find_property_access (expr.inner);
			if (ma != null) {
				// property postfix expression
				var prop = (Property) ma.symbol_reference;

				store_property (prop, ma.inner, temp_value);
			}

			// return new value
			expr.target_value = temp_value;
			return;
		}

		CCodeUnaryOperator op;
		switch (expr.operator) {
		case UnaryOperator.PLUS:
			op = CCodeUnaryOperator.PLUS;
			break;
		case UnaryOperator.MINUS:
			op = CCodeUnaryOperator.MINUS;
			break;
		case UnaryOperator.LOGICAL_NEGATION:
			op = CCodeUnaryOperator.LOGICAL_NEGATION;
			break;
		case UnaryOperator.BITWISE_COMPLEMENT:
			op = CCodeUnaryOperator.BITWISE_COMPLEMENT;
			break;
		case UnaryOperator.INCREMENT:
			op = CCodeUnaryOperator.PREFIX_INCREMENT;
			break;
		case UnaryOperator.DECREMENT:
			op = CCodeUnaryOperator.PREFIX_DECREMENT;
			break;
		default:
			assert_not_reached ();
		}
		set_cvalue (expr, new CCodeUnaryExpression (op, get_cvalue (expr.inner)));
	}

	public virtual CCodeExpression? deserialize_expression (DataType type, CCodeExpression variant_expr, CCodeExpression? expr, CCodeExpression? error_expr = null, out bool may_fail = null) {
		assert_not_reached ();
	}

	public virtual CCodeExpression? serialize_expression (DataType type, CCodeExpression expr) {
		assert_not_reached ();
	}

	public override void visit_cast_expression (CastExpression expr) {
		if (expr.is_silent_cast) {
			set_cvalue (expr, new CCodeInvalidExpression ());
			expr.error = true;
			Report.error (expr.source_reference, "Operation not supported for this type");
			return;
		}

		generate_type_declaration (expr.type_reference, cfile);

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
			CCodeExpression array_length_expr;

			var sizeof_to = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_to.add_argument (new CCodeConstant (get_ccode_name (array_type.element_type)));
			var sizeof_from = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));

			var value_type = expr.inner.value_type;
			if (value_type is ValueType) {
				sizeof_from.add_argument (new CCodeConstant (get_ccode_name (value_type.type_symbol)));
				array_length_expr = new CCodeBinaryExpression (CCodeBinaryOperator.DIV, sizeof_from, sizeof_to);
			} else if (value_type is PointerType && ((PointerType) value_type).base_type is ValueType) {
				sizeof_from.add_argument (new CCodeConstant (get_ccode_name (((PointerType) value_type).base_type.type_symbol)));
				array_length_expr = new CCodeBinaryExpression (CCodeBinaryOperator.DIV, sizeof_from, sizeof_to);
			} else {
				// cast from unsupported non-array to array, set invalid length
				// required by string.data, e.g.
				array_length_expr = new CCodeConstant ("-1");
			}

			for (int dim = 1; dim <= array_type.rank; dim++) {
				append_array_length (expr, array_length_expr);
			}
		}

		var innercexpr = get_cvalue (expr.inner);
		if (expr.type_reference is ValueType && !expr.type_reference.nullable &&
			expr.inner.value_type is ValueType && expr.inner.value_type.nullable) {
			// handle nested cast expressions
			unowned Expression? inner_expr = expr.inner;
			while (inner_expr is CastExpression) {
				inner_expr = ((CastExpression) inner_expr).inner;
			}
			if (inner_expr.value_type.value_owned
			    && !(inner_expr.symbol_reference is Variable || inner_expr is ElementAccess)) {
				// heap allocated struct leaked, destroy it
				var value = new GLibValue (new PointerType (new VoidType ()), innercexpr);
				temp_ref_values.insert (0, value);
			}
			// nullable integer or float or boolean or struct or enum cast to non-nullable
			innercexpr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, innercexpr);
		} else if (expr.type_reference is ValueType && expr.type_reference.nullable &&
			expr.inner.value_type.is_real_non_null_struct_type ()) {
			// real non-null struct cast to nullable
			innercexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, innercexpr);
		} else if (expr.type_reference is ArrayType && !(expr.inner is Literal)
		    && expr.inner.value_type is ValueType && !expr.inner.value_type.nullable) {
			// integer or float or boolean or struct or enum to array cast
			innercexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, innercexpr);
		}
		set_cvalue (expr, new CCodeCastExpression (innercexpr, get_ccode_name (expr.type_reference)));
		//TODO Use get_non_null (expr.inner.target_value)
		((GLibValue) expr.target_value).non_null = expr.is_non_null ();

		if (expr.type_reference is DelegateType) {
			var target = get_delegate_target (expr.inner);
			if (target != null) {
				set_delegate_target (expr, target);
			} else {
				set_delegate_target (expr, new CCodeConstant ("NULL"));
			}
			var target_destroy_notify = get_delegate_target_destroy_notify (expr.inner);
			if (target_destroy_notify != null) {
				set_delegate_target_destroy_notify (expr, target_destroy_notify);
			} else {
				set_delegate_target_destroy_notify (expr, new CCodeConstant ("NULL"));
			}
		}
	}

	public override void visit_named_argument (NamedArgument expr) {
		set_cvalue (expr, get_cvalue (expr.inner));
	}

	public override void visit_pointer_indirection (PointerIndirection expr) {
		set_cvalue (expr, new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_cvalue (expr.inner)));
		((GLibValue) expr.target_value).lvalue = get_lvalue (expr.inner.target_value);
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
			ccode.add_assignment (get_cvalue (expr.inner), new CCodeConstant ("NULL"));
			var target = get_delegate_target_cvalue (expr.inner.target_value);
			if (target != null) {
				ccode.add_assignment (target, new CCodeConstant ("NULL"));
			}
			var target_destroy_notify = get_delegate_target_destroy_notify_cvalue (expr.inner.target_value);
			if (target_destroy_notify != null) {
				ccode.add_assignment (target_destroy_notify, new CCodeConstant ("NULL"));
			}
		} else if (expr.inner.value_type is ArrayType) {
			var array_type = (ArrayType) expr.inner.value_type;
			var glib_value = (GLibValue) expr.inner.target_value;

			ccode.add_assignment (get_cvalue (expr.inner), new CCodeConstant ("NULL"));
			if (glib_value.array_length_cvalues != null) {
				for (int dim = 1; dim <= array_type.rank; dim++) {
					ccode.add_assignment (get_array_length_cvalue (glib_value, dim), new CCodeConstant ("0"));
				}
			}
		} else {
			ccode.add_assignment (get_cvalue (expr.inner), new CCodeConstant ("NULL"));
		}
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		var cleft = get_cvalue (expr.left);
		var cright = get_cvalue (expr.right);

		CCodeExpression? left_chain = null;
		if (expr.is_chained) {
			var lbe = (BinaryExpression) expr.left;

			var temp_decl = get_temp_variable (lbe.right.target_type, true, null, false);
			emit_temp_var (temp_decl);
			var cvar = get_variable_cexpression (temp_decl.name);
			var clbe = (CCodeBinaryExpression) get_cvalue (lbe);
			if (lbe.is_chained) {
				clbe = (CCodeBinaryExpression) clbe.right;
			}
			ccode.add_assignment (cvar, get_cvalue (lbe.right));
			clbe.right = get_variable_cexpression (temp_decl.name);
			left_chain = cleft;
			cleft = cvar;
		}

		CCodeBinaryOperator op;
		switch (expr.operator) {
		case BinaryOperator.PLUS:
			op = CCodeBinaryOperator.PLUS;
			break;
		case BinaryOperator.MINUS:
			op = CCodeBinaryOperator.MINUS;
			break;
		case BinaryOperator.MUL:
			op = CCodeBinaryOperator.MUL;
			break;
		case BinaryOperator.DIV:
			op = CCodeBinaryOperator.DIV;
			break;
		case BinaryOperator.MOD:
			// FIXME Code duplication with CCodeAssignmentModule.emit_simple_assignment()
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
			break;
		case BinaryOperator.SHIFT_LEFT:
			op = CCodeBinaryOperator.SHIFT_LEFT;
			break;
		case BinaryOperator.SHIFT_RIGHT:
			op = CCodeBinaryOperator.SHIFT_RIGHT;
			break;
		case BinaryOperator.LESS_THAN:
			op = CCodeBinaryOperator.LESS_THAN;
			break;
		case BinaryOperator.GREATER_THAN:
			op = CCodeBinaryOperator.GREATER_THAN;
			break;
		case BinaryOperator.LESS_THAN_OR_EQUAL:
			op = CCodeBinaryOperator.LESS_THAN_OR_EQUAL;
			break;
		case BinaryOperator.GREATER_THAN_OR_EQUAL:
			op = CCodeBinaryOperator.GREATER_THAN_OR_EQUAL;
			break;
		case BinaryOperator.EQUALITY:
			op = CCodeBinaryOperator.EQUALITY;
			break;
		case BinaryOperator.INEQUALITY:
			op = CCodeBinaryOperator.INEQUALITY;
			break;
		case BinaryOperator.BITWISE_AND:
			op = CCodeBinaryOperator.BITWISE_AND;
			break;
		case BinaryOperator.BITWISE_OR:
			op = CCodeBinaryOperator.BITWISE_OR;
			break;
		case BinaryOperator.BITWISE_XOR:
			op = CCodeBinaryOperator.BITWISE_XOR;
			break;
		case BinaryOperator.AND:
			op = CCodeBinaryOperator.AND;
			break;
		case BinaryOperator.OR:
			op = CCodeBinaryOperator.OR;
			break;
		case BinaryOperator.IN:
			if (expr.right.value_type is ArrayType) {
				unowned ArrayType array_type = (ArrayType) expr.right.value_type;
				unowned DataType element_type = array_type.element_type;
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (generate_array_contains_wrapper (array_type)));
				CCodeExpression node = ccall;

				ccall.add_argument (cright);
				ccall.add_argument (get_array_length_cexpression (expr.right));
				if (element_type is StructValueType) {
					ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cleft));
				} else if (element_type is ValueType && !element_type.nullable
					&& expr.left.value_type is ValueType && expr.left.value_type.nullable) {
					// null check
					var cnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, cleft, new CCodeConstant ("NULL"));
					ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, cleft));
					node = new CCodeParenthesizedExpression (new CCodeConditionalExpression (cnull, new CCodeConstant ("FALSE"), ccall));
				} else {
					ccall.add_argument (cleft);
				}
				set_cvalue (expr, node);
			} else {
				set_cvalue (expr, new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeBinaryExpression (CCodeBinaryOperator.BITWISE_AND, cright, cleft), cleft));
			}
			return;
		default:
			assert_not_reached ();
		}

		if (expr.operator == BinaryOperator.EQUALITY ||
		    expr.operator == BinaryOperator.INEQUALITY) {
			var left_type = expr.left.target_type;
			var right_type = expr.right.target_type;
			make_comparable_cexpression (ref left_type, ref cleft, ref right_type, ref cright);

			if (left_type is StructValueType && right_type is StructValueType) {
				var equalfunc = generate_struct_equal_function ((Struct) left_type.type_symbol);
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (equalfunc));
				ccall.add_argument (cleft);
				ccall.add_argument (cright);
				cleft = ccall;
				cright = get_boolean_cconstant (true);
			} else if ((left_type is IntegerType || left_type is FloatingType || left_type is BooleanType || left_type is EnumValueType) && left_type.nullable &&
			           (right_type is IntegerType || right_type is FloatingType || right_type is BooleanType || right_type is EnumValueType) && right_type.nullable) {
				var equalfunc = generate_numeric_equal_function ((TypeSymbol) left_type.type_symbol);
				var ccall = new CCodeFunctionCall (new CCodeIdentifier (equalfunc));
				ccall.add_argument (cleft);
				ccall.add_argument (cright);
				cleft = ccall;
				cright = get_boolean_cconstant (true);
			}
		}

		bool is_string_comparison = false;
		if (!(expr.right.value_type is NullType) && expr.right.value_type.compatible (string_type)) {
			if (!(expr.left.value_type is NullType) && expr.left.value_type.compatible (string_type)) {
				is_string_comparison = true;
			} else if (expr.is_chained) {
				unowned BinaryExpression lbe = (BinaryExpression) expr.left;
				if (!(lbe.right.value_type is NullType) && lbe.right.value_type.compatible (string_type)) {
					is_string_comparison = true;
				}
			}
		}
		bool has_string_literal = (expr.left is StringLiteral || expr.right is StringLiteral);

		if (is_string_comparison || (has_string_literal && expr.operator != BinaryOperator.PLUS)) {
			switch (expr.operator) {
			case BinaryOperator.PLUS:
				// string concatenation
				if (expr.left.is_constant () && expr.right.is_constant ()) {
					string left, right;

					if (cleft is CCodeIdentifier) {
						left = ((CCodeIdentifier) cleft).name;
					} else if (cleft is CCodeConstant) {
						left = ((CCodeConstant) cleft).name;
					} else {
						Report.error (expr.source_reference, "internal: Unsupported expression");
						left = "NULL";
					}
					if (cright is CCodeIdentifier) {
						right = ((CCodeIdentifier) cright).name;
					} else if (cright is CCodeConstant) {
						right = ((CCodeConstant) cright).name;
					} else {
						Report.error (expr.source_reference, "internal: Unsupported expression");
						right = "NULL";
					}

					set_cvalue (expr, new CCodeConstant ("%s %s".printf (left, right)));
				} else {
					var temp_value = create_temp_value (expr.value_type, false, expr);
					CCodeFunctionCall ccall;

					if (context.profile == Profile.POSIX) {
						// convert to strcat (strcpy (malloc (1 + strlen (a) + strlen (b)), a), b)
						ccall = new CCodeFunctionCall (new CCodeIdentifier ("strcat"));
						var strcpy = new CCodeFunctionCall (new CCodeIdentifier ("strcpy"));
						var malloc = new CCodeFunctionCall (new CCodeIdentifier ("malloc"));

						var strlen_a = new CCodeFunctionCall (new CCodeIdentifier ("strlen"));
						strlen_a.add_argument (cleft);
						var strlen_b = new CCodeFunctionCall (new CCodeIdentifier ("strlen"));
						strlen_b.add_argument (cright);
						var newlength = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("1"),
							new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, strlen_a, strlen_b));
						malloc.add_argument (newlength);

						strcpy.add_argument (malloc);
						strcpy.add_argument (cleft);

						ccall.add_argument (strcpy);
						ccall.add_argument (cright);
					} else {
						// convert to g_strconcat (a, b, NULL)
						ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_strconcat"));
						ccall.add_argument (cleft);
						ccall.add_argument (cright);
						ccall.add_argument (new CCodeConstant("NULL"));
					}

					ccode.add_assignment (get_cvalue_ (temp_value), ccall);
					expr.target_value = temp_value;
				}
				return;
			case BinaryOperator.EQUALITY:
			case BinaryOperator.INEQUALITY:
			case BinaryOperator.LESS_THAN:
			case BinaryOperator.GREATER_THAN:
			case BinaryOperator.LESS_THAN_OR_EQUAL:
			case BinaryOperator.GREATER_THAN_OR_EQUAL:
				CCodeExpression call;
				if (context.profile == Profile.POSIX) {
					cfile.add_include ("string.h");
					call = new CCodeIdentifier (generate_cmp_wrapper (new CCodeIdentifier ("strcmp")));
				} else {
					call = new CCodeIdentifier ("g_strcmp0");
				}
				set_cvalue (expr, new CCodeBinaryCompareExpression (call, op, cleft, cright, new CCodeConstant ("0")));
				break;
			default:
				set_cvalue (expr, new CCodeBinaryExpression (op, cleft, cright));
				break;
			}
		} else {
			set_cvalue (expr, new CCodeBinaryExpression (op, cleft, cright));
		}

		if (left_chain != null) {
			set_cvalue (expr, new CCodeBinaryExpression (CCodeBinaryOperator.AND, left_chain, get_cvalue (expr)));
		}
	}

	public CCodeExpression? create_type_check (CCodeNode ccodenode, DataType type) {
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
			CCodeFunctionCall ccheck;
			if (type is GenericType || type.type_symbol == null || type.type_symbol.external_package) {
				ccheck = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_CHECK_INSTANCE_TYPE"));
				ccheck.add_argument ((CCodeExpression) ccodenode);
				ccheck.add_argument (get_type_id_expression (type));
			} else {
				ccheck = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_type_check_function (type.type_symbol)));
				ccheck.add_argument ((CCodeExpression) ccodenode);
			}

			return ccheck;
		}
	}

	string generate_array_contains_wrapper (ArrayType array_type) {
		string array_contains_func = "_vala_%s_array_contains".printf (get_ccode_lower_case_name (array_type.element_type));

		if (!add_wrapper (array_contains_func)) {
			return array_contains_func;
		}

		generate_type_declaration (ssize_t_type, cfile);

		var function = new CCodeFunction (array_contains_func, get_ccode_name (bool_type));
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("stack", "%s *".printf (get_ccode_name (array_type.element_type))));
		function.add_parameter (new CCodeParameter ("stack_length", get_ccode_name (ssize_t_type)));
		if (array_type.element_type is StructValueType) {
			function.add_parameter (new CCodeParameter ("needle", "const %s *".printf (get_ccode_name (array_type.element_type))));
		} else {
			function.add_parameter (new CCodeParameter ("needle", "const %s".printf (get_ccode_name (array_type.element_type))));
		}

		push_function (function);

		ccode.add_declaration (get_ccode_name (ssize_t_type), new CCodeVariableDeclarator ("i"));

		var cloop_initializer = new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeConstant ("0"));
		var cloop_condition = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier ("i"), new CCodeIdentifier ("stack_length"));
		var cloop_iterator = new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("i"));
		ccode.open_for (cloop_initializer, cloop_condition, cloop_iterator);

		var celement = new CCodeElementAccess (new CCodeIdentifier ("stack"), new CCodeIdentifier ("i"));
		var cneedle = new CCodeIdentifier ("needle");
		CCodeBinaryExpression cif_condition;
		if (array_type.element_type.compatible (string_type)) {
			CCodeFunctionCall ccall;
			if (context.profile == Profile.POSIX) {
				cfile.add_include ("string.h");
				ccall = new CCodeFunctionCall (new CCodeIdentifier (generate_cmp_wrapper (new CCodeIdentifier ("strcmp"))));
			} else {
				ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_strcmp0"));
			}
			ccall.add_argument (celement);
			ccall.add_argument (cneedle);
			cif_condition = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ccall, new CCodeConstant ("0"));
		} else if (array_type.element_type is StructValueType) {
			var equalfunc = generate_struct_equal_function ((Struct) array_type.element_type.type_symbol);
			var ccall = new CCodeFunctionCall (new CCodeIdentifier (equalfunc));
			ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, celement));
			ccall.add_argument (cneedle);
			cif_condition = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, ccall, get_boolean_cconstant (true));
		} else {
			cif_condition = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, cneedle, celement);
		}

		ccode.open_if (cif_condition);
		ccode.add_return (get_boolean_cconstant (true));
		ccode.close ();

		ccode.close ();

		ccode.add_return (get_boolean_cconstant (false));

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return array_contains_func;
	}

	string generate_cmp_wrapper (CCodeIdentifier cmpid) {
		// generate and call NULL-aware cmp function to reduce number
		// of temporary variables and simplify code

		string cmp0_func = "_%s0".printf (cmpid.name);

		// g_strcmp0 is already NULL-safe
		if (cmpid.name == "g_strcmp0") {
			cmp0_func = cmpid.name;
		} else if (add_wrapper (cmp0_func)) {
			var cmp0_fun = new CCodeFunction (cmp0_func, get_ccode_name (int_type));
			cmp0_fun.add_parameter (new CCodeParameter ("s1", "const void *"));
			cmp0_fun.add_parameter (new CCodeParameter ("s2", "const void *"));
			cmp0_fun.modifiers = CCodeModifiers.STATIC;

			push_function (cmp0_fun);

			// s1 != s2;
			var noteq = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("s1"), new CCodeIdentifier ("s2"));

			// if (!s1) return -(s1 != s2);
			{
				var cexp = new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("s1"));
				ccode.open_if (cexp);
				ccode.add_return (new CCodeUnaryExpression (CCodeUnaryOperator.MINUS, noteq));
				ccode.close ();
			}
			// if (!s2) return s1 != s2;
			{
				var cexp = new CCodeUnaryExpression (CCodeUnaryOperator.LOGICAL_NEGATION, new CCodeIdentifier ("s2"));
				ccode.open_if (cexp);
				ccode.add_return (noteq);
				ccode.close ();
			}
			// return strcmp (s1, s2);
			var cmp_call = new CCodeFunctionCall (cmpid);
			cmp_call.add_argument (new CCodeIdentifier ("s1"));
			cmp_call.add_argument (new CCodeIdentifier ("s2"));
			ccode.add_return (cmp_call);

			pop_function ();

			cfile.add_function (cmp0_fun);
		}

		return cmp0_func;
	}

	public override void visit_type_check (TypeCheck expr) {
		generate_type_declaration (expr.type_reference, cfile);

		var type = expr.expression.value_type;
		var pointer_type = type as PointerType;
		if (pointer_type != null) {
			type = pointer_type.base_type;
		}
		unowned Class? cl = type.type_symbol as Class;
		unowned Interface? iface = type.type_symbol as Interface;
		if ((cl != null && !cl.is_compact) || iface != null || type is GenericType || type is ErrorType) {
			set_cvalue (expr, create_type_check (get_cvalue (expr.expression), expr.type_reference));
		} else {
			set_cvalue (expr, new CCodeInvalidExpression ());
		}

		if (get_cvalue (expr) is CCodeInvalidExpression) {
			Report.error (expr.source_reference, "type check expressions not supported for compact classes, structs, and enums");
		}
	}

	public override void visit_lambda_expression (LambdaExpression lambda) {
		var delegate_type = (DelegateType) lambda.target_type;

		lambda.accept_children (this);

		bool expr_owned = lambda.value_type.value_owned;

		set_cvalue (lambda, new CCodeIdentifier (get_ccode_name (lambda.method)));

		unowned DataType? this_type;
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
		} else if ((this_type = get_this_type ()) != null) {
			CCodeExpression delegate_target = get_this_cexpression ();
			delegate_target = convert_to_generic_pointer (delegate_target, this_type);
			if (expr_owned || delegate_type.is_called_once) {
				var ref_call = new CCodeFunctionCall (get_dup_func_expression (this_type, lambda.source_reference));
				ref_call.add_argument (delegate_target);
				delegate_target = ref_call;
				set_delegate_target_destroy_notify (lambda, get_destroy_func_expression (this_type));
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
		unowned SemanticAnalyzer analyzer = context.analyzer;
		var result = cexpr;
		if (analyzer.is_reference_type_argument (actual_type) || analyzer.is_nullable_value_type_argument (actual_type)) {
			generate_type_declaration (actual_type, cfile);
			result = new CCodeCastExpression (cexpr, get_ccode_name (actual_type));
		} else if (analyzer.is_signed_integer_type_argument (actual_type)) {
			// FIXME this should not happen
			while (cexpr is CCodeCastExpression) {
				cexpr = ((CCodeCastExpression) cexpr).inner;
			}
			result = new CCodeCastExpression (new CCodeCastExpression (cexpr, "gintptr"), get_ccode_name (actual_type));
		} else if (analyzer.is_unsigned_integer_type_argument (actual_type)) {
			// FIXME this should not happen
			while (cexpr is CCodeCastExpression) {
				cexpr = ((CCodeCastExpression) cexpr).inner;
			}
			result = new CCodeCastExpression (new CCodeCastExpression (cexpr, "guintptr"), get_ccode_name (actual_type));
		}
		return result;
	}

	public CCodeExpression convert_to_generic_pointer (CCodeExpression cexpr, DataType actual_type) {
		unowned SemanticAnalyzer analyzer = context.analyzer;
		var result = cexpr;
		if (analyzer.is_signed_integer_type_argument (actual_type)) {
			// FIXME this should not happen
			while (cexpr is CCodeCastExpression) {
				cexpr = ((CCodeCastExpression) cexpr).inner;
			}
			result = new CCodeCastExpression (new CCodeCastExpression (cexpr, "gintptr"), get_ccode_name (pointer_type));
		} else if (analyzer.is_unsigned_integer_type_argument (actual_type)) {
			// FIXME this should not happen
			while (cexpr is CCodeCastExpression) {
				cexpr = ((CCodeCastExpression) cexpr).inner;
			}
			result = new CCodeCastExpression (new CCodeCastExpression (cexpr, "guintptr"), get_ccode_name (pointer_type));
		}
		return result;
	}

	int next_variant_function_id = 0;

	public TargetValue transform_value (TargetValue value, DataType? target_type, CodeNode node) {
		var type = value.value_type;
		var result = ((GLibValue) value).copy ();

		if (type.value_owned
		    && (target_type == null || target_type is GenericType || !target_type.floating_reference)
		    && type.floating_reference) {
			/* floating reference, sink it.
			 */
			unowned ObjectTypeSymbol? cl = type.type_symbol as ObjectTypeSymbol;
			var sink_func = (cl != null) ? get_ccode_ref_sink_function (cl) : "";

			if (sink_func != "") {
				if (type.nullable) {
					var is_not_null = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, result.cvalue, new CCodeConstant ("NULL"));
					ccode.open_if (is_not_null);
				}

				var csink = new CCodeFunctionCall (new CCodeIdentifier (sink_func));
				csink.add_argument (result.cvalue);
				ccode.add_expression (csink);

				if (type.nullable) {
					ccode.close ();
				}
			} else {
				Report.error (node.source_reference, "type `%s' does not support floating references", type.type_symbol.name);
			}
		}

		bool boxing = (type is ValueType && !type.nullable
		               && target_type is ValueType && target_type.nullable);
		bool unboxing = (type is ValueType && type.nullable
		                 && target_type is ValueType && !target_type.nullable);

		bool gvalue_boxing = (context.profile == Profile.GOBJECT
		                      && target_type != null
		                      && target_type.type_symbol == gvalue_type
		                      && !(type is NullType)
		                      && get_ccode_type_id (type) != "G_TYPE_VALUE");
		bool gvariant_boxing = (context.profile == Profile.GOBJECT
		                        && target_type != null
		                        && target_type.type_symbol == gvariant_type
		                        && !(type is NullType)
		                        && type.type_symbol != gvariant_type);

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
					store_value (temp_value, result, node.source_reference);
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
				Report.error (node.source_reference, "GValue boxing of type `%s' is not supported", type.to_string ());
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
				var length_ctype = get_ccode_array_length_type (array_type);
				for (int dim = 1; dim <= array_type.rank; dim++) {
					ccall.add_argument (get_array_length_cvalue (value, dim));
					cfunc.add_parameter (new CCodeParameter (get_array_length_cname ("value", dim), length_ctype));
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
				if (!(result.cvalue is CCodeConstantIdentifier)) {
					result = (GLibValue) store_temp_value (result, node);
				}
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

		bool array_needs_copy = false;
		if (type is ArrayType && target_type is ArrayType) {
			var array = (ArrayType) type;
			var target_array = (ArrayType) target_type;
			if (target_array.element_type.value_owned && !array.element_type.value_owned) {
				array_needs_copy = requires_copy (target_array.element_type);
			}
		}

		if (!gvalue_boxing && !gvariant_boxing && target_type.value_owned && (!type.value_owned || boxing || unboxing || array_needs_copy) && requires_copy (target_type) && !(type is NullType)) {
			// need to copy value
			var copy = (GLibValue) copy_value (result, node);

			// need to free old array after copying it
			if (array_needs_copy && requires_destroy (type)) {
				result.value_type = type.copy ();
				ccode.add_expression (destroy_value (result));
			}
			result = copy;

			// implicit array copying is deprecated, but allow it for internal codegen usage
			var prop_acc = node as PropertyAccessor;
			if ((prop_acc != null && !prop_acc.automatic_body)
			    && result.value_type is ArrayType) {
				Report.deprecated (node.source_reference, "implicit copy of array is deprecated, explicitly invoke the copy method instead");
			}
		}

		return result;
	}

	public virtual CCodeExpression get_implicit_cast_expression (CCodeExpression source_cexpr, DataType? expression_type, DataType? target_type, CodeNode? node) {
		var cexpr = source_cexpr;

		if (expression_type.type_symbol != null && expression_type.type_symbol == target_type.type_symbol) {
			// same type, no cast required
			return cexpr;
		}

		if (expression_type is NullType) {
			// null literal, no cast required when not converting to generic type pointer
			return cexpr;
		}

		generate_type_declaration (target_type, cfile);

		unowned Class? cl = target_type.type_symbol as Class;
		unowned Interface? iface = target_type.type_symbol as Interface;
		if (context.checking && (iface != null || (cl != null && !cl.is_compact))) {
			// checked cast for strict subtypes of GTypeInstance
			return generate_instance_cast (cexpr, target_type.type_symbol);
		} else if (target_type.type_symbol != null && get_ccode_name (expression_type) != get_ccode_name (target_type)) {
			unowned Struct? st = target_type.type_symbol as Struct;
			if (target_type.type_symbol.is_reference_type () || (st != null && st.is_simple_type ())) {
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
		unowned Property base_prop = prop;
		if (prop.base_property != null) {
			base_prop = prop.base_property;
		} else if (prop.base_interface_property != null) {
			base_prop = prop.base_interface_property;
		}
		if (instance is BaseAccess && (base_prop.is_abstract || base_prop.is_virtual)) {
			CCodeExpression? vcast = null;
			if (base_prop.parent_symbol is Class) {
				unowned Class base_class = (Class) base_prop.parent_symbol;
				vcast = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_class_type_function (base_class)));
				((CCodeFunctionCall) vcast).add_argument (new CCodeIdentifier ("%s_parent_class".printf (get_ccode_lower_case_name (current_class))));
			} else if (base_prop.parent_symbol is Interface) {
				unowned Interface base_iface = (Interface) base_prop.parent_symbol;
				vcast = get_this_interface_cexpression (base_iface);
			}
			if (vcast != null) {
				var ccall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, "set_%s".printf (prop.name)));
				ccall.add_argument ((CCodeExpression) get_ccodenode (instance));
				var cexpr = get_cvalue_ (value);
				if (prop.property_type.is_real_non_null_struct_type ()) {
					//TODO Make use of get_lvalue (value)
					if (!(cexpr is CCodeConstant || cexpr is CCodeIdentifier)) {
						var temp_value = store_temp_value (value, instance);
						cexpr = get_cvalue_ (temp_value);
					}
					cexpr = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cexpr);
				}
				ccall.add_argument (cexpr);

				ccode.add_expression (ccall);
			} else {
				Report.error (instance.source_reference, "internal: Invalid assignment to `%s'", base_prop.get_full_name ());
			}
			return;
		}

		var set_func = "g_object_set";

		if (!get_ccode_no_accessor_method (prop) && !(prop is DynamicProperty)) {
			generate_property_accessor_declaration (base_prop.set_accessor, cfile);
			set_func = get_ccode_name (base_prop.set_accessor);

			if (!prop.external && prop.external_package) {
				// internal VAPI properties
				// only add them once per source file
				if (add_generated_external_symbol (prop)) {
					visit_property (prop);
				}
			}
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (set_func));

		if (prop.binding == MemberBinding.INSTANCE) {
			/* target instance is first argument */
			var cinstance = (CCodeExpression) get_ccodenode (instance);

			if (prop.parent_symbol is Struct && !((Struct) prop.parent_symbol).is_simple_type ()) {
				// we need to pass struct instance by reference if it isn't a simple-type
				var instance_value = instance.target_value;
				if (!get_lvalue (instance_value)) {
					instance_value = store_temp_value (instance_value, instance);
				}
				cinstance = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue_ (instance_value));
			}

			ccall.add_argument (cinstance);
		}

		if (get_ccode_no_accessor_method (prop) || prop is DynamicProperty) {
			/* property name is second argument of g_object_set */
			ccall.add_argument (get_property_canonical_cconstant (prop));
		}

		var cexpr = get_cvalue_ (value);

		if (prop.property_type.is_real_non_null_struct_type ()) {
			//TODO Make use of get_lvalue (value)
			if (!(cexpr is CCodeConstant || cexpr is CCodeIdentifier)) {
				var temp_value = store_temp_value (value, instance);
				cexpr = get_cvalue_ (temp_value);
			}
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
			if (get_ccode_delegate_target (prop) && delegate_type.delegate_symbol.has_target) {
				ccall.add_argument (get_delegate_target_cvalue (value));
				if (base_prop.set_accessor.value_type.value_owned) {
					ccall.add_argument (get_delegate_target_destroy_notify_cvalue (value));
				}
			}
		}

		if (get_ccode_no_accessor_method (prop) || prop is DynamicProperty) {
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

	public static DataType get_callable_creturn_type (Callable c) {
		assert (c is Method || c is Delegate);
		var creturn_type = c.return_type.copy ();
		if (c is CreationMethod) {
			unowned Class? cl = c.parent_symbol as Class;
			unowned Struct? st = c.parent_symbol as Struct;
			if (cl != null) {
				// object creation methods return the new object in C
				// in Vala they have no return type
				creturn_type = new ObjectType (cl);
			} else if (st != null && st.is_simple_type ()) {
				// constructors return simple type structs by value
				creturn_type = new StructValueType (st);
			}
		} else if (c.return_type.is_real_non_null_struct_type ()) {
			// structs are returned via out parameter
			creturn_type = new VoidType ();
		}
		return creturn_type;
	}

	public CCodeExpression? default_value_for_type (DataType type, bool initializer_expression, bool on_error = false) {
		unowned Struct? st = type.type_symbol as Struct;
		var array_type = type as ArrayType;
		if (type.type_symbol != null && !type.nullable
		    && (on_error ? get_ccode_default_value_on_error (type.type_symbol) : get_ccode_default_value (type.type_symbol)) != "") {
		    CCodeExpression val = new CCodeConstant (on_error ? get_ccode_default_value_on_error (type.type_symbol) : get_ccode_default_value (type.type_symbol));
		    if (st != null && st.get_fields ().size > 0) {
				val = new CCodeCastExpression (val, get_ccode_name (st));
			}
			return val;
		} else if (initializer_expression && !type.nullable &&
				   (st != null || (array_type != null && array_type.fixed_length))) {
			// 0-initialize struct with struct initializer { 0 }
			// only allowed as initializer expression in C
			var clist = new CCodeInitializerList ();
			clist.append (new CCodeConstant ("0"));
			return clist;
		} else if ((type.type_symbol != null && type.type_symbol.is_reference_type ())
		           || type.nullable
		           || type is PointerType || type is DelegateType
		           || (array_type != null && !array_type.fixed_length)) {
			return new CCodeConstant ("NULL");
		} else if (type is GenericType) {
			return new CCodeConstant ("NULL");
		} else if (type is ErrorType) {
			return new CCodeConstant ("NULL");
		} else if (type is CType) {
			return new CCodeConstant (((CType) type).cdefault_value);
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
		if (type.type_symbol != null) {
			return type.type_symbol.get_attribute_bool ("CCode", "lvalue_access", true);
		}
		return true;
	}

	public bool requires_memset_init (Variable variable, out CCodeExpression? size) {
		unowned ArrayType? array_type = variable.variable_type as ArrayType;
		if (array_type != null && array_type.fixed_length) {
			var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_call.add_argument (new CCodeIdentifier (get_ccode_name (array_type.element_type)));
			size = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, get_ccodenode (array_type.length), sizeof_call);
			return !is_constant_ccode (array_type.length);
		}
		size = null;
		return false;
	}

	public CCodeDeclaratorSuffix? get_ccode_declarator_suffix (DataType type) {
		var array_type = type as ArrayType;
		if (array_type != null) {
			if (array_type.fixed_length) {
				return new CCodeDeclaratorSuffix.with_array (get_ccodenode (array_type.length));
			} else if (array_type.inline_allocated) {
				return new CCodeDeclaratorSuffix.with_array ();
			}
		}
		return null;
	}

	public CCodeConstant get_signal_canonical_constant (Signal sig, string? detail = null) {
		return new CCodeConstant ("\"%s%s\"".printf (get_ccode_name (sig), (detail != null ? "::%s".printf (detail) : "")));
	}

	public CCodeConstant get_property_canonical_cconstant (Property prop) {
		return new CCodeConstant ("\"%s\"".printf (get_ccode_name (prop)));
	}

	public override void visit_class (Class cl) {
	}

	public void create_postcondition_statement (Expression postcondition) {
		var cassert = new CCodeFunctionCall (new CCodeIdentifier ("_vala_warn_if_fail"));

		postcondition.emit (this);

		string message = ((string) postcondition.source_reference.begin.pos).substring (0, (int) (postcondition.source_reference.end.pos - postcondition.source_reference.begin.pos));
		cassert.add_argument (get_cvalue (postcondition));
		cassert.add_argument (new CCodeConstant ("\"%s\"".printf (message.replace ("\n", " ").escape (""))));
		requires_assert = true;

		ccode.add_expression (cassert);

		foreach (var value in temp_ref_values) {
			ccode.add_expression (destroy_value (value));
		}

		temp_ref_values.clear ();
	}

	public unowned DataType? get_this_type () {
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
		function.add_parameter (new CCodeParameter ("self", "%s *".printf (get_ccode_name (st))));

		push_context (new EmitContext ());
		push_function (function);

		var this_value = load_this_parameter (st);
		foreach (Field f in st.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE) {
				if ((!(f.variable_type is DelegateType) || get_ccode_delegate_target (f)) && requires_destroy (f.variable_type)) {
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
		function.add_parameter (new CCodeParameter ("self", "const %s *".printf (get_ccode_name (st))));
		function.add_parameter (new CCodeParameter ("dest", "%s *".printf (get_ccode_name (st))));

		push_context (new EmitContext ());
		push_function (function);

		var dest_struct = new GLibValue (SemanticAnalyzer.get_data_type_for_symbol (st), new CCodeIdentifier ("(*dest)"), true);
		foreach (Field f in st.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE) {
				var value = load_field (f, load_this_parameter ((TypeSymbol) st));
				if ((!(f.variable_type is DelegateType) || get_ccode_delegate_target (f)) && requires_copy (f.variable_type))  {
					value = copy_value (value, f);
					if (value == null) {
						// error case, continue to avoid critical
						continue;
					}
				}
				store_field (f, dest_struct, value, false);
			}
		}

		pop_function ();
		pop_context ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);
	}

	public void return_default_value (DataType return_type, bool on_error = false) {
		unowned Struct? st = return_type.type_symbol as Struct;
		if (st != null && st.is_simple_type () && !return_type.nullable) {
			// 0-initialize struct with struct initializer { 0 }
			// only allowed as initializer expression in C
			var ret_temp_var = get_temp_variable (return_type, true, null, true);
			emit_temp_var (ret_temp_var, on_error);
			ccode.add_return (new CCodeIdentifier (ret_temp_var.name));
		} else {
			ccode.add_return (default_value_for_type (return_type, false, on_error));
		}
	}

	public virtual void generate_dynamic_method_wrapper (DynamicMethod method) {
	}

	public virtual CCodeExpression get_param_spec_cexpression (Property prop) {
		return new CCodeInvalidExpression ();
	}

	public virtual CCodeExpression get_param_spec (Property prop) {
		return new CCodeInvalidExpression ();
	}

	public virtual CCodeExpression get_signal_creation (Signal sig, ObjectTypeSymbol type) {
		return new CCodeInvalidExpression ();
	}

	public virtual CCodeExpression get_value_getter_function (DataType type_reference) {
		return new CCodeInvalidExpression ();
	}

	public virtual CCodeExpression get_value_setter_function (DataType type_reference) {
		return new CCodeInvalidExpression ();
	}

	public virtual CCodeExpression get_value_taker_function (DataType type_reference) {
		return new CCodeInvalidExpression ();
	}

	public virtual void register_dbus_info (CCodeBlock block, ObjectTypeSymbol bindable) {
	}

	public virtual string get_dynamic_signal_cname (DynamicSignal node) {
		return "";
	}

	public virtual string get_array_length_cname (string array_cname, int dim) {
		return "";
	}

	public virtual string get_variable_array_length_cname (Variable variable, int dim) {
		return "";
	}

	public virtual CCodeExpression get_array_length_cexpression (Expression array_expr, int dim = -1) {
		return new CCodeInvalidExpression ();
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

	public CCodeExpression get_boolean_cconstant (bool b) {
		if (context.profile == Profile.GOBJECT) {
			cfile.add_include ("glib.h");
			return new CCodeConstant (b ? "TRUE" : "FALSE");
		} else {
			cfile.add_include ("stdbool.h");
			return new CCodeConstant (b ? "true" : "false");
		}
	}
}
