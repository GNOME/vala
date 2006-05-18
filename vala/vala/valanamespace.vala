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
		List<Struct> structs;
		List<Enum> enums;
		List<Field> fields;
		
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

		public ref List<Class> get_classes () {
			return classes.copy ();
		}
		
		public void add_field (Field f) {
			fields.append (f);
		}
		
		public override void accept (CodeVisitor visitor) {
			visitor.visit_begin_namespace (this);

			foreach (Class cl in classes) {
				cl.accept (visitor);
			}

			foreach (Struct st in structs) {
				st.accept (visitor);
			}

			foreach (Enum en in enums) {
				en.accept (visitor);
			}

			foreach (Field f in fields) {
				f.accept (visitor);
			}

			visitor.visit_end_namespace (this);
		}

		public static ref string camel_case_to_lower_case (string camel_case) {
			String result = String.new ("");
			
			string i = camel_case;
			
			bool first = true;
			while (i.len (-1) > 0) {
				unichar c = i.get_char ();
				if (c.isupper () && !first) {
					/* current character is upper case and
					 * we're not at the beginning */
					string t = i.prev_char ();
					bool prev_upper = t.get_char ().isupper ();
					t = i.next_char ();
					bool next_upper = t.get_char ().isupper ();
					if (!prev_upper || (i.len (-1) >= 2 && !next_upper)) {
						/* previous character wasn't upper case or
						 * next character isn't upper case*/
						int len = result.str.len (-1);
						if (len != 1 && result.str.offset (len - 2).get_char () != '_') {
							/* we're not creating 1 character words */
							result.append_c ('_');
						}
					}
				}
				
				result.append_unichar (c);
				
				first = false;
				i = i.next_char ();
			}
			
			return result.str;
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
	}
}
