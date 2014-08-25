/* bidiriterator.vala
 *
 * Copyright (C) 2009  Didier Villevalois, Maciej Piechotka
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
 * A bi-directional Map iterator.
 */
[GenericAccessors]
public interface Vala.BidirMapIterator<K,V> : Vala.MapIterator<K,V> {
	/**
	 * Rewinds to the previous element in the iteration.
	 *
	 * @return `true` if the iterator has a previous element
	 */
	public abstract bool previous ();

	/**
	 * Checks whether there is a previous element in the iteration.
	 *
	 * @return `true` if the iterator has a previous element
	 */
	public abstract bool has_previous ();

	/**
	 * Goes back to the first element.
	 *
	 * @return `true` if the iterator has a first element
	 */
	public abstract bool first ();

	/**
	 * Advances to the last element in the iteration.
	 *
	 * @return `true` if the iterator has a last element
	 */
	public abstract bool last ();
}
