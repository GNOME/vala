/* wikirenderer.vala
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

using Valadoc.Content;

public class Valadoc.ValadocOrg.WikiRenderer : ContentRenderer {
	private Documentation? _container;
	private unowned FileStream _stream;

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

	private delegate void TagletWrite (Taglet taglet);

	private void write_taglets (Gee.List<Taglet> taglets, TagletWrite write) {
		foreach (var taglet in taglets) {
			write (taglet);
		}
	}

	public override void visit_comment (Comment element) {
		Gee.List<Taglet> taglets;

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Since));
		write_taglets (
			taglets,
			(taglet) => {
				var since = taglet as Taglets.Since;
				_stream.printf ("\n\nSince %s.\n", since.version);
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Deprecated));
		write_taglets (
			taglets,
			(taglet) => {
				_stream.puts ("\n\nDeprecated.\n\n");
			});

		// Write description
		element.accept_children (this);

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Param));
		write_taglets (
			taglets,
			(taglet) => {
				var param = taglet as Taglets.Param;
				_stream.printf ("@param %s ", param.parameter_name);
				param.accept_children (this);
				_stream.putc ('\n');
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Return));
		write_taglets (
			taglets,
			(taglet) => {
				var param = taglet as Taglets.Return;
				_stream.puts ("@return ");
				param.accept_children (this);
				_stream.putc ('\n');
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Throws));
		write_taglets (
			taglets,
			(taglet) => {
				var exception = taglet as Taglets.Throws;
				_stream.printf ("@throws %s ", exception.error_domain_name);
				exception.accept_children (this);
				_stream.putc ('\n');
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.See));
		write_taglets (
			taglets,
			(taglet) => {
				var see = taglet as Taglets.See;
				_stream.printf ("@see %s/%s\n", see.symbol.package.name, see.symbol.full_name ());
			});
	}

	public override void visit_embedded (Embedded element) {
		var caption = element.caption;
		if (caption == null) {
			_stream.printf ("{{{%s}}}", element.url);
		} else {
			_stream.printf ("{{{%s|%s}}}", element.url, caption);
		}
	}

	public override void visit_headline (Headline element) {
		_stream.puts (string.nfill (element.level+1, '='));
		element.accept_children (this);
		_stream.putc ('\n');
	}

	public override void visit_link (Link element) {
		var label = element.label;
		_stream.printf ("[[%s|%s]]",
		                element.url,
		                (label == null || label == "") ? element.url : label);
	}

	public override void visit_symbol_link (SymbolLink element) {
		_stream.printf ("{ @link %s/%s }", element.symbol.package.name, element.symbol.full_name ());
	}

	public override void visit_list (Content.List element) {
	}

	public override void visit_list_item (ListItem element) {
	}

	public override void visit_page (Page element) {
		element.accept_children (this);
	}

	public override void visit_paragraph (Paragraph element) {
		element.accept_children (this);
		_stream.printf ("\n\n");
	}

	public override void visit_run (Run element) {
		string tag = null;
		switch (element.style) {
		case Run.Style.BOLD:
			tag = "++";
			break;
		case Run.Style.ITALIC:
			tag = "//";
			break;
		case Run.Style.UNDERLINED:
			tag = "__";
			break;
/*		case Run.Style.MONOSPACED:
			break;
		case Run.Style.STROKE:
			break;
*/		}
		if (tag != null) {
			_stream.puts (tag);
		}
		element.accept_children (this);
		if (tag != null) {
			_stream.puts (tag);
		}
	}

	public override void visit_source_code (SourceCode element) {
		_stream.printf ("{{{\n");
		_stream.printf (element.code);
		_stream.printf ("\n}}}\n\n");
	}

	public override void visit_table (Table element) {
		element.accept_children (this);
		_stream.putc ('\n');
	}

	public override void visit_table_cell (TableCell element) {
		_stream.putc (' ');
		element.accept_children (this);
		_stream.puts (" ||");
	}

	public override void visit_table_row (TableRow element) {
		_stream.puts (" ||");
		element.accept_children (this);
		_stream.putc ('\n');
	}

	public override void visit_taglet (Taglet element) {
	}

	public override void visit_text (Text element) {
		_stream.puts (element.content);
	}
}

