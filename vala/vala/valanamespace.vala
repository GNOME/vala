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

namespace Vala {
	public class Namespace : CodeNode {
		public string name { get; construct; }
		public SourceReference source_reference { get; construct; }

		List<Class> classes;
		List<Interface> interfaces;
		List<Struct> structs;
		List<Enum> enums;
		List<Flags> flags_;
		List<Callback> callbacks;
		List<Field> fields;
		List<Method> methods;
		
		public string cprefix;
		public string lower_case_cprefix;
		
		public static ref Namespace new (string name, SourceReference source) {
			return (new Namespace (name = name, source_reference = source));
		}
		
		public void add_class (Class cl) {
			classes.append (cl);
			cl.@namespace = this;
		}
		
		public void remove_class (Class cl) {
			classes.remove (cl);
			cl.@namespace = null;
		}
		
		public void add_interface (Interface iface) {
			interfaces.append (iface);
			iface.@namespace = this;
		}
		
		public void add_struct (Struct st) {
			structs.append (st);
			st.@namespace = this;
		}
		
		public void remove_struct (Struct st) {
			structs.remove (st);
			st.@namespace = null;
		}
				
		public void add_enum (Enum en) {
			enums.append (en);
			en.@namespace = this;
		}
				
		public void add_flags (Flags fl) {
			flags_.append (fl);
			fl.@namespace = this;
		}
				
		public void add_callback (Callback! cb) {
			callbacks.append (cb);
			cb.@namespace = this;
		}

		public ref List<Struct> get_structs () {
			return structs.copy ();
		}

		public ref List<Class> get_classes () {
			return classes.copy ();
		}
		
		public void add_field (Field f) {
			fields.append (f);
		}
		
		public void add_method (Method m) {
			methods.append (m);
		}
		
		public override void accept (CodeVisitor visitor) {
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

		public static ref string camel_case_to_lower_case (string camel_case) {
			String result = String.new ("");
			
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
		
		public string get_cprefix () {
			if (cprefix == null) {
				if (name == null) {
					cprefix = "";
				} else {
					cprefix = name;
				}
			}
			return cprefix;
		}
		
		public void set_cprefix (string cprefix) {
			this.cprefix = cprefix;
		}
		
		public string get_lower_case_cprefix () {
			if (lower_case_cprefix == null) {
				if (name == null) {
					lower_case_cprefix = "";
				} else {
					lower_case_cprefix = "%s_".printf (camel_case_to_lower_case (name));
				}
			}
			return lower_case_cprefix;
		}
		
		public void set_lower_case_cprefix (string cprefix) {
			this.lower_case_cprefix = cprefix;
		}
		
		List<string> cheader_filenames;
		
		public ref List<string> get_cheader_filenames () {
			if (cheader_filenames == null) {
				cheader_filenames.append (source_reference.file.get_cheader_filename ());
			}
			return cheader_filenames.copy ();
		}
		
		void process_ccode_attribute (Attribute a) {
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
		
		public void process_attributes () {
			foreach (Attribute a in attributes) {
				if (a.name == "CCode") {
					process_ccode_attribute (a);
				}
			}
		}
	}
}
