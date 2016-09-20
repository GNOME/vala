/* hazardpointer.vala
 *
 * Copyright (C) 2011  Maciej Piechotka
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
 * Hazard pointer is a method of protecting a pointer shared by many threads.
 * If you want to use atomic pointer that may be freed you should use following code:
 *
 * {{{
 *    string *shared_pointer = ...;
 *    HazardPointer<string> hptr = HazardPointer.get_hazard_pointer (&shared_pointer);
 *    // my_string contains value from shared_pinter. It is valid as long as hptr is alive.
 *    unowned string my_string = ptr.get ();
 *    // instead of delete
 *    ptr.release ((ptr) => {string *sptr = ptr;string ref = (owned)sptr;});
 *    });
 * }}}
 *
 * In some cases you may use helper methods which might involve copying of object (and are unsafe for unowned objects):
 * {{{
 *    Gtk.Window *window = ...;
 *    Gtk.Window? local_window = HazardPointer.get_pointer (&window);
 *    HazardPointer.set_pointer (&window, ...)
 *    local_window = HazardPointer.exchange_pointer (&window, null);
 *    HazardPointer.compare_and_exchange (&window, null, local_window);
 * }}}
 *
 * The class also provides helper methods if least significant bits are used for storing flags.
 *
 * HazardPointers are not thread-safe (unless documentation states otherwise).
 */
[Compact]
public class Vala.HazardPointer<G> { // FIXME: Make it a struct
	/**
	 * Creates a hazard pointer for a pointer.
	 *
	 * @param ptr Protected pointer
	 */
	public HazardPointer (G *ptr) {
		this._node = acquire ();
		this._node.set ((void *)ptr);
	}

	/**
	 * Create a hazard pointer from Node.
	 */
	internal HazardPointer.from_node (Node node) {
		this._node = node;
	}

	/**
	 * Gets hazard pointer from atomic pointer safely.
	 *
	 * @param aptr Atomic pointer.
	 * @param mask Mask of bits.
	 * @param mask_out Result of mask.
	 * @return Hazard pointer containing the element.
	 */
	public static HazardPointer<G>? get_hazard_pointer<G> (G **aptr, size_t mask = 0, out size_t mask_out = null) {
		unowned Node node = acquire ();
		void *rptr = null;
		void *ptr = null;
		mask_out = 0;
		do {
			rptr = AtomicPointer.get ((void **)aptr);
			ptr = (void *)((size_t) rptr & ~mask);
			mask_out = (size_t) rptr & mask;
			node.set (ptr);
		} while (rptr != AtomicPointer.get ((void **)aptr));
		if (ptr != null) {
			return new HazardPointer<G>.from_node (node);
		} else {
			node.release ();
			return null;
		}
	}

	/**
	 * Copy an object from atomic pointer.
	 *
	 * @param aptr Atomic pointer.
	 * @param mask Mask of flags.
	 * @param mask_out Result of mask.
	 * @return A copy of object from atomic pointer.
	 */
	public static G? get_pointer<G> (G **aptr, size_t mask = 0, out size_t mask_out = null) {
		unowned Node node = acquire ();
		void *rptr = null;
		void *ptr = null;
		mask_out = 0;
		do {
			rptr = AtomicPointer.get ((void **)aptr);
			ptr = (void *)((size_t) rptr & ~mask);
			mask_out = (size_t) rptr & mask;
			node.set (ptr);
		} while (rptr != AtomicPointer.get ((void **)aptr));
		G? res = (G *)ptr;
		node.release ();
		return res;
	}

