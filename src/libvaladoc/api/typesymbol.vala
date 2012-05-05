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

using Gee;


/**
 * Represents a runtime data type.
 */
public abstract class Valadoc.Api.TypeSymbol : Symbol {
	private SourceComment? source_comment;

	public TypeSymbol (Node parent, SourceFile file, string name, SymbolAccessibility accessibility, SourceComment? comment, bool is_basic_type, void* data) {
		base (parent, file, name, accessibility, data);

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
	 * {@inheritDoc}
	 */
	internal override void process_comments (Settings settings, DocumentationParser parser) {
		if (source_comment != null) {
			documentation = parser.parse (this, source_comment);
		}

		base.process_comments (settings, parser);
	}
}
