/* htmlrenderer.vala
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

public class Valadoc.Html.HtmlRenderer : ContentRenderer {

	protected Documentation? _container;
	protected Documentation? _owner;
	protected unowned MarkupWriter writer;
	protected Html.CssClassResolver cssresolver;
	protected LinkHelper linker;
	protected Settings settings;

	public HtmlRenderer (Settings settings, LinkHelper linker, CssClassResolver cssresolver) {
		this.cssresolver = cssresolver;
		this.settings = settings;
		this.linker = linker;
	}

	public void set_container (Documentation? container) {
		_container = container;
	}

	public void set_owner (Documentation? owner) {
		_owner = owner;
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

	private string get_url (Documentation symbol) {
		return linker.get_relative_link (_container, symbol, settings);
	}

	private void write_unresolved_symbol_link (string given_symbol_name, InlineContent? label_owner = null) {
		if (label_owner == null || label_owner.content.size == 0) {
			writer.start_tag ("code");
			writer.text (given_symbol_name);
			writer.end_tag ("code");
		} else {
			writer.start_tag ("i");
			label_owner.accept_children (this);
			writer.end_tag ("i");
		}
	}

	private void write_resolved_symbol_link (Api.Node symbol, string? given_symbol_name, InlineContent? label_owner = null) {
		var symbol_name = (given_symbol_name == null || given_symbol_name == "") ? symbol.get_full_name () : given_symbol_name;
		string href = (symbol == _container || symbol == _owner)? null : get_url (symbol);
		string css_class = cssresolver.resolve (symbol);
		string end_tag_name;


		// Start Tag:
		if (href != null) {
			writer.start_tag ("a", {"href", href, "class", css_class});
			end_tag_name = "a";
		} else {
			writer.start_tag ("span", {"class", css_class});
			end_tag_name = "span";
		}


		// Content:
		if (label_owner != null && label_owner.content.size > 0) {
			label_owner.accept_children (this);
		} else {
			writer.text (symbol_name);
		}


		// End Tag:
		writer.end_tag (end_tag_name);
	}

	private delegate void Write ();
	private delegate void TagletWrite (Taglet taglet);

	private void write_taglets (Write header, Write footer, Write separator,
	                            Vala.List<Taglet> taglets, TagletWrite write) {
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
		Vala.List<Taglet> taglets;

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Deprecated));
		write_taglets (
			() => {
				writer.start_tag ("p", {"class", "main_title"});
				writer.start_tag ("b")
					.text ("Deprecated: ")
					.end_tag ("b");
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
		taglets.sort ((_a, _b) => {
			Taglets.Param a = _a as Taglets.Param;
			Taglets.Param b = _b as Taglets.Param;

			if (a.position < 0 && b.position < 0) {
				int cmp = a.parameter_name.ascii_casecmp (b.parameter_name);
				if (cmp == 0) {
					return 0;
				}

				if (a.parameter_name == "...") {
					return 1;
				}

				if (b.parameter_name == "...") {
					return -1;
				}

				return cmp;
			}

			if (a.position < 0) {
				return 1;
			}

			if (b.position < 0) {
				return -1;
			}

			return a.position - b.position;
		});

		write_taglets (
			() => {
				writer.start_tag ("h2", {"class", "main_title"})
					.text ("Parameters:")
					.end_tag ("h2");
				writer.start_tag ("table", {"class", "main_parameter_table"});
			},
			() => {
				writer.end_tag ("table");
			},
			() => {},
			taglets,
			(taglet) => {
				var param = taglet as Taglets.Param;
				string[]? unknown_parameter_css = null;
				if (param.parameter == null && !param.is_this) {
					unknown_parameter_css = {"class", "main_parameter_table_unknown_parameter"};
				}

				writer.start_tag ("tr", unknown_parameter_css);
				writer.start_tag ("td", {"class", "main_parameter_table_name"})
					.text (param.parameter_name)
					.end_tag ("td");
				writer.start_tag ("td");
				param.accept_children (this);
				writer.end_tag ("td");
				writer.end_tag ("tr");
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Return));
		write_taglets (
			() => {
				writer.start_tag ("h2", {"class", "main_title"})
					.text ("Returns:")
					.end_tag ("h2");
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
				writer.start_tag ("h2", {"class", "main_title"})
					.text ("Exceptions:")
					.end_tag ("h2");
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
				writer.start_tag ("td", {"class", "main_parameter_table_name"})
					.text (exception.error_domain_name)
					.end_tag ("td");
				writer.start_tag ("td");
				exception.accept_children (this);
				writer.end_tag ("td");
				writer.end_tag ("tr");
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Since));
		write_taglets (
			() => {
				writer.start_tag ("h2", {"class", "main_title"})
					.text ("Since:")
					.end_tag ("h2");
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
				writer.start_tag ("h2", {"class", "main_title"})
					.text ("See also:")
					.end_tag ("h2");
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
				if (see.symbol == null) {
					write_unresolved_symbol_link (see.symbol_name);
				} else {
					write_resolved_symbol_link (see.symbol, see.symbol_name);
				}
			});
	}

	public override void visit_embedded (Embedded element) {
		var caption = element.caption;

		var absolute_path = Path.build_filename (settings.path, element.package.name, "img",
												 Path.get_basename (element.url));
		var relative_path = Path.build_filename ("img", Path.get_basename (element.url));

		copy_file (element.url, absolute_path);

		writer.image (relative_path, (caption == null || caption == "") ? "" : caption);
	}

	public override void visit_headline (Headline element) {
		writer.start_tag ("h%d".printf (element.level));
		element.accept_children (this);
		writer.end_tag ("h%d".printf (element.level));
	}

	public override void visit_wiki_link (WikiLink element) {
		if (element.page != null) {
			writer.start_tag ("a", {"href", get_url (element.page)});
		}

		if (element.content.size > 0) {
			element.accept_children (this);
		} else {
			writer.text (element.name.substring (0, element.name.last_index_of_char ('.')));
		}

		if (element.page != null) {
			writer.end_tag ("a");
		}
	}

	public override void visit_link (Link element) {
		if (Uri.parse_scheme (element.url) != null) {
			writer.start_tag ("a", {"href", element.url, "target", "_blank"});
		} else {
			writer.start_tag ("a", {"href", element.url});
		}

		if (element.content.size > 0) {
			element.accept_children (this);
		} else {
			writer.text (element.url);
		}

		writer.end_tag ("a");
	}

	public override void visit_symbol_link (SymbolLink element) {
		if (element.symbol == null) {
			write_unresolved_symbol_link (element.given_symbol_name, element);
		} else {
			write_resolved_symbol_link (element.symbol, element.given_symbol_name, element);
		}
	}

	public override void visit_list (Content.List element) {
		string list_type = null;
		string bullet_type = null;
		string css_class = null;
		switch (element.bullet) {
		case Content.List.Bullet.NONE:
			list_type = "ul";
			css_class = "no_bullet";
			break;
		case Content.List.Bullet.UNORDERED:
			list_type = "ul";
			break;
		case Content.List.Bullet.ORDERED:
			list_type = "ol";
			break;
		case Content.List.Bullet.ORDERED_NUMBER:
			list_type = "ol";
			bullet_type = "1";
			break;
		case Content.List.Bullet.ORDERED_LOWER_CASE_ALPHA:
			list_type = "ol";
			bullet_type = "a";
			break;
		case Content.List.Bullet.ORDERED_UPPER_CASE_ALPHA:
			list_type = "ol";
			bullet_type = "A";
			break;
		case Content.List.Bullet.ORDERED_LOWER_CASE_ROMAN:
			list_type = "ol";
			bullet_type = "i";
			break;
		case Content.List.Bullet.ORDERED_UPPER_CASE_ROMAN:
			list_type = "ol";
			bullet_type = "I";
			break;
		}
		writer.start_tag (list_type, {"class", css_class, "type", bullet_type});
		element.accept_children (this);
		writer.end_tag (list_type);
	}

	public override void visit_list_item (ListItem element) {
		writer.start_tag ("li");
		Paragraph? first_para = (element.content.size > 0)? element.content[0] as Paragraph : null;
		if (first_para != null) {
			// We do not pick up alignments in gir-files.
			first_para.accept_children (this);
			bool first_entry = true;
			foreach (var item in element.content) {
				if (!first_entry) {
					item.accept (this);
				}
				first_entry = false;
			}
		} else {
			element.accept_children (this);
		}
		writer.end_tag ("li");
	}

	public override void visit_page (Page element) {
		element.accept_children (this);
	}

	public override void visit_paragraph (Paragraph element) {
		//FIXME: the extra-field is just a workaround for the current codegen ...
		switch (element.horizontal_align) {
		case HorizontalAlign.CENTER:
			writer.start_tag ("p", {"style", "text-align: center;"});
			break;
		case HorizontalAlign.RIGHT:
			writer.start_tag ("p", {"style", "text-align: right;"});
			break;
		default:
			writer.start_tag ("p");
			break;
		}
		element.accept_children (this);
		writer.end_tag ("p");
	}

	private void visit_notification_block (BlockContent element, string headline) {
		writer.start_tag ("div", {"class", "main_notification_block"});
		writer.start_tag ("span", {"class", "main_block_headline"})
			.text (headline)
			.end_tag ("span")
			.text (" ");
		writer.start_tag ("div", {"class", "main_block_content"});
		element.accept_children (this);
		writer.end_tag ("div");
		writer.end_tag ("div");
	}

	public override void visit_warning (Warning element) {
		visit_notification_block (element, "Warning:");
	}

	public override void visit_note (Note element) {
		visit_notification_block (element, "Note:");
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
		case Run.Style.LANG_ESCAPE:
			tag = "span";
			css_type = "main_escape";
			break;
		case Run.Style.LANG_LITERAL:
			tag = "span";
			css_type = "main_literal";
			break;
		case Run.Style.LANG_BASIC_TYPE:
			tag = "span";
			css_type = "main_basic_type";
			break;
		case Run.Style.LANG_TYPE:
			tag = "span";
			css_type = "main_type";
			break;
		case Run.Style.LANG_COMMENT:
			tag = "span";
			css_type = "main_comment";
			break;
		case Run.Style.LANG_PREPROCESSOR:
			tag = "span";
			css_type = "main_preprocessor";
			break;

		case Run.Style.XML_ESCAPE:
			tag = "span";
			css_type = "xml_escape";
			break;

		case Run.Style.XML_ELEMENT:
			tag = "span";
			css_type = "xml_element";
			break;

		case Run.Style.XML_ATTRIBUTE:
			tag = "span";
			css_type = "xml_attribute";
			break;

		case Run.Style.XML_ATTRIBUTE_VALUE:
			tag = "span";
			css_type = "xml_attribute_value";
			break;

		case Run.Style.XML_COMMENT:
			tag = "span";
			css_type = "xml_comment";
			break;

		case Run.Style.XML_CDATA:
			tag = "span";
			css_type = "xml_cdata";
			break;

		case Run.Style.NONE:
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
		writer.set_wrap (false);
		writer.start_tag ("pre", {"class", "main_source"});
		element.accept_children (this);
		writer.end_tag ("pre");
		writer.set_wrap (true);
	}

	public override void visit_table (Table element) {
		writer.start_tag ("table", {"class", "main_table"});
		element.accept_children (this);
		writer.end_tag ("table");
	}

	public override void visit_table_cell (TableCell element) {
		string style = "";

		if (element.horizontal_align != HorizontalAlign.NONE) {
			style += "text-align: "+element.horizontal_align.to_string ()+"; ";
		}

		if (element.vertical_align != VerticalAlign.NONE) {
			style += "vertical-align: "+element.vertical_align.to_string ()+"; ";
		}

		writer.start_tag ("td", {"class", "main_table",
						  "colspan", element.colspan.to_string (),
						  "rowspan", element.rowspan.to_string (),
						  "style", style});
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

