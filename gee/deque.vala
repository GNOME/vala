/* deque.vala
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
 * A double-ended queue.
 *
 * A deque can be used either as a queue (First-In-First-Out behavior) or as a
 * stack (Last-In-First-Out behavior).
 *
 * The methods defined by this interface behaves exactely in the same way as
 * the {@link Queue} methods with respect to capacity bounds.
 *
 * The Deque interface inherits from the {@link Queue} interface. Thus, to use
 * a deque as a queue, you can equivalently use the folowing method set:
 *
 * ||<)(> ''Queue method'' ||<)(>  ''Deque method'' ||
 * || {@link Queue.offer}  || {@link offer_tail}    ||
 * || {@link Queue.peek}   || {@link peek_head}     ||
 * || {@link Queue.poll}   || {@link poll_head}     ||
 * || {@link Queue.drain}  || {@link drain_head}    ||
 *
 * To use a deque as a stack, just use the method set that acts at the head of
 * the deque:
 *
 * ||<)(> ''Operation'' ||<)(>  ''Deque method'' ||
 * || push an element   || {@link offer_head}    ||
 * || peek an element   || {@link peek_head}     ||
 * || pop an element    || {@link poll_head}     ||
 */
[GenericAccessors]
public interface Vala.Deque<G> : Queue<G> {
	/**
	 * Offers the specified element to the head of this deque.
	 *
	 * @param element the element to offer to the queue
	 *
	 * @return        ``true`` if the element was added to the queue
	 */
	public abstract bool offer_head (G element);

	/**
	 * Peeks (retrieves, but not remove) an element from this queue.
	 *
	 * @return the element peeked from the queue (or ``null`` if none was
	 *         available)
	 */
	public abstract G? peek_head ();

	/**
	 * Polls (retrieves and remove) an element from the head of this queue.
	 *
	 * @return the element polled from the queue (or ``null`` if none was
	 *         available)
	 */
	public abstract G? poll_head ();

	/**
	 * Drains the specified amount of elements from the head of this queue in
	 * the specified recipient collection.
	 *
	 * @param recipient the recipient collection to drain the elements to
	 * @param amount    the amount of elements to drain
	 *
	 * @return          the amount of elements that were actually drained
	 */
	public abstract int drain_head (Collection<G> recipient, int amount = -1);

	/**
	 * Offers the specified element to the tail of this deque
	 *
	 * @param element the element to offer to the queue
	 *
	 * @return        ``true`` if the element was added to the queue
	 */
	public abstract bool offer_tail (G element);

	/**
	 * Peeks (retrieves, but not remove) an element from the tail of this
	 * queue.
	 *
	 * @return the element peeked from the queue (or ``null`` if none was
	 *         available)
	 */
	public abstract G? peek_tail ();

	/**
	 * Polls (retrieves and remove) an element from the tail of this queue.
	 *
	 * @return the element polled from the queue (or ``null`` if none was
	 *         available)
	 */
	public abstract G? poll_tail ();

	/**
	 * Drains the specified amount of elements from the tail of this queue in
	 * the specified recipient collection.
	 *
	 * @param recipient the recipient collection to drain the elements to
	 * @param amount    the amount of elements to drain
	 *
	 * @return          the amount of elements that were actually drained
	 */
	public abstract int drain_tail (Collection<G> recipient, int amount = -1);
}