	/**
	 * Exchange objects safly.
	 *
	 * @param aptr Atomic pointer.
	 * @param new_ptr New value
	 * @param mask Mask of flags.
	 * @param new_mask New mask.
	 * @param old_mask Previous mask mask.
	 * @return Hazard pointer containing old value.
	 */
	public static HazardPointer<G>? exchange_hazard_pointer<G> (G **aptr, owned G? new_ptr, size_t mask = 0, size_t new_mask = 0, out size_t old_mask = null) {
		unowned Node? new_node = null;
		if (new_ptr != null) {
			new_node = acquire ();
			new_node.set (new_ptr);
		}
		old_mask = 0;
		void *new_rptr = (void *)((size_t)((owned) new_ptr) | (mask & new_mask));
		unowned Node node = acquire ();
		void *rptr = null;
		void *ptr = null;
		do {
			rptr = AtomicPointer.get ((void **)aptr);
			ptr = (void *)((size_t) rptr & ~mask);
			old_mask = (size_t) rptr & mask;
			node.set (ptr);
		} while (!AtomicPointer.compare_and_exchange((void **)aptr, rptr, new_rptr));
		if (new_node != null)
			new_node.release ();
		if (ptr != null) {
			return new HazardPointer<G>.from_node (node);
		} else {
			node.release ();
			return null;
		}
	}

	/**
	 * Sets object safely
	 *
	 * @param aptr Atomic pointer.
	 * @param new_ptr New value
	 * @param mask Mask of flags.
	 * @param new_mask New mask.
	 */
	public static void set_pointer<G> (G **aptr, owned G? new_ptr, size_t mask = 0, size_t new_mask = 0) {
		HazardPointer<G>? ptr = exchange_hazard_pointer<G> (aptr, new_ptr, mask, new_mask, null);
		if (ptr != null) {
			DestroyNotify? notify = Utils.Free.get_destroy_notify<G> ();
			if (notify != null) {
				ptr.release ((owned)notify);
			}
		}
	}

	/**
	 * Exchange objects safly.
	 *
	 * @param aptr Atomic pointer.
	 * @param new_ptr New value
	 * @param mask Mask of flags.
	 * @param new_mask New mask.
	 * @param old_mask Previous mask mask.
	 * @return Value that was previously stored.
	 */
	public static G? exchange_pointer<G> (G **aptr, owned G? new_ptr, size_t mask = 0, size_t new_mask = 0, out size_t old_mask = null) {
		HazardPointer<G>? ptr = exchange_hazard_pointer<G> (aptr, new_ptr, mask, new_mask, out old_mask);
		G? rptr = ptr != null ? ptr.get () : null;
		return rptr;
	}

	/**
	 * Compares and exchanges objects.
	 *
	 * @param aptr Atomic pointer.
	 * @param old_ptr Old pointer.
	 * @param _new_ptr New value.
	 * @param old_mask Old mask.
	 * @param new_mask New mask.
	 * @return Value that was previously stored.
	 */
	public static bool compare_and_exchange_pointer<G> (G **aptr, G? old_ptr, owned G? _new_ptr, size_t mask = 0, size_t old_mask = 0, size_t new_mask = 0) {
		G *new_ptr = (owned)_new_ptr;
		void *new_rptr = (void *)((size_t)(new_ptr) | (mask & new_mask));
		void *old_rptr = (void *)((size_t)(old_ptr) | (mask & old_mask));
		bool success = AtomicPointer.compare_and_exchange((void **)aptr, old_rptr, new_rptr);
		if (success) {
			DestroyNotify? notify = Utils.Free.get_destroy_notify<G> ();
			if (old_ptr != null && notify != null) {
				Context.get_current_context ()->release_ptr (old_ptr, (owned)notify);
			}
		} else if (new_ptr != null) {
			_new_ptr = (owned)new_ptr;
		}
		return success;
	}

	~HazardPointer () {
		_node.release ();
	}

	/**
	 * Gets the pointer hold by hazard pointer.
	 *
	 * @param other_thread Have to be set to ``true`` if accessed from thread that did not create this thread.
	 * @return The value hold by pointer.
	 */
	public inline new unowned G get (bool other_thread = false) {
		return _node[other_thread];
	}

