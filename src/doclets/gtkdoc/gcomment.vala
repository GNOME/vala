/* gcomment.vala
*
* Copyright (C) 2010 Luca Bruno
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
* 	Luca Bruno <lethalman88@gmail.com>
*/

public class Gtkdoc.Header {
	public string name;
	public string[]? annotations;
	public string? value;

	public Header (string name, string? value = null) {
		this.name = name;
		this.value = value;
	}
}


public class Gtkdoc.GComment {
	public string symbol;
	public string[] symbol_annotations;
	public Gee.List<Header> headers = new Gee.LinkedList<Header>();
	public string body;
	public string returns;
	public string[] returns_annotations;
	public Gee.List<Header> versioning = new Gee.LinkedList<Header>();

	public string to_string () {
		var builder = new StringBuilder ();

		builder.append_printf ("/**\n * %s", symbol);
		if (symbol_annotations != null) {
			if (symbol_annotations.length > 0) {
				builder.append_c (':');
			}

			foreach (var annotation in symbol_annotations) {
				builder.append_printf (" (%s)", annotation);
			}
		}

		foreach (var header in headers) {
			builder.append_printf ("\n * %s:", header.name);
			if (header.annotations != null) {
				foreach (var annotation in header.annotations) {
					builder.append_printf (" (%s)", annotation);
				}

				if (header.annotations.length > 0) {
					builder.append_c (':');
				}
			}

			if (header.value != null) {
				builder.append_c (' ');
				builder.append (commentize (header.value));
			}
		}

		if (body != null) {
			builder.append ("\n * \n * ");
			builder.append (commentize (body));
		}

		if (returns != null || returns_annotations.length > 0) {
			builder.append ("\n * \n * Returns:");
			if (returns_annotations != null) {
				foreach (var annotation in returns_annotations) {
					builder.append_printf (" (%s)", annotation);
				}

				if (returns_annotations.length > 0) {
					builder.append_c (':');
				}
			}
			builder.append_c (' ');

			if (returns != null) {
				builder.append (commentize (returns));
			}
		}

		if (versioning.size > 0) {
			builder.append ("\n *");
			foreach (var version in versioning) {
				builder.append_printf ("\n * %s:", version.name);
				if (version.value != null) {
					builder.append_printf (" %s", commentize (version.value));
				}
			}
		}
		builder.append ("\n */");
		return builder.str;
	}
}

