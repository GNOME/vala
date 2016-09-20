/* concurrentlist.vala
 *
 * Copyright (C) 2011-2014  Maciej Piechotka
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
 * A single-linked list. This implementation is based on
 * [[http://www.cse.yorku.ca/~ruppert/papers/lfll.pdf|Mikhail Fomitchev and  Eric Ruppert paper ]].
 *
 * Many threads are allowed to operate on the same structure as well as modification
 * of structure during iteration is allowed. However the change may not be immediately
 * visible to other threads.
 */
public class Vala.ConcurrentList<G> : AbstractList<G> {
	/**
	 * The elements' equality testing function.
	 */
	[CCode (notify = false)]
	public Vala.EqualDataFunc<G> equal_func {
		private set {}
		get {
			return _equal_func.func;
		}
	}

	/**
	 * Construct new, empty single linked list
	 *
	 * If not provided, the function parameter is requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param equal_func an optional element equality testing function
	 */
	public ConcurrentList (owned Vala.EqualDataFunc<G>? equal_func = null) {
		if (equal_func == null) {
			equal_func = Vala.Functions.get_equal_func_for (typeof (G));
		}
		_equal_func = new Functions.EqualDataFuncClosure<G>((owned)equal_func);
		_head = new Node<G>.head ();
		HazardPointer.set_pointer<Node<G>> (&_tail, _head);
	}

	internal ConcurrentList.with_closure (owned Functions.EqualDataFuncClosure<G> equal_func) {
		_equal_func = (owned)equal_func;
		_head = new Node<G>.head ();
		HazardPointer.set_pointer<Node<G>> (&_tail, _head);
	}

