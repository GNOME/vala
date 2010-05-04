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

public class Gtkdoc.GComment {
	public string symbol;
	public string[] symbol_annotations;
	public Gee.List<Header> headers = new Gee.LinkedList<Header> ();
	public string brief_comment;
	public string long_comment;
	public string returns;
	public string[] returns_annotations;
	public Gee.List<Header> versioning = new Gee.LinkedList<Header> ();

	public string to_string () {
		var builder = new StringBuilder ();

		builder.append_printf ("/**\n * %s", symbol);
		if (symbol_annotations != null && symbol_annotations.length > 0) {
			builder.append_c (':');
			foreach (var annotation in symbol_annotations) {
				builder.append_printf (" (%s)", annotation);
			}
		}

		foreach (var header in headers) {
			builder.append_printf ("\n * %s:", header.name);
			if (header.annotations != null && header.annotations.length > 0) {
				foreach (var annotation in header.annotations) {
					builder.append_printf (" (%s)", annotation);
				}
				builder.append_c (':');
			}
			
			if (header.value != null) {
				builder.append_c (' ');
				builder.append (commentize (header.value));
			}
		}

		if (brief_comment != null) {
			builder.append_printf  ("\n * \n * %s", commentize (brief_comment));
		}
		if (long_comment != null) {
			builder.append_printf  ("\n * \n * %s", commentize (long_comment));
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

	public string to_docbook () {
		/*
		 * FIXME: this is not how it should be.
		 * The real solution is to create a comment like gtkdoc-mkdb does.
		 * This implies replacing the work of gtkdoc-mkdb and have a more accurate management of headers,
		 * (i.e. differentiate between parameters, short_description, see_also, etc.).
		 *
		 * For now we'll assume all headers are parameters.
		 * This is enough for a manually generated xml file only for D-Bus API.
		 *
		 * In other words, we are converting C/gtkdoc comment to a docbook comment.
		 */

		string? deprecated = null;
		string? since = null;
		foreach (var header in versioning) {
			if (header.name == "Deprecated") {
				deprecated = header.value;
			} else if (header.name == "Since") {
				since = header.value;
			} else {
				warning ("GtkDoc: Unknown versioning tag '%s'", header.name);
			}
		}

		var builder = new StringBuilder ();
		if (deprecated != null) {
			builder.append_printf ("""<warning><para><literal>%s</literal> is deprecated and should not be used in newly-written code. %s</para></warning>""", symbol, deprecated);
		}

		if (brief_comment != null) {
			builder.append_printf ("<para>%s</para>", brief_comment);
		}
		if (long_comment != null) {
			builder.append (long_comment);
		}

		if (headers.size > 0 || returns != null) {
			builder.append ("""<variablelist role="params">""");
			foreach (var header in headers) {
				builder.append_printf ("""<varlistentry><term><parameter>%s</parameter>&#160;:</term>
<listitem><simpara> %s </simpara></listitem></varlistentry>""",
									   header.name.offset (1), header.value);
			}
			if (returns != null) {
				builder.append_printf ("""<varlistentry><term><emphasis>Returns</emphasis>&#160;:</term>
<listitem><simpara> %s </simpara></listitem></varlistentry>""", returns);
			}
			builder.append ("</variablelist>");
		}

		if (since != null) {
			builder.append_printf ("""<para role="since">Since %s</para>""", since);
		}

		return builder.str;
	}
}

