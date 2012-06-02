/* valascanner.vala
 *
 * Copyright (C) 2008-2012  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 * 	Jukka-Pekka Iivonen <jp0409@jippii.fi>
 */

using GLib;

/**
 * Lexical scanner for Vala source files.
 */
public class Vala.Scanner {
	public SourceFile source_file { get; private set; }

	TokenType previous;
	char* current;
	char* end;

	int line;
	int column;

	Comment _comment;

	Conditional[] conditional_stack;

	struct Conditional {
		public bool matched;
		public bool else_found;
		public bool skip_section;
	}

	State[] state_stack;

	enum State {
		PARENS,
		BRACE,
		BRACKET,
		TEMPLATE,
		TEMPLATE_PART,
		REGEX_LITERAL
	}

	public Scanner (SourceFile source_file) {
		this.source_file = source_file;

		char* begin = source_file.get_mapped_contents ();
		end = begin + source_file.get_mapped_length ();

		current = begin;

		line = 1;
		column = 1;
	}

	public void seek (SourceLocation location) {
		current = location.pos;
		line = location.line;
		column = location.column;

		conditional_stack = null;
		state_stack = null;
	}

	bool in_template () {
		return (state_stack.length > 0 && state_stack[state_stack.length - 1] == State.TEMPLATE);
	}

	bool in_template_part () {
		return (state_stack.length > 0 && state_stack[state_stack.length - 1] == State.TEMPLATE_PART);
	}

	bool in_regex_literal () {
		return (state_stack.length > 0 && state_stack[state_stack.length - 1] == State.REGEX_LITERAL);
	}

	bool is_ident_char (char c) {
		return (c.isalnum () || c == '_');
	}

	SourceReference get_source_reference (int offset, int length = 0) {
		return new SourceReference (source_file, SourceLocation (current, line, column + offset), SourceLocation (current + length, line, column + offset + length));
	}

	public TokenType read_regex_token (out SourceLocation token_begin, out SourceLocation token_end) {
		TokenType type;
		char* begin = current;
		token_begin = SourceLocation (begin, line, column);

		int token_length_in_chars = -1;

		if (current >= end) {
			type = TokenType.EOF;
		} else {
			switch (current[0]) {
			case '/':
				type = TokenType.CLOSE_REGEX_LITERAL;
				current++;
				state_stack.length--;
				var fl_i = false;
				var fl_s = false;
				var fl_m = false;
				var fl_x = false;
				while (current[0] == 'i' || current[0] == 's' || current[0] == 'm' || current[0] == 'x') {
					switch (current[0]) {
					case 'i':
						if (fl_i) {
							Report.error (get_source_reference (token_length_in_chars), "modifier 'i' used more than once");
						}
						fl_i = true;
						break;
					case 's':
						if (fl_s) {
							Report.error (get_source_reference (token_length_in_chars), "modifier 's' used more than once");
						}
						fl_s = true;
						break;
					case 'm':
						if (fl_m) {
							Report.error (get_source_reference (token_length_in_chars), "modifier 'm' used more than once");
						}
						fl_m = true;
						break;
					case 'x':
						if (fl_x) {
							Report.error (get_source_reference (token_length_in_chars), "modifier 'x' used more than once");
						}
						fl_x = true;
						break;
					}
					current++;
					token_length_in_chars++;
				}
				break;
			default:
				type = TokenType.REGEX_LITERAL;
				token_length_in_chars = 0;
				while (current < end && current[0] != '/') {
					if (current[0] == '\\') {
						current++;
						token_length_in_chars++;
						if (current >= end) {
							break;
						}

						switch (current[0]) {
						case '\'':
						case '"':
						case '\\':
						case '/':
						case '^':
						case '$':
						case '.':
						case '[':
						case ']':
						case '{':
						case '}':
						case '(':
						case ')':
						case '?':
						case '*':
						case '+':
						case '-':
						case '#':
						case '&':
						case '~':
						case ':':
						case ';':
						case '<':
						case '>':
						case '|':
						case '%':
						case '=':
						case '@':
						case '0':
						case 'b':
						case 'B':
						case 'f':
						case 'n':
						case 'r':
						case 't':
						case 'a':
						case 'A':
						case 'p':
						case 'P':
						case 'e':
						case 'd':
						case 'D':
						case 's':
						case 'S':
						case 'w':
						case 'W':
						case 'G':
						case 'z':
						case 'Z':
							current++;
							token_length_in_chars++;
							break;
						case 'x':
							// hexadecimal escape character
							current++;
							token_length_in_chars++;
							while (current < end && current[0].isxdigit ()) {
								current++;
								token_length_in_chars++;
							}
							break;
						default:
							Report.error (get_source_reference (token_length_in_chars), "invalid escape sequence");
							break;
						}
					} else if (current[0] == '\n') {
						break;
					} else {
						unichar u = ((string) current).get_char_validated ((long) (end - current));
						if (u != (unichar) (-1)) {
							current += u.to_utf8 (null);
							token_length_in_chars++;
						} else {
							current++;
							Report.error (get_source_reference (token_length_in_chars), "invalid UTF-8 character");
						}
					}
				}
				if (current >= end || current[0] == '\n') {
					Report.error (get_source_reference (token_length_in_chars), "syntax error, expected \"");
					state_stack.length--;
					return read_token (out token_begin, out token_end);
				}
				break;
			}
		}

		if (token_length_in_chars < 0) {
			column += (int) (current - begin);
		} else {
			column += token_length_in_chars;
		}

		token_end = SourceLocation (current, line, column - 1);

		return type;
	}

