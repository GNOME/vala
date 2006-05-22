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
		Symbol current_symbol;
		
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
			
			current_symbol = ns.symbol;
		}
		
		public override void visit_end_namespace (Namespace ns) {
			current_symbol = current_symbol.parent_symbol;
		}
	
		public override void visit_begin_class (Class cl) {
			if (cl.@namespace.symbol.lookup (cl.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			cl.symbol = new Symbol (node = cl);
			cl.@namespace.symbol.add (cl.name, cl.symbol);
			
			current_symbol = cl.symbol;
		}
		
		public override void visit_end_class (Class cl) {
			current_symbol = current_symbol.parent_symbol;
		}
		
		public override void visit_begin_struct (Struct st) {
			if (st.@namespace.symbol.lookup (st.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			st.symbol = new Symbol (node = st);
			st.@namespace.symbol.add (st.name, st.symbol);
			
			current_symbol = st.symbol;
		}
		
		public override void visit_end_struct (Struct st) {
			current_symbol = current_symbol.parent_symbol;
		}
		
		public override void visit_begin_enum (Enum en) {
			if (en.@namespace.symbol.lookup (en.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			en.symbol = new Symbol (node = en);
			en.@namespace.symbol.add (en.name, en.symbol);
			current_symbol = en.symbol;
		}
		
		public override void visit_end_enum (Enum en) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_enum_value (EnumValue ev) {
			ev.symbol = new Symbol (node = ev);
			current_symbol.add (ev.name, ev.symbol);
		}

		public override void visit_constant (Constant c) {
			if (current_symbol.lookup (c.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			c.symbol = new Symbol (node = c);
			current_symbol.add (c.name, c.symbol);
		}
		
		public override void visit_field (Field f) {
			if (current_symbol.lookup (f.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			f.symbol = new Symbol (node = f);
			current_symbol.add (f.name, f.symbol);
		}
		
		public override void visit_begin_method (Method m) {
			if (current_symbol.lookup (m.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			m.symbol = new Symbol (node = m);
			current_symbol.add (m.name, m.symbol);
			current_symbol = m.symbol;
			
			if (m.instance) {
				var type = new TypeReference ();
				type.type = (Type_) m.symbol.parent_symbol.node;
				current_symbol.add ("this", new Symbol (node = type));
			}
		}
		
		public override void visit_end_method (Method m) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_formal_parameter (FormalParameter p) {
			p.symbol = new Symbol (node = p);
			current_symbol.add (p.name, p.symbol);
		}
		
		public override void visit_begin_property (Property prop) {
			if (current_symbol.lookup (prop.name) != null) {
				// TODO: raise error
				stderr.printf ("symbol conflict\n");
				return;
			}
			prop.symbol = new Symbol (node = prop);
			current_symbol.add (prop.name, prop.symbol);
			current_symbol = prop.symbol;
			
			var type = new TypeReference ();
			type.type = (Type_) prop.symbol.parent_symbol.node;
			current_symbol.add ("this", new Symbol (node = type));
		}
		
		public override void visit_end_property (Property prop) {
			current_symbol = current_symbol.parent_symbol;
		}
		
		public override void visit_begin_property_accessor (PropertyAccessor acc) {
			acc.symbol = new Symbol (node = acc);
			acc.symbol.parent_symbol = current_symbol;
			current_symbol = acc.symbol;

			if (acc.writable || acc.construct_) {
				current_symbol.add ("value", new Symbol (node = ((Property) current_symbol.parent_symbol.node).type_reference));
			}

			if (acc.body == null) {
				/* no accessor body specified, insert default body */
				
				var prop = (Property) acc.symbol.parent_symbol.node;
				
				var block = new Block ();
				if (acc.readable) {
					block.add_statement (new ReturnStatement (return_expression = new SimpleName (name = prop.name)));
				} else {
				}
				acc.body = block;
			}
		}
		
		public override void visit_end_property_accessor (PropertyAccessor acc) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_begin_block (Block b) {
			b.symbol = new Symbol (node = b);
			b.symbol.parent_symbol = current_symbol;
			current_symbol = b.symbol;
		}

		public override void visit_end_block (Block b) {
			current_symbol = current_symbol.parent_symbol;
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
