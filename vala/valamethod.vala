/* valamethod.vala
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;
using Gee;

/**
 * Represents a type or namespace method.
 */
public class Vala.Method : Member {
	public const string DEFAULT_SENTINEL = "NULL";

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
	
	public Block body {
		get { return _body; }
		set {
			_body = value;
			if (_body != null) {
				_body.owner = scope;
			}
		}
	}

	public BasicBlock entry_block { get; set; }

	public BasicBlock exit_block { get; set; }

	/**
	 * Specifies whether this method may only be called with an instance of
	 * the contained type.
	 */
	public MemberBinding binding { get; set; default = MemberBinding.INSTANCE; }

	/**
	 * The name of the vfunc of this method as it is used in C code.
	 */
	public string vfunc_name {
		get {
			if (_vfunc_name == null) {
				_vfunc_name = this.name;
			}
			return _vfunc_name;
		}
		set {
			_vfunc_name = value;
		}
	}

	/**
	 * The sentinel to use for terminating variable length argument lists.
	 */
	public string sentinel {
		get {
			if (_sentinel == null) {
				return DEFAULT_SENTINEL;
			}

			return _sentinel;
		}

		set {
			_sentinel = value;
		}
	}
	
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

	/**
	 * Specifies whether the C method returns a new instance pointer which
	 * may be different from the previous instance pointer. Only valid for
	 * imported methods.
	 */
	public bool returns_modified_pointer { get; set; }

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
	 * Specifies the generated `this' parameter for instance methods.
	 */
	public FormalParameter this_parameter { get; set; }

	/**
	 * Specifies the generated `result' variable for postconditions.
	 */
	public LocalVariable result_var { get; set; }

	/**
	 * Specifies the position of the instance parameter in the C function.
	 */
	public double cinstance_parameter_position { get; set; }

	/**
	 * Specifies the position of the array length out parameter in the C
	 * function.
	 */
	public double carray_length_parameter_position { get; set; }

	/**
	 * Specifies the position of the delegate target out parameter in the C
	 * function.
	 */
	public double cdelegate_target_parameter_position { get; set; }

	/**
	 * Specifies whether the array length should be returned implicitly
	 * if the return type is an array.
	 */
	public bool no_array_length { get; set; }

	/**
	 * Specifies whether this method expects printf-style format arguments.
	 */
	public bool printf_format { get; set; }

	/**
	 * Specifies whether a construct function with a GType parameter is
	 * available. This is only applicable to creation methods.
	 */
	public bool has_construct_function { get; set; default = true; }

	public bool coroutine { get; set; }

	private Gee.List<FormalParameter> parameters = new ArrayList<FormalParameter> ();
	private string cname;
	private string _vfunc_name;
	private string _sentinel;
	private Gee.List<Expression> preconditions = new ArrayList<Expression> ();
	private Gee.List<Expression> postconditions = new ArrayList<Expression> ();
	private DataType _return_type;
	private Block _body;

	private weak Method _base_method;
	private Method _base_interface_method;
	private bool base_methods_valid;

	/**
	 * Creates a new method.
	 *
	 * @param name        method name
	 * @param return_type method return type
	 * @param source      reference to source code
	 * @return            newly created method
	 */
	public Method (string? name, DataType return_type, SourceReference? source_reference = null) {
		base (name, source_reference);
		this.return_type = return_type;

		carray_length_parameter_position = -3;
		cdelegate_target_parameter_position = -3;
	}

