/* priorityqueue.vala
 *
 * Copyright (C) 2009  Didier Villevalois
 * Copyright (C) 2012  Maciej Piechotka
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
 * Relaxed fibonacci heap priority queue implementation of the {@link Queue}.
 *
 * The elements of the priority queue are ordered according to their natural
 * ordering, or by a compare_func provided at queue construction time. A
 * priority queue does not permit null elements and does not have bounded
 * capacity.
 *
 * This implementation provides O(1) time for offer and peek methods, and
 * O(log n) for poll method. It is based on the algorithms described by
 * Boyapati Chandra Sekhar in:
 *
 *   "Worst Case Efficient Data Structures
 *      for Priority Queues and Deques with Heap Order"
 *   Boyapati Chandra Sekhar (under the guidance of Prof. C. Pandu Rangan)
 *   Department of Computer Science and Engineering
 *   Indian Institute of Technology, Madras
 *   May 1996
 */
public class Vala.PriorityQueue<G> : Vala.AbstractQueue<G> {

	/**
	 * The elements' comparator function.
	 */
	[CCode (notify = false)]
	public CompareDataFunc<G> compare_func { private set; get; }

	private int _size = 0;
	private int _stamp = 0;
	private Type1Node<G>? _r = null;
	private Type2Node<G>? _r_prime = null;
	private Type2Node<G>? _lm_head = null;
	private Type2Node<G>? _lm_tail = null;
	private Type1Node<G>? _p = null;
	private Type1Node<G>?[] _a = new Type1Node<G>?[0];
	private NodePair<G>? _lp_head = null;
	private NodePair<G>? _lp_tail = null;
	private bool[] _b = new bool[0];
	private Type1Node<G>? _ll_head = null;
	private Type1Node<G>? _ll_tail = null;
	private unowned Node<G> _iter_head = null;
	private unowned Node<G> _iter_tail = null;

	/**
	 * Constructs a new, empty priority queue.
	 *
	 * If not provided, the function parameter is requested to the
	 * {@link Functions} function factory methods.
	 *
	 * @param compare_func an optional element comparator function
	 */
	public PriorityQueue (owned CompareDataFunc<G>? compare_func = null) {
		if (compare_func == null) {
			compare_func = Functions.get_compare_func_for (typeof (G));
		}
		this.compare_func = compare_func;
	}

