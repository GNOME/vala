/* valaunresolvedsymbol.vala
 *
 * Copyright (C) 2008-2009  Jürg Billeter
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

/**
 * An unresolved reference to a symbol.
 */
public class Vala.UnresolvedSymbol : Symbol {
	/**
	 * The parent of the symbol or null.
	 */
	public UnresolvedSymbol? inner { get; set; }

	/**
	 * Qualified access to global symbol.
	 */
	public bool qualified { get; set; }

	public UnresolvedSymbol (UnresolvedSymbol? inner, string name, SourceReference? source_reference = null) {
		base (name, source_reference);
		this.inner = inner;
	}

	public static UnresolvedSymbol? new_from_expression (Expression expr) {
		var ma = expr as MemberAccess;
		if (ma != null) {
			if (ma.inner != null) {
				return new UnresolvedSymbol (new_from_expression (ma.inner), ma.member_name, ma.source_reference);
			} else {
				return new UnresolvedSymbol (null, ma.member_name, ma.source_reference);
			}
		}

		Report.error (expr.source_reference, "Type reference must be simple name or member access expression");
		return null;
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

