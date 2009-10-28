/* htmlrenderer.vala
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

public class Valadoc.Html.HtmlRenderer : ContentRenderer {

	private BasicDoclet _doclet;
	private Documentation? _container;
	private unowned MarkupWriter writer;

	public HtmlRenderer (BasicDoclet doclet) {
		_doclet = doclet;
	}

	public void set_container (Documentation? container) {
		_container = container;
	}

	public void set_writer (MarkupWriter writer) {
		this.writer = writer;
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
		writer.link (url,
		             (label == null || label == "") ? symbol.full_name () : label,
		             get_html_css_class (symbol));
	}

	private delegate void Write ();
	private delegate void TagletWrite (Taglet taglet);

	private void write_taglets (Write header, Write footer, Write separator,
	                            Gee.List<Taglet> taglets, TagletWrite write) {
		if (taglets.size > 0) {
			header ();
			bool first = true;
			foreach (var taglet in taglets) {
				if (!first) {
					separator ();
				}
				write (taglet);
				first = false;
			}
			footer ();
		}
	}

	public override void visit_comment (Comment element) {
		Gee.List<Taglet> taglets;

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Deprecated));
		write_taglets (
			() => {
				writer.start_tag ("p", {"class", "main_title"});
				writer.start_tag ("b").text ("Deprecated:").end_tag ("b");
			},
			() => {
				writer.end_tag ("p");
			},
			() => {},
			taglets,
			(taglet) => {
				var deprecated = taglet as Taglets.Deprecated;
				deprecated.accept_children (this);
			});

		// Write description
		element.accept_children (this);

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Param));
		write_taglets (
			() => {
				writer.start_tag ("h2", {"class", "main_title"}).text ("Parameters:").end_tag ("h2");
				writer.start_tag ("table", {"class", "main_parameter_table"});
			},
			() => {
				writer.end_tag ("table");
			},
			() => {},
			taglets,
			(taglet) => {
				var param = taglet as Taglets.Param;
				writer.start_tag ("tr");
				writer.start_tag ("td", {"class", "main_parameter_table_name"}).text (param.parameter_name).end_tag ("td");
				writer.start_tag ("td");
				param.accept_children (this);
				writer.end_tag ("td");
				writer.end_tag ("tr");
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Return));
		write_taglets (
			() => {
				writer.start_tag ("h2", {"class", "main_title"}).text ("Returns:").end_tag ("h2");
				writer.start_tag ("table", {"class", "main_parameter_table"});
			},
			() => {
				writer.end_tag ("table");
			},
			() => {},
			taglets,
			(taglet) => {
				var param = taglet as Taglets.Return;
				writer.start_tag ("tr");
				writer.start_tag ("td");
				param.accept_children (this);
				writer.end_tag ("td");
				writer.end_tag ("tr");
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Throws));
		write_taglets (
			() => {
				writer.start_tag ("h2", {"class", "main_title"}).text ("Returns:").end_tag ("h2");
				writer.start_tag ("table", {"class", "main_parameter_table"});
			},
			() => {
				writer.end_tag ("table");
			},
			() => {},
			taglets,
			(taglet) => {
				var exception = taglet as Taglets.Throws;
				writer.start_tag ("tr");
				writer.start_tag ("td", {"class", "main_parameter_table_name"}).text (exception.error_domain_name).end_tag ("td");
				writer.start_tag ("td");
				exception.accept_children (this);
				writer.end_tag ("td");
				writer.end_tag ("tr");
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Since));
		write_taglets (
			() => {
				writer.start_tag ("h2", {"class", "main_title"}).text ("Since:").end_tag ("h2");
				writer.start_tag ("p");
			},
			() => {
				writer.end_tag ("p");
			},
			() => {},
			taglets,
			(taglet) => {
				var since = taglet as Taglets.Since;
				writer.text (since.version);
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.See));
		write_taglets (
			() => {
				writer.start_tag ("h2", {"class", "main_title"}).text ("See also:").end_tag ("h2");
				writer.start_tag ("p");
			},
			() => {
				writer.end_tag ("p");
			},
			() => {
				writer.text (", ");
			},
			taglets,
			(taglet) => {
				var see = taglet as Taglets.See;
				write_symbol_link (see.symbol, see.symbol_name);
			});
	}

	public override void visit_embedded (Embedded element) {
		var caption = element.caption;
		writer.image (element.url, (caption == null || caption == "") ? "" : caption);
	}

	public override void visit_headline (Headline element) {
		writer.start_tag ("h%d".printf (element.level));
		element.accept_children (this);
		writer.end_tag ("h%d".printf (element.level));
	}

	public override void visit_link (Link element) {
		var label = element.label;
		writer.link (element.url, (label == null || label == "") ? element.url : label);
	}

	public override void visit_symbol_link (SymbolLink element) {
		if (element.symbol == _container
		    || !element.symbol.is_visitor_accessible (_doclet.settings)
		    || !element.symbol.package.is_visitor_accessible (_doclet.settings)) {
			writer.text (element.label);
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
		writer.start_tag ("p");
		element.accept_children (this);
		writer.end_tag ("p");
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
		case Run.Style.LANG_BASIC_TYPE:
			tag = "span";
			css_type = "main_basic_type";
			break;
		case Run.Style.LANG_TYPE:
			tag = "span";
			css_type = "main_type";
			break;
		}
		if (tag != null) {
			writer.start_tag (tag, {"class", css_type});
		}
		element.accept_children (this);
		if (tag != null) {
			writer.end_tag (tag);
		}
	}

	public override void visit_source_code (SourceCode element) {
		writer.start_tag ("pre");
		writer.raw_text (element.code);
		writer.end_tag ("pre");
	}

	public override void visit_table (Table element) {
		writer.start_tag ("table", {"class", "main_table"});
		element.accept_children (this);
		writer.end_tag ("table");
	}

	public override void visit_table_cell (TableCell element) {
		writer.start_tag ("td", {"class", "main_table",
								 "colspan", element.colspan.to_string (),
								 "rowspan", element.rowspan.to_string ()});
		element.accept_children (this);
		writer.end_tag ("td");
	}

	public override void visit_table_row (TableRow element) {
		writer.start_tag ("tr");
		element.accept_children (this);
		writer.end_tag ("tr");
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
				writer.text (content.substring (lpos, i-lpos));
				writer.simple_tag ("br");
				lpos = i+1;
				break;
			case '<':
				writer.text (content.substring (lpos, i-lpos));
				writer.text ("&lt;");
				lpos = i+1;
				break;
			case '>':
				writer.text (content.substring (lpos, i-lpos));
				writer.text ("&gt;");
				lpos = i+1;
				break;
			case '&':
				writer.text (content.substring (lpos, i-lpos));
				writer.text ("&amp;");
				lpos = i+1;
				break;
			}
		}
		writer.text (content.substring (lpos, i-lpos));
	}
}

