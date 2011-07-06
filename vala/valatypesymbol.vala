/* valatypesymbol.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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
 * Represents a runtime data type. This data type may be defined in Vala source
 * code or imported from an external library with a Vala API file.
 */
public abstract class Vala.TypeSymbol : Symbol {
	public TypeSymbol (string? name, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
	}

	/**
	 * Checks whether this data type has value or reference type semantics.
	 *
	 * @return true if this data type has reference type semantics
	 */
	public virtual bool is_reference_type () {
		return false;
	}

	/**
	 * Checks whether this data type is equal to or a subtype of the
	 * specified data type.
	 *
	 * @param t a data type
	 * @return  true if t is a supertype of this data type, false otherwise
	 */
	public virtual bool is_subtype_of (TypeSymbol t) {
		return (this == t);
	}
	
	/**
	 * Return the index of the specified type parameter name.
	 */
	public virtual int get_type_parameter_index (string name) {
		return -1;
	}
}
