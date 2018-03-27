/* xmlscanner.vala
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
 * A cheap scanner used to highlight XML.
 */
public class Valadoc.Highlighter.XmlScanner : Object, Scanner {
	private Queue<CodeToken> token_queue = new Queue<CodeToken> ();
	private unowned string content;
	private unowned string pos;


	public XmlScanner (string content) {
		this.content = content;
		this.pos = content;
	}

	public CodeToken next () {
		if (!token_queue.is_empty ()) {
			return token_queue.pop_head ();
		}

		unowned string start;

		for (start = pos; pos[0] != '\0'; pos = pos.next_char ()) {
			if (pos[0] == '&') {
				unowned string begin = pos;
				if (queue_escape ()) {
					return dispatch (start, begin);
				}
			} else if (pos[0] == '<') {
				if (pos[1] == '/') {
					unowned string end = pos;
					if (queue_end_element ()) {
						return dispatch (start, end);
					}
				} else if (pos[1] == '!' && pos[2] == '-' && pos[3] == '-') {
					unowned string end = pos;
					if (queue_comment ()) {
						return dispatch (start, end);
					}
				} else if (pos[1] == '!' && pos[2] == '[' && pos[3] == 'C' && pos[4] == 'D' && pos[5] == 'A' && pos[6] == 'T' && pos[7] == 'A' && pos[8] == '[') {
					unowned string end = pos;
					pos = pos.offset (9);
					token_queue.push_tail (new CodeToken (CodeTokenType.XML_CDATA, "<![CDATA["));
					return dispatch (start, end);
				} else {
					unowned string end = pos;
					if (queue_start_element (start, pos[1] == '?')) {
						return dispatch (start, end);
					} else {
						continue;
					}
				}
			} else if (pos[0] == ']' && pos[1] == ']' && pos[2] == '>') {
				unowned string end = pos;
				pos = pos.offset (3);
				token_queue.push_tail (new CodeToken (CodeTokenType.XML_CDATA, "]]>"));
				return dispatch (start, end);
			}
		}

		token_queue.push_tail (new CodeToken (CodeTokenType.EOF, ""));
		return dispatch (start, pos);
	}

	private bool queue_start_element (string dispatch_start, bool xml_decl) {
		assert (token_queue.is_empty ());

		unowned string element_start = pos;
		if (xml_decl) {
			pos = pos.offset (2);
		} else {
			pos = pos.offset (1);
		}

		skip_optional_spaces (ref pos);

		if (skip_id (ref pos) == false) {
			token_queue.clear ();
			pos = element_start;
			return false;
		}

		skip_optional_spaces (ref pos);

		queue_token (element_start, pos, CodeTokenType.XML_ELEMENT);

		if (queue_attributes () == false) {
			token_queue.clear ();
			pos = element_start;
			return false;
		}

		unowned string element_end_start = pos;

		if (!xml_decl && pos[0] == '>') {
			pos = pos.offset (1);
		} else if (!xml_decl && pos[0] == '/' && pos[1] == '>') {
			pos = pos.offset (2);
		} else if (xml_decl && pos[0] == '?' && pos[1] == '>') {
			pos = pos.offset (2);
		} else {
			token_queue.clear ();
			pos = element_start;
			return false;
		}

		queue_token (element_end_start, pos, CodeTokenType.XML_ELEMENT);
		return true;
	}

	private bool queue_attributes () {
		while (is_id_char (pos[0])) {
			unowned string begin = pos;

			if (skip_id (ref pos) == false) {
				return false;
			}

			skip_optional_spaces (ref pos);

			if (pos[0] == '=') {
				pos = pos.offset (1);
			} else {
				return false;
			}

			skip_optional_spaces (ref pos);

			queue_token (begin, pos, CodeTokenType.XML_ATTRIBUTE);
			begin = pos;

			if (pos[0] == '"') {
				pos = pos.offset (1);
			} else {
				return false;
			}

			while (pos[0] != '"' && pos[0] != '\0') {
				pos = pos.offset (1);
			}

			if (pos[0] == '"') {
				pos = pos.offset (1);
			} else {
				return false;
			}

			skip_optional_spaces (ref pos);

			queue_token (begin, pos, CodeTokenType.XML_ATTRIBUTE_VALUE);
		}

		return true;
	}

