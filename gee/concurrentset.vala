/* concurrentset.vala
 *
 * Copyright (C) 2012-2014  Maciej Piechotka
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

/**
 * A skip-linked list. This implementation is based on
 * [[http://www.cse.yorku.ca/~ruppert/Mikhail.pdf|Mikhail Fomitchev Master Thesis]].
 *
 * Many threads are allowed to operate on the same structure as well as modification
 * of structure during iteration is allowed. However the change may not be immidiatly
 * visible to other threads.
 */
public class Vala.ConcurrentSet<G> : AbstractSortedSet<G> {
	public ConcurrentSet (owned CompareDataFunc<G>? compare_func = null) {
		if (compare_func == null) {
			compare_func = Functions.get_compare_func_for (typeof (G));
		}
		_cmp = (owned)compare_func;
		_head = new Tower<G>.head ();
	}

	~ConcurrentSet () {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		_head = null;
	}

	public override int size { get { return GLib.AtomicInt.get (ref _size); } }

	public override bool read_only { get { return false; } }

	public override Vala.Iterator<G> iterator () {
		return new Iterator<G> (this, _head);
	}

	public override bool contains (G key) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		Tower<G> prev = _head;
		return Tower.search<G> (_cmp, key, ref prev, null);
	}

	public override bool add (G key) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		Rand *rnd = rand.get ();
		if (rnd == null) {
			rand.set (rnd = new Rand ());
		}
		uint32 rand_int = rnd->int_range (0, int32.MAX);
		uint8 height = 1 + (uint8)GLib.Bit.nth_lsf (~rand_int, -1);
		TowerIter<G> prev = TowerIter<G>();
		prev._iter[height - 1] = _head;
		if (Tower.search<G> (_cmp, key, ref prev._iter[height - 1], null, height - 1)) {
			return false;
		}
		for (int i = height - 2; i >= 0; i--) {
			prev._iter[i] = prev._iter[height - 1];
		}
		Tower<G>? result = Tower.insert<G> (_cmp, ref prev, key, height - 1);
		if (result != null) {
			GLib.AtomicInt.inc (ref _size);
		}
		return result != null;
	}

	public override bool remove (G item) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		TowerIter<G> prev = TowerIter<G>();
		for (int i = 0; i < _MAX_HEIGHT; i++) {
			prev._iter[i] = _head;
		}
		bool result = Tower.remove_key<G> (_cmp, ref prev, item);
		if (result) {
			GLib.AtomicInt.dec_and_test (ref _size);
		}
		return result;
	}

	public override void clear () {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		Tower<G>? first;
		while ((first = _head.get_next (0)) != null) {
			remove (first._data);
		}
	}

	public override G first () {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		Tower<G>? prev = null;
		Tower<G> curr = _head;
		if (Tower.proceed<G> (_cmp, ref prev, ref curr, 0)) {
			return curr._data;
		} else {
			return null;
		}
	}

	public override G last () {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		Tower<G>? prev = null;
		Tower<G> curr = _head;
		bool found = false;
		for (int i = _MAX_HEIGHT; i >= 0; i--) {
			while (Tower.proceed<G> (_cmp, ref prev, ref curr, 0)) {
				found = true;
			}
		}
		if (!found) {
			return null;
		}
		return curr._data;
	}

	public override Vala.Iterator<G>? iterator_at (G element) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		TowerIter<G> prev = TowerIter<G> ();
		TowerIter<G> curr;
		for (int i = 0; i < _MAX_HEIGHT; i++) {
			prev._iter[i] = _head;
		}
		if (!Tower.search_from_bookmark<G> (_cmp, element, ref prev, out curr)) {
			return null;
		}
		return new Iterator<G>.point_at (this, ref prev, curr._iter[0]);
	}

	public override G? lower (G element) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		Tower<G> prev = _head;
		Tower.search<G> (_cmp, element, ref prev);
		if (prev == _head) {
			return null;
		}
		return prev._data;
	}

	public override G? higher (G element) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		Tower<G> prev = _head;
		Tower<G>? next;
		if (Tower.search<G> (_cmp, element, ref prev, out next)) {
			if (!Tower.proceed<G> (_cmp, ref prev, ref next, 0)) {
				return null;
			}
		}
		if (next == null) {
			return null;
		}
		return next._data;
	}

	public override G? floor (G element) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		Tower<G> prev = _head;
		Tower<G>? next;
		if (Tower.search<G> (_cmp, element, ref prev, out next)) {
			return next._data;
		} else if (prev != _head) {
			return prev._data;
		} else {
			return null;
		}
	}

	public override G? ceil (G element) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		Tower<G> prev = _head;
		Tower<G>? next;
		Tower.search<G> (_cmp, element, ref prev, out next);
		if (next == null) {
			return null;
		}
		return next._data;
	}

	public override SortedSet<G> head_set (G before) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		return new SubSet<G> (new Range<G>.head (this, before));
	}

	public override SortedSet<G> tail_set (G after) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		return new SubSet<G> (new Range<G>.tail (this, after));
	}
	public override SortedSet<G> sub_set (G from, G to) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		return new SubSet<G> (new Range<G> (this, from, to));
	}

	private unowned G max (G a, G b, out bool changed = null) {
		changed = _cmp (a, b) < 0;
		return changed ? b : a;
	}

	private unowned G min (G a, G b, out bool changed = null) {
		changed = _cmp (a, b) > 0;
		return changed ? b : a;
	}

