/* gtkcommentscanner.vala
 *
 * Copyright (C) 2011  Florian Brosch
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


using Valadoc.Gtkdoc;

public enum Valadoc.Gtkdoc.TokenType {
	XML_OPEN,
	XML_CLOSE,
	XML_COMMENT,
	GTKDOC_FUNCTION,
	GTKDOC_CONST,
	GTKDOC_TYPE,
	GTKDOC_PARAM,
	GTKDOC_SOURCE_OPEN,
	GTKDOC_SOURCE_CLOSE,
	GTKDOC_SIGNAL,
	GTKDOC_PROPERTY,
	GTKDOC_PARAGRAPH,
	NEWLINE,
	SPACE,
	WORD,
	EOF
}


public class Valadoc.Gtkdoc.Token {
	public TokenType type;
	public string content;
	public Vala.HashMap<string, string>? attributes;
	public unowned string start;
	public int length;
	public int line;
	public int first_column;
	public int last_column;

	public Token (TokenType type, string content, Vala.HashMap<string, string>? attributes, string start,
				  int length, int line, int first_column, int last_column)
	{
		this.attributes = attributes;
		this.content = content;
		this.length = length;
		this.start = start;
		this.type = type;
		this.line = line;
		this.first_column = first_column;
		this.last_column = last_column;
	}

	public string to_string () {
		switch (this.type) {
		case TokenType.XML_OPEN:
			return "`<%s>'".printf (this.content);

		case TokenType.XML_CLOSE:
			return "`</%s>'".printf (this.content);

		case TokenType.XML_COMMENT:
			return "<XML-COMMENT>";

		case TokenType.GTKDOC_FUNCTION:
			return "`%s ()'".printf (this.content);

		case TokenType.GTKDOC_CONST:
			return "`%%%s'".printf (this.content);

		case TokenType.GTKDOC_TYPE:
			return "`#%s'".printf (this.content);

		case TokenType.GTKDOC_PARAM:
			return "<GTKDOC-PARAM>";

		case TokenType.GTKDOC_SOURCE_OPEN:
			return "[|";

		case TokenType.GTKDOC_SOURCE_CLOSE:
			return "|]";

		case TokenType.GTKDOC_SIGNAL:
			return "`::%s'".printf (this.content);

		case TokenType.GTKDOC_PROPERTY:
			return "`:%s'".printf (this.content);

		case TokenType.GTKDOC_PARAGRAPH:
			return "<GKTDOC-PARAGRAPH>";

		case TokenType.NEWLINE:
			return "<NEWLNIE>";

		case TokenType.SPACE:
			return "<SPACE>";

		case TokenType.WORD:
			return "`%s'".printf (this.content);

		case TokenType.EOF:
			return "<EOF>";

		default:
			assert_not_reached ();
		}
	}
}


public class Valadoc.Gtkdoc.Scanner {
	private unowned string content;
	private unowned string pos;
	private int column;
	private int line;
	private Token tmp_token;

	public Scanner () {
	}

	public static string unescape (string txt) {
		StringBuilder builder = new StringBuilder ();
		unowned string start = txt;
		unowned string pos;
		unichar c;

		for (pos = txt; (c = pos.get_char ()) != '\0'; pos = pos.next_char ()) {
			if (c == '&') {
				if (pos.has_prefix ("&solidus;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 9);
					pos = (string) ((char*) pos + 8);
					builder.append_unichar ('⁄');
				} else if (pos.has_prefix ("&percnt;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 8);
					pos = (string) ((char*) pos + 7);
					builder.append_c ('%');
				} else if (pos.has_prefix ("&commat;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 8);
					pos = (string) ((char*) pos + 7);
					builder.append_c ('@');
				} else if (pos.has_prefix ("&nbsp;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 6);
					pos = (string) ((char*) pos + 5);
					builder.append_c (' ');
				} else if (pos.has_prefix ("&quot;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 6);
					pos = (string) ((char*) pos + 5);
					builder.append_c ('"');
				} else if (pos.has_prefix ("&apos;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 6);
					pos = (string) ((char*) pos + 5);
					builder.append_c ('\'');
				} else if (pos.has_prefix ("&lpar;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 6);
					pos = (string) ((char*) pos + 5);
					builder.append_c ('(');
				} else if (pos.has_prefix ("&rpar;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 6);
					pos = (string) ((char*) pos + 5);
					builder.append_c (')');
				} else if (pos.has_prefix ("&num;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 5);
					pos = (string) ((char*) pos + 4);
					builder.append_c ('#');
				} else if (pos.has_prefix ("&amp;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 5);
					pos = (string) ((char*) pos + 4);
					builder.append_c ('&');
				} else if (pos.has_prefix ("&ast;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 5);
					pos = (string) ((char*) pos + 4);
					builder.append_c ('*');
				} else if (pos.has_prefix ("&pi;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 4);
					pos = (string) ((char*) pos + 3);
					builder.append_unichar ('π');
				} else if (pos.has_prefix ("&lt;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 4);
					pos = (string) ((char*) pos + 3);
					builder.append_c ('<');
				} else if (pos.has_prefix ("&gt;")) {
					builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
					start = (string) ((char*) pos + 4);
					pos = (string) ((char*) pos + 3);
					builder.append_c ('>');
				}
			}
		}

		if (&txt == &start) {
			return txt;
		} else {
			builder.append_len (start, (ssize_t) ((char*) pos - (char*) start));
			return (owned) builder.str;
		}
	}

	public void reset (string content) {
		this.content = content;
		this.tmp_token = null;
		this.pos = content;
		this.column = 0;
		this.line = 0;
	}

	private inline unichar next_char () {
		this.pos = this.pos.next_char ();
		this.column++;

		return this.pos.get_char ();
	}

	private inline unichar get () {
		return this.pos.get_char ();
	}

	private inline bool letter (unichar c) {
		return (c >= 'a' && c <= 'z')
			|| (c >= 'A' && c <= 'Z');
	}

	private inline bool letter_or_number (unichar c) {
		return (c >= 'a' && c <= 'z')
			|| (c >= 'A' && c <= 'Z')
			|| (c >= '0' && c <= '9');
	}

	private inline bool space (unichar c) {
		return c == ' ' || c == '\t';
	}

	private inline bool space_or_newline (unichar c) {
		if (c == '\n') {
			this.line++;
			this.column = 0;
			return true;
		}

		return space (c);
	}

	private inline int offset (string a, string b) {
		return (int) ((char*) a - (char*) b);
	}

	private inline int vararg_prefix () {
		if (this.pos.has_prefix ("...")) {
			next_char ();
			next_char ();
			next_char ();
			return 3;
		}

		return 0;
	}

	private inline int id_prefix () {
		unichar c = get ();

		if (!letter (c) && c != '_') {
			return 0;
		}

		int start = this.column;
		while ((c = next_char ()) == '_' || letter_or_number (c));
		return this.column - start;
	}

	private inline int g_id_prefix () {
		unowned string start = this.pos;
		unichar c = get ();

		if (!letter (c)) {
			return 0;
		}

		while ((c = next_char ()) == '_' || c == '-' || letter_or_number (c));
		return offset (this.pos, start);
	}

	private inline int skip_spaces_and_newlines () {
		unowned string start = this.pos;
		if (space_or_newline (get ())) {
			while (space_or_newline (next_char ()));
		}

		return offset (this.pos, start);
	}

	private inline Token? function_prefix () {
		unowned string start = this.pos;
		int column_start = this.column;
		int id_len = 0;

		if ((id_len = id_prefix ()) == 0) {
			return null;
		}

		space_prefix ();

		if (get () != '(') {
			this.column = column_start;
			this.pos = start;
			return null;
		}

		next_char ();
		space_prefix ();

		if (get () != ')') {
			this.column = column_start;
			this.pos = start;
			return null;
		}

		next_char ();
		return new Token (TokenType.GTKDOC_FUNCTION,
						  start.substring (0, id_len),
						  null,
						  start,
						  offset (this.pos, start),
						  this.line,
						  column_start,
						  this.column);
	}

	private inline Token? gtkdoc_symbolic_link_prefix (unichar c, TokenType type) {
		if (get () != c) {
			return null;
		}

		unowned string start = this.pos;
		int column_start = this.column;
		next_char ();

		int id_len = 0;

		if ((id_len = id_prefix ()) == 0) {
			if (type == TokenType.GTKDOC_PARAM && (id_len = vararg_prefix ()) == 0) {
				this.column = column_start;
				this.pos = start;
				return null;
			}
		}

		unowned string separator = this.pos;
		if (get () == ':') {
			int separator_len = 1;
			if (next_char () == ':') {
				next_char ();
				separator_len++;
			}

			int id_len2;
			if ((id_len2 = g_id_prefix ()) == 0) {
				this.pos = separator;
			} else {
				id_len += id_len2 + separator_len;
			}
		} else if (this.pos.has_prefix ("->") || this.pos.has_prefix (".")) {
			unowned string sep_start = this.pos;
			int sep_column_start = this.column;
			int separator_len = 1;

			if (this.pos.has_prefix ("->")) {
				separator_len = 2;
				next_char ();
			}

			next_char ();

			Token? func_token = function_prefix ();
			if (func_token == null) {
				int id_len2;

				if ((id_len2 = id_prefix ()) > 0) {
					id_len += separator_len + id_len2;
				} else {
					this.column = sep_column_start;
					this.pos = sep_start;
				}
			} else {
				id_len += separator_len + func_token.content.length;
			}
		}

		return new Token (type,
						  start.substring (1, id_len),
						  null,
						  start,
						  offset (this.pos, start),
						  this.line,
						  column_start,
						  this.column);
	}

	private inline Token? gtkdoc_property_prefix () {
		if (get () != ':') {
			return null;
		}

		unowned string start = this.pos;
		int column_start = this.column;
		next_char ();

		int id_len = 0;

		if ((id_len = g_id_prefix ()) == 0) {
			this.column = column_start;
			this.pos = start;
			return null;
		}

		return new Token (TokenType.GTKDOC_PROPERTY,
						  start.substring (1, id_len),
						  null,
						  start,
						  offset (this.pos, start),
						  this.line,
						  column_start,
						  this.column);
	}

	private inline Token? gtkdoc_signal_prefix () {
		if (get () != ':') {
			return null;
		}

		unowned string start = this.pos;
		int column_start = this.column;
		if (next_char () != ':') {
			this.column = column_start;
			this.pos = start;
			return null;
		}


		start = this.pos;
		next_char ();

		int id_len = 0;

		if ((id_len = g_id_prefix ()) == 0) {
			this.column = column_start;
			this.pos = start;
			return null;
		}

		return new Token (TokenType.GTKDOC_SIGNAL,
						  start.substring (1, id_len),
						  null,
						  start,
						  offset (this.pos, start),
						  this.line,
						  column_start,
						  this.column);
	}

	private inline Token? gtkdoc_const_prefix () {
		return gtkdoc_symbolic_link_prefix ('%', TokenType.GTKDOC_CONST);
	}

	private inline Token? gtkdoc_param_prefix () {
		return gtkdoc_symbolic_link_prefix ('@', TokenType.GTKDOC_PARAM);
	}

	private inline Token? gtkdoc_type_prefix () {
		return gtkdoc_symbolic_link_prefix ('#', TokenType.GTKDOC_TYPE);
	}

	private inline Token? xml_prefix () {
		if (get () != '<') {
			return null;
		}

		unowned string start = this.pos;
		int line_start = this.line;
		int column_start = this.column;
		next_char ();

		if (get () == '!') {
			// comment
			if (next_char () == '-') {
				if (next_char () != '-') {
					this.column = column_start;
					this.pos = start;
					return null;
				}

				for (unichar c = next_char (); c != '\0'; c = next_char ()) {
					if (c == '\n') {
						this.line++;
						this.column = 0;
					} else if (this.pos.has_prefix ("-->")) {
						next_char ();
						next_char ();
						next_char ();
						return new Token (TokenType.XML_COMMENT,
										  "",
										  null,
										  start,
										  offset (this.pos, start),
										  this.line,
										  column_start,
										  this.column);
					}
				}
			} else if (this.pos.has_prefix ("[CDATA[")) {
				next_char ();
				next_char ();
				next_char ();
				next_char ();
				next_char ();
				next_char ();

				for (unichar c = next_char (); c != '\0'; c = next_char ()) {
					if (c == '\n') {
						this.line++;
						this.column = 0;
					} else if (this.pos.has_prefix ("]]>")) {
						string content = start.substring (9, offset (this.pos, start) - 9);
						next_char ();
						next_char ();
						next_char ();
						return new Token (TokenType.WORD,
										  unescape (content),
										  null,
										  start,
										  offset (this.pos, start),
										  this.line,
										  column_start,
										  this.column);
					}
				}
			}

			this.pos = start;
			this.column = column_start;
			this.line = line_start;
			return null;
		}

		bool close = false;
		if (get () == '/') {
			next_char ();
			close = true;
		}

		unowned string id_start = this.pos;

		int id_len = 0;
		if ((id_len = id_prefix ()) == 0) {
			this.column = column_start;
			this.pos = start;
			return null;
		}

		Vala.HashMap<string, string> map = new Vala.HashMap<string, string> (str_hash, str_equal);

		while (close == false && skip_spaces_and_newlines () > 0) {
			string name;
			string val;

			unowned string att_pos = this.pos;
			int att_id_len = 0;
			if ((att_id_len = id_prefix ()) == 0) {
				break;
			}

			name = att_pos.substring (0, att_id_len);

			if (get() != '=') {
				break;
			}

			next_char ();
			skip_spaces_and_newlines ();

			if (get() != '"') {
				break;
			}

			unichar c = next_char ();
			att_pos = this.pos;
			for (; c != '\0' && c != '\n' && c != '"' ; c = next_char ());

			val = att_pos.substring (0, offset (this.pos, att_pos));

			if (get() != '"') {
				break;
			}

			next_char ();

			map.set (name, val);
		}

		skip_spaces_and_newlines ();

		bool open_and_close = false;

		if (!close && get () == '/') {
			open_and_close = true;
			next_char ();
		}

		if (get () != '>') {
			this.line = line_start;
			this.column = column_start;
			this.pos = start;
			return null;
		}

		next_char ();

		if (open_and_close) {
			this.tmp_token = new Token (TokenType.XML_CLOSE,
										id_start.substring (0, id_len),
										null,
										start,
										offset (this.pos, start),
										this.line,
										column_start,
										this.column);
		}

		if (close) {
			return new Token (TokenType.XML_CLOSE,
							  id_start.substring (0, id_len),
							  null,
							  start,
							  offset (this.pos, start),
							  this.line,
							  column_start,
							  this.column);
		} else {
			return new Token (TokenType.XML_OPEN,
							  id_start.substring (0, id_len),
							  map,
							  start,
							  offset (this.pos, start),
							  this.line,
							  column_start,
							  this.column);
		}
	}

	private Token? newline_prefix () {
		if (get () != '\n') {
			return null;
		}

		unowned string start = this.pos;
		this.line++;
		this.column = 0;

		for (unichar c = next_char (); c == ' ' || c == '\t' ; c = next_char ());

		if (get () == '\n') {
			next_char ();
			this.line++;
			this.column = 0;
			return new Token (TokenType.GTKDOC_PARAGRAPH,
							  "\n\n",
							  null,
							  start,
							  offset (this.pos, start),
							  this.line,
							  this.column,
							  this.column);
		} else {
			return new Token (TokenType.NEWLINE,
							  "\n",
							  null,
							  start,
							  offset (this.pos, start),
							  this.line,
							  this.column,
							  this.column);
		}
	}

	private Token? eof_prefix () {
		if (get () != '\0') {
			return null;
		}

		return new Token (TokenType.EOF,
						  "",
						  null,
						  this.pos,
						  1,
						  this.line,
						  this.column,
						  this.column);
	}

	private Token? space_prefix () {
		unowned string start = this.pos;
		int column_start = this.column;
		for (unichar c = get (); c == ' ' || c == '\t'; c = next_char ());
		int len = offset (this.pos, start);
		if (len == 0) {
			this.column = column_start;
			this.pos = start;
			return null;
		}

		return new Token (TokenType.SPACE,
						  start.substring (0, len),
						  null,
						  start,
						  offset (this.pos, start),
						  this.line,
						  column_start,
						  this.column);
	}

	private Token? word_prefix () {
		unowned string start = this.pos;
		int column_start = this.column;
		unichar c = get ();
		if (c == '<' || c == '@') {
			next_char ();
		}

		for (c = get (); c != ' ' && c != '\t' && c != '\n' && c != '\0' && c != '<' && c != '@'; c = next_char ());
		int len = offset (this.pos, start);
		if (len == 0) {
			this.column = column_start;
			this.pos = start;
			return null;
		}

		return new Token (TokenType.WORD,
						  unescape (start.substring (0, len)),
						  null,
						  start,
						  offset (this.pos, start),
						  this.line,
						  column_start,
						  this.column);
	}

	private Token? gtkdoc_source_open_prefix () {
		if (!this.pos.has_prefix ("|[")) {
			return null;
		}

		unowned string start = this.pos;
		int column_start = this.column;
		next_char ();
		next_char ();

		return new Token (TokenType.GTKDOC_SOURCE_OPEN,
						  "|[",
						  null,
						  start,
						  offset (this.pos, start),
						  this.line,
						  column_start,
						  this.column);
	}

	private Token? gtkdoc_source_close_prefix () {
		if (!this.pos.has_prefix ("]|")) {
			return null;
		}

		unowned string start = this.pos;
		int column_start = this.column;
		next_char ();
		next_char ();

		return new Token (TokenType.GTKDOC_SOURCE_CLOSE, "]|",
						  null,
						  start,
						  offset (this.pos, start),
						  this.line,
						  column_start,
						  this.column);
	}

	public Token next () {
		if (tmp_token != null) {
			var tmp = tmp_token;
			tmp_token = null;
			return tmp;
		}

		Token? token = function_prefix ();
		if (token != null) {
			return token;
		}

		token = xml_prefix ();
		if (token != null) {
			return token;
		}

		token = gtkdoc_param_prefix ();
		if (token != null) {
			return token;
		}

		token = gtkdoc_const_prefix ();
		if (token != null) {
			return token;
		}

		token = gtkdoc_type_prefix ();
		if (token != null) {
			return token;
		}

		token = space_prefix ();
		if (token != null) {
			return token;
		}

		token = newline_prefix ();
		if (token != null) {
			return token;
		}

		token = gtkdoc_signal_prefix ();
		if (token != null) {
			return token;
		}

		token = gtkdoc_property_prefix ();
		if (token != null) {
			return token;
		}

		token = gtkdoc_source_open_prefix ();
		if (token != null) {
			return token;
		}

		token = gtkdoc_source_close_prefix ();
		if (token != null) {
			return token;
		}

		token = eof_prefix ();
		if (token != null) {
			return token;
		}

		token = word_prefix ();
		if (token != null) {
			return token;
		}

		assert_not_reached ();
	}
}

