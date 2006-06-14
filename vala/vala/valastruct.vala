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
		List<string> type_parameters;
		List<Constant> constants;
		List<Field> fields;
		List<Method> methods;
		
		public string cname;
		public string ref_function;
		public string lower_case_csuffix;
		bool reference_type;
		
		public static ref Struct new (string! name, SourceReference source) {
			return (new Struct (name = name, source_reference = source));
		}

		public void add_type_parameter (TypeParameter! p) {
			type_parameters.append (p);
			p.type = this;
		}
		
		public void add_constant (Constant! c) {
			constants.append (c);
		}
		
		public void add_field (Field! f) {
			fields.append (f);
		}
		
		public ref List<Field> get_fields () {
			return fields.copy ();
		}
		
		public void add_method (Method! m) {
			return_if_fail (m != null);
			
			methods.append (m);
		}
		
		public ref List<Method> get_methods () {
			return methods.copy ();
		}
		
		public override void accept (CodeVisitor! visitor) {
			visitor.visit_begin_struct (this);
			
			foreach (TypeParameter p in type_parameters) {
				p.accept (visitor);
			}
			
			foreach (Field f in fields) {
				f.accept (visitor);
			}
			
			foreach (Constant c in constants) {
				c.accept (visitor);
			}
			
			foreach (Method m in methods) {
				m.accept (visitor);
			}

			visitor.visit_end_struct (this);
		}
		
		public override string get_cname () {
			if (cname == null) {
				cname = "%s%s".printf (@namespace.get_cprefix (), name);
			}
			return cname;
		}
		
		public void set_cname (string! cname) {
			this.cname = cname;
		}
		
		public string get_lower_case_csuffix () {
			if (lower_case_csuffix == null) {
				lower_case_csuffix = Namespace.camel_case_to_lower_case (name);
			}
			return lower_case_csuffix;
		}
		
		public void set_lower_case_csuffix (string! csuffix) {
			this.lower_case_csuffix = csuffix;
		}
		
		public override ref string get_lower_case_cname (string infix) {
			if (infix == null) {
				infix = "";
			}
			return "%s%s%s".printf (@namespace.get_lower_case_cprefix (), infix, get_lower_case_csuffix ());
		}
		
		public override ref string get_upper_case_cname (string infix) {
			return get_lower_case_cname (infix).up ();
		}
		
		public override bool is_reference_type () {
			return reference_type;
		}
		
		private void process_ccode_attribute (Attribute! a) {
			foreach (NamedArgument arg in a.args) {
				if (arg.name == "cname") {
					/* this will already be checked during semantic analysis */
					if (arg.argument is LiteralExpression) {
						var lit = ((LiteralExpression) arg.argument).literal;
						if (lit is StringLiteral) {
							set_cname (((StringLiteral) lit).eval ());
						}
					}
				} else if (arg.name == "cheader_filename") {
					/* this will already be checked during semantic analysis */
					if (arg.argument is LiteralExpression) {
						var lit = ((LiteralExpression) arg.argument).literal;
						if (lit is StringLiteral) {
							var val = ((StringLiteral) lit).eval ();
							foreach (string filename in val.split (",", 0)) {
								cheader_filenames.append (filename);
							}
						}
					}
				}
			}
		}
		
		private void process_ref_type_attribute (Attribute! a) {
			reference_type = true;
			foreach (NamedArgument arg in a.args) {
				if (arg.name == "ref_function") {
					/* this will already be checked during semantic analysis */
					if (arg.argument is LiteralExpression) {
						var lit = ((LiteralExpression) arg.argument).literal;
						if (lit is StringLiteral) {
							set_ref_function (((StringLiteral) lit).eval ());
						}
					}
				}
			}
		}
		
		public void process_attributes () {
			foreach (Attribute a in attributes) {
				if (a.name == "CCode") {
					process_ccode_attribute (a);
				} else if (a.name == "ReferenceType") {
					process_ref_type_attribute (a);
				}
			}
		}

		public override bool is_reference_counting () {
			return false;
		}
		
		public override string get_ref_function () {
			if (ref_function == null) {
				Report.warning (source_reference, "type foo is missing a copy/reference increment function");
				ref_function = "g_strdup";
			}
			return ref_function;
		}
		
		public void set_ref_function (string! name) {
			this.ref_function = name;
		}
		
		public override string get_free_function () {
			return "g_free";
		}
	}
}
