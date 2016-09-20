/* treeset.vala
 *
 * Copyright (C) 2009-2014  Maciej Piechotka
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

using GLib;

/**
 * Left-leaning red-black tree implementation of the {@link Set} interface.
 *
 * This implementation is especially well designed for large quantity of
 * data. The (balanced) tree implementation insure that the set and get
 * methods are in logarithmic complexity. For a linear implementation see
 * {@link HashSet}.
 *
 * @see HashSet
 */
public class Vala.TreeSet<G> : AbstractBidirSortedSet<G> {
	/**
	 * {@inheritDoc}
	 */
	public override int size {
		get {return _size;}
	}
	
	/**
	 * {@inheritDoc}
	 */
	public override bool read_only {
		get { return false; }
	}

	/**
	 * The elements' comparator function.
	 */
	[CCode (notify = false)]
	public CompareDataFunc<G> compare_func {
		private set {}
		get {
			return _compare_func.func;
		}
	}

	private int _size = 0;

	/**
	 * Constructs a new, empty tree set sorted according to the specified
	 * comparator function.
	 *
	 * If not provided, the function parameter is requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param compare_func an optional element comparator function
	 */
	public TreeSet (owned CompareDataFunc<G>? compare_func = null) {
		if (compare_func == null) {
			compare_func = Functions.get_compare_func_for (typeof (G));
		}
		_compare_func = new Functions.CompareDataFuncClosure<G> ((owned)compare_func);
	}

	internal TreeSet.with_closures (owned Functions.CompareDataFuncClosure<G> compare_func) {
		_compare_func = (owned)compare_func;
	}

