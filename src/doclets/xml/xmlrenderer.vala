/* xmlrenderer.vala
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

public class Valadoc.Xml.Renderer : ContentRenderer {
	private Documentation? _container;
	private Xml.MarkupWriter _writer;

	public void set_container (Documentation? container) {
		_container = container;
	}

	public void set_filestream (Xml.MarkupWriter writer) {
		_writer = writer;
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

		element.accept_children (this);
		_writer.start_tag ("taglets");

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Since));
		write_taglets (
			taglets,
			(taglet) => {
				var since = taglet as Taglets.Since;
				_writer.simple_tag ("taglet", {"name", "since", "version", since.version});
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Deprecated));
		write_taglets (
			taglets,
			(taglet) => {
				_writer.simple_tag ("taglet", {"name", "deprecated"});
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Param));
		write_taglets (
			taglets,
			(taglet) => {
				var param = taglet as Taglets.Param;
				_writer.start_tag ("taglet", {"name", "param", "parameter", param.parameter_name});
				param.accept_children (this);
				_writer.end_tag ("taglet");
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Return));
		write_taglets (
			taglets,
			(taglet) => {
				var param = taglet as Taglets.Return;
				_writer.start_tag ("taglet", {"name", "return"});
				param.accept_children (this);
				_writer.end_tag ("taglet");
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.Throws));
		write_taglets (
			taglets,
			(taglet) => {
				var exception = taglet as Taglets.Throws;
				_writer.start_tag ("taglet", {"name", "throw", "type", exception.error_domain_name});
				exception.accept_children (this);
				_writer.end_tag ("taglet");
			});

		taglets = element.find_taglets ((Api.Node) _container, typeof (Taglets.See));
		write_taglets (
			taglets,
			(taglet) => {
				var see = taglet as Taglets.See;
				_writer.simple_tag ("taglet", {"name", "see", "type", see.symbol.get_full_name ()});
			});

		_writer.end_tag ("taglets");
	}

	public override void visit_embedded (Embedded element) {
		var caption = element.caption;
		_writer.simple_tag ("embedded", {"url", element.url, "caption", (caption == null)? "" : caption});
	}

	public override void visit_headline (Headline element) {
		_writer.start_tag ("headline", {"level", element.level.to_string ()});
		element.accept_children (this);
		_writer.end_tag ("headline");
	}

	public override void visit_link (Link element) {
		_writer.start_tag ("link", {"url", element.url});
		if (element.content.size > 0) {
			element.accept_children (this);
		} else {
			_writer.text (element.url);
		}
		_writer.end_tag ("link");
	}

	public override void visit_symbol_link (SymbolLink element) {
		_writer.simple_tag ("inline-taglet", {"name", "symbol-link", "type", element.symbol.get_full_name ()});
	}

	public override void visit_list (Content.List element) {
		_writer.start_tag ("list", {"bullet-type", element.bullet.to_string ()});
		element.accept_children (this);
		_writer.end_tag ("list");
	}

	public override void visit_list_item (ListItem element) {
		_writer.start_tag ("list-item");
		element.accept_children (this);
		_writer.end_tag ("list-item");
	}

	public override void visit_page (Page element) {
		element.accept_children (this);
	}

	public override void visit_paragraph (Paragraph element) {
		_writer.start_tag ("paragraph");
		element.accept_children (this);
		_writer.end_tag ("paragraph");
	}

	public override void visit_run (Run element) {
		if(element.style == Run.Style.BOLD || element.style == Run.Style.ITALIC ||
		   element.style == Run.Style.UNDERLINED || element.style == Run.Style.MONOSPACED ||
		   element.style == Run.Style.STROKE) {

			_writer.start_tag ("run", {"style", element.style.to_string ()});
			element.accept_children (this);
			_writer.end_tag ("run");
		} else {
			element.accept_children (this);
		}
	}

	public override void visit_source_code (SourceCode element) {
		_writer.start_tag ("source-code", {"language", element.language.to_string ()});
		_writer.text (element.code);
		_writer.end_tag ("source-code");
	}

	public override void visit_table (Table element) {
		_writer.start_tag ("table");
		element.accept_children (this);
		_writer.end_tag ("table");
	}

	public override void visit_table_cell (TableCell element) {
		_writer.start_tag ("table-cell", {"colspan", element.colspan.to_string (),
										  "rowspan", element.rowspan.to_string (),
										  "horizontal-align", (element.horizontal_align == null)? null : element.horizontal_align.to_string (),
										  "vertical-align", (element.vertical_align == null)? null : element.vertical_align.to_string ()});
		element.accept_children (this);
		_writer.end_tag ("table-cell");
	}

	public override void visit_table_row (TableRow element) {
		_writer.start_tag ("table-row");
		element.accept_children (this);
		_writer.end_tag ("table-row");
	}

	public override void visit_taglet (Taglet element) {
	}

	public override void visit_text (Text element) {
		unowned string from = element.content;
		unowned string to;

		while ((to = from.chr (-1, '\n')) != null) {
			_writer.text (from.substring (0, from.pointer_to_offset(to)));
			_writer.simple_tag ("br");
			from = to.offset(1);
		}
		_writer.text (from);
	}
}

