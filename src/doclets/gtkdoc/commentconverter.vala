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
	public string brief_comment;
	public string long_comment;
	public Gee.List<Header> headers = new Gee.LinkedList<Header> ();
	public string returns;
	public Gee.List<Header> versioning = new Gee.LinkedList<Header> ();

	private StringBuilder current_builder = new StringBuilder ();
	private bool in_brief_comment = true;

	public void convert (Comment comment) {
		comment.accept (this);
		brief_comment = brief_comment.strip ();
		long_comment = current_builder.str.strip ();
		if (long_comment == "") {
			long_comment = null;
		}
	}

	public override void visit_comment (Comment c) {
		c.accept_children (this);
	}
  
	public override void visit_embedded (Embedded em) {
		current_builder.append ("<figure>");
		if (em.caption != null) {
			current_builder.append_printf ("<title>%s</title>", em.caption);
		}

		current_builder.append_printf ("<mediaobject><imageobject><imagedata fileref=\"%s\"/></imageobject>", em.url);

		if (em.caption != null) {
			current_builder.append_printf ("<textobject><phrase>%s</phrase></textobject>", em.caption);
		}

		em.accept_children (this);
		current_builder.append ("</mediaobject>");
		current_builder.append ("</figure>");
	}

	public override void visit_headline (Headline hl) {
		// what to do here?
		warning ("GtkDoc: Headline elements not supported");
		current_builder.append ("\n");
		hl.accept_children (this);
		current_builder.append ("\n");
	}
  
	public override void visit_link (Link link) {
		current_builder.append_printf ("<ulink url=\"%s\">", link.url);
		link.accept_children (this);
		current_builder.append ("</ulink>");
	}

	public override void visit_symbol_link (SymbolLink sl) {
		current_builder.append (get_reference (sl.symbol) ?? sl.label);
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
			warning ("GtkDoc: unsupported list type: %s", list.bullet.to_string ());
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
		current_builder.append ("\n");
		para.accept_children (this);
		current_builder.append ("\n");
		if (in_brief_comment) {
			brief_comment = current_builder.str;
			current_builder = new StringBuilder ();
			in_brief_comment = false;
		}
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
			current_builder.append ("<blockquote>");
			tag = "blockquote";
			break;
		}
		run.accept_children (this);

		if (tag != null) {
			current_builder.append_printf ("</%s>", tag);
		}
	}
  
	public override void visit_source_code (SourceCode code) {
		current_builder.append ("<programlisting>");
		code.accept_children (this);
		current_builder.append ("</programlisting>");
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
			var header = new Header ("@"+((Taglets.Param)t).parameter_name, current_builder.str);
			headers.add (header);
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
			old_builder.append_printf ("\n<emphasis>See Also</emphasis>: %s\n", get_reference (see.symbol) ?? see.symbol_name);
		} else if (t is Taglets.Link) {
			((Taglets.Link)t).produce_content().accept (this);
		} else {
			warning ("GtkDoc: Taglet not supported"); // TODO
		}
		current_builder = (owned)old_builder;
	}
  
	public override void visit_text (Text t) {
		current_builder.append (t.content);
		t.accept_children (this);
	}
}

