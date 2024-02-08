/* gidocgenparser.vala
 *
 * Copyright (C) 2023 Corentin Noël
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
using Valadoc;

public class Valadoc.Gidocgen.Parser : Object, ResourceLocator {
	private Valadoc.Parser parser;
	private Content.ContentFactory _factory;

	private Vala.ArrayList<Object> _stack = new Vala.ArrayList<Object> ();

	private Settings _settings;
	private ErrorReporter _reporter;
	private Api.Tree _tree;

	private Importer.InternalIdRegistrar id_registrar;
	private GirMetaData metadata;
	private Api.GirSourceComment gir_comment;
	private Api.Node element;

	public Parser (Settings settings, ErrorReporter reporter, Api.Tree? tree, ModuleLoader _modules) {
		MarkdownScanner scanner = new MarkdownScanner (settings);
		parser = new Valadoc.Parser (settings, scanner, reporter);
		scanner.set_parser (parser);


		_factory = new Content.ContentFactory (settings, this, _modules);
		_settings = settings;
		_reporter = reporter;
		_tree = tree;
	}

	public Comment? parse (Api.Node element, Api.GirSourceComment gir_comment, GirMetaData metadata, Importer.InternalIdRegistrar id_registrar) {
		this.metadata = metadata;
		this.id_registrar = id_registrar;
		this.gir_comment = gir_comment;
		this.element = element;

		// main:
		Comment? cmnt = _parse (gir_comment);
		if (cmnt != null) {
			ImporterHelper.extract_short_desc (cmnt, _factory);
		}
		return null;
	}

	private Comment? _parse (Api.SourceComment comment) {
		try {
			_stack.clear ();
			parser.parse (comment.content, comment.file.get_name (), comment.first_line, comment.first_column);
			return (Comment) pop ();
		} catch (ParserError e) {
			return null;
		}
	}

	private Object peek (int offset = -1) {
		assert (_stack.size >= - offset);
		return _stack.get (_stack.size + offset);
	}

	private Object pop () {
		Object node = peek ();
		_stack.remove_at (_stack.size - 1);
		return node;
	}

	public string resolve (string path) {
		return path;
	}
}
