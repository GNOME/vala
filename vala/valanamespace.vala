/* valanamespace.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
 */

using GLib;
using Gee;

/**
 * Represents a namespace declaration in the source code.
 */
public class Vala.Namespace : Symbol {
	private Gee.List<Class> classes = new ArrayList<Class> ();
	private Gee.List<Interface> interfaces = new ArrayList<Interface> ();
	private Gee.List<Struct> structs = new ArrayList<Struct> ();
	private Gee.List<Enum> enums = new ArrayList<Enum> ();
	private Gee.List<ErrorDomain> error_domains = new ArrayList<ErrorDomain> ();
	private Gee.List<Delegate> delegates = new ArrayList<Delegate> ();
	private Gee.List<Constant> constants = new ArrayList<Constant> ();
	private Gee.List<Field> fields = new ArrayList<Field> ();
	private Gee.List<Method> methods = new ArrayList<Method> ();

	private Gee.List<string> cprefixes = new ArrayList<string> ();
	private string lower_case_cprefix;
	
	private Gee.List<string> cheader_filenames = new ArrayList<string> ();

	private Gee.List<Namespace> namespaces = new ArrayList<Namespace> ();

	/**
	 * Creates a new namespace.
	 *
	 * @param name             namespace name
	 * @param source_reference reference to source code
	 * @return                 newly created namespace
	 */
	public Namespace (string? name, SourceReference? source_reference = null) {
		base.init ();
		this.source_reference = source_reference;
		this.name = name;
		access = SymbolAccessibility.PUBLIC;
	}
	
	/**
	 * Adds the specified namespace to this source file.
	 *
	 * @param ns a namespace
	 */
	public void add_namespace (Namespace ns) {
		if (scope.lookup (ns.name) is Namespace) {
			// merge if namespace already exists
			var old_ns = (Namespace) scope.lookup (ns.name);
			if (old_ns.external_package && !ns.external_package) {
				old_ns.source_reference = ns.source_reference;
			}
			foreach (Namespace sub_ns in ns.get_namespaces ()) {
				old_ns.add_namespace (sub_ns);
			}
			foreach (Class cl in ns.get_classes ()) {
				old_ns.add_class (cl);
			}
			foreach (Struct st in ns.get_structs ()) {
				old_ns.add_struct (st);
			}
			foreach (Interface iface in ns.get_interfaces ()) {
				old_ns.add_interface (iface);
			}
			foreach (Delegate d in ns.get_delegates ()) {
				old_ns.add_delegate (d);
			}
			foreach (Enum en in ns.get_enums ()) {
				old_ns.add_enum (en);
			}
			foreach (ErrorDomain ed in ns.get_error_types ()) {
				old_ns.add_error_domain (ed);
			}
			foreach (Constant c in ns.get_constants ()) {
				old_ns.add_constant (c);
			}
			foreach (Field f in ns.get_fields ()) {
				old_ns.add_field (f);
			}
			foreach (Method m in ns.get_methods ()) {
				old_ns.add_method (m);
			}
		} else {
			namespaces.add (ns);
			scope.add (ns.name, ns);
		}
	}
	
	/**
	 * Returns a copy of the list of namespaces.
	 *
	 * @return namespace list
	 */
	public Gee.List<Namespace> get_namespaces () {
		return new ReadOnlyList<Namespace> (namespaces);
	}
	
	/**
	 * Adds the specified class to this namespace.
	 *
	 * @param cl a class
	 */
	public void add_class (Class cl) {
		if (scope.lookup (cl.name) is Class) {
			// merge
			var old_class = (Class) scope.lookup (cl.name);
			foreach (DataType base_type in cl.get_base_types ()) {
				old_class.add_base_type (base_type);
			}
			foreach (Field f in cl.get_fields ()) {
				old_class.add_field (f);
			}
			foreach (Method m in cl.get_methods ()) {
				if (m == cl.default_construction_method && old_class.default_construction_method != null) {
					// ignore secondary default creation method
					continue;
				}
				old_class.add_method (m);
			}
			if (cl.constructor != null) {
				old_class.constructor = cl.constructor;
			}
			cl.source_reference.file.remove_node (cl);
		} else {
			classes.add (cl);
			scope.add (cl.name, cl);
		}
	}

