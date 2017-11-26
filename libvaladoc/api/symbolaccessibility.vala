/* SymbolAccessibility.vala
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
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


/**
 * The access modifier
 */
public enum Valadoc.Api.SymbolAccessibility {
	PROTECTED,
	INTERNAL,
	PRIVATE,
	PUBLIC;

	public unowned string to_string () {
		switch (this) {
		case SymbolAccessibility.PROTECTED:
			return "protected";

		case SymbolAccessibility.INTERNAL:
			return "internal";

		case SymbolAccessibility.PRIVATE:
			return "private";

		case SymbolAccessibility.PUBLIC:
			return "public";

		default:
			assert_not_reached ();
		}
	}
}
