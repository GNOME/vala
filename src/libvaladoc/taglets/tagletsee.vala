/* tagletsee.vala
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


public class Valadoc.Taglets.See : ContentElement, Taglet, Block {
	public string symbol_name { private set; get; }
	public Api.Node symbol { private set; get; }

	public Rule? get_parser_rule (Rule run_rule) {
		return Rule.seq ({
			TokenType.any_word ().action ((token) => { symbol_name = token.to_string (); })
		});
	}

	public override void check (Api.Tree api_root, Api.Node container, ErrorReporter reporter, Settings settings) {
		if (symbol_name.has_prefix ("c::")) {
			symbol_name = symbol_name.offset (3);
			symbol = api_root.search_symbol_cstr (symbol_name);
			if (symbol != null) {
				symbol_name = _symbol.name;
			}
		} else {
			symbol = api_root.search_symbol_str (container, symbol_name);
		}

		if (symbol == null) {
			// TODO use ContentElement's source reference
			reporter.simple_warning ("%s does not exist".printf (symbol_name));
		}
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_taglet (this);
	}
}
