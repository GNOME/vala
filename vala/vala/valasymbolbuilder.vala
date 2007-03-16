/* valasymbolbuilder.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;

/**
 * Code visitor building the symbol tree.
 */
public class Vala.SymbolBuilder : CodeVisitor {
	Symbol root;
	Symbol current_type;
	Symbol current_symbol;
	SourceFile current_source_file;
	
	/**
	 * Build the symbol tree for the specified code context.
	 *
	 * @param context a code context
	 */
	public void build (CodeContext! context) {
		root = context.get_root ();
		context.accept (this);
	}
	
	public override void visit_begin_source_file (SourceFile! file) {
		current_source_file = file;
	}
	
	public override void visit_begin_namespace (Namespace! ns) {
		if (ns.name == null) {
			ns.symbol = root;
		}
		
		if (ns.symbol == null) {
			ns.symbol = root.lookup (ns.name);
		}
		if (ns.symbol == null) {
			ns.symbol = new Symbol (ns);
			root.add (ns.name, ns.symbol);
		}
		
		current_symbol = ns.symbol;
	}
	
	public override void visit_end_namespace (Namespace! ns) {
		current_symbol = current_symbol.parent_symbol;
	}
	
	private weak Symbol add_symbol (string name, CodeNode! node) {
		if (name != null) {
			if (current_symbol.lookup (name) != null) {
				node.error = true;
				Report.error (node.source_reference, "`%s' already contains a definition for `%s'".printf (current_symbol.get_full_name (), name));
				return null;
			}
		}
		node.symbol = new Symbol (node);
		if (name != null) {
			current_symbol.add (name, node.symbol);
		} else {
			node.symbol.parent_symbol = current_symbol;
		}
		
		return node.symbol;
	}

	public override void visit_begin_class (Class! cl) {
		if (add_symbol (cl.name, cl) == null) {
			return;
		}
		
		current_symbol = cl.symbol;
	}
	
	public override void visit_end_class (Class! cl) {
		if (cl.error) {
			/* skip classes with errors */
			return;
		}
		
		current_symbol = current_symbol.parent_symbol;
	}
	
	public override void visit_begin_struct (Struct! st) {
		if (add_symbol (st.name, st) == null) {
			return;
		}
		
		current_symbol = st.symbol;
	}
	
