/* valasymbol.vala
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

/**
 * Represents a node in the symbol tree.
 */
public class Vala.Symbol {
	/**
	 * The code node that created this symbol, if applicable.
	 */
	public weak CodeNode node { get; set; }
	
	/**
	 * The parent of this symbol.
	 */
	public weak Symbol parent_symbol { get; set; }
	
	/**
	 * The symbol name.
	 */
	public string name { get; set; }

	/**
	 * Specifies whether this symbol is active.
	 *
	 * Symbols may become inactive when they only apply to a part of a
	 * scope. This is used for local variables not declared at the beginning
	 * of the block to determine which variables need to be freed before
	 * jump statements.
	 */
	public bool active { get; set; }
	
	private HashTable<string,Symbol> symbol_table = new HashTable.full (str_hash, str_equal, g_free, g_object_unref);
	
	/**
	 * Creates a new symbol.
	 *
	 * @param node the corresponding code node
	 * @return     newly created symbol
	 */
	public construct (CodeNode _node = null)  {
		node = _node;
	}
	
	Symbol () {
		active = true;
	}
	
	/**
	 * Returns the fully expanded name of this symbol for use in
	 * human-readable messages.
	 *
	 * @return full name
	 */
	public ref string get_full_name () {
		if (parent_symbol == null) {
			return name;
		}
		
		if (name == null) {
			return parent_symbol.get_full_name ();
		}

		if (parent_symbol.get_full_name () == null) {
			return name;
		}
		
		return "%s.%s".printf (parent_symbol.get_full_name (), name);
	}
	
	/**
	 * Adds the specified symbol with the specified name to the symbol table
	 * of this symbol.
	 *
	 * @param name name for the specified symbol
	 * @param sym  a symbol
	 */
	public void add (string! name, Symbol! sym) {
		symbol_table.insert (name, sym);
		sym.parent_symbol = this;
		sym.name = name;
	}
	
	/**
	 * Returns the symbol stored in the symbol table with the specified
	 * name.
	 *
	 * @param name name of the symbol to be returned
	 * @return     found symbol or null
	 */
	public Symbol lookup (string! name) {
		Symbol sym = symbol_table.lookup (name);
		if (sym != null && !sym.active) {
			sym = null;
		}
		return sym;
	}
}
