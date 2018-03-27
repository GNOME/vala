/* resourcelocator.vala
 *
 * Copyright (C) 2010 Florian Brosch
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
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc;
using Valadoc.Content;

public class Valadoc.Importer.ValadocDocumentationImporter : DocumentationImporter, ResourceLocator {
	public override string file_extension { get { return "valadoc"; } }

	private ValadocDocumentationScanner _scanner;
	private DocumentationParser _doc_parser;
	private Parser _parser;

	private MappedFile _mapped_file;
	private string _filename;
	private string _cname;
	private StringBuilder _comment;
	private Vala.SourceLocation _comment_location;
	protected Content.ContentFactory factory;


	private ErrorReporter reporter;

	public ValadocDocumentationImporter (Api.Tree tree, DocumentationParser parser, ModuleLoader modules,
										 Settings settings, ErrorReporter reporter)
	{
		base (tree, modules, settings);
		this.factory = new Content.ContentFactory (settings, this, modules);
		this.reporter = reporter;

		_scanner = new ValadocDocumentationScanner (settings);
		_doc_parser = parser;

		_scanner = new ValadocDocumentationScanner (settings);
		_parser = new Parser (settings, _scanner, reporter);
		_scanner.set_parser (_parser);

		_comment = new StringBuilder ();

		// init parser rules:
		Rule unprinted_spaces = Rule.many ({
			Rule.one_of ({
				TokenType.VALADOC_SPACE,
				TokenType.VALADOC_TAB
			})
		});

		Rule empty_lines = Rule.many ({
			Rule.one_of ({
				unprinted_spaces,
				TokenType.VALADOC_EOL
			})
		})
		.set_name ("EmptyLines");

		Rule optional_empty_lines = Rule.option ({
			empty_lines
		});

		Rule documentation = Rule.one_of ({
			Rule.seq ({
				TokenType.VALADOC_COMMENT_START.action ((token) => { _comment_location = token.end; }),
				Rule.many ({
					Rule.one_of ({
						TokenType.ANY_WORD.action (add_comment),
						TokenType.VALADOC_COMMENT_START.action (add_comment),
						TokenType.VALADOC_SPACE.action (add_comment),
						TokenType.VALADOC_TAB.action (add_comment),
						TokenType.VALADOC_EOL.action (add_comment)
					})
				}),
				TokenType.VALADOC_COMMENT_END,
				optional_empty_lines,
				TokenType.ANY_WORD.action ((token) => { _cname = token.to_string (); })
			})
			.set_reduce (() => {
				add_documentation (_cname, _comment, _filename, _comment_location);
		 		_comment.erase ();
				_cname = null;
			}),

			TokenType.ANY_WORD.action ((token) => {
				add_documentation (token.to_string (), null, _filename, _comment_location);
			})
		})
		.set_name ("Documentation");

		Rule file = Rule.many ({
			Rule.one_of ({
				documentation,
				optional_empty_lines
			})
		})
		.set_name ("ValadocFile");

		_parser.set_root_rule (file);
	}

	private void add_comment (Token token) throws ParserError {
		_comment.append (token.to_string ());
	}

	private enum InsertionMode {
		APPEND,
		PREPEND,
		REPLACE
	}

	private void add_documentation (string _symbol_name, StringBuilder? comment, string filename,
									Vala.SourceLocation src_ref)
	{
		Api.Node? symbol = null;

		InsertionMode insertion_mode;
		string symbol_name;
		if (_symbol_name.has_suffix ("::append")) {
			symbol_name = _symbol_name.substring (0, _symbol_name.length - 8);
			insertion_mode = InsertionMode.APPEND;
		} else if (_symbol_name.has_suffix ("::prepend")) {
			symbol_name = _symbol_name.substring (0, _symbol_name.length - 9);
			insertion_mode = InsertionMode.PREPEND;
		} else {
			symbol_name = _symbol_name;
			insertion_mode = InsertionMode.REPLACE;
		}

		if (symbol_name.has_prefix ("c::")) {
			symbol = tree.search_symbol_cstr (null, symbol_name.substring (3));
		} else {
			symbol = tree.search_symbol_str (null, symbol_name);
		}

		if (symbol == null) {
			if (settings.verbose) {
				reporter.simple_warning (filename, "Node `%s' does not exist", symbol_name);
			}

			return ;
		}

		if (comment != null) {
			var docu = _doc_parser.parse_comment_str (symbol, comment.str, filename, src_ref.line, src_ref.column);
			if (docu != null) {
				docu.check (tree, symbol, filename, reporter, settings);

				if (symbol.documentation == null || insertion_mode == InsertionMode.REPLACE) {
					if (insertion_mode == InsertionMode.APPEND) {
						docu.content.insert (0, factory.create_paragraph ());
					}
					symbol.documentation = docu;
				} else if (insertion_mode == InsertionMode.APPEND) {
					symbol.documentation.content.add_all (docu.content);
					merge_taglets (symbol.documentation, docu);
				} else if (insertion_mode == InsertionMode.PREPEND) {
					symbol.documentation.content.insert_all (0, docu.content);
					merge_taglets (symbol.documentation, docu);
				}
			}
		}
	}

	private void merge_taglets (Comment comment, Comment imported) {
		foreach (Taglet taglet in imported.taglets) {
			imported.taglets.add (taglet);
		}
	}

	public override void process (string filename) {
		try {
			_filename = filename;
			_mapped_file = new MappedFile (filename, false);
			var content = _mapped_file.get_contents ();
			if (content != null) {
				_parser.parse ((string) content, filename, 0, 0);
			}
		} catch (FileError err) {
			reporter.simple_error (null, "Unable to map file `%s': %s", filename, err.message);
		} catch (ParserError err) {
		}
	}
}

