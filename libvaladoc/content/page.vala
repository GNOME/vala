/* page.vala
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


public class Valadoc.Content.Page : BlockContent {
	private bool checked = false;


	internal Page () {
		base ();
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_page (this);
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings)
	{
		if (checked == true) {
			return ;
		}

		checked = true;


		base.check (api_root, container, file_path, reporter, settings);
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		assert (new_parent == null);

		Content.Page page = new Content.Page ();
		page.parent = new_parent;

		foreach (Block block in content) {
			Block copy = block.copy (page) as Block;
			page.content.add (copy);
		}

		return page;
	}
}

