/* valanamespace.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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
public class Vala.Namespace : CodeNode {
	/**
	 * The name of this namespace.
	 */
	public string name { get; set; }

	private List<Class> classes;
	private List<Interface> interfaces;
	private List<Struct> structs;
	private List<Enum> enums;
	private List<Flags> flags_;
	private List<Callback> callbacks;
	private List<Field> fields;
	private List<Method> methods;
	
	private string cprefix;
	private string lower_case_cprefix;
	
	private List<string> cheader_filenames;
	
	/**
	 * Creates a new namespace.
	 *
	 * @param name   namespace name
	 * @param source reference to source code
	 * @return       newly created namespace
	 */
	public construct (string _name, SourceReference source = null) {
		name = _name;
		source_reference = source;
	}
	
	/**
	 * Adds the specified class to this namespace.
	 *
	 * @param cl a class
	 */
	public void add_class (Class! cl) {
		classes.append (cl);
		cl.@namespace = this;
	}
	
	/**
	 * Adds the specified interface to this namespace.
	 *
	 * @param iface an interface
	 */
	public void add_interface (Interface! iface) {
		interfaces.append (iface);
		iface.@namespace = this;
	}
	
	/**
	 * Adds the specified struct to this namespace.
	 *
	 * @param st a struct
	 */
	public void add_struct (Struct! st) {
		structs.append (st);
		st.@namespace = this;
	}
			
	/**
	 * Adds the specified enum to this namespace.
	 *
	 * @param en an enum
	 */
	public void add_enum (Enum! en) {
		enums.append (en);
		en.@namespace = this;
	}
			
	/**
	 * Adds the specified flags to this namespace.
	 *
	 * @param fl a flags
	 */
	public void add_flags (Flags! fl) {
		flags_.append (fl);
		fl.@namespace = this;
	}
	
	/**
	 * Adds the specified callback to this namespace.
	 *
	 * @param cb a callback
	 */
	public void add_callback (Callback! cb) {
		callbacks.append (cb);
		cb.@namespace = this;
	}

	/**
	 * Returns a copy of the list of structs.
	 *
	 * @return struct list
	 */
	public ref List<Struct> get_structs () {
		return structs.copy ();
	}

	/**
	 * Returns a copy of the list of classes.
	 *
	 * @return class list
	 */
	public ref List<Class> get_classes () {
		return classes.copy ();
	}
	
	/**
	 * Adds the specified field to this namespace.
	 *
	 * @param f a field
	 */
	public void add_field (Field! f) {
		fields.append (f);
	}
	
	/**
	 * Adds the specified method to this namespace.
	 *
	 * @param m a method
	 */
	public void add_method (Method! m) {
		methods.append (m);
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_namespace (this);

		foreach (Class cl in classes) {
			cl.accept (visitor);
		}

		foreach (Interface iface in interfaces) {
			iface.accept (visitor);
		}

		foreach (Struct st in structs) {
			st.accept (visitor);
		}

		foreach (Enum en in enums) {
			en.accept (visitor);
		}

		foreach (Flags fl in flags_) {
			fl.accept (visitor);
		}

		foreach (Callback cb in callbacks) {
			cb.accept (visitor);
		}

		foreach (Field f in fields) {
			f.accept (visitor);
		}

		foreach (Method m in methods) {
			m.accept (visitor);
		}

		visitor.visit_end_namespace (this);
	}

	/**
	 * Converts a string from CamelCase to lower_case.
	 *
	 * @param camel_case a string in camel case
	 * @return           the specified string converted to lower case
	 */
	public static ref string! camel_case_to_lower_case (string! camel_case) {
		String result = new String ("");
		
		string i = camel_case;
		
		bool first = true;
		while (i.len () > 0) {
			unichar c = i.get_char ();
			if (c.isupper () && !first) {
				/* current character is upper case and
				 * we're not at the beginning */
				string t = i.prev_char ();
				bool prev_upper = t.get_char ().isupper ();
				t = i.next_char ();
				bool next_upper = t.get_char ().isupper ();
				if (!prev_upper || (i.len () >= 2 && !next_upper)) {
					/* previous character wasn't upper case or
					 * next character isn't upper case*/
					int len = result.str.len ();
					if (len != 1 && result.str.offset (len - 2).get_char () != '_') {
						/* we're not creating 1 character words */
						result.append_c ('_');
					}
				}
			}
			
			result.append_unichar (c.tolower ());
			
			first = false;
			i = i.next_char ();
		}
		
		return result.str;
	}
	
	/**
	 * Returns the camel case string to be prepended to the name of members
	 * of this namespace when used in C code.
	 *
	 * @return the camel case prefix to be used in C code
	 */
	public string! get_cprefix () {
		if (cprefix == null) {
			if (name == null) {
				cprefix = "";
			} else {
				cprefix = name;
			}
		}
		return cprefix;
	}
	
	private void set_cprefix (string cprefix) {
		this.cprefix = cprefix;
	}
	
	/**
	 * Returns the lower case string to be prepended to the name of members
	 * of this namespace when used in C code.
	 *
	 * @return the lower case prefix to be used in C code
	 */
	public string! get_lower_case_cprefix () {
		if (lower_case_cprefix == null) {
			if (name == null) {
				lower_case_cprefix = "";
			} else {
				lower_case_cprefix = "%s_".printf (camel_case_to_lower_case (name));
			}
		}
		return lower_case_cprefix;
	}
	
	private void set_lower_case_cprefix (string cprefix) {
		this.lower_case_cprefix = cprefix;
	}
	
	/**
	 * Returns a list of C header filenames users of this namespace must
	 * include.
	 *
	 * @return list of C header filenames for this namespace
	 */
	public ref List<string> get_cheader_filenames () {
		if (cheader_filenames == null) {
			cheader_filenames.append (source_reference.file.get_cinclude_filename ());
		}
		return cheader_filenames.copy ();
	}
	
	/**
	 * Returns the C header filename of this namespace.
	 *
	 * @return header filename
	 */
	public ref string get_cheader_filename () {
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
		foreach (NamedArgument arg in a.args) {
			if (arg.name == "cprefix") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						set_cprefix (((StringLiteral) lit).eval ());
					}
				}
			} else if (arg.name == "lower_case_cprefix") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						set_lower_case_cprefix (((StringLiteral) lit).eval ());
					}
				}
			} else if (arg.name == "cheader_filename") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						var val = ((StringLiteral) lit).eval ();
						foreach (string filename in val.split (",")) {
							cheader_filenames.append (filename);
						}
					}
				}
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
