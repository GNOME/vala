/* readonlyset.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Read-only view for {@link Set} collections.
 *
 * This class decorates any class which implements the {@link Set} interface
 * by making it read only. Any method which normally modify data will throw an
 * error.
 *
 * @see Set
 */
internal class Vala.ReadOnlySet<G> : Vala.ReadOnlyCollection<G>, Set<G> {

	/**
	 * Constructs a read-only set that mirrors the content of the specified set.
	 *
	 * @param set the set to decorate.
	 */
	public ReadOnlySet (Set<G> set) {
		base (set);
	}

	public virtual new Set<G> read_only_view {
		owned get { return this; }
	}

}

