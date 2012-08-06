/* embedded.vala
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

	public override void check (Api.Tree api_root, Api.Node container, string file_path, ErrorReporter reporter, Settings settings) {
		// search relative to our file
		if (!Path.is_absolute (url)) {
			string relative_to_file = Path.build_path (Path.DIR_SEPARATOR_S, Path.get_dirname (file_path), url);
			if (FileUtils.test (relative_to_file, FileTest.EXISTS | FileTest.IS_REGULAR)) {
				url = (owned) relative_to_file;
				package = container.package;
				return ;
			}
		}

		// search relative to the current directory / absoulte path
		if (!FileUtils.test (url, FileTest.EXISTS | FileTest.IS_REGULAR)) {
			string node_segment = (container is Api.Package)? "" : container.get_full_name () + ": ";
			reporter.simple_error ("%s: %s{{: error: %s does not exist", file_path, node_segment, url);
		} else {
			package = container.package;
		}
	}

	public override void accept (ContentVisitor visitor) {
		visitor.visit_embedded (this);
	}

	public override bool is_empty () {
		return false;
	}
}
