/* timsort.vala
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
 * A stable, adaptive, iterative mergesort that requires far fewer than n*lg(n)
 * comparisons when running on partially sorted arrays, while offering
 * performance comparable to a traditional mergesort when run on random arrays.
 * Like all proper mergesorts, this sort is stable and runs O(n*log(n)) time
 * (worst case). In the worst case, this sort requires temporary storage space
 * for n/2 object references; in the best case, it requires only a small
 * constant amount of space.
 *
 * This implementation was adapted from Tim Peters's list sort for Python,
 * which is described in detail here:
 * [[http://svn.python.org/projects/python/trunk/Objects/listsort.txt]]
 *
 * Tim's C code may be found here:
 * [[http://svn.python.org/projects/python/trunk/Objects/listobject.c]]
 *
 * The underlying techniques are described in this paper (and may have even
 * earlier origins):
 *
 *   "Optimistic Sorting and Information Theoretic Complexity"
 *   Peter McIlroy
 *   SODA (Fourth Annual ACM-SIAM Symposium on Discrete Algorithms), pp
 *   467-474, Austin, Texas, 25-27 January 1993.
 */
internal class Vala.TimSort<G> {

	public static void sort<G> (List<G> list, CompareDataFunc<G> compare) {
		if (list is ArrayList) {
			TimSort.sort_arraylist<G> ((ArrayList<G>) list, compare);
		} else {
			TimSort.sort_list<G> (list, compare);
		}
	}

	private static void sort_list<G> (List<G> list, CompareDataFunc<G> compare) {
		TimSort<G> helper = new TimSort<G> ();

		helper.list_collection = list;
		helper.array = list.to_array ();
		helper.list = helper.array;
		helper.index = 0;
		helper.size = list.size;
		helper.compare = compare;

		helper.do_sort ();

		// TODO Use a list iterator and use iter.set (item)
		list.clear ();
		foreach (G item in helper.array) {
			list.add (item);
		}
	}

	private static void sort_arraylist<G> (ArrayList<G> list, CompareDataFunc<G> compare) {
		TimSort<G> helper = new TimSort<G> ();

		helper.list_collection = list;
		helper.list = list._items;
		helper.index = 0;
		helper.size = list._size;
		helper.compare = compare;

		helper.do_sort ();
	}

	private const int MINIMUM_GALLOP = 7;

	private List<G> list_collection;
	private G[] array;
	private void** list;
	private int index;
	private int size;
	private Slice<G>[] pending;
	private int minimum_gallop;
	private unowned CompareDataFunc<G> compare;

	private void do_sort () {
		if (size < 2) {
			return;
		}

		pending = new Slice<G>[0];
		minimum_gallop = MINIMUM_GALLOP;

		Slice<G> remaining = new Slice<G> (list, index, size);
		int minimum_length = compute_minimum_run_length (remaining.length);

		while (remaining.length > 0) {
			// Get the next run
			bool descending;
			Slice<G> run = compute_longest_run (remaining, out descending);
			#if DEBUG
				message ("New run (%d, %d) %s", run.index, run.length,
				         descending ? "descending" : "ascending");
			#endif
			if (descending) {
				run.reverse ();
			}

			// Extend it to minimum_length, if needed
			if (run.length < minimum_length) {
				int sorted_count = run.length;
				run.length = int.min (minimum_length, remaining.length);
				insertion_sort (run, sorted_count);
				#if DEBUG
					message ("Extended to (%d, %d) and sorted from index %d",
					         run.index, run.length, sorted_count);
				#endif
			}

			// Move remaining after run
			remaining.shorten_start (run.length);

			// Add run to pending runs and try to merge
			pending += (owned) run;
			merge_collapse ();
		}

		assert (remaining.index == size);

		merge_force_collapse ();

		assert (pending.length == 1);
		assert (pending[0].index == 0);
		assert (pending[0].length == size);
	}

	private delegate bool LowerFunc (G left, G right);

	private inline bool lower_than (G left, G right) {
            return compare (left, right) < 0;
	}

	private inline bool lower_than_or_equal_to (G left, G right) {
            return compare (left, right) <= 0;
	}

	private int compute_minimum_run_length (int length) {
		int run_length = 0;
		while (length >= 64) {
			run_length |= length & 1;
			length >>= 1;
		}
		return length + run_length;
	}

