/* functions.vala
 *
 * Copyright (C) 2009  Didier Villevalois, Maciej Piechotka
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
 * 	Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
 * 	Maciej Piechotka <uzytkownik2@gmail.com>
 */

using GLib;

namespace Vala {

	/**
	 * Helpers for equal, hash and compare functions.
	 *
	 * With those functions, you can retrieve the equal, hash and compare
	 * functions that best match your element, key or value types. Supported
	 * types are (non-boxed) primitive, string and ``Object`` types.
	 *
	 * A special care is taken for classes inheriting from the
	 * {@link Comparable} interface. For such types, an appropriate compare
	 * function is returned that calls {@link Comparable.compare_to}.
	 *
	 */
	namespace Functions {

		/**
		 * Get a equality testing function for a given type.
		 *
		 * @param t the type which to get an equality testing function for.
		 *
		 * @return the equality testing function corresponding to the given type.
		 */
		public static EqualDataFunc get_equal_func_for (Type t) {
			if (t == typeof (string)) {
				return (a, b) => {
					if (a == b)
						return true;
					else if (a == null || b == null)
						return false;
					else
						return str_equal ((string) a, (string) b);
				};
			} else if (t.is_a (typeof (Hashable))) {
				return (a, b) => {
					if (a == b)
						return true;
					else if (a == null || b == null)
						return false;
					else
						return ((Hashable<Hashable>) a).equal_to ((Hashable) b);
				};
			} else if (t.is_a (typeof (Comparable))) {
				return (a, b) => {
					if (a == b)
						return true;
					else if (a == null || b == null)
						return false;
					else
						return ((Comparable<Comparable>) a).compare_to ((Comparable) b) == 0;};
			} else {
				return (a, b) => {return direct_equal (a, b);};
			}
		}

		/**
		 * Get a hash function for a given type.
		 *
		 * @param t the type which to get the hash function for.
		 *
		 * @return the hash function corresponding to the given type.
		 */
		public static HashDataFunc get_hash_func_for (Type t) {
			if (t == typeof (string)) {
				return (a) => {
					if (a == null)
						return (uint)0xdeadbeef;
					else
						return str_hash ((string) a);
				};
			} else if (t.is_a (typeof (Hashable))) {
				return (a) => {
					if (a == null)
						return (uint)0xdeadbeef;
					else
						return ((Hashable) a).hash();
				};
			} else {
				return (a) => {return direct_hash (a);};
			}
		}

		/**
		 * Get a comparator function for a given type.
		 *
		 * @param t the type which to get a comparator function for.
		 *
		 * @return the comparator function corresponding to the given type.
		 */
		public static CompareDataFunc get_compare_func_for (Type t) {
			if (t == typeof (string)) {
				return (a, b) => {
					if (a == b)
						return 0;
					else if (a == null)
						return -1;
					else if (b == null)
						return 1;
					else
						return strcmp((string) a, (string) b);
				};
			} else if (t.is_a (typeof (Comparable))) {
				return (a, b) => {
					if (a == b)
						return 0;
					else if (a == null)
						return -1;
					else if (b == null)
						return 1;
					else
						return ((Comparable<Comparable>) a).compare_to ((Comparable) b);
				};
			} else {
				return (_val1, _val2) => {
					long val1 = (long)_val1, val2 = (long)_val2;
					if (val1 > val2) {
						return 1;
					} else if (val1 == val2) {
						return 0;
					} else {
						return -1;
					}
				};
			}
		}
	}
}
