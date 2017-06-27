/* codescanner.vala
 *
 * Copyright (C) 2015       Florian Brosch
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

using GLib;


/**
 * A cheap scanner used to highlight C and Vala source code.
 */
public class Valadoc.Highlighter.CodeScanner : Object, Scanner {
	private Vala.HashMap<string, CodeTokenType?> keywords;
	private bool enable_string_templates;
	private bool enabel_verbatim_string;
	private bool enable_preprocessor_define;
	private bool enable_preprocessor_include;
	private bool enable_keyword_escape;


	private Queue<CodeToken> token_queue = new Queue<CodeToken> ();
	private unowned string content;
	private unowned string pos;


	public CodeScanner (string content, bool enable_string_templates, bool enabel_verbatim_string,
		bool enable_preprocessor_define, bool enable_preprocessor_include, bool enable_keyword_escape,
		Vala.HashMap<string, CodeTokenType?> keywords)
	{
		this.content = content;
		this.pos = content;

		this.enable_string_templates = enable_string_templates;
		this.enabel_verbatim_string = enabel_verbatim_string;
		this.enable_preprocessor_define = enable_preprocessor_define;
		this.enable_preprocessor_include = enable_preprocessor_include;
		this.enable_keyword_escape = enable_keyword_escape;

		this.keywords = keywords;
	}

	public CodeToken next () {
		if (!token_queue.is_empty ()) {
			return token_queue.pop_head ();
		}


		unowned string start;

		for (start = pos; pos[0] != '\0'; pos = pos.next_char ()) {
			if (((char*) pos) == ((char*) content) || pos[0] == '\n') {
				unowned string line_start = pos;

				while (pos[0] == ' ' || pos[0] == '\t' || pos[0] == '\n') {
					pos = pos.offset (1);
				}

				if (pos[0] == '\0') {
					break;
				} else if (enable_preprocessor_include && pos.has_prefix ("#include")) {
					unowned string end = pos;
					if (queue_c_include ()) {
						return dispatch (start, end);
					} else {
						pos = line_start;
						continue;
					}
				} else if (pos.has_prefix ("#if") || pos.has_prefix ("#else") || pos.has_prefix ("#elif") || pos.has_prefix ("#endif")
					|| (enable_preprocessor_define && (pos.has_prefix ("#defined") || pos.has_prefix ("#ifdef")))) {

					unowned string end = pos;
					queue_until ('\n', CodeTokenType.PREPROCESSOR);
					return dispatch (start, end);
				}
			}

			if (pos[0] == '\'') {
				unowned string end = pos;
				queue_string_literal ("\'");
				return dispatch (start, end);
			}

			if (pos[0] == '"' || (enable_string_templates && pos[0] == '@' && pos[1] == '"')) {
				unowned string end = pos;
				if (enabel_verbatim_string && (pos.has_prefix ("\"\"\"") || (enable_string_templates && pos.has_prefix ("@\"\"\"")))) {
					queue_string_literal ("\"\"\"");
				} else {
					queue_string_literal ("\"");
				}
				return dispatch (start, end);
			}

			if (pos[0] >= '0' && pos[0] <= '9') {
				unowned string end = pos;
				queue_numeric_literal ();
				return dispatch (start, end);
			}

			if (pos.has_prefix ("/*")) {
				unowned string end = pos;
				queue_multiline_comment ();
				return dispatch (start, end);
			}

			if (pos.has_prefix ("//")) {
				unowned string end = pos;
				queue_until ('\n', CodeTokenType.COMMENT);
				return dispatch (start, end);
			}

			if ((((char*) pos) == ((char*) content) || !isidstartchar (pos[-1])) && isidstartchar (pos[0])) {
				unowned string end = pos;
				if (queue_keyword ()) {
					return dispatch (start, end);
				} else {
					continue;
				}
			}
		}

		token_queue.push_tail (new CodeToken (CodeTokenType.EOF, ""));
		return dispatch (start, pos);
	}