#if DEBUG
	public void dump () {
		for (int i = _MAX_HEIGHT - 1; i >= 0; i--) {
			bool printed = false;
			Tower<G>? curr = _head;
			State state;
			while ((curr = curr.get_succ (out state, (uint8)i)) != null) {
				if (!printed) {
					stderr.printf("Level %d\n", i);
					printed = true;
				}
				stderr.printf("    Node %p%s - %s\n", curr, state == State.NONE ? "" : state == State.MARKED ? " (MARKED)" : " (FLAGGED)", (string)curr._data);
				assert (curr._height > i);
			}
		}
	}
#endif

	private int _size = 0;
	private Tower<G> _head;
	private CompareDataFunc<G>? _cmp;
	private const int _MAX_HEIGHT = 31;
	private static Private rand = new Private((ptr) => {
		Rand *rnd = (Rand *)ptr;
		delete rnd;
	});

	private class Iterator<G> : Object, Traversable<G>, Vala.Iterator<G> {
		public Iterator (ConcurrentSet cset, Tower<G> head) {
			_curr = head;
			_set = cset;
			assert (_curr != null);
		}

		public Iterator.point_at (ConcurrentSet cset, ref TowerIter<G> prev, Tower<G> curr) {
			_curr = curr;
			_set = cset;
			_prev = prev;
			assert (_curr != null);
		}

		public Iterator.from_iterator (Iterator<G> iter) {
			_curr = iter._curr;
			_set = iter._set;
			_prev = iter._prev;
			_removed = iter._removed;
		}

		public new bool foreach (ForallFunc<G> f) {
			assert (_curr != null);
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			if (_prev._iter[0] != null && !_removed) {
				if (!f (_curr._data)) {
					assert (_curr != null);
					return false;
				}
			}
			Tower<G> new_prev = _prev._iter[0];
			Tower<G>? new_curr = _curr;
			while (Tower.proceed<G> (_set._cmp, ref new_prev, ref new_curr, 0)) {
				assert (_curr != null);
				if (!_removed) {
					//FIXME: Help mark/delete on the way
					_prev._iter[0] = new_prev;
					int prev_height = _prev._iter[0].get_height();
					for (int i = 1; i < prev_height; i++) {
						_prev._iter[i] = _prev._iter[0];
					}
				}
				_curr = new_curr;
				_removed = false;
				if (!f (_curr._data)) {
					assert (_curr != null);
					return false;
				}
			}
			assert (_curr != null);
			return true;
		}

		public Vala.Iterator<G>[] tee (uint forks) {
			if (forks == 0) {
				return new Vala.Iterator<G>[0];
			} else {
				Vala.Iterator<G>[] result = new Vala.Iterator<G>[forks];
				result[0] = this;
				for (uint i = 1; i < forks; i++) {
					result[i] = new Iterator<G>.from_iterator (this);
				}
				return result;
			}
		}

		public bool next () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			Tower<G>? new_prev = _prev._iter[0];
			Tower<G>? new_curr = _curr;
			bool success = Tower.proceed<G> (_set._cmp, ref new_prev, ref new_curr, 0);
			if (success) {
				if (!_removed) {
					//FIXME: Help mark/delete on the way
					_prev._iter[0] = (owned)new_prev;
					int prev_height = _prev._iter[0].get_height();
					for (int i = 1; i < prev_height; i++) {
						_prev._iter[i] = _prev._iter[0];
					}
				}
				_curr = (owned)new_curr;
				_removed = false;
			}
			assert (_curr != null);
			return success;
		}

		public bool has_next () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			Tower<G> prev = _prev._iter[0];
			Tower<G>? curr = _curr;
			return Tower.proceed<G> (_set._cmp, ref prev, ref curr, 0);
		}

		public new G get () {
			assert (valid);
			return _curr._data;
		}

		public void remove () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			assert (valid);
			if (Tower.remove<G> (_set._cmp, ref _prev, _curr)) {
				AtomicInt.dec_and_test (ref _set._size);
			}
			_removed = true;
		}

		public bool valid { get { return _prev._iter[0] != null && !_removed; } }

		public bool read_only { get { return true; } }

		protected bool _removed = false;
		protected ConcurrentSet<G> _set;
		protected TowerIter<G> _prev;
		protected Tower<G> _curr;
	}

	private class SubSet<G> : AbstractSortedSet<G> {
		public override int size {
			get {
				HazardPointer.Context ctx = new HazardPointer.Context ();
				Utils.Misc.unused (ctx);
				Tower<G>? curr;
				Range.improve_bookmark<G> (_range, out curr);
				if (curr != null) {
					int acc = 1;
					Tower<G>? prev = HazardPointer.get_pointer<Tower<G>> (&_range._bookmark._iter[0]);
					while (Range.proceed<G> (_range, ref prev, ref curr, 0)) {
						acc++;
					}
					return acc;
				} else {
					return 0;
				}
			}
		}

		public bool is_empty {
			get {
				HazardPointer.Context ctx = new HazardPointer.Context ();
				Utils.Misc.unused (ctx);
				Tower<G>? curr;
				Range.improve_bookmark<G> (_range, out curr);
				return curr != null;
			}
		}

		public override bool read_only { get { return false; } }

		public SubSet (Range<G> range) {
			_range = range;
		}

		public override Vala.Iterator<G> iterator () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			return new SubIterator<G> (_range);
		}

		public override bool contains (G item) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			if (!Range.inside<G> (_range, item)) {
				return false;
			}
			TowerIter<G> prev;
			Range.improve_bookmark<G> (_range, null, out prev);
			return Tower.search_from_bookmark<G> (_range._set._cmp, item, ref prev);
		}

		public override bool add (G key) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			if (!Range.inside<G> (_range, key)) {
				return false;
			}
			TowerIter<G> prev;
			Range.improve_bookmark<G> (_range, null, out prev);
			Rand *rnd = ConcurrentSet.rand.get ();
			if (rnd == null) {
				rand.set (rnd = new Rand ());
			}
			uint32 rand_int = rnd->int_range (0, int32.MAX);
			uint8 height = 1 + (uint8)GLib.Bit.nth_lsf (~rand_int, -1);
			if (Tower.search_from_bookmark<G> (_range._set._cmp, key, ref prev, null, height - 1)) {
				return false;
			}
			for (int i = height - 2; i >= 0; i--) {
				prev._iter[i] = prev._iter[height - 1];
			}
			Tower<G>? result = Tower.insert<G> (_range._set._cmp, ref prev, key, height - 1);
			if (result != null) {
				GLib.AtomicInt.inc (ref _range._set._size);
			}
			return result != null;
		}

		public override bool remove (G key) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			if (!Range.inside<G> (_range, key)) {
				return false;
			}
			TowerIter<G> prev;
			Range.improve_bookmark<G> (_range, null, out prev);
			// FIXME: Use full bookmark
			bool result = Tower.remove_key<G> (_range._set._cmp, ref prev, key);
			if (result) {
				GLib.AtomicInt.dec_and_test (ref _range._set._size);
			}
			return result;
		}

		public override void clear () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			TowerIter<G> prev;
			Tower<G>? first;
			Range.improve_bookmark<G> (_range, out first, out prev);
			while (first != null) {
				Tower.remove<G> (_range._set._cmp, ref prev, first);
				Range.improve_bookmark<G> (_range, out first, out prev);
			}
		}

		public override G? first () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			Tower<G>? first;
			Range.improve_bookmark<G> (_range, out first);
			if (first == null) {
				return null;
			}
			return first._data;
		}

		public override G? last () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			TowerIter<G> prev;
			Range.improve_bookmark<G> (_range, null, out prev);
			Tower<G>? curr = null;
			for (int i = _MAX_HEIGHT - 1; i >= 0; i--) {
				if (curr == null) {
					curr = prev._iter[i].get_next ((uint8)i);
					if (curr == null || !Range.inside<G> (_range, curr._data)) {
						curr = null;
						continue;
					}
				}
				bool improved = false;
				while (Range.proceed<G> (_range, ref prev._iter[i], ref curr, (uint8)i)) {
					improved = true;
				}
				if (improved && i > 0) {
					prev._iter[i - 1] = prev._iter[i];
				}
			}
			if (curr == null) {
				return null;
			}
			return curr._data;
		}

		public override Vala.Iterator<G>? iterator_at (G element) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			if (!Range.inside<G> (_range, element)) {
				return null;
			}
			TowerIter<G> prev;
			TowerIter<G> next;
			Range.improve_bookmark<G> (_range, null, out prev);
			if (!Tower.search_from_bookmark<G> (_range._set._cmp, element, ref prev, out next)) {
				return null;
			}
			return new SubIterator<G>.point_at (_range, ref prev, next._iter[0]);
		}

		public override G? lower (G element) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			switch (Range.cmp<G> (_range, element)) {
			case Range.Position.BEFORE:
			case Range.Position.EMPTY:
				return null;
			case Range.Position.INSIDE:
				TowerIter<G> prev;
				Range.improve_bookmark<G> (_range, null, out prev);
				Tower.search_from_bookmark<G> (_range._set._cmp, element, ref prev);
				if (prev._iter[0] == _range._set._head || !Range.inside (_range, prev._iter[0]._data)) {
					return null;
				}
				return prev._iter[0]._data;
			case Range.Position.AFTER:
				return last ();
			default:
				assert_not_reached ();
			}
		}

		public override G? higher (G element) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			switch (Range.cmp<G> (_range, element)) {
			case Range.Position.BEFORE:
				return first ();
			case Range.Position.INSIDE:
				TowerIter<G> prev;
				TowerIter<G> curr;
				Range.improve_bookmark<G> (_range, null, out prev);
				if (Tower.search_from_bookmark<G> (_range._set._cmp, element, ref prev, out curr)) {
					if (!Tower.proceed<G> (_range._set._cmp, ref prev._iter[0], ref curr._iter[0], 0)) {
						return null;
					}
				}
				if (curr._iter[0] == null || !Range.inside(_range, curr._iter[0]._data)) {
					return null;
				}
				return curr._iter[0]._data;
			case Range.Position.AFTER:
			case Range.Position.EMPTY:
				return null;
			default:
				assert_not_reached ();
			}
		}

		public override G? floor (G element) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			switch (Range.cmp<G> (_range, element)) {
			case Range.Position.BEFORE:
			case Range.Position.EMPTY:
				return null;
			case Range.Position.INSIDE:
				TowerIter<G> curr;
				TowerIter<G> prev;
				Range.improve_bookmark<G> (_range, null, out prev);
				if (!Tower.search_from_bookmark<G> (_range._set._cmp, element, ref prev, out curr)) {
					curr._iter[0] = (owned)prev._iter[0];
				}
				if (curr._iter[0] == null || curr._iter[0].is_head () || !Range.inside(_range, curr._iter[0]._data)) {
					return null;
				}
				return curr._iter[0]._data;
			case Range.Position.AFTER:
				return last ();
			default:
				assert_not_reached ();
			}
		}

		public override G? ceil (G element) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			switch (Range.cmp<G> (_range, element)) {
			case Range.Position.BEFORE:
				return first ();
			case Range.Position.INSIDE:
				TowerIter<G> curr;
				TowerIter<G> prev;
				Range.improve_bookmark<G> (_range, null, out prev);
				Tower.search_from_bookmark<G> (_range._set._cmp, element, ref prev, out curr);
				if (curr._iter[0] == null || !Range.inside(_range, curr._iter[0]._data)) {
					return null;
				}
				return curr._iter[0]._data;
			case Range.Position.AFTER:
			case Range.Position.EMPTY:
				return null;
			default:
				assert_not_reached ();
			}
		}

		public override SortedSet<G> head_set (G before) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			return new SubSet<G> (Range.cut_tail (_range, before));
		}

		public override SortedSet<G> tail_set (G after) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			return new SubSet<G> (Range.cut_head (_range, after));
		}

		public override SortedSet<G> sub_set (G from, G to) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			return new SubSet<G> (Range.cut (_range, from, to));
		}

		private Range<G> _range;
	}

	private class SubIterator<G> : Object, Traversable<G>, Vala.Iterator<G> {
		public SubIterator (Range<G> range) {
			Range.improve_bookmark<G> (range);
			_range = range;
		}

		public SubIterator.point_at (Range<G> range, ref TowerIter<G> prev, owned Tower<G> curr) {
			Range.improve_bookmark<G> (range);
			_range = range;
			_prev = prev;
			_curr = curr;
		}

		public SubIterator.from_iterator (SubIterator<G> iter) {
			Range.improve_bookmark<G> (iter._range);
			_range = iter._range;
			_prev = iter._prev;
			_curr = iter._curr;
			_removed = iter._removed;
		}

		public new bool foreach (ForallFunc<G> f) {
			assert (_curr != null);
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			if (!begin ()) {
				return true;
			}
			if (_prev._iter[0] != null && !_removed) {
				if (!f (_curr._data)) {
					assert (_curr != null);
					return false;
				}
			}
			Tower<G> new_prev = _prev._iter[0];
			Tower<G>? new_curr = _curr;
			while (Range.proceed<G> (_range, ref new_prev, ref new_curr, 0)) {
				assert (_curr != null);
				if (!f (_curr._data)) {
					assert (_curr != null);
					return false;
				}
				if (!_removed) {
					//FIXME: Help mark/delete on the way
					_prev._iter[0] = (owned)new_prev;
					int prev_height = _prev._iter[0].get_height();
					for (int i = 1; i < prev_height; i++) {
						_prev._iter[i] = _prev._iter[0];
					}
				}
				_curr = (owned)new_curr;
				_removed = false;
			}
			assert (_curr != null);
			return true;
		}

		public Vala.Iterator<G>[] tee (uint forks) {
			if (forks == 0) {
				return new Vala.Iterator<G>[0];
			} else {
				Vala.Iterator<G>[] result = new Vala.Iterator<G>[forks];
				result[0] = this;
				for (uint i = 1; i < forks; i++) {
					result[i] = new SubIterator<G>.from_iterator (this);
				}
				return result;
			}
		}

		public bool next () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			if (_prev._iter[0] == null) {
				return begin ();
			} else {
				Tower<G> new_prev = _prev._iter[0];
				Tower<G> new_curr = _curr;
				if (Range.proceed<G> (_range, ref new_prev, ref new_curr, 0)) {
					if (!_removed) {
						//FIXME: Help mark/delete on the way
						_prev._iter[0] = (owned)new_prev;
						int prev_height = _prev._iter[0].get_height();
						for (int i = 1; i < prev_height; i++) {
							_prev._iter[i] = _prev._iter[0];
						}
					}
					_curr = (owned)new_curr;
					_removed = false;
					return true;
				} else {
					return false;
				}
			}
		}

		public bool has_next () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			if (_prev._iter[0] == null) {
				Tower<G> next;
				Range.improve_bookmark<G> (_range, out next);
				if (next != null && Range.beyond<G> (_range, next)) {
					next = null;
				}
				return next != null;
			} else {
				Tower<G> new_prev = _prev._iter[0];
				Tower<G> new_curr = _curr;
				return Range.proceed<G> (_range, ref new_prev, ref new_curr, 0);
			}
		}

		public new G get () {
			assert (valid);
			return _curr._data;
		}

		public void remove () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			assert (valid);
			if (Tower.remove<G> (_range._set._cmp, ref _prev, _curr)) {
				AtomicInt.dec_and_test (ref _range._set._size);
			}
			_removed = true;
		}

		public bool valid {
			get {
				bool is_valid = _prev._iter[0] != null && !_removed;
				assert (!is_valid || _curr != null);
				return is_valid;
			}
		}

		public bool read_only { get { return false; } }

		private bool begin () {
			if (_prev._iter[0] != null) {
				return true;
			}
			Range.improve_bookmark<G> (_range, out _curr, out _prev);
			if (_curr == null) {
				for (int i = 0; i < _MAX_HEIGHT; i++) {
					_prev._iter[i] = null;
				}
			}
			return _curr != null;
		}

		protected Range<G> _range;
		protected TowerIter<G> _prev;
		protected Tower<G>? _curr = null;
		protected bool _removed = false;
	}

	private class Range<G> {
		public G? _start;
		public G? _end;
		public RangeType _type;
		public TowerIter<G> _bookmark;
		public ConcurrentSet<G> _set;

		public Range (ConcurrentSet<G> cset, G start, G end) {
			_start = start;
			_end = end;
			if (cset._cmp(start, end) < 0) {
				_type = RangeType.BOUNDED;
				for (int i = 0; i < _MAX_HEIGHT; i++) {
					_bookmark._iter[i] = cset._head;
				}
			} else {
				_type = RangeType.EMPTY;
			}
			_set = cset;
		}

		public Range.head (ConcurrentSet<G> cset, G end) {
			_end = end;
			_type = RangeType.HEAD;
			for (int i = 0; i < _MAX_HEIGHT; i++) {
				_bookmark._iter[i] = cset._head;
			}
			_set = cset;
		}

		public Range.tail (ConcurrentSet<G> cset, G start) {
			_start = start;
			_type = RangeType.TAIL;
			for (int i = 0; i < _MAX_HEIGHT; i++) {
				_bookmark._iter[i] = cset._head;
			}
			_set = cset;
		}

		public Range.empty (ConcurrentSet<G> cset) {
			_type = RangeType.EMPTY;
			_set = cset;
		}

		private void copy_bookmark (Range<G> range) {
			for (int i = 0; i < _MAX_HEIGHT; i++) {
				_bookmark._iter[i] = HazardPointer.get_pointer<Tower<G>> (&range._bookmark._iter[i]);
			}
		}

		public static Range<G> cut_head<G> (Range<G> from, G start) {
			Range<G> result = new Range<G>.empty (from._set);
			switch (from._type) {
			case RangeType.HEAD:
				if (from._set._cmp (start, from._end) < 0) {
					result._start = start;
					result._end = from._end;
					result._type = RangeType.BOUNDED;
				} else {
					result._type = RangeType.EMPTY;
				}
				break;
			case RangeType.TAIL:
				result._start = from._set.max (from._start, start);
				result._type = RangeType.TAIL;
				break;
			case RangeType.BOUNDED:
				if (from._set._cmp (from._start, start) < 0) {
					result._start = from._set.max (from._start, start);
					result._end = from._end;
					result._type = RangeType.BOUNDED;
				} else {
					result._type = RangeType.EMPTY;
				}
				break;
			case RangeType.EMPTY:
				result._type = RangeType.EMPTY;
				break;
			default:
				assert_not_reached ();
			}
			if (result._type != RangeType.EMPTY) {
				improve_bookmark<G> (from);
				result.copy_bookmark (from);
				improve_bookmark<G> (result);
			}
			return result;
		}

		public static Range<G> cut_tail<G> (Range<G> from, G end) {
			Range<G> result = new Range<G>.empty (from._set);
			switch (from._type) {
			case RangeType.HEAD:
				result._end = from._set.min (from._end, end);
				result._type = RangeType.HEAD;
				break;
			case RangeType.TAIL:
				if (from._set._cmp (from._start, end) < 0) {
					result._start = from._start;
					result._end = end;
					result._type = RangeType.BOUNDED;
				} else {
					result._type = RangeType.EMPTY;
				}
				break;
			case RangeType.BOUNDED:
				if (from._set._cmp (from._start, end) < 0) {
					result._start = from._start;
					result._end = from._set.min (from._end, end);
					result._type = RangeType.BOUNDED;
				} else {
					result._type = RangeType.EMPTY;
				}
				break;
			case RangeType.EMPTY:
				result._type = RangeType.EMPTY;
				break;
			default:
				assert_not_reached ();
			}
			if (result._type != RangeType.EMPTY) {
				improve_bookmark<G> (from);
				result.copy_bookmark (from);
				improve_bookmark<G> (result);
			}
			return result;
		}

		public static Range<G> cut<G> (Range<G> from, G start, G end) {
			Range<G> result = new Range<G>.empty (from._set);
			result._type = RangeType.BOUNDED;
			switch (from._type) {
			case RangeType.HEAD:
				end = from._set.min (from._end, end);
				break;
			case RangeType.TAIL:
				start = from._set.max (from._start, start);
				break;
			case RangeType.BOUNDED:
				start = from._set.max (from._start, start);
				end = from._set.min (from._end, end);
				break;
			case RangeType.EMPTY:
				result._type = RangeType.EMPTY;
				break;
			default:
				assert_not_reached ();
			}
			if (result._type != RangeType.EMPTY && from._set._cmp (start, end) < 0) {
				result._start = start;
				result._end = end;
				result._type = RangeType.BOUNDED;
			} else {
				result._type = RangeType.EMPTY;
			}
			if (result._type != RangeType.EMPTY) {
				improve_bookmark<G> (from);
				result.copy_bookmark (from);
				improve_bookmark<G> (result);
			}
			return result;
		}

		public static void improve_bookmark<G> (Range<G> range, out Tower<G>? out_curr = null, out TowerIter<G> prev = null) {
			prev = TowerIter<G>();
			out_curr = null;
			switch (range._type) {
			case RangeType.HEAD:
				if (&out_curr != null) {
					out_curr = HazardPointer.get_pointer<Tower<G>> (&range._bookmark._iter[0]);
					if (&prev != null) {
						prev._iter[0] = (owned)out_curr;
						out_curr = prev._iter[0].get_next (0);
					} else {
						out_curr = out_curr.get_next (0);
					}
				}
				if (&prev != null) {
					for (int i = &out_curr != null ? 1 : 0; i < _MAX_HEIGHT; i++) {
						prev._iter[i] = HazardPointer.get_pointer<Tower<G>> (&range._bookmark._iter[i]);
					}
				}
				break;
			case RangeType.EMPTY:
				out_curr = null;
				break;
			case RangeType.TAIL:
			case RangeType.BOUNDED:
				Tower<G>? last_best = null;
				for (int i = _MAX_HEIGHT - 1; i >= 0; i--) {
					Tower<G> curr = HazardPointer.get_pointer<Tower<G>> (&range._bookmark._iter[i]);
					Tower<G> curr_old = curr;
					assert (curr != null);
					Tower.backtrace<G> (ref curr, (uint8)i);
					if (last_best != null && last_best != curr && Tower.compare<G> (range._set._cmp, curr, last_best) < 0) {
						curr = last_best;
					}
					if (curr != curr_old) {
						if (!HazardPointer.compare_and_exchange_pointer<Tower<G>> (&range._bookmark._iter[i], curr_old, curr)) {
							curr = HazardPointer.get_pointer<Tower<G>> (&range._bookmark._iter[i]);
						}
					}
					Tower<G> next = curr.get_next ((uint8)i);
					if (&out_curr != null && i == 0) {
						out_curr = next;
					}
					while (next != null && Tower.compare_data<G> (range._set._cmp, next, range._start) < 0) {
						Tower.proceed<G> (range._set._cmp, ref curr, ref next, (uint8)i, true);
						if (&curr != null && i == 0 && next != null) {
							out_curr = next;
						}
						if (Tower.compare_data<G> (range._set._cmp, curr, range._start) < 0) {
							if (!HazardPointer.compare_and_exchange_pointer<Tower<G>> (&range._bookmark._iter[i], curr_old, curr)) {
								curr = HazardPointer.get_pointer<Tower<G>> (&range._bookmark._iter[i]);
							}
							curr_old = curr;
						} else {
							break;
						}
					}
					if (&prev != null) {
						prev._iter[i] = curr;
					}
					last_best = (owned)curr;
				}
				break;
			default:
				assert_not_reached ();
			}
			if (&out_curr != null && out_curr != null && Range.beyond<G> (range, out_curr)) {
				out_curr = null;
			}
#if DEBUG
			stderr.printf("Bookmark after:\n");
			for (int i = _MAX_HEIGHT - 1; i >= 0; i--) {
				stderr.printf("    Level %d:\n", i);
				Tower<string>? t = HazardPointer.get_pointer<Tower<string>> (&range._bookmark._iter[i]);
				assert (t == null || t.get_height () > i);
				while (t != null) {
					stderr.printf("      %s\n", t.is_head () ? "<<head>>" : t._data);
					t = t.get_next ((uint8)i);
					assert (t == null || t.get_height () > i);
				}
			}
#endif
		}

		public static bool proceed<G> (Range<G> range, ref Tower<G>? prev, ref Tower<G> curr, uint8 level) {
			switch (range._type) {
			case RangeType.EMPTY:
				return false;
			case RangeType.TAIL:
				return Tower.proceed<G> (range._set._cmp, ref prev, ref curr, level);
			case RangeType.HEAD:
			case RangeType.BOUNDED:
				Tower<G>? tmp_prev = prev;
				Tower<G>? tmp_curr = curr;
				if (!Tower.proceed<G> (range._set._cmp, ref tmp_prev, ref tmp_curr, level)) {
					return false;
				} else if (Tower.compare_data<G> (range._set._cmp, tmp_curr, range._end) >= 0) {
					return false;
				} else {
					prev = (owned)tmp_prev;
					curr = (owned)tmp_curr;
					return true;
				}
			default:
				assert_not_reached ();
			}
		}

		public static bool inside<G> (Range<G> range, G val) {
			switch (range._type) {
			case RangeType.HEAD:
				return range._set._cmp (val, range._end) < 0;
			case RangeType.TAIL:
				return range._set._cmp (val, range._start) >= 0;
			case RangeType.BOUNDED:
				return range._set._cmp (val, range._start) >= 0 && range._set._cmp (val, range._end) < 0;
			case RangeType.EMPTY:
				return false;
			default:
				assert_not_reached ();
			}
		}

		public static bool beyond<G> (Range<G> range, Tower<G> tw) {
			switch (range._type) {
			case RangeType.EMPTY:
				return true;
			case RangeType.TAIL:
				return false;
			case RangeType.HEAD:
			case RangeType.BOUNDED:
				return Tower.compare_data<G> (range._set._cmp, tw, range._end) >= 0;
			default:
				assert_not_reached ();
			}
		}

		public static int cmp<G> (Range<G> range, G val) {
			switch (range._type) {
			case RangeType.HEAD:
				return range._set._cmp (val, range._end) < 0 ? Position.INSIDE : Position.AFTER;
			case RangeType.TAIL:
				return range._set._cmp (val, range._start) >= 0 ? Position.INSIDE : Position.BEFORE;
			case RangeType.BOUNDED:
				return range._set._cmp (val, range._start) >= 0 ? (range._set._cmp (val, range._end) < 0 ? Position.INSIDE : Position.AFTER) : Position.BEFORE;
			case RangeType.EMPTY:
				return Position.EMPTY;
			default:
				assert_not_reached ();
			}
		}

		enum Position {
			BEFORE = -1,
			INSIDE = 0,
			AFTER = 1,
			EMPTY
		}
	}

	public enum RangeType {
		HEAD,
		TAIL,
		BOUNDED,
		EMPTY
	}

	private class Tower<G> {
		public inline Tower (G data, uint8 height) {
			_nodes = new TowerNode<G>[height];
			_data = data;
			_height = 0;
			AtomicPointer.set (&_nodes[0]._backlink, null); // FIXME: This should be memory barrier
		}

		public inline Tower.head () {
			_nodes = new TowerNode<G>[_MAX_HEIGHT];
			_height = -1;
#if DEBUG
			_data = (G)"<<head>>";
#endif
		}

		inline ~Tower () {
			int height = get_height();
			for (uint8 i = 0; i < height; i++) {
				set_succ (null, State.NONE, i);
				set_backlink (null, i);
			}
			_nodes = null;
		}

		public static inline bool search<G> (CompareDataFunc<G>? cmp, G key, ref Tower<G> prev, out Tower<G>? next = null, uint8 to_level = 0, uint8 from_level = (uint8)_MAX_HEIGHT - 1) {
			assert (from_level >= to_level);
			bool res = false;
			next = null;
			for (int i = from_level; i >= to_level; i--) {
				res = search_helper<G> (cmp, key, ref prev, out next, (uint8)i);
			}
			return res;
		}

		public static inline bool search_from_bookmark<G> (CompareDataFunc<G>? cmp, G key, ref TowerIter<G> prev, out TowerIter<G> next = null, uint8 to_level = 0, uint8 from_level = (uint8)_MAX_HEIGHT - 1) {
			assert (from_level >= to_level);
			next = TowerIter<G>();
			bool res = false;
			for (int i = from_level; i >= to_level; i--) {
				unowned Tower<G> tmp_prev = prev._iter[i]; // Should be treated as NULL-like value
				Tower<G> tmp_next;
				res = search_helper<G> (cmp, key, ref prev._iter[i], out tmp_next, (uint8)i);
				if (&next != null) {
					next._iter[i] = (owned)tmp_next;
				}
				if (prev._iter[i] != tmp_prev) {
					prev._iter[i] = prev._iter[i];
					if (i > to_level && compare<G> (cmp, prev._iter[i - 1], prev._iter[i]) <= 0) {
						prev._iter[i - 1] = prev._iter[i];
					}
				}
			}
			return res;
		}

		private static inline bool search_helper<G> (CompareDataFunc<G>? cmp, G key, ref Tower<G>? prev, out Tower<G>? next, uint8 level) {
			next = prev.get_next (level);
			while (next != null && compare_data<G> (cmp, next, key) < 0 && proceed<G> (cmp, ref prev, ref next, level, true));
			return next != null && cmp(key, next._data) == 0;
		}

		public static inline Tower<G>? insert<G> (CompareDataFunc<G>? cmp, ref TowerIter<G> prev, G key, uint8 chosen_level) {
			return insert_helper<G> (cmp, ref prev, key, chosen_level, chosen_level);
		}

		private static inline Tower<G>? insert_helper<G> (CompareDataFunc<G>? cmp, ref TowerIter<G> prev, G key, uint8 chosen_level, uint8 level) {
			Tower<G>? new_tower;
			Tower<G>? next;
			if (search_helper (cmp, key, ref prev._iter[level], out next, level)) {
				return null;
			}
			if (level > 0) {
				if (compare<G> (cmp, prev._iter[level], prev._iter[level - 1]) >= 0) {
					prev._iter[level - 1] = prev._iter[level];
				}
				new_tower = insert_helper<G> (cmp, ref prev, key, chosen_level, level - 1);
			} else {
				new_tower = new Tower<G> (key, chosen_level + 1);
			}
			if (new_tower == null) {
				return null;
			}
			while (true) {
				State prev_state;
				Tower<G>? prev_next = prev._iter[level].get_succ (out prev_state, level);
				if (prev_state == State.FLAGGED) {
					prev_next.help_flagged (prev._iter[level], level);
				} else {
					new_tower.set_succ (next, State.NONE, level);
					bool result = prev._iter[level].compare_and_exchange (next, State.NONE, new_tower, State.NONE, level);
					if (result)
						break;
					prev_next = prev._iter[level].get_succ (out prev_state, level);
					if (prev_state == State.FLAGGED) {
						prev_next.help_flagged (prev._iter[level], level);
					}
					backtrace<G> (ref prev._iter[level], level);
				}
				if (search_helper (cmp, key, ref prev._iter[level], null, level)) {
					return null;
				}
			}
			GLib.AtomicInt.inc (ref new_tower._height);
			if (new_tower.get_state (0) == State.MARKED) {
				remove_level (cmp, ref prev._iter[level], new_tower, level);
				return null;
			}
			return new_tower;
		}

		public static inline bool remove_key<G> (CompareDataFunc<G>? cmp, ref TowerIter<G> prev, G key, uint8 from_level = (uint8)_MAX_HEIGHT - 1) {
			for (int i = from_level; i >= 1; i--) {
				Tower<G> next;
				search_helper<G> (cmp, key, ref prev._iter[i], out next, (uint8)i);
				if (compare<G> (cmp, prev._iter[i - 1], prev._iter[i]) < 0) {
					prev._iter[i - 1] = prev._iter[i];
				}
			}
			Tower<G>? curr;
			if (search_helper<G> (cmp, key, ref prev._iter[0], out curr, 0)) {
				return remove<G> (cmp, ref prev, curr);
			} else {
				return false;
			}
		}

		public static inline bool remove<G> (CompareDataFunc<G>? cmp, ref TowerIter<G> prev, Tower<G> curr) {
			bool removed = remove_level (cmp, ref prev._iter[0], curr, 0);
			for (int i = 1; i < _MAX_HEIGHT; i++) {
				remove_level (cmp, ref prev._iter[i], curr, (uint8)i);
			}
			return removed;
		}

		private static inline bool remove_level (CompareDataFunc<G>? cmp, ref Tower<G> prev, Tower<G> curr, uint8 level) {
			bool status;
			bool flagged = curr.try_flag (cmp, ref prev, out status, level);
			if (status) {
				curr.help_flagged (prev, level);
			}
			return flagged;
		}

		public static inline bool proceed<G> (CompareDataFunc<G>? cmp, ref Tower<G>? arg_prev, ref Tower<G> arg_curr, uint8 level, bool force = false) {
			Tower<G> curr = arg_curr;
			Tower<G>? next = curr.get_next (level);
			if (next != null) {
				while (next != null && next.get_state (0) == State.MARKED) {
					bool status;
					next.try_flag (cmp, ref curr, out status, level);
					if (status) {
						next.help_flagged (curr, level);
					}
					next = curr.get_next (level);
				}
			}
			bool success = next != null;
			if (success || force) {
				arg_prev = (owned)curr;
				arg_curr = (owned)next;
			}
			return success;
		}

		public inline void help_marked (Tower<G> prev_tower, uint8 level) {
			prev_tower.compare_and_exchange (this, State.FLAGGED, get_next (level), State.NONE, level);
		}

		public inline void help_flagged (Tower<G> prev, uint8 level) {
			set_backlink (prev, level);
			if (get_state (level) != State.MARKED)
				try_mark (level);
			help_marked (prev, level);
		}

		public inline void try_mark (uint8 level) {
			do {
				Tower<G>? next_tower = get_next (level);
				bool result = compare_and_exchange (next_tower, State.NONE, next_tower, State.MARKED, level);
				if (!result) {
					State state;
					next_tower = get_succ (out state, level);
					if (state == State.FLAGGED)
						help_flagged (next_tower, level);
				}
			} while (get_state (level) !=  State.MARKED);
		}

		public inline bool try_flag (CompareDataFunc<G>? cmp, ref Tower<G> prev_tower, out bool status, uint8 level) {
			while (true) {
				if (prev_tower.compare_succ (this, State.FLAGGED, level)) {
					status = true;
					return false;
				}
				bool result = prev_tower.compare_and_exchange (this, State.NONE, this, State.FLAGGED, level);
				if (result) {
					status = true;
					return true;
				}
				State result_state;
				Tower<G>? result_tower = prev_tower.get_succ (out result_state, level);
				if (result_tower == this && result_state == State.FLAGGED) {
					status = true;
					return false;
				}
				backtrace<G> (ref prev_tower, level);
				if (!search_helper (cmp, _data, ref prev_tower, null, level)) {
					status = false;
					return false;
				}
			}
		}

		public static inline void backtrace<G> (ref Tower<G>? curr, uint8 level) {
			while (curr.get_state (level) == State.MARKED)
				curr = curr.get_backlink (level);
		}

		public inline bool compare_and_exchange (Tower<G>? old_tower, State old_state, Tower<G>? new_tower, State new_state, uint8 level) {
			return HazardPointer.compare_and_exchange_pointer<Tower<G>?> (&_nodes[level]._succ, old_tower, new_tower, 3, (size_t)old_state, (size_t)new_state);
		}

		public inline bool compare_succ (Tower<G>? next, State state, uint8 level) {
			size_t cur = (size_t)AtomicPointer.get (&_nodes[level]._succ);
			return cur == ((size_t)next | (size_t)state);
		}

		public inline Tower<G>? get_next (uint8 level) {
			return get_succ (null, level);
		}

		public inline State get_state (uint8 level) {
			return (State)((size_t)AtomicPointer.get (&_nodes[level]._succ) & 3);
		}

		public inline Tower<G>? get_succ (out State state, uint8 level) {
			size_t rstate;
			Tower<G>? succ = HazardPointer.get_pointer<Tower<G>> (&_nodes[level]._succ, 3, out rstate);
			state = (State)rstate;
			return (owned)succ;
		}

		public inline void set_succ (Tower<G>? next, State state, uint8 level) {
			HazardPointer.set_pointer<Tower<G>> (&_nodes[level]._succ, next, 3, (size_t)state);
		}

		public inline Tower<G>? get_backlink (uint8 level) {
			return HazardPointer.get_pointer<Tower<G>> (&_nodes[level]._backlink);
		}

		public inline void set_backlink (Tower<G>? backlink, uint8 level) {
			HazardPointer.compare_and_exchange_pointer<Tower<G>?> (&_nodes[level]._backlink, null, backlink);
		}

		public inline int get_height () {
			int height = GLib.AtomicInt.get (ref _height);
			return height != -1 ? height : _MAX_HEIGHT;
		}

		public inline bool is_head () {
			int height = GLib.AtomicInt.get (ref _height);
			return height == -1;
		}

		public inline static int compare<G> (CompareDataFunc<G>? cmp, Tower<G> a, Tower<G> b) {
			bool ah = GLib.AtomicInt.get (ref a._height) == -1;
			bool bh = GLib.AtomicInt.get (ref b._height) == -1;
			return ah ? (bh ? 0 : -1) : (bh ? 1 : cmp(a._data, b._data));
		}

		public inline static int compare_data<G> (CompareDataFunc<G>? cmp, Tower<G> a, G b) {
			bool ah = GLib.AtomicInt.get (ref a._height) == -1;
			return ah ? -1 : cmp(a._data, b);
		}

		[CCode (array_length = false)]
		public TowerNode<G>[] _nodes;
		public G _data;
		public int _height;
	}

	private struct TowerNode<G> {
		public Tower<G> *_succ;
		public Tower<G> *_backlink;
	}

	private struct TowerIter<G> {
		[CCode (array_length = false)]
		public Tower<G>? _iter[31 /*_MAX_HEIGHT*/];
	}


	private enum State {
		NONE = 0,
		MARKED = 1,
		FLAGGED = 2
	}
}

