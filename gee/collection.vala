/* collection.vala
 *
 * Copyright (C) 2007-2009  Jürg Billeter
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

/**
 * A generic collection of objects.
 */
[GenericAccessors]
public interface Vala.Collection<G> : Iterable<G> {
	/**
	 * The number of items in this collection.
	 */
	[CCode (ordering = 9)]
	public abstract int size { get; }

	/**
	 * Specifies whether this collection is empty.
	 */
	[CCode (ordering = 10)]
	public virtual bool is_empty { get { return size == 0; } }

	/**
	 * Specifies whether this collection can change - i.e. wheather {@link add},
	 * {@link remove} etc. are legal operations.
	 */
	[CCode (ordering = 11)]
	public abstract bool read_only { get; }

	/**
	 * Determines whether this collection contains the specified item.
	 *
	 * @param item the item to locate in the collection
	 *
	 * @return     ``true`` if item is found, ``false`` otherwise
	 */
	[CCode (ordering = 0)]
	public abstract bool contains (G item);

	/**
	 * Adds an item to this collection. Must not be called on read-only
	 * collections.
	 *
	 * @param item the item to add to the collection
	 *
	 * @return     ``true`` if the collection has been changed, ``false`` otherwise
	 */
	[CCode (ordering = 1)]
	public abstract bool add (G item);

	/**
	 * Removes the first occurence of an item from this collection. Must not
	 * be called on read-only collections.
	 *
	 * @param item the item to remove from the collection
	 *
	 * @return     ``true`` if the collection has been changed, ``false`` otherwise
	 */
	[CCode (ordering = 2)]
	public abstract bool remove (G item);

	/**
	 * Removes all items from this collection. Must not be called on
	 * read-only collections.
	 */
	[CCode (ordering = 3)]
	public abstract void clear ();

	/**
	 * Adds all items in the input collection to this collection.
	 *
	 * @param collection the collection which items will be added to this
	 *                   collection.
	 *
	 * @return     ``true`` if the collection has been changed, ``false`` otherwise
	 */
	[CCode (ordering = 4)]
	public virtual bool add_all (Collection<G> collection) {
		return collection.fold<bool> ((item, changed) => changed | add (item), false);
	}

	/**
	 * Returns ``true`` it this collection contains all items as the input
	 * collection.
	 *
	 * @param collection the collection which items will be compared with
	 *                   this collection.
	 *
	 * @return     ``true`` if the collection has been changed, ``false`` otherwise
	 */
	[CCode (ordering = 5)]
	public virtual bool contains_all (Collection<G> collection) {
		return collection.foreach ((item) => contains (item));
	}

	/**
	 * Removes the subset of items in this collection corresponding to the
	 * elments in the input collection. If there is several occurrences of
	 * the same value in this collection they are decremented of the number
	 * of occurrences in the input collection.
	 *
	 * @param collection the collection which items will be compared with
	 *                   this collection.
	 *
	 * @return     ``true`` if the collection has been changed, ``false`` otherwise
	 */
	[CCode (ordering = 6)]
	public virtual bool remove_all (Collection<G> collection) {
		return collection.fold<bool> ((item, changed) => changed | remove (item), false);
	}

	/**
	 * Removes all items in this collection that are not contained in the input
	 * collection. In other words all common items of both collections are
	 * retained in this collection.
	 *
	 * @param collection the collection which items will be compared with
	 *                   this collection.
	 *
	 * @return     ``true`` if the collection has been changed, ``false`` otherwise
	 */
	[CCode (ordering = 7)]
	public virtual bool retain_all (Collection<G> collection) {
		bool changed = false;
		for (Iterator<G> iter = iterator(); iter.next ();) {
			G item = iter.get ();
			if (!collection.contains (item)) {
				iter.remove ();
				changed = true;
			}
		}
		return changed;
	}

