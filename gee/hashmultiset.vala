/* hashmultiset.vala
 *
 * Copyright (C) 2009  Ali Sabil
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
 * 	Ali Sabil <ali.sabil@gmail.com>
 */

/**
 * Hash table implementation of the {@link MultiSet} interface.
 */
public class Vala.HashMultiSet<G> : AbstractMultiSet<G> {
	public HashDataFunc<G> hash_func {
		get { return ((HashMap<G, int>) _storage_map).key_hash_func; }
	}

	public EqualDataFunc<G> equal_func {
		get { return ((HashMap<G, int>) _storage_map).key_equal_func; }
	}

	/**
	 * Constructs a new, empty hash multi set.
	 *
	 * If not provided, the functions parameters are requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param hash_func an optional element hash function
	 * @param equal_func an optional element equality testing function
	 */
	public HashMultiSet (HashDataFunc<G>? hash_func = null, EqualDataFunc<G>? equal_func = null) {
		base (new HashMap<G, int> (hash_func, equal_func));
	}
}
