/* tagletinit.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch
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
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


namespace Valadoc.Taglets {
	public void init (ModuleLoader loader) {
		loader.register_taglet ("see", typeof (Valadoc.Taglets.See));
		loader.register_taglet ("since", typeof (Valadoc.Taglets.Since));
		loader.register_taglet ("link", typeof (Valadoc.Taglets.Link));
		loader.register_taglet ("throws", typeof (Valadoc.Taglets.Throws));
		loader.register_taglet ("return", typeof (Valadoc.Taglets.Return));
		loader.register_taglet ("param", typeof (Valadoc.Taglets.Param));
		loader.register_taglet ("deprecated", typeof (Valadoc.Taglets.Deprecated));
		loader.register_taglet ("inheritDoc", typeof (Valadoc.Taglets.InheritDoc));
	}
}
