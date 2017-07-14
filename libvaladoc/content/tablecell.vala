/* tablecell.vala
 *
 * Copyright (C) 2008-2009 Didier Villevalois
 * Copyright (C) 2008-2012 Florian Brosch
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


public class Valadoc.Content.TableCell : InlineContent, StyleAttributes {
	public HorizontalAlign horizontal_align {
		get;
		set;
	}

	public VerticalAlign vertical_align {
		get;
		set;
	}

	public string? style {
		get;
		set;
	}

	public int colspan {
		get;
		set;
	}

	public int rowspan {
		get;
		set;
	}

	internal TableCell () {
		base ();
		_colspan = 1;
		_rowspan = 1;
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
		ErrorReporter reporter, Settings settings)
	{
		// Check inline content
		base.check (api_root, container, file_path, reporter, settings);
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_table_cell (this);
	}

	public override bool is_empty () {
		// empty cells are displayed as well
		return false;
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		TableCell cell = new TableCell ();
		cell.parent = new_parent;

		cell.horizontal_align = horizontal_align;
		cell.vertical_align = vertical_align;
		cell.colspan = colspan;
		cell.rowspan = rowspan;
		cell.style = style;

		foreach (Inline element in content) {
			Inline copy = element.copy (cell) as Inline;
			cell.content.add (copy);
		}

		return cell;
	}
}

