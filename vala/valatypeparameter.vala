/* valatypeparameter.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Represents a generic type parameter in the source code.
 */
public class Vala.TypeParameter : TypeSymbol {
	/**
	 * Creates a new generic type parameter.
	 *
	 * @param name              parameter name
	 * @param source_reference  reference to source code
	 * @return                  newly created generic type parameter
	 */
	public TypeParameter (string name, SourceReference? source_reference = null) {
		base (name, source_reference);
		access = SymbolAccessibility.PUBLIC;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_type_parameter (this);
	}

	/**
	 * Checks two type parameters for equality.
	 *
	 * @param param2 a type parameter
	 * @return      true if this type parameter is equal to param2, false
	 *              otherwise
	 */
	public bool equals (TypeParameter param2) {
		/* only type parameters with a common scope are comparable */
		if (!owner.is_subscope_of (param2.owner) && !param2.owner.is_subscope_of (owner)) {
			Report.error (source_reference, "internal error: comparing type parameters from different scopes");
			return false;
		}

		return name == param2.name && parent_symbol == param2.parent_symbol;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!(parent_symbol is GenericSymbol)) {
			Report.error (source_reference, "internal error: Incompatible parent_symbol");
			error = true;
			return false;
		}

		return !error;
	}
}
