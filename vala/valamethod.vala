/* valamethod.vala
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

/**
 * Represents a type or namespace method.
 */
public class Vala.Method : Subroutine {
	List<TypeParameter> type_parameters;

	/**
	 * The return type of this method.
	 */
	public DataType return_type {
		get { return _return_type; }
		set {
			_return_type = value;
			_return_type.parent_node = this;
		}
	}

	public override bool has_result {
		get { return !(return_type is VoidType); }
	}

	/**
	 * Specifies whether this method may only be called with an instance of
	 * the contained type.
	 */
	public MemberBinding binding { get; set; default = MemberBinding.INSTANCE; }
	
	/**
	 * Specifies whether this method is abstract. Abstract methods have no
	 * body, may only be specified within abstract classes, and must be
	 * overriden by derived non-abstract classes.
	 */
	public bool is_abstract { get; set; }
	
	/**
	 * Specifies whether this method is virtual. Virtual methods may be
	 * overridden by derived classes.
	 */
	public bool is_virtual { get; set; }
	
	/**
	 * Specifies whether this method overrides a virtual or abstract method
	 * of a base type.
	 */
	public bool overrides { get; set; }
	
	/**
	 * Specifies whether this method should be inlined.
	 */
	public bool is_inline { get; set; }

	public bool returns_floating_reference {
		get {
			return get_attribute_bool ("CCode", "returns_floating_reference");
		}
		set {
			set_attribute_bool ("CCode", "returns_floating_reference", value);
		}
	}

	/*
	 * Specifies whether the C method returns a new instance pointer which
	 * may be different from the previous instance pointer. Only valid for
	 * imported methods.
	 */
	public bool returns_modified_pointer {
		get {
			return get_attribute ("ReturnsModifiedPointer") != null;
		}
		set {
			set_attribute ("ReturnsModifiedPointer", value);
		}
	}

	/**
	 * Specifies the virtual or abstract method this method overrides.
	 * Reference must be weak as virtual and abstract methods set 
	 * base_method to themselves.
	 */
	public Method base_method {
		get {
			find_base_methods ();
			return _base_method;
		}
	}
	
	/**
	 * Specifies the abstract interface method this method implements.
	 */
	public Method base_interface_method {
		get {
			find_base_methods ();
			return _base_interface_method;
		}
	}

	public bool entry_point { get; private set; }

	/**
	 * Specifies the generated `this` parameter for instance methods.
	 */
	public Parameter this_parameter { get; set; }

	/**
	 * Specifies whether this method expects printf-style format arguments.
	 */
	public bool printf_format {
		get {
			return get_attribute ("PrintfFormat") != null;
		}
		set {
			set_attribute ("PrintfFormat", value);
		}
	}

	/**
	 * Specifies whether this method expects scanf-style format arguments.
	 */
	public bool scanf_format {
		get {
			return get_attribute ("ScanfFormat") != null;
		}
		set {
			set_attribute ("ScanfFormat", value);
		}
	}

	/**
	 * Specifies whether a construct function with a GType parameter is
	 * available. This is only applicable to creation methods.
	 */
	public bool has_construct_function {
		get {
			return get_attribute_bool ("CCode", "has_construct_function", true);
		}
		set {
			set_attribute_bool ("CCode", "has_construct_function", value);
		}
	}

	public weak Signal signal_reference { get; set; }

	public bool closure { get; set; }

	public bool coroutine { get; set; }

	public bool is_async_callback { get; set; }

	public int yield_count { get; set; }

	private List<Parameter> parameters = new ArrayList<Parameter> ();
	private List<Expression> preconditions;
	private List<Expression> postconditions;
	private DataType _return_type;

	private weak Method _base_method;
	private Method _base_interface_method;
	private bool base_methods_valid;

	Method? callback_method;

	// only valid for closures
	List<LocalVariable> captured_variables;

	static List<Expression> _empty_expression_list;
	static List<TypeParameter> _empty_type_parameter_list;

