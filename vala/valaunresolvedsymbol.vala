/* valaunresolvedsymbol.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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
 * An unresolved reference to a symbol.
 */
public class Vala.UnresolvedSymbol : CodeNode {
	/**
	 * The parent of the symbol or null.
	 */
	public UnresolvedSymbol? inner { get; set; }

	/**
	 * The symbol name.
	 */
	public string name { get; set; }

	public UnresolvedSymbol (UnresolvedSymbol? inner, string name, SourceReference? source_reference = null) {
		this.inner = inner;
		this.name = name;
		this.source_reference = source_reference;
	}

	public override string to_string () {
		if (inner == null) {
			return name;
		} else {
			return "%s.%s".printf (inner.to_string (), name);
		}
	}

	public UnresolvedSymbol copy () {
		return new UnresolvedSymbol (inner, name, source_reference);
	}
}

