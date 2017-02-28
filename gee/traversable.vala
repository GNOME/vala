/* traversable.vala
 *
 * Copyright (C) 2011-2012  Maciej Piechotka
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
 * 	Maciej Piechotka <uzytkownik2@gmail.com>
 */

namespace Vala {
	public delegate A FoldFunc<A, G> (owned G g, owned A a);
	public delegate bool ForallFunc<G> (owned G g);
	public delegate Lazy<A>? UnfoldFunc<A> ();
	public delegate Traversable.Stream StreamFunc<G, A> (Traversable.Stream state, owned Lazy<G>? g, out Lazy<A>? lazy);
	public delegate A MapFunc<A, G> (owned G g);
	public delegate bool Predicate<G> (G g);
}

/**
 * It's a common interface for {@link Iterator} and {@link Iterable}. It
 * provides a fast, high level functions.
 *
 * ''{@link Iterator} implementation:'' Please note that most of the functions
 * affect the state of the iterator by moving it forward.
 * Even if the iterator is {@link BidirIterator} it ''must not''
 * rewind the state.
 *
 * ''{@link Iterable} implementation:'' validy ({@link Iterator.valid})
 * of returned iterator is the same as for invalid
 * iterator. In other words the following code is semantically equivalent:
 *
 * {{{
 *     var x = iterable.function (args);
 *     var x = iterable.iterator ().function(args);
 * }}}
 *
 */
[GenericAccessors]
public interface Vala.Traversable<G> : Object {
	/**
	 * Apply function to each element returned by iterator untill last element
	 * or function return ''false''.
	 *
	 * ''{@link Iterator} implementation:'' Operation moves the iterator
	 * to last element in iteration or the first element that returned ''false''.
	 * If iterator points at some element it will be included in iteration.
	 *
	 * @param f function applied to every element of the collection
	 *
	 * @return ''false'' if the argument returned ''false'' at last invocation and
	 *         ''true'' otherwise.
	 */
	[CCode (ordering = 0)]
	public new abstract bool foreach (ForallFunc<G> f);

	/**
	 * Stream function is an abstract function allowing writing many
	 * operations.
	 *
	 * The stream function accepts three parameter:
	 *
	 *   1. state. It is usually the last returned value from function but
	 *      it may be {@link Stream.END} when {@link Stream.CONTINUE} was
	 *      returned and there was no more elements.
	 *   1. input. It is valid only if first argument is
	 *      {@link Stream.CONTINUE}
	 *   1. output. It is valid only if result is Stream.YIELD
	 *
	 * It may return one of 3 results:
	 *
	 *   1. {@link Stream.YIELD}. It means that value was yielded and can
	 *      be passed to outgoing iterator.
	 *   1. {@link Stream.CONTINUE}. It means that the function needs to be
	 *      called with next element or with {@link Stream.END} if it is
	 *      end of stream). If the state element was Stream.END during the
	 *      current iteration function ''must not'' return {@link Stream.CONTINUE}.
	 *   1. {@link Stream.WAIT}. Simply denotes that iterator should skip an element.
	 *      Usually the function is called once again with {@link Stream.WAIT} as
	 *      state however it do affect the initial validity of iterator.
	 *   1. {@link Stream.END}. It means that the last argument was yielded.
	 *
	 * If the function yields the value immediately then the returning iterator
	 * is {@link Iterator.valid} and points to this value as well as in case when the
	 * parent iterator is {@link Iterator.valid} and function yields
	 * after consuming 1 input. In other case returned iterator is invalid including
	 * when the first value returned is {@link Stream.WAIT}.
	 *
	 * Note: In {@link Iterator} implementation: if iterator is
	 *    {@link Iterator.valid} the current value should be fed
	 *    immediately to function if during initial call function returns
	 *    {@link Stream.CONTINUE}. The parent iterator cannot be used before
	 *    the functions return {@link Stream.END} afterwards it points on the
	 *    last element consumed.
	 *
	 * @param f function generating stream
	 * @return iterator containing values yielded by stream
	 */
	[CCode (ordering = 1)]
	public virtual Iterator<A> stream<A> (owned StreamFunc<G, A> f) {
		unowned Iterator<G>? self;
		unowned Iterable<G>? iself;
		// Yes - I've heard of polimorphism ;) but I don't want users to need to implement the method.
		if ((self = this as Iterator<G>) != null) {
			return new StreamIterator<A, G> (self, (owned)f);
		} else if ((iself = this as Iterable<G>) != null) {
			return iself.iterator().stream<A> ((owned) f);
		} else {
			assert_not_reached ();
		}
	}

