/* valaconstant.vala
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
	public class Constant : CodeNode {
		public string name { get; construct; }
		public TypeReference type_reference { get; construct; }
		public Expression initializer { get; construct; }
		public SourceReference source_reference { get; construct; }
		
		public static ref Constant new (string name, TypeReference type, Expression init, SourceReference source) {
			return (new Constant (name = name, type_reference = type, initializer = init, source_reference = source));
		}
		
		public override void accept (CodeVisitor visitor) {
			type_reference.accept (visitor);
			
			initializer.accept (visitor);

			visitor.visit_constant (this);
		}
		
		string cname;
		public string get_cname () {
			if (cname == null) {
				if (symbol.parent_symbol.node is Type_) {
					var t = (Type_) symbol.parent_symbol.node;
					cname = "%s_%s".printf (t.get_upper_case_cname (null), name);
				} else {
					var ns = (Namespace) symbol.parent_symbol.node;
					cname = "%s%s".printf (ns.get_cprefix ().up (-1), name);
				}
			}
			return cname;
		}
	}
}