	private Slice<G> compute_longest_run (Slice<G> a, out bool descending) {
		int run_length;
		if (a.length <= 1) {
			run_length = a.length;
			descending = false;
		} else {
			run_length = 2;
			if (lower_than (a.list[a.index + 1], a.list[a.index])) {
				descending = true;
				for (int i = a.index + 2; i < a.index + a.length; i++) {
					if (lower_than (a.list[i], a.list[i-1])) {
						run_length++;
					} else {
						break;
					}
				}
			} else {
				descending = false;
				for (int i = a.index + 2; i < a.index + a.length; i++) {
					if (lower_than (a.list[i], a.list[i-1])) {
						break;
					} else {
						run_length++;
					}
				}
			}
		}
		return new Slice<G> (a.list, a.index, run_length);
	}

	private void insertion_sort (Slice<G> a, int offset) {
		#if DEBUG
			message ("Sorting (%d, %d) at %d", a.index, a.length, offset);
		#endif
		for (int start = a.index + offset; start < a.index + a.length; start++) {
			int left = a.index;
			int right = start;
			void* pivot = a.list[right];

			while (left < right) {
				int p = left + ((right - left) >> 1);
				if (lower_than (pivot, a.list[p])) {
					right = p;
				} else {
					left = p + 1;
				}
			}
			assert (left == right);

			Memory.move (&a.list[left + 1], &a.list[left], sizeof (G) * (start - left));
			a.list[left] = pivot;
		}
	}

	private void merge_collapse () {
		#if DEBUG
			message ("Merge Collapse");
		#endif
		int count = pending.length;
		while (count > 1) {
			#if DEBUG
				message ("Pending count: %d", count);
				if (count >= 3) {
					message ("pending[count-3]=%p; pending[count-2]=%p; pending[count-1]=%p",
					         pending[count-3], pending[count-2], pending[count-1]);
				}
			#endif
			if (count >= 3 && pending[count-3].length <= pending[count-2].length + pending[count-1].length) {
				if (pending[count-3].length < pending[count-1].length) {
					merge_at (count-3);
				} else {
					merge_at (count-2);
				}
			} else if (pending[count-2].length <= pending[count-1].length) {
				merge_at (count-2);
			} else {
				break;
			}
			count = pending.length;
			#if DEBUG
				message ("New pending count: %d", count);
			#endif
		}
	}

	private void merge_force_collapse () {
		#if DEBUG
			message ("Merge Force Collapse");
		#endif
		int count = pending.length;
		#if DEBUG
			message ("Pending count: %d", count);
		#endif
		while (count > 1) {
			if (count >= 3 && pending[count-3].length < pending[count-1].length) {
				merge_at (count-3);
			} else {
				merge_at (count-2);
			}
			count = pending.length;
			#if DEBUG
				message ("New pending count: %d", count);
			#endif
		}
	}

	private void merge_at (int index) {
		#if DEBUG
			message ("Merge at %d", index);
		#endif
		Slice<G> a = (owned) pending[index];
		Slice<G> b = (owned) pending[index + 1];

		assert (a.length > 0);
		assert (b.length > 0);
		assert (a.index + a.length == b.index);

		pending[index] = new Slice<G> (list, a.index, a.length + b.length);
		pending.move (index + 2, index + 1, pending.length - index - 2);
		pending.length -= 1;

		int sorted_count = gallop_rightmost (b.peek_first (), a, 0);
		a.shorten_start (sorted_count);
		if (a.length == 0) {
			return;
		}

		b.length = gallop_leftmost (a.peek_last (), b, b.length - 1);
		if (b.length == 0) {
			return;
		}

		if (a.length <= b.length) {
			merge_low ((owned) a, (owned) b);
		} else {
			merge_high ((owned) a, (owned) b);
		}
	}

	private int gallop_leftmost (G key, Slice<G> a, int hint) {
		#if DEBUG
			message ("Galop leftmost in (%d, %d), hint=%d", a.index, a.length, hint);
		#endif
		assert (0 <= hint);
		assert (hint < a.length);

		int p = a.index + hint;
		int last_offset = 0;
		int offset = 1;
		if (lower_than (a.list[p], key)) {
			int max_offset = a.length - hint;
			while (offset < max_offset) {
				if (lower_than (a.list[p + offset], key)) {
					last_offset = offset;
					offset <<= 1;
					offset++;
				} else {
					break;
				}
			}

			if (offset > max_offset) {
				offset = max_offset;
			}

			last_offset = hint + last_offset;
			offset = hint + offset;
		} else {
			int max_offset = hint + 1;
			while (offset < max_offset) {
				if (lower_than (a.list[p - offset], key)) {
					break;
				} else {
					last_offset = offset;
					offset <<= 1;
					offset++;
				}
			}

			if (offset > max_offset) {
				offset = max_offset;
			}

			int temp_last_offset = last_offset;
			int temp_offset = offset;
			last_offset = hint - temp_offset;
			offset = hint - temp_last_offset;
		}

		assert (-1 <= last_offset);
		assert (last_offset < offset);
		assert (offset <= a.length);

		last_offset += 1;
		while (last_offset < offset) {
			int m = last_offset + ((offset - last_offset) >> 1);
			if (lower_than (a.list[a.index + m], key)) {
				last_offset = m + 1;
			} else {
				offset = m;
			}
		}

		assert (last_offset == offset);
		return offset;
	}

