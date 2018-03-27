/* gtkdocmarkdownscanner.vala
 *
 * Copyright (C) 2014 Florian Brosch
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
 *  Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc.Content;
using Valadoc;

public class Valadoc.Gtkdoc.MarkdownScanner : GLib.Object, Valadoc.Scanner {
	private enum State {
		NORMAL,
		UNORDERED_LIST,
		ORDERED_LIST,
		BLOCK
	}

	private Settings _settings;
	private Valadoc.Parser parser;

	private unowned string _content;
	private int _skip;

	private StringBuilder _current_string = new StringBuilder ();
	private unowned string _index;
	private bool contains_at;

	private int _line;
	private int _column;
	private int _last_line;
	private int _last_column;
	private bool _stop;

	private string? headline_end;

	private Regex regex_mail;

	private Vala.List<State> states = new Vala.ArrayList<State> ();

	private inline void push_state (State state) {
		states.insert (0, state);
	}

	private inline State pop_state () {
		return states.remove_at (0);
	}

	private inline State peek_state () {
		return states.get (0);
	}


	public MarkdownScanner (Settings settings) {
		_settings = settings;

		try {
			regex_mail = new Regex ("^[A-Za-z0-9._-]+@[A-Za-z0-9._-]+$");
		} catch (Error e) {
			assert_not_reached ();
		}
	}

	public void set_parser (Valadoc.Parser parser) {
		this.parser = parser;
	}

	public void reset () {
		_stop = false;
		_last_line = 0;
		_last_column = 0;
		_line = 0;
		_column = 0;
		_skip = 0;
		_current_string.erase (0, -1);
		contains_at = false;

		states.clear ();
		push_state (State.NORMAL);
	}

	public void scan (string content) throws ParserError {
		_content = content;
		_index = _content;


		// Accept block taglets:
		if (handle_newline (_index, true)) {
			_index = _index.next_char ();
		} else {
			// Empty string
	 		emit_token (Valadoc.TokenType.MARKDOWN_PARAGRAPH);
		}


		while (!_stop && _index.get_char () != 0) {
			unichar c = _index.get_char ();
			accept (c);

			_index = _index.next_char ();
		}


		// Close open blocks:
		while (peek_state () != State.NORMAL) {
			if (peek_state () == State.BLOCK) {
				emit_token (Valadoc.TokenType.MARKDOWN_BLOCK_END);
				pop_state ();
			} else {
				close_block ();
			}
		}


		emit_token (Valadoc.TokenType.MARKDOWN_EOC);
	}

	private void accept (unichar c) throws ParserError {
		_column++;
		if (_skip > 0) {
			_skip--;
			return ;
		}

		// In headline:
		string? hash = null;

		if (headline_end != null && is_headline_end (ref _index, headline_end, out hash)) {
			if (hash != null) {
				emit_token (Valadoc.TokenType.MARKDOWN_HEADLINE_HASH, hash);
			}
			emit_token (Valadoc.TokenType.MARKDOWN_HEADLINE_END);
			headline_end = null;

			handle_newline (_index, true);

			return ;
		}

		switch (c) {
		case '\\':
			switch (get_next_char ()) {
			case '(':
				if (get_next_char (2) == ')') {
					_current_string.append ("()");
					_skip += 2;
					break;
				}

				_current_string.append ("\\(");
				_skip++;
				break;

			case '<':
				append_char ('<');
				_skip++;
				break;

			case '>':
				append_char ('>');
				_skip++;
				break;

			case '@':
				append_char ('@');
				_skip++;
				break;

			case '%':
				append_char ('%');
				_skip++;
				break;

			case '#':
				append_char ('#');
				_skip++;
				break;

			default:
				append_char ('\\');
				break;
			}

			break;

		case ':':
			unichar next_char = get_next_char ();
			unichar next2_char = get_next_char (2);

			// :id or ::id
			if ((_current_string.len == 0 || !_current_string.str[_current_string.len - 1].isalpha ())
				&& (next_char.isalpha () || (next_char == ':' && next2_char.isalpha ()))) {

				unowned string _iter;
				if (next_char == ':') {
					_iter = _index.offset (2);
					_skip++;
				} else {
					_iter = _index.offset (1);
				}

				while (_iter[0].isalnum () || _iter[0] == '_' || (_iter[0] == '-' && _iter[1].isalnum ())) {
					_iter = _iter.offset (1);
					_skip++;
				}

				emit_token (Valadoc.TokenType.MARKDOWN_LOCAL_GMEMBER, _index.substring (0, _skip + 1));
				break;
			}

			append_char (c);
			break;

		case '%':
			// " %foo", "-%foo" but not " %", "a%foo", ...
			if ((_current_string.len == 0 || !_current_string.str[_current_string.len - 1].isalpha ()) && get_next_char ().isalpha ()) {
				unowned string _iter = _index.offset (1);

				while (_iter[0].isalnum () || _iter[0] == '_') {
					_iter = _iter.offset (1);
					_skip++;
				}

				emit_token (Valadoc.TokenType.MARKDOWN_CONSTANT, _index.substring (1, _skip));
				break;
			}
			// %numeric:
			if ((_current_string.len == 0 || !_current_string.str[_current_string.len - 1].isalpha ()) && get_next_char ().isdigit ()) {
				unowned string _iter = _index.offset (1);

				while (_iter[0].isdigit ()) {
					_iter = _iter.offset (1);
					_skip++;
				}

				// Integers:
				if (_iter[0].tolower () == 'u' && _iter[0].tolower () == 'l') {
					_iter = _iter.offset (1);
					_skip += 2;

					emit_token (Valadoc.TokenType.MARKDOWN_CONSTANT, _index.substring (1, _skip));
					break;
				} else if (_iter[0].tolower () == 'u' || _iter[0].tolower () == 'l') {
					_iter = _iter.offset (1);
					_skip++;

					emit_token (Valadoc.TokenType.MARKDOWN_CONSTANT, _index.substring (1, _skip));
					break;
				}


				// Float, double:
				if (_iter[0] == '.' && _iter[1].isdigit ()) {
					_iter = _iter.offset (2);
					_skip += 2;
				}

				while (_iter[0].isdigit ()) {
					_iter = _iter.offset (1);
					_skip++;
				}

				if (_iter[0].tolower () == 'f' || _iter[0].tolower () == 'l') {
					_iter = _iter.offset (1);
					_skip++;
				}

				emit_token (Valadoc.TokenType.MARKDOWN_CONSTANT, _index.substring (1, _skip));
				break;
			}

			append_char (c);
			break;

		case '#':
			// " #foo", "-#foo" but not " #"", "a#""foo", ...
			if ((_current_string.len == 0 || !_current_string.str[_current_string.len - 1].isalpha ()) && get_next_char ().isalpha ()) {
				unowned string _iter = _index.offset (1);

				while (_iter[0].isalnum () || _iter[0] == '_') {
					_iter = _iter.offset (1);
					_skip++;
				}

				// signals, fields, properties
				bool is_field = false;
				if (((_iter[0] == ':' || _iter[0] == '.') && _iter[1].isalpha ())
					|| (_iter.has_prefix ("::") && _iter[2].isalpha ())) {

					is_field = (_iter[0] == '.');
					_iter = _iter.offset (2);
					_skip += 2;

					while (_iter[0].isalnum () || _iter[0] == '_' || (!is_field && _iter[0] == '-')) {
						_iter = _iter.offset (1);
						_skip++;
					}
				}

				if (is_field && _iter.has_prefix ("()")) {
					_skip += 2;

					emit_token (Valadoc.TokenType.MARKDOWN_SYMBOL, _index.substring (1, _skip - 2));
				} else {
					emit_token (Valadoc.TokenType.MARKDOWN_SYMBOL, _index.substring (1, _skip));
				}

				break;
			}

			append_char (c);
			break;

		case '@':
			// " @foo", "-@foo" but not " @", "a@foo", ...
			if ((_current_string.len == 0 || !_current_string.str[_current_string.len - 1].isalpha ())) {
				if (get_next_char ().isalpha ()) {
					unowned string _iter = _index.offset (1);

					while (_iter[0].isalnum () || _iter[0] == '_') {
						_iter = _iter.offset (1);
						_skip++;
					}

					emit_token (Valadoc.TokenType.MARKDOWN_PARAMETER, _index.substring (1, _skip));
					break;
				} else if (_index.has_prefix ("@...")) {
					_skip += 3;
					emit_token (Valadoc.TokenType.MARKDOWN_PARAMETER, "...");
					break;
				}
			}

			append_char (c);
			contains_at = true;
			break;

		case '(':
			if (get_next_char () == ')' && is_id ()) {
				string id = _current_string.str;
				_current_string.erase (0, -1);
				contains_at = false;

				emit_token (Valadoc.TokenType.MARKDOWN_FUNCTION, id);
				_skip++;
				break;
			}

			emit_token (Valadoc.TokenType.MARKDOWN_OPEN_PARENS);
			break;

		case ')':
			emit_token (Valadoc.TokenType.MARKDOWN_CLOSE_PARENS);
			break;

		case '[':
			unowned string iter = _index;
			int count = 1;
			while (iter[0] != '\n' && iter[0] != '\0' && count > 0) {
				iter = iter.offset (1);
				switch (iter[0]) {
				case '[':
					count++;
					break;

				case ']':
					count--;
					break;
				}
			}

			if (iter[0] == ']') {
				emit_token (Valadoc.TokenType.MARKDOWN_OPEN_BRACKET);
			} else {
				append_char ('[');
			}
			break;

		case ']':
			emit_token (Valadoc.TokenType.MARKDOWN_CLOSE_BRACKET);
			break;

		case '<':
			emit_token (Valadoc.TokenType.MARKDOWN_LESS_THAN);
			break;

		case '>':
			emit_token (Valadoc.TokenType.MARKDOWN_GREATER_THAN);
			break;

		case '!':
			emit_token (Valadoc.TokenType.MARKDOWN_EXCLAMATION_MARK);
			break;

		case '|':
			if (get_next_char () == '[') {
				unowned string _iter = _index.offset (2);
				int end = _iter.index_of ("]|");
				if (end < 0) {
					append_char ('|');
				} else {
					emit_token (Valadoc.TokenType.MARKDOWN_SOURCE, _index.substring (2, end));
					_skip = end + 3;
				}

				break;
			}

			append_char (c);
			break;

		case '\t':
		case ' ':
			unowned string _iter = _index.offset (1);
			_skip += skip_spaces (ref _iter);

			if (_iter[0] != '\n' && _iter[0] != '\0') {
				emit_token (Valadoc.TokenType.MARKDOWN_SPACE);
			}
			break;

		case '\r':
			// Ignore
			break;

		case '\n':
			unowned string _iter = _index.offset (1);

			_line++;
			_column = 0;
			_last_column = 0;
			handle_newline (_iter, false);
			break;

		default:
			append_char (c);
			break;
		}
	}

	private bool handle_newline (string _iter, bool is_paragraph) throws ParserError {
		int leading_spaces;

		leading_spaces = skip_spaces (ref _iter);

		if (_iter[0] == '\0') {
			return false;
		}

		// Do not emit paragraphs twice:
		if (is_paragraph) {
			while (_iter[0] == '\n') {
				_line++;
				_iter = _iter.offset (1);
				leading_spaces = skip_spaces (ref _iter);
			}
		}

		bool in_block = states.contains (State.BLOCK);
		if (_iter[0] == '>') {
			if (!in_block) {
				close_block ();

				if (is_paragraph) {
					_column += (int) ((char*) _iter - (char*) _index);
					_index = _iter.offset (1);
					emit_token (Valadoc.TokenType.MARKDOWN_BLOCK_START);
					push_state (State.BLOCK);
				}
			}

			if (in_block || is_paragraph) {
				_column++;
				_index = _iter;

				_iter = _iter.offset (1);
				skip_spaces (ref _iter);
			}
		} else if (in_block && is_paragraph) {
			_column += (int) ((char*) _iter - (char*) _index);
			_index = _iter;

			close_block ();

			emit_token (Valadoc.TokenType.MARKDOWN_BLOCK_END);
			pop_state ();
		}


		int list_token_len = 0;
		bool is_unsorted_list = _iter[0] == '-' && _iter[1].isspace ();
		bool is_sorted_list = is_ordered_list (_iter, out list_token_len);
		if ((is_unsorted_list || is_sorted_list)  && (is_paragraph || states.contains (State.UNORDERED_LIST) || states.contains (State.ORDERED_LIST))) {
			Valadoc.TokenType start_token = Valadoc.TokenType.MARKDOWN_ORDERED_LIST_ITEM_START;
			State new_state = State.ORDERED_LIST;

			if (is_unsorted_list) {
				start_token = Valadoc.TokenType.MARKDOWN_UNORDERED_LIST_ITEM_START;
				new_state = State.UNORDERED_LIST;
				list_token_len = 2;
			}


			_iter = _iter.offset (list_token_len);
			close_block ();

			skip_spaces (ref _iter);

			_column += (int) ((char*) _iter - (char*) _index);
			_index = _iter.offset (-1);
			emit_token (start_token);
			push_state (new_state);

			emit_token (Valadoc.TokenType.MARKDOWN_PARAGRAPH);
			return true;
		}

		if ((_iter[0] == '#' && _iter[1].isspace ()) || (_iter[0] == '#' && _iter[1] == '#' && _iter[2].isspace ()) && is_paragraph) {
			close_block ();

			if (_iter[1] != '#') {
				_iter = _iter.offset (1);
				emit_token (Valadoc.TokenType.MARKDOWN_HEADLINE_1);
				headline_end = "#";
			} else {
				emit_token (Valadoc.TokenType.MARKDOWN_HEADLINE_2);
				_iter = _iter.offset (2);
				headline_end = "##";
			}

			_column += (int) ((char*) _iter - (char*) _index);
			_index = _iter.offset (-1);

			return true;
		}

		if (is_paragraph) {
			if (leading_spaces == 0) {
				close_block ();
			}

			_column += (int) ((char*) _iter - (char*) _index);
			_index = _iter.offset (-1);
			emit_token (Valadoc.TokenType.MARKDOWN_PARAGRAPH);
		} else if (_iter[0] == '\n') {
			_line++;
			_column = 0;
			_last_column = 0;

			handle_newline (_iter.offset (1), true);
		} else {
			emit_token (Valadoc.TokenType.MARKDOWN_SPACE);
		}

		return true;
	}

	private bool is_headline_end (ref unowned string iter, string separator, out string? hash) {
		unowned string _iter = iter;
		hash = null;


		if (_iter[0] == '\n' || _iter[0] == '\0') {
			_line++;
			return true;
		}
		if (!_iter.has_prefix (separator)) {
			return false;
		}

		_iter = _iter.offset (separator.length);


		skip_spaces (ref _iter);
		if (_iter[0] == '\n' || _iter[0] == '\0') {
			iter = _iter;
			_line++;
			return true;
		} else if (!_iter.has_prefix ("{#")) {
			return false;
		}
		_iter = _iter.offset (2);

		unowned string id_start = _iter;
		int hash_len = 0;

		while (_iter[0] != '}' && _iter[0] != '\n' && _iter[0] != '\0') {
			_iter = _iter.offset (1);
			hash_len++;
		}

		if (_iter[0] != '}') {
			return false;
		}

		_iter = _iter.offset (1);

		skip_spaces (ref _iter);

		if (_iter[0] == '\n' || _iter[0] == '\0') {
			hash = id_start.substring (0, hash_len);
			iter = _iter;
			_line++;
			return true;
		}

		return false;
	}

	private bool is_ordered_list (string iter, out int numeric_prefix_count) {
		numeric_prefix_count = 0;
		while (iter[0] >= '0' && iter[0] <= '9') {
			numeric_prefix_count++;
			iter = iter.offset (1);
		}

		if (numeric_prefix_count > 0 && iter[0] == '.' && iter[1].isspace ()) {
			numeric_prefix_count++;
			return true;
		}

		return false;
	}

	private inline int skip_spaces (ref unowned string _iter) {
		int count = 0;
		while (_iter[0] == ' ' || _iter[0] == '\t' || _iter[0] == '\r') {
			_iter = _iter.offset (1);
			count++;
		}

		return count;
	}

	private bool close_block () throws ParserError {
		if (states.get (0) == State.UNORDERED_LIST) {
			emit_token (Valadoc.TokenType.MARKDOWN_UNORDERED_LIST_ITEM_END);
			pop_state ();
			return true;
		} else if (states.get (0) == State.ORDERED_LIST) {
			emit_token (Valadoc.TokenType.MARKDOWN_ORDERED_LIST_ITEM_END);
			pop_state ();
			return true;
		}

		return false;
	}

	public void end () throws ParserError {
		emit_token (Valadoc.TokenType.EOF);
	}

	public void stop () {
		_stop = true;
	}

	public string get_line_content () {
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

	private void emit_token (Valadoc.TokenType type, string? value = null) throws ParserError {
		emit_current_word ();

		parser.accept_token (new Valadoc.Token.from_type (type, get_begin (), get_end (_skip), value));
	}

	private void emit_current_word () throws ParserError {
		if (_current_string.len > 0) {
			if (is_mail ()) {
				parser.accept_token (new Valadoc.Token.from_type (Valadoc.TokenType.MARKDOWN_MAIL, get_begin (), get_end (_skip), _current_string.str));
			} else if (_current_string.str.has_prefix ("http://") || _current_string.str.has_prefix ("https://")) {
				// TODO: (https?:[\/]{2}[^\s]+?)
				parser.accept_token (new Valadoc.Token.from_type (Valadoc.TokenType.MARKDOWN_LINK, get_begin (), get_end (_skip), _current_string.str));
			} else {
				parser.accept_token (new Valadoc.Token.from_word (_current_string.str, get_begin (), get_end (-1)));
			}

			_current_string.erase (0, -1);
			contains_at = false;
		}
	}

	private Vala.SourceLocation get_begin () {
		return Vala.SourceLocation (_index, _last_line, get_line_start_column () + _last_column);
	}

	private Vala.SourceLocation get_end (int offset = 0) {
		return Vala.SourceLocation (_index, _line, get_line_start_column () + _column + offset);
	}

	public int get_line_start_column () {
		return 0;
	}

	private void append_char (unichar c) {
		_current_string.append_unichar (c);
	}

	private unichar get_next_char (int offset = 1) {
		return _index.get_char (_index.index_of_nth_char (offset));
	}

	private inline bool is_mail () {
		return contains_at && regex_mail.match (_current_string.str);
	}

	private bool is_id () {
		if (_current_string.len == 0) {
			return false;
		}

		if (_current_string.str[0].isalpha () == false && _current_string.str[0] != '_') {
			return false;
		}

		for (int i = 1; i < _current_string.len ; i++) {
			if (_current_string.str[i].isalnum () == false && _current_string.str[i] != '_') {
				return false;
			}
		}

		return true;
	}
}

