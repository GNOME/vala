/* valanamespace.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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

/**
 * Represents a namespace declaration in the source code.
 */
public class Vala.Namespace : Symbol {
	private List<Class> classes = new ArrayList<Class> ();
	private List<Interface> interfaces = new ArrayList<Interface> ();
	private List<Struct> structs = new ArrayList<Struct> ();
	private List<Enum> enums = new ArrayList<Enum> ();
	private List<ErrorDomain> error_domains = new ArrayList<ErrorDomain> ();
	private List<Delegate> delegates = new ArrayList<Delegate> ();
	private List<Constant> constants = new ArrayList<Constant> ();
	private List<Field> fields = new ArrayList<Field> ();
	private List<Method> methods = new ArrayList<Method> ();

	private List<Comment> comments = new ArrayList<Comment> ();

	private List<string> cprefixes = new ArrayList<string> ();
	private string lower_case_cprefix;
	
	private List<Namespace> namespaces = new ArrayList<Namespace> ();

	private List<UsingDirective> using_directives = new ArrayList<UsingDirective> ();

	/**
	 * Creates a new namespace.
	 *
	 * @param name             namespace name
	 * @param source_reference reference to source code
	 * @return                 newly created namespace
	 */
	public Namespace (string? name, SourceReference? source_reference = null) {
		base (name, source_reference);
		access = SymbolAccessibility.PUBLIC;
	}

	/**
	 * Adds a new using directive with the specified namespace.
	 *
	 * @param ns reference to namespace
	 */
	public void add_using_directive (UsingDirective ns) {
		using_directives.add (ns);
	}

	public void add_comment (Comment comment) {
		comments.add (comment);
	}

	/**
	 * Returns a copy of the list of namespaces.
	 *
	 * @return comment list
	 */
	public List<Comment> get_comments () {
		return comments;
	}

