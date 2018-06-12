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
	private SourceComment? source_comment;
	private string? type_macro_name;
	private string? is_type_macro_name;
	private string? type_cast_macro_name;
	private string? type_function_name;

	public TypeSymbol (Node parent, SourceFile file, string name, SymbolAccessibility accessibility,
					   SourceComment? comment, string? type_macro_name, string? is_type_macro_name,
					   string? type_cast_macro_name, string? type_function_name, bool is_basic_type,
					   Vala.TypeSymbol data)
	{
		base (parent, file, name, accessibility, data);

		this.type_cast_macro_name = type_cast_macro_name;
		this.is_type_macro_name = is_type_macro_name;
		this.type_function_name = type_function_name;
		this.type_macro_name = type_macro_name;

		this.is_basic_type = is_basic_type;
		this.source_comment = comment;
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
	public string get_type_macro_name () {
		return type_macro_name;
	}

	/**
	 * Gets the name of the GType macro which casts a type instance to the given type.
	 */
	public string get_type_cast_macro_name () {
		return type_cast_macro_name;
	}

	/**
	 * Gets the name of the GType macro which determines whether a type instance is of a given type.
	 */
	public string get_is_type_macro_name () {
		return is_type_macro_name;
	}

	/**
	 * Gets the name of the get_type() function which represents the type symbol
	 */
	public string get_type_function_name () {
		return type_function_name;
	}

	/**
	 * {@inheritDoc}
	 */
	internal override void parse_comments (Settings settings, DocumentationParser parser) {
		if (documentation != null) {
			return ;
		}

		if (source_comment != null) {
			documentation = parser.parse (this, source_comment);
		}

		base.parse_comments (settings, parser);
	}

	/**
	 * {@inheritDoc}
	 */
	internal override void check_comments (Settings settings, DocumentationParser parser) {
		if (documentation != null) {
			parser.check (this, documentation);
		}

		base.check_comments (settings, parser);
	}
}
