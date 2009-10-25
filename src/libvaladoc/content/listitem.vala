/* listitem.vala
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

using Gee;


public class Valadoc.Content.ListItem : InlineContent {
	public enum Bullet {
		NONE,
		UNORDERED,
		ORDERED,
		ORDERED_LATIN,
		ORDERED_CAPITAL,
		ORDERED_NUMBER,
		ORDERED_LOWER_CASE
	}

	public Bullet bullet { get; set; }
	public int level { get; set; }

	internal ListItem () {
		base ();
		_bullet = Bullet.UNORDERED;
		_level = 0;
	}

	public override void check (Api.Tree api_root, Api.Node? container, ErrorReporter reporter) {
		// TODO report error if level == 0 ?

		// Check inline content
		base.check (api_root, container, reporter);
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_list_item (this);
	}
}

