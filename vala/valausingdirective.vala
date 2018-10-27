/* valausingdirective.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
 * A reference to a namespace symbol.
 */
public class Vala.UsingDirective : CodeNode {
	/**
	 * The symbol of the namespace this using directive is referring to.
	 */
	public weak Symbol namespace_symbol {
		get {
			if (unresolved_symbol != null) {
				return unresolved_symbol;
			}
			return _namespace_symbol;
		}
		set {
			if (value is UnresolvedSymbol) {
				unresolved_symbol = (UnresolvedSymbol) value;
				_namespace_symbol = null;
			} else {
				_namespace_symbol = value;
				unresolved_symbol = null;
			}
		}
	}

	weak Symbol _namespace_symbol;
	UnresolvedSymbol unresolved_symbol;

	/**
	 * Creates a new using directive.
	 *
	 * @param namespace_symbol namespace symbol
	 * @return                 newly created using directive
	 */
	public UsingDirective (Symbol namespace_symbol, SourceReference? source_reference = null) {
		this.namespace_symbol = namespace_symbol;
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_using_directive (this);
	}
}
