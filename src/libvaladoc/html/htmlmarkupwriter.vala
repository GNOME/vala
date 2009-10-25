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

using GLib;
using Valadoc.Content;

public class Valadoc.Html.MarkupWriter : Valadoc.MarkupWriter {
	public MarkupWriter (FileStream stream) {
		base (stream);
	}

	// edit
	public MarkupWriter link (string url, string label, string? css_class = null) {
		if (css_class == null) {
			start_tag ("a", {"href", url});
		} else {
			start_tag ("a", {"href", url, "class", css_class});
		}
		text (label);
		end_tag ("a");
		return this;
	}

	public MarkupWriter image (string src, string? caption = null, string? css_class = null) {
		if (css_class == null) {
			simple_tag ("img", {"src", src, "alt", caption});
		} else {
			simple_tag ("img", {"src", src, "alt", caption, "class", css_class});
		}
		return this;
	}

	public MarkupWriter stylesheet_link (string url) {
		simple_tag ("link", {"href", url, "rel", "stylesheet", "type", "text/css"});
		return this;
	}

	private override bool inline_element (string name) {
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

	private override bool content_inline_element (string name) {
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
}

