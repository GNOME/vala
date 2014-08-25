/* queue.vala
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
 * A collection designed for holding elements prior to processing.
 *
 * Although all Queue implementations do not limit the amount of elements they
 * can contain, this interface supports for capacity-bounded queues. When
 * capacity is not bound, then the {@link capacity} and
 * {@link remaining_capacity} both return {@link UNBOUNDED_CAPACITY}.
 *
 * This interface defines methods that will never fail whatever the state of
 * the queue is. For capacity-bounded queues, those methods will either return
 * ``false`` or ``null`` to specify that the insert or retrieval did not occur
 * because the queue was full or empty.
 *
 * Queue implementations are not limited to First-In-First-Out behavior and can
 * propose different ordering of their elements. Each Queue implementation have
 * to specify how it orders its elements.
 *
 * Queue implementations do not allow insertion of ``null`` elements, although
 * some implementations, such as {@link LinkedList}, do not prohibit insertion
 * of ``null``. Even in the implementations that permit it, ``null`` should not be
 * inserted into a Queue, as ``null`` is also used as a special return value by
 * the poll method to indicate that the queue contains no elements.
 */
[GenericAccessors]
public interface Vala.Queue<G> : Collection<G> {

	/**
	 * The unbounded capacity value.
	 */
	public const int UNBOUNDED_CAPACITY = -1;

	/**
	 * The capacity of this queue (or ``null`` if capacity is not bound).
	 */
	public abstract int capacity { get; }

	/**
	 * The remaining capacity of this queue (or ``null`` if capacity is not
	 * bound).
	 */
	public abstract int remaining_capacity { get; }

	/**
	 * Specifies whether this queue is full.
	 */
	public abstract bool is_full { get; }

	/**
	 * Offers the specified element to this queue.
	 *
	 * @param element the element to offer to the queue
	 *
	 * @return        ``true`` if the element was added to the queue
	 */
	public virtual bool offer (G element) {
		return add (element);
	}

	/**
	 * Peeks (retrieves, but not remove) an element from this queue.
	 *
	 * @return the element peeked from the queue (or ``null`` if none was
	 *         available)
	 */
	public abstract G? peek ();

	/**
	 * Polls (retrieves and remove) an element from this queue.
	 *
	 * @return the element polled from the queue (or ``null`` if none was
	 *         available)
	 */
	public abstract G? poll ();

	/**
	 * Drains the specified amount of elements from this queue in the specified
	 * recipient collection.
	 *
	 * @param recipient the recipient collection to drain the elements to
	 * @param amount    the amount of elements to drain
	 *
	 * @return          the amount of elements that were actually drained
	 */
	public virtual int drain (Collection<G> recipient, int amount = -1) {
		G? item = null;
		int drained = 0;
		while((amount == -1 || --amount >= 0) && (item = poll ()) != null) {
			recipient.add (item);
			drained++;
		}
		return drained;
	}
}