	/**
	 * Creates a new method.
	 *
	 * @param name        method name
	 * @param return_type method return type
	 * @param source      reference to source code
	 * @return            newly created method
	 */
	public Method (string? name, DataType return_type, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
		this.return_type = return_type;
	}

	/**
	 * Appends parameter to this method.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (Parameter param) {
		// default C parameter position
		parameters.add (param);
		scope.add (param.name, param);
	}
	
	public List<Parameter> get_parameters () {
		return parameters;
	}

	/**
	 * Remove all parameters from this method.
	 */
	public void clear_parameters () {
		foreach (Parameter param in parameters) {
			if (!param.ellipsis) {
				scope.remove (param.name);
			}
		}
		parameters.clear ();
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_method (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (TypeParameter p in get_type_parameters ()) {
			p.accept (visitor);
		}

		if (return_type != null) {
			return_type.accept (visitor);
		}

		foreach (Parameter param in parameters) {
			param.accept (visitor);
		}

		foreach (DataType error_type in get_error_types ()) {
			error_type.accept (visitor);
		}

		if (result_var != null) {
			result_var.accept (visitor);
		}

		if (preconditions != null) {
			foreach (Expression precondition in preconditions) {
				precondition.accept (visitor);
			}
		}

		if (postconditions != null) {
			foreach (Expression postcondition in postconditions) {
				postcondition.accept (visitor);
			}
		}

		if (body != null) {
			body.accept (visitor);
		}
	}

	/**
	 * Checks whether the parameters and return type of this method are
	 * compatible with the specified method
	 *
	 * @param base_method a method
	 * @param invalid_match error string about which check failed
	 * @return true if the specified method is compatible to this method
	 */
	public bool compatible (Method base_method, out string? invalid_match) {
		if (binding != base_method.binding) {
			invalid_match = "incompatible binding";
			return false;
		}

		ObjectType object_type = null;
		if (parent_symbol is ObjectTypeSymbol) {
			object_type = new ObjectType ((ObjectTypeSymbol) parent_symbol);
			foreach (TypeParameter type_parameter in object_type.type_symbol.get_type_parameters ()) {
				var type_arg = new GenericType (type_parameter);
				type_arg.value_owned = true;
				object_type.add_type_argument (type_arg);
			}
		}

		var actual_base_type = base_method.return_type.get_actual_type (object_type, null, this);
		if (!return_type.equals (actual_base_type)) {
			invalid_match = "incompatible return type";
			return false;
		}
		
		Iterator<Parameter> method_params_it = parameters.iterator ();
		int param_index = 1;
		foreach (Parameter base_param in base_method.parameters) {
			/* this method may not expect less arguments */
			if (!method_params_it.next ()) {
				invalid_match = "too few parameters";
				return false;
			}

			var param = method_params_it.get ();
			if (base_param.ellipsis != param.ellipsis) {
				invalid_match = "ellipsis parameter mismatch";
				return false;
			}
			if (!base_param.ellipsis) {
				actual_base_type = base_param.variable_type.get_actual_type (object_type, null, this);
				if (!actual_base_type.equals (param.variable_type)) {
					invalid_match = "incompatible type of parameter %d".printf (param_index);
					return false;
				}
			}
			param_index++;
		}
		
		/* this method may not expect more arguments */
		if (method_params_it.next ()) {
			invalid_match = "too many parameters";
			return false;
		}

		/* this method may throw less but not more errors than the base method */
		foreach (DataType method_error_type in get_error_types ()) {
			bool match = false;
			foreach (DataType base_method_error_type in base_method.get_error_types ()) {
				if (method_error_type.compatible (base_method_error_type)) {
					match = true;
					break;
				}
			}

			if (!match) {
				invalid_match = "incompatible error type `%s'".printf (method_error_type.to_string ());
				return false;
			}
		}
		if (base_method.coroutine != this.coroutine) {
			invalid_match = "async mismatch";
			return false;
		}

		invalid_match = null;
		return true;
	}

	/**
	 * Appends the specified parameter to the list of type parameters.
	 *
	 * @param p a type parameter
	 */
	public void add_type_parameter (TypeParameter p) {
		if (type_parameters == null) {
			type_parameters = new ArrayList<TypeParameter> ();
		}
		type_parameters.add (p);
		scope.add (p.name, p);
	}

	/**
	 * Returns a copy of the type parameter list.
	 *
	 * @return list of type parameters
	 */
	public List<TypeParameter> get_type_parameters () {
		if (type_parameters != null) {
			return type_parameters;
		}
		if (_empty_type_parameter_list == null) {
			_empty_type_parameter_list = new ArrayList<TypeParameter> ();
		}
		return _empty_type_parameter_list;
	}

	public int get_type_parameter_index (string name) {
		if (type_parameters == null) {
			return -1;
		}

		int i = 0;
		foreach (TypeParameter parameter in type_parameters) {
			if (parameter.name == name) {
				return i;
			}
			i++;
		}
		return -1;
	}

	/**
	 * Adds a precondition to this method.
	 *
	 * @param precondition a boolean precondition expression
	 */
	public void add_precondition (Expression precondition) {
		if (preconditions == null) {
			preconditions = new ArrayList<Expression> ();
		}
		preconditions.add (precondition);
		precondition.parent_node = this;
	}

	/**
	 * Returns a copy of the list of preconditions of this method.
	 *
	 * @return list of preconditions
	 */
	public List<Expression> get_preconditions () {
		if (preconditions != null) {
			return preconditions;
		}
		if (_empty_expression_list == null) {
			_empty_expression_list = new ArrayList<Expression> ();
		}
		return _empty_expression_list;
	}

	/**
	 * Adds a postcondition to this method.
	 *
	 * @param postcondition a boolean postcondition expression
	 */
	public void add_postcondition (Expression postcondition) {
		if (postconditions == null) {
			postconditions = new ArrayList<Expression> ();
		}
		postconditions.add (postcondition);
		postcondition.parent_node = this;
	}

	/**
	 * Returns a copy of the list of postconditions of this method.
	 *
	 * @return list of postconditions
	 */
	public List<Expression> get_postconditions () {
		if (postconditions != null) {
			return postconditions;
		}
		if (_empty_expression_list == null) {
			_empty_expression_list = new ArrayList<Expression> ();
		}
		return _empty_expression_list;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (return_type == old_type) {
			return_type = new_type;
			return;
		}
		var error_types = get_error_types ();
		for (int i = 0; i < error_types.size; i++) {
			if (error_types[i] == old_type) {
				error_types[i] = new_type;
				return;
			}
		}
	}

	private void find_base_methods () {
		if (base_methods_valid) {
			return;
		}

		if (parent_symbol is Class) {
			if (!(this is CreationMethod)) {
				find_base_interface_method ((Class) parent_symbol);
				if (is_virtual || is_abstract || overrides) {
					find_base_class_method ((Class) parent_symbol);
				}
			}
		} else if (parent_symbol is Interface) {
			if (is_virtual || is_abstract) {
				_base_interface_method = this;
			}
		}

		base_methods_valid = true;
	}

	private void find_base_class_method (Class cl) {
		var sym = cl.scope.lookup (name);
		if (sym is Signal) {
			var sig = (Signal) sym;
			sym = sig.default_handler;
		}
		if (sym is Method) {
			var base_method = (Method) sym;
			if (base_method.is_abstract || base_method.is_virtual) {
				string invalid_match;
				if (!compatible (base_method, out invalid_match)) {
					error = true;
					Report.error (source_reference, "overriding method `%s' is incompatible with base method `%s': %s.".printf (get_full_name (), base_method.get_full_name (), invalid_match));
					return;
				}

				_base_method = base_method;
				return;
			}
		}

		if (cl.base_class != null) {
			find_base_class_method (cl.base_class);
		}
	}

	private void find_base_interface_method (Class cl) {
		// FIXME report error if multiple possible base methods are found
		foreach (DataType type in cl.get_base_types ()) {
			if (type.data_type is Interface) {
				var sym = type.data_type.scope.lookup (name);
				if (sym is Signal) {
					var sig = (Signal) sym;
					sym = sig.default_handler;
				}
				if (sym is Method) {
					var base_method = (Method) sym;
					if (base_method.is_abstract || base_method.is_virtual) {
						string invalid_match;
						if (!compatible (base_method, out invalid_match)) {
							error = true;
							Report.error (source_reference, "overriding method `%s' is incompatible with base method `%s': %s.".printf (get_full_name (), base_method.get_full_name (), invalid_match));
							return;
						}

						_base_interface_method = base_method;
						return;
					}
				}
			}
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (get_attribute ("DestroysInstance") != null) {
			this_parameter.variable_type.value_owned = true;
		}
		if (get_attribute ("NoThrow") != null) {
			get_error_types ().clear ();
		}

		if (is_abstract) {
			if (parent_symbol is Class) {
				var cl = (Class) parent_symbol;
				if (!cl.is_abstract) {
					error = true;
					Report.error (source_reference, "Abstract methods may not be declared in non-abstract classes");
					return false;
				}
			} else if (!(parent_symbol is Interface)) {
				error = true;
				Report.error (source_reference, "Abstract methods may not be declared outside of classes and interfaces");
				return false;
			}
		} else if (is_virtual) {
			if (!(parent_symbol is Class) && !(parent_symbol is Interface)) {
				error = true;
				Report.error (source_reference, "Virtual methods may not be declared outside of classes and interfaces");
				return false;
			}

			if (parent_symbol is Class) {
				var cl = (Class) parent_symbol;
				if (cl.is_compact) {
					Report.error (source_reference, "Virtual methods may not be declared in compact classes");
					return false;
				}
			}
		} else if (overrides) {
			if (!(parent_symbol is Class)) {
				error = true;
				Report.error (source_reference, "Methods may not be overridden outside of classes");
				return false;
			}
		} else if (access == SymbolAccessibility.PROTECTED) {
			if (!(parent_symbol is Class) && !(parent_symbol is Interface)) {
				error = true;
				Report.error (source_reference, "Protected methods may not be declared outside of classes and interfaces");
				return false;
			}
		}

		if (is_abstract && body != null) {
			Report.error (source_reference, "Abstract methods cannot have bodies");
		} else if ((is_abstract || is_virtual) && external && !external_package && !parent_symbol.external) {
			Report.error (source_reference, "Extern methods cannot be abstract or virtual");
		} else if (external && body != null) {
			Report.error (source_reference, "Extern methods cannot have bodies");
		} else if (!is_abstract && !external && source_type == SourceFileType.SOURCE && body == null) {
			Report.error (source_reference, "Non-abstract, non-extern methods must have bodies");
		}

		if (coroutine && !external_package && !context.has_package ("gio-2.0")) {
			error = true;
			Report.error (source_reference, "gio-2.0 package required for async methods");
			return false;
		}

		var old_source_file = context.analyzer.current_source_file;
		var old_symbol = context.analyzer.current_symbol;

		if (source_reference != null) {
			context.analyzer.current_source_file = source_reference.file;
		}
		context.analyzer.current_symbol = this;

		return_type.check (context);

		var init_attr = get_attribute ("ModuleInit");
		if (init_attr != null) {
			source_reference.file.context.module_init_method = this;
		}

		if (return_type != null) {
			return_type.check (context);
		}

		if (parameters.size == 1 && parameters[0].ellipsis && body != null) {
			// accept just `...' for external methods for convenience
			error = true;
			Report.error (parameters[0].source_reference, "Named parameter required before `...'");
		}

		foreach (Parameter param in parameters) {
			param.check (context);
			if (coroutine && param.direction == ParameterDirection.REF) {
				error = true;
				Report.error (param.source_reference, "Reference parameters are not supported for async methods");
			}
		}

		foreach (DataType error_type in get_error_types ()) {
			error_type.check (context);

			// check whether error type is at least as accessible as the method
			if (!context.analyzer.is_type_accessible (this, error_type)) {
				error = true;
				Report.error (source_reference, "error type `%s` is less accessible than method `%s`".printf (error_type.to_string (), get_full_name ()));
				return false;
			}
		}

		if (result_var != null) {
			result_var.check (context);
		}

		if (preconditions != null) {
			foreach (Expression precondition in preconditions) {
				precondition.check (context);
			}
		}

		if (postconditions != null) {
			foreach (Expression postcondition in postconditions) {
				postcondition.check (context);
			}
		}

		if (body != null) {
			body.check (context);
		}

		if (context.analyzer.current_struct != null) {
			if (is_abstract || is_virtual || overrides) {
				error = true;
				Report.error (source_reference, "A struct member `%s' cannot be marked as override, virtual, or abstract".printf (get_full_name ()));
				return false;
			}
		} else if (overrides && base_method == null) {
			Report.error (source_reference, "%s: no suitable method found to override".printf (get_full_name ()));
		} else if ((is_abstract || is_virtual || overrides) && access == SymbolAccessibility.PRIVATE) {
			error = true;
			Report.error (source_reference, "Private member `%s' cannot be marked as override, virtual, or abstract".printf (get_full_name ()));
			return false;
		}

		context.analyzer.current_source_file = old_source_file;
		context.analyzer.current_symbol = old_symbol;

		if (!external_package && !overrides && !hides && get_hidden_member () != null) {
			Report.warning (source_reference, "%s hides inherited method `%s'. Use the `new' keyword if hiding was intentional".printf (get_full_name (), get_hidden_member ().get_full_name ()));
		}

		// check whether return type is at least as accessible as the method
		if (!context.analyzer.is_type_accessible (this, return_type)) {
			error = true;
			Report.error (source_reference, "return type `%s` is less accessible than method `%s`".printf (return_type.to_string (), get_full_name ()));
			return false;
		}

		foreach (Expression precondition in get_preconditions ()) {
			if (precondition.error) {
				// if there was an error in the precondition, skip this check
				error = true;
				return false;
			}

			if (!precondition.value_type.compatible (context.analyzer.bool_type)) {
				error = true;
				Report.error (precondition.source_reference, "Precondition must be boolean");
				return false;
			}
		}

		foreach (Expression postcondition in get_postconditions ()) {
			if (postcondition.error) {
				// if there was an error in the postcondition, skip this check
				error = true;
				return false;
			}

			if (!postcondition.value_type.compatible (context.analyzer.bool_type)) {
				error = true;
				Report.error (postcondition.source_reference, "Postcondition must be boolean");
				return false;
			}
		}

		// check that all errors that can be thrown in the method body are declared
		if (body != null) { 
			foreach (DataType body_error_type in body.get_error_types ()) {
				bool can_propagate_error = false;
				foreach (DataType method_error_type in get_error_types ()) {
					if (body_error_type.compatible (method_error_type)) {
						can_propagate_error = true;
					}
				}
				bool is_dynamic_error = body_error_type is ErrorType && ((ErrorType) body_error_type).dynamic_error;
				if (!can_propagate_error && !is_dynamic_error) {
					Report.warning (body_error_type.source_reference, "unhandled error `%s'".printf (body_error_type.to_string()));
				}
			}
		}

		if (is_possible_entry_point (context)) {
			if (context.entry_point != null) {
				error = true;
				Report.error (source_reference, "program already has an entry point `%s'".printf (context.entry_point.get_full_name ()));
				return false;
			}
			entry_point = true;
			context.entry_point = this;

			if (tree_can_fail && context.profile != Profile.DOVA) {
				Report.error (source_reference, "\"main\" method cannot throw errors");
			}
		}

		return !error;
	}

	bool is_possible_entry_point (CodeContext context) {
		if (external_package) {
			return false;
		}

		if (context.entry_point_name == null) {
			if (name == null || name != "main") {
				// method must be called "main"
				return false;
			}
		} else {
			// custom entry point name
			if (get_full_name () != context.entry_point_name) {
				return false;
			}
		}
		
		if (binding == MemberBinding.INSTANCE) {
			// method must be static
			return false;
		}
		
		if (return_type is VoidType) {
		} else if (return_type.data_type == context.analyzer.int_type.data_type) {
		} else {
			// return type must be void or int
			return false;
		}
		
		var params = get_parameters ();
		if (params.size == 0) {
			// method may have no parameters
			return true;
		}

		if (params.size > 1) {
			// method must not have more than one parameter
			return false;
		}
		
		Iterator<Parameter> params_it = params.iterator ();
		params_it.next ();
		var param = params_it.get ();

		if (param.direction == ParameterDirection.OUT) {
			// parameter must not be an out parameter
			return false;
		}
		
		if (!(param.variable_type is ArrayType)) {
			// parameter must be an array
			return false;
		}
		
		var array_type = (ArrayType) param.variable_type;
		if (array_type.element_type.data_type != context.analyzer.string_type.data_type) {
			// parameter must be an array of strings
			return false;
		}
		
		return true;
	}

	public int get_required_arguments () {
		int n = 0;
		foreach (var param in parameters) {
			if (param.initializer != null || param.ellipsis) {
				// optional argument
				break;
			}
			n++;
		}
		return n;
	}

	public Method get_callback_method () {
		assert (this.coroutine);

		if (callback_method == null) {
			var bool_type = new BooleanType ((Struct) CodeContext.get ().root.scope.lookup ("bool"));
			bool_type.value_owned = true;
			callback_method = new Method ("callback", bool_type, source_reference);
			callback_method.access = SymbolAccessibility.PUBLIC;
			callback_method.external = true;
			callback_method.binding = MemberBinding.INSTANCE;
			callback_method.owner = scope;
			callback_method.is_async_callback = true;
		}
		return callback_method;
	}

	public List<Parameter> get_async_begin_parameters () {
		assert (this.coroutine);

		var glib_ns = CodeContext.get ().root.scope.lookup ("GLib");

		var params = new ArrayList<Parameter> ();
		foreach (var param in parameters) {
			if (param.direction == ParameterDirection.IN) {
				params.add (param);
			}
		}

		var callback_type = new DelegateType ((Delegate) glib_ns.scope.lookup ("AsyncReadyCallback"));
		callback_type.nullable = true;
		callback_type.is_called_once = true;

		var callback_param = new Parameter ("_callback_", callback_type);
		callback_param.initializer = new NullLiteral (source_reference);
		callback_param.initializer.target_type = callback_type.copy ();
		callback_param.set_attribute_double ("CCode", "pos", -1);
		callback_param.set_attribute_double ("CCode", "delegate_target_pos", -0.9);

		params.add (callback_param);

		return params;
	}

	public List<Parameter> get_async_end_parameters () {
		assert (this.coroutine);

		var params = new ArrayList<Parameter> ();

		var glib_ns = CodeContext.get ().root.scope.lookup ("GLib");
		var result_type = new ObjectType ((ObjectTypeSymbol) glib_ns.scope.lookup ("AsyncResult"));

		var result_param = new Parameter ("_res_", result_type);
		result_param.set_attribute_double ("CCode", "pos", 0.1);
		params.add (result_param);

		foreach (var param in parameters) {
			if (param.direction == ParameterDirection.OUT) {
				params.add (param);
			}
		}

		return params;
	}

	public void add_captured_variable (LocalVariable local) {
		assert (this.closure);

		if (captured_variables == null) {
			captured_variables = new ArrayList<LocalVariable> ();
		}
		captured_variables.add (local);
	}

	public void get_captured_variables (Collection<LocalVariable> variables) {
		if (captured_variables != null) {
			foreach (var local in captured_variables) {
				variables.add (local);
			}
		}
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		// capturing variables is only supported if they are initialized
		// therefore assume that captured variables are initialized
		if (closure) {
			get_captured_variables ((Collection<LocalVariable>) collection);
		}
	}
}

// vim:sw=8 noet
