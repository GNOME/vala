/* comparable.vala
 *
 * Copyright (C) 2009  Didier Villevalois
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

/**
 * This interface defines a total ordering among instances of each class
 * implementing it.
 *
 * In other words:
 *
 *   * It's irreflexive: For all `a` it holds that `a.compare_to(a) == 0`
 *   * It's transitive: For all `a`, `b` and `c` if `a.compare_to(b) < 0` and
 *     `b.compare_to(c) < 0` then `a.compare_to(c) < 0`.
 *   * It's trichotomous: For all `a` and `b` it holds that
 *     `a.compare_to(b) = -b.compare_to(a)`.
 *
 * Note: The relationship must be immutable. In other words if at one point of
 *   program `a.compare_to(b)` had certain value then call `a.compare_to(b)`
 *   //must always// return the original value until end of `a` and `b` lifetime.
 *
 * @see Hashable
 */
public interface Vala.Comparable<G> : Object {
	/**
	 * Compares this object with the specifed object.
	 *
	 * @return a negative integer, zero, or a positive integer as this object
	 *         is less than, equal to, or greater than the specified object
	 */
	public abstract int compare_to (G object);
}
