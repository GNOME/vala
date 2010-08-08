/* valamarkupreader.vala
 *
 * Copyright (C) 2008-2009  Jürg Billeter
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
 */

using GLib;

/**
 * Simple reader for a subset of XML.
 */
public class Vala.MarkupReader : Object {
	public string filename { get; private set; }

	public string name { get; private set; }

	public string content { get; private set; }

	MappedFile mapped_file;

	char* begin;
	char* current;
	char* end;

	int line;
	int column;

	Map<string,string> attributes = new HashMap<string,string> (str_hash, str_equal);
	bool empty_element;

	public MarkupReader (string filename) {
		this.filename = filename;

		try {
			mapped_file = new MappedFile (filename, false);
			begin = mapped_file.get_contents ();
			end = begin + mapped_file.get_length ();

			current = begin;

			line = 1;
			column = 1;
		} catch (FileError e) {
			Report.error (null, "Unable to map file `%s': %s".printf (filename, e.message));
		}
	}

	public string? get_attribute (string attr) {
		return attributes[attr];
	}

	string read_name () {
		char* begin = current;
		while (current < end) {
			if (current[0] == ' ' || current[0] == '\t' || current[0] == '>'
			    || current[0] == '/' || current[0] == '=' || current[0] == '\n') {
				break;
			}
			unichar u = ((string) current).get_char_validated ((long) (end - current));
			if (u != (unichar) (-1)) {
				current += u.to_utf8 (null);
			} else {
				Report.error (null, "invalid UTF-8 character");
			}
		}
		if (current == begin) {
			// syntax error: invalid name
		}
		return ((string) begin).ndup (current - begin);
	}

	public MarkupTokenType read_token (out SourceLocation token_begin, out SourceLocation token_end) {
		attributes.clear ();

		if (empty_element) {
			empty_element = false;
			return MarkupTokenType.END_ELEMENT;
		}

		space ();

		MarkupTokenType type = MarkupTokenType.NONE;
		char* begin = current;
		token_begin.pos = begin;
		token_begin.line = line;
		token_begin.column = column;

		if (current >= end) {
			type = MarkupTokenType.EOF;
		} else if (current[0] == '<') {
			current++;
			if (current >= end) {
				// error
			} else if (current[0] == '?') {
				// processing instruction
			} else if (current[0] == '!') {
				// comment or doctype
				current++;
				if (current < end - 1 && current[0] == '-' && current[1] == '-') {
					// comment
					current += 2;
					while (current < end - 2) {
						if (current[0] == '-' && current[1] == '-' && current[2] == '>') {
							// end of comment
							current += 3;
							break;
						} else if (current[0] == '\n') {
							line++;
							column = 0;
						}
						current++;
					}

					// ignore comment, read next token
					return read_token (out token_begin, out token_end);
				}
			} else if (current[0] == '/') {
				type = MarkupTokenType.END_ELEMENT;
				current++;
				name = read_name ();
				if (current >= end || current[0] != '>') {
					// error
				}
				current++;
			} else {
				type = MarkupTokenType.START_ELEMENT;
				name = read_name ();
				space ();
				while (current < end && current[0] != '>' && current[0] != '/') {
					string attr_name = read_name ();
					if (current >= end || current[0] != '=') {
						// error
					}
					current++;
					// FIXME allow single quotes
					if (current >= end || current[0] != '"') {
						// error
					}
					current++;

					string attr_value = text ('"');

					if (current >= end || current[0] != '"') {
						// error
					}
					current++;
					attributes.set (attr_name, attr_value);
					space ();
				}
				if (current[0] == '/') {
					empty_element = true;
					current++;
					space ();
				} else {
					empty_element = false;
				}
				if (current >= end || current[0] != '>') {
					// error
				}
				current++;
			}
		} else {
			space ();

			if (current[0] != '<') {
				content = text ('<');
			} else {
				// no text
				// read next token
				return read_token (out token_begin, out token_end);
			}

			type = MarkupTokenType.TEXT;
		}

		token_end.pos = current;
		token_end.line = line;
		token_end.column = column - 1;

		return type;
	}

	string text (char end_char) {
		StringBuilder content = new StringBuilder ();
		char* text_begin = current;
		char* last_linebreak = current;

		while (current < end && current[0] != end_char) {
			unichar u = ((string) current).get_char_validated ((long) (end - current));
			if (u == (unichar) (-1)) {
				Report.error (null, "invalid UTF-8 character");
			} else if (u == '&') {
				char* next_pos = current + u.to_utf8 (null);
				if (((string) next_pos).has_prefix ("amp;")) {
					content.append (((string) text_begin).ndup (current - text_begin));
					content.append_c ('&');
					current += 5;
					text_begin = current;
				} else if (((string) next_pos).has_prefix ("quot;")) {
					content.append (((string) text_begin).ndup (current - text_begin));
					content.append_c ('"');
					current += 6;
					text_begin = current;
				} else if (((string) next_pos).has_prefix ("apos;")) {
					content.append (((string) text_begin).ndup (current - text_begin));
					content.append_c ('\'');
					current += 6;
					text_begin = current;
				} else if (((string) next_pos).has_prefix ("lt;")) {
					content.append (((string) text_begin).ndup (current - text_begin));
					content.append_c ('<');
					current += 4;
					text_begin = current;
				} else if (((string) next_pos).has_prefix ("gt;")) {
					content.append (((string) text_begin).ndup (current - text_begin));
					content.append_c ('>');
					current += 4;
					text_begin = current;
				} else {
					current += u.to_utf8 (null);
				}
			} else {
				if (u == '\n') {
					line++;
					column = 0;
					last_linebreak = current;
				}

				current += u.to_utf8 (null);
				column++;
			}
		}

		if (text_begin != current) {
			content.append (((string) text_begin).ndup (current - text_begin));
		}

		column += (int) (current - last_linebreak);

		return content.str;
	}

	void space () {
		while (current < end && current[0].isspace ()) {
			if (current[0] == '\n') {
				line++;
				column = 0;
			}
			current++;
			column++;
		}
	}
}

public enum Vala.MarkupTokenType {
	NONE,
	START_ELEMENT,
	END_ELEMENT,
	TEXT,
	EOF;

	public unowned string to_string () {
		switch (this) {
		case START_ELEMENT: return "start element";
		case END_ELEMENT: return "end element";
		case TEXT: return "text";
		case EOF: return "end of file";
		default: return "unknown token type";
		}
	}
}