	/**
	 * Free the pointer.
	 *
	 * @param notify method freeing object
	 */
	public void release (owned DestroyNotify notify) {
		unowned G item = _node[false];
		_node.set (null);
		if (item != null) {
			Context.get_current_context ()->release_ptr (item, (owned)notify);
		}
	}

	/**
	 * Sets default policy (i.e. default policy for user-created contexts).
	 * The policy must be concrete and should not be blocking.
	 *
	 * @param policy New default policy.
	 */
	public static void set_default_policy (Policy policy) requires (policy.is_concrete ()) {
		if (policy.is_blocking ())
			warning ("Setting blocking defautl Vala.HazardPointer.Policy (there may be a deadlock).\n");
		AtomicInt.set(ref _default_policy, (int)policy);
	}

	/**
	 * Sets thread exit policy (i.e. default policy for the top-most Context).
	 * The policy must be concrete and should not be unsafe.
	 *
	 * @param policy New thread policy.
	 */
	public static void set_thread_exit_policy (Policy policy) requires (policy.is_concrete ()) {
		if (!policy.is_safe ())
			warning ("Setting unsafe globale thread-exit Vala.HazardPointer.Policy (there may be a memory leak).\n");
		AtomicInt.set(ref _thread_exit_policy, (int)policy);
	}

	/**
	 * Sets release (i.e. how exactly the released objects arefreed).
	 *
	 * The method can be only set before any objects is released and is not thread-safe.
	 *
	 * @param policy New release policy.
	 */
	public static bool set_release_policy (ReleasePolicy policy) {
		int old_policy = AtomicInt.get (ref release_policy);
		if ((old_policy & (sizeof(int) * 8 - 1)) != 0) {
			critical ("Attempt to change the policy of running helper. Failing.");
			return false;
		}
		if (!AtomicInt.compare_and_exchange (ref release_policy, old_policy, (int)policy)) {
			critical ("Concurrent access to release policy detected. Failing.");
			return false;
		}
		return true;
	}

	/**
	 * Policy determines what happens on exit from Context.
	 */
	public enum Policy {
		/**
		 * Performs default action on exit from thread.
		 */
		DEFAULT,
		/**
		 * Performs the same action as on exit from current thread.
		 */
		THREAD_EXIT,
		/**
		 * Goes through the free list and attempts to free un-freed elements.
		 */
		TRY_FREE,
		/**
		 * Goes through the free list and attempts to free un-freed elements
		 * untill all elements are freed.
		 */
		FREE,
		/**
		 * Release the un-freed elements to either helper thread or to main loop.
		 * Please note if the operation would block it is not performed.
		 */
		TRY_RELEASE,
		/**
		 * Release the un-freed elements to either helper thread or to main loop.
		 * Please note it may block while adding to queue.
		 */
		RELEASE;

		/**
		 * Checks if the policy is concrete or if it depends on global variables.
		 *
		 * @return ``true`` if this policy does not depend on global variables
		 */
		public bool is_concrete () {
			switch (this) {
			case DEFAULT:
			case THREAD_EXIT:
				return false;
			case TRY_FREE:
			case FREE:
			case TRY_RELEASE:
			case RELEASE:
				return true;
			default:
				assert_not_reached ();
			}
		}

		/**
		 * Checks if policy blocks or is lock-free.
		 * Please note that it works on a concrete policy only.
		 *
		 * @return ``true`` if the policy may block the thread.
		 */
		public bool is_blocking () requires (this.is_concrete ()) {
			switch (this) {
			case TRY_FREE:
			case TRY_RELEASE:
				return false;
			case FREE:
			case RELEASE:
				return true;
			default:
				assert_not_reached ();
			}
		}

		/**
		 * Checks if policy guarantees freeing all elements.
		 * Please note that it works on a concrete policy only.
		 *
		 * @return ``true`` if the policy guarantees freeing all elements.
		 */
		public bool is_safe () requires (this.is_concrete ()) {
			switch (this) {
			case TRY_FREE:
			case TRY_RELEASE:
				return false;
			case FREE:
			case RELEASE:
				return true;
			default:
				assert_not_reached ();
			}
		}