	private bool queue_c_include () {
		unowned string include_start = pos;
		unowned string start = pos;
		pos = pos.offset (8);

		while (pos[0] == ' ' || pos[0] == '\t') {
			pos = pos.offset (1);
		}

		char? end_char = null;
		if (pos[0] == '"') {
			end_char = '"';
		} else if (pos[0] == '<') {
			end_char = '>';
		}

		if (end_char != null) {
			queue_token (start, pos, CodeTokenType.PREPROCESSOR);

			unowned string literal_start = pos;
			pos = pos.offset (1);

			while (pos[0] != end_char && pos[0] != '\n' && pos[0] != '\0') {
				pos = pos.offset (1);
			}

			if (pos[0] == end_char) {
				pos = pos.offset (1);

				queue_token (literal_start, pos, CodeTokenType.LITERAL);
				start = pos;
			} else {
				pos = include_start;
				token_queue.clear ();
				return false;
			}
		}

		while (pos[0] == ' ' || pos[0] == '\t') {
			pos = pos.offset (1);
		}

		if (pos[0] == '\n' || pos[0] == '\0') {
			queue_token (start, pos, CodeTokenType.PREPROCESSOR);
			return true;
		} else {
			pos = include_start;
			token_queue.clear ();
			return false;
		}
	}

	private bool queue_keyword () {
		unowned string start = pos;
		if (pos[0] == '@') {
			pos = pos.offset (1);
		}
		while (isidchar (pos[0])) {
			pos = pos.offset (1);
		}

		long length = start.pointer_to_offset (pos);
		string word = start.substring (0, length);
		CodeTokenType? token_type = keywords.get (word);
		if (token_type == null) {
			pos = start;
			return false;
		}

		token_queue.push_tail (new CodeToken (token_type, word));
		return true;
	}

	private void queue_multiline_comment () {
		unowned string start = pos;
		pos = pos.offset (2);

		while (!(pos[0] == '*' && pos[1] == '/') && pos[0] != '\0') {
			pos = pos.offset (1);
		}

		if (pos[0] != '\0') {
			pos = pos.offset (2);
		}

		queue_token (start, pos, CodeTokenType.COMMENT);
	}

	private void queue_until (char end_char, CodeTokenType token_type) {
		unowned string start = pos;
		pos = pos.offset (1);

		while (pos[0] != end_char && pos[0] != '\0') {
			pos = pos.offset (1);
		}

		if (pos[0] != '\0' && pos[0] != '\n') {
			pos = pos.offset (1);
		}

		queue_token (start, pos, token_type);
	}

	private void queue_string_literal (string end_chars) {
		unowned string start = pos;
		bool is_template = false;

		if (pos[0] == '@') {
			pos = pos.offset (end_chars.length + 1);
			is_template = true;
		} else {
			pos = pos.offset (end_chars.length);
		}

		while (!pos.has_prefix (end_chars) && pos[0] != '\0') {
			long skip = 0;

			if ((pos[0] == '%' && has_printf_format_prefix (out skip))
				|| (pos[0] == '\\' && has_escape_prefix (out skip))
				|| (is_template && pos[0] == '$' && has_template_literal_prefix (out skip)))
			{
				queue_token (start, pos, CodeTokenType.LITERAL);

				unowned string sub_start = pos;
				pos = pos.offset (skip);
				queue_token (sub_start, pos, CodeTokenType.ESCAPE);
				start = pos;
			} else {
				pos = pos.offset (1);
			}
		}

		if (pos[0] != '\0') {
			pos = pos.offset (end_chars.length);
		}

		queue_token (start, pos, CodeTokenType.LITERAL);
	}

	private bool has_template_literal_prefix (out long skip) {
		if (isidchar (pos[1])) {
			skip = 1;
			while (isidchar (pos[skip])) {
				skip++;
			}
			return true;
		}

		if (pos[1] == '(') {
			int level = 1;
			skip = 2;

			while (level > 0) {
				switch (pos[skip]) {
				case '(':
					level++;
					break;
				case ')':
					level--;
					break;
				case '\0':
					skip = 0;
					return false;
				}
				skip++;
			}
			return true;
		}

		skip = 0;
		return false;
	}

	private bool has_escape_prefix (out long skip) {
		switch (pos[1]) {
		case 'a':
		case 'b':
		case 'f':
		case 'n':
		case 'r':
		case 't':
		case 'v':
		case '\\':
		case '\'':
		case '\"':
		case '?':
			skip = 2;
			return true;

		case 'x':
			if (pos[2].isxdigit ()) {
				for (skip = 2; pos[skip].isxdigit (); skip++) {
					skip++;
				}

				skip++;
				return true;
			}

			skip = 0;
			return false;

		default:
			if (pos[1].isdigit ()) {
				skip = 2;

				if (pos[2].isdigit ()) {
					skip++;

					if (pos[3].isdigit ()) {
						skip++;
					}
				}

				return true;
			}

			skip = 0;
			return false;
		}
	}