	private int gallop_rightmost (G key, Slice<G> a, int hint) {
		#if DEBUG
			message ("Galop rightmost in (%d, %d), hint=%d", a.index, a.length, hint);
		#endif
		assert (0 <= hint);
		assert (hint < a.length);

		int p = a.index + hint;
		int last_offset = 0;
		int offset = 1;
		if (lower_than_or_equal_to (a.list[p], key)) {
			int max_offset = a.length - hint;
			while (offset < max_offset) {
				if (lower_than_or_equal_to (a.list[p + offset], key)) {
					last_offset = offset;
					offset <<= 1;
					offset++;
				} else {
					break;
				}
			}

			if (offset > max_offset) {
				offset = max_offset;
			}

			last_offset = hint + last_offset;
			offset = hint + offset;
		} else {
			int max_offset = hint + 1;
			while (offset < max_offset) {
				if (lower_than_or_equal_to (a.list[p - offset], key)) {
					break;
				} else {
					last_offset = offset;
					offset <<= 1;
					offset++;
				}
			}

			if (offset > max_offset) {
				offset = max_offset;
			}

			int temp_last_offset = last_offset;
			int temp_offset = offset;
			last_offset = hint - temp_offset;
			offset = hint - temp_last_offset;
		}

		assert (-1 <= last_offset);
		assert (last_offset < offset);
		assert (offset <= a.length);

		last_offset += 1;
		while (last_offset < offset) {
			int m = last_offset + ((offset - last_offset) >> 1);
			if (lower_than_or_equal_to (a.list[a.index + m], key)) {
				last_offset = m + 1;
			} else {
				offset = m;
			}
		}

		assert (last_offset == offset);
		return offset;
	}

	private void merge_low (owned Slice<G> a, owned Slice<G> b) {
		#if DEBUG
			message ("Merge low (%d, %d) (%d, %d)", a.index, a.length, b.index, b.length);
		#endif
		assert (a.length > 0);
		assert (b.length > 0);
		assert (a.index + a.length == b.index);

		int minimum_gallop = this.minimum_gallop;
		int dest = a.index;
		a.copy ();

		try {
			list[dest++] = b.pop_first ();
			if (a.length == 1 || b.length == 0) {
				return;
			}

			while (true) {
				int a_count = 0;
				int b_count = 0;

				while (true) {
					if (lower_than (b.peek_first (), a.peek_first ())) {
						list[dest++] = b.pop_first ();
						if (b.length == 0) {
							return;
						}

						b_count++;
						a_count = 0;
						if (b_count >= minimum_gallop) {
							break;
						}
					} else {
						list[dest++] = a.pop_first ();
						if (a.length == 1) {
							return;
						}

						a_count++;
						b_count = 0;
						if (a_count >= minimum_gallop) {
							break;
						}
					}
				}

				minimum_gallop++;

				while (true) {
					minimum_gallop -= (minimum_gallop > 1 ? 1 : 0);
					this.minimum_gallop = minimum_gallop;

					a_count = gallop_rightmost (b.peek_first (), a, 0);
					a.merge_in (list, a.index, dest, a_count);
					dest += a_count;
					a.shorten_start (a_count);
					if (a.length <= 1) {
						return;
					}

					list[dest++] = b.pop_first ();
					if (b.length == 0) {
						return;
					}

					b_count = gallop_leftmost (a.peek_first (), b, 0);
					b.merge_in (list, b.index, dest, b_count);
					dest += b_count;
					b.shorten_start (b_count);
					if (b.length == 0) {
						return;
					}

					list[dest++] = a.pop_first ();
					if (a.length == 1) {
						return;
					}

					if (a_count < MINIMUM_GALLOP && b_count < MINIMUM_GALLOP) {
						break;
					}
				}

				minimum_gallop++;
				this.minimum_gallop = minimum_gallop;
			}
		} finally {
			assert (a.length >= 0);
			assert (b.length >= 0);
			b.merge_in (list, b.index, dest, b.length);
			a.merge_in (list, a.index, dest + b.length, a.length);
		}
	}