	/**
	 * Returns an array containing all of items from this collection.
	 *
	 * @return an array containing all of items from this collection
	 */
	[CCode (ordering = 8)]
	public virtual G[] to_array () {
		var t = typeof (G);
		if (t == typeof (bool)) {
			return (G[]) to_bool_array ((Collection<bool>) this);
		} else if (t == typeof (char)) {
			return (G[]) to_char_array ((Collection<char>) this);
		} else if (t == typeof (uchar)) {
			return (G[]) to_uchar_array ((Collection<uchar>) this);
		} else if (t == typeof (int)) {
			return (G[]) to_int_array ((Collection<int>) this);
		} else if (t == typeof (uint)) {
			return (G[]) to_uint_array ((Collection<uint>) this);
		} else if (t == typeof (int64)) {
			return (G[]) to_int64_array ((Collection<int64>) this);
		} else if (t == typeof (uint64)) {
			return (G[]) to_uint64_array ((Collection<uint64>) this);
		} else if (t == typeof (long)) {
			return (G[]) to_long_array ((Collection<long>) this);
		} else if (t == typeof (ulong)) {
			return (G[]) to_ulong_array ((Collection<ulong>) this);
		} else if (t == typeof (float)) {
			return (G[]) to_float_array ((Collection<float>) this);
		} else if (t == typeof (double)) {
			return (G[]) to_double_array ((Collection<double>) this);
		} else {
			G[] array = new G[size];
			int index = 0;
			foreach (G element in this) {
				array[index++] = (owned)element;
			}
			return array;
		}
	}

	/**
	 * Adds all items in the input array to this collection.
	 *
	 * @param array the array which items will be added to this
	 *              collection.
	 *
	 * @return     ``true`` if the collection has been changed, ``false`` otherwise
	 */
	[CCode (ordering = 13)]
	public virtual bool add_all_array (G[] array) {
		var t = typeof (G);
		if (t == typeof (bool)) {
			return add_all_bool_array ((Collection<bool>) this, (bool [])array);
		} else if (t == typeof (char)) {
			return add_all_char_array ((Collection<char>) this, (char [])array);
		} else if (t == typeof (uchar)) {
			return add_all_uchar_array ((Collection<uchar>) this, (uchar [])array);
		} else if (t == typeof (int)) {
			return add_all_int_array ((Collection<int>) this, (int [])array);
		} else if (t == typeof (uint)) {
			return add_all_uint_array ((Collection<uint>) this, (uint [])array);
		} else if (t == typeof (int64)) {
			return add_all_int64_array ((Collection<int64?>) this, (int64? [])array);
		} else if (t == typeof (uint64)) {
			return add_all_uint64_array ((Collection<uint64?>) this, (uint64? [])array);
		} else if (t == typeof (long)) {
			return add_all_long_array ((Collection<long>) this, (long [])array);
		} else if (t == typeof (ulong)) {
			return add_all_ulong_array ((Collection<ulong>) this, (ulong [])array);
		} else if (t == typeof (float)) {
			return add_all_float_array ((Collection<float>) this, (float? [])array);
		} else if (t == typeof (double)) {
			return add_all_double_array ((Collection<double>) this, (double? [])array);
		} else {
			bool changed = false;
			foreach (unowned G item in array) {
				changed |= add (item);
			}
			return changed;
		}
	}

	/**
	 * Returns ``true`` it this collection contains all items as the input
	 * array.
	 *
	 * @param array the array which items will be compared with
	 *              this collection.
	 *
	 * @return     ``true`` if the collection has been changed, ``false`` otherwise
	 */
	[CCode (ordering = 14)]
	public virtual bool contains_all_array (G[] array) {
		var t = typeof (G);
		if (t == typeof (bool)) {
			return contains_all_bool_array ((Collection<bool>) this, (bool [])array);
		} else if (t == typeof (char)) {
			return contains_all_char_array ((Collection<char>) this, (char [])array);
		} else if (t == typeof (uchar)) {
			return contains_all_uchar_array ((Collection<uchar>) this, (uchar [])array);
		} else if (t == typeof (int)) {
			return contains_all_int_array ((Collection<int>) this, (int [])array);
		} else if (t == typeof (uint)) {
			return contains_all_uint_array ((Collection<uint>) this, (uint [])array);
		} else if (t == typeof (int64)) {
			return contains_all_int64_array ((Collection<int64?>) this, (int64? [])array);
		} else if (t == typeof (uint64)) {
			return contains_all_uint64_array ((Collection<uint64?>) this, (uint64? [])array);
		} else if (t == typeof (long)) {
			return contains_all_long_array ((Collection<long>) this, (long [])array);
		} else if (t == typeof (ulong)) {
			return contains_all_ulong_array ((Collection<ulong>) this, (ulong [])array);
		} else if (t == typeof (float)) {
			return contains_all_float_array ((Collection<float>) this, (float? [])array);
		} else if (t == typeof (double)) {
			return contains_all_double_array ((Collection<double>) this, (double? [])array);
		} else {
			foreach (unowned G item in array) {
				if (!contains (item)) {
					return false;
				}
			}
			return true;
		}
	}