	public override void visit_end_struct (Struct! st) {
		if (st.error) {
			/* skip structs with errors */
			return;
		}
		
		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_begin_interface (Interface! iface) {
		if (add_symbol (iface.name, iface) == null) {
			return;
		}
		
		current_symbol = iface.symbol;
	}
	
	public override void visit_end_interface (Interface! iface) {
		if (iface.error) {
			/* skip interfaces with errors */
			return;
		}
		
		current_symbol = current_symbol.parent_symbol;
	}
	
	public override void visit_begin_enum (Enum! en) {
		if (add_symbol (en.name, en) == null) {
			return;
		}
		
		current_symbol = en.symbol;
	}
	
	public override void visit_end_enum (Enum! en) {
		if (en.error) {
			/* skip enums with errors */
			return;
		}
		
		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_enum_value (EnumValue! ev) {
		ev.symbol = new Symbol (ev);
		current_symbol.add (ev.name, ev.symbol);
	}
	
	public override void visit_begin_callback (Callback! cb) {
		if (add_symbol (cb.name, cb) == null) {
			return;
		}
		
		current_symbol = cb.symbol;
	}
	
	public override void visit_end_callback (Callback! cb) {
		if (cb.error) {
			/* skip enums with errors */
			return;
		}
		
		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_constant (Constant! c) {
		add_symbol (c.name, c);
	}
	
	public override void visit_field (Field! f) {
		add_symbol (f.name, f);
	}
	
	public override void visit_begin_method (Method! m) {
		if (add_symbol (m.name, m) == null) {
			return;
		}
		
		if (m.instance) {
			if (!(m.symbol.parent_symbol.node is DataType)) {
				Report.error (m.source_reference, "instance methods not allowed outside of data types");
			
				m.error = true;
				return;
			}
		
			m.this_parameter = new FormalParameter ("this", new TypeReference ());
			m.this_parameter.type_reference.data_type = (DataType) m.symbol.parent_symbol.node;
			m.this_parameter.symbol = new Symbol (m.this_parameter);
			current_symbol.add (m.this_parameter.name, m.this_parameter.symbol);
		}
		
		current_symbol = m.symbol;
	}
	
	public override void visit_end_method (Method! m) {
		if (m.error) {
			/* skip methods with errors */
			return;
		}
		
		current_symbol = current_symbol.parent_symbol;
	}
	
	public override void visit_begin_creation_method (CreationMethod! m) {
		if (add_symbol (m.name, m) == null) {
			return;
		}
		
		var type_node = m.symbol.parent_symbol.node;
		if (!(type_node is Class || type_node is Struct)) {
			Report.error (m.source_reference, "construction methods may only be declared within classes and structs");
		
			m.error = true;
			return;
		}
	
		if (m.name == null) {
			if (type_node is Class) {
				((Class) type_node).default_construction_method = m;
			} else if (type_node is Struct) {
				((Struct) type_node).default_construction_method = m;
			}
		}
		
		current_symbol = m.symbol;
	}
	
	public override void visit_end_creation_method (CreationMethod! m) {
		if (m.error) {
			/* skip methods with errors */
			return;
		}
		
		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_formal_parameter (FormalParameter! p) {
		if (!p.ellipsis) {
			add_symbol (p.name, p);
		}
	}
	
	public override void visit_begin_property (Property! prop) {
		if (add_symbol (prop.name, prop) == null) {
			return;
		}
		
		current_symbol = prop.symbol;
		
		prop.this_parameter = new FormalParameter ("this", new TypeReference ());
		prop.this_parameter.type_reference.data_type = (DataType) prop.symbol.parent_symbol.node;
		prop.this_parameter.symbol = new Symbol (prop.this_parameter);
		current_symbol.add (prop.this_parameter.name, prop.this_parameter.symbol);
	}
	
	public override void visit_end_property (Property! prop) {
		if (prop.error) {
			/* skip properties with errors */
			return;
		}
		
		current_symbol = current_symbol.parent_symbol;
	}
	
	public override void visit_begin_property_accessor (PropertyAccessor! acc) {
		acc.symbol = new Symbol (acc);
		acc.symbol.parent_symbol = current_symbol;
		current_symbol = acc.symbol;
		
		if (current_source_file.pkg) {
			return;
		}

		if (acc.writable || acc.construction) {
			acc.value_parameter = new FormalParameter ("value", ((Property) current_symbol.parent_symbol.node).type_reference);
			acc.value_parameter.symbol = new Symbol (acc.value_parameter);
			
			current_symbol.add (acc.value_parameter.name, acc.value_parameter.symbol);
		}

		if (acc.body == null) {
			/* no accessor body specified, insert default body */
			
			var prop = (Property) acc.symbol.parent_symbol.node;
		
			if (prop.interface_only || prop.symbol.parent_symbol.node is Interface) {
				return;
			}
			
			var block = new Block ();
			if (acc.readable) {
				block.add_statement (new ReturnStatement (new MemberAccess.simple ("_%s".printf (prop.name))));
			} else {
				block.add_statement (new ExpressionStatement (new Assignment (new MemberAccess.simple ("_%s".printf (prop.name)), new MemberAccess.simple ("value"))));
			}
			acc.body = block;
		}
	}
	
	public override void visit_end_property_accessor (PropertyAccessor! acc) {
		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_begin_signal (Signal! sig) {
		if (add_symbol (sig.name, sig) == null) {
			return;
		}
		
		current_symbol = sig.symbol;
	}

	public override void visit_end_signal (Signal! sig) {
		if (sig.error) {
			/* skip signals with errors */
			return;
		}
		
		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_begin_constructor (Constructor! c) {
		c.symbol = new Symbol (c);
		c.symbol.parent_symbol = current_symbol;
		current_symbol = c.symbol;
	}

	public override void visit_end_constructor (Constructor! c) {
		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_begin_destructor (Destructor! d) {
		d.symbol = new Symbol (d);
		d.symbol.parent_symbol = current_symbol;
		current_symbol = d.symbol;
	}

	public override void visit_end_destructor (Destructor! d) {
		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_begin_block (Block! b) {
		b.symbol = new Symbol (b);
		b.symbol.parent_symbol = current_symbol;
		current_symbol = b.symbol;
	}

	public override void visit_end_block (Block! b) {
		current_symbol = current_symbol.parent_symbol;
	}
	
	public override void visit_type_parameter (TypeParameter! p) {
		add_symbol (p.name, p);
	}
}
