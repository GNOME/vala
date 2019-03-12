/* typesymbol.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
 * Copyright (C) 2011      Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */


/**
 * Represents a runtime data type.
 */
public abstract class Valadoc.Api.TypeSymbol : Symbol {
	protected TypeSymbol (Node parent, SourceFile file, string name, Vala.SymbolAccessibility accessibility,
					   SourceComment? comment, bool is_basic_type,
					   Vala.TypeSymbol data)
	{
		base (parent, file, name, accessibility, comment, data);

		this.is_basic_type = is_basic_type;
	}

	/**
	 * Specifies whether this symbol is a basic type (string, int, char, etc)
	 */
	public bool is_basic_type {
		private set;
		get;
	}

	/**
	 * Gets the name of the GType macro which represents the type symbol
	 */
	public string? get_type_macro_name () {
		if ((data is Vala.Class
			&& ((Vala.Class) data).is_compact)
			|| data is Vala.ErrorDomain
			|| data is Vala.Delegate)
		{
			return null;
		}

		return Vala.get_ccode_type_id (data);
	}

	/**
	 * Gets the name of the GType macro which casts a type instance to the given type.
	 */
	public string? get_type_cast_macro_name () {
		if ((data is Vala.Class
			&& !((Vala.Class) data).is_compact)
			|| data is Vala.Interface)
		{
			return Vala.get_ccode_upper_case_name ((Vala.TypeSymbol) data, null);
		} else {
			return null;
		}
	}

	/**
	 * Gets the name of the GType macro which determines whether a type instance is of a given type.
	 */
	public string? get_is_type_macro_name () {
		if ((data is Vala.Class
			&& !((Vala.Class) data).is_compact)
			|| data is Vala.Interface)
		{
			return Vala.get_ccode_type_check_function ((Vala.TypeSymbol) data);
		} else {
			return null;
		}
	}

	/**
	 * Gets the name of the get_type() function which represents the type symbol
	 */
	public string? get_type_function_name () {
		if ((data is Vala.Class
			&& ((Vala.Class) data).is_compact)
			|| data is Vala.ErrorDomain
			|| data is Vala.Delegate)
		{
			return null;
		}

		return "%s_get_type".printf (Vala.get_ccode_lower_case_name (data, null));
	}
}