	/**
	 * Standard aggregation function.
	 *
	 * It takes a function, seed and first element, returns the new seed and
	 * progress to next element when the operation repeats.
	 *
	 * Note: Default implementation uses {@link foreach}.
	 *
	 * Note: In {@link Iterator} implementation operation moves the
	 *    iterator to last element in iteration. If iterator is
	 *    {@link Iterator.valid} the current element will be considered
	 *    as well.
	 *
	 */
	[CCode (ordering = 2)]
	public virtual A fold<A> (FoldFunc<A, G> f, owned A seed)
	{
		this.foreach ((item) => {seed = f ((owned) item, (owned) seed); return true; });
		return (owned) seed;
	}

	/**
	 * Produces an iterator pointing at elements generated by function passed.
	 *
	 * Iterator is lazy evaluated but value is force-evaluated when
	 * iterator moves to next element. ({@link Iterator.next})
	 *
	 * Note: Default implementation uses {@link stream}.
	 *
	 * Note: In {@link Iterator} implementation if the parent iterator is
	 *    {@link Iterator.valid} so is the returned one. Using the parent
	 *    iterator is not allowed before the inner iterator {@link Iterator.next}
	 *    return false and then it points on its last element.
	 *    The resulting iterator is {@link Iterator.valid} if the parent
	 *    iterator is.
	 *
	 * @param f Mapping function
	 * @return Iterator listing mapped value
	 */
	[CCode (ordering = 3)]
	public virtual Iterator<A> map<A> (MapFunc<A, G> f) {
		return stream<A>((state, item, out val) => {
			switch (state) {
			case Stream.YIELD:
				val = null;
				return Stream.CONTINUE;
			case Stream.CONTINUE:
				val = new Lazy<A>(() => {
					A tmp = item.get ();
					item = null;
					return (f ((owned)tmp));
				});
				return Stream.YIELD;
			case Stream.END:
				val = null;
				return Stream.END;
			default:
				assert_not_reached ();
			}
		});
	}

	/**
	 * Creates a new iterator that is initially pointing to seed. Then
	 * subsequent values are obtained after applying the function to previous
	 * value and the subsequent items.
	 *
	 * The resulting iterator is always valid and it contains the seed value.
	 *
	 * Note: Default implementation uses {@link stream}.
	 *
	 * Note: When the method is called on {@link Iterator} using the parent
	 *    iterator is not allowed befor the inner iterator
	 *    {@link Iterator.next} return false and then it points on its last
	 *    element. The resulting iterator is {@link Iterator.valid}.
	 *
	 * @param f Folding function
	 * @param seed original seed value
	 * @return Iterator containing values of subsequent values of seed
	 */
	[CCode (ordering = 4)]
	public virtual Iterator<A> scan<A> (FoldFunc<A, G> f, owned A seed) {
		bool seed_emitted = false;
		return stream<A>((state, item, out val) => {
			switch (state) {
			case Stream.YIELD:
				if (seed_emitted) {
					val = null;
					return Stream.CONTINUE;
				} else {
					val = new Lazy<A>.from_value (seed);
					seed_emitted = true;
					return Stream.YIELD;
				}
			case Stream.CONTINUE:
				val = new Lazy<A> (() => {
					A tmp = item.get ();
					item = null;
					seed = f ((owned) tmp, (owned) seed);
					return seed;
				});
				return Stream.YIELD;
			case Stream.END:
				val = null;
				return Stream.END;
			default:
				assert_not_reached ();
			}
		});
	}

	/**
	 * Creates a new iterator that contains only values that fullfills the
	 * predicate.
	 *
	 * Note: When the method is called on {@link Iterator} using the parent
	 *    iterator is not allowed befor the inner iterator
	 *    {@link Iterator.next} return false and then it points on its last
	 *    element. The resulting iterator is {@link Iterator.valid} if parent
	 *    iterator is {@link Iterator.valid} and value it is pointing on
	 *    fullfills the predicate.
	 *
	 * @param pred predicate to check should the value be retained
	 * @return Iterator containing values of subsequent values of seed
	 */
	[CCode (ordering = 5)]
	public virtual Iterator<G> filter (owned Predicate<G> pred) {
		return stream<G> ((state, item, out val) => {
			switch (state) {
			case Stream.YIELD:
				val = null;
				return Stream.CONTINUE;
			case Stream.CONTINUE:
				G g = item.get ();
				if (pred (g)) {
					val = item;
					return Stream.YIELD;
				} else {
					val = null;
					return Stream.CONTINUE;
				}
			case Stream.END:
				val = null;
				return Stream.END;
			default:
				assert_not_reached ();
			};
		});
	}