	/**
	 * {@inheritDoc}
	 */
	public override int capacity {
		get { return UNBOUNDED_CAPACITY; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override int remaining_capacity {
		get { return UNBOUNDED_CAPACITY; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool is_full {
		get { return false; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool read_only {
		get { return false; }
	}

	/**
	 * {@inheritDoc}
	 */
	public bool offer (G element) {
		#if DEBUG
			_dump ("Start offer: %s".printf ((string)element));
		#endif
		if (_r == null) {
			_r = new Type1Node<G> (element, ref _iter_head, ref _iter_tail);
			_p = _r;
		} else if (_r_prime == null) {
			_r_prime = new Type2Node<G> (element, ref _iter_head, ref _iter_tail);
			_r_prime.parent = _r;
			_r.type2_child = _r_prime;
			if (_compare (_r_prime, _r) < 0)
				_swap_data (_r_prime, _r);
		} else {
			// Form a tree with a single node N of type I consisting of element e
			Type1Node<G> node = new Type1Node<G> (element, ref _iter_head, ref _iter_tail);

			//Add(Q, N)
			_add (node);
		}

		_stamp++;
		_size++;
		#if DEBUG
			_dump ("End offer: %s".printf ((string)element));
		#endif
		return true;
	}

	/**
	 * {@inheritDoc}
	 */
	public override G? peek () {
		if (_r == null) {
			return null;
		}
		return _r.data;
	}

	/**
	 * {@inheritDoc}
	 */
	public override G? poll () {
		#if DEBUG
			_dump ("Start poll:");
		#endif

		// 1a. M inElement <- R.element
		if (_r == null) {
			return null;
		}
		G min = _r.data;
		_r.pending_drop = false;
		_stamp++;
		_size--;

		// 1b. R.element = R'.element
		if (_r_prime == null) {
			if (_r.iter_next != null) {
				_r.iter_next.iter_prev = _r.iter_prev;
			}
			if (_r.iter_prev != null) {
				_r.iter_prev.iter_next = _r.iter_next;
			}
			if (_iter_head == _r) {
				_iter_head = _r.iter_next;
			}
			if (_iter_tail == _r) {
				_iter_tail = _r.iter_prev;
			}
			_r = null;
			_p = null;
			return min;
		}
		_move_data (_r, _r_prime);


		// 1c. R'' <- The child of R' containing the minimum element among the children of R'
		if (_r_prime.type1_children_head == null) {
			_remove_type2_node (_r_prime, true);
			_r_prime = null;
			return min;
		}
		Type1Node<G>? r_second = null;
		Type1Node<G> node = _r_prime.type1_children_head;
		while (node != null) {
			if (r_second == null || _compare (node, r_second) < 0) {
				r_second = node;
			}
			node = node.brothers_next;
		}

		// 1d. R'.element <- R''.element
		_move_data (_r_prime, r_second);

		// 2a. Delete the subtree rooted at R'' from Q
		_remove_type1_node (r_second, true);

		// 2b. For all children N of type I of R'' do make N a child of R' of Q
		node = r_second.type1_children_head;
		while (node != null) {
			Type1Node<G> next = node.brothers_next;
			_remove_type1_node (node, false);
			_add_in_r_prime (node);
			node = next;
		}

		// For now we can't have type2 node other than R' (left for reference)
		#if false
			// 3a. If R'' has no child of type II then goto Step 4.
			if (r_second.type2_child != null) {
				// 3b. Let M' be the child of type II of R''. Insert(Q, M'.element)
				Type2Node<G> m_prime = r_second.type2_child;
				_remove_type2_node (m_prime);
				offer (m_prime.data);

				// 3c. For all children N of M do make N a child of R' of Q
				node = m_prime.type1_children_head;
				while (node != null) {
					Type1Node<G> next = node.brothers_next;
					_remove_type1_node (node);
					_add_in_r_prime (node);
					node = next;
				}
			}
		#endif

		// 4. Adjust(Q, P, P)
		_adjust (_p, _p);

		// For now we can't have type2 node other than R' (left for reference)
		#if false
			// 5a. if LM is empty then goto Step 6
			if (_lm_head != null) {
				// 5b. M <- Head(LM); LM <- Tail(LM)
				Type2Node<G> m = _lm_head;

				// 5c. Delete M from Q
				_remove_type2_node (m);

				// 5d. I nsert(Q, M.element)
				offer (m.data);

				// 5e. For all children N of M do make M a child of R' of Q
				node = m.type1_children_head;
				while (node != null) {
					Type1Node<G> next = node.brothers_next;
					_remove_type1_node (node);
					_add_in_r_prime (node);
					node = next;
				}
			}
		#endif

		// 6. While among the children of R' there exist any two different nodes Ri and Rj
		// such that Ri.degree = Rj.degree do Link(Q, Ri, Rj)
		while (_check_linkable ()) {}

		// 7. Return MinElement
		return min;
	}

	/**
	 * {@inheritDoc}
	 */
	public int drain (Collection<G> recipient, int amount = -1) {
		if (amount == -1) {
			amount = this._size;
		}
		for (int i = 0; i < amount; i++) {
			if (this._size == 0) {
				return i;
			}
			recipient.add (poll ());
		}
		return amount;
	}

	/**
	 * {@inheritDoc}
	 */
	public override int size {
		get { return _size; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool contains (G item) {
		foreach (G an_item in this) {
			if (compare_func (item, an_item) == 0) {
				return true;
			}
		}
		return false;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool add (G item) {
		return offer (item);
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool remove (G item) {
		#if DEBUG
			_dump ("Start remove: %s".printf ((string) item));
		#endif

		Iterator<G> iterator = new Iterator<G> (this);
		while (iterator.next ()) {
			G an_item = iterator.get ();
			if (compare_func (item, an_item) == 0) {
				iterator.remove ();
				return true;
			}
		}
		return false;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void clear () {
		_size = 0;
		_r = null;
		_r_prime = null;
		_lm_head = null;
		_lm_tail = null;
		_p = null;
		_a = new Type1Node<G>?[0];
		_lp_head = null;
		_lp_tail = null;
		_b = new bool[0];
		_ll_head = null;
		_ll_tail = null;
		_iter_head = null;
		_iter_tail = null;
	}

	/**
	 * {@inheritDoc}
	 */
	public override Vala.Iterator<G> iterator () {
		return new Iterator<G> (this);
	}

	private inline int _compare (Node<G> node1, Node<G> node2) {
		// Assume there can't be two nodes pending drop
		if (node1.pending_drop) {
			return -1;
		} else if (node2.pending_drop) {
			return 1;
		} else {
			return compare_func (node1.data, node2.data);
		}
	}

	private inline void _swap_data (Node<G> node1, Node<G> node2) {
		#if DEBUG
			_dump ("Before swap: %p(%s) %p(%s)".printf(node1, (string)node1.data, node2, (string)node2.data));
		#endif
		G temp_data = (owned) node1.data;
		bool temp_pending_drop = node1.pending_drop;
		node1.data = (owned) node2.data;
		node1.pending_drop = node2.pending_drop;
		node2.data = (owned) temp_data;
		node2.pending_drop = temp_pending_drop;

		if (node1.iter_next == node2) { // Before swap: N1 N2
			unowned Node<G> temp_iter_prev = node1.iter_prev;
			unowned Node<G> temp_iter_next = node2.iter_next;

			node1.iter_prev = node2;
			node1.iter_next = temp_iter_next;
			node2.iter_prev = temp_iter_prev;
			node2.iter_next = node1;
		} else if (node1.iter_prev == node2) { // Before swap: N2 N1
			unowned Node<G> temp_iter_prev = node2.iter_prev;
			unowned Node<G> temp_iter_next = node1.iter_next;

			node1.iter_prev = temp_iter_prev;
			node1.iter_next = node2;
			node2.iter_prev = node1;
			node2.iter_next = temp_iter_next;
		} else {
			unowned Node<G> temp_iter_prev = node1.iter_prev;
			unowned Node<G> temp_iter_next = node1.iter_next;

			node1.iter_prev = node2.iter_prev;
			node1.iter_next = node2.iter_next;
			node2.iter_prev = temp_iter_prev;
			node2.iter_next = temp_iter_next;
		}

		if (node2 == _iter_head) {
			_iter_head = node1;
		} else if (node1 == _iter_head) {
			_iter_head = node2;
		}
		if (node2 == _iter_tail) {
			_iter_tail = node1;
		} else if (node1 == _iter_tail) {
			_iter_tail = node2;
		}

		if (node1.iter_prev != null) {
			node1.iter_prev.iter_next = node1;
		}
		if (node1.iter_next != null) {
			node1.iter_next.iter_prev = node1;
		}
		if (node2.iter_prev != null) {
			node2.iter_prev.iter_next = node2;
		}
		if (node2.iter_next != null) {
			node2.iter_next.iter_prev = node2;
		}

		#if DEBUG
			_dump ("After swap: %p(%s) %p(%s)".printf(node1, (string)node1.data, node2, (string)node2.data));
		#endif
	}

	private inline void _move_data (Node<G> target, Node<G> source) {
		#if DEBUG
			_dump ("Before move: %p(%s) <- %p(%s)".printf(target, (string)target.data, source, (string)source.data));
		#endif

		if (target.iter_next != null) {
			target.iter_next.iter_prev = target.iter_prev;
		} else if (_iter_tail == target) {
			_iter_tail = target.iter_prev;
		}
		if (target.iter_prev != null) {
			target.iter_prev.iter_next = target.iter_next;
		} else if (_iter_head == target) {
			_iter_head = target.iter_next;
		}

		target.data = source.data;
		target.pending_drop = source.pending_drop;
		target.iter_next = source.iter_next;
		target.iter_prev = source.iter_prev;
		source.iter_next = null;
		source.iter_prev = null;

		if (target.iter_next != null) {
			target.iter_next.iter_prev = target;
		} else if (_iter_tail == source) {
			_iter_tail = target;
		}
		if (target.iter_prev != null) {
			target.iter_prev.iter_next = target;
		} else if (_iter_head == source) {
			_iter_head = target;
		}
		#if DEBUG
			_dump ("After move:");
		#endif
	}

	private void _link (owned Type1Node<G> ri, owned Type1Node<G> rj) {
		assert (ri.degree () == rj.degree ());

		// Delete the subtrees rooted at Ri and Rj from Q
		_remove_type1_node (ri, false);
		_remove_type1_node (rj, false);

		// If Ri.element > Rj.element then Swap(Ri,Rj)
		if (_compare (ri, rj) > 0) {
			Type1Node<G> temp = ri;
			ri = rj;
			rj = temp;
		}

		// Make Rj the last child of Ri
		_add_to (rj, ri);

		// Make Ri (whose degree now = d+1) a child of R' of Q
		_add_in_r_prime (ri);
	}

	private void _add (Type1Node<G> n) {
		// Make N a child of R' of Q
		_add_in_r_prime (n);

		// If N.element < R'.element then Swap(N.element, R'.element)
		if (_compare (n, _r_prime) < 0) {
			_swap_data (n, _r_prime);
		}

		// If R'.element < R.element then Swap(R'.element, R.element)
		if (_compare (_r_prime, _r) < 0) {
			_swap_data (_r_prime, _r);
		}

		// If among the children of R' there exist any two different nodes Ri and Rj
		// such that Ri.degree = Rj.degree then Link(Q, Ri, Rj)
		_check_linkable ();

		#if DEBUG
			_dump ("End _add: %p(%s)".printf (n, (string) n.data));
		#endif
	}

	private bool _check_linkable () {
		#if DEBUG
			_dump ("Start _check_linkable:");
		#endif

		if (_lp_head != null) {
			NodePair<G> pair = _lp_head;
			_link (pair.node1, pair.node2);
			return true;
		}
		return false;
	}

	private Node<G> _re_insert (owned Type1Node<G> n) {
		assert (n != _r);

		#if DEBUG
			_dump ("Start _re_insert: %p(%s)".printf (n, (string) n.data));
		#endif

		//Parent <- N.parent
		Node<G> parent = n.parent;

		// Delete the subtree rooted at N from Q
		_remove_type1_node (n, false);

		// Add(Q, N)
		_add (n);

		// Return Parent
		return parent;
	}

	private void _adjust (Type1Node<G> p1, Type1Node<G> p2) {
		// If M.lost <= 1 for all nodes M in Q then return
		if (_ll_head == null) {
			return;
		}

		#if DEBUG
			_dump ("Start _adjust: %p(%s), %p(%s)".printf (p1, (string) p1.data, p2, (string) p2.data));
		#endif

		// If P1.lost > P2.lost then M <- P1 else M <- P2
		Type1Node<G> m;
		if (p1.lost > p2.lost) {
			m = p1;
		} else {
			m = p2;
		}

		// If M.lost <= 1 then M <- M' for some node M' in Q such that M'.lost > 1
		if (m.lost <= 1) {
			m = _ll_head;
			if (_ll_head.ll_next != null) {
				_ll_head.ll_next.ll_prev = null;
			}
			_ll_head = _ll_head.ll_next;
		}

		// P <- ReInsert(Q, M)
		_p = (Type1Node<G>) _re_insert (m);

		#if DEBUG
			_dump ("End _adjust: %p(%s), %p(%s)".printf (p1, (string) p1.data, p2, (string) p2.data));
		#endif
	}

	private void _delete (Node<G> n) {
		// DecreaseKey(Q, N, infinite)
		_decrease_key (n);

		// DeleteMin(Q)
		poll ();
	}

	private void _decrease_key (Node<G> n) {
		#if DEBUG
			_dump ("Start _decrease_key: %p(%s)".printf (n, (string) n.data));
		#endif

		if (n == _r || _r_prime == null) {
			return;
		}

		n.pending_drop = true;

		// If (N = R or R') and (R'.element < R.element) then
		// Swap(R'.element, R.element); return
		if (n == _r_prime && _compare (_r_prime, _r) < 0) {
			_swap_data (_r_prime, _r);
			return;
		}

		// For now we can't have type2 node other than R' (left for reference)
		#if false
			// If (N is of type II) and (N.element < N.parent.element) then
			// Swap(N.element, N.parent.element); N <- N.parent
			if (n is Type2Node && _compare (n, n.parent) < 0) {
				_swap_data (n, n.parent);
				n = n.parent;
			}
		#endif

		// Can't occur as we made n be the most little (left for reference)
		#if false
			// If N.element >= N.parent.element then return
			if (n.parent != null && _compare (n, n.parent) >= 0) {
				return;
			}
		#endif

		// P' <- ReInsert(Q, N)
		Node<G> p_prime = _re_insert ((Type1Node<G>) n);

		if (p_prime is Type2Node) {
			// Adjust(Q, P, P);
			_adjust (_p, _p);
		} else {
			// Adjust(Q, P, P');
			_adjust (_p, (Type1Node<G>) p_prime);
		}
	}

	private void _add_to (Type1Node<G> node, Type1Node<G> parent) {
		parent.add (node);
		parent.lost = 0;
	}

	private void _add_in_r_prime (Type1Node<G> node) {
		#if DEBUG
			_dump ("Start _add_in_r_prime: %p(%s)".printf (node, (string) node.data));
		#endif

		int degree = node.degree ();

		Type1Node<G>? insertion_point = null;
		if (degree < _a.length) {
			insertion_point = _a[degree];
		}

		if (insertion_point == null) {
			if (_r_prime.type1_children_tail != null) {
				node.brothers_prev = _r_prime.type1_children_tail;
				_r_prime.type1_children_tail.brothers_next = node;
			} else {
				_r_prime.type1_children_head = node;
			}
			_r_prime.type1_children_tail = node;
		} else {
			if (insertion_point.brothers_prev != null) {
				insertion_point.brothers_prev.brothers_next = node;
				node.brothers_prev = insertion_point.brothers_prev;
			} else {
				_r_prime.type1_children_head = node;
			}
			node.brothers_next = insertion_point;
			insertion_point.brothers_prev = node;
		}
		node.parent = _r_prime;

		// Maintain A, B and LP
		if (degree >= _a.length) {
			_a.resize (degree + 1);
			_b.resize (degree + 1);
		}

		// If there is already a child of such degree
		if (_a[degree] == null) {
			_b[degree] = true;
		} else {
			// Else if there is an odd number of child of such degree
			if (_b[degree]) {
				// Make a pair
				NodePair<G> pair = new NodePair<G> (node, node.brothers_next);
				node.brothers_next.pair = pair;
				node.pair = pair;
				if (_lp_head == null) {
					_lp_head = pair;
					_lp_tail = pair;
				} else {
					pair.lp_prev = _lp_tail;
					_lp_tail.lp_next = pair;
					_lp_tail = pair;
				}
				// There is now an even number of child of such degree
				_b[degree] = false;
			} else {
				_b[degree] = true;
			}
		}
		_a[degree] = node;

		#if DEBUG
			_dump ("End _add_in_r_prime: %p(%s)".printf (node, (string) node.data));
		#endif
	}

	private void _remove_type1_node (Type1Node<G> node, bool with_iteration) {
		#if DEBUG
			_dump ("Start _remove_type1_node: %p(%s)".printf (node, (string) node.data));
		#endif

		if (node.parent == _r_prime) {
			_updated_degree (node, false);
		} else {
			// Maintain LL
			if (node.ll_prev != null) {
				node.ll_prev.ll_next = node.ll_next;
			} else if (_ll_head == node) {
				_ll_head = node.ll_next;
			}
			if (node.ll_next != null) {
				node.ll_next.ll_prev = node.ll_prev;
			} else if (_ll_tail == node) {
				_ll_tail = node.ll_prev;
			}

			if (node.parent != null) {
				if (node.parent.parent == _r_prime) {
					_updated_degree ((Type1Node<G>) node.parent, true);
				} else if (node.parent.parent != null) {
					Type1Node<G> parent = (Type1Node<G>) node.parent;

					// Increment parent's lost count
					parent.lost++;

					// And add it to LL if needed
					if (parent.lost > 1) {
						if (_ll_tail != null) {
							parent.ll_prev = _ll_tail;
							_ll_tail.ll_next = parent;
						} else {
							_ll_head = parent;
						}
						_ll_tail = parent;
					}
				}
			}
		}

		// Check whether removed node is P
		if (node == _p) {
			_p = _r;
		}

		// Maintain brothers list
		node.remove ();

		// Maintain iteration
		if (with_iteration) {
			if (node.iter_prev != null) {
				node.iter_prev.iter_next = node.iter_next;
			} else if (_iter_head == node) {
				_iter_head = node.iter_next;
			}
			if (node.iter_next != null) {
				node.iter_next.iter_prev = node.iter_prev;
			} else if (_iter_tail == node) {
				_iter_tail = node.iter_prev;
			}
		}
		#if DEBUG
			_dump ("End _remove_type1_node: %p(%s)".printf (node, (string) node.data));
		#endif
	}

	private void _updated_degree (Type1Node<G> node, bool child_removed) {
		int degree = node.degree ();

		// Ensure proper sizes of A and B
		if (degree >= _a.length) {
			_a.resize (degree + 1);
			_b.resize (degree + 1);
		}

		// Maintain A and B
		if (child_removed && _a[degree - 1] == null) {
			_a[degree - 1] = node;
			_b[degree - 1] = ! _b[degree - 1];
		}

		_b[degree] = ! _b[degree];
		if (_a[degree] == node) {
			Type1Node<G> next = node.brothers_next;
			if (next != null && next.degree () == degree) {
				_a[degree] = next;
			} else {
				_a[degree] = null;

				int i = _a.length - 1;
				while (i >= 0 && _a[i] == null) {
					i--;
				}
				_a.resize (i + 1);
				_b.resize (i + 1);
			}
		}

		// Maintain LP
		if (node.pair != null) {
			NodePair<G> pair = node.pair;
			Type1Node<G> other = (pair.node1 == node ? pair.node2 : pair.node1);
			node.pair = null;
			other.pair = null;
			if (pair.lp_prev != null) {
				pair.lp_prev.lp_next = pair.lp_next;
			} else {
				_lp_head = pair.lp_next;
			}
			if (pair.lp_next != null) {
				pair.lp_next.lp_prev = pair.lp_prev;
			} else {
				_lp_tail = pair.lp_prev;
			}
		}
	}

	private void _remove_type2_node (Type2Node<G> node, bool with_iteration) {
		#if DEBUG
			_dump ("Start _remove_type2_node: %p(%s)".printf (node, (string) node.data));
		#endif
		((Type1Node<G>) node.parent).type2_child = null;
		node.parent = null;

		// For now we can't have type2 node other than R' (left for reference)
		#if false
			// Maintain LM
			if (node != _r_prime) {
				if (node.lm_prev != null) {
					node.lm_prev.lm_next = node.lm_next;
				} else if (_lm_head == node) {
					_lm_head = node.lm_next;
				}
				if (node.lm_next != null) {
					node.lm_next.lm_prev = node.lm_prev;
				} else if (_lm_tail == node)  {
					_lm_tail = node.lm_prev;
				}
				node.lm_next = null;
				node.lm_prev = null;
			}
		#endif

		// Maintain iteration
		if (with_iteration) {
			if (node.iter_prev != null) {
				node.iter_prev.iter_next = node.iter_next;
			} else if (_iter_head == node) {
				_iter_head = node.iter_next;
			}
			if (node.iter_next != null) {
				node.iter_next.iter_prev = node.iter_prev;
			} else if (_iter_tail == node) {
				_iter_tail = node.iter_prev;
			}
		}
		#if DEBUG
			_dump ("End _remove_type2_node: %p(%s)".printf (node, (string) node.data));
		#endif
	}

	#if DEBUG
	public void _dump (string message) {
		stdout.printf (">>>> %s\n", message);

		stdout.printf ("A.length = %d:", _a.length);
		foreach (Node<G>? node in _a) {
			stdout.printf (" %p(%s);", node, node != null ? (string) node.data : null);
		}
		stdout.printf ("\n");

		stdout.printf ("B.length = %d:", _b.length);
		foreach (bool even in _b) {
			stdout.printf (" %s;", even.to_string ());
		}
		stdout.printf ("\n");

		stdout.printf ("LP:");
		unowned NodePair<G>? pair = _lp_head;
		while (pair != null) {
			stdout.printf (" (%p(%s),%p(%s));", pair.node1, (string) pair.node1.data, pair.node2, (string) pair.node2.data);
			pair = pair.lp_next;
		}
		stdout.printf ("\n");

		stdout.printf ("LL:");
		unowned Type1Node<G>? node = _ll_head;
		while (node != null) {
			stdout.printf (" %p(%s);", node, (string) node.data);
			node = node.ll_next;
		}
		stdout.printf ("\n");

		stdout.printf ("ITER:");
		unowned Node<G>? inode_prev = null;
		unowned Node<G>? inode = _iter_head;
		while (inode != null) {
			stdout.printf (" %p(%s);", inode, (string) inode.data);
			assert (inode.iter_prev == inode_prev);
			inode_prev = inode;
			inode = inode.iter_next;
		}
		stdout.printf ("\n");

		stdout.printf ("%s\n", _r != null ? _r.to_string () : null);

		stdout.printf ("\n");
	}
	#endif

	private abstract class Node<G> {
		public G data;
		public weak Node<G>? parent = null;

		public int type1_children_count;
		public Type1Node<G>? type1_children_head = null;
		public Type1Node<G>? type1_children_tail = null;

		public unowned Node<G>? iter_prev;
		public unowned Node<G>? iter_next = null;

		public bool pending_drop;

		protected Node (G data, ref unowned Node<G>? head, ref unowned Node<G>? tail) {
			this.data = data;
			iter_prev = tail;
			tail = this;
			if (iter_prev != null) {
				iter_prev.iter_next = this;
			}
			if (head == null) {
				head = this;
			}
		}

		public inline int degree () {
			return type1_children_count;
		}

	#if DEBUG
		public string children_to_string (int level = 0) {
			StringBuilder builder = new StringBuilder ();
			bool first = true;
			Type1Node<G> child = type1_children_head;
			while (child != null) {
				if (!first) {
					builder.append (",\n");
				}
				first = false;
				builder.append (child.to_string (level));
				child = child.brothers_next;
			}
			return builder.str;
		}

		public abstract string to_string (int level = 0);
	#endif
	}

	private class Type1Node<G> : Node<G> {
		public uint lost;
		public weak Type1Node<G>? brothers_prev = null;
		public Type1Node<G>? brothers_next = null;
		public Type2Node<G>? type2_child = null;
		public weak Type1Node<G>? ll_prev = null;
		public Type1Node<G>? ll_next = null;
		public weak NodePair<G>? pair = null;

		public Type1Node (G data, ref unowned Node<G>? head, ref unowned Node<G>? tail) {
			base (data, ref head, ref tail);
		}

		public inline void add (Type1Node<G> node) {
			node.parent = this;
			if (type1_children_head == null) {
				type1_children_head = node;
			} else {
				node.brothers_prev = type1_children_tail;
			}
			if (type1_children_tail != null) {
				type1_children_tail.brothers_next = node;
			}
			type1_children_tail = node;
			type1_children_count++;
		}

		public inline void remove () {
			if (brothers_prev == null) {
				parent.type1_children_head = brothers_next;
			} else {
				brothers_prev.brothers_next = brothers_next;
			}
			if (brothers_next == null) {
				parent.type1_children_tail = brothers_prev;
			} else {
				brothers_next.brothers_prev = brothers_prev;
			}
			parent.type1_children_count--;
			parent = null;
			brothers_prev = null;
			brothers_next = null;
		}

		#if DEBUG
		public override string to_string (int level = 0) {
			StringBuilder builder = new StringBuilder ();
			builder.append (string.nfill (level, '\t'));
			builder.append ("(");
			builder.append_printf("%p(%s)/%u", this, (string)data, lost);
			if (type1_children_head != null || type2_child != null) {
				builder.append (":\n");
			}
			if (type1_children_head != null) {
				builder.append (children_to_string (level + 1));
			}
			if (type1_children_head != null && type2_child != null) {
				builder.append (",\n");
			}
			if (type2_child != null) {
				builder.append (type2_child.to_string (level + 1));
			}
			if (type1_children_head != null || type2_child != null) {
				builder.append ("\n");
				builder.append (string.nfill (level, '\t'));
			}
			builder.append (")");
			return builder.str;
		}
		#endif
	}

	private class Type2Node<G> : Node<G> {
		// For now we can't have type2 node other than R' (left for reference)
		#if false
			public weak Type2Node<G>? lm_prev = null;
			public Type2Node<G>? lm_next = null;
		#endif

		public Type2Node (G data, ref unowned Node<G>? head, ref unowned Node<G>? tail) {
			base (data, ref head, ref tail);
		}

		#if DEBUG
		public override string to_string (int level = 0) {
			StringBuilder builder = new StringBuilder ();
			builder.append (string.nfill (level, '\t'));
			builder.append_printf ("[%p(%s)", this, (string)data);
			if (type1_children_head != null) {
				builder.append (":\n");
				builder.append (children_to_string (level + 1));
				builder.append ("\n");
				builder.append (string.nfill (level, '\t'));
			}
			builder.append ("]");
			return builder.str;
		}
		#endif
	}

	private class DummyNode<G> : Node<G> {
		public DummyNode (ref unowned Node<G>? prev_next, ref unowned Node<G>? next_prev, Node<G>? iter_prev, Node<G>? iter_next) {
			#if DEBUG
			base ("<<dummy>>", ref prev_next, ref next_prev);
			#else
			base (null, ref prev_next, ref next_prev);
			#endif
			this.iter_prev = iter_prev;
			this.iter_next = iter_next;
			prev_next = next_prev = this;
		}

		#if DEBUG
		public override string to_string (int level = 0) {
			StringBuilder builder = new StringBuilder ();
			builder.append (string.nfill (level, '\t'));
			builder.append ("%p<<dummy>>".printf(this));
			return builder.str;
		}
		#endif
	}

	private class NodePair<G> {
		public weak NodePair<G>? lp_prev = null;
		public NodePair<G>? lp_next = null;
		public Type1Node<G> node1 = null;
		public Type1Node<G> node2 = null;

		public NodePair (Type1Node<G> node1, Type1Node<G> node2) {
			this.node1 = node1;
			this.node2 = node2;
		}
	}

	private class Iterator<G> : Object, Traversable<G>, Vala.Iterator<G> {
		private PriorityQueue<G> queue;
		private unowned Node<G>? position;
		private unowned Node<G>? previous;
		private int stamp;

		public Iterator (PriorityQueue<G> queue) {
			this.queue = queue;
			this.position = null;
			this.previous = null;
			this.stamp = queue._stamp;
		}

		public bool next () {
			unowned Node<G>? next = _get_next_node ();
			if (next != null) {
				previous = position;
				position = next;
			}
			return next != null;
		}

		public bool has_next () {
			return _get_next_node () != null;
		}

		private inline unowned Node<G>? _get_next_node () {
			if (position != null) {
				return position.iter_next;
			} else {
				return (previous != null) ? previous.iter_next : queue._iter_head;
			}
		}

		public new G get () {
			assert (stamp == queue._stamp);
			assert (position != null);
			return position.data;
		}

		public void remove () {
			assert (stamp == queue._stamp);
			assert (position != null);
			DummyNode<G> dn;
			if (previous != null) {
				dn = new DummyNode<G> (ref previous.iter_next, ref position.iter_prev, previous, position);
			} else {
				dn = new DummyNode<G> (ref queue._iter_head, ref position.iter_prev, null, position);
			}
			queue._delete (position);
			position = null;
			if (previous != null) {
				previous.iter_next = dn.iter_next;
			}
			if (dn == queue._iter_head) {
				queue._iter_head = dn.iter_next;
			}
			if (dn.iter_next != null) {
				dn.iter_next.iter_prev = previous;
			}
			if (dn == queue._iter_tail) {
				queue._iter_tail = previous;
			}
			stamp++;
			assert (stamp == queue._stamp);
		}

		public bool read_only { get { return false; } }

		public bool valid { get { return position != null; } }

		public bool foreach (ForallFunc<G> f) {
			if (position == null) {
				position = (previous != null) ? previous.iter_next : queue._iter_head;
			}
			if (position == null) {
				return true;
			}
			if (!f (position.data)) {
				return false;
			}
			while (position.iter_next != null) {
				previous = position;
				position = position.iter_next;
				if (!f (position.data)) {
					return false;
				}
			}
			return true;
		}
	}
}