	/**
	 * Removes the subset of items in this collection corresponding to the
	 * elments in the input array. If there is several occurrences of
	 * the same value in this collection they are decremented of the number
	 * of occurrences in the input array.
	 *
	 * @param array the array which items will be compared with
	 *              this collection.
	 *
	 * @return     ``true`` if the collection has been changed, ``false`` otherwise
	 */
	[CCode (ordering = 15)]
	public virtual bool remove_all_array (G[] array) {
		var t = typeof (G);
		if (t == typeof (bool)) {
			return remove_all_bool_array ((Collection<bool>) this, (bool [])array);
		} else if (t == typeof (char)) {
			return remove_all_char_array ((Collection<char>) this, (char [])array);
		} else if (t == typeof (uchar)) {
			return remove_all_uchar_array ((Collection<uchar>) this, (uchar [])array);
		} else if (t == typeof (int)) {
			return remove_all_int_array ((Collection<int>) this, (int [])array);
		} else if (t == typeof (uint)) {
			return remove_all_uint_array ((Collection<uint>) this, (uint [])array);
		} else if (t == typeof (int64)) {
			return remove_all_int64_array ((Collection<int64?>) this, (int64? [])array);
		} else if (t == typeof (uint64)) {
			return remove_all_uint64_array ((Collection<uint64?>) this, (uint64? [])array);
		} else if (t == typeof (long)) {
			return remove_all_long_array ((Collection<long>) this, (long [])array);
		} else if (t == typeof (ulong)) {
			return remove_all_ulong_array ((Collection<ulong>) this, (ulong [])array);
		} else if (t == typeof (float)) {
			return remove_all_float_array ((Collection<float>) this, (float? [])array);
		} else if (t == typeof (double)) {
			return remove_all_double_array ((Collection<double>) this, (double? [])array);
		} else {
			bool changed = false;
			foreach (unowned G item in array) {
				changed |= remove (item);
			}
			return changed;
		}
	}

	[CCode (ordering = 16)]
	public virtual bool add_all_iterator (Iterator<G> iter) {
		bool changed = false;
		iter.foreach ((val) => {
			changed |= add (val);
			return true;
		});
		return changed;
	}

	[CCode (ordering = 17)]
	public virtual bool contains_all_iterator (Iterator<G> iter) {
		return iter.foreach ((val) => {return contains (val);});
	}

	[CCode (ordering = 18)]
	public virtual bool remove_all_iterator (Iterator<G> iter) {
		bool changed = false;
		return iter.foreach ((val) => {
			changed |= remove (val);
			return true;
		});
	}

	/**
	 * The read-only view of this collection.
	 */
	[CCode (ordering = 12)]
	public abstract Collection<G> read_only_view { owned get; }

	/**
	 * Returns an immutable empty collection.
	 *
	 * @return an immutable empty collection
	 */
	public static Collection<G> empty<G> () {
		return new HashSet<G> ().read_only_view;
	}

	private static bool[] to_bool_array (Collection<bool> coll) {
		bool[] array = new bool[coll.size];
		int index = 0;
		foreach (bool element in coll) {
			array[index++] = element;
		}
		return array;
	}

	private static char[] to_char_array (Collection<char> coll) {
		char[] array = new char[coll.size];
		int index = 0;
		foreach (char element in coll) {
			array[index++] = element;
		}
		return array;
	}

	private static uchar[] to_uchar_array (Collection<uchar> coll) {
		uchar[] array = new uchar[coll.size];
		int index = 0;
		foreach (uchar element in coll) {
			array[index++] = element;
		}
		return array;
	}

	private static int[] to_int_array (Collection<int> coll) {
		int[] array = new int[coll.size];
		int index = 0;
		foreach (int element in coll) {
			array[index++] = element;
		}
		return array;
	}

