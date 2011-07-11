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

public class Valadoc.Importer.ValadoDocumentationScanner : Object, Scanner {

	public ValadoDocumentationScanner (Settings settings) {
		_settings = settings;
	}

	private Settings _settings;
	private Parser _parser;

	private string _content;
	private int _index;
	private bool _stop;
	private int _last_index;
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
		_last_index = 0;
		_last_line = 0;
		_last_column = 0;
		_line = 0;
		_column = 0;
		_last_char = 0;
		_skip = 0;
		_current_string.erase (0, -1);
	}

	public void scan (string _content) throws ParserError {
		this._content = _content;
		for (_index = 0; !_stop && _index < _content.length; _index++) {
			unichar c = _content[_index];
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
		int i = _index;
		while (i > 0 && _content[i-1] != '\n') {
			i--;
		}
		StringBuilder builder = new StringBuilder ();
		while (i < _content.length && _content[i] != '\n') {
			unichar c = _content[i++];
			if (c == '\t') {
				builder.append (" ");
			} else {
				builder.append_unichar (c);
			}
		}
		return builder.str;
	}

	protected unichar get_next_char (int offset = 1) {
		return _content[_index + offset];
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

	private SourceLocation get_begin () {
		return SourceLocation (_last_line, get_line_start_column () + _last_column);
	}

	private SourceLocation get_end (int offset = 0) {
		return SourceLocation (_line, get_line_start_column () + _column + offset);
	}

	private void emit_current_word () throws ParserError {
		if (_current_string.len > 0) {
			_parser.accept_token (new Token.from_word (_current_string.str, get_begin (), get_end (-1)));
			_current_string.erase (0, -1);

			_last_index = _index;
			_last_line = _line;
			_last_column = _column - 1;
		}
	}

	private void emit_token (TokenType type) throws ParserError {
		emit_current_word ();

		_parser.accept_token (new Token.from_type (type, get_begin (), get_end (_skip)));

		_last_index = _index;
		_last_line = _line;
		_last_column = _column;
	}
}
