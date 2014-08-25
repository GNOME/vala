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
	public abstract int size { get; }

	/**
	 * Specifies whether this collection is empty.
	 */
	public virtual bool is_empty { get { return size == 0; } }

	/**
	 * Specifies whether this collection can change - i.e. wheather {@link add},
	 * {@link remove} etc. are legal operations.
	 */
	public abstract bool read_only { get; }

	/**
	 * Determines whether this collection contains the specified item.
	 *
	 * @param item the item to locate in the collection
	 *
	 * @return     ``true`` if item is found, ``false`` otherwise
	 */
	public abstract bool contains (G item);

	/**
	 * Adds an item to this collection. Must not be called on read-only
	 * collections.
	 *
	 * @param item the item to add to the collection
	 *
	 * @return     ``true`` if the collection has been changed, ``false`` otherwise
	 */
	public abstract bool add (G item);

	/**
	 * Removes the first occurence of an item from this collection. Must not
	 * be called on read-only collections.
	 *
	 * @param item the item to remove from the collection
	 *
	 * @return     ``true`` if the collection has been changed, ``false`` otherwise
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
				array[index++] = element;
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

	private static int64[] to_int64_array (Collection<int64?> coll) {
		int64[] array = new int64[coll.size];
		int index = 0;
		foreach (int64 element in coll) {
			array[index++] = element;
		}
		return array;
	}

	private static uint64[] to_uint64_array (Collection<uint64?> coll) {
		uint64[] array = new uint64[coll.size];
		int index = 0;
		foreach (uint64 element in coll) {
			array[index++] = element;
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
		foreach (float element in coll) {
			array[index++] = element;
		}
		return array;
	}

	private static double?[] to_double_array (Collection<double?> coll) {
		double?[] array = new double?[coll.size];
		int index = 0;
		foreach (double element in coll) {
			array[index++] = element;
		}
		return array;
	}

	/**
	 * The read-only view of this collection.
	 */
	public abstract Collection<G> read_only_view { owned get; }

	/**
	 * Returns an immutable empty collection.
	 *
	 * @return an immutable empty collection
	 */
	public static Collection<G> empty<G> () {
		return new HashSet<G> ().read_only_view;
	}
}

