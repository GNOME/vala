/* valagenericsymbol.vala
 *
 * Copyright (C) 2023  Rico Tzschichholz
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
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */

using GLib;

/**
 * The interface for symbols which support type parameters.
 */
public interface Vala.GenericSymbol : Symbol {
	/**
	 * Appends the specified parameter to the list of type parameters.
	 *
	 * @param p a type parameter
	 */
	public abstract void add_type_parameter (TypeParameter p);

	/**
	 * Returns the type parameter list.
	 *
	 * @return list of type parameters
	 */
	public abstract unowned List<TypeParameter> get_type_parameters ();

	/**
	 * Returns whether this symbol has type parameters.
	 *
	 * @return true if there are type parameters
	 */
	public abstract bool has_type_parameters ();

	/**
	 * Returns the index of the type parameter with the given name.
	 *
	 * @return index of a type parameter, or -1
	 */
	public abstract int get_type_parameter_index (string name);
}
