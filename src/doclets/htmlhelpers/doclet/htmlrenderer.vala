/* contentvisitor.vala
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

public class Valadoc.Html.HtmlRenderer : ContentRenderer {

	private BasicDoclet _doclet;
	private Documentation? _container;
	private unowned FileStream _stream;

	public HtmlRenderer (BasicDoclet doclet) {
		_doclet = doclet;
	}

	public void set_container (Documentation? container) {
		_container = container;
	}

	public void set_filestream (FileStream stream) {
		_stream = stream;
	}

	public override void render (ContentElement element) {
		element.accept (this);
	}

	public override void render_children (ContentElement element) {
		element.accept_children (this);
	}

	private string get_url (Api.Node symbol) {
		return get_html_link (_doclet.settings, symbol, _container);
	}

	private void write_symbol_link (Api.Node symbol, string label) {
		var url = get_url (symbol);
		_stream.printf ("<a href=\"%s\">%s</a>",
		                url,
		                (label == null || label == "") ? symbol.full_name () : label);
	}

	private delegate void TagletWrite (Taglet taglet);

	private void write_taglets (string header, string footer, string separator,
	                            Gee.List<Taglet> taglets, TagletWrite write) {
		if (taglets.size > 0) {
			_stream.printf (header);
			bool first = true;
			foreach (var taglet in taglets) {
				if (!first) {
					_stream.printf (separator);
				}
				write (taglet);
				first = false;
			}
			_stream.printf (footer);
		}
	}

	public override void visit_comment (Comment element) {
		Gee.List<Taglet> taglets;

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Deprecated));
		write_taglets (
			"<p class=\"main_title\"><b>Deprecated:</b> ",
			"</p>",
			"",
			taglets,
			(taglet) => {
				var deprecated = taglet as Taglets.Deprecated;
				deprecated.accept_children (this);
			});

		// Write description
		element.accept_children (this);

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Param));
		write_taglets (
			"<h2 class=\"main_title\">Parameters:</h2>\n<table class=\"main_parameter_table\">",
			"</table>",
			"",
			taglets,
			(taglet) => {
				var param = taglet as Taglets.Param;
				_stream.printf ("<tr><td class=\"main_parameter_table_name\">%s</td><td>", param.parameter_name);
				param.accept_children (this);
				_stream.printf ("</td></tr>");
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Return));
		write_taglets (
			"<h2 class=\"main_title\">Returns:</h2>\n<table class=\"main_parameter_table\">",
			"</table>",
			"",
			taglets,
			(taglet) => {
				var param = taglet as Taglets.Return;
				_stream.printf ("<tr><td>");
				param.accept_children (this);
				_stream.printf ("</td></tr>");
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Throws));
		write_taglets (
			"<h2 class=\"main_title\">Throws:</h2>\n<table class=\"main_parameter_table\">",
			"</table>",
			"",
			taglets,
			(taglet) => {
				var exception = taglet as Taglets.Throws;
				_stream.printf ("<tr><td class=\"main_parameter_table_name\">%s</td><td>", exception.error_domain_name);
				exception.accept_children (this);
				_stream.printf ("</td></tr>");
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Since));
		write_taglets (
			"<h2 class=\"main_title\">Since:</h2>\n<p>",
			"</p>",
			", ",
			taglets,
			(taglet) => {
				var since = taglet as Taglets.Since;
				_stream.printf ("%s", since.version);
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.See));
		write_taglets (
			"<h2 class=\"main_title\">See also:</h2>\n<p>",
			"</p>",
			", ",
			taglets,
			(taglet) => {
				var see = taglet as Taglets.See;
				write_symbol_link (see.symbol, see.symbol_name);
			});
	}

	public override void visit_embedded (Embedded element) {
		var caption = element.caption;
		if (caption == null) {
			_stream.printf ("<img src=\"%s\" alt=\"%s\" />", element.url);
		} else {
			_stream.printf ("<img src=\"%s\" alt=\"%s\" />", element.url, caption);
		}
	}

	public override void visit_headline (Headline element) {
		_stream.printf ("<h%d>", element.level);
		element.accept_children (this);
		_stream.printf ("</h%d>", element.level);
	}

	public override void visit_link (Link element) {
		var label = element.label;
		_stream.printf ("<a href=\"%s\">%s</a>",
		                element.url,
		                (label == null || label == "") ? element.url : label);
	}

	public override void visit_symbol_link (SymbolLink element) {
		if (element.symbol == _container
		    || !element.symbol.is_visitor_accessible (_doclet.settings)
		    || !element.symbol.package.is_visitor_accessible (_doclet.settings)) {
			_stream.printf (element.label);
		} else {
			write_symbol_link (element.symbol, element.label);
		}
	}

	public override void visit_list (Content.List element) {
	}

	public override void visit_list_item (ListItem element) {
	}

	public override void visit_page (Page element) {
		element.accept_children (this);
	}

	public override void visit_paragraph (Paragraph element) {
		_stream.printf ("<p>");
		element.accept_children (this);
		_stream.printf ("</p>");
	}

	public override void visit_run (Run element) {
		string tag = null;
		string css_type = null;
		switch (element.style) {
		case Run.Style.BOLD:
			tag = "b";
			break;
		case Run.Style.ITALIC:
			tag = "i";
			break;
		case Run.Style.UNDERLINED:
			tag = "u";
			break;
		case Run.Style.MONOSPACED:
			tag = "code";
			break;
		case Run.Style.STROKE:
			tag = "stroke";
			break;
		case Run.Style.LANG_KEYWORD:
			tag = "span";
			css_type = "main_keyword";
			break;
		case Run.Style.LANG_LITERAL:
			tag = "span";
			css_type = "main_optional_parameter";
			break;
		case Run.Style.LANG_TYPE:
			tag = "span";
			css_type = "main_basic_type";
			break;
		}
		if (tag != null) {
			_stream.printf ("<%s%s>", tag, css_type != null ? " class=\"" + css_type + "\"" : "");
		}
		element.accept_children (this);
		if (tag != null) {
			_stream.printf ("</%s>", tag);
		}
	}

	public override void visit_source_code (SourceCode element) {
		_stream.printf ("<pre>");
		_stream.printf (element.code);
		_stream.printf ("</pre>");
	}

	public override void visit_table (Table element) {
		_stream.printf ("<table class=\"main_table\">");
		element.accept_children (this);
		_stream.printf ("</table>");
	}

	public override void visit_table_cell (TableCell element) {
		_stream.printf ("<td class=\"main_table\"%s%s>",
			element.colspan != 1 ? " colspan=\"%d\"".printf (element.colspan) : "",
			element.rowspan != 1 ? " rowspan=\"%d\"".printf (element.rowspan) : ""
		);
		element.accept_children (this);
		_stream.printf ("</td>");
	}

	public override void visit_table_row (TableRow element) {
		_stream.printf ("<tr>");
		element.accept_children (this);
		_stream.printf ("</tr>");
	}

	public override void visit_taglet (Taglet element) {
	}

	public override void visit_text (Text element) {
		write_string (element.content);
	}

	private void write_string (string content) {
		unichar chr = content[0];
		long lpos = 0;
		int i = 0;

		for (i = 0; chr != '\0' ; i++, chr = content[i]) {
			switch (chr) {
			case '\n':
				_stream.puts (content.substring (lpos, i-lpos));
				_stream.puts ("<br />");
				lpos = i+1;
				break;
			case '<':
				_stream.puts (content.substring (lpos, i-lpos));
				_stream.puts ("&lt;");
				lpos = i+1;
				break;
			case '>':
				_stream.puts (content.substring (lpos, i-lpos));
				_stream.puts ("&gt;");
				lpos = i+1;
				break;
			case '&':
				_stream.puts (content.substring (lpos, i-lpos));
				_stream.puts ("&amp;");
				lpos = i+1;
				break;
			}
		}
		_stream.puts (content.substring (lpos, i-lpos));
	}
}
