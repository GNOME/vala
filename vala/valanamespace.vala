/* valanamespace.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 */

using GLib;

/**
 * Represents a namespace declaration in the source code.
 */
public class Vala.Namespace : Symbol {
	/**
	 * Specifies whether this namespace is only used in a VAPI package file.
	 */
	public bool pkg { get; set; }

	private List<Class> classes;
	private List<Interface> interfaces;
	private List<Struct> structs;
	private List<Enum> enums;
	private List<Callback> callbacks;
	private List<Constant> constants;
	private List<Field> fields;
	private List<Method> methods;
	
	private string cprefix;
	private string lower_case_cprefix;
	
	private List<string> cheader_filenames;

	private List<Namespace> namespaces;

	/**
	 * Creates a new namespace.
	 *
	 * @param name   namespace name
	 * @param source reference to source code
	 * @return       newly created namespace
	 */
	public Namespace (construct string name, construct SourceReference source_reference = null) {
	}
	
	/**
	 * Adds the specified namespace to this source file.
	 *
	 * @param ns a namespace
	 */
	public void add_namespace (Namespace! ns) {
		namespaces.append (ns);
		scope.add (ns.name, ns);
	}
	
	/**
	 * Returns a copy of the list of namespaces.
	 *
	 * @return namespace list
	 */
	public List<weak Namespace> get_namespaces () {
		return namespaces.copy ();
	}
	
	/**
	 * Adds the specified class to this namespace.
	 *
	 * @param cl a class
	 */
	public void add_class (Class! cl) {
		classes.append (cl);
		scope.add (cl.name, cl);
	}

	/**
	 * Adds the specified interface to this namespace.
	 *
	 * @param iface an interface
	 */
	public void add_interface (Interface! iface) {
		interfaces.append (iface);
		scope.add (iface.name, iface);
	}
	
	/**
	 * Adds the specified struct to this namespace.
	 *
	 * @param st a struct
	 */
	public void add_struct (Struct! st) {
		structs.append (st);
		scope.add (st.name, st);
	}
			
	/**
	 * Adds the specified enum to this namespace.
	 *
	 * @param en an enum
	 */
	public void add_enum (Enum! en) {
		enums.append (en);
		scope.add (en.name, en);
	}
			
	/**
	 * Adds the specified callback to this namespace.
	 *
	 * @param cb a callback
	 */
	public void add_callback (Callback! cb) {
		callbacks.append (cb);
		scope.add (cb.name, cb);
	}

	/**
	 * Returns a copy of the list of structs.
	 *
	 * @return struct list
	 */
	public List<weak Struct> get_structs () {
		return structs.copy ();
	}

	/**
	 * Returns a copy of the list of classes.
	 *
	 * @return class list
	 */
	public List<weak Class> get_classes () {
		return classes.copy ();
	}
	
	/**
	 * Returns a copy of the list of interfaces.
	 *
	 * @return interface list
	 */
	public List<weak Interface> get_interfaces () {
		return interfaces.copy ();
	}
	
	/**
	 * Adds the specified constant to this namespace.
	 *
	 * @param constant a constant
	 */
	public void add_constant (Constant! constant) {
		constants.append (constant);
		scope.add (constant.name, constant);
	}
	
	/**
	 * Adds the specified field to this namespace.
	 *
	 * @param f a field
	 */
	public void add_field (Field! f) {
		fields.append (f);
		scope.add (f.name, f);
	}
	
	/**
	 * Adds the specified method to this namespace.
	 *
	 * @param m a method
	 */
	public void add_method (Method! m) {
		if (m is CreationMethod) {
			Report.error (m.source_reference, "construction methods may only be declared within classes and structs");
		
			m.error = true;
			return;
		}
		if (m.instance) {
			Report.error (m.source_reference, "instance methods not allowed outside of data types");

			m.error = true;
			return;
		}

		methods.append (m);
		scope.add (m.name, m);
	}

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_namespace (this);
	}

	public override void accept_children (CodeVisitor! visitor) {
		foreach (Namespace ns in namespaces) {
			ns.accept (visitor);
		}

		/* process enums first to avoid order problems in C code */
		foreach (Enum en in enums) {
			en.accept (visitor);
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

		foreach (Callback cb in callbacks) {
			cb.accept (visitor);
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
	
	public override string! get_cprefix () {
		if (cprefix == null) {
			if (name == null) {
				cprefix = "";
			} else {
				cprefix = name;
			}
		}
		return cprefix;
	}

	/**
	 * Sets the camel case string to be prepended to the name of members of
	 * this namespace when used in C code.
	 *
	 * @param cprefix the camel case prefix to be used in C code
	 */
	public void set_cprefix (string cprefix) {
		this.cprefix = cprefix;
	}

	/**
	 * Returns the lower case string to be prepended to the name of members
	 * of this namespace when used in C code.
	 *
	 * @return the lower case prefix to be used in C code
	 */
	public override string! get_lower_case_cprefix () {
		if (lower_case_cprefix == null) {
			if (name == null) {
				lower_case_cprefix = "";
			} else {
				lower_case_cprefix = "%s_".printf (camel_case_to_lower_case (name));
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

	public override List<weak string> get_cheader_filenames () {
		return cheader_filenames.copy ();
	}
	
	/**
	 * Returns the C header filename of this namespace.
	 *
	 * @return header filename
	 */
	public string get_cheader_filename () {
		var s = new String ();
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
	public void set_cheader_filename (string! cheader_filename) {
		cheader_filenames = null;
		cheader_filenames.append (cheader_filename);
	}
	
	private void process_ccode_attribute (Attribute! a) {
		if (a.has_argument ("cprefix")) {
			set_cprefix (a.get_string ("cprefix"));
		}
		if (a.has_argument ("lower_case_cprefix")) {
			set_lower_case_cprefix (a.get_string ("lower_case_cprefix"));
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				cheader_filenames.append (filename);
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
