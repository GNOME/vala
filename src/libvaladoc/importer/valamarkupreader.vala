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

using Vala;
using GLib;

// (not completely) Modified version of vala's MarkupReader

/**
 * Simple reader for a subset of XML.
 */

public class Valadoc.MarkupReader : Object {
	public string filename { get; private set; }

	public string name { get; private set; }

	public string text { get; private set; }

	public int column { get; private set; }

	public int line { get; private set; }

	public string get_line_str () {
		char* pos = line_start+1;

		for (; pos < end && pos[1] != '\n'; pos++);

		return ((string) line_start).substring (1, (long) (pos-line_start));
	}

	MappedFile mapped_file;

	char* line_start;
	char* begin;
	char* current;
	char* end;

	//int line;
	//int column;


	Map<string,string> attributes = new HashMap<string,string> (str_hash, str_equal);
	bool empty_element;

	public MarkupReader (string filename) {
		this.filename = filename;

		try {
			mapped_file = new MappedFile (filename, false);
			begin = mapped_file.get_contents ();
			end = begin + mapped_file.get_length ();

			line_start = begin;
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
			if (current[0] == ' ' || current[0] == '>'
			    || current[0] == '/' || current[0] == '=') {
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

	public MarkupTokenType read_token (out Vala.SourceLocation token_begin, out Vala.SourceLocation token_end) {
		attributes.clear ();

		if (empty_element) {
			empty_element = false;
			return MarkupTokenType.END_ELEMENT;
		}

		char* start_pos = current;
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
					char* attr_begin = current;
					while (current < end && current[0] != '"') {
						unichar u = ((string) current).get_char_validated ((long) (end - current));
						if (u != (unichar) (-1)) {
							current += u.to_utf8 (null);
						} else {
							Report.error (null, "invalid UTF-8 character");
						}
					}
					// TODO process &amp; &gt; &lt; &quot; &apos;
					string attr_value = ((string) attr_begin).ndup (current - attr_begin);
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
			var str = new StringBuilder ();
			char* text_begin = start_pos;
			while (current < end && current[0] != '<') {
				unichar u = ((string) current).get_char_validated ((long) (end - current));
				if (u != (unichar) (-1)) {
					current += u.to_utf8 (null);
				} else {
					Report.error (null, "invalid UTF-8 character");
				}

				if (u == '&') {
					str.append_len ((string) text_begin, (long) (current - text_begin - 1));
					if (((string) current).has_prefix ("apos;")) {
						str.append_c ('\'');
						current += 5;
					} else if (((string) current).has_prefix ("quot;")) {
						str.append_c ('"');
						current += 5;
					} else if (((string) current).has_prefix ("amp;")) {
						str.append_c ('&');
						current += 4;
					} else if (((string) current).has_prefix ("gt;")) {
						str.append_c ('>');
						current += 3;
					} else if (((string) current).has_prefix ("lt;")) {
						str.append_c ('<');
						current += 3;
					} else {
						str.append_c ('&');
					}
					text_begin = current;
				}
			}
			if (text_begin == current && str.len == 0) {
				// no text
				// read next token
				return read_token (out token_begin, out token_end);
			}
			str.append_len ((string) text_begin, (long) (current - text_begin));
			type = MarkupTokenType.TEXT;
			text = str.str;
		}

		column += (int) (current - begin);

		token_end.pos = current;
		token_end.line = line;
		token_end.column = column - 1;

		return type;
	}

	void space () {
		while (current < end && current[0].isspace ()) {
			if (current[0] == '\n') {
				line_start = current;
				line++;
				column = 0;
			}
			current++;
			column++;
		}
	}
}


