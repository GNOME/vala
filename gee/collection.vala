/* collection.vala
 *
 * Copyright (C) 2007  Jürg Billeter
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
 * Serves as the base interface for implementing collection classes. Defines
 * size, iteration, and modification methods.
 */
public abstract class Vala.Collection<G> : Iterable<G> {
	/**
	 * The number of items in this collection.
	 */
	public abstract int size { get; }

	/**
	 * Specifies whether this collection is empty.
	 */
	public virtual bool is_empty { get { return size == 0; } }

	/**
	 * Determines whether this collection contains the specified item.
	 *
	 * @param item the item to locate in the collection
	 *
	 * @return     true if item is found, false otherwise
	 */
	public abstract bool contains (G item);

	/**
	 * Adds an item to this collection. Must not be called on read-only
	 * collections.
	 *
	 * @param item the item to add to the collection
	 *
	 * @return     true if the collection has been changed, false otherwise
	 */
	public abstract bool add (G item);

	/**
	 * Removes the first occurrence of an item from this collection. Must not
	 * be called on read-only collections.
	 *
	 * @param item the item to remove from the collection
	 *
	 * @return     true if the collection has been changed, false otherwise
	 */
	public abstract bool remove (G item);

	/**
	 * Removes all items from this collection. Must not be called on
	 * read-only collections.
	 */
	public abstract void clear ();

	/**
	 * Adds all items in the input collection to this collection.
	 *
	 * @param collection the collection which items will be added to this
	 *                   collection.
	 *
	 * @return     ``true`` if the collection has been changed, ``false`` otherwise
	 */
	public virtual bool add_all (Collection<G> collection) {
		bool changed = false;
		for (Iterator<G> iter = collection.iterator (); iter.next ();) {
			G item = iter.get ();
			if (!contains (item)) {
				add (item);
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
			return (G[]) to_int64_array ((Collection<int64?>) this);
		} else if (t == typeof (uint64)) {
			return (G[]) to_uint64_array ((Collection<uint64?>) this);
		} else if (t == typeof (long)) {
			return (G[]) to_long_array ((Collection<long>) this);
		} else if (t == typeof (ulong)) {
			return (G[]) to_ulong_array ((Collection<ulong>) this);
		} else if (t == typeof (float)) {
			return (G[]) to_float_array ((Collection<float?>) this);
		} else if (t == typeof (double)) {
			return (G[]) to_double_array ((Collection<double?>) this);
		} else if (t.is_enum () || t.is_flags ()) {
			return (G[]) to_int_array ((Collection<int>) this);
		} else {
			G[] array = new G[size];
			int index = 0;
			foreach (G element in this) {
				array[index++] = (owned)element;
			}
			return array;
		}
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
}