	public static TokenType get_identifier_or_keyword (char* begin, int len) {
		switch (len) {
		case 2:
			switch (begin[0]) {
			case 'a':
				if (matches (begin, "as")) return TokenType.AS;
				break;
			case 'd':
				if (matches (begin, "do")) return TokenType.DO;
				break;
			case 'i':
				switch (begin[1]) {
				case 'f':
					return TokenType.IF;
				case 'n':
					return TokenType.IN;
				case 's':
					return TokenType.IS;
				}
				break;
			}
			break;
		case 3:
			switch (begin[0]) {
			case 'f':
				if (matches (begin, "for")) return TokenType.FOR;
				break;
			case 'g':
				if (matches (begin, "get")) return TokenType.GET;
				break;
			case 'n':
				if (matches (begin, "new")) return TokenType.NEW;
				break;
			case 'o':
				if (matches (begin, "out")) return TokenType.OUT;
				break;
			case 'r':
				if (matches (begin, "ref")) return TokenType.REF;
				break;
			case 's':
				if (matches (begin, "set")) return TokenType.SET;
				break;
			case 't':
				if (matches (begin, "try")) return TokenType.TRY;
				break;
			case 'v':
				if (matches (begin, "var")) return TokenType.VAR;
				break;
			}
			break;
		case 4:
			switch (begin[0]) {
			case 'b':
				if (matches (begin, "base")) return TokenType.BASE;
				break;
			case 'c':
				if (matches (begin, "case")) return TokenType.CASE;
				break;
			case 'e':
				switch (begin[1]) {
				case 'l':
					if (matches (begin, "else")) return TokenType.ELSE;
					break;
				case 'n':
					if (matches (begin, "enum")) return TokenType.ENUM;
					break;
				}
				break;
			case 'l':
				if (matches (begin, "lock")) return TokenType.LOCK;
				break;
			case 'n':
				if (matches (begin, "null")) return TokenType.NULL;
				break;
			case 't':
				switch (begin[1]) {
				case 'h':
					if (matches (begin, "this")) return TokenType.THIS;
					break;
				case 'r':
					if (matches (begin, "true")) return TokenType.TRUE;
					break;
				}
				break;
			case 'v':
				if (matches (begin, "void")) return TokenType.VOID;
				break;
			case 'w':
				if (matches (begin, "weak")) return TokenType.WEAK;
				break;
			}
			break;
		case 5:
			switch (begin[0]) {
			case 'a':
				if (matches (begin, "async")) return TokenType.ASYNC;
				break;
			case 'b':
				if (matches (begin, "break")) return TokenType.BREAK;
				break;
			case 'c':
				switch (begin[1]) {
				case 'a':
					if (matches (begin, "catch")) return TokenType.CATCH;
					break;
				case 'l':
					if (matches (begin, "class")) return TokenType.CLASS;
					break;
				case 'o':
					if (matches (begin, "const")) return TokenType.CONST;
					break;
				}
				break;
			case 'f':
				if (matches (begin, "false")) return TokenType.FALSE;
				break;
			case 'o':
				if (matches (begin, "owned")) return TokenType.OWNED;
				break;
			case 't':
				if (matches (begin, "throw")) return TokenType.THROW;
				break;
			case 'u':
				if (matches (begin, "using")) return TokenType.USING;
				break;
			case 'w':
				if (matches (begin, "while")) return TokenType.WHILE;
				break;
			case 'y':
				if (matches (begin, "yield")) return TokenType.YIELD;
				break;
			}
			break;
		case 6:
			switch (begin[0]) {
			case 'd':
				if (matches (begin, "delete")) return TokenType.DELETE;
				break;
			case 'e':
				if (matches (begin, "extern")) return TokenType.EXTERN;
				break;
			case 'i':
				if (matches (begin, "inline")) return TokenType.INLINE;
				break;
			case 'p':
				switch (begin[1]) {
				case 'a':
					if (matches (begin, "params")) return TokenType.PARAMS;
					break;
				case 'u':
					if (matches (begin, "public")) return TokenType.PUBLIC;
					break;
				}
				break;
			case 'r':
				if (matches (begin, "return")) return TokenType.RETURN;
				break;
			case 's':
				switch (begin[1]) {
				case 'e':
					if (matches (begin, "sealed")) return TokenType.SEALED;
					break;
				case 'i':
					switch (begin[2]) {
					case 'g':
						if (matches (begin, "signal")) return TokenType.SIGNAL;
						break;
					case 'z':
						if (matches (begin, "sizeof")) return TokenType.SIZEOF;
						break;
					}
					break;
				case 't':
					switch (begin[2]) {
					case 'a':
						if (matches (begin, "static")) return TokenType.STATIC;
						break;
					case 'r':
						if (matches (begin, "struct")) return TokenType.STRUCT;
						break;
					}
					break;
				case 'w':
					if (matches (begin, "switch")) return TokenType.SWITCH;
					break;
				}
				break;
			case 't':
				switch (begin[1]) {
				case 'h':
					if (matches (begin, "throws")) return TokenType.THROWS;
					break;
				case 'y':
					if (matches (begin, "typeof")) return TokenType.TYPEOF;
					break;
				}
				break;
			}
			break;
		case 7:
			switch (begin[0]) {
			case 'd':
				switch (begin[1]) {
				case 'e':
					if (matches (begin, "default")) return TokenType.DEFAULT;
					break;
				case 'y':
					if (matches (begin, "dynamic")) return TokenType.DYNAMIC;
					break;
				}
				break;
			case 'e':
				if (matches (begin, "ensures")) return TokenType.ENSURES;
				break;
			case 'f':
				switch (begin[1]) {
				case 'i':
					if (matches (begin, "finally")) return TokenType.FINALLY;
					break;
				case 'o':
					if (matches (begin, "foreach")) return TokenType.FOREACH;
					break;
				}
				break;
			case 'p':
				if (matches (begin, "private")) return TokenType.PRIVATE;
				break;
			case 'u':
				if (matches (begin, "unowned")) return TokenType.UNOWNED;
				break;
			case 'v':
				if (matches (begin, "virtual")) return TokenType.VIRTUAL;
				break;
			}
			break;
		case 8:
			switch (begin[0]) {
			case 'a':
				if (matches (begin, "abstract")) return TokenType.ABSTRACT;
				break;
			case 'c':
				if (matches (begin, "continue")) return TokenType.CONTINUE;
				break;
			case 'd':
				if (matches (begin, "delegate")) return TokenType.DELEGATE;
				break;
			case 'i':
				if (matches (begin, "internal")) return TokenType.INTERNAL;
				break;
			case 'o':
				if (matches (begin, "override")) return TokenType.OVERRIDE;
				break;
			case 'r':
				if (matches (begin, "requires")) return TokenType.REQUIRES;
				break;
			case 'v':
				if (matches (begin, "volatile")) return TokenType.VOLATILE;
				break;
			}
			break;
		case 9:
			switch (begin[0]) {
			case 'c':
				if (matches (begin, "construct")) return TokenType.CONSTRUCT;
				break;
			case 'i':
				if (matches (begin, "interface")) return TokenType.INTERFACE;
				break;
			case 'n':
				if (matches (begin, "namespace")) return TokenType.NAMESPACE;
				break;
			case 'p':
				if (matches (begin, "protected")) return TokenType.PROTECTED;
				break;
			}
			break;
		case 11:
			if (matches (begin, "errordomain")) return TokenType.ERRORDOMAIN;
			break;
		}
		return TokenType.IDENTIFIER;
	}