	/**
	 * Creates a new iterator which contains elements from iterable. The
	 * first argument states the offset i.e. number of elements the iterator
	 * skips by default.
	 *
	 * Note: In {@link Iterator} implementation resulting iterator is
	 *    {@link Iterator.valid} when parent iterator is
	 *    {@link Iterator.valid} and the offset is 0. Using the parent
	 *    iterator is not allowed before the inner iterator
	 *    {@link Iterator.next} return false and then it points on its last
	 *    element.
	 *
	 * @param offset the offset to first element the iterator is pointing to
	 * @param length maximum number of elements iterator may return. Negative
	 *        value means that the number is unbounded
	 */
	[CCode (ordering = 6)]
	public virtual Iterator<G> chop (int offset, int length = -1) {
		assert (offset >= 0);
		return stream<G> ((state, item, out val) => {
			switch (state) {
			case Stream.YIELD:
				val = null;
				if (offset > 0) {
					return Stream.CONTINUE;
				} else if (length > 0) {
					return length != 0 ? Stream.CONTINUE : Stream.END;
				} else if (length == 0) {
					return Stream.END;
				} else {
					return Stream.CONTINUE;
				}
			case Stream.CONTINUE:
				if (offset == 0) {
					val = item;
					length--;
					return Stream.YIELD;
				} else {
					val = null;
					offset--;
					return Stream.CONTINUE;
				}
			case Stream.END:
				val = null;
				return Stream.END;
			default:
				assert_not_reached ();
			};
		});
	}

	/**
	 * The type of the elements in this collection.
	 */
	[CCode (ordering = 7)]
	public virtual Type element_type { get { return typeof (G); } }

	/**
	 * A fused concatinate and map. The function is applied to each element
	 * of iteration and the resulting values are concatinated.
	 *
	 * The iterator is lazy evaluated but value is force-evaluated when
	 * iterator is moved to next value.
	 *
	 * Note: Default implementation uses {@link stream}.
	 *
	 * Note: In {@link Iterator} implementation if the parent iterator is
	 *    {@link Iterator.valid} and function returns a valid iterator the
	 *    resulting iterator is also valid. Using the parent iterator is not
	 *    allowed before the inner iterator {@link Iterator.next}
	 *    return false and then it points on its last element.
	 *
	 * @param f mapping function
	 * @return Iterator over returned values
	 */
	[CCode (ordering = 8)]
	public virtual Iterator<A> flat_map<A>(owned FlatMapFunc<A, G> f) {
		Iterator<A>? current = null;
		return stream<A> ((state, item, out val) => {
			switch (state) {
			case Stream.YIELD:
				if (current == null || !current.next ()) {
					val = null;
					return Stream.CONTINUE;
				} else {
					val = new Lazy<A> (() => {return current.get ();});
					return Stream.YIELD;
				}
			case Stream.CONTINUE:
				current = f (item.get ());
				if (current.valid) {
					val = new Lazy<A> (() => {return current.get ();});
					return Stream.YIELD;
				} else {
					val = null;
					return Stream.WAIT;
				}
			case Stream.WAIT:
				if (current.next()) {
					val = new Lazy<A> (() => {return current.get ();});
					return Stream.YIELD;
				} else {
					val = null;
					return Stream.CONTINUE;
				}
			case Stream.END:
				val = null;
				return Stream.END;
			default:
				assert_not_reached ();
			}
		});
	}

