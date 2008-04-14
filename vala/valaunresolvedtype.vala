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
using Gee;

/**
 * An unresolved reference to a data type.
 */
public class Vala.UnresolvedType : DataType {
	/**
	 * The unresolved reference to a type symbol.
	 */
	public UnresolvedSymbol unresolved_symbol { get; set; }

	/**
	 * Specifies the rank of the array this reference is possibly referring
	 * to. "0" indicates no array.
	 */
	public int array_rank { get; set; }

	/**
	 * Specifies the level of the pointer if this is a pointer-type. "0"
	 * indicates no pointer-type.
	 */
	public int pointer_level { get; set; }

	/**
	 * The weak modifier has been specified.
	 */
	public bool is_weak { get; set; }

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
	 * @param source reference to source code
	 * @return       newly created type reference
	 */
	public static UnresolvedType? new_from_expression (Expression expr) {
		string ns = null;
		string type_name = null;
		if (expr is MemberAccess) {
			UnresolvedType type_ref = null;
		
			MemberAccess ma = (MemberAccess) expr;
			if (ma.inner != null) {
				if (ma.inner is MemberAccess) {
					var simple = (MemberAccess) ma.inner;
					type_ref = new UnresolvedType.from_symbol (new UnresolvedSymbol (new UnresolvedSymbol (null, simple.member_name, ma.source_reference), ma.member_name, ma.source_reference), ma.source_reference);
				}
			} else {
				type_ref = new UnresolvedType.from_symbol (new UnresolvedSymbol (null, ma.member_name, ma.source_reference), ma.source_reference);
			}
			
			if (type_ref != null) {
				var type_args = ma.get_type_arguments ();
				foreach (DataType arg in type_args) {
					type_ref.add_type_argument (arg);
				}
				
				return type_ref;
			}
		}
		
		Report.error (expr.source_reference, "Type reference must be simple name or member access expression");
		return null;
	}

	public override DataType copy () {
		var result = new UnresolvedType ();
		result.source_reference = source_reference;
		result.transfers_ownership = transfers_ownership;
		result.takes_ownership = takes_ownership;
		result.is_out = is_out;
		result.nullable = nullable;
		result.unresolved_symbol = unresolved_symbol.copy ();
		result.array_rank = array_rank;
		result.pointer_level = pointer_level;
		result.is_ref = is_ref;
		result.is_weak = is_weak;
		
		foreach (DataType arg in get_type_arguments ()) {
			result.add_type_argument (arg.copy ());
		}
		
		return result;
	}

	public override string to_string () {
		return unresolved_symbol.to_string ();
	}
}