	TokenType read_number () {
		var type = TokenType.INTEGER_LITERAL;

		// integer part
		if (current < end - 2 && current[0] == '0'
		    && current[1] == 'x' && current[2].isxdigit ()) {
			// hexadecimal integer literal
			current += 2;
			while (current < end && current[0].isxdigit ()) {
				current++;
			}
		} else {
			// decimal number
			while (current < end && current[0].isdigit ()) {
				current++;
			}
		}

		// fractional part
		if (current < end - 1 && current[0] == '.' && current[1].isdigit ()) {
			type = TokenType.REAL_LITERAL;
			current++;
			while (current < end && current[0].isdigit ()) {
				current++;
			}
		}

		// exponent part
		if (current < end && current[0].tolower () == 'e') {
			type = TokenType.REAL_LITERAL;
			current++;
			if (current < end && (current[0] == '+' || current[0] == '-')) {
				current++;
			}
			while (current < end && current[0].isdigit ()) {
				current++;
			}
		}

		// type suffix
		if (current < end) {
			bool real_literal = (type == TokenType.REAL_LITERAL);

			switch (current[0]) {
			case 'l':
			case 'L':
				if (type == TokenType.INTEGER_LITERAL) {
					current++;
					if (current < end && current[0].tolower () == 'l') {
						current++;
					}
				}
				break;
			case 'u':
			case 'U':
				if (type == TokenType.INTEGER_LITERAL) {
					current++;
					if (current < end && current[0].tolower () == 'l') {
						current++;
						if (current < end && current[0].tolower () == 'l') {
							current++;
						}
					}
				}
				break;
			case 'f':
			case 'F':
			case 'd':
			case 'D':
				type = TokenType.REAL_LITERAL;
				current++;
				break;
			}

			if (!real_literal && is_ident_char (current[0])) {
				// allow identifiers to start with a digit
				// as long as they contain at least one char
				while (current < end && is_ident_char (current[0])) {
					current++;
				}
				type = TokenType.IDENTIFIER;
			}
		}

		return type;
	}