	/**
	 * Adds the specified interface to this namespace.
	 *
	 * @param iface an interface
	 */
	public void add_interface (Interface iface) {
		interfaces.add (iface);
		scope.add (iface.name, iface);
	}
	
	/**
	 * Adds the specified struct to this namespace.
	 *
	 * @param st a struct
	 */
	public void add_struct (Struct st) {
		structs.add (st);
		scope.add (st.name, st);
	}
			
	/**
	 * Adds the specified enum to this namespace.
	 *
	 * @param en an enum
	 */
	public void add_enum (Enum en) {
		enums.add (en);
		scope.add (en.name, en);
	}

	/**
	 * Adds the specified error domain to this namespace.
	 *
	 * @param edomain an error domain
	 */
	public void add_error_domain (ErrorDomain edomain) {
		error_domains.add (edomain);
		scope.add (edomain.name, edomain);
	}

	/**
	 * Adds the specified delegate to this namespace.
	 *
	 * @param d a delegate
	 */
	public void add_delegate (Delegate d) {
		delegates.add (d);
		scope.add (d.name, d);
	}

	/**
	 * Returns a copy of the list of structs.
	 *
	 * @return struct list
	 */
	public Gee.List<Struct> get_structs () {
		return new ReadOnlyList<Struct> (structs);
	}

	/**
	 * Returns a copy of the list of classes.
	 *
	 * @return class list
	 */
	public Gee.List<Class> get_classes () {
		return new ReadOnlyList<Class> (classes);
	}
	
	/**
	 * Returns a copy of the list of interfaces.
	 *
	 * @return interface list
	 */
	public Gee.List<Interface> get_interfaces () {
		return new ReadOnlyList<Interface> (interfaces);
	}
	
	/**
	 * Returns a copy of the list of enums.
	 *
	 * @return enum list
	 */
	public Gee.List<Enum> get_enums () {
		return new ReadOnlyList<Enum> (enums);
	}
	
	/**
	 * Returns a copy of the list of error domains.
	 *
	 * @return error domain list
	 */
	public Gee.List<ErrorDomain> get_error_types () {
		return new ReadOnlyList<ErrorDomain> (error_domains);
	}
	
	/**
	 * Returns a copy of the list of fields.
	 *
	 * @return field list
	 */
	public Gee.List<Field> get_fields () {
		return new ReadOnlyList<Field> (fields);
	}
	
	/**
	 * Returns a copy of the list of constants.
	 *
	 * @return constant list
	 */
	public Gee.List<Constant> get_constants () {
		return new ReadOnlyList<Constant> (constants);
	}
	
	/**
	 * Returns a copy of the list of delegates.
	 *
	 * @return delegate list
	 */
	public Gee.List<Delegate> get_delegates () {
		return new ReadOnlyList<Delegate> (delegates);
	}
	
	/**
	 * Returns a copy of the list of methods.
	 *
	 * @return method list
	 */
	public Gee.List<Method> get_methods () {
		return new ReadOnlyList<Method> (methods);
	}
	
	/**
	 * Adds the specified constant to this namespace.
	 *
	 * @param constant a constant
	 */
	public void add_constant (Constant constant) {
		constants.add (constant);
		scope.add (constant.name, constant);
	}
	
	/**
	 * Adds the specified field to this namespace.
	 *
	 * @param f a field
	 */
	public void add_field (Field f) {
		if (f.binding == MemberBinding.INSTANCE) {
			Report.error (f.source_reference, "instance members are not allowed outside of data types");
			f.error = true;
			return;
		} else if (f.binding == MemberBinding.CLASS) {
			Report.error (f.source_reference, "class members are not allowed outside of classes");
			f.error = true;
			return;
		}

		fields.add (f);
		scope.add (f.name, f);
	}
	
