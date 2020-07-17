/* methodbindingtype.vala
 *
 * Copyright (C) 2011 Florian Brosch
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
 * 	Brosch Florian <flo.brosch@gmail.com>
 */


public enum Valadoc.MethodBindingType {
	UNMODIFIED,
	OVERRIDE,
	ABSTRACT,
	VIRTUAL,
	INLINE,
	STATIC,
	CLASS;

	public unowned string to_string () {
		switch (this) {
		case OVERRIDE:
			return "override";

		case ABSTRACT:
			return "abstract";

		case VIRTUAL:
			return "virtual";

		case INLINE:
			return "inline";

		case STATIC:
			return "static";

		case CLASS:
			return "class";

		case UNMODIFIED:
			return "";
		}

		assert_not_reached ();
	}
}
