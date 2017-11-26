/* valadodocumentationscanner.vala
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


public class Valadoc.Importer.ValadocDocumentationScanner : Object, Scanner {

	public ValadocDocumentationScanner (Settings settings) {
		_settings = settings;
	}

	private Settings _settings;
	private Parser _parser;

	private string _content;
	private unowned string _index;
	private bool _stop;
	private int _last_line;
	private int _last_column;
	private int _line;
	private int _column;
	private unichar _last_char;
	private int _skip;
	private StringBuilder _current_string = new StringBuilder ();

	public void set_parser (Parser parser) {
		_parser = parser;
	}

	public virtual void reset () {
		_stop = false;
		_last_line = 0;
		_last_column = 0;
		_line = 0;
		_column = 0;
		_last_char = 0;
		_skip = 0;
		_current_string.erase (0, -1);
	}

	public void scan (string content) throws ParserError {
		this._content = content;

		for (_index = _content; !_stop && _index.get_char () != 0; _index = _index.next_char ()) {
			unichar c = _index.get_char ();
			accept (c);
		}
	}

	public void end () throws ParserError {
		emit_token (TokenType.EOF);
	}

	public virtual void stop () {
		_stop = true;
	}

	public int get_line () {
		return _line;
	}

	public virtual string get_line_content () {
		StringBuilder builder = new StringBuilder ();
		weak string line_start = _index;
		unichar c;

		while ((char*) line_start > (char*) _content && line_start.prev_char ().get_char () != '\n') {
			line_start = line_start.prev_char ();
		}

		while ((c = line_start.get_char ()) != '\n' && c != '\0') {
			if (c == '\t') {
				builder.append_c (' ');
			} else {
				builder.append_unichar (c);
			}
			line_start = line_start.next_char ();
		}

		return builder.str;
	}

	protected unichar get_next_char (int offset = 1) {
		return _index.get_char (_index.index_of_nth_char (offset));
	}


	protected void accept (unichar c) throws ParserError {
		_column++;
		if (_skip == 0) {
			switch (c) {
			case '/':
				if (get_next_char (1) == '*') {
					emit_token (TokenType.VALADOC_COMMENT_START);
					_skip = 1;
				} else {
					append_char (c);
				}
				break;

			case '*':
				if (get_next_char (1) == '/') {
					emit_token (TokenType.VALADOC_COMMENT_END);
					_skip = 1;
				} else {
					append_char (c);
				}
				break;

			case '\t':
				emit_token (TokenType.VALADOC_TAB);
				break;

			case ' ':
				emit_token (TokenType.VALADOC_SPACE);
				break;

			case '\n':
				emit_token (TokenType.VALADOC_EOL);
				_line++;
				_column = 0;
				_last_column = 0;
				break;

			default:
				append_char (c);
				break;
			}
		} else {
			_skip--;
		}
		_last_char = c;
	}

	private void append_char (unichar c) {
		_current_string.append_unichar (c);
	}

	public virtual int get_line_start_column () {
		return 0;
	}

	private Vala.SourceLocation get_begin () {
		return Vala.SourceLocation (_index, _last_line, get_line_start_column () + _last_column);
	}

	private Vala.SourceLocation get_end (int offset = 0) {
		return Vala.SourceLocation (_index, _line, get_line_start_column () + _column + offset);
	}

	private void emit_current_word () throws ParserError {
		if (_current_string.len > 0) {
			_parser.accept_token (new Token.from_word (_current_string.str, get_begin (), get_end (-1)));
			_current_string.erase (0, -1);

			_last_line = _line;
			_last_column = _column - 1;
		}
	}

	private void emit_token (TokenType type) throws ParserError {
		emit_current_word ();

		_parser.accept_token (new Token.from_type (type, get_begin (), get_end (_skip)));

		_last_line = _line;
		_last_column = _column;
	}

}
