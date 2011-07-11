/* girdocuscanner.vala
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

public class Valadoc.Importer.GirDocumentationScanner : Object, Scanner {

	public GirDocumentationScanner (Settings settings) {
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
	private bool _code_element_escape_mode;
	private bool _code_escape_mode;
	private bool _node_name;
	private unichar _last_char;
	private int _skip;
	private StringBuilder _current_string = new StringBuilder ();

	public void set_parser (Parser parser) {
		_parser = parser;
	}

	public void reset () {
		_stop = false;
		_last_index = 0;
		_last_line = 0;
		_last_column = 0;
		_line = 0;
		_column = 0;
		_code_element_escape_mode = false;
		_code_escape_mode = false;
		_node_name = false;
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
		emit_token (TokenType.GTKDOC_EOF);
	}

	public void stop () {
		_stop = true;
	}

	public void set_code_element_escape_mode (bool escape_mode) {
		_code_element_escape_mode = escape_mode;
	}

	public void set_code_escape_mode (bool escape_mode) {
		_code_escape_mode = escape_mode;
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

	private void emit_xml_node_open_token (string name, int offset) throws ParserError {
		switch (name) {
		case "structname":
			emit_token (TokenType.GTKDOC_STRUCTNAME_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "link":
			emit_token (TokenType.GTKDOC_LINK_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "literal":
			emit_token (TokenType.GTKDOC_LITERAL_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "guimenuitem":
			emit_token (TokenType.GTKDOC_GUI_MENU_ITEM_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "replaceable":
			emit_token (TokenType.GTKDOC_REPLACEABLE_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "para":
			emit_token (TokenType.GTKDOC_PARA_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "note":
			emit_token (TokenType.GTKDOC_NOTE_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "itemizedlist":
			emit_token (TokenType.GTKDOC_ITEMIZED_LIST_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "listitem":
			emit_token (TokenType.GTKDOC_LIST_ITEM_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "warning":
			emit_token (TokenType.GTKDOC_WARNING_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "programlisting":
			emit_token (TokenType.GTKDOC_PROGRAMLISTING_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "informalexample":
			emit_token (TokenType.GTKDOC_EXAMPLE_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "variablelist":
			emit_token (TokenType.GTKDOC_VARIABLE_LIST_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "varlistentry":
			emit_token (TokenType.GTKDOC_VARIABLE_LIST_ENTRY_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "term":
			emit_token (TokenType.GTKDOC_TERM_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "envar":
			emit_token (TokenType.GTKDOC_ENVAR_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "option":
			emit_token (TokenType.GTKDOC_OPTION_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "emphasis":
			emit_token (TokenType.GTKDOC_EMPHASIS_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "filename":
			emit_token (TokenType.GTKDOC_FILENAME_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "simplelist":
			emit_token (TokenType.GTKDOC_SIMPLELIST_ELEMENT_OPEN);
			_skip = offset;
			break;

		case "member":
			emit_token (TokenType.GTKDOC_MEMBER_ELEMENT_OPEN);
			_skip = offset;
			break;

		default:
			append_char ('<');
			break;
		}
	}

	private void emit_xml_node_close_token (string name, int offset) throws ParserError {
		switch (name) {
		case "structname":
			emit_token (TokenType.GTKDOC_STRUCTNAME_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "link":
			emit_token (TokenType.GTKDOC_LINK_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "literal":
			emit_token (TokenType.GTKDOC_LITERAL_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "guimenuitem":
			emit_token (TokenType.GTKDOC_GUI_MENU_ITEM_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "replaceable":
			emit_token (TokenType.GTKDOC_REPLACEABLE_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "para":
			emit_token (TokenType.GTKDOC_PARA_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "note":
			emit_token (TokenType.GTKDOC_NOTE_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "itemizedlist":
			emit_token (TokenType.GTKDOC_ITEMIZED_LIST_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "listitem":
			emit_token (TokenType.GTKDOC_LIST_ITEM_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "warning":
			emit_token (TokenType.GTKDOC_WARNING_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "programlisting":
			emit_token (TokenType.GTKDOC_PROGRAMLISTING_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "informalexample":
			emit_token (TokenType.GTKDOC_EXAMPLE_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "variablelist":
			emit_token (TokenType.GTKDOC_VARIABLE_LIST_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "varlistentry":
			emit_token (TokenType.GTKDOC_VARIABLE_LIST_ENTRY_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "term":
			emit_token (TokenType.GTKDOC_TERM_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "envar":
			emit_token (TokenType.GTKDOC_ENVAR_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "option":
			emit_token (TokenType.GTKDOC_OPTION_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "emphasis":
			emit_token (TokenType.GTKDOC_EMPHASIS_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "filename":
			emit_token (TokenType.GTKDOC_FILENAME_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "simplelist":
			emit_token (TokenType.GTKDOC_SIMPLELIST_ELEMENT_CLOSE);
			_skip = offset;
			break;

		case "member":
			emit_token (TokenType.GTKDOC_MEMBER_ELEMENT_CLOSE);
			_skip = offset;
			break;

		default:
			append_char ('<');
			break;
		}
	}

	private inline bool is_numeric (unichar c) {
		return c >= '0' && c <= '9';
	}

	private inline bool is_letter (unichar c) {
		return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
	}

	private void emmit_qualified_function_name (int offset) throws ParserError {
		unichar c = get_next_char (offset);

		if (!is_letter (c) && c != '_') {
			emit_current_word ();
			return;
		}

		append_char (c);

		for (offset++; ; offset++) {
			c = get_next_char (offset);

			if (!is_letter (c) && c != '_' && !is_numeric (c) && c != '\0') {
				break;
			}

			append_char (c);
		}

		unichar nc = get_next_char (offset+1);

		if (c == '\0' || !((c == ':' && nc == ':' && is_letter (get_next_char (offset+2))) || (c == ':' && is_letter (nc)))) {
			emit_current_word ();
			_skip = offset-1;
			return;
		}

		append_char (c);

		if (nc == ':') {
			append_char (nc);
			offset++;
		}

		for (offset++; ; offset++) {
			c = get_next_char (offset);

			if (!is_letter (c) && c != '_' && !is_numeric (c)&& c != '-' && c != '\0') {
				break;
			}

			append_char (c);
		}

		emit_current_word ();
		_skip = offset-1;
	}

	protected void accept (unichar c) throws ParserError {
		_column++;

		if (_skip == 0) {
			if (_code_element_escape_mode == true) {
				switch (c) {
				case '<':
					if (get_next_char (1) == '/' && get_next_char (2) == 'p' &&
						get_next_char (3) == 'r' && get_next_char (4) == 'o' &&
						get_next_char (5) == 'g' && get_next_char (6) == 'r' &&
						get_next_char (7) == 'a' && get_next_char (8) == 'm' &&
						get_next_char (9) == 'l' && get_next_char (10) == 'i' &&
						get_next_char (11) == 's' && get_next_char (12) == 't' &&
						get_next_char (13) == 'i' && get_next_char (14) == 'n' &&
						get_next_char (15) == 'g' && get_next_char (16) == '>') {

						_code_element_escape_mode = false;
						emit_token (TokenType.GTKDOC_PROGRAMLISTING_ELEMENT_CLOSE);
						_skip = 16;
					} else {
						append_char (c);
					}
					return;
				default:
					append_char (c);
					return;
				}
			} else if (_code_escape_mode == true) {
				switch (c) {
				case ']':
					if (get_next_char (1) == '|') {
						_code_escape_mode = false;
						emit_token (TokenType.GTKDOC_SOURCE_CLOSE);
						_skip = 2;
					} else {
						append_char (c);
					}
					return;
				default:
					append_char (c);
					return;
				}
			} else {
				switch (c) {
				case '#':
				case '%':
					unichar nc = get_next_char (1);
					if (is_letter (nc) || nc == '_') {
						emit_token (TokenType.GTKDOC_SYMBOL);
						emmit_qualified_function_name (1);
					} else {
						append_char (c);
					}
					break;

				case '@':
					if (_last_char.isspace ()) {
						emit_token (TokenType.GTKDOC_PARAM);
					} else {
						append_char (c);
					}
					break;

				case '-':
					if (get_next_char (1) == '-' && get_next_char (2) == '>') {
						emit_token (TokenType.GTKDOC_XML_COMMENT_END);
						_skip = 2;
					} else {
						append_char (c);
					}
					break;

				case '(': // "(<spaces>?)"
					int i = 1;

					for (; get_next_char(i).isspace (); i++);
					if (get_next_char(i) == ')') {
						emit_token (TokenType.GTKDOC_FUNCTION_BRACKETS);
						_skip = i;
					} else {
						append_char (c);
					}
					break;

				case '<':
					if (get_next_char(1) == '!' && get_next_char(2) == '-' && get_next_char(3) == '-') {
						emit_token (TokenType.GTKDOC_XML_COMMENT_START);
						_skip = 3;
						break;
					}

					var name = new StringBuilder ();
					bool is_end_tag = false;
					int i = 1;

					if (get_next_char(i) == '/') {
						is_end_tag = true;
						i++;
					}


					for (; get_next_char(i) != '>' && !get_next_char(i).isspace (); i++) {
						name.append_unichar (get_next_char(i));
					}

					if (name.len == 0) {
						append_char (c);
						break;
					}

					if (is_end_tag) {
						if (get_next_char(i) != '>') {
							append_char (c);
							break;
						}
						emit_xml_node_close_token (name.str, i);
					} else {
						for (; get_next_char(i) != '>' && get_next_char(i) != '\0'; i++);
						if (get_next_char(i) == '\0') {
							append_char (c);
							break;
						}
						emit_xml_node_open_token (name.str, i);
					}
					break;

				case '|':
					if (get_next_char (1) == '[') {
						emit_token (TokenType.GTKDOC_SOURCE_OPEN);
						_skip = 1;
					} else {
						append_char (c);
					}
					break;

				case ']':
					if (get_next_char (1) == '|') {
						emit_token (TokenType.GTKDOC_SOURCE_CLOSE);
						_skip = 1;
					} else {
						append_char (c);
					}
					break;

				case '\r':
					break;

				case '\n':
					emit_token (TokenType.GTKDOC_EOL);
					_line++;
					_column = 0;
					_last_column = 0;
					break;

				case '\t':
				case ' ':
					emit_token (TokenType.GTKDOC_SPACE);
					break;

				case '.':
					emit_token (TokenType.GTKDOC_DOT);
					break;

				default:
					append_char (c);
					break;
				}
			}
		} else {
			_skip--;
		}
		_last_char = c;
	}

	private void append_char (unichar c) {
		_current_string.append_unichar (c);
	}

	public int get_line_start_column () {
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