		/**
		 * Finds concrete policy which corresponds to given policy.
		 *
		 * @return Policy that corresponds to given policy at given time in given thread.
		 */
		public Policy to_concrete () ensures (result.is_concrete ()) {
			switch (this) {
			case TRY_FREE:
			case FREE:
			case TRY_RELEASE:
			case RELEASE:
				return this;
			case DEFAULT:
				return (Policy) AtomicInt.get (ref _default_policy);
			case THREAD_EXIT:
				return (Policy) AtomicInt.get (ref _thread_exit_policy);
			default:
				assert_not_reached ();

			}
		}

		/**
		 * Runs the policy.
		 * @param to_free List containing elements to free.
		 * @return Non-empty list of not freed elements or ``null`` if all elements have been disposed.
		 */
		internal bool perform (ref ArrayList<FreeNode *> to_free) {
			switch (this.to_concrete ()) {
			case TRY_FREE:
				return try_free (to_free);
			case FREE:
				while (try_free (to_free)) {
					Thread.yield ();
				}
				break;
			case TRY_RELEASE:
				ReleasePolicy.ensure_start ();
				if (_queue_mutex.trylock ()) {
					_queue.offer ((owned) to_free);
					_queue_mutex.unlock ();
					return true;
				} else {
					return false;
				}
			case RELEASE:
				ReleasePolicy.ensure_start ();
				_queue_mutex.lock ();
				_queue.offer ((owned) to_free);
				_queue_mutex.unlock ();
				return true;
			default:
				assert_not_reached ();
			}
			return false;
		}
	}

	/**
	 * Release policy determines what happens with object freed by Policy.TRY_RELEASE
	 * and Policy.RELEASE.
	 */
	public enum ReleasePolicy {
		/**
		 * Libgee spawns helper thread to free those elements.
		 * This is default.
		 */
		HELPER_THREAD,
		/**
		 * Libgee uses GLib main loop.
		 * This is recommended for application using GLib main loop.
		 */
		MAIN_LOOP;

		private static void start (ReleasePolicy self) { // FIXME: Make it non-static [bug 659778]
			switch (self) {
			case HELPER_THREAD:
				new Thread<bool> ("<<libgee hazard pointer>>", () => {
					Context ctx = new Context (Policy.TRY_FREE);
					while (true) {
						Thread.yield ();
						pull_from_queue (ctx._to_free, ctx._to_free.is_empty);
						ctx.try_free ();
						if (ctx._to_free.is_empty) {
							GLib.Thread.usleep (100000);
						}
					}
				});
				break;
			case MAIN_LOOP:
				_global_to_free = new ArrayList<FreeNode *> ();
				Idle.add (() => {
					Context ctx = new Context (Policy.TRY_FREE);
					swap (ref _global_to_free, ref ctx._to_free);
					pull_from_queue (ctx._to_free, false);
					ctx.try_free ();
					swap (ref _global_to_free, ref ctx._to_free);
					return true;
				}, Priority.LOW);
				break;
			default:
				assert_not_reached ();
			}
		}

		private static void swap<T>(ref T a, ref T b) {
			T tmp = (owned)a;
			a = (owned)b;
			b = (owned)tmp;
		}

		/**
		 * Ensures that helper methods are started.
		 */
		internal static inline void ensure_start () {
			int policy = AtomicInt.get (ref release_policy);
			if ((policy & (1 << (sizeof(int) * 8 - 1))) != 0)
				return;
			if (_queue_mutex.trylock ()) {
				policy = AtomicInt.get (ref release_policy);
				if ((policy & (1 << (sizeof(int) * 8 - 1))) == 0) {
					_queue = new LinkedList<ArrayList<FreeNode *>> ();
					// Hack to not lie about successfull setting policy
					policy = AtomicInt.add (ref release_policy, (int)(1 << (sizeof(int) * 8 - 1)));
					start ((ReleasePolicy) policy);
				}
				_queue_mutex.unlock ();
			}
		}

