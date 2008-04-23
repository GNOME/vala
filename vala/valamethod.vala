/* valamethod.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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
	 * Reference must be weak as virtual methods set base_method to
	 * themselves.
	 */
	public weak Method base_method { get; set; }
	
	/**
	 * Specifies the abstract interface method this method implements.
	 */
	public Method base_interface_method { get; set; }
	
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
	 * Specifies whether the array length should implicitly be passed
	 * if the parameter type is an array.
	 */
	public bool no_array_length {
		get {
			return _no_array_length;
		}
		set {
			_no_array_length = value;
			foreach (FormalParameter param in parameters) {
				param.no_array_length = value;
			}
		}
	}

	/**
	 * Specifies whether this method expects printf-style format arguments.
	 */
	public bool printf_format { get; set; }

	private Gee.List<FormalParameter> parameters = new ArrayList<FormalParameter> ();
	private string cname;
	private string _vfunc_name;
	private string _sentinel;
	private bool _no_array_length;
	private Gee.List<DataType> error_domains = new ArrayList<DataType> ();
	private Gee.List<Expression> preconditions = new ArrayList<Expression> ();
	private Gee.List<Expression> postconditions = new ArrayList<Expression> ();
	private DataType _return_type;
	private Block _body;

	/**
	 * Creates a new method.
	 *
	 * @param name        method name
	 * @param return_type method return type
	 * @param source      reference to source code
	 * @return            newly created method
	 */
	public Method (string name, DataType return_type, SourceReference? source_reference = null) {
		this.return_type = return_type;
		this.source_reference = source_reference;
		this.name = name;
	}

	construct {
		carray_length_parameter_position = -3;
		cdelegate_target_parameter_position = -3;
	}

	/**
	 * Appends parameter to this method.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (FormalParameter param) {
		if (no_array_length) {
			param.no_array_length = true;
		}
		// default C parameter position
		param.cparameter_position = parameters.size + 1;
		param.carray_length_parameter_position = param.cparameter_position + 0.1;
		param.cdelegate_target_parameter_position = param.cparameter_position + 0.1;

		parameters.add (param);
		if (!param.ellipsis) {
			scope.add (param.name, param);
		}
	}
	
	public Collection<FormalParameter> get_parameters () {
		return new ReadOnlyCollection<FormalParameter> (parameters);
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

		foreach (DataType error_domain in error_domains) {
			error_domain.accept (visitor);
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
	public string get_real_cname () {
		if (base_method != null || base_interface_method != null) {
			return "%s_real_%s".printf (parent_symbol.get_lower_case_cname (null), name);
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
		if (a.has_argument ("array_length_pos")) {
			carray_length_parameter_position = a.get_double ("array_length_pos");
		}
		if (a.has_argument ("delegate_target_pos")) {
			cdelegate_target_parameter_position = a.get_double ("delegate_target_pos");
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
			} else if (a.name == "NoArrayLength") {
				no_array_length = true;
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
		if (!return_type.equals (base_method.return_type)) {
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
			
			if (!base_param.type_reference.equals (method_params_it.get ().type_reference)) {
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
		foreach (DataType method_error_domain in error_domains) {
			bool match = false;
			foreach (DataType base_method_error_domain in base_method.error_domains) {
				if (method_error_domain.compatible (base_method_error_domain)) {
					match = true;
					break;
				}
			}

			if (!match) {
				invalid_match = "incompatible error domain `%s'".printf (method_error_domain.to_string ());
				return false;
			}
		}

		return true;
	}

	/**
	 * Adds an error domain to this method.
	 *
	 * @param error_domain an error domain
	 */
	public void add_error_domain (DataType error_domain) {
		error_domains.add (error_domain);
		error_domain.parent_node = this;
	}

	/**
	 * Returns a copy of the list of error domains of this method.
	 *
	 * @return list of error domains
	 */
	public Collection<DataType> get_error_domains () {
		return new ReadOnlyCollection<DataType> (error_domains);
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
	public Collection<Expression> get_preconditions () {
		return new ReadOnlyCollection<Expression> (preconditions);
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
	public Collection<Expression> get_postconditions () {
		return new ReadOnlyCollection<Expression> (postconditions);
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (return_type == old_type) {
			return_type = new_type;
			return;
		}
		for (int i = 0; i < error_domains.size; i++) {
			if (error_domains[i] == old_type) {
				error_domains[i] = new_type;
				return;
			}
		}
	}

	public override CodeBinding? create_code_binding (CodeGenerator codegen) {
		return codegen.create_method_binding (this);
	}
}
