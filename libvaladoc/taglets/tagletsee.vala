/* tagletsee.vala
 *
 * Copyright (C) 2008-2009 Didier Villevalois
 * Copyright (C) 2008-2012 Florian Brosch
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


using Valadoc.Content;

public class Valadoc.Taglets.See : ContentElement, Taglet, Block {
	public string symbol_name { private set; get; }
	public Api.Node symbol { private set; get; }

	public Rule? get_parser_rule (Rule run_rule) {
		Rule optional_spaces = Rule.option ({ Rule.many ({ TokenType.SPACE }) });

		return Rule.seq ({
			optional_spaces,
			TokenType.any_word ().action ((token) => { symbol_name = token.to_string (); }),
			optional_spaces
		});
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings) {
		if (symbol_name.has_prefix ("c::")) {
			symbol_name = symbol_name.substring (3);
			symbol = api_root.search_symbol_cstr (container, symbol_name);
			if (symbol != null) {
				symbol_name = _symbol.name;
			}
		} else {
			symbol = api_root.search_symbol_str (container, symbol_name);
		}

		if (symbol == null) {
			// TODO use ContentElement's source reference
			reporter.simple_warning ("%s: %s: @see".printf (file_path, container.get_full_name ()),
									 "`%s' does not exist", symbol_name);
		}
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_taglet (this);
	}

	public override bool is_empty () {
		return false;
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		See see = new See ();
		see.parent = new_parent;

		see.symbol_name = symbol_name;
		see.symbol = symbol;

		return see;
	}}
