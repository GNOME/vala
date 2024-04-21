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
public class Vala.Method : Subroutine, Callable, GenericSymbol {
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
	 * overridden by derived non-abstract classes.
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
			return has_attribute ("ReturnsModifiedPointer");
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

	/**
	 * Specifies the explicit interface containing the method this method implements.
	 */
	public DataType base_interface_type {
		get { return _base_interface_type; }
		set {
			_base_interface_type = value;
			_base_interface_type.parent_node = this;
		}
	}

	public bool entry_point { get; private set; }

	public bool is_main_block { get; private set; }

	/**
	 * Specifies the generated `this` parameter for instance methods.
	 */
	public Parameter? this_parameter { get; set; }

	/**
	 * Specifies whether this method expects printf-style format arguments.
	 */
	public bool printf_format {
		get {
			return has_attribute ("PrintfFormat");
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
			return has_attribute ("ScanfFormat");
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

	public LocalVariable? params_array_var { get; protected set; }

	public weak Signal signal_reference { get; set; }

	public bool closure { get; set; }

	public bool coroutine { get; set; }

	public bool is_async_callback { get; set; }

	private List<Parameter> parameters = new ArrayList<Parameter> ();
	private List<Parameter>? async_begin_parameters;
	private List<Parameter>? async_end_parameters;
	private List<Expression> preconditions;
	private List<Expression> postconditions;
	private DataType _return_type;

	protected List<DataType> error_types;

	private weak Method _base_method;
	private weak Method _base_interface_method;
	private DataType _base_interface_type;
	private bool base_methods_valid;

	Method? callback_method;
	Method? end_method;

	// only valid for closures
	List<LocalVariable> captured_variables;

	static List<Expression> _empty_expression_list;
	static List<TypeParameter> _empty_type_parameter_list;

	/**
	 * Creates a new method.
	 *
	 * @param name              method name
	 * @param return_type       method return type
	 * @param source_reference  reference to source code
	 * @return                  newly created method
	 */
	public Method (string? name, DataType return_type, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
		this.return_type = return_type;
	}

	/**
	 * Creates a new main block method.
	 *
	 * @param source_reference  reference to source code
	 * @return                  newly created method
	 */
	public Method.main_block (SourceReference? source_reference = null) {
		base ("main", source_reference, null);
		return_type = new VoidType ();
		is_main_block = true;
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

	public unowned List<Parameter> get_parameters () {
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

	public bool is_variadic () {
		foreach (Parameter param in parameters) {
			if (param.ellipsis || param.params_array) {
				return true;
			}
		}
		return false;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_method (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (TypeParameter p in get_type_parameters ()) {
			p.accept (visitor);
		}

		if (base_interface_type != null) {
			base_interface_type.accept (visitor);
		}

		if (return_type != null) {
			return_type.accept (visitor);
		}

		foreach (Parameter param in parameters) {
			param.accept (visitor);
		}

		if (error_types != null) {
			foreach (DataType error_type in error_types) {
			error_type.accept (visitor);
		}
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
		return compatible_internal (base_method, out invalid_match, this);
	}

	/**
	 * Checks whether the parameters and return type of this method are
	 * compatible with the specified method
	 *
	 * @param base_method a method
	 * @return true if the specified method is compatible to this method
	 */
	public bool compatible_no_error (Method base_method) {
		return compatible_internal (base_method, null, null);
	}

	bool compatible_internal (Method base_method, out string? invalid_match, CodeNode? node_reference) {
		// method is always compatible to itself
		if (this == base_method) {
			invalid_match = null;
			return true;
		}

		if (binding != base_method.binding) {
			invalid_match = "incompatible binding";
			return false;
		}

		ObjectType object_type = null;
		if (parent_symbol is ObjectTypeSymbol) {
			object_type = new ObjectType ((ObjectTypeSymbol) parent_symbol);
			foreach (TypeParameter type_parameter in object_type.object_type_symbol.get_type_parameters ()) {
				var type_arg = new GenericType (type_parameter);
				type_arg.value_owned = true;
				object_type.add_type_argument (type_arg);
			}
		}

		if (this.get_type_parameters ().size < base_method.get_type_parameters ().size) {
			invalid_match = "too few type parameters";
			return false;
		} else if (this.get_type_parameters ().size > base_method.get_type_parameters ().size) {
			invalid_match = "too many type parameters";
			return false;
		}

		List<DataType> method_type_args = null;
		if (this.has_type_parameters ()) {
			method_type_args = new ArrayList<DataType> ();
			foreach (TypeParameter type_parameter in this.get_type_parameters ()) {
				var type_arg = new GenericType (type_parameter);
				type_arg.value_owned = true;
				method_type_args.add (type_arg);
			}
		}

		var return_type = this.return_type.copy ();
		if (has_attribute_argument ("CCode", "returns_floating_reference")) {
			return_type.floating_reference = returns_floating_reference;
		} else {
			return_type.floating_reference = base_method.returns_floating_reference;
		}

		var actual_base_type = base_method.return_type.get_actual_type (object_type, method_type_args, node_reference);
		if (!return_type.equals (actual_base_type)) {
			invalid_match = "Base method expected return type `%s', but `%s' was provided".printf (actual_base_type.to_prototype_string (), return_type.to_prototype_string ());
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
			if (base_param.params_array != param.params_array) {
				invalid_match = "params array parameter mismatch";
				return false;
			}
			if (!base_param.ellipsis) {
				if (base_param.direction != param.direction) {
					invalid_match = "incompatible direction of parameter %d".printf (param_index);
					return false;
				}

				actual_base_type = base_param.variable_type.get_actual_type (object_type, method_type_args, node_reference);
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
		var base_method_errors = new ArrayList<DataType> ();
		base_method.get_error_types (base_method_errors);
		if (error_types != null) {
			foreach (DataType method_error_type in error_types) {
			bool match = false;
				foreach (DataType base_method_error_type in base_method_errors) {
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
	 * Returns the type parameter list.
	 *
	 * @return list of type parameters
	 */
	public unowned List<TypeParameter> get_type_parameters () {
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

	public bool has_type_parameters () {
		return (type_parameters != null && type_parameters.size > 0);
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
	 * Returns the list of preconditions of this method.
	 *
	 * @return list of preconditions
	 */
	public unowned List<Expression> get_preconditions () {
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
	 * Returns the list of postconditions of this method.
	 *
	 * @return list of postconditions
	 */
	public unowned List<Expression> get_postconditions () {
		if (postconditions != null) {
			return postconditions;
		}
		if (_empty_expression_list == null) {
			_empty_expression_list = new ArrayList<Expression> ();
		}
		return _empty_expression_list;
	}

	/**
	 * Adds an error type to the exceptions that can be
	 * thrown by this method.
	 */
	public void add_error_type (DataType error_type) {
		if (error_types == null) {
			error_types = new ArrayList<DataType> ();
		}
		error_types.add (error_type);
		error_type.parent_node = this;
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		if (error_types != null) {
			foreach (var error_type in error_types) {
				if (source_reference != null) {
					var type = error_type.copy ();
					type.source_reference = source_reference;
					collection.add (type);
				} else {
					collection.add (error_type);
				}
			}
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (preconditions != null) {
			var index = preconditions.index_of (old_node);
			if (index >= 0) {
				preconditions[index] = new_node;
				new_node.parent_node = this;
			}
		}
		if (postconditions != null) {
			var index = postconditions.index_of (old_node);
			if (index >= 0) {
				postconditions[index] = new_node;
				new_node.parent_node = this;
			}
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (base_interface_type == old_type) {
			base_interface_type = new_type;
			return;
		}
		if (return_type == old_type) {
			return_type = new_type;
			return;
		}
		if (error_types != null) {
		for (int i = 0; i < error_types.size; i++) {
			if (error_types[i] == old_type) {
				error_types[i] = new_type;
				return;
			}
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
			unowned Signal sig = (Signal) sym;
			sym = sig.default_handler;
		}
		if (sym is Method) {
			unowned Method base_method = (Method) sym;
			if (base_method.is_abstract || base_method.is_virtual) {
				string invalid_match;
				if (!compatible (base_method, out invalid_match)) {
					error = true;
					var base_method_type = new MethodType (base_method);
					Report.error (source_reference, "overriding method `%s' is incompatible with base method `%s': %s.", get_full_name (), base_method_type.to_prototype_string (), invalid_match);
					return;
				}

				_base_method = base_method;
				copy_attribute_double (base_method, "CCode", "instance_pos");
				copy_attribute_bool (base_method, "CCode", "returns_floating_reference");
				return;
			}
		}

		if (cl.base_class != null) {
			find_base_class_method (cl.base_class);
		}
	}

	private void find_base_interface_method (Class cl) {
		Method? base_match = null;

		string? invalid_error = null;
		Method? invalid_base_match = null;

		foreach (DataType type in cl.get_base_types ()) {
			if (type.type_symbol is Interface) {
				if (base_interface_type != null && base_interface_type.type_symbol != type.type_symbol) {
					continue;
				}

				var sym = type.type_symbol.scope.lookup (name);
				if (sym is Signal) {
					unowned Signal sig = (Signal) sym;
					sym = sig.default_handler;
				}
				if (sym is Method) {
					unowned Method base_method = (Method) sym;
					if (base_method.is_abstract || base_method.is_virtual) {
						if (base_interface_type == null) {
							// check for existing explicit implementation
							var has_explicit_implementation = false;
							foreach (var m in cl.get_methods ()) {
								if (m.base_interface_type != null && base_method == m.base_interface_method) {
									has_explicit_implementation = true;
									break;
								}
							}
							if (has_explicit_implementation) {
								continue;
							}
						}

						string invalid_match = null;
						if (!compatible (base_method, out invalid_match)) {
							invalid_error = invalid_match;
							invalid_base_match = base_method;
						} else {
							base_match = base_method;
							break;
						}
					}
				}
			}
		}

		if (base_match != null) {
			_base_interface_method = base_match;
			copy_attribute_double (base_match, "CCode", "instance_pos");
			copy_attribute_bool (base_match, "CCode", "returns_floating_reference");
			return;
		} else if (!hides && invalid_base_match != null) {
			error = true;
			var base_method_type = new MethodType (invalid_base_match);
			Report.error (source_reference, "overriding method `%s' is incompatible with base method `%s': %s.", get_full_name (), base_method_type.to_prototype_string (), invalid_error);
			return;
		}

		if (base_interface_type != null) {
			Report.error (source_reference, "`%s': no suitable interface method found to implement", get_full_name ());
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (this_parameter != null) {
			this_parameter.check (context);
		}

		if (has_attribute ("DestroysInstance")) {
			this_parameter.variable_type.value_owned = true;
		}
		if (has_attribute ("NoThrow")) {
			error_types = null;
		}

		if (parent_symbol is Class && (is_abstract || is_virtual)) {
			unowned Class cl = (Class) parent_symbol;
			if (cl.is_compact && cl.base_class != null) {
				error = true;
				Report.error (source_reference, "Abstract and virtual methods may not be declared in derived compact classes");
				return false;
			}
			if (cl.is_opaque) {
				error = true;
				Report.error (source_reference, "Abstract and virtual methods may not be declared in opaque compact classes");
				return false;
			}
		}

		if (is_variadic () && (is_abstract || is_virtual)) {
			error = true;
			Report.error (source_reference, "Abstract and virtual methods may not be variadic. Use a `va_list' parameter instead of `...' or params-array.");
			return false;
		}

		if (has_attribute ("NoWrapper") && !(is_abstract || is_virtual)) {
			error = true;
			Report.error (source_reference, "[NoWrapper] methods must be declared abstract or virtual");
			return false;
		}

		if (is_abstract) {
			if (parent_symbol is Class) {
				unowned Class cl = (Class) parent_symbol;
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
			error = true;
			Report.error (source_reference, "Abstract methods cannot have bodies");
		} else if ((is_abstract || is_virtual) && is_extern) {
			error = true;
			Report.error (source_reference, "Extern methods cannot be abstract or virtual");
		} else if (is_extern && body != null) {
			error = true;
			Report.error (source_reference, "Extern methods cannot have bodies");
		} else if (!is_abstract && !external && source_type == SourceFileType.SOURCE && body == null) {
			error = true;
			Report.error (source_reference, "Non-abstract, non-extern methods must have bodies");
		}

		// auto-convert main block to async if a yield expression is used
		if (is_main_block && body != null) {
			body.accept (new TraverseVisitor (node => {
				if (!(node is Statement || node is Expression || node is Variable || node is CatchClause)) {
					return TraverseStatus.STOP;
				}
				if (node is YieldStatement
				    || (node is MethodCall && ((MethodCall) node).is_yield_expression)
				    || (node is ObjectCreationExpression && ((ObjectCreationExpression) node).is_yield_expression)) {
					coroutine = true;
					return TraverseStatus.STOP;
				}
				return TraverseStatus.CONTINUE;
			}));
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

		return_type.floating_reference = returns_floating_reference;
		return_type.check (context);
		if (!external_package) {
			context.analyzer.check_type (return_type);
			return_type.check_type_arguments (context, !(return_type is DelegateType));
		}

		if (return_type.type_symbol == context.analyzer.va_list_type.type_symbol) {
			error = true;
			Report.error (source_reference, "`%s' not supported as return type", return_type.type_symbol.get_full_name ());
			return false;
		}

		if (has_attribute ("ModuleInit")) {
			source_reference.file.context.module_init_method = this;
		}

		if (parameters.size == 1 && parameters[0].ellipsis && body != null && binding != MemberBinding.INSTANCE) {
			// accept just `...' for external methods and instance methods
			error = true;
			Report.error (parameters[0].source_reference, "Named parameter required before `...'");
		}

		if (has_attribute ("Print") && (parameters.size != 1 || parameters[0].variable_type.type_symbol != context.analyzer.string_type.type_symbol)) {
			error = true;
			Report.error (source_reference, "[Print] methods must have exactly one parameter of type `string'");
		}

		// Collect generic type references
		// TODO Can this be done in the SymbolResolver?
		List<GenericType> referenced_generics = new ArrayList<GenericType> ();
		var traverse = new TraverseVisitor (node => {
			if (node is GenericType) {
				referenced_generics.add ((GenericType) node);
				return TraverseStatus.STOP;
			}
			return TraverseStatus.CONTINUE;
		});

		foreach (TypeParameter p in get_type_parameters ()) {
			if (!p.check (context)) {
				error = true;
			}
		}

		return_type.accept (traverse);

		var optional_param = false;
		var params_array_param = false;
		var ellipsis_param = false;
		foreach (Parameter param in parameters) {
			if (!param.check (context)) {
				error = true;
				continue;
			}
			if (coroutine && param.direction == ParameterDirection.REF) {
				error = true;
				Report.error (param.source_reference, "Reference parameters are not supported for async methods");
			}
			if (!external_package && coroutine && (param.ellipsis || param.params_array || param.variable_type.type_symbol == context.analyzer.va_list_type.type_symbol)) {
				error = true;
				Report.error (param.source_reference, "Variadic parameters are not supported for async methods");
				return false;
			}

			param.accept_children (traverse);

			// TODO: begin and end parameters must be checked separately for coroutines
			if (coroutine) {
				continue;
			}
			if (optional_param && param.initializer == null && !param.ellipsis) {
				Report.warning (param.source_reference, "parameter without default follows parameter with default");
			} else if (param.initializer != null) {
				optional_param = true;
			}

			// Disallow parameter after params array or ellipsis
			if (params_array_param) {
				Report.error (param.source_reference, "parameter follows params-array parameter");
			} else if (param.params_array) {
				params_array_param = true;
			}
			if (ellipsis_param) {
				Report.error (param.source_reference, "parameter follows ellipsis parameter");
			} else if (param.ellipsis) {
				ellipsis_param = true;
			}

			// Add local variable to provide access to params arrays which will be constructed out of the given va-args
			if (param.params_array && body != null) {
				if (params_array_var != null) {
					error = true;
					Report.error (param.source_reference, "Only one params-array parameter is allowed");
					continue;
				}
				if (!context.experimental) {
					Report.warning (param.source_reference, "Support of params-arrays is experimental");
				}
				var type = (ArrayType) param.variable_type.copy ();
				type.element_type.value_owned = type.value_owned;
				type.value_owned = true;
				if (type.element_type.is_real_struct_type () && !type.element_type.nullable) {
					error = true;
					Report.error (param.source_reference, "Only nullable struct elements are supported in params-array");
				}
				if (type.length != null) {
					error = true;
					Report.error (param.source_reference, "Passing length to params-array is not supported yet");
				}
				params_array_var = new LocalVariable (type, param.name, null, param.source_reference);
				body.insert_statement (0, new DeclarationStatement (params_array_var, param.source_reference));
			}
		}

		// Check if referenced type-parameters are present
		// TODO Can this be done in the SymbolResolver?
		if (binding == MemberBinding.STATIC && parent_symbol is Class && !((Class) parent_symbol).is_compact) {
			Iterator<GenericType> ref_generics_it = referenced_generics.iterator ();
			while (ref_generics_it.next ()) {
				var ref_generics = ref_generics_it.get ();
				foreach (var type_param in get_type_parameters ()) {
					if (ref_generics.type_parameter.name == type_param.name) {
						ref_generics_it.remove ();
					}
				}
			}
			foreach (var type in referenced_generics) {
				error = true;
				Report.error (type.source_reference, "The type name `%s' could not be found", type.type_parameter.name);
			}
		}

		if (coroutine) {
			// TODO: async methods with out-parameters before in-parameters are not supported
			bool requires_pointer = false;
			for (int i = parameters.size - 1; i >= 0; i--) {
				var param = parameters[i];
				if (param.direction == ParameterDirection.IN) {
					requires_pointer = true;
				} else if (requires_pointer) {
					error = true;
					Report.error (param.source_reference, "Synchronous out-parameters are not supported in async methods");
				}
			}
		}

		if (error_types != null) {
			foreach (DataType error_type in error_types) {
				if (!(error_type is ErrorType)) {
					error = true;
					Report.error (error_type.source_reference, "`%s' is not an error type", error_type.to_string ());
				}
				error_type.check (context);

				// check whether error type is at least as accessible as the method
				if (!error_type.is_accessible (this)) {
					error = true;
					Report.error (source_reference, "error type `%s' is less accessible than method `%s'", error_type.to_string (), get_full_name ());
					return false;
				}
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

		if (overrides && base_method == null && base_interface_method != null && base_interface_method.is_abstract) {
			Report.warning (source_reference, "`override' not required to implement `abstract' interface method `%s'", base_interface_method.get_full_name ());
			overrides = false;
		} else if (!error && overrides && base_method == null && base_interface_method == null) {
			error = true;
			Report.error (source_reference, "`%s': no suitable method found to override", get_full_name ());
		} else if ((is_abstract || is_virtual || overrides) && access == SymbolAccessibility.PRIVATE) {
			error = true;
			Report.error (source_reference, "Private member `%s' cannot be marked as override, virtual, or abstract", get_full_name ());
			return false;
		}

		if (base_interface_type != null && base_interface_method != null && parent_symbol is Class) {
			unowned Class cl = (Class) parent_symbol;
			foreach (var m in cl.get_methods ()) {
				if (m != this && m.base_interface_method == base_interface_method) {
					m.checked = true;
					m.error = true;
					error = true;
					Report.error (source_reference, "`%s' already contains an implementation for `%s'", cl.get_full_name (), base_interface_method.get_full_name ());
					Report.notice (m.source_reference, "previous implementation of `%s' was here", base_interface_method.get_full_name ());
					return false;
				}
			}
		}

		context.analyzer.current_source_file = old_source_file;
		context.analyzer.current_symbol = old_symbol;

		if (!external_package && !overrides && !hides && get_hidden_member () != null) {
			Report.warning (source_reference, "%s hides inherited method `%s'. Use the `new' keyword if hiding was intentional", get_full_name (), get_hidden_member ().get_full_name ());
		}

		// check whether return type is at least as accessible as the method
		if (!return_type.is_accessible (this)) {
			error = true;
			Report.error (source_reference, "return type `%s' is less accessible than method `%s'", return_type.to_string (), get_full_name ());
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
		if (body != null && !body.error) {
			var body_errors = new ArrayList<DataType> ();
			body.get_error_types (body_errors);
			foreach (DataType body_error_type in body_errors) {
				bool can_propagate_error = false;
				if (error_types != null) {
					foreach (DataType method_error_type in error_types) {
					if (body_error_type.compatible (method_error_type)) {
						can_propagate_error = true;
					}
				}
				}
				bool is_dynamic_error = body_error_type is ErrorType && ((ErrorType) body_error_type).dynamic_error;
				if (!can_propagate_error && !is_dynamic_error) {
					Report.warning (body_error_type.source_reference, "unhandled error `%s'", body_error_type.to_string());
				}
			}
		}

		// check that DBus methods at least throw "GLib.Error" or "GLib.DBusError, GLib.IOError"
		if (!(this is CreationMethod) && binding == MemberBinding.INSTANCE
		    && !overrides && access == SymbolAccessibility.PUBLIC
		    && parent_symbol is ObjectTypeSymbol && parent_symbol.has_attribute ("DBus")) {
			Attribute? dbus_attr = get_attribute ("DBus");
			if (dbus_attr == null || dbus_attr.get_bool ("visible", true)) {
				bool throws_gerror = false;
				bool throws_gioerror = false;
				bool throws_gdbuserror = false;
				var error_types = new ArrayList<DataType> ();
				get_error_types (error_types);
				foreach (DataType error_type in error_types) {
					if (!(error_type is ErrorType)) {
						continue;
					}
					unowned ErrorDomain? error_domain = ((ErrorType) error_type).error_domain;
					if (error_domain == null) {
						throws_gerror = true;
						break;
					}
					string? full_error_domain = error_domain.get_full_name ();
					if (full_error_domain == "GLib.IOError") {
						throws_gioerror = true;
					} else if (full_error_domain == "GLib.DBusError") {
						throws_gdbuserror = true;
					}
				}
				if (!throws_gerror && !(throws_gioerror && throws_gdbuserror)) {
					Report.warning (source_reference, "DBus methods are recommended to throw at least `GLib.Error' or `GLib.DBusError, GLib.IOError'");
				}
			}
		}

		if (is_possible_entry_point (context)) {
			if (context.entry_point != null) {
				error = true;
				Report.error (source_reference, "program already has an entry point `%s'", context.entry_point.get_full_name ());
				return false;
			}
			entry_point = true;
			context.entry_point = this;

			if (tree_can_fail) {
				error = true;
				Report.error (source_reference, "\"main\" method cannot throw errors");
			}

			if (is_inline) {
				error = true;
				Report.error (source_reference, "\"main\" method cannot be inline");
			}
		}

		if (has_attribute ("GtkCallback")) {
			used = true;
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
		} else if (return_type.type_symbol == context.analyzer.int_type.type_symbol) {
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

		unowned ArrayType array_type = (ArrayType) param.variable_type;
		if (array_type.element_type.type_symbol != context.analyzer.string_type.type_symbol) {
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

	public unowned Method get_end_method () {
		assert (this.coroutine);

		if (end_method == null) {
			end_method = new Method ("end", return_type, source_reference);
			end_method.access = SymbolAccessibility.PUBLIC;
			end_method.external = true;
			end_method.owner = scope;
			foreach (var param in get_async_end_parameters ()) {
				end_method.add_parameter (param.copy ());
			}
			foreach (var param in get_type_parameters ()) {
				end_method.add_type_parameter (param);
			}
			end_method.copy_attribute_double (this, "CCode", "async_result_pos");
		}
		return end_method;
	}

	public unowned Method get_callback_method () {
		assert (this.coroutine);

		if (callback_method == null) {
			var bool_type = CodeContext.get ().analyzer.bool_type.copy ();
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

	public unowned List<Parameter> get_async_begin_parameters () {
		assert (this.coroutine);

		if (async_begin_parameters != null) {
			return async_begin_parameters;
		}

		async_begin_parameters = new ArrayList<Parameter> ();

		var glib_ns = CodeContext.get ().root.scope.lookup ("GLib");

		Parameter ellipsis = null;
		foreach (var param in parameters) {
			if (param.ellipsis) {
				ellipsis = param;
			} else if (param.direction == ParameterDirection.IN) {
				async_begin_parameters.add (param);
			}
		}

		var callback_type = new DelegateType ((Delegate) glib_ns.scope.lookup ("AsyncReadyCallback"), source_reference);
		callback_type.nullable = true;
		callback_type.value_owned = true;
		callback_type.is_called_once = true;

		var callback_param = new Parameter ("_callback_", callback_type, source_reference);
		callback_param.initializer = new NullLiteral (source_reference);
		callback_param.initializer.target_type = callback_type.copy ();
		callback_param.set_attribute_double ("CCode", "pos", -1);
		callback_param.set_attribute_double ("CCode", "delegate_target_pos", -0.9);
		scope.add (null, callback_param);
		async_begin_parameters.add (callback_param);

		if (ellipsis != null) {
			async_begin_parameters.add (ellipsis);
		}

		return async_begin_parameters;
	}

	public unowned List<Parameter> get_async_end_parameters () {
		assert (this.coroutine);

		if (async_end_parameters != null) {
			return async_end_parameters;
		}

		async_end_parameters = new ArrayList<Parameter> ();

		var glib_ns = CodeContext.get ().root.scope.lookup ("GLib");
		var result_type = new ObjectType ((ObjectTypeSymbol) glib_ns.scope.lookup ("AsyncResult"));

		var result_param = new Parameter ("_res_", result_type, source_reference);
		result_param.set_attribute_double ("CCode", "pos", get_attribute_double ("CCode", "async_result_pos", 0.1));
		scope.add (null, result_param);
		async_end_parameters.add (result_param);

		foreach (var param in parameters) {
			if (param.direction == ParameterDirection.OUT) {
				async_end_parameters.add (param);
			}
		}

		return async_end_parameters;
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
		if (result_var != null) {
			collection.add (result_var);
		}
		if (params_array_var != null) {
			collection.add (params_array_var);
		}

		// capturing variables is only supported if they are initialized
		// therefore assume that captured variables are initialized
		if (closure) {
			get_captured_variables ((Collection<LocalVariable>) collection);
		}
	}

	public int get_format_arg_index () {
		for (int i = 0; i < parameters.size; i++) {
			if (parameters[i].format_arg) {
				return i;
			}
		}
		return -1;
	}

	public bool has_error_type_parameter () {
		if (tree_can_fail) {
			return true;
		}
		if (base_method != null && base_method != this && base_method.has_error_type_parameter ()) {
			return true;
		}
		if (base_interface_method != null && base_interface_method != this && base_interface_method.has_error_type_parameter ()) {
			return true;
		}
		return false;
	}
}

// vim:sw=8 noet