	private bool queue_end_element () {
		unowned string start = pos;
		pos = pos.offset (2);

		skip_optional_spaces (ref pos);

		if (skip_id (ref pos) == false) {
			pos = start;
			return false;
		}

		skip_optional_spaces (ref pos);

		if (pos[0] == '>') {
			pos = pos.offset (1);
		} else {
			pos = start;
			return false;
		}

		queue_token (start, pos, CodeTokenType.XML_ELEMENT);
		return true;
	}

	private bool queue_escape () {
		unowned string start = pos;
		pos = pos.offset (1);

		if (skip_id (ref pos) == false) {
			pos = start;
			return false;
		}

		if (pos[0] == ';') {
			pos = pos.offset (1);
		} else {
			pos = start;
			return false;
		}

		queue_token (start, pos, CodeTokenType.XML_ESCAPE);
		return true;
	}

	private bool queue_comment () {
		unowned string start = pos;
		pos = pos.offset (4);

		while (pos[0] != '>' && pos[0] != '\0') {
			pos = pos.offset (1);
		}

		if (pos[0] == '>') {
			pos = pos.offset (1);
		} else {
			pos = start;
			return false;
		}

		queue_token (start, pos, CodeTokenType.XML_COMMENT);
		return true;
	}

	private static bool skip_id (ref unowned string pos) {
		bool has_next_segment = true;
		bool has_id = false;

		while (has_next_segment) {
			has_id = false;

			while (is_id_char (pos[0])) {
				pos = pos.offset (1);
				has_id = true;
			}

			if (pos[0] == ':' && has_id) {
				has_next_segment = true;
				pos = pos.offset (1);
			} else {
				has_next_segment = false;
			}
		}

		return has_id;
	}

	private static bool skip_optional_spaces (ref unowned string pos) {
		bool skipped = false;

		while (pos[0].isspace ()) {
			pos = pos.offset (1);
			skipped = true;
		}

		return skipped;
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

	private static inline bool is_id_char (char c) {
		return c.isalnum () || c == '_' || c == '-';
	}

	internal static bool is_xml (string source) {
		unowned string pos = source;

		skip_optional_spaces (ref pos);

		if (pos[0] == '<') {
			// Comment:
			if (pos.has_prefix ("<!--")) {
				return true;
			}

			// CDATA:
			if (pos.has_prefix ("<![CDATA[")) {
				return true;
			}


			// Start Tag:
			bool proc_instr = false;
			pos = pos.offset (1);

			if (pos[0] == '?') {
				pos = pos.offset (1);
				proc_instr = true;
			}

			// ID:
			if (skip_id (ref pos) == false) {
				return false;
			}

			skip_optional_spaces (ref pos);

			while (skip_id (ref pos)) {
				if (pos[0] == '=') {
					pos = pos.offset (1);
				} else {
					return false;
				}

				skip_optional_spaces (ref pos);

				if (pos[0] == '"') {
					pos = pos.offset (1);
				} else {
					return false;
				}

				while (pos[0] != '\0' && pos[0] != '\n' && pos[0] != '"') {
					pos = pos.offset (1);
				}

				if (pos[0] == '"') {
					pos = pos.offset (1);
				} else {
					return false;
				}

				skip_optional_spaces (ref pos);
			}

			if (proc_instr && pos[0] == '?' && pos[1] == '>') {
				return true;
			}

			if (!proc_instr && (pos[0] == '>' || (pos[0] == '/' && pos[1] == '>'))) {
				return true;
			}

			return false;
		} else {
			return false;
		}
	}
}

