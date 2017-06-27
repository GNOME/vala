/* member.vala
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


public abstract class Valadoc.Api.Member : Symbol {
	private SourceComment? source_comment;

	public Member (Node parent, SourceFile file, string name, SymbolAccessibility accessibility,
				   SourceComment? comment, void* data)
	{
		base (parent, file, name, accessibility, data);

		this.source_comment = comment;
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
