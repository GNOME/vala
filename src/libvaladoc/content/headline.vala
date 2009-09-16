/* headline.vala
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

public class Valadoc.Content.Headline : Block, InlineContent {
	public int level { get; set; }

	internal Headline () {
		base ();
		_level = 0;
	}

	public override void check (Tree api_root, DocumentedElement? container, ErrorReporter reporter) {
		// TODO report error if level == 0 ?

		// Check inline content
		base.check (api_root, container, reporter);
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_headline (this);
	}
}
