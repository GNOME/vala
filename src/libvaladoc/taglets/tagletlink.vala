/* taglet.vala
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

using Gee;
using Valadoc.Content;


public class Valadoc.Taglets.Link : InlineTaglet {
	public string symbol_name { internal set; get; }

	private enum SymbolContext {
		NORMAL,
		FINISH,
		TYPE
	}

	private SymbolContext _context = SymbolContext.NORMAL;
	private Api.Node _symbol;

	public override Rule? get_parser_rule (Rule run_rule) {
		return Rule.seq ({
			Rule.option ({ Rule.many ({ TokenType.SPACE }) }),
			TokenType.any_word ().action ((token) => { symbol_name = token.to_string (); }),
			Rule.option ({
				Rule.many ({
					Rule.one_of ({
						TokenType.any_word ().action ((token) => { symbol_name += token.to_string (); }),
						TokenType.MINUS.action ((token => { symbol_name += token.to_string (); }))
					})
				})
			})
		});
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings) {
		if (symbol_name.has_prefix ("c::")) {
			_symbol_name = _symbol_name.substring (3);
			_symbol = api_root.search_symbol_cstr (container, symbol_name);
			_context = SymbolContext.NORMAL;

			if (_symbol == null && _symbol_name.has_suffix ("_finish")) {
				string tmp = _symbol_name.substring (0, _symbol_name.length - 7);

				_symbol = api_root.search_symbol_cstr (container, tmp + "_async") as Api.Method;
				if (_symbol != null && ((Api.Method) _symbol).is_yields) {
					_context = SymbolContext.FINISH;
				} else {
					_symbol = api_root.search_symbol_cstr (container, tmp) as Api.Method;
					if (_symbol != null && ((Api.Method) _symbol).is_yields) {
						_context = SymbolContext.FINISH;
					} else {
						_symbol = null;
					}
				}
			}

			if (_symbol == null) {
				_symbol = api_root.search_symbol_type_cstr (symbol_name);
				if (_symbol != null) {
					_context = SymbolContext.TYPE;
				}
			}

			if (_symbol != null) {
				symbol_name = _symbol.name;

				if (_context == SymbolContext.FINISH) {
					symbol_name = symbol_name + ".end";
				}
			}
		} else {
			_symbol = api_root.search_symbol_str (container, symbol_name);
		}

		if (_symbol == null && symbol_name != "main") {
			string node_segment = (container is Api.Package)? "" : container.get_full_name () + ": ";
			reporter.simple_warning ("%s: %s@link: warning: %s does not exist",
									 file_path, node_segment, symbol_name);
		}

		base.check (api_root, container, file_path, reporter, settings);
	}

	public override ContentElement produce_content () {
		var link = new Content.SymbolLink ();
		link.symbol = _symbol;
		link.label = symbol_name;

		// TODO: move typeof () to gtkdoc-importer
		switch (_context) {
		case SymbolContext.FINISH:
			// covered by symbol_name
			return link;

		case SymbolContext.TYPE:
			Content.Run content = new Content.Run (Run.Style.MONOSPACED);

			Content.Run keyword = new Content.Run (Run.Style.LANG_KEYWORD);
			keyword.content.add (new Content.Text ("typeof"));
			content.content.add (keyword);

			content.content.add (new Content.Text (" ("));
			content.content.add (link);
			content.content.add (new Content.Text (")"));
			return content;

		default:
			return link;
		}
	}

	public override bool is_empty () {
		return false;
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		Link link = new Link ();
		link.parent = new_parent;

		link.settings = settings;
		link.locator = locator;

		link.symbol_name = symbol_name;
		link._context = _context;
		link._symbol = _symbol;

		return link;
	}
}
