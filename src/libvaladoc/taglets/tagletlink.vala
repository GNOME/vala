/* taglet.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
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
using Valadoc.Content;


public class Valadoc.Taglets.Link : InlineTaglet {
	public string symbol_name { internal set; get; }

	private Api.Node _symbol;

	public override Rule? get_parser_rule (Rule run_rule) {
		return Rule.seq ({
			TokenType.any_word ().action ((token) => { symbol_name = token.to_string (); })
		});
	}

	public override void check (Api.Tree api_root, Api.Node container, ErrorReporter reporter, Settings settings) {
		if (symbol_name.has_prefix ("c::")) {
			_symbol_name = _symbol_name.offset (3);
			_symbol = api_root.search_symbol_cstr (symbol_name);
			if (_symbol != null) {
				symbol_name = _symbol.name;
			}
		} else {
			_symbol = api_root.search_symbol_str (container, symbol_name);
		}

		if (_symbol == null) {
			// TODO use ContentElement's source reference
			reporter.simple_warning ("%s does not exist".printf (symbol_name));
		}

		base.check (api_root, container, reporter, settings);
	}

	public override ContentElement produce_content () {
		var link = new Content.SymbolLink ();
		link.symbol = _symbol;
		link.label = symbol_name;
		return link;
	}
}