	public TokenType read_template_token (out SourceLocation token_begin, out SourceLocation token_end) {
		TokenType type;
		char* begin = current;
		token_begin = SourceLocation (begin, line, column);

		int token_length_in_chars = -1;

		if (current >= end) {
			type = TokenType.EOF;
		} else {
			switch (current[0]) {
			case '"':
				type = TokenType.CLOSE_TEMPLATE;
				current++;
				state_stack.length--;
				break;
			case '$':
				token_begin.pos++; // $ is not part of following token
				current++;
				if (current[0].isalpha () || current[0] == '_') {
					int len = 0;
					while (current < end && is_ident_char (current[0])) {
						current++;
						len++;
					}
					type = TokenType.IDENTIFIER;
					state_stack += State.TEMPLATE_PART;
				} else if (current[0] == '(') {
					current++;
					column += 2;
					state_stack += State.PARENS;
					return read_token (out token_begin, out token_end);
				} else if (current[0] == '$') {
					type = TokenType.TEMPLATE_STRING_LITERAL;
					current++;
					state_stack += State.TEMPLATE_PART;
				} else {
					Report.error (get_source_reference (1), "unexpected character");
					return read_template_token (out token_begin, out token_end);
				}
				break;
			default:
				type = TokenType.TEMPLATE_STRING_LITERAL;
				token_length_in_chars = 0;
				while (current < end && current[0] != '"' && current[0] != '$') {
					if (current[0] == '\\') {
						current++;
						token_length_in_chars++;
						if (current >= end) {
							break;
						}

						switch (current[0]) {
						case '\'':
						case '"':
						case '\\':
						case '0':
						case 'b':
						case 'f':
						case 'n':
						case 'r':
						case 't':
							current++;
							token_length_in_chars++;
							break;
						case 'x':
							// hexadecimal escape character
							current++;
							token_length_in_chars++;
							while (current < end && current[0].isxdigit ()) {
								current++;
								token_length_in_chars++;
							}
							break;
						default:
							Report.error (get_source_reference (token_length_in_chars), "invalid escape sequence");
							break;
						}
					} else if (current[0] == '\n') {
						current++;
						line++;
						column = 1;
						token_length_in_chars = 1;
					} else {
						unichar u = ((string) current).get_char_validated ((long) (end - current));
						if (u != (unichar) (-1)) {
							current += u.to_utf8 (null);
							token_length_in_chars++;
						} else {
							current++;
							Report.error (get_source_reference (token_length_in_chars), "invalid UTF-8 character");
						}
					}
				}
				if (current >= end) {
					Report.error (get_source_reference (token_length_in_chars), "syntax error, expected \"");
					state_stack.length--;
					return read_token (out token_begin, out token_end);
				}
				state_stack += State.TEMPLATE_PART;
				break;
			}
		}

		if (token_length_in_chars < 0) {
			column += (int) (current - begin);
		} else {
			column += token_length_in_chars;
		}

		token_end = SourceLocation (current, line, column - 1);

		return type;
	}

