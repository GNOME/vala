/* embedded.vala
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


public class Valadoc.Content.Embedded : ContentElement, Inline, StyleAttributes {
	public string url { get; set; }
	public string? caption { get; set; }

	public HorizontalAlign? horizontal_align { get; set; }
	public VerticalAlign? vertical_align { get; set; }
	public string? style { get; set; }
	public Api.Package package;

	private ResourceLocator _locator;

	internal Embedded () {
		base ();
	}

	public override void configure (Settings settings, ResourceLocator locator) {
		_locator = locator;
	}

	public override void check (Api.Tree api_root, Api.Node container, ErrorReporter reporter, Settings settings) {
		if (!FileUtils.test (url, FileTest.EXISTS | FileTest.IS_REGULAR)) {
			reporter.simple_error ("%s does not exist".printf (url));
		} else {
			package = container.package;
		}
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_embedded (this);
	}
}