	~ConcurrentList () {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		_head = null;
		HazardPointer.set_pointer<Node<G>?> (&_tail, null);
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool read_only {
		get {
			return false;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override int size {
		get {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			int result = 0;
			for (var iter = iterator (); iter.next ();)
				result++;
			return result;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public bool is_empty {
		get {
			return !iterator ().next ();
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool contains (G item) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		for (var iter = iterator (); iter.next ();)
			if (equal_func (item, iter.get ()))
				return true;
		return false;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool add (G item) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		Node<G> node = new Node<G> (item);
		node.insert (get_tail (), null);
		return true;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool remove (G item) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		Vala.Iterator<G> iter = iterator ();
		while (iter.next ()) {
			if (equal_func (item, iter.get ())) {
				iter.remove ();
				return true;
			}
		}
		return false;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void clear () {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		var iter = iterator ();
		while (iter.next ())
			iter.remove ();
		HazardPointer.set_pointer (&_tail, _head);
	}

	/**
	 * {@inheritDoc}
	 */
	public override Vala.Iterator<G> iterator () {
		return new Iterator<G> (_head);
	}

	/**
	 * {@inheritDoc}
	 */
	public override ListIterator<G> list_iterator () {
		return new Iterator<G> (_head);
	}

	/**
	 * {@inheritDoc}
	 */
	public override G? get (int index) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		assert (index >= 0);
		for (var iterator = iterator (); iterator.next ();)
			if (index-- == 0)
				return iterator.get ();
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public override void set (int index, G item) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		assert (index >= 0);
		for (var iterator = list_iterator (); iterator.next ();) {
			if (index-- == 0) {
				iterator.set (item);
				return;
			}
		}
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public override int index_of (G item) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		int index = 0;
		for (var iterator = list_iterator (); iterator.next (); index++)
			if (equal_func (item, iterator.get ()))
				return index;
		return -1;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void insert (int index, G item) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		assert (index >= 0);
		if (index == 0) {
			var prev = _head;
			var next = _head.get_next ();
			Node<G> new_node = new Node<G> (item);
			new_node.insert (prev, next);
		} else {
			for (var iterator = list_iterator (); iterator.next ();) {
				if (--index == 0) {
					iterator.add (item);
					return;
				}
			}
			assert_not_reached ();
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override G remove_at (int index) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		for (var iterator = list_iterator (); iterator.next ();) {
			if (index-- == 0) {
				G data = iterator.get ();
				iterator.remove ();
				return data;
			}
		}
		assert_not_reached ();
	}

	/**
	 * {@inheritDoc}
	 */
	public override List<G>? slice (int start, int end) {
		HazardPointer.Context ctx = new HazardPointer.Context ();
		Utils.Misc.unused (ctx);
		assert (0 <= start);
		assert (start <= end);
		var list = new ConcurrentList<G>.with_closure (_equal_func);
		var iterator = iterator ();
		int idx = 0;
		for (; iterator.next (); idx++)
			if (idx >= start && idx < end)
				list.add (iterator.get ());
			else if (idx >= end)
				break;
		assert (idx >= end);
		return list;
	}

	private inline Node<G> update_tail () {
		Node<G> tail = HazardPointer.get_pointer (&_tail);
		Node.backtrace<G> (ref tail);
		Node.search_for<G> (null, ref tail);
		HazardPointer.set_pointer<Node<G>> (&_tail, tail);
		return tail;
	}

	private inline Node<G> get_tail () {
		return update_tail ();
	}

	private Node<G> _head;
	private Node<G> *_tail;
	private Functions.EqualDataFuncClosure<G> _equal_func;

	private class Iterator<G> : Object, Vala.Traversable<G>, Vala.Iterator<G>, ListIterator<G> {
		public Iterator (Node<G> head) {
			_removed = false;
			_index = -1;
			_prev = null;
			_curr = head;
		}

		public Iterator.from_iterator (Iterator<G> iter) {
			_removed = iter._removed;
			_index = iter._index;
			_prev = iter._prev;
			_curr = iter._curr;
		}

		public bool next () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			Node<G>? _old_prev = _removed ? _prev : null;
			bool success = Node.proceed<G> (ref _prev, ref _curr);
			if (success) {
				if (_removed)
					_prev = (owned)_old_prev;
				_removed = false;
				_index++;
			}
			return success;
		}

		public bool has_next () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			Node<G>? prev = _prev;
			Node<G> curr = _curr;
			return Node.proceed<G> (ref prev, ref curr);
		}

		public new G get () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			assert (valid);
			return HazardPointer.get_pointer<G> (&_curr._data);
		}

		public new void set (G item) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			assert (valid);
#if DEBUG
			G item_copy = item;
			stderr.printf ("  Setting data %p to %p\n", _curr, item_copy);
			HazardPointer.set_pointer<G> (&_curr._data, (owned)item_copy);
#else
			HazardPointer.set_pointer<G> (&_curr._data, item);
#endif
		}

		public void remove () {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			assert (valid);
			_curr.remove (_prev);
			_removed = true;
			_index--;
		}

		public bool valid {
			get {
				assert (_curr != null);
				return _prev != null && !_removed;
			}
		}

		public bool read_only { get { return false; } }

		public int index() {
			assert (valid);
			return _index;
		}

		public void add (G item) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			assert (valid);
			if (!Node.proceed<G> (ref _prev, ref _curr)) {
				_prev = (owned)_curr;
				_curr = null;
			}
			Node<G> new_node = new Node<G> (item);
			new_node.insert (_prev, _curr);
			_curr = (owned)new_node;
			_index++;
			_removed = false;
		}

		public new bool foreach (ForallFunc<G> f) {
			HazardPointer.Context ctx = new HazardPointer.Context ();
			Utils.Misc.unused (ctx);
			if (_prev != null && !_removed) {
				if (!f (HazardPointer.get_pointer<G> (&_curr._data))) {
					return false;
				}
			}
			Node<G>? _old_prev = _removed ? _prev : null;
			while (Node.proceed<G> (ref _prev, ref _curr)) {
				if (_removed)
					_prev = (owned)_old_prev;
				_removed = false;
				_index++;
				if (!f (HazardPointer.get_pointer<G> (&_curr._data))) {
					return false;
				}
			}
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

		protected bool _removed;
		protected int _index;
		protected Node<G>? _prev;
		protected Node<G> _curr;
	}

	private class Node<G> {
		public inline Node (G data) {
			AtomicPointer.set (&_succ, null);
			AtomicPointer.set (&_backlink, null);
			G data_copy = data;
			G *data_ptr = (owned)data_copy;
#if DEBUG
			stderr.printf ("  Creating node %p with data %p\n", this, data_ptr);
#endif
			AtomicPointer.set (&_data, (owned)data_ptr);
		}

		public inline Node.head () {
			AtomicPointer.set (&_succ, null);
			AtomicPointer.set (&_backlink, null);
			AtomicPointer.set (&_data, null);
#if DEBUG
			stderr.printf ("  Creating head node %p\n", this);
#endif
		}

		inline ~Node () {
			HazardPointer.set_pointer<Node<G>?> (&_succ, null, 3);
			HazardPointer.set_pointer<Node<G>?> (&_backlink, null);
#if DEBUG
			HazardPointer<G?>? old_data = HazardPointer.exchange_hazard_pointer (&_data, null);
			stderr.printf ("  Freeing node %p (with data %p)\n", this, old_data != null ? old_data.get() : null);
			if (old_data != null) {
				old_data.release (HazardPointer.get_destroy_notify<G?> ());
			}
#else
			HazardPointer.set_pointer<G> (&_data, null);
#endif
		}

		public static inline bool proceed<G> (ref Node<G>? prev, ref Node<G> curr, bool force = false) {
			Node<G>? next = curr.get_next ();
			while (next != null) {
				State next_state = next.get_state ();
				State curr_state;
				Node<G> curr_next = curr.get_succ (out curr_state);
				if (next_state != State.MARKED || (curr_state == State.MARKED && curr_next == next))
					break;
				if (curr_next == next)
					next.help_marked (curr);
				next = curr_next;
			}
			bool success = next != null;
			if (success || force) {
				prev = (owned)curr;
				curr = (owned)next;
#if DEBUG
				stderr.printf ("  Procceed to %p (previous %p)\n", curr, prev);
#endif
			}
			return success;
		}

		public static inline bool search_for<G> (Node<G>? goal, ref Node<G>? prev) {
			Node<G>? curr = prev.get_next ();
			while ((curr != goal || curr != null) && proceed<G> (ref prev, ref curr, true));
			return curr == goal;
		}

		public inline bool remove (Node<G> prev_node) {
#if DEBUG
			stderr.printf ("  Removing %p (previous %p)\n", this, prev_node);
#endif
			Node<G>? prev = prev_node;
			bool result = try_flag (ref prev);
			if (prev != null)
				help_flagged (prev);
			return result;
		}

		public inline void insert (owned Node<G> prev, Node<G>? next) {
#if DEBUG
			stderr.printf ("  Inserting %p between %p and %p\n", this, prev, next);
#endif
			while (true) {
				State prev_state;
				Node<G>? prev_next = get_succ (out prev_state);
				if (prev_state == State.FLAGGED) {
					prev_next.help_flagged (prev);
				} else {
					set_succ (next, State.NONE);
					bool result = prev.compare_and_exchange (next, State.NONE, this, State.NONE);
					if (result)
						return;
					prev_next = get_succ (out prev_state);
					if (prev_state == State.FLAGGED)
						prev_next.help_flagged (prev);
					backtrace<G> (ref prev);
				}
				search_for<G> (next, ref prev);
			}
			
		}

		public inline void help_flagged (Node<G> prev) {
#if DEBUG
			stderr.printf ("    Help flagging %p (previous %p)\n", this, prev);
#endif
			set_backlink (prev);
			if (get_state () != State.MARKED)
				try_mark ();
			help_marked (prev);
		}

		public inline void try_mark () {
#if DEBUG
			stderr.printf ("    Try flagging %p\n", this);
#endif
			do {
				Node<G>? next_node = get_next ();
				bool result = compare_and_exchange (next_node, State.NONE, next_node, State.MARKED);
				if (!result) {
					State state;
					next_node = get_succ (out state);
					if (state == State.FLAGGED)
						help_flagged (next_node);
				}
			} while (get_state () != State.MARKED);
		}

		public inline void help_marked (Node<G> prev_node) {
#if DEBUG
			stderr.printf ("    Help marking %p (previous %p)\n", this, prev_node);
#endif
			prev_node.compare_and_exchange (this, State.FLAGGED, get_next (), State.NONE);
		}

		public inline bool try_flag (ref Node<G>? prev_node) {
#if DEBUG
			stderr.printf ("    Try flagging %p (previous %p)\n", this, prev_node);
#endif
			while (true) {
				if (prev_node.compare_succ (this, State.FLAGGED))
					return false;
				bool result = prev_node.compare_and_exchange (this, State.NONE, this, State.FLAGGED);
				if (result)
					return true;
				State result_state;
				Node<G>? result_node = prev_node.get_succ (out result_state);
				if (result_node == this && result_state == State.FLAGGED)
					return false;
				backtrace<G> (ref prev_node);
				if (!search_for<G> (this, ref prev_node)) {
					prev_node = null;
					return false;
				}
			}
		}

		public static inline void backtrace<G> (ref Node<G>? curr) {
			while (curr.get_state () == State.MARKED)
				curr = curr.get_backlink ();
		}

		public inline bool compare_and_exchange (Node<G>? old_node, State old_state, Node<G>? new_node, State new_state) {
#if DEBUG
			bool b = HazardPointer.compare_and_exchange_pointer (&_succ, old_node, new_node, 3, (size_t)old_state, (size_t)new_state);
			stderr.printf ("      Setting %p.succ to (%p, %s) if %p.succ is (%p, %s): %s\n", this, new_node, new_state.to_string (), this, old_node, old_state.to_string (), b ? "success" : "failure");
			return b;
#else
			return HazardPointer.compare_and_exchange_pointer<Node<G>> (&_succ, old_node, new_node, 3, (size_t)old_state, (size_t)new_state);
#endif
		}

		public inline bool compare_succ (Node<G>? next, State state) {
			size_t cur = (size_t)AtomicPointer.get (&_succ);
			return cur == ((size_t)next | (size_t)state);
		}

		public inline Node<G>? get_next () {
			return get_succ (null);
		}

		public inline State get_state () {
			return (State)((size_t)AtomicPointer.get (&_succ) & 3);
		}

		public inline Node<G>? get_succ (out State state) {
			size_t rstate;
			Node<G>? succ = HazardPointer.get_pointer<Node<G>> (&_succ, 3, out rstate);
			state = (State)rstate;
			return (owned)succ;
		}

		public inline void set_succ (Node<G>? next, State state) {
#if DEBUG
			stderr.printf ("      Setting %p.succ to (%p, %s)\n", this, next, state.to_string ());
#endif
			HazardPointer.set_pointer<Node<G>> (&_succ, next, 3, (size_t)state);
		}

		public inline Node<G>? get_backlink () {
			return HazardPointer.get_pointer<Node<G>> (&_backlink);
		}

		public inline void set_backlink (Node<G>? backlink) {
#if DEBUG
			stderr.printf ("      Setting backlink from %p to %p\n", this, backlink);
#endif
			HazardPointer.compare_and_exchange_pointer<Node<G>?> (&_backlink, null, backlink);
		}

		public Node<G> *_succ;
		public Node<G> *_backlink;
		public G *_data;
	}

	private enum State {
		NONE = 0,
		MARKED = 1,
		FLAGGED = 2
	}
}
