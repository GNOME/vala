/* hashmultimap.vala
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
 * Hash table implementation of the {@link MultiMap} interface.
 */
public class Vala.HashMultiMap<K,V> : AbstractMultiMap<K,V> {
	public HashDataFunc<K> key_hash_func {
		get { return ((HashMap<K, Set<V>>) _storage_map).key_hash_func; }
	}

	public EqualDataFunc<K> key_equal_func {
		get { return ((HashMap<K, Set<V>>) _storage_map).key_equal_func; }
	}

	[CCode (notify = false)]
	public HashDataFunc<V> value_hash_func {
		private set {}
		get {
			return _value_hash_func.func;
		}
	}

	[CCode (notify = false)]
	public EqualDataFunc<V> value_equal_func {
		private set {}
		get {
			return _value_equal_func.func;
		}
	}

	/**
	 * Constructs a new, empty hash multimap.
	 *
	 * If not provided, the functions parameters are requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param key_hash_func an optional key hash function
	 * @param key_equal_func an optional key equality testing function
	 * @param value_hash_func an optional value hash function
	 * @param value_equal_func an optional value equality testing function
	 */
	public HashMultiMap (owned HashDataFunc<K>? key_hash_func = null, owned EqualDataFunc<K>? key_equal_func = null,
	                     owned HashDataFunc<V>? value_hash_func = null, owned EqualDataFunc<V>? value_equal_func = null) {
		base (new HashMap<K, Set<V>> ((owned)key_hash_func, (owned)key_equal_func, Functions.get_equal_func_for (typeof (Set))));
		if (value_hash_func == null) {
			value_hash_func = Functions.get_hash_func_for (typeof (V));
		}
		if (value_equal_func == null) {
			value_equal_func = Functions.get_equal_func_for (typeof (V));
		}
		_value_hash_func = new Functions.HashDataFuncClosure<V> ((owned)value_hash_func);
		_value_equal_func = new Functions.EqualDataFuncClosure<V> ((owned)value_equal_func);
	}

	protected override Collection<V> create_value_storage () {
		return new HashSet<V>.with_closures (_value_hash_func, _value_equal_func);
	}

	protected override MultiSet<K> create_multi_key_set () {
		return new HashMultiSet<K>.with_closures (((HashMap<K, Set<V>>) _storage_map).get_key_hash_func_closure (), ((HashMap<K, Set<V>>) _storage_map).get_key_equal_func_closure ());
	}

	protected override EqualDataFunc<V> get_value_equal_func () {
		return _value_equal_func.clone_func ();
	}

	private Functions.HashDataFuncClosure<V> _value_hash_func;
	private Functions.EqualDataFuncClosure<V> _value_equal_func;
}
