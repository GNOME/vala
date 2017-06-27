/* gtkdocmarkupwriter.vala
 *
 * Copyright (C) 2012  Florian Brosch
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



public class Valadoc.GtkDocMarkupWriter : Valadoc.MarkupWriter {
	private unowned StringBuilder builder;

	public void reset () {
		last_was_tag = true;
		current_column = 0;
		builder.erase ();
		indent = -1;
	}

	public unowned string content {
		get { return builder.str; }
	}

	public GtkDocMarkupWriter () {
		StringBuilder builder = new StringBuilder ();
		base ((str) => { builder.append (str); }, false);
		this.builder = builder;
	}

	protected override bool inline_element (string name) {
		return name != "para"
			&& name != "programlisting"
			&& name != "table"
			&& name != "example"
			&& name != "figure"
			&& name != "tr"
			&& name != "td"
			&& name != "mediaobject"
			&& name != "imageobject"
			&& name != "textobject"
			&& name != "listitem"
			&& name != "orderedlist"
			&& name != "itemizedlist"
			&& name != "title";
	}

	protected override bool content_inline_element (string name) {
		return name == "para"
			|| name == "programlisting"
			|| name == "emphasis"
			|| name == "blockquote"
			|| name == "ulink"
			|| name == "listitem"
			|| name == "title";
	}
}


