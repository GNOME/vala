/* taglet.vala
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


using Valadoc.Content;

public class Valadoc.Taglets.Link : InlineTaglet {
	public string symbol_name { internal set; get; }

	/**
	 * Accept leading 's', e.g. #Widgets
	 */
	public bool c_accept_plural { internal set; get; }

	/**
	 * True if symbol_name could only be resolved after removing 's'
	 *
	 * E.g. true or #Widgets, false for #Widget
	 */
	public bool c_is_plural { private set; get; }


	private enum SymbolContext {
		NORMAL,
		FINISH,
		TYPE
	}

	private SymbolContext _context = SymbolContext.NORMAL;
	private Api.Node _symbol;

	public override Rule? get_parser_rule (Rule run_rule) {
		return Rule.seq ({
			Rule.option ({
				Rule.many ({
					Rule.one_of({
						TokenType.SPACE,
						TokenType.EOL
					})
				})
			}),
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
			string? singular_symbol_name = (c_accept_plural && _symbol_name.has_suffix ("s"))
				? symbol_name.substring (0, _symbol_name.length - 1)
				: null;

			_symbol = api_root.search_symbol_cstr (container, symbol_name);
			if (_symbol == null && singular_symbol_name != null) {
				_symbol = api_root.search_symbol_cstr (container, singular_symbol_name);
				c_is_plural = true;
			}
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
				if (_symbol == null && singular_symbol_name != null) {
					_symbol = api_root.search_symbol_type_cstr (singular_symbol_name);
					c_is_plural = true;
				}
				if (_symbol != null) {
					_context = SymbolContext.TYPE;
				}
			}

			if (_symbol != null) {
				symbol_name = _symbol.name;
			}
		} else {
			_symbol = api_root.search_symbol_str (container, symbol_name);
		}

		if (_symbol == null && symbol_name != "main") {
			string node_segment = (container is Api.Package)? "" : container.get_full_name () + ": ";
			reporter.simple_warning ("%s: %s@link".printf (file_path, node_segment),
									 "`%s' does not exist", symbol_name);
		}

		base.check (api_root, container, file_path, reporter, settings);
	}

	public override ContentElement produce_content () {
		var link = new Content.SymbolLink ();
		link.symbol = _symbol;
		link.given_symbol_name = symbol_name;

		Content.Inline content;
		switch (_context) {
		case SymbolContext.FINISH:
			link.given_symbol_name += ".end";
			content = link;
			break;

		case SymbolContext.TYPE:
			Run run = new Content.Run (Run.Style.MONOSPACED);
			content = run;

			Content.Run keyword = new Content.Run (Run.Style.LANG_KEYWORD);
			keyword.content.add (new Content.Text ("typeof"));
			run.content.add (keyword);

			run.content.add (new Content.Text (" ("));
			run.content.add (link);
			run.content.add (new Content.Text (")"));
			break;

		default:
			content = link;
			break;
		}

		if (c_is_plural == true) {
			Run run = new Content.Run (Run.Style.NONE);
			run.content.add (content);
			run.content.add (new Content.Text ("s"));
			return run;
		}

		return content;
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
		link.c_accept_plural = c_accept_plural;
		link.c_is_plural = c_is_plural;
		link._context = _context;
		link._symbol = _symbol;

		return link;
	}
}
