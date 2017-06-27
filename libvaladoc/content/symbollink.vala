/* symbollink.vala
 *
 * Copyright (C) 2008-2009 Didier Villevalois
 * Copyright (C) 2008-2014 Florian Brosch
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


public class Valadoc.Content.SymbolLink : InlineContent, Inline {
	public Api.Node symbol {
		get;
		set;
	}

	public string given_symbol_name {
		get;
		set;
	}

	internal SymbolLink (Api.Node? symbol = null, string? given_symbol_name = null) {
		base ();
		_symbol = symbol;
		_given_symbol_name = given_symbol_name;
	}

	public override void configure (Settings settings, ResourceLocator locator) {
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings)
	{
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_symbol_link (this);
	}

	public override bool is_empty () {
		return false;
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		SymbolLink link = new SymbolLink (symbol, _given_symbol_name);
		link.parent = new_parent;

		foreach (Inline element in content) {
			Inline copy = element.copy (link) as Inline;
			link.content.add (copy);
		}

		return link;
	}
}

