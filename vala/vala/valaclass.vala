/* valaclass.vala
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
	public class Class : Type_ {
		List<string> type_parameters;
		public List<TypeReference> base_types;
		public Class base_class;
		public bool is_abstract;
		
		List<Constant> constants;
		List<Field> fields;
		List<Method> methods;
		List<Property> properties;
		List<Signal> signals;
		
		public Constructor constructor { get; set; }
		public Destructor destructor { get; set; }
		
		public string cname;
		public string lower_case_csuffix;
		public bool has_private_fields;
		
		public static ref Class new (string! name, SourceReference source) {
			return (new Class (name = name, source_reference = source));
		}

		public void add_base_type (TypeReference! type) {
			base_types.append (type);
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
			if (f.access == MemberAccessibility.PRIVATE) {
				has_private_fields = true;
			}
		}
		
		public ref List<Field> get_fields () {
			return fields.copy ();
		}
		
		public void add_method (Method! m) {
			methods.append (m);
		}
		
		public ref List<Method> get_methods () {
			return methods.copy ();
		}
		
		public void add_property (Property! prop) {
			properties.append (prop);
			
			if (prop.set_accessor != null && prop.set_accessor.body == null) {
				/* automatic property accessor body generation */
				var f = new Field (name = "_%s".printf (prop.name), type_reference = prop.type_reference, source_reference = prop.source_reference);
				f.access = MemberAccessibility.PRIVATE;
				add_field (f);
			}
		}
		
		public ref List<Property> get_properties () {
			return properties.copy ();
		}
		
		public void add_signal (Signal! sig) {
			signals.append (sig);
		}
		
		public ref List<Signal> get_signals () {
			return signals.copy ();
		}
		
		public override void accept (CodeVisitor! visitor) {
			visitor.visit_begin_class (this);
			
			foreach (TypeReference type in base_types) {
				type.accept (visitor);
			}

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
			
			foreach (Property prop in properties) {
				prop.accept (visitor);
			}
			
			foreach (Signal sig in signals) {
				sig.accept (visitor);
			}
			
			if (constructor != null) {
				constructor.accept (visitor);
			}

			if (destructor != null) {
				destructor.accept (visitor);
			}

			visitor.visit_end_class (this);
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
		
		public override ref string get_upper_case_cname (string! infix) {
			return get_lower_case_cname (infix).up ();
		}

		public override bool is_reference_type () {
			return true;
		}
		
		void process_ccode_attribute (Attribute! a) {
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
		
		public void process_attributes () {
			foreach (Attribute a in attributes) {
				if (a.name == "CCode") {
					process_ccode_attribute (a);
				}
			}
		}

		public override bool is_reference_counting () {
			return true;
		}
		
		public override string get_ref_function () {
			return "g_object_ref";
		}
		
		public override string get_free_function () {
			return "g_object_unref";
		}
	}
}