		private static inline void pull_from_queue (Collection<FreeNode *> to_free, bool do_lock) {
			bool locked = do_lock;
			if (do_lock) {
				_queue_mutex.lock ();
			} else {
				locked = _queue_mutex.trylock ();
			}
			if (locked) {
				Collection<ArrayList<FreeNode *>> temp = new ArrayList<ArrayList<FreeNode *>> ();
				_queue.drain (temp);
				_queue_mutex.unlock ();
				temp.foreach ((x) => {to_free.add_all (x); return true;});
			}
		}
	}

	/**
	 * Create a new context. User does not need to create explicitly however it might be benefitial
	 * if he is about to issue bunch of commands he might consider it benefitial to fine-tune the creation of contexts.
	 *
	 * {{{
	 *   Context ctx = new Context ();
	 *   lock_free_collection.operation1 ();
	 *   // Normally on exit the thread exit operation would be executed but here the default operation of
	 *   // child context is executed.
	 *   lock_free_collection.operation2 ();
	 * }}}
	 *
	 * Please note that the Context in implicitly part of stack and:
	 *
	 * 1. It cannot be moved between threads.
	 * 2. If in given thread the child (created later) context is alive parent must be alive as well.
	 */
	[Compact]
	public class Context { // FIXME: Should be struct
		public Context (Policy? policy = null) {
			this._to_free = new ArrayList<FreeNode *> ();
			this._parent = _current_context.get ();
			_current_context.set (this, null);
			if (policy == null) {
				if (_parent == null) {
					_policy = (Policy)AtomicInt.get (ref _thread_exit_policy);
				} else {
					_policy = (Policy)AtomicInt.get (ref _default_policy);
				}
			} else {
				this._policy = policy.to_concrete ();
			}
#if DEBUG
			stderr.printf ("Entering context %p (policy %s, parent %p)\n", this, _policy != null ? _policy.to_string () : null, _parent);
#endif
		}

		~Context () {
#if DEBUG
			stderr.printf ("Exiting context %p (policy %s, parent %p)\n", this, _policy != null ? _policy.to_string () : null, _parent);
#endif
			int size = _to_free.size;
			bool clean_parent = false;
			if (size > 0) {
				if (_parent == null || size >= THRESHOLD) {
					if (!_policy.perform (ref _to_free)) {
						assert (_parent != null && _to_free != null);
						_parent->_to_free.add_all (_to_free);
						clean_parent = true;
					}
				}
			}
#if DEBUG
			stderr.printf ("Setting current context to %p\n", _parent);
#endif
			_current_context.set (_parent, null);
			if (clean_parent)
				HazardPointer.try_free (_parent->_to_free);
		}

		/**
		 * Tries to free all freed pointer in current context.
		 */
		public void try_free () {
			HazardPointer.try_free (_to_free);
		}

		/**
		 * Ensure that whole context is freed. Plase note that it might block.
		 */
		public void free_all () {
			while (HazardPointer.try_free (_to_free))
				Thread.yield ();
		}

		/**
		 * Tries to push the current context to releaser.
		 */
		public void try_release () {
			if (_queue_mutex.trylock ()) {
				_queue.offer ((owned) _to_free);
				_to_free = new ArrayList<FreeNode *> ();
				_queue_mutex.unlock ();
			}
		}

		/**
		 * Pushes the current context to releaser. Plase note that it might block.
		 */
		public void release () {
			_queue_mutex.lock ();
			_queue.offer ((owned) _to_free);
			_to_free = new ArrayList<FreeNode *> ();
			_queue_mutex.unlock ();
		}

		/**
		 * Add pointer to freed array.
		 */
		internal inline void release_ptr (void *ptr, owned DestroyNotify notify) {
			FreeNode *node = new FreeNode ();
			node->pointer = ptr;
			node->destroy_notify = (owned)notify;
			_to_free.add (node);
			if (_to_free.size >= THRESHOLD)
				HazardPointer.try_free (_to_free);
		}

