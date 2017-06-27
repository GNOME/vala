/* comment.vala
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


using Valadoc.Taglets;

public class Valadoc.Content.Comment : BlockContent {
	public Vala.List<Taglet> taglets { get { return _taglets; } }
	private Vala.List<Taglet> _taglets;

	private bool checked = false;


	internal Comment () {
		base ();
		_taglets = new Vala.ArrayList<Taglet> ();
	}

	public override void configure (Settings settings, ResourceLocator locator) {
	}

	public override void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings)
	{
		if (checked == true) {
			return ;
		}

		checked = true;


		base.check (api_root, container, file_path, reporter, settings);

		foreach (Taglet element in _taglets) {
			element.parent = this;
			element.check (api_root, container, file_path, reporter, settings);
		}
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_comment (this);
	}

	public override void accept_children (ContentVisitor visitor) {
		base.accept_children (visitor);

		foreach (Taglet element in _taglets) {
			element.accept (visitor);
		}
	}

	public Vala.List<Taglet> find_taglets (Api.Node? container, Type taglet_type) {
		Vala.List<Taglet> selected_taglets = new Vala.ArrayList<Taglet> ();

		// TODO inherit stuff if needed

		foreach (Taglet taglet in _taglets) {
			if (taglet.get_type () == taglet_type) {
				selected_taglets.add (taglet);
			}
		}

		return selected_taglets;
	}

	public override ContentElement copy (ContentElement? new_parent = null) {
		assert (new_parent == null);

		Comment comment = new Comment ();
		comment.parent = new_parent;

		foreach (Block element in content) {
			Block copy = element.copy (comment) as Block;
			comment.content.add (copy);
		}

		foreach (Taglet taglet in _taglets) {
			Taglet copy = taglet.copy (comment) as Taglet;
			comment.taglets.add (copy);
		}

		return comment;
	}
}