	private static uint[] to_uint_array (Collection<uint> coll) {
		uint[] array = new uint[coll.size];
		int index = 0;
		foreach (uint element in coll) {
			array[index++] = element;
		}
		return array;
	}

	private static int64?[] to_int64_array (Collection<int64?> coll) {
		int64?[] array = new int64?[coll.size];
		int index = 0;
		foreach (int64? element in coll) {
			array[index++] = (owned)element;
		}
		return array;
	}

	private static uint64?[] to_uint64_array (Collection<uint64?> coll) {
		uint64?[] array = new uint64?[coll.size];
		int index = 0;
		foreach (uint64? element in coll) {
			array[index++] = (owned)element;
		}
		return array;
	}

	private static long[] to_long_array (Collection<long> coll) {
		long[] array = new long[coll.size];
		int index = 0;
		foreach (long element in coll) {
			array[index++] = element;
		}
		return array;
	}

	private static ulong[] to_ulong_array (Collection<ulong> coll) {
		ulong[] array = new ulong[coll.size];
		int index = 0;
		foreach (ulong element in coll) {
			array[index++] = element;
		}
		return array;
	}

	private static float?[] to_float_array (Collection<float?> coll) {
		float?[] array = new float?[coll.size];
		int index = 0;
		foreach (float? element in coll) {
			array[index++] = (owned)element;
		}
		return array;
	}

	private static double?[] to_double_array (Collection<double?> coll) {
		double?[] array = new double?[coll.size];
		int index = 0;
		foreach (double? element in coll) {
			array[index++] = (owned)element;
		}
		return array;
	}

	private static bool add_all_bool_array (Collection<bool> coll, bool[] arr) {
		bool changed = false;
		foreach (bool el in arr) {
			changed |= coll.add (el);
		}
		return changed;
	}

	private static bool add_all_char_array (Collection<char> coll, char[] arr) {
		bool changed = false;
		foreach (char el in arr) {
			changed |= coll.add (el);
		}
		return changed;
	}

	private static bool add_all_uchar_array (Collection<uchar> coll, uchar[] arr) {
		bool changed = false;
		foreach (uchar el in arr) {
			changed |= coll.add (el);
		}
		return changed;
	}

	private static bool add_all_int_array (Collection<int> coll, int[] arr) {
		bool changed = false;
		foreach (int el in arr) {
			changed |= coll.add (el);
		}
		return changed;
	}

	private static bool add_all_uint_array (Collection<uint> coll, uint[] arr) {
		bool changed = false;
		foreach (uint el in arr) {
			changed |= coll.add (el);
		}
		return changed;
	}

	private static bool add_all_int64_array (Collection<int64?> coll, int64?[] arr) {
		bool changed = false;
		foreach (unowned int64? el in arr) {
			changed |= coll.add (el);
		}
		return changed;
	}

	private static bool add_all_uint64_array (Collection<uint64?> coll, uint64?[] arr) {
		bool changed = false;
		foreach (unowned uint64? el in arr) {
			changed |= coll.add (el);
		}
		return changed;
	}

	private static bool add_all_long_array (Collection<long> coll, long[] arr) {
		bool changed = false;
		foreach (long el in arr) {
			changed |= coll.add (el);
		}
		return changed;
	}

	private static bool add_all_ulong_array (Collection<ulong> coll, ulong[] arr) {
		bool changed = false;
		foreach (ulong el in arr) {
			changed |= coll.add (el);
		}
		return changed;
	}

	private static bool add_all_float_array (Collection<float?> coll, float?[] arr) {
		bool changed = false;
		foreach (unowned float? el in arr) {
			changed |= coll.add (el);
		}
		return changed;
	}

	private static bool add_all_double_array (Collection<double?> coll, double?[] arr) {
		bool changed = false;
		foreach (unowned double? el in arr) {
			changed |= coll.add (el);
		}
		return changed;
	}

	private static bool contains_all_bool_array (Collection<bool> coll, bool[] arr) {
		foreach (bool el in arr) {
			if (!coll.contains (el)) {
				return false;
			}
		}
		return true;
	}

	private static bool contains_all_char_array (Collection<char> coll, char[] arr) {
		foreach (char el in arr) {
			if (!coll.contains (el)) {
				return false;
			}
		}
		return true;
	}