	/**
	 * Splits the traversable into multiple ones, caching the result if needed.
	 *
	 * Note: In {@link Iterator} implementation using the parent iterator is
	 *   not allowed. However if any of the forked iterators {@link next}
	 *   return false then it is treated as if the parent iterator
	 *   {@link next} returned false.
	 *
	 * Note: The returned arrey might contain parent iterator if it is allowed
	 *   by implementation. For example the iteration over collection does
	 *   not need to generate and cache the results.
	 *   In such case it is recommended to return the value as the first element
	 *   of the array. This allows the consumer to check just the first element
	 *   if it can perform optimizations for such case. However it //must// not
	 *   depend on the order (that's for optimization only).
	 *
	 * Note: The resulting iterators does not need to be thread safe.
	 *
	 * @param forks Number of iterators in array
	 * @return An array with created iterators
	 */
	[CCode (ordering = 9)]
	public virtual Iterator<G>[] tee (uint forks) {
		unowned Iterator<G>? self;
		unowned Iterable<G>? iself;
		// Yes - I've heard of polimorphism ;) but I don't want users to need to implement the method.
		if ((self = this as Iterator<G>) != null) {
			if (forks == 0) {
				return new Iterator<G>[0];
			} else if (forks == 1) {
				return new Iterator<G>[1]{self};
			} else {
				Iterator<G>[] result = new Iterator<G>[forks];
				Lazy<G>? data;
				bool is_valid = self.valid;
				if (is_valid) {
					data = new Lazy<G>(() => {return self.get ();});
				} else {
					data = new Lazy<G>.from_value (null);
				}
				var head = new TeeIterator.Node<G> (data, TeeIterator.create_nodes<G> (self, data));
				for (uint i = 0; i < forks; i++) {
					result[i] = new TeeIterator<G> (head, is_valid);
				}
				return result;
			}
		} else if ((iself = this as Iterable<G>) != null) {
			var result = new Iterator<G>[forks];
			for (uint i = 0; i < forks; i++) {
				result[i] = iself.iterator ();
			}
			return result;
		} else {
			assert_not_reached ();
		}
	}

	/**
	 * Returns the first element that matches a given condition
	 *
	 * @param pred Predicate to be called to check for matches
	 * @return The first element that matches or null
	 */
	[CCode (ordering = 10)]
	public virtual G? first_match (owned Predicate<G> pred) {
		G? result = null;
		this.foreach ((item) => {
			if (pred (item)) {
				result = item;
				return false;
			}
			return true;
		});
		return (owned) result;
	}

	/**
	 * Returns whether any element matches the given predicate.
	 *
	 * This is similar to @first_match, with the difference that it
	 * just returns whether there is a match or not, not the value
	 * of the match.
	 *
	 * @param pred Predicate to be called to check for matches
	 * @return Whether there was a match or not
	 */
	[CCode (ordering = 11)]
	public virtual bool any_match (owned Predicate<G> pred) {
		return this.first_match (pred) != null;
	}

	/**
	 * Checks whether all elements match the given predicate.
	 *
	 * @param pred Predicate to be called to check for matches
	 * @return Whether all elements match or not
	 */
	[CCode (ordering = 12)]
	public virtual bool all_match (owned Predicate<G> pred) {
		bool result = true;
		this.foreach ((item) => {
			if (!pred (item)) {
				result = false;
				return false;
			}
			return true;
		});
		return result;
	}

	/**
	 * Returns the item in the sequence that contains the max value
	 * based on the given compare function.
	 *
	 * @param compare Function to be called for comparisons
	 * @return The item containing the max value.
	 */
	[CCode (ordering = 13)]
	public virtual G max (owned CompareDataFunc<G> compare) {
		G max_value = null;
		this.foreach ((item) => {
			if (max_value == null || compare (max_value, item) > 0) {
				max_value = item;
			}
			return true;
		});
		return max_value;
	}

	/**
	 * Returns the item in the sequence that contains the min value
	 * based on the given compare function.
	 *
	 * @param compare Function to be called for comparisons
	 * @return The item containing the min value.
	 */
	[CCode (ordering = 14)]
	public virtual G min (owned CompareDataFunc<G> compare) {
		G min_value = null;
		this.foreach ((item) => {
			if (min_value == null || compare (min_value, item) < 0) {
				min_value = item;
			}
			return true;
		});
		return min_value;
	}

	/**
	 * Returns a new iterator containing the elements in the source
	 * ordered as specified by the comparison function.
	 *
	 * @param compare Comparison function
	 * @return A new iterator with the source elements sorted.
	 */
	[CCode (ordering = 15)]
	public virtual Iterator<G> order_by (owned CompareDataFunc<G>? compare = null) {
		ArrayList<G> result = new ArrayList<G> ();
		this.foreach ((item) => result.add (item));
		result.sort (compare);
		return result.iterator ();
	}

	public enum Stream {
		YIELD,
		CONTINUE,
		END,
		WAIT
	}
}

namespace Vala {
	// Placed here to workaround bug #703710
	public delegate Iterator<A> FlatMapFunc<A, G>(owned G g);
}

