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

namespace Vala {
	public class Symbol {
		HashTable<string,Symbol> symbol_table = HashTable.new (str_hash, str_equal);
		public readonly CodeNode# node;
		public Symbol parent_symbol;
		
		public void add (string s, Symbol sym) {
			symbol_table.insert (s, sym);
			sym.parent_symbol = this;
		}
		
		public Symbol lookup (string s) {
			return symbol_table.lookup (s);
		}
	}
}