	~TreeSet () {
		clear ();
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool contains (G item) {
		weak Node<G>? cur = root;
		while (cur != null) {
			int res = compare_func (item, cur.key);
			if (res == 0) {
				return true;
			} else if (res < 0) {
				cur = cur.left;
			} else {
				cur = cur.right;
			}
		}
		return false;
	}

	private inline void rotate_right (ref Node<G> root) {
		Node<G> pivot = (owned) root.left;
		pivot.color = root.color;
		root.color = Node.Color.RED;
		root.left = (owned) pivot.right;
		pivot.right = (owned) root;
		root = (owned) pivot;
#if DEBUG
		stdout.printf (dump ("after rotate right on %s".printf ((string)root.right.key)));
#endif
	}

	private inline void rotate_left (ref Node<G> root) {
		Node<G> pivot = (owned) root.right;
		pivot.color = root.color;
		root.color = Node.Color.RED;
		root.right = (owned) pivot.left;
		pivot.left = (owned) root;
		root = (owned) pivot;
#if DEBUG
		stdout.printf (dump ("after rotate left on %s".printf ((string)root.left.key)));
#endif
	}

	private inline bool is_red (Node<G>? n) {
		return n != null && n.color == Node.Color.RED;
	}

	private inline bool is_black (Node<G>? n) {
		return n == null || n.color == Node.Color.BLACK;
	}

	private inline void fix_up (ref Node<G> node) {
#if DEBUG
		var n = (string)node.key;
#endif
		if (is_black (node.left) && is_red (node.right)) {
			rotate_left (ref node);
		}
		if (is_red (node.left) && is_red (node.left.left)) {
			rotate_right (ref node);
		}
		if (is_red (node.left) && is_red (node.right)) {
			node.flip ();
		}
#if DEBUG
		stdout.printf (dump ("after fix up on %s".printf (n)));
#endif
	}

	private bool add_to_node (ref Node<G>? node, owned G item, Node<G>? prev, Node<G>? next) {
#if DEBUG
		if (node != null)
			stdout.printf ("Adding %s to %s\n".printf ((string) item, (string) node.key));
#endif
		if (node == null) {
			node = new Node<G> ((owned) item, prev, next);
			if (prev == null) {
				_first = node;
			}
			if (next == null) {
				_last = node;
			}
			_size++;
			return true;
		}

		int cmp = compare_func (item, node.key);
		if (cmp == 0) {
			fix_up (ref node);
			return false;
		} else if (cmp < 0) {
			bool r = add_to_node (ref node.left, item, node.prev, node);
			fix_up (ref node);
			return r;
		} else {
			bool r = add_to_node (ref node.right, item, node, node.next);
			fix_up (ref node);
			return r;
		}
	}

	/**
	 * {@inheritDoc}
	 *
	 * If the element already exists in the set it will not be added twice.
	 */
	public override bool add (G item) {
#if CONSISTENCY_CHECKS
		check ();
#endif
		bool r = add_to_node (ref root, item, null, null);
		root.color = Node.Color.BLACK;
#if CONSISTENCY_CHECKS
		check ();
#endif
		stamp++;
		return r;
	}

	private inline void move_red_left (ref Node<G> root) {
#if DEBUG
		var n = (string)root.key;
#endif
		root.flip ();
		if (is_red (root.right.left)) {
			rotate_right (ref root.right);
			rotate_left (ref root);
			root.flip ();
		}
#if DEBUG
		stdout.printf (dump ("after red left on %s".printf (n)));
#endif
	}

	private inline void move_red_right (ref Node<G> root) {
#if DEBUG
		var n = (string)root.key;
#endif
		root.flip ();
		if (is_red (root.left.left)) {
			rotate_right (ref root);
			root.flip ();
		}
#if DEBUG
		stdout.printf (dump ("after red right on %s".printf (n)));
#endif
	}

	private inline void fix_removal (ref Node<G> node, out G? key = null) {
		Node<G> n = (owned)node;
		key = (owned) n.key;
		if (n.prev != null) {
			n.prev.next = n.next;
		} else {
			_first = n.next;
		}
		if (n.next != null) {
			n.next.prev = n.prev;
		} else {
			_last = n.prev;
		}
		node = null;
		_size--;
	}

	private void remove_minimal (ref Node<G> node, out G key) {
		if (node.left == null) {
			fix_removal (ref node, out key);
			return;
		}

		if (is_black (node.left) && is_black (node.left.left)) {
			move_red_left (ref node);
		}

		remove_minimal (ref node.left, out key);

		fix_up (ref node);
	}

	private bool remove_from_node (ref Node<G>? node, G item, out unowned Node<G>? prev = null, out unowned Node<G>? next = null) {
#if DEBUG
		stdout.printf ("Removing %s from %s\n", (string)item, node != null ? (string)node.key : null);
#endif
		if (node == null) {
			prev = null;
			next = null;
			return false;
		} else if (compare_func (item, node.key) < 0) {
			weak Node<G> left = node.left;
			if (left == null) {
				prev = null;
				next = null;
				return false;
			}
			if (is_black (left) && is_black (left.left)) {
				move_red_left (ref node);
			}
			bool r = remove_from_node (ref node.left, item, out prev, out next);
			fix_up (ref node);
			return r;
		} else {
			if (is_red (node.left)) {
				rotate_right (ref node);
			}

			weak Node<G>? r = node.right;
			if (compare_func (item, node.key) == 0 && r == null) {
				prev = node.prev;
				next = node.next;
				fix_removal (ref node, null);
				return true;
			}
			if (is_black (r) && r != null && is_black (r.left)) {
				move_red_right (ref node);
			}
			if (compare_func (item, node.key) == 0) {
				prev = node.prev;
				next = node;
				remove_minimal (ref node.right, out node.key);
				fix_up (ref node);
				return true;
			} else {
				bool re = remove_from_node (ref node.right, item, out prev, out next);
				fix_up (ref node);
				return re;
			}
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool remove (G item) {
#if CONSISTENCY_CHECKS
		check ();
#endif
		bool b = remove_from_node (ref root, item);
		if (root != null) {
			root.color = Node.Color.BLACK;
		}
#if CONSISTENCY_CHECKS
		check ();
#endif
		stamp++;
		return b;
	}

	private inline void clear_subtree (owned Node<G> node) {
		node.key = null;
		if (node.left != null)
			clear_subtree ((owned) node.left);
		if (node.right != null)
			clear_subtree ((owned) node.right);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void clear () {
		if (root != null) {
			clear_subtree ((owned) root);
			_first = _last = null;
		}
		_size = 0;
		stamp++;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool foreach (ForallFunc<G> f) {
		for (unowned Node<G> node = _first; node != null; node = node.next) {
			if (!f (node.key)) {
				return false;
			}
		}
		return true;
	}

	/**
	 * {@inheritDoc}
	 */
	public override Vala.Iterator<G> iterator () {
		return new Iterator<G> (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override BidirIterator<G> bidir_iterator () {
		return new Iterator<G> (this);
	}

	private inline G? lift_null_get (Node<G>? node) {
		return node != null ? node.key : null;
	}

	/**
	 * {@inheritDoc}
	 */
	public override G first () {
		assert (_first != null);
		return _first.key;
	}

	/**
	 * {@inheritDoc}
	 */
	public override G last () {
		assert (_last != null);
		return _last.key;
	}

	/**
	 * {@inheritDoc}
	 */
	public override SortedSet<G> head_set (G before) {
		return new SubSet<G>.head (this, before);
	}

	/**
	 * {@inheritDoc}
	 */
	public override SortedSet<G> tail_set (G after) {
		return new SubSet<G>.tail (this, after);
	}

	/**
	 * {@inheritDoc}
	 */
	public override SortedSet<G> sub_set (G after, G before) {
		return new SubSet<G> (this, after, before);
	}

	private inline unowned Node<G>? find_node (G item) {
		weak Node<G>? cur = root;
		while (cur != null) {
			int res = compare_func (item, cur.key);
			if (res == 0) {
				return cur;
			} else if (res < 0) {
				cur = cur.left;
			} else {
				cur = cur.right;
			}
		}
		return null;
	}

	/**
	 * {@inheritDoc}
	 */
	public override Vala.Iterator<G>? iterator_at (G item) {
		weak Node<G>? node = find_node (item);
		return node != null ? new Iterator<G>.pointing (this, node) : null;
	}

	private inline unowned Node<G>? find_nearest (G item) {
		weak Node<G>? cur = root;
		while (cur != null) {
			int res = compare_func (item, cur.key);
			if (res == 0) {
				return cur;
			} else if (res < 0) {
				if (cur.left == null)
					return cur;
				cur = cur.left;
			} else {
				if (cur.right == null)
					return cur;
				cur = cur.right;
			}
		}
		return null;
	}

	private inline unowned Node<G>? find_lower (G item) {
		weak Node<G>? node = find_nearest (item);
		if (node == null)
			return null;
		return compare_func (item, node.key) <= 0 ? node.prev : node;
	}

	private inline unowned Node<G>? find_higher (G item) {
		weak Node<G>? node = find_nearest (item);
		if (node == null)
			return null;
		return compare_func (item, node.key) >= 0 ? node.next : node;
	}

	private inline unowned Node<G>? find_floor (G item) {
		weak Node<G>? node = find_nearest (item);
		if (node == null)
			return null;
		return compare_func (item, node.key) < 0 ? node.prev : node;
	}

	private inline unowned Node<G>? find_ceil (G item) {
		weak Node<G>? node = find_nearest (item);
		if (node == null)
			return null;
		return compare_func (item, node.key) > 0 ? node.next : node;
	}

	/**
	 * {@inheritDoc}
	 */
	public override G? lower (G item) {
		return lift_null_get (find_lower (item));
	}

	/**
	 * {@inheritDoc}
	 */
	public override G? higher (G item) {
		return lift_null_get (find_higher (item));
	}

	/**
	 * {@inheritDoc}
	 */
	public override G? floor (G item) {
		return lift_null_get (find_floor (item));
	}

	/**
	 * {@inheritDoc}
	 */
	public override G? ceil (G item) {
		return lift_null_get (find_ceil (item));
	}

#if CONSISTENCY_CHECKS
	public inline void check () {
		check_subtree (root);
		assert (root == null || root.color == Node.Color.BLACK);
#if DEBUG
		stdout.printf ("%s\n", dump ());
#endif
	}

	private inline uint check_subtree (Node<G>? node) {
		if (node == null)
			return 0;
		assert (! (is_black (node.left) && is_red (node.right))); // Check left-leaning
		assert (! (is_red (node) && is_red (node.left))); // Check red property
		uint l = check_subtree (node.left);
		uint r = check_subtree (node.right);
		assert (l == r);
		return l + (node.color == Node.Color.BLACK ? 1 : 0);
	}
#endif
#if DEBUG
	public string dump (string? when = null) {
		return "TreeSet dump%s:\n%s".printf (when == null ? "" : (" " + when), dump_node (root));
	}

	private inline string dump_node (Node<G>? node, uint depth = 0) {
		if (node != null)
			return dump_node (node.left, depth + 1) +
			       "%s%s%p(%s)\033[0m\n".printf (string.nfill (depth, ' '),
			                                   node.color == Node.Color.RED ? "\033[0;31m" : "",
			                                   node, (string)node.key) +
			       dump_node (node.right, depth + 1);
		return "";
	}
#endif

	[Compact]
	private class Node<G> {
		public enum Color {
			RED,
			BLACK;

			public Color flip () {
				if (this == RED) {
					return BLACK;
				} else {
					return RED;
				}
			}
		}

		public Node (owned G node, Node<G>? prev, Node<G>? next) {
			this.key = (owned) node;
			this.color = Color.RED;
			this.prev = prev;
			this.next = next;
			if (prev != null) {
				prev.next = this;
			}
			if (next != null) {
				next.prev = this;
			}
		}

		public void flip () {
			color = color.flip ();
			if (left != null) {
				left.color = left.color.flip ();
			}
			if (right != null) {
				right.color = right.color.flip ();
			}
		}

		public G key;
		public Color color;
		public Node<G>? left;
		public Node<G>? right;
		public weak Node<G>? prev;
		public weak Node<G>? next;
	}

	private class Iterator<G> : Object, Traversable<G>, Vala.Iterator<G>, BidirIterator<G> {
		public Iterator (TreeSet<G> set) {
			_set = set;
			stamp = _set.stamp;
		}

		public Iterator.pointing (TreeSet<G> set, Node<G> current) {
			this._set = set;
			this._current = current;
			this.stamp = set.stamp;
			this.started = true;
		}

		public Iterator.from_iterator (Iterator<G> iter) {
			_set = iter._set;
			stamp = iter.stamp;
			_current = iter._current;
			_next = iter._next;
			_prev = iter._prev;
			started = iter.started;
		}

		public bool next () {
			assert (stamp == _set.stamp);
			if (_current != null) {
				if (_current.next != null) {
					_current = _current.next;
					return true;
				} else {
					return false;
				}
			} else if (!started) {
				_current = _set._first;
				started = true;
				return _current != null;
			} else {
				_current = _next;
				if (_current != null) {
					_next = null;
					_prev = null;
				}
				return _current != null;
			}
		}

		public bool has_next () {
			assert (stamp == _set.stamp);
			return (!started && _set._first != null) ||
			       (_current == null && _next != null) ||
			       (_current != null && _current.next != null);
		}

		public bool first () {
			assert (stamp == _set.stamp);
			_current = _set._first;
			_next = null;
			_prev = null;
			started = true;
			return _current != null; // on false it is null anyway
		}

		public bool previous () {
			assert (stamp == _set.stamp);
			if (_current != null) {
				if (_current.prev != null) {
					_current = _current.prev;
					return true;
				} else {
					return false;
				}
			} else {
				if (_prev != null) {
					_current = _prev;
					_next = null;
					_prev = null;
					return true;
				} else {
					return false;
				}
			}
		}

		public bool has_previous () {
			assert (stamp == _set.stamp);
			return (_current == null && _prev != null) ||
			       (_current != null && _current.prev != null);
		}

		public bool last () {
			assert (stamp == _set.stamp);
			_current = _set._last;
			_next = null;
			_prev = null;
			started = true;
			return _current != null; // on false it is null anyway
		}

		public new G get () {
			assert (stamp == _set.stamp);
			assert (_current != null);
			return _current.key;
		}

		public void remove () {
			assert (stamp == _set.stamp);
			assert (_current != null);
			bool success = _set.remove_from_node (ref _set.root, _current.key, out _prev, out _next);
			assert (success);
			if (_set.root != null)
				_set.root.color = Node.Color.BLACK;
			_current = null;
			assert (stamp++ == _set.stamp++);
		}

		internal bool safe_next_get (out G val) {
			if (_current != null) {
				val = _set.lift_null_get (_current.next);
				return _current.next != null;
			} else {
				val = _set.lift_null_get (_next);
				return _next != null;
			}
		}

		internal bool safe_previous_get (out G val) {
			if (_current != null) {
				val = _set.lift_null_get (_current.prev);
				return _current.prev != null;
			} else {
				val = _set.lift_null_get (_prev);
				return _next != null;
			}
		}

		public bool valid {
			get {
				assert (stamp == _set.stamp);
				return _current != null;
			}
		}

		public bool read_only {
			get {
				return false;
			}
		}

		public bool foreach (ForallFunc<G> f) {
			assert (stamp == _set.stamp);
			unowned Node<G>? current = _current, next;
			if (current != null) {
				if (!f (current.key)) {
					return false;
				}
				next = current.next;
			} else if (!started) {
				next = _set._first;
				if (next != null) {
					started = true;
				}
			} else {
				next = _next;
				if (next != null) {
					_next = null;
					_prev = null;
				}
			}
			while (next != null) {
				if (!f (next.key)) {
					_current = next;
					return false;
				}
				current = next;
				next = current.next;
			}
			_current = current;
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

		protected TreeSet<G> _set;
		protected int stamp;
		protected weak Node<G>? _current = null;
		protected weak Node<G>? _next = null;
		protected weak Node<G>? _prev = null;
		protected bool started = false;
	}

	private inline G min (G a, G b) {
		return compare_func (a, b) <= 0 ? a : b;
	}

	private inline G max (G a, G b) {
		return compare_func (a, b) > 0 ? a : b;
	}

	private class Range<G> {
		public Range (TreeSet<G> set, G after, G before) {
			this.set = set;
			if (set.compare_func (after, before) < 0) {
				this.after = after;
				this.before = before;
				type = RangeType.BOUNDED;
			} else {
				type = RangeType.EMPTY;
			}
		}

		public Range.head (TreeSet<G> set, G before) {
			this.set = set;
			this.before = before;
			type = RangeType.HEAD;
		}

		public Range.tail (TreeSet<G> set, G after) {
			this.set = set;
			this.after = after;
			type = RangeType.TAIL;
		}

#if false
		public Range.empty (TreeSet<G> set) {
			this.set = set;
			type = RangeType.EMPTY;
		}
#endif

		public Range<G> cut_head (G after) {
			switch (type) {
			case RangeType.HEAD:
				return new Range<G> (set, after, before);
			case RangeType.TAIL:
				return new Range<G>.tail (set, set.max (after, this.after));
			case RangeType.EMPTY:
				return this;
			case RangeType.BOUNDED:
				var _after = set.max (after, this.after);
				return new Range<G> (set, _after, before);
			default:
				assert_not_reached ();
			}
		}

		public Range<G> cut_tail (G before) {
			switch (type) {
			case RangeType.HEAD:
				return new Range<G>.head (set, set.min (before, this.before));
			case RangeType.TAIL:
				return new Range<G> (set, after, before);
			case RangeType.EMPTY:
				return this;
			case RangeType.BOUNDED:
				var _before = set.min (before, this.before);
				return new Range<G> (set, after, _before);
			default:
				assert_not_reached ();
			}
		}

		public Range<G> cut (G after, G before) {
			if (type == RangeType.EMPTY)
				return this;
			var _before = type != RangeType.TAIL ? set.min (before, this.before) : before;
			var _after = type != RangeType.HEAD ? set.max (after, this.after) : after;
			return new Range<G> (set, _after, _before);
		}

		public bool in_range (G item) {
			return type == RangeType.EMPTY ? false : compare_range (item) == 0;
		}

		public int compare_range (G item) {
			switch (type) {
			case RangeType.HEAD:
				return set.compare_func (item, before) < 0 ? 0 : 1;
			case RangeType.TAIL:
				return set.compare_func (item, after) >= 0 ? 0 : -1;
			case RangeType.EMPTY:
				return 0; // For simplicity - please make sure it does not break anything
			case RangeType.BOUNDED:
				return set.compare_func (item, after) >= 0 ?
					(set.compare_func (item, before) < 0 ? 0 : 1) : -1;
			default:
				assert_not_reached ();
			}
		}

		public bool empty_subset () {
			switch (type) {
			case RangeType.HEAD:
				return set._first == null || !in_range (set._first.key);
			case RangeType.TAIL:
				return set._last == null || !in_range (set._last.key);
			case RangeType.EMPTY:
				return true;
			case RangeType.BOUNDED:
				return first () == null;
			default:
				assert_not_reached ();
			}
		}

		public unowned Node<G>? first () {
			switch (type) {
			case RangeType.EMPTY:
				return null;
			case RangeType.HEAD:
				return set._first;
			default:
				return set.find_floor (after);
			}
		}

		public unowned Node<G>? last () {
			switch (type) {
			case RangeType.EMPTY:
				return null;
			case RangeType.TAIL:
				return set._last;
			default:
				return set.find_lower (before);
			}
		}

		private new TreeSet<G> set;
		private G after;
		private G before;
		private RangeType type;
	}

	private enum RangeType {
		HEAD,
		TAIL,
		EMPTY,
		BOUNDED
	}

	private class SubSet<G> : AbstractBidirSortedSet<G> {
		public SubSet (TreeSet<G> set, G after, G before) {
			this.set = set;
			this.range = new Range<G> (set, after, before);
		}

		public SubSet.head (TreeSet<G> set, G before) {
			this.set = set;
			this.range = new Range<G>.head (set, before);
		}

		public SubSet.tail (TreeSet<G> set, G after) {
			this.set = set;
			this.range = new Range<G>.tail (set, after);
		}

		public SubSet.from_range (TreeSet<G> set, Range<G> range) {
			this.set = set;
			this.range = range;
		}

		public override int size {
			get {
				var i = 0;
				Vala.Iterator<G> iterator = iterator ();
				while (iterator.next ())
					i++;
				return i;
			}
		}

		public override bool read_only {
			get { return true; }
		}

		public bool is_empty {
			get {
				return range.empty_subset ();
			}
		}

		public override bool contains (G item) {
			return range.in_range (item) && set.contains (item);
		}

		public override bool add (G item) {
			return range.in_range (item) && set.add (item);
		}

		public override bool remove (G item) {
			return range.in_range (item) && set.remove (item);
		}

		public override void clear () {
			var iter = iterator ();
			while (iter.next ()) {
				iter.remove ();
			}
		}

		public override Vala.Iterator<G> iterator () {
			return new SubIterator<G> (set, range);
		}

		public override BidirIterator<G> bidir_iterator () {
			return new SubIterator<G> (set, range);
		}

		public override G first () {
			weak Node<G>? _first = range.first ();
			assert (_first != null);
			return _first.key;
		}

		public override G last () {
			weak Node<G>? _last = range.last ();
			assert (_last != null);
			return _last.key;
		}

		public override SortedSet<G> head_set (G before) {
			return new SubSet<G>.from_range (set, range.cut_tail (before));
		}

		public override SortedSet<G> tail_set (G after) {
			return new SubSet<G>.from_range (set, range.cut_head (after));
		}

		public override SortedSet<G> sub_set (G after, G before) {
			return new SubSet<G>.from_range (set, range.cut (after, before));
		}

		public override Vala.Iterator<G>? iterator_at (G item) {
			if (!range.in_range (item))
				return null;
			weak Node<G>? n = set.find_node (item);
			if (n == null)
				return null;
			return new SubIterator<G>.pointing (set, range, n);
		}

		public override G? lower (G item) {
			var res = range.compare_range (item);
			if (res > 0)
				return last ();
			var l = set.lower (item);
			return l != null && range.in_range (l) ? l : null;
		}

		public override G? higher (G item) {
			var res = range.compare_range (item);
			if (res < 0)
				return first ();
			var h = set.higher (item);
			return h != null && range.in_range (h) ? h : null;
		}

		public override G? floor (G item) {
			var res = range.compare_range (item);
			if (res > 0)
				return last ();
			var l = set.floor (item);
			return l != null && range.in_range (l) ? l : null;
		}

		public override G? ceil (G item) {
			var res = range.compare_range (item);
			if (res < 0)
				return first ();
			var h = set.ceil (item);
			return h != null && range.in_range (h) ? h : null;
		}

		protected new TreeSet<G> set;
		protected Range<G> range;
	}

	private class SubIterator<G> : Object, Traversable<G>, Vala.Iterator<G>, BidirIterator<G> {
		public SubIterator (TreeSet<G> set, Range<G> range) {
			this.set = set;
			this.range = range;
		}

		public SubIterator.pointing (TreeSet<G> set, Range<G> range, Node<G> node) {
			this.set = set;
			this.range = range;
			this.iterator = new Iterator<G>.pointing (set, node);
		}

		public SubIterator.from_iterator (SubIterator<G> iter) {
			set = iter.set;
			range = iter.range;
			iterator = new Iterator<G>.from_iterator (iter.iterator);
		}

		public bool next () {
			if (iterator != null) {
				G next;
				if (iterator.safe_next_get (out next) && range.in_range (next)) {
					assert (iterator.next ());
					return true;
				} else {
					return false;
				}
			} else {
				return first ();
			}
		}

		public bool has_next () {
			if (iterator != null) {
				G next;
				return (iterator.safe_next_get (out next) && range.in_range (next));
			} else {
				return range.first () != null;
			}
		}

		public bool first () {
			weak Node<G>? node = range.first ();
			if (node == null)
				return false;
			iterator = new Iterator<G>.pointing (set, node);
			return true;
		}

		public bool previous () {
			if (iterator == null)
				return false;
			G prev;
			if (iterator.safe_previous_get (out prev) && range.in_range (prev)) {
				assert (iterator.previous ());
				return true;
			} else {
				return false;
			}
		}

		public bool has_previous () {
			if (iterator == null)
				return false;
			G prev;
			return iterator.safe_previous_get (out prev) && range.in_range (prev);
		}

		public bool last () {
			weak Node<G>? node = range.last ();
			if (node == null)
				return false;
			iterator = new Iterator<G>.pointing (set, node);
			return true;
		}

		public new G get () {
			assert (iterator != null);
			return iterator.get ();
		}

		public void remove () {
			assert (iterator != null);
			iterator.remove ();
		}

		public bool read_only {
			get {
				return false;
			}
		}

		public bool valid {
			get {
				return iterator.valid;
			}
		}

		public bool foreach(ForallFunc<G> f) {
			if(valid) {
				if (!f(get())) {
					return false;
				}
			}
			while(next()) {
				if (!f(get())) {
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
					result[i] = new SubIterator<G>.from_iterator (this);
				}
				return result;
			}
		}

		protected new TreeSet<G> set;
		protected Range<G> range;
		protected Iterator<G>? iterator = null;
	}

	private Node<G>? root = null;
	private weak Node<G>? _first = null;
	private weak Node<G>? _last = null;
	private int stamp = 0;
	private Functions.CompareDataFuncClosure<G> _compare_func;
}
