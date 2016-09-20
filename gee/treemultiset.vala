/* treemultiset.vala
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
 * Left-leaning red-black tree implementation of the {@link MultiSet}
 * interface.
 */
public class Vala.TreeMultiSet<G> : AbstractMultiSet<G> {
	public CompareDataFunc<G> compare_func {
		get { return ((TreeMap<G, int>) _storage_map).key_compare_func; }
	}

	/**
	 * Constructs a new, empty tree multi set.
	 *
	 * If not provided, the function parameter is requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param compare_func an optional element comparator function
	 */
	public TreeMultiSet (owned CompareDataFunc<G>? compare_func = null) {
		base (new TreeMap<G, int> ((owned)compare_func));
	}

	internal TreeMultiSet.with_closures (owned Functions.CompareDataFuncClosure<G> compare_func) {
		base (new TreeMap<G, int>.with_closures ((owned)compare_func, new Functions.EqualDataFuncClosure<int> (Functions.get_equal_func_for (typeof (int)))));
	}
}
