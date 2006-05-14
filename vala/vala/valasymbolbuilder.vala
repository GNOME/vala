/* valasymbolbuilder.vala
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
	public class SymbolBuilder : CodeVisitor {
		Symbol root;
		Symbol current_namespace;
		Symbol current_type;
		
		public void build (CodeContext context) {
			root = context.root;
			context.accept (this);
		}
		
		public override void visit_begin_namespace (Namespace ns) {
			if (ns.name == null) {
				ns.symbol = root;
				return;
			}
			ns.symbol = root.lookup (ns.name);
			if (ns.symbol == null) {
				ns.symbol = new Symbol (node = ns);
				root.add (ns.name, ns.symbol);
			}
		}
	
		public override void visit_begin_class (Class cl) {
			if (cl.@namespace.symbol.lookup (cl.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			cl.symbol = new Symbol (node = cl);
			cl.@namespace.symbol.add (cl.name, cl.symbol);
		}
		
		public override void visit_begin_struct (Struct st) {
			if (st.@namespace.symbol.lookup (st.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			st.symbol = new Symbol (node = st);
			st.@namespace.symbol.add (st.name, st.symbol);
		}
		
		public override void visit_enum (Enum en) {
			if (en.@namespace.symbol.lookup (en.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			en.symbol = new Symbol (node = en);
			en.@namespace.symbol.add (en.name, en.symbol);
		}
		
		public override void visit_field (Field f) {
			if (f.parent_type.symbol.lookup (f.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			f.symbol = new Symbol (node = f);
			f.parent_type.symbol.add (f.name, f.symbol);
		}
		
		public override void visit_method (Method m) {
			if (m.parent_type.symbol.lookup (m.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			m.symbol = new Symbol (node = m);
			m.parent_type.symbol.add (m.name, m.symbol);
		}
		
		public override void visit_type_parameter (TypeParameter p) {
			if (p.type.symbol.lookup (p.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			p.symbol = new Symbol (node = p);
			p.type.symbol.add (p.name, p.symbol);
		}
	}
}
