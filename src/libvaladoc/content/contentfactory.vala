/* contentfactory.vala
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
using Gee;

public class Valadoc.Content.ContentFactory : Object {

	public ContentFactory (Settings settings, ResourceLocator locator, ModuleLoader modules) {
		_settings = settings;
		_locator = locator;
		_modules = modules;
	}

	private Settings _settings;
	private ResourceLocator _locator;
	private ModuleLoader _modules;

	private inline ContentElement configure (ContentElement element) {
		element.configure (_settings, _locator);
		return element;
	}

	public Comment create_comment () {
		return (Comment) configure (new Comment ());
	}

	public Embedded create_embedded () {
		return (Embedded) configure (new Embedded ());
	}

	public Headline create_headline () {
		return (Headline) configure (new Headline ());
	}

	public Highlighted create_highlighted (Highlighted.Style style) {
		return (Highlighted) configure (new Highlighted (style));
	}

	public Link create_link () {
		return (Link) configure (new Link ());
	}

	public List create_list () {
		return (List) configure (new List ());
	}

	public ListItem create_list_item () {
		return (ListItem) configure (new ListItem ());
	}

	public Page create_page () {
		return (Page) configure (new Page ());
	}

	public Paragraph create_paragraph () {
		return (Paragraph) configure (new Paragraph ());
	}

	public SourceCode create_source_code () {
		return (SourceCode) configure (new SourceCode ());
	}

	public Table create_table () {
		return (Table) configure (new Table ());
	}

	public TableCell create_table_cell () {
		return (TableCell) configure (new TableCell ());
	}

	public TableRow create_table_row () {
		return (TableRow) configure (new TableRow ());
	}

	public Taglet create_taglet (string name) {
		return _modules.create_taglet (name);
	}

	public Text create_text (string? text = null) {
		return (Text) configure (new Text (text));
	}

	public ContentElement set_style_attributes (StyleAttributes element,
	                                            VerticalAlign? valign,
	                                            HorizontalAlign? halign,
	                                            string? style) {
		element.vertical_align = valign;
		element.horizontal_align = halign;
		element.style = style;
		return element;
	}
}
