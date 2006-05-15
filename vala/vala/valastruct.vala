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
		public readonly string# name;
		public readonly SourceReference# source_reference;
		public Namespace @namespace;

		ref List<ref string> type_parameters;
		List<Field#># fields;
		List<Method#># methods;
		
		public ref string cname;
		
		public static Struct# new (string name, SourceReference source) {
			return (new Struct (name = name, source_reference = source));
		}

		public void add_type_parameter (TypeParameter p) {
			type_parameters.append (p);
			p.type = this;
		}
		
		public void add_field (Field f) {
			fields.append (f);
			f.parent_type = this;
		}
		
		public void add_method (Method m) {
			methods.append (m);
			m.parent_type = this;
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
			
			foreach (Field f in fields) {
				f.accept (visitor);
			}
			
			foreach (Method m in methods) {
				m.accept (visitor);
			}
		}
		
		public override string get_cname () {
			if (cname == null) {
				cname = name;
			}
			return cname;
		}
		
		public void set_cname (string cname) {
			this.cname = cname;
		}

		public override bool is_reference_type () {
			return false;
		}
		
		void process_ccode_attribute (Attribute a) {
			foreach (NamedArgument arg in a.args) {
				if (arg.name.cmp ("cname") == 0) {
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
				if (a.name.cmp ("CCode") == 0) {
					process_ccode_attribute (a);
				}
			}
		}
	}
}
