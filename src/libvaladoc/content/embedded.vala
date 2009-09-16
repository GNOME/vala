/* embedded.vala
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

public class Valadoc.Content.Embedded : ContentElement, Inline, StyleAttributes {
	public string url { get; set; }
	public string caption { get; set; }

	public HorizontalAlign? horizontal_align { get; set; }
	public VerticalAlign? vertical_align { get; set; }
	public string? style { get; set; }

	private ResourceLocator _locator;

	internal Embedded () {
		base ();
	}

	public override void configure (Settings settings, ResourceLocator locator) {
		_locator = locator;
	}

	public override void check (Tree api_root, DocumentedElement? container, ErrorReporter reporter) {
		// Check the image exists if it a local resource
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_embedded (this);
	}
}
