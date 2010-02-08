/* htmlrenderer.vala
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

using GLib;
using Valadoc.Content;
using Valadoc.Html;

public class Valadoc.ValadocOrg.HtmlRenderer : Html.HtmlRenderer {
	public HtmlRenderer (BasicDoclet doclet) {
		base (doclet);
	}

	public override void visit_embedded (Embedded element) {
		var caption = element.caption;

		var absolute_path = Path.build_filename (_doclet.settings.path, element.package.name, "img", Path.get_basename (element.url));
		var relative_path = Path.build_filename ("/doc", element.package.name, "img", Path.get_basename (element.url));

		copy_file (element.url, absolute_path);

		writer.image (relative_path, (caption == null || caption == "") ? "" : caption);
	}
}

