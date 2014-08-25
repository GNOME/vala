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
 * @since 0.7.0
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
	 * @return ''false'' if the argument returned ''false'' at last invocation and
	 *         ''true'' otherwise.
	 */
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
	 *      current iteration function ''must not'' return {@link Stream.CONTINUE}
	 *   1. Stream.END. It means that the last argument was yielded.
	 *
	 * If the function yields the value immediately then the returning iterator
	 * is {@link Iterator.valid} and points to this value as well as in case when the
	 * parent iterator is {@link Iterator.valid} and function yields
	 * after consuming 1 input. In other case returned iterator is invalid.
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
	public virtual Iterator<A> stream<A> (owned StreamFunc<G, A> f) {
		Iterator<G>? self;
		Iterable<G>? iself;
		// Yes - I've heard of polimorphism ;) but I don't want users to need to implement the method.
		if ((self = this as Iterator<G>) != null) {
			Traversable.Stream str;
			Lazy<A>? initial = null;
			bool need_next = true;
			str = f (Stream.YIELD, null, out initial);
			switch (str) {
			case Stream.CONTINUE:
				if (self.valid) {
					str = f (Stream.CONTINUE, new Lazy<G> (() => {return self.get ();}), out initial);
					switch (str) {
					case Stream.YIELD:
					case Stream.CONTINUE:
						break;
					case Stream.END:
						return Iterator.unfold<A> (() => {return null;});
					default:
						assert_not_reached ();
					}
				}
				break;
			case Stream.YIELD:
				if (self.valid)
					need_next = false;
				break;
			case Stream.END:
				return Iterator.unfold<A> (() => {return null;});
			default:
				assert_not_reached ();
			}
			return Iterator.unfold<A> (() => {
				Lazy<A>? val = null;
				if (str != Stream.CONTINUE)
					str = f (Traversable.Stream.YIELD, null, out val);
				while (str == Stream.CONTINUE) {
					if (need_next) {
						if (!self.next ()) {
							str = f (Traversable.Stream.END, null, out val);
							assert (str != Traversable.Stream.CONTINUE);
							break;
						}
					} else {
						need_next = true;
					}
					str = f (Stream.CONTINUE, new Lazy<G> (() => {return self.get ();}), out val);
				}
				switch (str) {
				case Stream.YIELD:
					return val;
				case Stream.END:
					return null;
				default:
					assert_not_reached ();
				}
			}, initial);
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
	 * @param f Folding function
	 * @return Iterator containing values of subsequent values of seed
	 */
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
	public virtual Type element_type { get { return typeof (G); } }

	public enum Stream {
		YIELD,
		CONTINUE,
		END
	}

}

