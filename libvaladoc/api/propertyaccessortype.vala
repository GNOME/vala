/* propertyaccessor.vala
 *
 * Copyright (C) 2011  Florian Brosch
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


public enum Valadoc.Api.PropertyAccessorType {
	CONSTRUCT = 1 << 0,
	SET = 1 << 1,
	GET = 1 << 2;

	public unowned string to_string () {
		if ((this & PropertyAccessorType.CONSTRUCT) != 0) {
			if ((this & PropertyAccessorType.SET) != 0) {
				return "construct set";
			}
			return "construct";
		} else if ((this & PropertyAccessorType.SET) != 0) {
			return "set";
		} else if ((this & PropertyAccessorType.GET) != 0) {
			return "get";
		}

		assert_not_reached ();
	}
}
