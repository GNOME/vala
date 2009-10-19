/* markupwriter.vala
 *
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using GLib;
using Valadoc.Content;

public class Valadoc.Html.MarkupWriter {
	private unowned FileStream stream;
	private int indent;
	private long current_column = 0;
	private bool last_was_tag;

	private const int MAX_COLUMN = 150;

	public MarkupWriter (FileStream stream) {
		this.stream = stream;
		do_write ("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		indent = -1;
		last_was_tag = true;
	}

	public MarkupWriter start_tag (string name, string? css_class = null, string? id = null) {
		indent++;
		check_column (name);
		do_write ("<%s%s%s>".printf (
			name,
			css_class != null ? " class=\"%s\"".printf (css_class) : "",
			id != null ? " id=\"%s\"".printf (id) : ""));
		last_was_tag = true;
		return this;
	}

	public MarkupWriter start_tag_with_attrs (string name, string? css_class = null, string[] names, string[] values) {
		indent++;
		check_column (name);

		var content = "<%s%s".printf (
			name,
			css_class != null ? " class=\"%s\"".printf (css_class) : "");
		for (int i = 0; i < names.length; i++) {
			content += " %s=\"%s\"".printf (names[i], values[i]);
		}
		content += ">";

		do_write (content);
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

	public MarkupWriter simple_tag (string name, string? css_class = null) {
		indent++;
		check_column (name);
		do_write ("<%s%s/>".printf (
			name,
			css_class != null ? " class=\"%s\"".printf (css_class) : ""));
		indent--;
		last_was_tag = true;
		return this;
	}

	public MarkupWriter link (string css_class, string url, string label) {
		indent++;
		check_column ("a");
		do_write ("<a class=\"%s\" href=\"%s\">%s</a>".printf (
			css_class, url, label));
		indent--;
		last_was_tag = true;
		return this;
	}

	public MarkupWriter image (string css_class, string src, string? caption = null) {
		indent++;
		check_column ("img");
		do_write ("<img class=\"%s\" src=\"%s\"%s/>".printf (
			css_class, src,
			caption != null ? " alt=\"%s\"".printf (caption) : ""));
		indent--;
		last_was_tag = true;
		return this;
	}

	public MarkupWriter stylesheet_link (string url) {
		indent++;
		check_column ("link");
		do_write ("<link href=\"%s\" rel=\"stylesheet\" type=\"text/css\" />".printf (url));
		indent--;
		last_was_tag = true;
		return this;
	}

	public MarkupWriter text (string text) {
		if (text.length + current_column > MAX_COLUMN) {
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

	public void break_line () {
		current_column = 0;
		do_write ("\n%s".printf (get_indent_string ()));
	}

	public void do_write (string text) {
		stream.printf (text);
		current_column += text.length;
	}

	private void check_column (string name, bool end_tag = false) {
		if (!end_tag && inline (name) && !last_was_tag) {
			return;
		} else if (end_tag && content_inline (name)) {
			return;
		}
		break_line ();
	}

	private bool inline (string name) {
		return name != "html"
			&& name != "head"
			&& name != "title"
			&& name != "link"
			&& name != "body"
			&& name != "div"
			&& name != "p"
			&& name != "table"
			&& name != "tr"
			&& name != "td"
			&& name != "ul"
			&& name != "ol"
			&& name != "li"
			&& name != "h1"
			&& name != "h2"
			&& name != "h3"
			&& name != "h4"
			&& name != "h5"
			&& name != "hr"
			&& name != "img";
	}

	private bool content_inline (string name) {
		return name == "title"
			|| name == "p"
			|| name == "a"
			|| name == "h1"
			|| name == "h2"
			|| name == "h3"
			|| name == "h4"
			|| name == "h5"
			|| name == "span"
			|| name == "code"
			|| name == "b"
			|| name == "i"
			|| name == "u"
			|| name == "stoke";
	}

	private string get_indent_string () {
		return current_column == 0 ? string.nfill (indent * 2, ' ') : "";
	}		
}

