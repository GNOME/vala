/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
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
 */

using GLib;
using Gee;


public class Valadoc.ValadocOrg.TableCellDocElement : Valadoc.TableCellDocElement {
	private Gee.ArrayList<DocElement> content;
	private TextVerticalPosition hpos;
	private TextPosition pos;
	private int dcells;
	private int cells;

	public override void parse (TextPosition pos, TextVerticalPosition hpos, int cells, int dcells, Gee.ArrayList<DocElement> content) {
		this.content = content;
		this.dcells = dcells;
		this.cells = cells;
		this.hpos = hpos;
		this.pos = pos;
	}

	public override bool write (void* res, int max, int index) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		int _max = this.content.size;
		int _index = 0;

		GLib.StringBuilder td = new GLib.StringBuilder ();
		if (this.cells != 1) {
			td.append ("|");
			td.append (this.cells.to_string());
		}

		if (this.dcells != 1) {
			td.append ("-");
			td.append (this.dcells.to_string());
		}

		switch (this.pos) {
		case TextPosition.CENTER:
			td.append (")(");
			break;
		case TextPosition.RIGHT:
			td.append (")) ");
			break;
		}

		switch (this.hpos) {
		case TextVerticalPosition.TOP:
			td.append ("^");
			break;
		case TextVerticalPosition.BOTTOM:
			td.append ("v");
			break;
		}

		if (td.len > 0) {
			file.printf ("<%s>", td.str);
		}

		file.printf (" ");

		foreach (DocElement cell in this.content) {
			cell.write (res, _max, _index );
			_index++;
		}
		file.puts (" || \n" );
		return true;
	}
}