	public TokenType read_token (out SourceLocation token_begin, out SourceLocation token_end) {
		if (in_template ()) {
			return read_template_token (out token_begin, out token_end);
		} else if (in_template_part ()) {
			state_stack.length--;

			token_begin = SourceLocation (current, line, column);
			token_end = SourceLocation (current, line, column - 1);

			return TokenType.COMMA;
		} else if (in_regex_literal ()) {
			return read_regex_token (out token_begin, out token_end);
		}

		space ();

		TokenType type;
		char* begin = current;
		token_begin = SourceLocation (begin, line, column);

		int token_length_in_chars = -1;

		if (current >= end) {
			type = TokenType.EOF;
		} else if (current[0].isalpha () || current[0] == '_') {
			int len = 0;
			while (current < end && is_ident_char (current[0])) {
				current++;
				len++;
			}
			type = get_identifier_or_keyword (begin, len);
		} else if (current[0] == '@' && source_file.context.profile != Profile.DOVA) {
			if (current < end - 1 && current[1] == '"') {
				type = TokenType.OPEN_TEMPLATE;
				current += 2;
				state_stack += State.TEMPLATE;
			} else {
				token_begin.pos++; // @ is not part of the identifier
				current++;
				int len = 0;
				while (current < end && is_ident_char (current[0])) {
					current++;
					len++;
				}
				type = TokenType.IDENTIFIER;
			}
		} else if (current[0].isdigit ()) {
			type = read_number ();
		} else {
			switch (current[0]) {
			case '{':
				type = TokenType.OPEN_BRACE;
				current++;
				state_stack += State.BRACE;
				break;
			case '}':
				type = TokenType.CLOSE_BRACE;
				current++;
				if (state_stack.length > 0) {
					state_stack.length--;
				}
				break;
			case '(':
				type = TokenType.OPEN_PARENS;
				current++;
				state_stack += State.PARENS;
				break;
			case ')':
				type = TokenType.CLOSE_PARENS;
				current++;
				if (state_stack.length > 0) {
					state_stack.length--;
				}
				if (in_template ()) {
					type = TokenType.COMMA;
				}
				break;
			case '[':
				type = TokenType.OPEN_BRACKET;
				current++;
				state_stack += State.BRACKET;
				break;
			case ']':
				type = TokenType.CLOSE_BRACKET;
				current++;
				if (state_stack.length > 0) {
					state_stack.length--;
				}
				break;
			case '.':
				type = TokenType.DOT;
				current++;
				if (current < end - 1) {
					if (current[0] == '.' && current[1] == '.') {
						type = TokenType.ELLIPSIS;
						current += 2;
					}
				}
				break;
			case ':':
				type = TokenType.COLON;
				current++;
				if (current < end && current[0] == ':') {
					type = TokenType.DOUBLE_COLON;
					current++;
				}
				break;
			case ',':
				type = TokenType.COMMA;
				current++;
				break;
			case ';':
				type = TokenType.SEMICOLON;
				current++;
				break;
			case '#':
				type = TokenType.HASH;
				current++;
				break;
			case '?':
				type = TokenType.INTERR;
				current++;
				if (current < end && current[0] == '?') {
					type = TokenType.OP_COALESCING;
					current++;
				}
				break;
			case '|':
				type = TokenType.BITWISE_OR;
				current++;
				if (current < end) {
					switch (current[0]) {
					case '=':
						type = TokenType.ASSIGN_BITWISE_OR;
						current++;
						break;
					case '|':
						type = TokenType.OP_OR;
						current++;
						break;
					}
				}
				break;
			case '&':
				type = TokenType.BITWISE_AND;
				current++;
				if (current < end) {
					switch (current[0]) {
					case '=':
						type = TokenType.ASSIGN_BITWISE_AND;
						current++;
						break;
					case '&':
						type = TokenType.OP_AND;
						current++;
						break;
					}
				}
				break;
			case '^':
				type = TokenType.CARRET;
				current++;
				if (current < end && current[0] == '=') {
					type = TokenType.ASSIGN_BITWISE_XOR;
					current++;
				}
				break;
			case '~':
				type = TokenType.TILDE;
				current++;
				break;
			case '=':
				type = TokenType.ASSIGN;
				current++;
				if (current < end) {
					switch (current[0]) {
					case '=':
						type = TokenType.OP_EQ;
						current++;
						break;
					case '>':
						type = TokenType.LAMBDA;
						current++;
						break;
					}
				}
				break;
			case '<':
				type = TokenType.OP_LT;
				current++;
				if (current < end) {
					switch (current[0]) {
					case '=':
						type = TokenType.OP_LE;
						current++;
						break;
					case '<':
						type = TokenType.OP_SHIFT_LEFT;
						current++;
						if (current < end && current[0] == '=') {
							type = TokenType.ASSIGN_SHIFT_LEFT;
							current++;
						}
						break;
					}
				}
				break;
			case '>':
				type = TokenType.OP_GT;
				current++;
				if (current < end && current[0] == '=') {
					type = TokenType.OP_GE;
					current++;
				}
				break;
			case '!':
				type = TokenType.OP_NEG;
				current++;
				if (current < end && current[0] == '=') {
					type = TokenType.OP_NE;
					current++;
				}
				break;
			case '+':
				type = TokenType.PLUS;
				current++;
				if (current < end) {
					switch (current[0]) {
					case '=':
						type = TokenType.ASSIGN_ADD;
						current++;
						break;
					case '+':
						type = TokenType.OP_INC;
						current++;
						break;
					}
				}
				break;
			case '-':
				type = TokenType.MINUS;
				current++;
				if (current < end) {
					switch (current[0]) {
					case '=':
						type = TokenType.ASSIGN_SUB;
						current++;
						break;
					case '-':
						type = TokenType.OP_DEC;
						current++;
						break;
					case '>':
						type = TokenType.OP_PTR;
						current++;
						break;
					}
				}
				break;
			case '*':
				type = TokenType.STAR;
				current++;
				if (current < end && current[0] == '=') {
					type = TokenType.ASSIGN_MUL;
					current++;
				}
				break;
			case '/':
				switch (previous) {
				case TokenType.ASSIGN:
				case TokenType.COMMA:
				case TokenType.MINUS:
				case TokenType.OP_AND:
				case TokenType.OP_COALESCING:
				case TokenType.OP_EQ:
				case TokenType.OP_GE:
				case TokenType.OP_GT:
				case TokenType.OP_LE:
				case TokenType.OP_LT:
				case TokenType.OP_NE:
				case TokenType.OP_NEG:
				case TokenType.OP_OR:
				case TokenType.OPEN_BRACE:
				case TokenType.OPEN_PARENS:
				case TokenType.PLUS:
				case TokenType.RETURN:
					type = TokenType.OPEN_REGEX_LITERAL;
					state_stack += State.REGEX_LITERAL;
					current++;
					break;
				default:
					type = TokenType.DIV;
					current++;
					if (current < end && current[0] == '=') {
						type = TokenType.ASSIGN_DIV;
						current++;
					}
					break;
				}
				break;
			case '%':
				type = TokenType.PERCENT;
				current++;
				if (current < end && current[0] == '=') {
					type = TokenType.ASSIGN_PERCENT;
					current++;
				}
				break;
			case '\'':
			case '"':
				if (begin[0] == '\'') {
					type = TokenType.CHARACTER_LITERAL;
				} else if (current < end - 6 && begin[1] == '"' && begin[2] == '"') {
					type = TokenType.VERBATIM_STRING_LITERAL;
					token_length_in_chars = 6;
					current += 3;
					while (current < end - 4) {
						if (current[0] == '"' && current[1] == '"' && current[2] == '"' && current[3] != '"') {
							break;
						} else if (current[0] == '\n') {
							current++;
							line++;
							column = 1;
							token_length_in_chars = 3;
						} else {
							unichar u = ((string) current).get_char_validated ((long) (end - current));
							if (u != (unichar) (-1)) {
								current += u.to_utf8 (null);
								token_length_in_chars++;
							} else {
								Report.error (get_source_reference (token_length_in_chars), "invalid UTF-8 character");
							}
						}
					}
					if (current[0] == '"' && current[1] == '"' && current[2] == '"') {
						current += 3;
					} else {
						Report.error (get_source_reference (token_length_in_chars), "syntax error, expected \"\"\"");
					}
					break;
				} else {
					type = TokenType.STRING_LITERAL;
				}
				token_length_in_chars = 2;
				current++;
				while (current < end && current[0] != begin[0]) {
					if (current[0] == '\\') {
						current++;
						token_length_in_chars++;
						if (current >= end) {
							break;
						}

						switch (current[0]) {
						case '\'':
						case '"':
						case '\\':
						case '0':
						case 'b':
						case 'f':
						case 'n':
						case 'r':
						case 't':
						case '$':
							current++;
							token_length_in_chars++;
							break;
						case 'x':
							// hexadecimal escape character
							current++;
							token_length_in_chars++;
							while (current < end && current[0].isxdigit ()) {
								current++;
								token_length_in_chars++;
							}
							break;
						default:
							Report.error (get_source_reference (token_length_in_chars), "invalid escape sequence");
							break;
						}
					} else if (current[0] == '\n') {
						current++;
						line++;
						column = 1;
						token_length_in_chars = 1;
					} else {
						if (type == TokenType.STRING_LITERAL && source_file.context.profile == Profile.DOVA && current[0] == '$') {
							// string template
							type = TokenType.OPEN_TEMPLATE;
							current = begin;
							state_stack += State.TEMPLATE;
							break;
						}
						unichar u = ((string) current).get_char_validated ((long) (end - current));
						if (u != (unichar) (-1)) {
							current += u.to_utf8 (null);
							token_length_in_chars++;
						} else {
							current++;
							Report.error (get_source_reference (token_length_in_chars), "invalid UTF-8 character");
						}
					}
					if (current < end && begin[0] == '\'' && current[0] != '\'') {
						// multiple characters in single character literal
						Report.error (get_source_reference (token_length_in_chars), "invalid character literal");
					}
				}
				if (current < end) {
					current++;
				} else {
					Report.error (get_source_reference (token_length_in_chars), "syntax error, expected %c".printf (begin[0]));
				}
				break;
			default:
				unichar u = ((string) current).get_char_validated ((long) (end - current));
				if (u != (unichar) (-1)) {
					current += u.to_utf8 (null);
					Report.error (get_source_reference (0), "syntax error, unexpected character");
				} else {
					current++;
					Report.error (get_source_reference (0), "invalid UTF-8 character");
				}
				column++;
				return read_token (out token_begin, out token_end);
			}
		}

		if (token_length_in_chars < 0) {
			column += (int) (current - begin);
		} else {
			column += token_length_in_chars;
		}

		token_end = SourceLocation (current, line, column - 1);
		previous = type;

		return type;
	}

