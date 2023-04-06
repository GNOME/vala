/* inlinecontent.vala
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


public abstract class Valadoc.Content.InlineContent : ContentElement {
	public Vala.List<Inline> content { get; private set; }

	construct {
		content = new Vala.ArrayList<Inline> ();
	}

	internal InlineContent () {
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings)
	{
		foreach (Inline element in content) {
			element.parent = this;
			element.check (api_root, container, file_path, reporter, settings);
		}
	}

	public override void accept_children (ContentVisitor visitor) {
		foreach (Inline element in content) {
			element.accept (visitor);
		}
	}

	public override bool is_empty () {
		foreach (Inline item in content) {
			if (!item.is_empty ()) {
				return false;
			}
		}

		return true;
	}

	internal void replace_node (Inline old, Inline replacement) {
		int index = content.index_of (old);
		assert (index >= 0);

		content.set (index, replacement);
	}
}

