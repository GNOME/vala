/* valastruct.vala
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
	public class Struct : Type_ {
		public string name { get; construct; }
		public SourceReference source_reference { get; construct; }
		public weak Namespace @namespace;

		List<string> type_parameters;
		List<Constant> constants;
		List<Field> fields;
		List<Method> methods;
		
		public string cname;
		public string lower_case_csuffix;
		bool reference_type;
		
		public static ref Struct new (string name, SourceReference source) {
			return (new Struct (name = name, source_reference = source));
		}

		public void add_type_parameter (TypeParameter p) {
			type_parameters.append (p);
			p.type = this;
		}
		
		public void add_constant (Constant c) {
			constants.append (c);
		}
		
		public void add_field (Field f) {
			fields.append (f);
		}
		
		public void add_method (Method m) {
			methods.append (m);
		}
		
		public override void accept (CodeVisitor visitor) {
			visitor.visit_begin_struct (this);
			
			visit_children (visitor);

			visitor.visit_end_struct (this);
		}
		
		public void visit_children (CodeVisitor visitor) {
			foreach (TypeParameter p in type_parameters) {
				p.accept (visitor);
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
		
		public override string get_cname () {
			if (cname == null) {
				cname = "%s%s".printf (@namespace.get_cprefix (), name);
			}
			return cname;
		}
		
		public void set_cname (string cname) {
			this.cname = cname;
		}
		
		public string get_lower_case_csuffix () {
			if (lower_case_csuffix == null) {
				lower_case_csuffix = Namespace.camel_case_to_lower_case (name);
			}
			return lower_case_csuffix;
		}
		
		public void set_lower_case_csuffix (string csuffix) {
			this.lower_case_csuffix = csuffix;
		}
		
		public ref string get_lower_case_cname (string infix) {
			if (infix == null) {
				infix = "";
			}
			return "%s%s%s".printf (@namespace.get_lower_case_cprefix (), infix, get_lower_case_csuffix ());
		}
		
		public override ref string get_upper_case_cname (string infix) {
			return get_lower_case_cname (infix).up (-1);
		}

		public override bool is_reference_type () {
			return reference_type;
		}
		
		void process_ccode_attribute (Attribute a) {
			foreach (NamedArgument arg in a.args) {
				if (arg.name.collate ("cname") == 0) {
					/* this will already be checked during semantic analysis */
					if (arg.argument is LiteralExpression) {
						var lit = ((LiteralExpression) arg.argument).literal;
						if (lit is StringLiteral) {
							set_cname (((StringLiteral) lit).eval ());
						}
					}
				}
			}
		}
		
		public void process_attributes () {
			foreach (Attribute a in attributes) {
				if (a.name.collate ("CCode") == 0) {
					process_ccode_attribute (a);
				} else if (a.name.collate ("ReferenceType") == 0) {
					reference_type = true;
				}
			}
		}
	}
}
