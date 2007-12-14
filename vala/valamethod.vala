/* valamethod.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
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
	
	public Block body { get; set; }
	
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
	 * The name of the vfunc of this method as it is used in C code.
	 */
	public string! vfunc_name {
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
	public string! sentinel {
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
	 * Specifies whether the instance pointer should be passed as the first
	 * or as the last argument in C code. Defaults to first.
	 */
	public bool instance_last { get; set; }

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
	private Gee.List<FormalParameter> parameters = new ArrayList<FormalParameter> ();
	private string cname;
	private string _vfunc_name;
	private string _sentinel;
	private bool _no_array_length;
	private Gee.List<DataType> error_domains = new ArrayList<DataType> ();
	private DataType _return_type;

	/**
	 * Creates a new method.
	 *
	 * @param name        method name
	 * @param return_type method return type
	 * @param source      reference to source code
	 * @return            newly created method
	 */
	public Method (construct string name, construct DataType return_type, construct SourceReference source_reference = null) {
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
		
		parameters.add (param);
		if (!param.ellipsis) {
			scope.add (param.name, param);
		}
	}
	
	public Collection<FormalParameter> get_parameters () {
		return new ReadOnlyCollection<FormalParameter> (parameters);
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

		foreach (DataType error_domain in error_domains) {
			error_domain.accept (visitor);
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
	public virtual string! get_default_cname () {
		if (name.has_prefix ("_")) {
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
	public string! get_real_cname () {
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
			} else if (a.name == "FloatingReference") {
				return_type.floating_reference = true;
			} else if (a.name == "NoArrayLength") {
				no_array_length = true;
			} else if (a.name == "PrintfFormat") {
				printf_format = true;
			} else if (a.name == "Import") {
				is_imported = true;
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
		
		Iterator<FormalParameter> method_params_it = m2.get_parameters ().iterator ();
		foreach (FormalParameter param in parameters) {
			/* method may not expect less arguments */
			if (!method_params_it.next ()) {
				return false;
			}
			
			if (!method_params_it.get ().type_reference.equals (param.type_reference)) {
				return false;
			}
		}
		
		/* method may not expect more arguments */
		if (method_params_it.next ()) {
			return false;
		}

		Iterator<DataType> method_error_domains_it = m2.get_error_domains ().iterator ();
		foreach (DataType error_domain in error_domains) {
			/* method may not have less error domains */
			if (!method_error_domains_it.next ()) {
				return false;
			}

			if (!method_error_domains_it.get ().equals (error_domain)) {
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
	public void add_error_domain (DataType! error_domain) {
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

	public override void replace_type (DataType! old_type, DataType! new_type) {
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
}
