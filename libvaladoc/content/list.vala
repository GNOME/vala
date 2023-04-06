/* list.vala
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


public class Valadoc.Content.List : ContentElement, Block {
	public enum Bullet {
		NONE,
		UNORDERED,
		ORDERED,
		ORDERED_NUMBER,
		ORDERED_LOWER_CASE_ALPHA,
		ORDERED_UPPER_CASE_ALPHA,
		ORDERED_LOWER_CASE_ROMAN,
		ORDERED_UPPER_CASE_ROMAN;

		public static Bullet? from_string (string? str) {
			switch (str) {
			case "none":
				return Bullet.NONE;

			case "unordered":
				return Bullet.UNORDERED;

			case "ordered":
				return Bullet.ORDERED;

			case "ordered-number":
				return Bullet.ORDERED_NUMBER;

			case "ordered-lower-case-alpa":
				return Bullet.ORDERED_LOWER_CASE_ALPHA;

			case "ordered-upper-case-alpha":
				return Bullet.ORDERED_UPPER_CASE_ALPHA;

			case "ordered-lower-case-roman":
				return Bullet.ORDERED_LOWER_CASE_ROMAN;

			case "ordered-upper-case-roman":
				return Bullet.ORDERED_UPPER_CASE_ROMAN;
			}

			return null;
		}

		public unowned string to_string () {
			switch (this) {
			case Bullet.NONE:
				return "none";

			case Bullet.UNORDERED:
				return "unordered";

			case Bullet.ORDERED:
				return "ordered";

			case Bullet.ORDERED_NUMBER:
				return "ordered-number";

			case Bullet.ORDERED_LOWER_CASE_ALPHA:
				return "ordered-lower-case-alpa";

			case Bullet.ORDERED_UPPER_CASE_ALPHA:
				return "ordered-upper-case-alpha";

			case Bullet.ORDERED_LOWER_CASE_ROMAN:
				return "ordered-lower-case-roman";

			case Bullet.ORDERED_UPPER_CASE_ROMAN:
				return "ordered-upper-case-roman";
			}

			assert (true);
			return "";
		}
	}

	public Bullet bullet {
		get;
		set;
	}

	// TODO add initial value (either a number or some letters)
	public Vala.List<ListItem> items { get; private set; }

	internal List () {
		base ();
		bullet = Bullet.NONE;
		items = new Vala.ArrayList<ListItem> ();
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings)
	{
		// Check individual list items
		foreach (ListItem element in items) {
			element.parent = this;
			element.check (api_root, container, file_path, reporter, settings);
		}
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_list (this);
	}

	public override void accept_children (ContentVisitor visitor) {
		foreach (ListItem element in items) {
			element.accept (visitor);
		}
	}

	public override bool is_empty () {
		return items.size == 0;
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		Content.List list = new Content.List ();
		list.parent = new_parent;
		list.bullet = bullet;

		foreach (ListItem item in items) {
			ListItem copy = item.copy (list) as ListItem;
			list.items.add (copy);
		}

		return list;
	}
}
