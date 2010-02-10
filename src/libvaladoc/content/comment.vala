/* comment.vala
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


public class Valadoc.Content.Comment : BlockContent {
	public Gee.List<Taglet> taglets { get { return _taglets; } }

	private Gee.List<Taglet> _taglets;

	internal Comment () {
		base ();
		_taglets = new ArrayList<Taglet> ();
	}

	public override void configure (Settings settings, ResourceLocator locator) {
	}

	public override void check (Api.Tree api_root, Api.Node? container, ErrorReporter reporter, Settings settings) {
		base.check (api_root, container, reporter, settings);

		foreach (Taglet element in _taglets) {
			element.check (api_root, container, reporter, settings);
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

	public Gee.List<Taglet> find_taglets (Api.Node? container, Type taglet_type) {
		Gee.List<Taglet> selected_taglets = new ArrayList<Taglet> ();

		// TODO inherit stuff if needed

		foreach (Taglet taglet in _taglets) {
			if (taglet.get_type () == taglet_type) {
				selected_taglets.add (taglet);
			}
		}

		return selected_taglets;
	}
}