	static bool matches (char* begin, string keyword) {
		char* keyword_array = (char*) keyword;
		long len = keyword.length;
		for (int i = 0; i < len; i++) {
			if (begin[i] != keyword_array[i]) {
				return false;
			}
		}
		return true;
	}

	bool pp_whitespace () {
		bool found = false;
		while (current < end && current[0].isspace () && current[0] != '\n') {
			found = true;
			current++;
			column++;
		}
		return found;
	}

	void pp_directive () {
		// hash sign
		current++;
		column++;

		if (line == 1 && column == 2 && current < end && current[0] == '!') {
			// hash bang: #!
			// skip until end of line or end of file
			while (current < end && current[0] != '\n') {
				current++;
			}
			return;
		}

		pp_whitespace ();

		char* begin = current;
		int len = 0;
		while (current < end && current[0].isalnum ()) {
			current++;
			column++;
			len++;
		}

		if (len == 2 && matches (begin, "if")) {
			parse_pp_if ();
		} else if (len == 4 && matches (begin, "elif")) {
			parse_pp_elif ();
		} else if (len == 4 && matches (begin, "else")) {
			parse_pp_else ();
		} else if (len == 5 && matches (begin, "endif")) {
			parse_pp_endif ();
		} else {
			Report.error (get_source_reference (-len, len), "syntax error, invalid preprocessing directive");
		}

		if (conditional_stack.length > 0
		    && conditional_stack[conditional_stack.length - 1].skip_section) {
			// skip lines until next preprocessing directive
			bool bol = false;
			while (current < end) {
				if (bol && current[0] == '#') {
					// go back to begin of line
					current -= (column - 1);
					column = 1;
					return;
				}
				if (current[0] == '\n') {
					line++;
					column = 0;
					bol = true;
				} else if (!current[0].isspace ()) {
					bol = false;
				}
				current++;
				column++;
			}
		}
	}