	/**
	 * Adds the specified method to this namespace.
	 *
	 * @param m a method
	 */
	public void add_method (Method m) {
		if (m is CreationMethod) {
			Report.error (m.source_reference, "construction methods may only be declared within classes and structs");
			m.error = true;
			return;
		}
		if (m.binding == MemberBinding.INSTANCE) {
			Report.error (m.source_reference, "instance members are not allowed outside of data types");
			m.error = true;
			return;
		} else if (m.binding == MemberBinding.CLASS) {
			Report.error (m.source_reference, "class members are not allowed outside of classes");
			m.error = true;
			return;
		}

		methods.add (m);
		scope.add (m.name, m);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_namespace (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (Namespace ns in namespaces) {
			ns.accept (visitor);
		}

		/* process enums first to avoid order problems in C code */
		foreach (Enum en in enums) {
			en.accept (visitor);
		}

		foreach (ErrorDomain edomain in error_domains) {
			edomain.accept (visitor);
		}

		foreach (Class cl in classes) {
			cl.accept (visitor);
		}

		foreach (Interface iface in interfaces) {
			iface.accept (visitor);
		}

		foreach (Struct st in structs) {
			st.accept (visitor);
		}

		foreach (Delegate d in delegates) {
			d.accept (visitor);
		}

		foreach (Constant c in constants) {
			c.accept (visitor);
		}

		foreach (Field f in fields) {
			f.accept (visitor);
		}

		foreach (Method m in methods) {
			m.accept (visitor);
		}
	}
	
	public override string get_cprefix () {
		if (cprefixes.size > 0) {
			return cprefixes[0];
		} else if (null != name) {
			string parent_prefix;
			if (parent_symbol == null) {
				parent_prefix = "";
			} else {
				parent_prefix = parent_symbol.get_cprefix ();
			}
			return parent_prefix + name;
		} else {
			return "";
		}
	}

	public Gee.List<string> get_cprefixes () {
		if (0 == cprefixes.size && null != name)
			cprefixes.add (name);

		return cprefixes;
	}

	/**
	 * Adds a camel case string to be prepended to the name of members of
	 * this namespace when used in C code.
	 *
	 * @param cprefixes the camel case prefixes used in C code
	 */
	public void add_cprefix (string cprefix) {
		return_if_fail (cprefix.len() >= 1);
		cprefixes.add (cprefix);
	}

	/**
	 * Returns the lower case string to be prepended to the name of members
	 * of this namespace when used in C code.
	 *
	 * @return the lower case prefix to be used in C code
	 */
	public override string get_lower_case_cprefix () {
		if (lower_case_cprefix == null) {
			if (name == null) {
				lower_case_cprefix = "";
			} else {
				string parent_prefix;
				if (parent_symbol == null) {
					parent_prefix = "";
				} else {
					parent_prefix = parent_symbol.get_lower_case_cprefix ();
				}
				lower_case_cprefix = "%s%s_".printf (parent_prefix, camel_case_to_lower_case (name));
			}
		}
		return lower_case_cprefix;
	}

	/**
	 * Sets the lower case string to be prepended to the name of members of
	 * this namespace when used in C code.
	 *
	 * @param cprefix the lower case prefix to be used in C code
	 */
	public void set_lower_case_cprefix (string cprefix) {
		this.lower_case_cprefix = cprefix;
	}

	public override Gee.List<string> get_cheader_filenames () {
		return new ReadOnlyList<string> (cheader_filenames);
	}
	
	/**
	 * Returns the C header filename of this namespace.
	 *
	 * @return header filename
	 */
	public string get_cheader_filename () {
		var s = new StringBuilder ();
		bool first = true;
		foreach (string cheader_filename in get_cheader_filenames ()) {
			if (first) {
				first = false;
			} else {
				s.append_c (',');
			}
			s.append (cheader_filename);
		}
		return s.str;
	}
	
	/**
	 * Sets the C header filename of this namespace to the specified
	 * filename.
	 *
	 * @param cheader_filename header filename
	 */
	public void set_cheader_filename (string cheader_filename) {
		cheader_filenames = new ArrayList<string> ();
		cheader_filenames.add (cheader_filename);
	}
	
	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("cprefix")) {
			foreach (string name in a.get_string ("cprefix").split (","))
				add_cprefix (name);
		}
		if (a.has_argument ("lower_case_cprefix")) {
			set_lower_case_cprefix (a.get_string ("lower_case_cprefix"));
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				cheader_filenames.add (filename);
			}
		}
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			}
		}
	}
}
