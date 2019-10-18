/* gtkdocrenderer.vala
 *
 * Copyright (C) 2011 Florian Brosch
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

using GLib;
using Valadoc.Content;

public class Valadoc.GtkdocRenderer : ContentRenderer {
	private GtkDocMarkupWriter writer = new GtkDocMarkupWriter ();
	protected Settings settings;
	private bool separated;

	private string? get_cname (Api.Item item) {
		if (item is Api.Method) {
			return ((Api.Method)item).get_cname ();
		} else if (item is Api.Parameter) {
			return ((Api.Parameter)item).name;
		} else if (item is Api.Constant) {
			return ((Api.Constant)item).get_cname ();
		} else if (item is Api.Property) {
			return ((Api.Property)item).get_cname ();
		} else if (item is Api.Signal) {
			var name = ((Api.Signal)item).get_cname ();
			return name.replace ("_", "-");
		} else if (item is Api.Class) {
			return ((Api.Class)item).get_cname ();
		} else if (item is Api.Struct) {
			return ((Api.Struct)item).get_cname ();
		} else if (item is Api.Interface) {
			return ((Api.Interface)item).get_cname ();
		} else if (item is Api.ErrorDomain) {
			return ((Api.ErrorDomain)item).get_cname ();
		} else if (item is Api.ErrorCode) {
			return ((Api.ErrorCode)item).get_cname ();
		} else if (item is Api.Delegate) {
			return ((Api.Delegate)item).get_cname ();
		} else if (item is Api.Enum) {
			return ((Api.Enum)item).get_cname ();
		} else if (item is Api.EnumValue) {
			return ((Api.EnumValue)item).get_cname ();
		}

		return null;
	}

	public void write_docbook_link (Api.Item item) {
		writer.set_wrap (false);

		if (item is Api.Method) {
			writer.start_tag ("function")
				.text (((Api.Method)item).get_cname ())
				.end_tag ("function");
		} else if (item is Api.Parameter) {
			writer.start_tag ("parameter").
				text (((Api.Parameter)item).name ?? "...")
				.end_tag ("parameter");
		} else if (item is Api.Constant) {
			writer.start_tag ("constant").text (((Api.Constant)item)
				.get_cname ())
				.end_tag ("constant");
		} else if (item is Api.Property) {
			// TODO: use docbook-tags instead
			writer.text ("#").text (get_cname(item.parent))
				.text (":")
				.text (((Api.Property)item)
				.get_cname ().replace ("_", "-"));
		} else if (item is Api.Signal) {
			// TODO: use docbook-tags instead
			writer.text ("#").text (get_cname(item.parent))
				.text ("::")
				.text (((Api.Signal)item).get_cname ().replace ("_", "-"));
		} else if (item is Api.Namespace) {
			writer.text (((Api.Namespace) item).get_full_name ());
		} else {
			writer.start_tag ("type")
				.text (get_cname (item))
				.end_tag ("type");
		}

		writer.set_wrap (true);
	}

	public GtkdocRenderer () {
	}

	public override void render (ContentElement element) {
		reset ();
		element.accept (this);
	}

	public void render_symbol (Content.Comment? documentation) {
		render (documentation);

		append_exceptions (documentation.find_taglets (null, typeof(Taglets.Throws)));
		append_see (documentation.find_taglets (null, typeof(Taglets.See)));
		append_since (documentation.find_taglets (null, typeof(Taglets.Since)));
	}

	public override void render_children (ContentElement element) {
		reset ();
		element.accept_children (this);
	}

	private void reset () {
		separated = false;
		writer.reset ();
	}

	public unowned string content {
		get {
			if (writer.content.has_prefix ("\n")) {
				return writer.content.next_char ();
			}

			return writer.content;
		}
	}

	public override void visit_comment (Comment element) {
		element.accept_children (this);
	}

	public override void visit_embedded (Embedded element) {
		writer.start_tag ("figure");
		if (element.caption != null) {
			writer.start_tag ("title")
				.text (element.caption)
				.end_tag ("title");
		}

		writer.start_tag ("mediaobject");

		writer.start_tag ("imageobject")
			.simple_tag ("imagedata", {"fileref", element.url})
			.end_tag ("imageobject");

		if (element.caption != null) {
			writer.start_tag ("textobject")
				.start_tag ("phrase")
				.text (element.caption)
				.end_tag ("phrase")
				.end_tag ("textobject");
		}

		writer.end_tag ("mediaobject");
		writer.end_tag ("figure");
	}

	public override void visit_headline (Headline element) {
		assert_not_reached ();
	}

	public override void visit_wiki_link (WikiLink element) {
		// wiki pages are not supported by gir
		if (element.content.size > 0) {
			element.accept_children (this);
		} else {
			write_string (element.name);
		}
	}

	public override void visit_link (Link element) {
		writer.start_tag ("ulink", {"url", element.url});
		element.accept_children (this);
		writer.end_tag ("ulink");
	}

	public override void visit_symbol_link (SymbolLink element) {
		if (element.content.size > 0) {
			writer.text ("\"");
			element.accept_children (this);
			writer.text ("\" (");
			write_symbol_link (element);
			writer.text (")");
		} else {
			write_symbol_link (element);
		}
	}

	public void write_symbol_link (SymbolLink element) {
		if (element.symbol == null) {
			writer.text (element.given_symbol_name);
		} else {
			write_docbook_link (element.symbol);
		}
	}

	public override void visit_list (Content.List element) {
		string tag = "orderedlist";
		switch (element.bullet) {
		case Content.List.Bullet.NONE:
			writer.start_tag ("itemizedlist", {"mark", "none"});
			tag = "itemizedlist";
			break;

		case Content.List.Bullet.UNORDERED:
			writer.start_tag ("itemizedlist");
			tag = "itemizedlist";
			break;

		case Content.List.Bullet.ORDERED:
			writer.start_tag ("orderedlist");
			break;

		case Content.List.Bullet.ORDERED_NUMBER:
			writer.start_tag ("orderedlist", {"numeration", "arabic"});
			break;

		case Content.List.Bullet.ORDERED_LOWER_CASE_ALPHA:
			writer.start_tag ("orderedlist", {"numeration", "loweralpha"});
			break;

		case Content.List.Bullet.ORDERED_UPPER_CASE_ALPHA:
			writer.start_tag ("orderedlist", {"numeration", "upperalpha"});
			break;

		case Content.List.Bullet.ORDERED_LOWER_CASE_ROMAN:
			writer.start_tag ("orderedlist", {"numeration", "lowerroman"});
			break;

		case Content.List.Bullet.ORDERED_UPPER_CASE_ROMAN:
			writer.start_tag ("orderedlist", {"numeration", "upperroman"});
			break;

		default:
			assert_not_reached ();
		}

		element.accept_children (this);

		writer.end_tag (tag);
	}

	public override void visit_list_item (ListItem element) {
		writer.start_tag ("listitem");
		element.accept_children (this);
		writer.end_tag ("listitem");
	}

	public override void visit_page (Page element) {
		element.accept_children (this);
	}

	public override void visit_paragraph (Paragraph element) {
		writer.start_tag ("para");
		element.accept_children (this);
		writer.end_tag ("para");
	}

	public override void visit_warning (Warning element) {
		writer.start_tag ("warning");
		element.accept_children (this);
		writer.end_tag ("warning");
	}

	public override void visit_note (Note element) {
		writer.start_tag ("note");
		element.accept_children (this);
		writer.end_tag ("note");
	}

	public override void visit_run (Run element) {
		string? tag = null;

		switch (element.style) {
		case Run.Style.BOLD:
			writer.start_tag ("emphasis", {"role", "bold"});
			tag = "emphasis";
			break;

		case Run.Style.ITALIC:
			writer.start_tag ("emphasis");
			tag = "emphasis";
			break;

		case Run.Style.UNDERLINED:
			writer.start_tag ("emphasis", {"role", "underline"});
			tag = "emphasis";
			break;

		case Run.Style.MONOSPACED:
			writer.start_tag ("blockquote");
			tag = "blockquote";
			break;
		default:
			break;
		}

		element.accept_children (this);

		if (tag != null) {
			writer.end_tag (tag);
		}
	}

	public override void visit_source_code (SourceCode element) {
		writer.start_tag ("example")
			.start_tag ("programlisting");
		writer.text (element.code);
		writer.end_tag ("programlisting")
			.end_tag ("example");
	}

	public override void visit_table (Table element) {
		writer.start_tag ("table", {"align", "center"});
		element.accept_children (this);
		writer.end_tag ("table");
	}

	public override void visit_table_cell (TableCell element) {
		writer.start_tag ("td", {"colspan", element.colspan.to_string (), "rowspan", element.rowspan.to_string ()});
		element.accept_children (this);
		writer.end_tag ("td");
	}

	public override void visit_table_row (TableRow element) {
		writer.start_tag ("tr");
		element.accept_children (this);
		writer.end_tag ("tr");
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
			case '<':
				writer.raw_text (content.substring (lpos, i-lpos));
				writer.raw_text ("&lt;");
				lpos = i+1;
				break;

			case '>':
				writer.raw_text (content.substring (lpos, i-lpos));
				writer.raw_text ("&gt;");
				lpos = i+1;
				break;

			case '"':
				writer.raw_text (content.substring (lpos, i-lpos));
				writer.raw_text ("&quot;");
				lpos = i+1;
				break;

			case '\'':
				writer.raw_text (content.substring (lpos, i-lpos));
				writer.raw_text ("&apos;");
				lpos = i+1;
				break;

			case '&':
				writer.raw_text (content.substring (lpos, i-lpos));
				writer.raw_text ("&amp;");
				lpos = i+1;
				break;

			case '#':
				writer.raw_text (content.substring (lpos, i-lpos));
				writer.raw_text ("&num;");
				lpos = i+1;
				break;

			case '%':
				writer.raw_text (content.substring (lpos, i-lpos));
				writer.raw_text ("&percnt;");
				lpos = i+1;
				break;

			case '@':
				writer.raw_text (content.substring (lpos, i-lpos));
				writer.raw_text ("&commat;");
				lpos = i+1;
				break;

			case '(':
				writer.raw_text (content.substring (lpos, i-lpos));
				writer.raw_text ("&lpar;");
				lpos = i+1;
				break;

			case ')':
				writer.raw_text (content.substring (lpos, i-lpos));
				writer.raw_text ("&rpar;");
				lpos = i+1;
				break;

			case '\n':
				writer.raw_text (content.substring (lpos, i-lpos));
				writer.simple_tag ("br");
				lpos = i+1;
				break;
			}
		}

		writer.raw_text (content.substring (lpos, i-lpos));
	}

	public void append_since (Vala.List<Content.Taglet> taglets) {
		foreach (Content.Taglet _taglet in taglets) {
			Taglets.Since taglet = _taglet as Taglets.Since;
			if (taglet == null || taglet.version == null) {
				// ignore unexpected taglets
				continue ;
			}

			if (separated == false) {
				writer.text ("\n");
			}

			writer.set_wrap (false);
			writer.text ("\nSince: ")
				.text (taglet.version);
			writer.set_wrap (true);
			separated = true;

			// ignore multiple occurrences
			return ;
		}
	}

	public void append_see (Vala.List<Content.Taglet> taglets) {
		bool first = true;
		foreach (Content.Taglet _taglet in taglets) {
			Taglets.See taglet = _taglet as Taglets.See;
			if (taglet == null || taglet.symbol == null) {
				// ignore unexpected taglets
				continue ;
			}

			if (first) {
				writer.start_tag ("para").text ("See also: ");
			} else {
				writer.text (", ");
			}

			write_docbook_link (taglet.symbol);
			first = false;
		}

		if (first == false) {
			writer.end_tag ("para");
		}
	}

	public void append_exceptions (Vala.List<Content.Taglet> taglets) {
		bool first = true;
		foreach (Content.Taglet _taglet in taglets) {
			Taglets.Throws taglet = _taglet as Taglets.Throws;
			if (taglet == null || taglet.error_domain == null) {
				// ignore unexpected taglets
				continue ;
			}

			if (first) {
				writer.start_tag ("para")
					.text ("This function may throw:")
					.end_tag ("para");
				writer.start_tag ("table");
			}

			writer.start_tag ("tr");

			writer.start_tag ("td");
			write_docbook_link (taglet.error_domain);
			writer.end_tag ("td");

			writer.start_tag ("td");
			taglet.accept_children (this);
			writer.end_tag ("td");

			writer.end_tag ("tr");

			first = false;
		}

		if (first == false) {
			writer.end_tag ("table");
		}
	}
}

