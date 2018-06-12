/* devhelp-markupwriter.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch
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


public class Valadoc.Devhelp.MarkupWriter : Valadoc.MarkupWriter {

	public MarkupWriter (FileStream stream, bool xml_declaration = true) {
		// avoid broken implicit copy
		unowned FileStream _stream = stream;

		base ((str) => { _stream.printf (str); }, xml_declaration);
	}

	protected override bool inline_element (string name) {
		return name != "book";
	}

	protected override bool content_inline_element (string name) {
		return name == "keyword"
			|| name == "sub";
	}

	public unowned MarkupWriter start_book (string title, string lang, string link, string name, string version, string author) {
		this.start_tag ("book", {"xmlns", "http://www.devhelp.net/book",
								 "title", title,
								 "language", lang,
								 "name", name,
								 "version", version,
								 "author", author,
								 "link", link});
		return this;
	}

	public unowned MarkupWriter end_book () {
		this.end_tag ("book");
		return this;
	}

	public unowned MarkupWriter start_functions () {
		this.start_tag ("functions");
		return this;
	}

	public unowned MarkupWriter end_functions () {
		this.end_tag ("functions");
		return this;
	}

	public unowned MarkupWriter start_chapters () {
		this.start_tag ("chapters");
		return this;
	}

	public unowned MarkupWriter end_chapters () {
		this.end_tag ("chapters");
		return this;
	}

	public unowned MarkupWriter start_sub (string name, string link) {
		this.start_tag ("sub", {"name", name, "link", link});
		return this;
	}

	public unowned MarkupWriter end_sub () {
		this.end_tag ("sub");
		return this;
	}

	public unowned MarkupWriter keyword (string name, string type, string link) {
		this.start_tag ("keyword", {"type", type, "name", name, "link", link});
		this.end_tag ("keyword");
		return this;
	}
}