	/**
	 * Appends parameter to this method.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (FormalParameter param) {
		// default C parameter position
		param.cparameter_position = parameters.size + 1;
		param.carray_length_parameter_position = param.cparameter_position + 0.1;
		param.cdelegate_target_parameter_position = param.cparameter_position + 0.1;

		parameters.add (param);
		if (!param.ellipsis) {
			scope.add (param.name, param);
		}
	}
	
	public Gee.List<FormalParameter> get_parameters () {
		return new ReadOnlyList<FormalParameter> (parameters);
	}

	/**
	 * Remove all parameters from this method.
	 */
	public void clear_parameters () {
		foreach (FormalParameter param in parameters) {
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
		if (return_type != null) {
			return_type.accept (visitor);
		}

		foreach (FormalParameter param in parameters) {
			param.accept (visitor);
		}

		foreach (DataType error_type in get_error_types ()) {
			error_type.accept (visitor);
		}

		if (result_var != null) {
			result_var.variable_type.accept (visitor);
		}

		foreach (Expression precondition in preconditions) {
			precondition.accept (visitor);
		}

		foreach (Expression postcondition in postconditions) {
			postcondition.accept (visitor);
		}

		if (body != null) {
			body.accept (visitor);
		}
	}

	/**
	 * Returns the interface name of this method as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public string get_cname () {
		if (cname == null) {
			cname = get_default_cname ();
		}
		return cname;
	}

	/**
	 * Returns the default interface name of this method as it is used in C
	 * code.
	 *
	 * @return the name to be used in C code by default
	 */
	public virtual string get_default_cname () {
		if (name == "main" && parent_symbol.name == null) {
			// avoid conflict with generated main function
			return "_main";
		} else if (name.has_prefix ("_")) {
			return "_%s%s".printf (parent_symbol.get_lower_case_cprefix (), name.offset (1));
		} else {
			return "%s%s".printf (parent_symbol.get_lower_case_cprefix (), name);
		}
	}

	/**
	 * Returns the implementation name of this data type as it is used in C
	 * code.
	 *
	 * @return the name to be used in C code
	 */
	public virtual string get_real_cname () {
		if (base_method != null || base_interface_method != null) {
			return "%sreal_%s".printf (parent_symbol.get_lower_case_cprefix (), name);
		} else {
			return get_cname ();
		}
	}
	
	/**
	 * Sets the name of this method as it is used in C code.
	 *
	 * @param cname the name to be used in C code
	 */
	public void set_cname (string cname) {
		this.cname = cname;
	}
	
	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("cname")) {
			set_cname (a.get_string ("cname"));
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				add_cheader_filename (filename);
			}
		}
		if (a.has_argument ("vfunc_name")) {
			this.vfunc_name = a.get_string ("vfunc_name");
		}
		if (a.has_argument ("sentinel")) {
			this.sentinel = a.get_string ("sentinel");
		}
		if (a.has_argument ("instance_pos")) {
			cinstance_parameter_position = a.get_double ("instance_pos");
		}
		if (a.has_argument ("array_length")) {
			no_array_length = !a.get_bool ("array_length");
		}
		if (a.has_argument ("array_length_pos")) {
			carray_length_parameter_position = a.get_double ("array_length_pos");
		}
		if (a.has_argument ("delegate_target_pos")) {
			cdelegate_target_parameter_position = a.get_double ("delegate_target_pos");
		}
		if (a.has_argument ("has_construct_function")) {
			has_construct_function = a.get_bool ("has_construct_function");
		}
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			} else if (a.name == "ReturnsModifiedPointer") {
				returns_modified_pointer = true;
			} else if (a.name == "FloatingReference") {
				return_type.floating_reference = true;
			} else if (a.name == "PrintfFormat") {
				printf_format = true;
			}
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
		ObjectType object_type = null;
		if (parent_symbol is ObjectTypeSymbol) {
			object_type = new ObjectType ((ObjectTypeSymbol) parent_symbol);
			foreach (TypeParameter type_parameter in object_type.type_symbol.get_type_parameters ()) {
				var type_arg = new GenericType (type_parameter);
				type_arg.value_owned = true;
				object_type.add_type_argument (type_arg);
			}
		}

		var actual_base_type = base_method.return_type.get_actual_type (object_type, this);
		if (!return_type.equals (actual_base_type)) {
			invalid_match = "incompatible return type";
			return false;
		}
		
		Iterator<FormalParameter> method_params_it = parameters.iterator ();
		int param_index = 1;
		foreach (FormalParameter base_param in base_method.parameters) {
			/* this method may not expect less arguments */
			if (!method_params_it.next ()) {
				invalid_match = "too few parameters";
				return false;
			}
			
			actual_base_type = base_param.parameter_type.get_actual_type (object_type, this);
			if (!actual_base_type.equals (method_params_it.get ().parameter_type)) {
				invalid_match = "incompatible type of parameter %d".printf (param_index);
				return false;
			}
			param_index++;
		}
		
		/* this method may not expect more arguments */
		if (method_params_it.next ()) {
			invalid_match = "too many parameters";
			return false;
		}

		/* this method may throw more but not less errors than the base method */
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

		return true;
	}

	/**
	 * Adds a precondition to this method.
	 *
	 * @param precondition a boolean precondition expression
	 */
	public void add_precondition (Expression precondition) {
		preconditions.add (precondition);
		precondition.parent_node = this;
	}

	/**
	 * Returns a copy of the list of preconditions of this method.
	 *
	 * @return list of preconditions
	 */
	public Gee.List<Expression> get_preconditions () {
		return new ReadOnlyList<Expression> (preconditions);
	}

	/**
	 * Adds a postcondition to this method.
	 *
	 * @param postcondition a boolean postcondition expression
	 */
	public void add_postcondition (Expression postcondition) {
		postconditions.add (postcondition);
		postcondition.parent_node = this;
	}

	/**
	 * Returns a copy of the list of postconditions of this method.
	 *
	 * @return list of postconditions
	 */
	public Gee.List<Expression> get_postconditions () {
		return new ReadOnlyList<Expression> (postconditions);
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
			/* VAPI classes don't specify overridden methods */
			if (!parent_symbol.external_package) {
				if (!(this is CreationMethod)) {
					find_base_interface_method ((Class) parent_symbol);
					if (is_virtual || is_abstract || overrides) {
						find_base_class_method ((Class) parent_symbol);
					}
				}
			} else if (is_virtual || is_abstract) {
				_base_method = this;
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
		} else if (sym is Signal) {
			var sig = (Signal) sym;
			if (sig.is_virtual) {
				var base_method = sig.get_method_handler ();
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

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		process_attributes ();

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
		}

		if (is_abstract && body != null) {
			Report.error (source_reference, "Abstract methods cannot have bodies");
		} else if (external && body != null) {
			Report.error (source_reference, "Extern methods cannot have bodies");
		} else if (!is_abstract && !external && !external_package && body == null) {
			Report.error (source_reference, "Non-abstract, non-extern methods must have bodies");
		}

		var old_source_file = analyzer.current_source_file;
		var old_symbol = analyzer.current_symbol;
		var old_class = analyzer.current_class;
		var old_struct = analyzer.current_struct;
		var old_return_type = analyzer.current_return_type;

		if (source_reference != null) {
			analyzer.current_source_file = source_reference.file;
		}
		analyzer.current_symbol = this;
		if (parent_symbol is Class) {
			analyzer.current_class = (Class) parent_symbol;
		} else if (parent_symbol is Struct) {
			analyzer.current_struct = (Struct) parent_symbol;
		}
		analyzer.current_return_type = return_type;

		return_type.check (analyzer);

		var init_attr = get_attribute ("ModuleInit");
		if (init_attr != null) {
			source_reference.file.context.module_init_method = this;
		}

		if (!is_internal_symbol ()) {
			if (return_type is ValueType) {
				analyzer.current_source_file.add_type_dependency (return_type, SourceFileDependencyType.HEADER_FULL);
			} else {
				analyzer.current_source_file.add_type_dependency (return_type, SourceFileDependencyType.HEADER_SHALLOW);
			}
		}
		analyzer.current_source_file.add_type_dependency (return_type, SourceFileDependencyType.SOURCE);

		if (return_type != null) {
			return_type.check (analyzer);
		}

		foreach (FormalParameter param in parameters) {
			param.check (analyzer);
		}

		foreach (DataType error_type in get_error_types ()) {
			error_type.check (analyzer);
		}

		if (result_var != null) {
			result_var.variable_type.check (analyzer);
		}

		foreach (Expression precondition in preconditions) {
			precondition.check (analyzer);
		}

		foreach (Expression postcondition in postconditions) {
			postcondition.check (analyzer);
		}

		if (body != null) {
			body.check (analyzer);
		}

		analyzer.current_source_file = old_source_file;
		analyzer.current_symbol = old_symbol;
		analyzer.current_class = old_class;
		analyzer.current_struct = old_struct;
		analyzer.current_return_type = old_return_type;

		if (analyzer.current_symbol.parent_symbol is Method) {
			/* lambda expressions produce nested methods */
			var up_method = (Method) analyzer.current_symbol.parent_symbol;
			analyzer.current_return_type = up_method.return_type;
		}

		if (analyzer.current_symbol is Struct) {
			if (is_abstract || is_virtual || overrides) {
				Report.error (source_reference, "A struct member `%s' cannot be marked as override, virtual, or abstract".printf (get_full_name ()));
				return false;
			}
		} else if (overrides && base_method == null) {
			Report.error (source_reference, "%s: no suitable method found to override".printf (get_full_name ()));
		}

		// check whether return type is at least as accessible as the method
		if (!analyzer.is_type_accessible (this, return_type)) {
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

			if (!precondition.value_type.compatible (analyzer.bool_type)) {
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

			if (!postcondition.value_type.compatible (analyzer.bool_type)) {
				error = true;
				Report.error (postcondition.source_reference, "Postcondition must be boolean");
				return false;
			}
		}

		if (tree_can_fail && name == "main") {
			Report.error (source_reference, "\"main\" method cannot throw errors");
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
				if (!can_propagate_error) {
					Report.warning (body_error_type.source_reference, "unhandled error `%s'".printf (body_error_type.to_string()));
				}
			}
		}

		if (is_possible_entry_point (analyzer)) {
			entry_point = true;
		}

		return !error;
	}

	bool is_possible_entry_point (SemanticAnalyzer analyzer) {
		if (name == null || name != "main") {
			// method must be called "main"
			return false;
		}
		
		if (binding == MemberBinding.INSTANCE) {
			// method must be static
			return false;
		}
		
		if (return_type is VoidType) {
		} else if (return_type.data_type == analyzer.int_type.data_type) {
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
		
		Iterator<FormalParameter> params_it = params.iterator ();
		params_it.next ();
		var param = params_it.get ();

		if (param.direction == ParameterDirection.OUT) {
			// parameter must not be an out parameter
			return false;
		}
		
		if (!(param.parameter_type is ArrayType)) {
			// parameter must be an array
			return false;
		}
		
		var array_type = (ArrayType) param.parameter_type;
		if (array_type.element_type.data_type != analyzer.string_type.data_type) {
			// parameter must be an array of strings
			return false;
		}
		
		return true;
	}
}