	private void merge_high (owned Slice<G> a, owned Slice<G> b) {
		#if DEBUG
			message ("Merge high (%d, %d) (%d, %d)", a.index, a.length, b.index, b.length);
		#endif
		assert (a.length > 0);
		assert (b.length > 0);
		assert (a.index + a.length == b.index);

		int minimum_gallop = this.minimum_gallop;
		int dest = b.index + b.length;
		b.copy ();

		try {
			list[--dest] = a.pop_last ();
			if (a.length == 0 || b.length == 1) {
				return;
			}

			while (true) {
				int a_count = 0;
				int b_count = 0;

				while (true) {
					if (lower_than (b.peek_last (), a.peek_last ())) {
						list[--dest] = a.pop_last ();
						if (a.length == 0) {
							return;
						}

						a_count++;
						b_count = 0;
						if (a_count >= minimum_gallop) {
							break;
						}
					} else {
						list[--dest] = b.pop_last ();
						if (b.length == 1) {
							return;
						}

						b_count++;
						a_count = 0;
						if (b_count >= minimum_gallop) {
							break;
						}
					}
				}

				minimum_gallop++;

				while (true) {
					minimum_gallop -= (minimum_gallop > 1 ? 1 : 0);
					this.minimum_gallop = minimum_gallop;

					int k = gallop_rightmost (b.peek_last (), a, a.length - 1);
					a_count = a.length - k;
					a.merge_in_reversed (list, a.index + k, dest - a_count, a_count);
					dest -= a_count;
					a.shorten_end (a_count);
					if (a.length == 0) {
						return;
					}

					list[--dest] = b.pop_last ();
					if (b.length == 1) {
						return;
					}

					k = gallop_leftmost (a.peek_last (), b, b.length - 1);
					b_count = b.length - k;
					b.merge_in_reversed (list, b.index + k, dest - b_count, b_count);
					dest -= b_count;
					b.shorten_end (b_count);
					if (b.length <= 1) {
						return;
					}

					list[--dest] = a.pop_last ();
					if (a.length == 0) {
						return;
					}

					if (a_count < MINIMUM_GALLOP && b_count < MINIMUM_GALLOP) {
						break;
					}
				}

				minimum_gallop++;
				this.minimum_gallop = minimum_gallop;
			}
		} finally {
			assert (a.length >= 0);
			assert (b.length >= 0);
			a.merge_in_reversed (list, a.index, dest - a.length, a.length);
			b.merge_in_reversed (list, b.index, dest - a.length - b.length, b.length);
		}
	}

	[Compact]
	private class Slice<G> {

		public void** list;
		public void** new_list;
		public int index;
		public int length;

		public Slice (void** list, int index, int length) {
			this.list = list;
			this.index = index;
			this.length = length;
		}

		~Slice () {
			if (new_list != null)
				free (new_list);
		}

		public void copy () {
			size_t size = sizeof (G) * length;
			new_list = malloc (size);
			Memory.copy (new_list, &list[index], size);
			list = new_list;
			index = 0;
		}

		public inline void merge_in (void** dest_array, int index, int dest_index, int count) {
			Memory.move (&dest_array[dest_index], &list[index], sizeof (G) * count);
		}

		public inline void merge_in_reversed (void** dest_array, int index, int dest_index, int count) {
			Memory.move (&dest_array[dest_index], &list[index], sizeof (G) * count);
		}

		public inline void shorten_start (int n) {
			index += n;
			length -= n;
		}

		public inline void shorten_end (int n) {
			length -= n;
		}

		public inline void* pop_first () {
			length--;
			return list[index++];
		}

		public inline void* pop_last () {
			length--;
			return list[index + length];
		}

		public inline unowned void* peek_first () {
			return list[index];
		}

		public inline unowned void* peek_last () {
			return list[index + length - 1];
		}

		public void reverse () {
			int low = index;
			int high = index + length - 1;
			while (low < high) {
				swap (low++, high--);
			}
		}

		private inline void swap (int i, int j) {
			void* temp = list[i];
			list[i] = list[j];
			list[j] = temp;
		}
	}
}