	private static bool contains_all_uchar_array (Collection<uchar> coll, uchar[] arr) {
		foreach (uchar el in arr) {
			if (!coll.contains (el)) {
				return false;
			}
		}
		return true;
	}

	private static bool contains_all_int_array (Collection<int> coll, int[] arr) {
		foreach (int el in arr) {
			if (!coll.contains (el)) {
				return false;
			}
		}
		return true;
	}

	private static bool contains_all_uint_array (Collection<uint> coll, uint[] arr) {
		foreach (uint el in arr) {
			if (!coll.contains (el)) {
				return false;
			}
		}
		return true;
	}

	private static bool contains_all_int64_array (Collection<int64?> coll, int64?[] arr) {
		foreach (unowned int64? el in arr) {
			if (!coll.contains (el)) {
				return false;
			}
		}
		return true;
	}

	private static bool contains_all_uint64_array (Collection<uint64?> coll, uint64?[] arr) {
		foreach (unowned uint64? el in arr) {
			if (!coll.contains (el)) {
				return false;
			}
		}
		return true;
	}

	private static bool contains_all_long_array (Collection<long> coll, long[] arr) {
		foreach (long el in arr) {
			if (!coll.contains (el)) {
				return false;
			}
		}
		return true;
	}

	private static bool contains_all_ulong_array (Collection<ulong> coll, ulong[] arr) {
		foreach (ulong el in arr) {
			if (!coll.contains (el)) {
				return false;
			}
		}
		return true;
	}

	private static bool contains_all_float_array (Collection<float?> coll, float?[] arr) {
		foreach (unowned float? el in arr) {
			if (!coll.contains (el)) {
				return false;
			}
		}
		return true;
	}

	private static bool contains_all_double_array (Collection<double?> coll, double?[] arr) {
		foreach (unowned double? el in arr) {
			if (!coll.contains (el)) {
				return false;
			}
		}
		return true;
	}

	private static bool remove_all_bool_array (Collection<bool> coll, bool[] arr) {
		bool changed = false;
		foreach (bool el in arr) {
			changed |= coll.remove (el);
		}
		return changed;
	}

	private static bool remove_all_char_array (Collection<char> coll, char[] arr) {
		bool changed = false;
		foreach (char el in arr) {
			changed |= coll.remove (el);
		}
		return changed;
	}

	private static bool remove_all_uchar_array (Collection<uchar> coll, uchar[] arr) {
		bool changed = false;
		foreach (uchar el in arr) {
			changed |= coll.remove (el);
		}
		return changed;
	}

	private static bool remove_all_int_array (Collection<int> coll, int[] arr) {
		bool changed = false;
		foreach (int el in arr) {
			changed |= coll.remove (el);
		}
		return changed;
	}

	private static bool remove_all_uint_array (Collection<uint> coll, uint[] arr) {
		bool changed = false;
		foreach (uint el in arr) {
			changed |= coll.remove (el);
		}
		return changed;
	}

	private static bool remove_all_int64_array (Collection<int64?> coll, int64?[] arr) {
		bool changed = false;
		foreach (unowned int64? el in arr) {
			changed |= coll.remove (el);
		}
		return changed;
	}

	private static bool remove_all_uint64_array (Collection<uint64?> coll, uint64?[] arr) {
		bool changed = false;
		foreach (unowned uint64? el in arr) {
			changed |= coll.remove (el);
		}
		return changed;
	}

	private static bool remove_all_long_array (Collection<long> coll, long[] arr) {
		bool changed = false;
		foreach (long el in arr) {
			changed |= coll.remove (el);
		}
		return changed;
	}

	private static bool remove_all_ulong_array (Collection<ulong> coll, ulong[] arr) {
		bool changed = false;
		foreach (ulong el in arr) {
			changed |= coll.remove (el);
		}
		return changed;
	}

	private static bool remove_all_float_array (Collection<float?> coll, float?[] arr) {
		bool changed = false;
		foreach (unowned float? el in arr) {
			changed |= coll.remove (el);
		}
		return changed;
	}

	private static bool remove_all_double_array (Collection<double?> coll, double?[] arr) {
		bool changed = false;
		foreach (unowned double? el in arr) {
			changed |= coll.remove (el);
		}
		return changed;
	}
}

