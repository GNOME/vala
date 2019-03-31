/* commentconverter.vala
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

using Valadoc;
using Valadoc.Api;
using Valadoc.Content;

public class Gtkdoc.CommentConverter : ContentVisitor {
	public Api.Node node_reference;

	public bool is_dbus;
	public string brief_comment;
	public string long_comment;
	public string returns;
	public Vala.List<Header> parameters = new Vala.ArrayList<Header> ();
	public Vala.List<Header> versioning = new Vala.ArrayList<Header> ();
	public string[] see_also = new string[]{};

	private StringBuilder current_builder = new StringBuilder ();
	private bool in_brief_comment = true;
	private ErrorReporter reporter;

	public CommentConverter (ErrorReporter reporter, Api.Node? node_reference = null) {
		this.node_reference = node_reference;
		this.reporter = reporter;
	}

	public void convert (Content.Comment comment, bool is_dbus = false) {
		this.is_dbus = is_dbus;
		comment.accept (this);

		long_comment = current_builder.str.strip ();
		if (long_comment == "") {
			long_comment = null;
		}
	}

	public override void visit_comment (Content.Comment c) {
		c.accept_children (this);
	}

	public override void visit_embedded (Embedded em) {
		current_builder.append ("<figure>");
		if (em.caption != null) {
			current_builder.append_printf ("<title>%s</title>", em.caption);
		}

		current_builder.append_printf ("<mediaobject><imageobject><imagedata fileref=\"%s\"/></imageobject>",
									   em.url);

		if (em.caption != null) {
			current_builder.append_printf ("<textobject><phrase>%s</phrase></textobject>", em.caption);
		}

		em.accept_children (this);
		current_builder.append ("</mediaobject>");
		current_builder.append ("</figure>");
	}

	public override void visit_headline (Headline hl) {
		// what to do here?
		reporter.simple_warning ("GtkDoc", "Headline elements not supported");
		current_builder.append ("\n");
		hl.accept_children (this);
		current_builder.append ("\n");
	}

	public override void visit_wiki_link (WikiLink link) {
		// wiki pages are not supported right now
		if (link.content.size > 0) {
			link.accept_children (this);
		} else {
			current_builder.append (link.name);
		}
	}

	public override void visit_link (Link link) {
		current_builder.append_printf ("<ulink url=\"%s\">", link.url);
		link.accept_children (this);
		current_builder.append ("</ulink>");
	}

	public override void visit_symbol_link (SymbolLink sl) {
		if (sl.symbol != null) {
			// If the symbol is a method and it doesn't have a constructor, fall back to linking to the class
			if (sl.symbol is Method && ((Method) sl.symbol).is_constructor &&
			    ((Method) sl.symbol).parent is Class && ((Class) ((Method) sl.symbol).parent).is_abstract) {
				current_builder.append (get_docbook_link (((Method) sl.symbol).parent, is_dbus) ?? sl.given_symbol_name);
			} else {
				current_builder.append (get_docbook_link (sl.symbol, is_dbus) ?? sl.given_symbol_name);
			}
		} else {
			current_builder.append (sl.given_symbol_name);
		}
	}

	public override void visit_list (Content.List list) {
		string tag = "orderedlist";
		switch (list.bullet) {
		case Content.List.Bullet.NONE:
			current_builder.append ("<itemizedlist mark=\"none\">");
			tag = "itemizedlist";
			break;

		case Content.List.Bullet.UNORDERED:
			current_builder.append ("<itemizedlist>");
			tag = "itemizedlist";
			break;

		case Content.List.Bullet.ORDERED:
			current_builder.append ("<orderedlist>");
			break;

		case Content.List.Bullet.ORDERED_NUMBER:
			current_builder.append ("<orderedlist numeration=\"arabic\">");
			break;

		case Content.List.Bullet.ORDERED_LOWER_CASE_ALPHA:
			current_builder.append ("<orderedlist numeration=\"loweralpha\">");
			break;

		case Content.List.Bullet.ORDERED_UPPER_CASE_ALPHA:
			current_builder.append ("<orderedlist numeration=\"upperalpha\">");
			break;

		case Content.List.Bullet.ORDERED_LOWER_CASE_ROMAN:
			current_builder.append ("<orderedlist numeration=\"lowerroman\">");
			break;

		case Content.List.Bullet.ORDERED_UPPER_CASE_ROMAN:
			current_builder.append ("<orderedlist numeration=\"upperroman\">");
			break;

		default:
			reporter.simple_warning ("GtkDoc",
									 "unsupported list type: '%s'", list.bullet.to_string ());
			break;
		}

		list.accept_children (this);
		current_builder.append_printf ("</%s>", tag);
	}

	public override void visit_list_item (ListItem item) {
		current_builder.append ("<listitem>");
		item.accept_children (this);
		current_builder.append ("</listitem>");
	}

	public override void visit_paragraph (Paragraph para) {
		if (!in_brief_comment) {
			current_builder.append ("<para>");
		}
		para.accept_children (this);

		if (in_brief_comment) {
			brief_comment = current_builder.str;
			current_builder = new StringBuilder ();
			in_brief_comment = false;
		} else {
			current_builder.append ("</para>");
		}
	}

	public override void visit_warning (Warning element) {
		current_builder.append ("<warning>");
		element.accept_children (this);
		current_builder.append ("</warning>");
	}

	public override void visit_note (Note element) {
		current_builder.append ("<note>");
		element.accept_children (this);
		current_builder.append ("</note>");
	}

	public override void visit_page (Page page) {
		page.accept_children (this);
	}

	public override void visit_run (Run run) {
		string? tag = null;
		switch (run.style) {
		case Run.Style.BOLD:
			current_builder.append ("<emphasis role=\"bold\">");
			tag = "emphasis";
			break;

		case Run.Style.ITALIC:
			current_builder.append ("<emphasis>");
			tag = "emphasis";
			break;

		case Run.Style.UNDERLINED:
			current_builder.append ("<emphasis role=\"underline\">");
			tag = "emphasis";
			break;

		case Run.Style.MONOSPACED:
			current_builder.append ("<code>");
			tag = "code";
			break;
		default:
			break;
		}
		run.accept_children (this);

		if (tag != null) {
			current_builder.append_printf ("</%s>", tag);
		}
	}

	public override void visit_source_code (SourceCode code) {
		current_builder.append ("\n|[\n");
		current_builder.append (Markup.escape_text (code.code));
		current_builder.append ("\n]|\n");
	}

	public override void visit_table (Table t) {
		current_builder.append ("<table>");
		t.accept_children (this);
		current_builder.append ("</table>");
	}

	public override void visit_table_row (TableRow row) {
		current_builder.append ("<tr>");
		row.accept_children (this);
		current_builder.append ("</tr>");
	}

	public override void visit_table_cell (TableCell cell) {
		current_builder.append ("<td>");
		cell.accept_children (this);
		current_builder.append ("</td>");
	}

	public override void visit_taglet (Taglet t) {
		var old_builder = (owned)current_builder;
		current_builder = new StringBuilder ();

		t.accept_children (this);
		if (t is Taglets.Param) {
			double pos = double.MAX;
			var param_name = ((Taglets.Param)t).parameter_name;
			if (node_reference != null) {
				pos = get_parameter_pos (node_reference, param_name);
			}
			var header = new Header (param_name, current_builder.str, pos);
			parameters.add (header);
		} else if (t is Taglets.InheritDoc) {
			((Taglets.InheritDoc)t).produce_content().accept (this);
		} else if (t is Taglets.Return) {
			returns = current_builder.str;
		} else if (t is Taglets.Since) {
			var header = new Header ("Since", ((Taglets.Since)t).version);
			versioning.add (header);
		} else if (t is Taglets.Deprecated) {
			var header = new Header ("Deprecated", current_builder.str);
			versioning.add (header);
		} else if (t is Taglets.See) {
			var see = (Taglets.See)t;
			var see_also = this.see_also; // vala bug
			if (see.symbol != null) {
				see_also += get_docbook_link (see.symbol, is_dbus) ?? see.symbol_name;
			} else {
				see_also += see.symbol_name;
			}
			this.see_also = see_also;
		} else if (t is Taglets.Link) {
			((Taglets.Link)t).produce_content().accept (this);
		} else if (t is Taglets.Throws) {
			var taglet = (Taglets.Throws) t;
			var link = get_docbook_link (taglet.error_domain) ?? taglet.error_domain_name;
			old_builder.append_printf ("\n<para>%s will be returned in @error %s</para>",
									   link,
									   current_builder.str);
		} else {
			reporter.simple_warning ("GtkDoc", "Taglet not supported"); // TODO
		}
		current_builder = (owned)old_builder;
	}

	public override void visit_text (Text t) {
		current_builder.append (Markup.escape_text (t.content));
		t.accept_children (this);
	}
}