	void pp_eol () {
		pp_whitespace ();
		if (current >= end || current[0] != '\n') {
			Report.error (get_source_reference (0), "syntax error, expected newline");
		}
	}

	void parse_pp_if () {
		pp_whitespace ();

		bool condition = parse_pp_expression ();

		pp_eol ();

		conditional_stack += Conditional ();

		if (condition && (conditional_stack.length == 1 || !conditional_stack[conditional_stack.length - 2].skip_section)) {
			// condition true => process code within if
			conditional_stack[conditional_stack.length - 1].matched = true;
		} else {
			// skip lines until next preprocessing directive
			conditional_stack[conditional_stack.length - 1].skip_section = true;
		}
	}

	void parse_pp_elif () {
		pp_whitespace ();

		bool condition = parse_pp_expression ();

		pp_eol ();

		if (conditional_stack.length == 0 || conditional_stack[conditional_stack.length - 1].else_found) {
			Report.error (get_source_reference (0), "syntax error, unexpected #elif");
			return;
		}

		if (condition && !conditional_stack[conditional_stack.length - 1].matched
		    && (conditional_stack.length == 1 || !conditional_stack[conditional_stack.length - 2].skip_section)) {
			// condition true => process code within if
			conditional_stack[conditional_stack.length - 1].matched = true;
			conditional_stack[conditional_stack.length - 1].skip_section = false;
		} else {
			// skip lines until next preprocessing directive
			conditional_stack[conditional_stack.length - 1].skip_section = true;
		}
	}

	void parse_pp_else () {
		pp_eol ();

		if (conditional_stack.length == 0 || conditional_stack[conditional_stack.length - 1].else_found) {
			Report.error (get_source_reference (0), "syntax error, unexpected #else");
			return;
		}

		if (!conditional_stack[conditional_stack.length - 1].matched
		    && (conditional_stack.length == 1 || !conditional_stack[conditional_stack.length - 2].skip_section)) {
			// condition true => process code within if
			conditional_stack[conditional_stack.length - 1].matched = true;
			conditional_stack[conditional_stack.length - 1].skip_section = false;
		} else {
			// skip lines until next preprocessing directive
			conditional_stack[conditional_stack.length - 1].skip_section = true;
		}
	}

	void parse_pp_endif () {
		pp_eol ();

		if (conditional_stack.length == 0) {
			Report.error (get_source_reference (0), "syntax error, unexpected #endif");
			return;
		}

		conditional_stack.length--;
	}

	bool parse_pp_symbol () {
		int len = 0;
		while (current < end && is_ident_char (current[0])) {
			current++;
			column++;
			len++;
		}

		if (len == 0) {
			Report.error (get_source_reference (0), "syntax error, expected identifier");
			return false;
		}

		string identifier = ((string) (current - len)).substring (0, len);
		bool defined;
		if (identifier == "true") {
			defined = true;
		} else if (identifier == "false") {
			defined = false;
		} else {
			defined = source_file.context.is_defined (identifier);
		}

		return defined;
	}