	private bool has_printf_format_prefix (out long skip) {
		// %[flag][min width][precision][length modifier][conversion specifier]
		unowned string pos = this.pos;
		unowned string start = pos;

		// '%'
		pos = pos.offset (1);

		if (pos[0] == '%') {
			pos = pos.offset (1);
			skip = 2;
			return true;
		}


		// flags:
		while ("#0+- ".index_of_char (pos[0]) > 0) {
			pos = pos.offset (1);
		}

		// min width:
		while (pos[0].isdigit ()) {
			pos = pos.offset (1);
		}

		// precision
		if (pos[0] == '.' && pos[1].isdigit ()) {
			pos = pos.offset (2);
			while (pos[0].isdigit ()) {
				pos = pos.offset (1);
			}
		}

		// length:
		switch (pos[0]) {
		case 'h':
			pos = pos.offset (1);
			if (pos[0] == 'h') {
				pos = pos.offset (1);
			}
			break;

		case 'l':
			pos = pos.offset (1);
			if (pos[0] == 'l') {
				pos = pos.offset (1);
			}
			break;

		case 'j':
		case 'z':
		case 't':
		case 'L':
			pos = pos.offset (1);
			break;
		}

		// conversion specifier:
		switch (pos[0]) {
		case 'd':
		case 'i':
		case 'u':
		case 'o':
		case 'x':
		case 'X':
		case 'f':
		case 'F':
		case 'e':
		case 'E':
		case 'g':
		case 'G':
		case 'a':
		case 'A':
		case 'c':
		case 's':
		case 'p':
		case 'n':
			pos = pos.offset (1);
			break;

		default:
			skip = 0;
			return false;
		}

		skip = start.pointer_to_offset (pos);
		return true;
	}

	private enum NumericType {
		INTEGER,
		REAL,
		NONE
	}

	// based on libvala
	private void queue_numeric_literal () {
		NumericType numeric_type = NumericType.INTEGER;
		unowned string start = pos;


		// integer part
		if (pos[0] == '0' && pos[1] == 'x' && pos[2].isxdigit ()) {
			// hexadecimal integer literal
			pos = pos.offset (2);
			while (pos[0].isxdigit ()) {
				pos = pos.offset (1);
			}
		} else {
			// decimal number
			while (pos[0].isdigit ()) {
				pos = pos.offset (1);
			}
		}


		// fractional part
		if (pos[0] == '.' && pos[1].isdigit ()) {
			numeric_type = NumericType.REAL;
			pos = pos.offset (1);
			while (pos[0].isdigit ()) {
				pos = pos.offset (1);
			}
		}


		// exponent part
		if (pos[0] == 'e' || pos[0] == 'E') {
			numeric_type = NumericType.REAL;
			pos = pos.offset (1);
			if (pos[0] == '+' || pos[0] == '-') {
				pos = pos.offset (1);
			}
			while (pos[0].isdigit ()) {
				pos = pos.offset (1);
			}
		}


		// type suffix
		switch (pos[0]) {
		case 'l':
		case 'L':
			if (numeric_type == NumericType.INTEGER) {
				pos = pos.offset (1);
				if (pos[0] == 'l' || pos[0] == 'L') {
					pos = pos.offset (1);
				}
			}
			break;

		case 'u':
		case 'U':
			if (numeric_type == NumericType.INTEGER) {
				pos = pos.offset (1);
				if (pos[0] == 'l' || pos[0] == 'L') {
					pos = pos.offset (1);
					if (pos[0] == 'l' || pos[0] == 'L') {
						pos = pos.offset (1);
					}
				}
			}
			break;

		case 'f':
		case 'F':
		case 'd':
		case 'D':
			numeric_type = NumericType.REAL;
			pos = pos.offset (1);
			break;
		}

		if (pos[0].isalnum ()) {
			numeric_type = NumericType.NONE;
		}

		queue_token (start, pos, (numeric_type != NumericType.NONE)
			? CodeTokenType.LITERAL
			: CodeTokenType.PLAIN);
	}

	private CodeToken dispatch (string start, string end) {
		assert (token_queue.is_empty () == false);

		if (((char*) start) == ((char*) end)) {
			return token_queue.pop_head ();
		}

		long length = start.pointer_to_offset (end);
		string content = start.substring (0, length);
		return new CodeToken (CodeTokenType.PLAIN, content);
	}

	private void queue_token (string start, string end, CodeTokenType token_type) {
		long length = start.pointer_to_offset (end);
		string content = start.substring (0, length);
		token_queue.push_tail (new CodeToken (token_type, content));
	}

	private inline bool isidchar (char c) {
		return c.isalnum () || c == '_';
	}

	private inline bool isidstartchar (char c) {
		return c.isalnum () || c == '_' || (c == '@' && enable_keyword_escape);
	}
}

