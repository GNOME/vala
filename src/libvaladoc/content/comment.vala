/* comment.vala
 *
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
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
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using GLib;
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

	public override void check (Tree api_root, DocumentedElement? container, ErrorReporter reporter) {
		base.check (api_root, container, reporter);

		foreach (Taglet element in _taglets) {
			element.check (api_root, container, reporter);
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

	public Gee.List<Taglet> find_taglets (DocumentedElement? container, Type taglet_type) {
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
