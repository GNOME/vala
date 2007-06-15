/* valamethod.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;

/**
 * Represents a type or namespace method.
 */
public class Vala.Method : Member, Invokable {
	/**
	 * The symbol name of this method.
	 */
	public string name { get; set; }

	/**
	 * The return type of this method.
	 */
	public TypeReference return_type { get; set; }
	
	public Block body { get; set; }
	
	/**
	 * Specifies the accessibility of this method. Public accessibility
	 * doesn't limit access. Default accessibility limits access to this
	 * program or library. Private accessibility limits access to instances
	 * of the contained type.
	 */
	public MemberAccessibility access;
	
	/**
	 * Specifies whether this method may only be called with an instance of
	 * the contained type.
	 */
	public bool instance {
		get {
			return _instance;
		}
		set {
			_instance = value;
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
	 * Specifies whether the C method returns a new instance pointer which
	 * may be different from the previous instance pointer. Only valid for
	 * imported methods.
	 */
	public bool returns_modified_pointer { get; set; }
	
	/**
	 * Specifies whether the instance pointer should be passed as the first
	 * or as the last argument in C code. Defaults to first.
	 */
	public bool instance_last { get; set; }
	
	/**
	 * Specifies whether the instance of a value type should be passed by
	 * reference. Only valid for instance methods of value types.
	 */
	public bool instance_by_reference { get; set; }
	
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

	private bool _instance = true;
	private List<FormalParameter> parameters;
	private string cname;
	private bool _no_array_length;
	
	/**
	 * Creates a new method.
	 *
	 * @param name        method name
	 * @param return_type method return type
	 * @param source      reference to source code
	 * @return            newly created method
	 */
	public Method (string _name, TypeReference _return_type, SourceReference source = null) {
		name = _name;
		return_type = _return_type;
		source_reference = source;
	}
	
	/**
	 * Appends parameter to this method.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (FormalParameter! param) {
		if (no_array_length) {
			param.no_array_length = true;
		}
		
		parameters.append (param);
	}
	
	public ref List<weak FormalParameter> get_parameters () {
		return parameters.copy ();
	}
	
	public TypeReference get_return_type () {
		return return_type;
	}

	public bool is_invokable () {
		return true;
	}

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_method (this);
	}

	public override void accept_children (CodeVisitor! visitor) {
		if (return_type != null) {
			return_type.accept (visitor);
		}
		
		foreach (FormalParameter param in parameters) {
			param.accept (visitor);
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
	public string! get_cname () {
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
	public virtual ref string! get_default_cname () {
		var parent = symbol.parent_symbol.node;
		if (parent is DataType) {
			if (name.has_prefix ("_")) {
				return "_%s%s".printf (((DataType) parent).get_lower_case_cprefix (), name.offset (1));
			} else {
				return "%s%s".printf (((DataType) parent).get_lower_case_cprefix (), name);
			}
		} else if (parent is Namespace) {
			return "%s%s".printf (((Namespace) parent).get_lower_case_cprefix (), name);
		} else {
			return name;
		}
	}

	/**
	 * Returns the implementation name of this data type as it is used in C
	 * code.
	 *
	 * @return the name to be used in C code
	 */
	public ref string! get_real_cname () {
		if (base_method != null || base_interface_method != null) {
			var parent = (Class) symbol.parent_symbol.node;
			return "%s_real_%s".printf (parent.get_lower_case_cname (null), name);
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
			} else if (a.name == "InstanceLast") {
				instance_last = true;
			} else if (a.name == "InstanceByReference") {
				instance_by_reference = true;
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
	 * Checks whether the arguments and return type of the specified method
	 * matches this method.
	 *
	 * @param m a method
	 * @return  true if the specified method is compatible to this method
	 */
	public bool equals (Method! m2) {
		if (!m2.return_type.equals (return_type)) {
			return false;
		}
		
		var method_params = m2.get_parameters ();
		weak List<weak FormalParameter> method_params_it = method_params;
		foreach (FormalParameter param in parameters) {
			/* method may not expect less arguments */
			if (method_params_it == null) {
				return false;
			}
			
			var method_param = (FormalParameter) method_params_it.data;
			if (!method_param.type_reference.equals (param.type_reference)) {
				return false;
			}
			
			method_params_it = method_params_it.next;
		}
		
		/* method may not expect more arguments */
		if (method_params_it != null) {
			return false;
		}
		
		return true;
	}
}
