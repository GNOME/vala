/* markupwriter.vala
 *
 * Copyright (C) 2008-2014 Florian Brosch, Didier Villevalois
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

	public MarkupWriter (FileStream stream, bool xml_declaration = true) {
		// avoid broken implicit copy
		unowned FileStream _stream = stream;

		base ((str) => {
			_stream.printf (str);
		}, xml_declaration);
	}

	public MarkupWriter.builder (StringBuilder builder, bool xml_declaration = true) {
		// avoid broken implicit copy
		unowned StringBuilder _builder = builder;

		base ((str) => {
			_builder.append (str);
		}, xml_declaration);
	}

	public unowned MarkupWriter add_usemap (Charts.Chart chart) {
		string? buf = (string?) chart.write_buffer ("cmapx");
		if (buf != null) {
			raw_text ("\n");
			raw_text ((!) buf);
		}

		return this;
	}

	// edit
	public unowned MarkupWriter link (string url, string label, string? css_class = null, string? rel = null) {
		string[] attributes = {"href", url};
		if (css_class != null) {
			attributes += "class";
			attributes += css_class;
		}
		if (rel != null) {
			attributes += "rel";
			attributes += rel;
		}
		start_tag ("a", attributes);

		text (label);
		end_tag ("a");
		return this;
	}

	public unowned MarkupWriter image (string src, string? caption = null, string? css_class = null) {
		if (css_class == null) {
			simple_tag ("img", {"src", src, "alt", caption});
		} else {
			simple_tag ("img", {"src", src, "alt", caption, "class", css_class});
		}
		return this;
	}

	public unowned MarkupWriter stylesheet_link (string url) {
		simple_tag ("link", {"href", url, "rel", "stylesheet", "type", "text/css"});
		return this;
	}

	public unowned MarkupWriter javascript_link (string url) {
		start_tag ("script", {"src", url, "type", "text/javascript"});
		end_tag ("script");
		return this;
	}

	protected override bool inline_element (string name) {
		return name != "html"
			&& name != "head"
			&& name != "title"
			&& name != "meta"
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

	protected override bool content_inline_element (string name) {
		return name == "title"
			|| name == "meta"
			|| name == "p"
			|| name == "a"
			|| name == "h1"
			|| name == "h2"
			|| name == "h3"
			|| name == "h4"
			|| name == "h5"
			|| name == "li"
			|| name == "span"
			|| name == "code"
			|| name == "b"
			|| name == "i"
			|| name == "u"
			|| name == "stoke";
	}
}

