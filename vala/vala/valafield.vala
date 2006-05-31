/* valafield.vala
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
	public class Field : CodeNode {
		public string name { get; construct; }
		public TypeReference type_reference { get; construct; }
		public Expression initializer { get; construct; }
		public MemberAccessibility access;
		public bool instance = true;
		public SourceReference source_reference { get; construct; }
		public string cname;
		
		public static ref Field new (string name, TypeReference type, Expression init, SourceReference source) {
			return (new Field (name = name, type_reference = type, initializer = init, source_reference = source));
		}
		
		public override void accept (CodeVisitor visitor) {
			type_reference.accept (visitor);
			
			if (initializer != null) {
				initializer.accept (visitor);
			}

			visitor.visit_field (this);
		}

		public string get_cname () {
			if (cname == null) {
				cname = name;
			}
			return cname;
		}
		
		public void set_cname (string cname) {
			this.cname = cname;
		}
		
		void process_ccode_attribute (Attribute a) {
			foreach (NamedArgument arg in a.args) {
				if (arg.name == "cname") {
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
				if (a.name == "CCode") {
					process_ccode_attribute (a);
				}
			}
		}
	}
}
