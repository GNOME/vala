/* contentelement.vala
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


public abstract class Valadoc.Content.ContentElement : Object {
	public ContentElement parent { get; internal set; }

	public abstract ContentElement copy (ContentElement? new_parent = null);


	public virtual void configure (Settings settings, ResourceLocator locator) {
	}

	public abstract void check (Api.Tree api_root, Api.Node container, string file_path,
								ErrorReporter reporter, Settings settings);

	public abstract void accept (ContentVisitor visitor);

	public abstract bool is_empty ();

	public virtual void accept_children (ContentVisitor visitor) {
	}
}

