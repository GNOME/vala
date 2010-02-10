/* blockcontent.vala
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

public abstract class Valadoc.Content.BlockContent : ContentElement {
	public Gee.List<Block> content { get { return _content; } }

	private Gee.List<Block> _content;

	internal BlockContent () {
		_content = new ArrayList<Block> ();
	}

	public override void configure (Settings settings, ResourceLocator locator) {
	}

	public override void check (Api.Tree api_root, Api.Node container, ErrorReporter reporter, Settings settings) {
		foreach (Block element in _content) {
			element.check (api_root, container, reporter, settings);
		}
	}

	public override void accept_children (ContentVisitor visitor) {
		foreach (Block element in _content) {
			element.accept (visitor);
		}
	}
}

