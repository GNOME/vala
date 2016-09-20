/* treemultimap.vala
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
 * Left-leaning red-black tree implementation of the {@link MultiMap}
 * interface.
 */
public class Vala.TreeMultiMap<K,V> : AbstractMultiMap<K,V> {
	public CompareDataFunc<K> key_compare_func {
		get { return ((TreeMap<K, Set<V>>) _storage_map).key_compare_func; }
	}

	[CCode (notify = false)]
	public CompareDataFunc<V> value_compare_func {
		private set {}
		get {
			return _value_compare_func.func;
		}
	}

	/**
	 * Constructs a new, empty tree multimap.
	 *
	 * If not provided, the functions parameters are requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param key_compare_func an optional key comparator function
	 * @param value_compare_func an optional value comparator function
	 */
	public TreeMultiMap (owned CompareDataFunc<K>? key_compare_func = null, owned CompareDataFunc<V>? value_compare_func = null) {
		base (new TreeMap<K, Set<V>> ((owned)key_compare_func, Functions.get_equal_func_for (typeof (Set))));
		if (value_compare_func == null) {
			value_compare_func = Functions.get_compare_func_for (typeof (V));
		}
		_value_compare_func = new Functions.CompareDataFuncClosure<V> ((owned)value_compare_func);
	}

	protected override Collection<V> create_value_storage () {
		return new TreeSet<V>.with_closures (_value_compare_func);
	}

	protected override MultiSet<K> create_multi_key_set () {
		return new TreeMultiSet<K>.with_closures (((TreeMap<K, Set<V>>) _storage_map).get_key_compare_func_closure ());
	}

	protected override EqualDataFunc<V> get_value_equal_func () {
		return Functions.get_equal_func_for (typeof (V));
	}

	private Functions.CompareDataFuncClosure<V> _value_compare_func;
}
