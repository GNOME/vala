/* table.vala
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


public class Valadoc.Content.Table : ContentElement, Block {
	public Vala.List<TableRow> rows {
		get {
			return _rows;
		}
	}

	private Vala.List<TableRow> _rows;

	internal Table () {
		base ();
		_rows = new Vala.ArrayList<TableRow> ();
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings)
	{
		// Check the table consistency in term of row/column number

		// Check individual rows
		foreach (var row in _rows) {
			row.parent = this;
			row.check (api_root, container, file_path, reporter, settings);
		}
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_table (this);
	}

	public override void accept_children (ContentVisitor visitor) {
		foreach (TableRow element in _rows) {
			element.accept (visitor);
		}
	}

	public override bool is_empty () {
		return false;
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		Table table = new Table ();
		table.parent = new_parent;

		foreach (var row in _rows) {
			TableRow copy = row.copy (table) as TableRow;
			table.rows.add (copy);
		}

		return table;
	}
}

