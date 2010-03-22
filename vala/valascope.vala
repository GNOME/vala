/* valascope.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

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
 * Represents a part of the symbol tree.
 */
public class Vala.Scope {
	/**
	 * The symbol that owns this scope.
	 */
	public weak Symbol owner { get; set; }

	/**
	 * The parent of this scope.
	 */
	public weak Scope parent_scope { get; set; }

	private Map<string,Symbol> symbol_table;
	private List<Symbol> anonymous_members;

	/**
	 * Creates a new scope.
	 *
	 * @return newly created scope
	 */
	public Scope (Symbol? owner = null) {
		this.owner = owner;
	}

	/**
	 * Adds the specified symbol with the specified name to the symbol table
	 * of this scope.
	 *
	 * @param name name for the specified symbol
	 * @param sym  a symbol
	 */
	public void add (string? name, Symbol sym) {
		if (name != null) {
			if (symbol_table == null) {
				symbol_table = new HashMap<string,Symbol> (str_hash, str_equal);
			} else if (lookup (name) != null) {
				owner.error = true;
				if (owner.name == null && owner.parent_symbol == null) {
					Report.error (sym.source_reference, "The root namespace already contains a definition for `%s'".printf (name));
				} else {
					Report.error (sym.source_reference, "`%s' already contains a definition for `%s'".printf (owner.get_full_name (), name));
				}
				Report.notice (lookup (name).source_reference, "previous definition of `%s' was here".printf (name));
				return;
			}

			symbol_table[(string) name] = sym;
		} else {
			if (anonymous_members == null) {
				anonymous_members = new ArrayList<Symbol> ();
			}

			anonymous_members.add (sym);
		}
		sym.owner = this;
	}

	public void remove (string name) {
		symbol_table.remove (name);
	}

	/**
	 * Returns the symbol stored in the symbol table with the specified
	 * name.
	 *
	 * @param name name of the symbol to be returned
	 * @return     found symbol or null
	 */
	public Symbol? lookup (string name) {
		if (symbol_table == null) {
			return null;
		}
		Symbol sym = symbol_table[name];
		if (sym != null && !sym.active) {
			sym = null;
		}
		return sym;
	}

	/**
	 * Returns whether the specified scope is an ancestor of this scope.
	 *
	 * @param scope a scope or null for the root scope
	 * @return      true if this scope is a subscope of the specified
	 *              scope, false otherwise
	 */
	public bool is_subscope_of (Scope? scope) {
		if (scope == this) {
			return true;
		}

		// null scope is the root scope
		if (scope == null) {
			return true;
		}

		if (parent_scope != null) {
			return parent_scope.is_subscope_of (scope);
		}

		return false;
	}

	public Map<string,Symbol> get_symbol_table () {
		return symbol_table;
	}
}

