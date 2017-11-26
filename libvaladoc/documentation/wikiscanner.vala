/* wikiscanner.vala
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


public class Valadoc.WikiScanner : Object, Scanner {

	public WikiScanner (Settings settings) {
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
	private bool _url_escape_mode;
	private bool _code_escape_mode;
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
		_url_escape_mode = false;
		_code_escape_mode = false;
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

	public void set_url_escape_mode (bool escape_mode) {
		_url_escape_mode = escape_mode;
	}

	public void set_code_escape_mode (bool escape_mode) {
		_code_escape_mode = escape_mode;
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

	protected virtual void accept (unichar c) throws ParserError {
		_column++;
		if (_skip == 0) {
			if (_code_escape_mode) {
				if (c == '}' && get_next_char (1) == '}' && get_next_char (2) == '}') {
					_code_escape_mode = false; // This is a temporary hack
					emit_token (TokenType.TRIPLE_CLOSED_BRACE);
					_skip = 2;
				} else {
					append_char (c);
				}
				return;
			} else if (_url_escape_mode) {
				switch (c) {
				// Reserved characters
				case ';':
				case '/':
				case '?':
				case ':':
				case '@':
				case '#':
				case '=':
				case '&':
				// Special characters
				case '$':
				case '-':
				case '_':
				case '.':
				case '+':
				case '!':
				case '*':
				case '\'':
				case '(':
				case ')':
				case ',':
					append_char (c);
					return;
				default:
					break;
				}
			}

			switch (c) {
			case '@':
				emit_token (TokenType.AROBASE);
				break;

			case '{':
				look_for_three (c,
				                TokenType.OPEN_BRACE,
				                TokenType.DOUBLE_OPEN_BRACE,
				                TokenType.TRIPLE_OPEN_BRACE);
				break;

			case '}':
				look_for_three (c,
				                TokenType.CLOSED_BRACE,
				                TokenType.DOUBLE_CLOSED_BRACE,
				                TokenType.TRIPLE_CLOSED_BRACE);
				break;

			case '[':
				look_for_two_or_append (c, TokenType.DOUBLE_OPEN_BRACKET);
				break;

			case ']':
				look_for_two_or_append (c, TokenType.DOUBLE_CLOSED_BRACKET);
				break;

			case '|':
				look_for_two (c,
				              TokenType.PIPE,
				              TokenType.DOUBLE_PIPE);
				break;

			case ')':
				if (get_next_char () == ')') {
					emit_token (TokenType.ALIGN_RIGHT);
					_skip = 1;
				} else if (get_next_char () == '(') {
					emit_token (TokenType.ALIGN_CENTER);
					_skip = 1;
				} else {
					append_char (c);
				}
				break;

			case '-':
				emit_token (TokenType.MINUS);
				break;

			case '=':
				look_for_five (c,
	                           TokenType.EQUAL_1,
	                           TokenType.EQUAL_2,
	                           TokenType.EQUAL_3,
	                           TokenType.EQUAL_4,
	                           TokenType.EQUAL_5);
				break;

			case '<':
				if (!look_for ("<<BR>>", TokenType.BREAK)) {
					emit_token (TokenType.LESS_THAN);
				}
				break;

			case '>':
				emit_token (TokenType.GREATER_THAN);
				break;

			case '^':
				emit_token (TokenType.ALIGN_TOP);
				break;

			case 'v':
				unichar next_char = get_next_char ();
				if (_last_char.isalnum () || _last_char == ' '
					|| next_char.isalnum () || next_char == ' ') {
					append_char (c);
				} else {
					emit_token (TokenType.ALIGN_BOTTOM);
				}
				break;

			case '\'':
				look_for_two_or_append (c, TokenType.SINGLE_QUOTE_2);
				break;

			case '/':
				look_for_two_or_append (c, TokenType.SLASH_2);
				break;

			case '_':
				look_for_two_or_append (c, TokenType.UNDERSCORE_2);
				break;

			case '`':
				if (get_next_char () == '`') {
					emit_token (TokenType.BACK_QUOTE_2);
					_skip = 1;
				} else {
					append_char (c);
				}
				break;

			case '\t':
				emit_token (TokenType.TAB);
				break;

			case ' ':
				emit_token (TokenType.SPACE);
				break;

			case '\r':
				break;

			case '\n':
				emit_token (TokenType.EOL);
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

	private void look_for_two_or_append (unichar c, TokenType type) throws ParserError {
		if (get_next_char () == c) {
			emit_token (type);
			_skip = 1;
		} else {
			append_char (c);
		}
	}

	private void look_for_two (unichar c, TokenType one, TokenType two) throws ParserError {
		if (get_next_char (1) == c) {
			emit_token (two);
			_skip = 1;
		} else {
			emit_token (one);
		}
	}

	private void look_for_three (unichar c, TokenType one, TokenType two, TokenType three)
								 throws ParserError
	{
		if (get_next_char (1) == c) {
			if (get_next_char (2) == c) {
				emit_token (three);
				_skip = 2;
			} else {
				emit_token (two);
				_skip = 1;
			}
		} else {
			emit_token (one);
		}
	}

	private void look_for_five (unichar c, TokenType one, TokenType two, TokenType three,
								TokenType four, TokenType five) throws ParserError
	{
		if (get_next_char (1) == c) {
			if (get_next_char (2) == c) {
				if (get_next_char (3) == c) {
					if (get_next_char (4) == c) {
						emit_token (five);
						_skip = 4;
					} else {
						emit_token (four);
						_skip = 3;
					}
				} else {
					emit_token (three);
					_skip = 2;
				}
			} else {
				emit_token (two);
				_skip = 1;
			}
		} else {
			emit_token (one);
		}
	}

	private bool look_for (string str, TokenType type) throws ParserError {
		for (int i = 1; i < str.length; i++) {
			if (get_next_char (i) != str[i]) {
				return false;
			}
		}

		emit_token (type);
		_skip = (int) (str.length - 1);
		return true;
	}
}
