/* gidocgenparser.vala
 *
 * Copyright 2026 Collabora Ltd. (https://collabora.com)
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
 * 	Corentin Noël <corentin.noel@collabora.com>
 */


using Valadoc.Content;

/**
 * Scanner recognizing gi-docgen `[kind@Target]` symbol links.
 */
public class Valadoc.GiDocgen.Scanner : Gtkdoc.MarkdownScanner {
	public static Valadoc.TokenType LINK = new Valadoc.TokenType.basic ("<gi-docgen-link>");

	private Regex regex_link;

	public Scanner () {
		try {
			regex_link = new Regex ("^\\[(alias|callback|class|const|ctor|enum|error|flags|func|id|iface|method|property|signal|struct|type|vfunc|ctype)@([A-Za-z0-9_.:-]+)(#([^\\]\\s]+))?\\]");
		} catch (Error e) {
			assert_not_reached ();
		}
	}

	protected override void accept (unichar c) throws ParserError {
		MatchInfo? info = null;
		if (_skip == 0 && c == '[' && regex_link.match (_index, 0, out info)) {
			_column++;
			_skip = info.fetch (0).length - 1;
			string? fragment = info.fetch (4);
			emit_token (LINK, info.fetch (1) + "@" + info.fetch (2) + (fragment != null ? "#" + fragment : ""));
			return;
		}

		base.accept (c);
	}
}

/**
 * Parser for gi-docgen documentation: Markdown with `[kind@Target]` symbol links.
 */
public class Valadoc.GiDocgen.Parser : Gtkdoc.MarkdownParser {
	public Parser (Settings settings, ErrorReporter reporter, Api.Tree? tree, ModuleLoader modules) {
		base (settings, reporter, tree, modules);
	}

	protected override Gtkdoc.MarkdownScanner create_scanner () {
		return new Scanner ();
	}

	protected override Rule[] get_extra_inline_rules () {
		Rule link = Rule.seq ({
			Scanner.LINK.action ((token) => {
				add_link (token.value);
			})
		})
		.set_name ("GiDocgenLink");

		return { link };
	}

	private void add_link (string value) {
		string[] parts = value.split ("@", 2);
		string kind = parts[0];
		string target = parts[1];
		string? fragment = null;
		int fragment_start = target.index_of_char ('#');
		if (fragment_start >= 0) {
			fragment = target.substring (fragment_start + 1);
			target = target.substring (0, fragment_start);
		}

		if (kind == "id" || kind == "ctype") {
			add_symbol_link ("c::" + target, false, fragment);
			return;
		}

		// Properties and signals are children of their type in the API tree
		target = target.replace ("::", ".").replace (":", ".").replace ("-", "_");
		add_symbol_link (target, false, fragment);
	}
}
