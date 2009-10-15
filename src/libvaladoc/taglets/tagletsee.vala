/* taglet.vala
 *
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using GLib;
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

	public override void check (Tree api_root, Api.Node? container, ErrorReporter reporter) {
		symbol = api_root.search_symbol_str (container, symbol_name);
		if (symbol == null) {
			// TODO use ContentElement's source reference
			reporter.simple_error ("%s does not exist".printf (symbol_name));
		}
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_taglet (this);
	}
}