		/**
		 * Gets current context.
		 */
		internal inline static Context *get_current_context () {
			return _current_context.get ();
		}

		internal Context *_parent;
		internal ArrayList<FreeNode *> _to_free;
		internal Policy? _policy;
		internal static StaticPrivate _current_context;
		internal static StaticPrivate _root_context;
		private static uint THRESHOLD = 10;
	}

	/**
	 * Gets a new hazard pointer node.
	 *
	 * @return new hazard pointer node.
	 */
	internal static inline unowned Node acquire () {
		for (unowned Node? curr = get_head (); curr != null; curr = curr.get_next ())
			if (curr.activate ())
				return curr;
		Node *node = new Node ();
		Node *old_head = null;
		do {
			node->set_next (old_head = (Node *)AtomicPointer.get (&_head));
		} while (!AtomicPointer.compare_and_exchange (&_head, old_head, node));
		return  node;
	}

	/**
	 * Tries to free from list.
	 *
	 * @return ``true`` if list is empty.
	 */
	internal static bool try_free (ArrayList<FreeNode *> to_free) {
		Collection<void *> used = new HashSet<void *>();
		for (unowned Node? current = get_head (); current != null; current = current.get_next ()) {
			used.add (current.get ());
		}
		for (int i = 0; i < to_free.size;) {
			FreeNode *current = to_free[i];
			if (used.contains (current->pointer)) {
#if DEBUG
				stderr.printf ("Skipping freeing %p\n", current->pointer);
#endif
				i++;
			} else {
#if DEBUG
				stderr.printf ("Freeing %p\n", current->pointer);
#endif
				FreeNode *cur = to_free.remove_at (to_free.size - 1);
				if (i != to_free.size) {
					FreeNode *temp = to_free[i];
					to_free[i] = cur;
					cur = temp;
				}
				cur->destroy_notify (cur->pointer);
				delete cur;
			}
		}
		return to_free.size > 0;
	}

	/**
	 * Gets head of hazard pointers.
	 * @return Hazard pointer head.
	 */
	internal static unowned Node? get_head () {
		return (Node *)AtomicPointer.get(&_head);
	}

	internal unowned Node _node;

	internal static Node *_head = null;

	internal static int _default_policy = (int)Policy.TRY_FREE;
	internal static int _thread_exit_policy = (int)Policy.RELEASE;

	internal static int release_policy = 0;

	internal static Queue<ArrayList<FreeNode *>> _queue;
	internal static StaticMutex _queue_mutex;

	internal static ArrayList<FreeNode *> _global_to_free;

	[Compact]
	internal class FreeNode {
		public void *pointer;
		public DestroyNotify destroy_notify;
	}

	/**
	 * List of used pointers.
	 */
	[Compact]
	internal class Node {
		public Node () {
			AtomicPointer.set (&_hazard, null);
			AtomicInt.set (ref _active, 1);
		}
		
		inline ~Node () {
			delete _next;
		}

		public void release () {
			AtomicPointer.set (&_hazard, null);
			AtomicInt.set (ref _active, 0);
		}

		public inline bool is_active () {
			return AtomicInt.get (ref _active) != 0;
		}

		public inline bool activate () {
			return AtomicInt.compare_and_exchange (ref _active, 0, 1);
		}

		public inline void set (void *ptr) {
			AtomicPointer.set (&_hazard, ptr);
		}

		public inline void *get (bool safe = true) {
			if (safe) {
				return (void *)AtomicPointer.get (&_hazard);
			} else {
				return (void *)_hazard;
			}
		}

		public inline unowned Node? get_next () {
			return (Node *)AtomicPointer.get (&_next);
		}

		public inline void set_next (Node *next) {
			AtomicPointer.set (&_next, next);
		}

		public Node *_next;
		public int _active;
		public void *_hazard;
	}
}

