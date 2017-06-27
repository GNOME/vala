/* commentscanner.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
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

public class Valadoc.CommentScanner : WikiScanner {

	public CommentScanner (Settings settings) {
		base (settings);
	}

	private bool in_line_start;
	private bool past_star;
	private int start_column;

	public override void reset () {
		base.reset ();

		in_line_start = true;
		past_star = false;
		start_column = 0;
	}

	public override int get_line_start_column () {
		return start_column;
	}

	protected override void accept (unichar c) throws ParserError {
		if (in_line_start) {
			start_column++;
			if (c == '*') {
				past_star = true;
			} else if (past_star) {
				past_star = false;
				if (c == '\n') {
					base.accept (c);
					in_line_start = true;
					start_column = 0;
				} else {
					in_line_start = false;
				}
			}
		} else {
			base.accept (c);
			if (c == '\n') {
				in_line_start = true;
				start_column = 0;
			}
		}
	}
}

