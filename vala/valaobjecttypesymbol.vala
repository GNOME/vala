/* valaobjecttypesymbol.vala
 *
 * Copyright (C) 2008  Jürg Billeter
 * Copyright (C) 2008  Philip Van Hoof
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
 * 	Philip Van Hoof <pvanhoof@gnome.org>
 */

using Gee;

/**
 * Represents a runtime data type for objects and interfaces. This data type may
 * be defined in Vala source code or imported from an external library with a 
 * Vala API file.
 */
public abstract class Vala.ObjectTypeSymbol : TypeSymbol {
	private Gee.List<TypeParameter> type_parameters = new ArrayList<TypeParameter> ();

	public ObjectTypeSymbol (string name, SourceReference? source_reference = null) {
		base (name, source_reference);
	}

	public abstract Gee.List<Method> get_methods ();
	public abstract Gee.List<Signal> get_signals ();
	public abstract Gee.List<Property> get_properties ();

	/**
	 * Appends the specified parameter to the list of type parameters.
	 *
	 * @param p a type parameter
	 */
	public void add_type_parameter (TypeParameter p) {
		type_parameters.add (p);
		p.type = this;
		scope.add (p.name, p);
	}

	/**
	 * Returns a copy of the type parameter list.
	 *
	 * @return list of type parameters
	 */
	public Gee.List<TypeParameter> get_type_parameters () {
		return new ReadOnlyList<TypeParameter> (type_parameters);
	}

	public override int get_type_parameter_index (string name) {
		int i = 0;
		foreach (TypeParameter parameter in type_parameters) {
			if (parameter.name == name) {
				return i;
			}
			i++;
		}
		return -1;
	}
}
