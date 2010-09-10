/* valaunresolvedtype.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

/**
 * An unresolved reference to a data type.
 */
public class Vala.UnresolvedType : DataType {
	/**
	 * The unresolved reference to a type symbol.
	 */
	public UnresolvedSymbol unresolved_symbol { get; set; }

	public UnresolvedType () {
	}

	/**
	 * Creates a new type reference.
	 *
	 * @param symbol    unresolved type symbol
	 * @param source    reference to source code
	 * @return          newly created type reference
	 */
	public UnresolvedType.from_symbol (UnresolvedSymbol symbol, SourceReference? source = null) {
		this.unresolved_symbol = symbol;
		source_reference = source;
	}

	/**
	 * Creates a new type reference from a code expression.
	 *
	 * @param expr   member access expression
	 * @return       newly created type reference
	 */
	public static UnresolvedType? new_from_expression (Expression expr) {
		var sym = UnresolvedSymbol.new_from_expression (expr);

		if (sym != null) {
			var type_ref = new UnresolvedType.from_symbol (sym, expr.source_reference);
			type_ref.value_owned = true;

			var ma = (MemberAccess) expr;
			foreach (DataType arg in ma.get_type_arguments ()) {
				type_ref.add_type_argument (arg);
			}

			return type_ref;
		}

		return null;
	}

	public override DataType copy () {
		var result = new UnresolvedType ();
		result.source_reference = source_reference;
		result.value_owned = value_owned;
		result.nullable = nullable;
		result.is_dynamic = is_dynamic;
		result.unresolved_symbol = unresolved_symbol.copy ();
		
		foreach (DataType arg in get_type_arguments ()) {
			result.add_type_argument (arg.copy ());
		}
		
		return result;
	}

	public override string to_qualified_string (Scope? scope) {
		var s = unresolved_symbol.to_string ();

		var type_args = get_type_arguments ();
		if (type_args.size > 0) {
			s += "<";
			bool first = true;
			foreach (DataType type_arg in type_args) {
				if (!first) {
					s += ",";
				} else {
					first = false;
				}
				if (!type_arg.value_owned) {
					s += "weak ";
				}
				s += type_arg.to_qualified_string (scope);
			}
			s += ">";
		}
		if (nullable) {
			s += "?";
		}

		return s;
	}

	public override bool is_disposable () {
		return value_owned;
	}
}
