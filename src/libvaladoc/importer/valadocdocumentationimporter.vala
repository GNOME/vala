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


using Gee;
using Valadoc;
using Valadoc.Content;

public class Valadoc.Importer.ValadocDocumentationImporter : DocumentationImporter, ResourceLocator {
	public override string file_extension { get { return "valadoc"; } }

	private ValadoDocumentationScanner _scanner;
	private DocumentationParser _doc_parser;
	private Parser _parser;

	private MappedFile _mapped_file;
	private string _filename;
	private string _cname;
	private StringBuilder _comment;
	private SourceLocation _comment_location;

	private ErrorReporter reporter;

	public ValadocDocumentationImporter (Api.Tree tree, DocumentationParser parser, ModuleLoader modules, Settings settings, ErrorReporter reporter) {
		base (tree, modules, settings);
		this.reporter = reporter;

		_scanner = new ValadoDocumentationScanner (settings);
		_doc_parser = parser;

		_scanner = new ValadoDocumentationScanner (settings);
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

		Rule documentation = Rule.seq ({
			TokenType.ANY_WORD.action ((token) => { _cname = token.to_string (); }),
			optional_empty_lines,
			TokenType.VALADOC_COMMENT_START.action ((token) => { _comment_location = token.end; }),
			Rule.many ({
				Rule.one_of ({
					TokenType.ANY_WORD.action ((token) => { _comment.append (token.to_string ()); }),
					TokenType.VALADOC_COMMENT_START.action ((token) => { _comment.append (token.to_string ()); }),
					TokenType.VALADOC_SPACE.action ((token) => { _comment.append (token.to_string ()); }),
					TokenType.VALADOC_TAB.action ((token) => { _comment.append (token.to_string ()); }),
					TokenType.VALADOC_EOL.action ((token) => { _comment.append (token.to_string ()); })
				})
			}),
			TokenType.VALADOC_COMMENT_END
		})
		.set_name ("Documentation")
		.set_reduce (() => {
			add_documentation (_cname, _comment, _filename, _comment_location);
	 		_comment.erase ();
			_cname = null;
		});

		Rule file = Rule.many ({
			optional_empty_lines,
			documentation,
			optional_empty_lines
		})
		.set_name ("ValadocFile");

		_parser.set_root_rule (file);
	}

	private void add_documentation (string symbol_name, StringBuilder comment, string filename, SourceLocation src_ref) {
		Api.Node? symbol = null;

		if (symbol_name.has_prefix ("c::")) {
			symbol = tree.search_symbol_cstr (symbol_name.offset (3));
		} else {
			symbol = tree.search_symbol_str (null, symbol_name);
		}

		if (symbol == null) {
			reporter.simple_warning ("%s does not exist".printf (symbol_name));
		} else {
			var docu = _doc_parser.parse_comment_str (symbol, comment.str, filename, src_ref.line, src_ref.column);
			if (docu != null) {
				symbol.documentation = docu;
			}
		}
	}

	public override void process (string filename) {
		try {
			_filename = filename;
			_mapped_file = new MappedFile (filename, false);
			_parser.parse ((string) _mapped_file.get_contents (), filename, 0, 0);
		} catch (FileError err) {
			reporter.simple_error ("Unable to map file `%s': %s".printf (filename, err.message));
		} catch (ParserError err) {
		}
	}

	public string resolve (string path) {
		return path;
	}
}