	/**
	 * Adds the specified namespace to this source file.
	 *
	 * @param ns a namespace
	 */
	public override void add_namespace (Namespace ns) {
		if (ns.owner == null) {
			ns.source_reference.file.add_node (ns);
		}

		if (scope.lookup (ns.name) is Namespace) {
			// merge if namespace already exists
			var old_ns = (Namespace) scope.lookup (ns.name);
			if (old_ns.external_package && !ns.external_package) {
				old_ns.source_reference = ns.source_reference;
			}

			foreach (var using_directive in ns.using_directives) {
				old_ns.add_using_directive (using_directive);
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
			foreach (ErrorDomain ed in ns.get_error_domains ()) {
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
			foreach (Comment c in ns.get_comments ()) {
				old_ns.add_comment (c);
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
	public List<Namespace> get_namespaces () {
		return namespaces;
	}
	
	/**
	 * Adds the specified class to this namespace.
	 *
	 * @param cl a class
	 */
	public override void add_class (Class cl) {
		// namespaces do not support private memebers
		if (cl.access == SymbolAccessibility.PRIVATE) {
			cl.access = SymbolAccessibility.INTERNAL;
		}

		if (cl.owner == null) {
			cl.source_reference.file.add_node (cl);
		}

		classes.add (cl);
		scope.add (cl.name, cl);
	}

	/**
	 * Adds the specified interface to this namespace.
	 *
	 * @param iface an interface
	 */
	public override void add_interface (Interface iface) {
		// namespaces do not support private memebers
		if (iface.access == SymbolAccessibility.PRIVATE) {
			iface.access = SymbolAccessibility.INTERNAL;
		}

		if (iface.owner == null) {
			iface.source_reference.file.add_node (iface);
		}

		interfaces.add (iface);
		scope.add (iface.name, iface);

	}
	
	/**
	 * Adds the specified struct to this namespace.
	 *
	 * @param st a struct
	 */
	public override void add_struct (Struct st) {
		// namespaces do not support private memebers
		if (st.access == SymbolAccessibility.PRIVATE) {
			st.access = SymbolAccessibility.INTERNAL;
		}

		if (st.owner == null) {
			st.source_reference.file.add_node (st);
		}

		structs.add (st);
		scope.add (st.name, st);
	}
	
	/**
	 * Removes the specified struct from this namespace.
	 *
	 * @param st a struct
	 */
	public void remove_struct (Struct st) {
		structs.remove (st);
		scope.remove (st.name);
	}
			
	/**
	 * Adds the specified enum to this namespace.
	 *
	 * @param en an enum
	 */
	public override void add_enum (Enum en) {
		// namespaces do not support private memebers
		if (en.access == SymbolAccessibility.PRIVATE) {
			en.access = SymbolAccessibility.INTERNAL;
		}

		if (en.owner == null) {
			en.source_reference.file.add_node (en);
		}

		enums.add (en);
		scope.add (en.name, en);
	}

	/**
	 * Adds the specified error domain to this namespace.
	 *
	 * @param edomain an error domain
	 */
	public override void add_error_domain (ErrorDomain edomain) {
		// namespaces do not support private memebers
		if (edomain.access == SymbolAccessibility.PRIVATE) {
			edomain.access = SymbolAccessibility.INTERNAL;
		}

		if (edomain.owner == null) {
			edomain.source_reference.file.add_node (edomain);
		}

		error_domains.add (edomain);
		scope.add (edomain.name, edomain);
	}

	/**
	 * Adds the specified delegate to this namespace.
	 *
	 * @param d a delegate
	 */
	public override void add_delegate (Delegate d) {
		// namespaces do not support private memebers
		if (d.access == SymbolAccessibility.PRIVATE) {
			d.access = SymbolAccessibility.INTERNAL;
		}

		if (d.owner == null) {
			d.source_reference.file.add_node (d);
		}

		delegates.add (d);
		scope.add (d.name, d);
	}

	/**
	 * Returns a copy of the list of structs.
	 *
	 * @return struct list
	 */
	public List<Struct> get_structs () {
		return structs;
	}

	/**
	 * Returns a copy of the list of classes.
	 *
	 * @return class list
	 */
	public List<Class> get_classes () {
		return classes;
	}
	
	/**
	 * Returns a copy of the list of interfaces.
	 *
	 * @return interface list
	 */
	public List<Interface> get_interfaces () {
		return interfaces;
	}
	
	/**
	 * Returns a copy of the list of enums.
	 *
	 * @return enum list
	 */
	public List<Enum> get_enums () {
		return enums;
	}
	
	/**
	 * Returns a copy of the list of error domains.
	 *
	 * @return error domain list
	 */
	public List<ErrorDomain> get_error_domains () {
		return error_domains;
	}
	
	/**
	 * Returns a copy of the list of fields.
	 *
	 * @return field list
	 */
	public List<Field> get_fields () {
		return fields;
	}
	
	/**
	 * Returns a copy of the list of constants.
	 *
	 * @return constant list
	 */
	public List<Constant> get_constants () {
		return constants;
	}
	
	/**
	 * Returns a copy of the list of delegates.
	 *
	 * @return delegate list
	 */
	public List<Delegate> get_delegates () {
		return delegates;
	}
	
	/**
	 * Returns a copy of the list of methods.
	 *
	 * @return method list
	 */
	public List<Method> get_methods () {
		return methods;
	}
	
	/**
	 * Adds the specified constant to this namespace.
	 *
	 * @param constant a constant
	 */
	public override void add_constant (Constant constant) {
		// namespaces do not support private memebers
		if (constant.access == SymbolAccessibility.PRIVATE) {
			constant.access = SymbolAccessibility.INTERNAL;
		}

		if (constant.owner == null) {
			constant.source_reference.file.add_node (constant);
		}

		constants.add (constant);
		scope.add (constant.name, constant);
	}
	
	/**
	 * Adds the specified field to this namespace.
	 *
	 * @param f a field
	 */
	public override void add_field (Field f) {
		if (f.binding == MemberBinding.INSTANCE) {
			// default to static member binding
			f.binding = MemberBinding.STATIC;
		}

		// namespaces do not support private memebers
		if (f.access == SymbolAccessibility.PRIVATE) {
			f.access = SymbolAccessibility.INTERNAL;
		}

		if (f.binding == MemberBinding.INSTANCE) {
			Report.error (f.source_reference, "instance members are not allowed outside of data types");
			f.error = true;
			return;
		} else if (f.binding == MemberBinding.CLASS) {
			Report.error (f.source_reference, "class members are not allowed outside of classes");
			f.error = true;
			return;
		}

		if (f.owner == null) {
			f.source_reference.file.add_node (f);
		}

		fields.add (f);
		scope.add (f.name, f);
	}
	
	/**
	 * Adds the specified method to this namespace.
	 *
	 * @param m a method
	 */
	public override void add_method (Method m) {
		if (m.binding == MemberBinding.INSTANCE) {
			// default to static member binding
			m.binding = MemberBinding.STATIC;
		}

		// namespaces do not support private memebers
		if (m.access == SymbolAccessibility.PRIVATE) {
			m.access = SymbolAccessibility.INTERNAL;
		}

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
		if (!(m.return_type is VoidType) && (CodeContext.get ().profile == Profile.DOVA || m.get_postconditions ().size > 0)) {
			m.result_var = new LocalVariable (m.return_type.copy (), "result", null, source_reference);
			m.result_var.is_result = true;
		}

		if (m.owner == null) {
			m.source_reference.file.add_node (m);
		}

		methods.add (m);
		scope.add (m.name, m);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_namespace (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (UsingDirective ns_ref in using_directives) {
			ns_ref.accept (visitor);
		}

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

	public List<string> get_cprefixes () {
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

	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("cprefix")) {
			string value = a.get_string ("cprefix");
			if (value == "") {
				// split of an empty string returns an empty array
				add_cprefix ("");
			} else {
				foreach (string name in value.split (",")) {
					add_cprefix (name);
				}
			}
		}
		if (a.has_argument ("lower_case_cprefix")) {
			set_lower_case_cprefix (a.get_string ("lower_case_cprefix"));
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				add_cheader_filename (filename);
			}
		}
		if (a.has_argument ("gir_namespace")) {
			source_reference.file.gir_namespace = a.get_string ("gir_namespace");
		}
		if (a.has_argument ("gir_version")) {
			source_reference.file.gir_version = a.get_string ("gir_version");
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

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		process_attributes ();

		foreach (Namespace ns in namespaces) {
			ns.check (analyzer);
		}

		return !error;
	}
}
