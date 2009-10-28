/* markupwriter.vala
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



public class Valadoc.MarkupWriter {
	private unowned FileStream stream;
	protected int indent;
	private long current_column = 0;
	private bool last_was_tag;
	private bool wrap = true;

	private const int MAX_COLUMN = 150;

	public MarkupWriter (FileStream stream, bool xml_declaration = true) {
		this.stream = stream;
		if (xml_declaration) {
			do_write ("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		}
		indent = -1;
		last_was_tag = true;
	}

	//TODO: rename to start_tagv, create a start_tag (string name, string[] ...)
	public MarkupWriter start_tag (string name, string[]? attributes=null) {
		indent++;
		check_column (name);

		if (attributes.length % 2 != 0) {
			attributes.resize (attributes.length+1);
			attributes[attributes.length-1] = "";
		}

		var content = new StringBuilder ("<");
		content.append (name);
		for (int i = 0; i < attributes.length; i=i+2) {
			if (attributes[i+1] != null) {
				content.append_printf (" %s=\"%s\"", attributes[i], attributes[i+1]);
			}
		}
		content.append (">");

		do_write (content.str);
		last_was_tag = true;
		return this;
	}

	public MarkupWriter simple_tag (string name, string[]? attributes=null) {
		indent++;
		check_column (name);

		if (attributes.length % 2 != 0) {
			attributes.resize (attributes.length+1);
			attributes[attributes.length-1] = "";
		}

		var content = new StringBuilder ("<");
		content.append (name);
		for (int i = 0; i < attributes.length; i=i+2) {
			if (attributes[i+1] != null) {
				content.append_printf (" %s=\"%s\"", attributes[i], attributes[i+1]);
			}
		}
		content.append ("/>");

		do_write (content.str);
		indent--;
		last_was_tag = true;
		return this;
	}


	public MarkupWriter end_tag (string name) {
		check_column (name, true);
		do_write ("</%s>".printf (name));
		indent--;
		last_was_tag = true;
		return this;
	}

	public MarkupWriter text (string text) {
		if (wrap && text.length + current_column > MAX_COLUMN) {
			long wrote = 0;
			while (wrote < text.length) {
				long space_pos = -1;
				for (long i = wrote + 1; i < text.length; i++) {
					if (text[i] == ' ') {
						if (i - wrote + current_column > MAX_COLUMN) {
							break;
						}
						space_pos = i;
					}
				}
				if (text.length - wrote + current_column <= MAX_COLUMN) {
					do_write (text.substring (wrote));
					wrote = text.length + 1;
				} else if (space_pos == -1) {
					// Force line break
				} else {
					do_write (text.substring (wrote, space_pos - wrote));
					wrote = space_pos + 1;
				}
				if (wrote < text.length) {
					break_line ();
					do_write ("  ");
				}
			}
		} else {
			do_write (text);
		}
		last_was_tag = false;
		return this;
	}

	public MarkupWriter raw_text (string text) {
		do_write (text);
		last_was_tag = false;
		return this;
	}

	public void set_wrap (bool wrap) {
		this.wrap = wrap;
	}

	private void break_line () {
		stream.printf ("\n");
		stream.printf (string.nfill (indent * 2, ' '));
		current_column = indent * 2;
	}

	protected void do_write (string text) {
		if (wrap && current_column + text.length > MAX_COLUMN) {
			break_line ();
		}
		stream.printf (text);
		current_column += text.length;
	}

	private void check_column (string name, bool end_tag = false) {
		if (!wrap) {
			return;
		} else if (!end_tag && inline_element (name) && !last_was_tag) {
			return;
		} else if (end_tag && content_inline_element (name)) {
			return;
		}
		break_line ();
	}

	protected virtual bool inline_element (string name) {
		return false;
	}

	protected virtual bool content_inline_element (string name) {
		return true;
	}
}