	bool parse_pp_primary_expression () {
		if (current >= end) {
			Report.error (get_source_reference (0), "syntax error, expected identifier");
		} else if (is_ident_char (current[0])) {
			return parse_pp_symbol ();
		} else if (current[0] == '(') {
			current++;
			column++;
			pp_whitespace ();
			bool result = parse_pp_expression ();
			pp_whitespace ();
			if (current < end && current[0] ==  ')') {
				current++;
				column++;
			} else {
				Report.error (get_source_reference (0), "syntax error, expected `)'");
			}
			return result;
		} else {
			Report.error (get_source_reference (0), "syntax error, expected identifier");
		}
		return false;
	}

	bool parse_pp_unary_expression () {
		if (current < end && current[0] == '!') {
			current++;
			column++;
			pp_whitespace ();
			return !parse_pp_unary_expression ();
		}

		return parse_pp_primary_expression ();
	}

	bool parse_pp_equality_expression () {
		bool left = parse_pp_unary_expression ();
		pp_whitespace ();
		while (true) {
			if (current < end - 1 && current[0] == '=' && current[1] == '=') {
				current += 2;
				column += 2;
				pp_whitespace ();
				bool right = parse_pp_unary_expression ();
				left = (left == right);
			} else if (current < end - 1 && current[0] == '!' && current[1] == '=') {
				current += 2;
				column += 2;
				pp_whitespace ();
				bool right = parse_pp_unary_expression ();
				left = (left != right);
			} else {
				break;
			}
		}
		return left;
	}

	bool parse_pp_and_expression () {
		bool left = parse_pp_equality_expression ();
		pp_whitespace ();
		while (current < end - 1 && current[0] == '&' && current[1] == '&') {
			current += 2;
			column += 2;
			pp_whitespace ();
			bool right = parse_pp_equality_expression ();
			left = left && right;
		}
		return left;
	}

	bool parse_pp_or_expression () {
		bool left = parse_pp_and_expression ();
		pp_whitespace ();
		while (current < end - 1 && current[0] == '|' && current[1] == '|') {
			current += 2;
			column += 2;
			pp_whitespace ();
			bool right = parse_pp_and_expression ();
			left = left || right;
		}
		return left;
	}

	bool parse_pp_expression () {
		return parse_pp_or_expression ();
	}

	bool whitespace () {
		bool found = false;
		bool bol = (column == 1);
		while (current < end && current[0].isspace ()) {
			if (current[0] == '\n') {
				line++;
				column = 0;
				bol = true;
			}
			found = true;
			current++;
			column++;
		}
		if (bol && current < end && current[0] == '#') {
			pp_directive ();
			return true;
		}
		return found;
	}

	bool comment (bool file_comment = false) {
		if (current == null
		    || current > end - 2
		    || current[0] != '/'
		    || (current[1] != '/' && current[1] != '*')) {
			return false;
		}

		if (current[1] == '/') {
			SourceReference source_reference = null;
			if (file_comment) {
				source_reference = get_source_reference (0);
			}

			// single-line comment
			current += 2;
			char* begin = current;

			// skip until end of line or end of file
			while (current < end && current[0] != '\n') {
				current++;
			}

			if (source_reference != null) {
				push_comment (((string) begin).substring (0, (long) (current - begin)), source_reference, file_comment);
			}
		} else {
			SourceReference source_reference = null;

			if (file_comment && current[2] == '*') {
				return false;
			}

			if (current[2] == '*' || file_comment) {
				source_reference = get_source_reference (0);
			}

			current += 2;

			char* begin = current;
			while (current < end - 1
			       && (current[0] != '*' || current[1] != '/')) {
				if (current[0] == '\n') {
					line++;
					column = 0;
				}
				current++;
				column++;
			}

			if (current == end - 1) {
				Report.error (get_source_reference (0), "syntax error, expected */");
				return true;
			}

			if (source_reference != null) {
				push_comment (((string) begin).substring (0, (long) (current - begin)), source_reference, file_comment);
			}

			current += 2;
			column += 2;
		}

		return true;
	}

	void space () {
		while (whitespace () || comment ()) {
		}
	}

	public void parse_file_comments () {
		while (whitespace () || comment (true)) {
		}
	}

	void push_comment (string comment_item, SourceReference source_reference, bool file_comment) {
		if (comment_item[0] == '*') {
			if (_comment != null) {
				// extra doc comment, add it to source file comments
				source_file.add_comment (_comment);
			}
			_comment = new Comment (comment_item, source_reference);
		}

		if (file_comment) {
			source_file.add_comment (new Comment (comment_item, source_reference));
			_comment = null;
		}
	}

	/**
	 * Clears and returns the content of the comment stack.
	 *
	 * @return saved comment
	 */
	public Comment? pop_comment () {
		if (_comment == null) {
			return null;
		}

		var comment = _comment;
		_comment = null;
		return comment;
	}
}

