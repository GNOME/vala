/* treemap.vala
 *
 * Copyright (C) 2009-2011  Maciej Piechotka
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
 * Left-leaning red-black tree implementation of the {@link Map} interface.
 *
 * This implementation is especially well designed for large quantity of
 * data. The (balanced) tree implementation insure that the set and get
 * methods are in logarithmic complexity.
 *
 * @see HashMap
 */
public class Vala.TreeMap<K,V> : Vala.AbstractBidirSortedMap<K,V> {
	/**
	 * {@inheritDoc}
	 */
	public override int size {
		get { return _size; }
	}

	public override bool read_only {
		get { return false; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override Set<K> keys {
		owned get {
			var keys = _keys;
			if (_keys == null) {
				keys = new KeySet<K,V> (this);
				_keys = keys;
				keys.add_weak_pointer ((void**) (&_keys));
			}
			return keys;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override Collection<V> values {
		owned get {
			var values = _values;
			if (_values == null) {
				values = new ValueCollection<K,V> (this);
				_values = values;
				values.add_weak_pointer ((void**) (&_values));
			}
			return values;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override Set<Map.Entry<K,V>> entries {
		owned get {
			var entries = _entries;
			if (_entries == null) {
				entries = new EntrySet<K,V> (this);
				_entries = entries;
				entries.add_weak_pointer ((void**) (&_entries));
			}
			return entries;
		}
	}

	/**
	 * The keys' comparator function.
	 */
	[CCode (notify = false)]
	public CompareDataFunc<K> key_compare_func { private set; get; }

	/**
	 * The values' equality testing function.
	 */
	[CCode (notify = false)]
	public EqualDataFunc<V> value_equal_func { private set; get; }

	private int _size = 0;

	private weak SortedSet<K> _keys;
	private weak Collection<V> _values;
	private weak SortedSet<Map.Entry<K,V>> _entries;

	/**
	 * Constructs a new, empty tree map sorted according to the specified
	 * comparator function.
	 *
	 * If not provided, the functions parameters are requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param key_compare_func an optional key comparator function
	 * @param value_equal_func an optional values equality testing function
	 */
	public TreeMap (owned CompareDataFunc<K>? key_compare_func = null, owned EqualDataFunc<V>? value_equal_func = null) {
		if (key_compare_func == null) {
			key_compare_func = Functions.get_compare_func_for (typeof (K));
		}
		if (value_equal_func == null) {
			value_equal_func = Functions.get_equal_func_for (typeof (V));
		}
		this.key_compare_func = key_compare_func;
		this.value_equal_func = value_equal_func;
	}

	~TreeMap () {
		clear ();
	}

	private void rotate_right (ref Node<K, V> root) {
		Node<K,V> pivot = (owned) root.left;
		pivot.color = root.color;
		root.color = Node.Color.RED;
		root.left = (owned) pivot.right;
		pivot.right = (owned) root;
		root = (owned) pivot;
	}

	private void rotate_left (ref Node<K, V> root) {
		Node<K,V> pivot = (owned) root.right;
		pivot.color = root.color;
		root.color = Node.Color.RED;
		root.right = (owned) pivot.left;
		pivot.left = (owned) root;
		root = (owned) pivot;
	}

	private bool is_red (Node<K, V>? n) {
		return n != null && n.color == Node.Color.RED;
	}

	private bool is_black (Node<K, V>? n) {
		return n == null || n.color == Node.Color.BLACK;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool has_key (K key) {
		weak Node<K, V>? cur = root;
		while (cur != null) {
			int res = key_compare_func (key, cur.key);
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

	/**
	 * {@inheritDoc}
	 */
	public override bool has (K key, V value) {
		V? own_value = get (key);
		return (own_value != null && value_equal_func (own_value, value));
	}

	/**
	 * {@inheritDoc}
	 */
	public override V? get (K key) {
		weak Node<K, V>? cur = root;
		while (cur != null) {
			int res = key_compare_func (key, cur.key);
			if (res == 0) {
				return cur.value;
			} else if (res < 0) {
				cur = cur.left;
			} else {
				cur = cur.right;
			}
		}
		return null;
	}

	private bool set_to_node (ref Node<K, V>? node, K key, V value, out V? old_value, Node<K, V>? prev, Node<K, V>? next) {
		if (node == null) {
			old_value = null;
			node = new Node<K,V> (key, value, prev, next);
			if (prev == null) {
				first = node;
			}
			if (next == null) {
				last = node;
			}
			_size++;
			return true;
		}

		int cmp = key_compare_func (key, node.key);
		bool changed;
		if (cmp == 0) {
			if (value_equal_func (value, node.value)) {
				old_value = null;
				changed = false;
			} else {
				old_value = (owned) node.value;
				node.value = value;
				changed = true;
			}
		} else if (cmp < 0) {
			changed = set_to_node (ref node.left, key, value, out old_value, node.prev, node);
		} else {
			changed = set_to_node (ref node.right, key, value, out old_value, node, node.next);
		}

		fix_up (ref node);
		return changed;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void set (K key, V value) {
		V old_value;
		set_to_node (ref root, key, value, out old_value, null, null);
		root.color = Node.Color.BLACK;
		stamp++;
	}

	private void move_red_left (ref Node<K, V> root) {
		root.flip ();
		if (is_red (root.right.left)) {
			rotate_right (ref root.right);
			rotate_left (ref root);
			root.flip ();
		}
	}

	private void move_red_right (ref Node<K, V> root) {
		root.flip ();
		if (is_red (root.left.left)) {
			rotate_right (ref root);
			root.flip ();
		}
	}

	private void fix_removal (ref Node<K,V> node, out K? key = null, out V? value = null) {
		Node<K,V> n = (owned) node;
		key = (owned) n.key;
		value = (owned) n.value;
		if (n.prev != null) {
			n.prev.next = n.next;
		} else {
			first = n.next;
		}
		if (n.next != null) {
			n.next.prev = n.prev;
		} else {
			last = n.next;
		}
		n.value = null;
		node = null;
		_size--;
	}

	private void remove_minimal (ref Node<K,V> node, out K key, out V value) {
		if (node.left == null) {
			fix_removal (ref node, out key, out value);
			return;
		}

		if (is_black (node.left) && is_black (node.left.left)) {
			move_red_left (ref node);
		}

		remove_minimal (ref node.left, out key, out value);

		fix_up (ref node);
	}

	private bool remove_from_node (ref Node<K, V>? node, K key, out V? value, out unowned Node<K, V>? prev = null, out unowned Node<K, V>? next = null) {
		if (node == null) {
			value = null;
			next = null;
			prev = null;
			return false;
		} else if (key_compare_func (key, node.key) < 0) {
			weak Node<K,V> left = node.left;
			if (left == null) {
				value = null;
				next = null;
				prev = null;
				return false;
			}
			if (node.left != null && is_black (left) && is_black (left.left)) {
				move_red_left (ref node);
			}
			bool r = remove_from_node (ref node.left, key, out value, out prev, out next);
			fix_up (ref node);
			return r;
		} else {
			if (is_red (node.left)) {
				rotate_right (ref node);
			}

			weak Node<K,V>? r = node.right;
			if (key_compare_func (key, node.key) == 0 && r == null) {
				prev = node.prev;
				next = node.next;
				fix_removal (ref node, null, out value);
				return true;
			}
			if (is_black (r) && r != null && is_black (r.left)) {
				move_red_right (ref node);
			}
			if (key_compare_func (key, node.key) == 0) {
				value = (owned) node.value;
				prev = node.prev;
				next = node;
				remove_minimal (ref node.right, out node.key, out node.value);
				fix_up (ref node);
				return true;
			} else {
				bool re = remove_from_node (ref node.right, key, out value, out prev, out next);
				fix_up (ref node);
				return re;
			}
		}
	}

	private void fix_up (ref Node<K,V> node) {
		if (is_black (node.left) && is_red (node.right)) {
			rotate_left (ref node);
		}
		if (is_red (node.left) && is_red (node.left.left)) {
			rotate_right (ref node);
		}
		if (is_red (node.left) && is_red (node.right)) {
			node.flip ();
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool unset (K key, out V? value = null) {
		bool b = remove_from_node (ref root, key, out value);

		if (root != null) {
			root.color = Node.Color.BLACK;
		}
		stamp++;
		return b;
	}

	private inline void clear_subtree (owned Node<K,V> node) {
		node.key = null;
		node.value = null;
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
			first = last = null;
		}
		_size = 0;
		stamp++;
	}

	/**
	 * {@inheritDoc}
	 */
	public override SortedMap<K,V> head_map (K before) {
		return new SubMap<K,V> (this, new Range<K,V>.head (this, before));
	}

	/**
	 * {@inheritDoc}
	 */
	public override SortedMap<K,V> tail_map (K after) {
		return new SubMap<K,V> (this, new Range<K,V>.tail (this, after));
	}

	/**
	 * {@inheritDoc}
	 */
	public override SortedMap<K,V> sub_map (K after, K before) {
		return new SubMap<K,V> (this, new Range<K,V> (this, after, before));
	}

	/**
	 * {@inheritDoc}
	 */
	public override SortedSet<K> ascending_keys {
		owned get {
			var keys = _keys;
			if (_keys == null) {
				keys = new KeySet<K,V> (this);
				_keys = keys;
				keys.add_weak_pointer (&_keys);
			}
			return keys;
		}
	}
	/**
	 * {@inheritDoc}
	 */
	public override SortedSet<Map.Entry<K,V>> ascending_entries {
		owned get {
			var entries = _entries;
			if (_entries == null) {
				entries = new EntrySet<K,V> (this);
				_entries = entries;
				entries.add_weak_pointer (&_entries);
			}
			return entries;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override Vala.MapIterator<K,V> map_iterator () {
		return new MapIterator<K,V> (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override Vala.BidirMapIterator<K,V> bidir_map_iterator () {
		return new MapIterator<K,V> (this);
	}

	[Compact]
	private class Node<K, V> {
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

		public Node (owned K key, owned V value, Node<K,V>? prev, Node<K,V>? next) {
			this.key = (owned) key;
			this.value = (owned) value;
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

		public K key;
		public V value;
		public Color color;
		public Node<K, V>? left;
		public Node<K, V>? right;
		public weak Node<K, V>? prev;
		public weak Node<K, V>? next;
		public unowned Map.Entry<K,V>? entry;
	}

	private Node<K, V>? root = null;
	private weak Node<K, V>? first = null;
	private weak Node<K, V>? last = null;
	private int stamp = 0;

	private inline K min (K a, K b) {
		return key_compare_func (a, b) <= 0 ? a : b;
	}

	private inline K max (K a, K b) {
		return key_compare_func (a, b) > 0 ? a : b;
	}

	private inline unowned Node<K,V>? find_node (K key) {
		unowned Node<K,V>? cur = root;
		while (cur != null) {
			int res = key_compare_func (key, cur.key);
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

	private inline unowned Node<K,V>? find_nearest (K key) {
		unowned Node<K,V>? cur = root;
		while (cur != null) {
			int res = key_compare_func (key, cur.key);
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

	private class Entry<K,V> : Map.Entry<K,V> {
		private unowned Node<K,V> _node;

		public static Map.Entry<K,V> entry_for<K,V> (Node<K,V> node) {
			Map.Entry<K,V> result = node.entry;
			if (result == null) {
				result = new Entry<K,V> (node);
				node.entry = result;
				result.add_weak_pointer ((void**) (&node.entry));
			}
			return result;
		}

		public Entry (Node<K,V> node) {
			_node = node;
		}

		public override K key { get { return _node.key; } }

		public override V value {
			get { return _node.value; }
			set { _node.value = value; }
		}

		public override bool read_only { get { return false; } }
	}

	private inline unowned Node<K,V>? find_lower (K key) {
		unowned Node<K,V>? node = find_nearest (key);
		if (node == null)
			return null;
		return key_compare_func (key, node.key) <= 0 ? node.prev : node;
	}

	private inline unowned Node<K,V>? find_higher (K key) {
		unowned Node<K,V>? node = find_nearest (key);
		if (node == null)
			return null;
		return key_compare_func (key, node.key) >= 0 ? node.next : node;
	}

	private inline unowned Node<K,V>? find_floor (K key) {
		unowned Node<K,V>? node = find_nearest (key);
		if (node == null)
			return null;
		return key_compare_func (key, node.key) < 0 ? node.prev : node;
	}

	private inline unowned Node<K,V>? find_ceil (K key) {
		unowned Node<K,V>? node = find_nearest (key);
		if (node == null)
			return null;
		return key_compare_func (key, node.key) > 0 ? node.next : node;
	}

	private inline K? lift_null_key (Node<K,V>? node) {
		return node != null ? node.key : null;
	}

	private class Range<K,V> {
		public Range (TreeMap<K,V> map, K after, K before) {
			this.map = map;
			if (map.key_compare_func (after, before) < 0) {
				this.after = after;
				this.before = before;
				type = RangeType.BOUNDED;
			} else {
				type = RangeType.EMPTY;
			}
		}

		public Range.head (TreeMap<K,V> map, K before) {
			this.map = map;
			this.before = before;
			type = RangeType.HEAD;
		}

		public Range.tail (TreeMap<K,V> map, K after) {
			this.map = map;
			this.after = after;
			type = RangeType.TAIL;
		}

		public Range.empty (TreeMap<K,V> map) {
			this.map = map;
			type = RangeType.EMPTY;
		}

		public Range<K,V> cut_head (K after) {
			switch (type) {
			case RangeType.HEAD:
				return new Range<K,V> (map, after, before);
			case RangeType.TAIL:
				return new Range<K,V>.tail (map, map.max (after, this.after));
			case RangeType.EMPTY:
				return this;
			case RangeType.BOUNDED:
				var _after = map.max (after, this.after);
				return new Range<K,V> (map, _after, before);
			default:
				assert_not_reached ();
			}
		}

		public Range<K,V> cut_tail (K before) {
			switch (type) {
			case RangeType.HEAD:
				return new Range<K,V>.head (map, map.min (before, this.before));
			case RangeType.TAIL:
				return new Range<K,V> (map, after, before);
			case RangeType.EMPTY:
				return this;
			case RangeType.BOUNDED:
				var _before = map.min (before, this.before);
				return new Range<K,V> (map, after, _before);
			default:
				assert_not_reached ();
			}
		}

		public Range<K,V> cut (K after, K before) {
			if (type == RangeType.EMPTY)
				return this;
			var _before = (type == RangeType.HEAD || type == RangeType.BOUNDED) ?
				map.min (before, this.before) : before;
			var _after = (type == RangeType.TAIL || type == RangeType.BOUNDED) ?
				map.max (after, this.after) : after;
			return new Range<K,V> (map, _after, _before);
		}

		public bool in_range (K key) {
			return type == RangeType.EMPTY ? false : compare_range(key) == 0;
		}

		public int compare_range (K key) {
			switch (type) {
			case RangeType.HEAD:
				return map.key_compare_func (key, before) < 0 ? 0 : 1;
			case RangeType.TAIL:
				return map.key_compare_func (key, after) >= 0 ? 0 : -1;
			case RangeType.EMPTY:
				return 0; // For simplicity - please make sure it does not break anything
			case RangeType.BOUNDED:
				return map.key_compare_func (key, after) >= 0 ?
					(map.key_compare_func (key, before) < 0 ? 0 : 1) : -1;
			default:
				assert_not_reached ();
			}
		}

		public bool empty_submap () {
			switch (type) {
			case RangeType.HEAD:
				return map.first == null || !in_range (map.first.key);
			case RangeType.TAIL:
				return map.last == null || !in_range (map.last.key);
			case RangeType.EMPTY:
				return true;
			case RangeType.BOUNDED:
				return first () == null;
			default:
				assert_not_reached ();
			}
		}

		public unowned Node<K,V>? first () {
			switch (type) {
			case RangeType.EMPTY:
				return null;
			case RangeType.HEAD:
				return map.first;
			default:
				return map.find_floor (after);
			}
		}

		public unowned Node<K,V>? last () {
			switch (type) {
			case RangeType.EMPTY:
				return null;
			case RangeType.TAIL:
				return map.last;
			default:
				return map.find_lower (before);
			}
		}

		private new TreeMap<K,V> map;
		private K after;
		private K before;
		private RangeType type;
	}

	private enum RangeType {
		HEAD,
		TAIL,
		EMPTY,
		BOUNDED
	}

	private class SubMap<K,V> : AbstractBidirSortedMap<K,V> {
		public override int size { get { return keys.size; } }
		public bool is_empty { get { return keys.is_empty; } }

		public SubMap (TreeMap<K,V> map, Range<K,V> range) {
			this.map = map;
			this.range = range;
		}

		private weak SortedSet<K>? _keys;
		public override Set<K> keys {
			owned get {
				var keys = _keys;
				if (_keys == null) {
					keys = new SubKeySet<K,V> (map, range);
					_keys = keys;
					keys.add_weak_pointer(&_keys);
				}
				return keys;
			}
		}

		private weak Collection<K>? _values;
		public override Collection<V> values {
			owned get {
				var values = _values;
				if (_values == null) {
					values = new SubValueCollection<K,V> (map, range);
					_values = values;
					values.add_weak_pointer(&_values);
				}
				return values;
			}
		}

		private weak SortedSet<Entry<K,V>>? _entries;
		public override Set<Entry<K,V>> entries {
			owned get {
				var entries = _entries;
				if (_entries == null) {
					entries = new SubEntrySet<K,V> (map, range);
					_entries = entries;
					entries.add_weak_pointer(&_entries);
				}
				return entries;
			}
		}

		public override bool read_only {
			get {
				return true;
			}
		}

		public override bool has_key (K key) {
			return range.in_range (key) && map.has_key (key);
		}

		public override bool has (K key, V value) {
			return range.in_range (key) && map.has (key, value);
		}

		public override new V? get (K key) {
			return range.in_range (key) ? map.get (key) : null;
		}

		public override void set (K key, V value) {
			if (range.in_range (key))
				map.set (key, value);
		}

		public override bool unset (K key, out V? value = null) {
			value = null;
			return range.in_range (key) && map.unset (key, out value);
		}

		public override void clear () {
			for (var iterator = map_iterator (); iterator.next ();)
				iterator.unset ();
		}

		public override Vala.MapIterator<K,V> map_iterator () {
			return new SubMapIterator<K,V> (map, range);
		}

		public override BidirMapIterator<K,V> bidir_map_iterator () {
			return new SubMapIterator<K,V> (map, range);
		}

		public override SortedMap<K,V> head_map (K before) {
			return new SubMap<K,V> (map, range.cut_tail (before));
		}

		public override SortedMap<K,V> tail_map (K after) {
			return new SubMap<K,V> (map, range.cut_head (after));
		}

		public override SortedMap<K,V> sub_map (K after, K before) {
			return new SubMap<K,V> (map, range.cut (after, before));
		}

		public override SortedSet<K> ascending_keys {
			owned get {
				var keys = _keys;
				if (_keys == null) {
					keys = new SubKeySet<K,V> (map, range);
					_keys = keys;
					keys.add_weak_pointer(&_keys);
				}
				return keys;
			}
		}

		public override SortedSet<K> ascending_entries {
			owned get {
				var entries = _entries;
				if (_entries == null) {
					entries = new SubEntrySet<K,V> (map, range);
					_entries = entries;
					entries.add_weak_pointer(&_entries);
				}
				return _entries;
			}
		}

		private TreeMap<K,V> map;
		private Range<K,V> range;
	}

	private class KeySet<K,V> : AbstractBidirSortedSet<K> {
		private TreeMap<K,V> _map;

		public KeySet (TreeMap<K,V> map) {
			_map = map;
		}

		public override Iterator<K> iterator () {
			return new KeyIterator<K,V> (_map);
		}

		public override int size {
			get { return _map.size; }
		}

		public override bool read_only {
			get { return true; }
		}

		public override bool add (K key) {
			assert_not_reached ();
		}

		public override void clear () {
			assert_not_reached ();
		}

		public override bool remove (K key) {
			assert_not_reached ();
		}

		public override bool contains (K key) {
			return _map.has_key (key);
		}

		public override K first () {
			assert (_map.first != null);
			return _map.first.key;
		}

		public override K last () {
			assert (_map.last != null);
			return _map.last.key;
		}

		public override BidirIterator<K> bidir_iterator () {
			return new KeyIterator<K,V> (_map);
		}

		public override SortedSet<K> head_set (K before) {
			return new SubKeySet<K,V> (_map, new Range<K,V>.head (_map, before));
		}

		public override SortedSet<K> tail_set (K after) {
			return new SubKeySet<K,V> (_map, new Range<K,V>.tail (_map, after));
		}

		public override SortedSet<K> sub_set (K after, K before) {
			return new SubKeySet<K,V> (_map, new Range<K,V> (_map, after, before));
		}

		public override Iterator<K>? iterator_at (K item) {
			weak Node<K,V>? node = _map.find_node (item);
			if (node == null)
				return null;
			return new KeyIterator<K,V>.pointing (_map, node);
		}

		public override K? lower (K item) {
			return _map.lift_null_key (_map.find_lower (item));
		}

		public override K? higher (K item) {
			return _map.lift_null_key (_map.find_higher (item));
		}

		public override K? floor (K item) {
			return _map.lift_null_key (_map.find_floor (item));
		}

		public override K? ceil (K item) {
			return _map.lift_null_key (_map.find_ceil (item));
		}
	}

	private class SubKeySet<K,V> : AbstractBidirSortedSet<K> {
		[CCode (notify = false)]
		public TreeMap<K,V> map { private set; get; }
		[CCode (notify = false)]
		public Range<K,V> range { private set; get; }

		public SubKeySet (TreeMap<K,V> map, Range<K,V> range) {
			this.map = map;
			this.range = range;
		}

		public override Iterator<K> iterator () {
			return new SubKeyIterator<K,V> (map, range);
		}

		public override int size {
			get {
				var i = 0;
				Vala.Iterator<K> iterator = iterator ();
				while (iterator.next ())
					i++;
				return i;
			}
		}

		public override bool read_only {
			get {
				return true;
			}
		}

		public bool is_empty { get { return range.empty_submap (); } }

		public override bool add (K key) {
			assert_not_reached ();
		}

		public override void clear () {
			assert_not_reached ();
		}

		public override bool remove (K key) {
			assert_not_reached ();
		}

		public override bool contains (K key) {
			return range.in_range(key) && map.has_key (key);
		}

		public override BidirIterator<K> bidir_iterator () {
			return new SubKeyIterator<K,V> (map, range);
		}

		public override K first () {
			weak Node<K,V>? _first = range.first ();
			assert (_first != null);
			return _first.key;
		}

		public override K last () {
			weak Node<K,V>? _last = range.last ();
			assert (_last != null);
			return _last.key;
		}

		public override SortedSet<K> head_set (K before) {
			return new SubKeySet<K,V> (map, range.cut_tail (before));
		}

		public override SortedSet<K> tail_set (K after) {
			return new SubKeySet<K,V> (map, range.cut_head (after));
		}

		public override SortedSet<K> sub_set (K after, K before) {
			return new SubKeySet<K,V> (map, range.cut (after, before));
		}

		public override Iterator<K>? iterator_at (K key) {
			if (!range.in_range (key))
				return null;
			weak Node<K,V>? n = map.find_node (key);
			if (n == null)
				return null;
			return new SubKeyIterator<K,V>.pointing (map, range, n);
		}

		public override K? lower (K key) {
			var res = range.compare_range (key);
			if (res > 0)
				return last ();
			var l = map.lift_null_key (map.find_lower (key));
			return l != null && range.in_range (l) ? l : null;
		}

		public override K? higher (K key) {
			var res = range.compare_range (key);
			if (res < 0)
				return first ();
			var h = map.lift_null_key (map.find_higher (key));
			return h != null && range.in_range (h) ? h : null;
		}

		public override K? floor (K key) {
			var res = range.compare_range (key);
			if (res > 0)
				return last ();
			var l = map.lift_null_key (map.find_floor (key));
			return l != null && range.in_range (l) ? l : null;
		}

		public override K? ceil (K key) {
			var res = range.compare_range (key);
			if (res < 0)
				return first ();
			var h = map.lift_null_key (map.find_ceil (key));
			return h != null && range.in_range (h) ? h : null;
		}
	}

	private class ValueCollection<K,V> : AbstractCollection<V> {
		private TreeMap<K,V> _map;

		public ValueCollection (TreeMap<K,V> map) {
			_map = map;
		}

		public override Iterator<V> iterator () {
			return new ValueIterator<K,V> (_map);
		}

		public override int size {
			get { return _map.size; }
		}

		public override bool read_only {
			get { return true; }
		}

		public override bool add (V key) {
			assert_not_reached ();
		}

		public override void clear () {
			assert_not_reached ();
		}

		public override bool remove (V key) {
			assert_not_reached ();
		}

		public override bool contains (V key) {
			Iterator<V> it = iterator ();
			while (it.next ()) {
				if (_map.value_equal_func (key, it.get ())) {
					return true;
				}
			}
			return false;
		}
	}

	private class SubValueCollection<K,V> : AbstractCollection<V> {
		[CCode (notify = false)]
		public TreeMap<K,V> map { private set; get; }
		[CCode (notify = false)]
		public Range<K,V> range { private set; get; }

		public SubValueCollection (TreeMap<K,V> map, Range<K,V> range) {
			this.map = map;
			this.range = range;
		}

		public override Iterator<V> iterator () {
			return new SubValueIterator<K,V> (map, range);
		}

		public override bool read_only {
			get {
				return true;
			}
		}

		public override int size {
			get {
				var i = 0;
				Vala.Iterator<V> iterator = iterator ();
				while (iterator.next ())
					i++;
				return i;
			}
		}

		public bool is_empty { get { return range.empty_submap (); } }

		public override bool add (V key) {
			assert_not_reached ();
		}

		public override void clear () {
			assert_not_reached ();
		}

		public override bool remove (V key) {
			assert_not_reached ();
		}

		public override bool contains (V key) {
			Iterator<V> it = iterator ();
			while (it.next ()) {
				if (map.value_equal_func (key, it.get ())) {
					return true;
				}
			}
			return false;
		}
	}

	private class EntrySet<K,V> : AbstractBidirSortedSet<Map.Entry<K, V>> {
		private TreeMap<K,V> _map;

		public EntrySet (TreeMap<K,V> map) {
			_map = map;
		}

		public override Iterator<Map.Entry<K, V>> iterator () {
			return new EntryIterator<K,V> (_map);
		}

		public override int size {
			get { return _map.size; }
		}

		public override bool read_only {
			get { return true; }
		}

		public override bool add (Map.Entry<K, V> entry) {
			assert_not_reached ();
		}

		public override void clear () {
			assert_not_reached ();
		}

		public override bool remove (Map.Entry<K, V> entry) {
			assert_not_reached ();
		}

		public override bool contains (Map.Entry<K, V> entry) {
			return _map.has (entry.key, entry.value);
		}

		public override Map.Entry<K, V>/*?*/ first () {
			assert (_map.first != null);
			return Entry.entry_for<K,V> (_map.first);
		}

		public override Map.Entry<K, V>/*?*/ last () {
			assert (_map.last != null);
			return Entry.entry_for<K,V> (_map.last);
		}

		public override BidirIterator<Map.Entry<K, V>> bidir_iterator () {
			return new EntryIterator<K,V> (_map);
		}

		public override SortedSet<Map.Entry<K, V>> head_set (Map.Entry<K, V> before) {
			return new SubEntrySet<K,V> (_map, new Range<K,V>.head (_map, before.key));
		}

		public override SortedSet<Map.Entry<K, V>> tail_set (Map.Entry<K, V> after) {
			return new SubEntrySet<K,V> (_map, new Range<K,V>.tail (_map, after.key));
		}

		public override SortedSet<K> sub_set (Map.Entry<K, V> after, Map.Entry<K, V> before) {
			return new SubEntrySet<K,V> (_map, new Range<K,V> (_map, after.key, before.key));
		}

		public override Iterator<Map.Entry<K, V>>? iterator_at (Map.Entry<K, V> item) {
			weak Node<K,V>? node = _map.find_node (item.key);
			if (node == null || !_map.value_equal_func (node.value, item.value))
				return null;
			return new EntryIterator<K,V>.pointing (_map, node);
		}

		public override Map.Entry<K, V>/*?*/ lower (Map.Entry<K, V> item) {
			weak Node<K,V>? l = _map.find_lower (item.key);
			return l != null ? Entry.entry_for<K,V> (l) : null;
		}

		public override Map.Entry<K, V>/*?*/ higher (Map.Entry<K, V> item) {
			weak Node<K,V>? l = _map.find_higher (item.key);
			return l != null ? Entry.entry_for<K,V> (l) : null;
		}

		public override Map.Entry<K, V>/*?*/ floor (Map.Entry<K, V> item) {
			weak Node<K,V>? l = _map.find_floor (item.key);
			return l != null ? Entry.entry_for<K,V> (l) : null;
		}

		public override Map.Entry<K, V>/*?*/ ceil (Map.Entry<K, V> item) {
			weak Node<K,V>? l = _map.find_ceil (item.key);
			return l != null ? Entry.entry_for<K,V> (l) : null;
		}
	}

	private class SubEntrySet<K,V> : AbstractBidirSortedSet<Map.Entry<K,V>> {
		[CCode (notify = false)]
		public TreeMap<K,V> map { private set; get; }
		[CCode (notify = false)]
		public Range<K,V> range { private set; get; }

		public SubEntrySet (TreeMap<K,V> map, Range<K,V> range) {
			this.map = map;
			this.range = range;
		}

		public override Iterator<Map.Entry<K,V>> iterator () {
			return new SubEntryIterator<K,V> (map, range);
		}

		public override int size {
			get {
				var i = 0;
				Vala.Iterator<Map.Entry<K,V>> iterator = iterator ();
				while (iterator.next ())
					i++;
				return i;
			}
		}

		public override bool read_only {
			get {
				return true;
			}
		}

		public bool is_empty { get { return range.empty_submap (); } }

		public override bool add (Map.Entry<K,V> entry) {
			assert_not_reached ();
		}

		public override void clear () {
			assert_not_reached ();
		}

		public override bool remove (Map.Entry<K,V> entry) {
			assert_not_reached ();
		}

		public override bool contains (Map.Entry<K,V> entry) {
			return range.in_range(entry.key) && map.has (entry.key, entry.value);
		}

		public override BidirIterator<K> bidir_iterator () {
			return new SubEntryIterator<K,V> (map, range);
		}

		public override Map.Entry<K,V> first () {
			weak Node<K,V>? _first = range.first ();
			assert (_first != null);
			return Entry.entry_for<K,V> (_first);
		}

		public override Map.Entry<K,V> last () {
			weak Node<K,V>? _last = range.last ();
			assert (_last != null);
			return Entry.entry_for<K,V> (_last);
		}

		public override SortedSet<K> head_set (Map.Entry<K,V> before) {
			return new SubEntrySet<K,V> (map, range.cut_tail (before.key));
		}

		public override SortedSet<K> tail_set (Map.Entry<K,V> after) {
			return new SubEntrySet<K,V> (map, range.cut_head (after.key));
		}

		public override SortedSet<K> sub_set (Map.Entry<K,V> after, Map.Entry<K,V> before) {
			return new SubEntrySet<K,V> (map, range.cut (after.key, before.key));
		}

		public override Iterator<Map.Entry<K,V>>? iterator_at (Map.Entry<K,V> entry) {
			if (!range.in_range (entry.key))
				return null;
			weak Node<K,V>? n = map.find_node (entry.key);
			if (n == null || !map.value_equal_func (n.value, entry.value))
				return null;
			return new SubEntryIterator<K,V>.pointing (map, range, n);
		}

		public override Map.Entry<K,V>/*?*/ lower (Map.Entry<K,V> entry) {
			var res = range.compare_range (entry.key);
			if (res > 0)
				return last ();
			weak Node<K,V>? l = map.find_lower (entry.key);
			return l != null && range.in_range (l.key) ? Entry.entry_for<K,V> (l) : null;
		}

		public override Map.Entry<K,V>/*?*/ higher (Map.Entry<K,V> entry) {
			var res = range.compare_range (entry.key);
			if (res < 0)
				return first ();
			weak Node<K,V>? h = map.find_higher (entry.key);
			return h != null && range.in_range (h.key) ? Entry.entry_for<K,V> (h) : null;
		}

		public override Map.Entry<K,V>/*?*/ floor (Map.Entry<K,V> entry) {
			var res = range.compare_range (entry.key);
			if (res > 0)
				return last ();
			weak Node<K,V>? l = map.find_floor (entry.key);
			return l != null && range.in_range (l.key) ? Entry.entry_for<K,V> (l) : null;
		}

		public override Map.Entry<K,V>/*?*/ ceil (Map.Entry<K,V> entry) {
			var res = range.compare_range (entry.key);
			if (res < 0)
				return first ();
			weak Node<K,V>? h = map.find_ceil (entry.key);
			return h != null && range.in_range (h.key) ? Entry.entry_for<K,V> (h) : null;
		}
	}

	private class NodeIterator<K, V> : Object {
		protected TreeMap<K,V> _map;

		// concurrent modification protection
		protected int stamp;

		protected bool started = false;

		internal weak Node<K, V>? current;
		protected weak Node<K, V>? _next;
		protected weak Node<K, V>? _prev;

		public NodeIterator (TreeMap<K,V> map) {
			_map = map;
			this.stamp = _map.stamp;
		}

		public NodeIterator.pointing (TreeMap<K,V> map, Node<K,V> current) {
			_map = map;
			stamp = _map.stamp;
			this.current = current;
		}

		public bool next () {
			assert (stamp == _map.stamp);
			if (current != null) {
				if (current.next != null) {
					current = current.next;
					return true;
				} else {
					return false;
				}
			} else if (_next == null && _prev == null) {
				current = _map.first;
				started = true;
				return current != null;
			} else {
				current = _next;
				if (current != null) {
					_next = null;
					_prev = null;
				}
				return current != null;
			}
		}

		public bool has_next () {
			assert (stamp == _map.stamp);
			return (current == null && _next == null && _prev == null && _map.first != null) ||
			       (current == null && _next != null) ||
			       (current != null && current.next != null);
 		}

		public bool first () {
			assert (stamp == _map.stamp);
			current = _map.first;
			_next = null;
			_prev = null;
			return current != null; // on false it is null anyway
		}

		public bool previous () {
			assert (stamp == _map.stamp);
			if (current != null) {
				if (current.prev != null) {
					current = current.prev;
					return true;
				} else {
					return false;
				}
			} else {
				if (_prev != null) {
					current = _prev;
					_next = null;
					_prev = null;
					return true;
				} else {
					return false;
				}
			}
		}

		public bool has_previous () {
			assert (stamp == _map.stamp);
			return (current == null && _prev != null) ||
			       (current != null && current.prev != null);
		}

		public bool last () {
			assert (stamp == _map.stamp);
			current = _map.last;
			_next = null;
			_prev = null;
			return current != null; // on false it is null anyway
		}

		public void remove () {
			assert_not_reached ();
		}

		public void unset () {
			assert (stamp == _map.stamp);
			assert (current != null);
			V value;
			bool success = _map.remove_from_node (ref _map.root, current.key, out value, out _prev, out _next);
			assert (success);
			if (_map.root != null)
				_map.root.color = Node.Color.BLACK;
			current = null;
			stamp++;
			_map.stamp++;
			assert (stamp == _map.stamp);
		}

		public virtual bool read_only {
			get {
				return true;
			}
		}

		public bool valid {
			get {
				return current != null;
			}
		}

		internal unowned Node<K,V>? safe_next_get () {
			return (current != null) ? current.next : _next;
		}

		internal unowned Node<K,V>? safe_previous_get () {
			return (current != null) ? current.prev : _prev;
		}
	}

	private class SubNodeIterator<K,V> : Object {
		public SubNodeIterator (TreeMap<K,V> map, Range<K,V> range) {
			_map = map;
			this.range = range;
		}

		public SubNodeIterator.pointing (TreeMap<K,V> map, Range<K,V> range, Node<K,V> node) {
			_map = map;
			this.range = range;
			this.iterator = new NodeIterator<K,V>.pointing (_map, node);
		}

		public bool next () {
			if (iterator != null) {
				weak Node<K,V>? node= iterator.safe_next_get ();
				if (node != null && range.in_range (node.key)) {
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
				weak Node<K,V>? node = iterator.safe_next_get ();
				return node != null && range.in_range (node.key);
			} else {
				return range.first () != null;
			}
		}

		public virtual bool first () {
			weak Node<K,V>? node = range.first ();
			if (node == null)
				return false;
			iterator = iterator_pointing_at (node);
			return true;
		}

		public bool previous () {
			if (iterator == null)
				return false;
			weak Node<K,V>? node;
			if ((node = iterator.safe_previous_get ()) != null && range.in_range (node.key)) {
				assert (iterator.previous ());
				return true;
			} else {
				return false;
			}
		}

		public bool has_previous () {
			if (iterator == null)
				return false;
			weak Node<K,V>? node;
			return (node = iterator.safe_previous_get ()) != null && range.in_range (node.key);
		}

		public virtual bool last () {
			weak Node<K,V>? node = range.last ();
			if (node == null)
				return false;
			iterator = iterator_pointing_at (node);
			return true;
		}

		public void remove () {
			assert (valid);
			iterator.remove ();
		}

		public void unset () {
			assert (valid);
			iterator.unset ();
		}

		public virtual bool read_only {
			get {
				return true;
			}
		}

		public bool valid {
			get {
				return iterator != null && iterator.valid;
			}
		}

		protected virtual NodeIterator<K,V> iterator_pointing_at (Node<K,V> node) {
			return new NodeIterator<K,V>.pointing (_map, node);
		}

		protected new TreeMap<K,V> _map;
		protected Range<K,V> range;
		protected NodeIterator<K,V>? iterator = null;
	}

	private class KeyIterator<K,V> : NodeIterator<K, V>, Traversable<K>, Vala.Iterator<K>, BidirIterator<K> {
		public KeyIterator (TreeMap<K,V> map) {
			base (map);
		}

		public KeyIterator.pointing (TreeMap<K,V> map, Node<K,V> current) {
			base.pointing (map, current);
		}

		public new K get () {
			assert (stamp == _map.stamp);
			assert (current != null);
			return current.key;
		}

		public bool foreach (ForallFunc<K> f) {
			if (current != null) {
				if (!f (current.key)) {
					return false;
				}
				current = current.next;
			} else if (_next == null) {
				current = _map.first;
				started = true;
			} else {
				current = _next;
				if (current != null) {
					_next = null;
					_prev = null;
				}
			}
			for (; current != null; current = current.next) {
				if (!f (current.key)) {
					return false;
				}
			}
			return true;
		}
	}

	private class SubKeyIterator<K,V> : SubNodeIterator<K,V>, Traversable<K>, Vala.Iterator<K>, BidirIterator<K> {
		public SubKeyIterator (TreeMap<K,V> map, Range<K,V> range) {
			base (map, range);
		}

		public SubKeyIterator.pointing (TreeMap<K,V> map, Range<K,V> range, Node<K,V> node) {
			base.pointing (map, range, node);
		}

		public new K get () {
			assert (valid);
			return iterator.current.key;
		}

		public bool foreach (ForallFunc<K> f) {
			if (valid) {
				if (!f (iterator.current.key)) {
					return false;
				}
			}
			while (iterator.next ()) {
				if (!f (iterator.current.key)) {
					return false;
				}
			}
			return true;
		}
	}

	private class ValueIterator<K,V> : NodeIterator<K,V>, Traversable<V>, Vala.Iterator<V>, Vala.BidirIterator<V> {
		public ValueIterator (TreeMap<K,V> map) {
			base (map);
		}

		public ValueIterator.pointing (TreeMap<K,V> map, Node<K,V> current) {
			base.pointing (map, current);
		}

		public new V get () {
			assert (stamp == _map.stamp);
			assert (valid);
			return current.value;
		}

		public bool foreach (ForallFunc<V> f) {
			if (current != null) {
				if (!f (current.value)) {
					return false;
				}
				current = current.next;
			} else if (_next == null) {
				current = _map.first;
				started = true;
			} else {
				current = _next;
				if (current != null) {
					_next = null;
					_prev = null;
				}
			}
			for (; current != null; current = current.next) {
				if (!f (current.value)) {
					return false;
				}
			}
			return true;
		}
	}

	private class SubValueIterator<K,V> : SubNodeIterator<K,V>, Traversable<V>, Vala.Iterator<V>, BidirIterator<V> {
		public SubValueIterator (TreeMap<K,V> map, Range<K,V> range) {
			base (map, range);
		}

		public SubValueIterator.pointing (TreeMap<K,V> map, Range<K,V> range, Node<K,V> node) {
			base.pointing (map, range, node);
		}

		public new V get () {
			assert (valid);
			return iterator.current.value;
		}

		public bool foreach (ForallFunc<V> f) {
			if (valid) {
				if (!f (iterator.current.key)) {
					return false;
				}
			}
			while (iterator.next ()) {
				if (!f (iterator.current.key)) {
					return false;
				}
			}
			return true;
		}
	}

	private class EntryIterator<K,V> : NodeIterator<K,V>, Traversable<Map.Entry<K, V>>, Vala.Iterator<Map.Entry<K,V>>, Vala.BidirIterator<Map.Entry<K,V>> {
		public EntryIterator (TreeMap<K,V> map) {
			base (map);
		}

		public EntryIterator.pointing (TreeMap<K,V> map, Node<K,V> node) {
			base.pointing (map, node);
		}

		public new Map.Entry<K,V> get () {
			assert (stamp == _map.stamp);
			assert (valid);
			return Entry.entry_for<K,V> (current);
		}

		public new void remove () {
			unset ();
		}

		public bool foreach (ForallFunc<Map.Entry<K, V>> f) {
			if (current != null) {
				if (!f (Entry.entry_for<K,V> (current))) {
					return false;
				}
				current = current.next;
			} else if (_next == null) {
				current = _map.first;
				started = true;
			} else {
				current = _next;
				if (current != null) {
					_next = null;
					_prev = null;
				}
			}
			for (; current != null; current = current.next) {
				if (!f (Entry.entry_for<K,V> (current))) {
					return false;
				}
			}
			return true;
		}
	}

	private class SubEntryIterator<K,V> : SubNodeIterator<K,V>, Traversable<Map.Entry<K, V>>, Vala.Iterator<Map.Entry<K,V>>, Vala.BidirIterator<Map.Entry<K,V>> {
		public SubEntryIterator (TreeMap<K,V> map, Range<K,V> range) {
			base (map, range);
		}

		public SubEntryIterator.pointing (TreeMap<K,V> map, Range<K,V> range, Node<K,V> node) {
			base.pointing (map, range, node);
		}

		public new Map.Entry<K,V> get () {
			assert (iterator != null);
			return Entry.entry_for<K,V> (iterator.current);
		}

		public new void remove () {
			unset ();
		}

		public bool foreach (ForallFunc<Map.Entry<K, V>> f) {
			if (valid) {
				if (!f (Entry.entry_for<K,V> (iterator.current))) {
					return false;
				}
			}
			while (iterator.next ()) {
				if (!f (Entry.entry_for<K,V> (iterator.current))) {
					return false;
				}
			}
			return true;
		}
	}

	private class MapIterator<K,V> : NodeIterator<K,V>, Vala.MapIterator<K,V>, BidirMapIterator<K,V> {
		public MapIterator (TreeMap<K,V> map) {
			base (map);
		}

		public K get_key () {
			assert (stamp == _map.stamp);
			assert (valid);
			return current.key;
		}

		public V get_value () {
			assert (stamp == _map.stamp);
			assert (valid);
			return current.value;
		}

		public void set_value (V value) {
			assert (stamp == _map.stamp);
			assert (valid);
			current.value = value;
		}

		public override bool read_only {
			get {
				return false;
			}
		}

		public bool mutable {
			get {
				return true;
			}
		}
	}

	private class SubMapIterator<K,V> : SubNodeIterator<K,V>, Vala.MapIterator<K,V>, BidirMapIterator<K,V> {
		public SubMapIterator (TreeMap<K,V> map, Range<K,V> range) {
			base (map, range);
		}

		public K get_key () {
			assert (valid);
			return iterator.current.key;
		}

		public V get_value () {
			assert (valid);
			return iterator.current.value;
		}

		public void set_value (V value) {
			assert (valid);
			iterator.current.value = value;
		}

		public override bool read_only {
			get {
				return false;
			}
		}

		public bool mutable {
			get {
				return true;
			}
		}
	}
}
