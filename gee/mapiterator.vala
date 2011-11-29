/* mapiterator.vala
 *
 * Copyright (C) 2011  Florian Brosch
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
 * 	Florian Brosch <flo.brosch@gmail.com>
 */



/**
 * An iterator over a map.
 */
public abstract class Vala.MapIterator<K,V> {
	/**
	 * Advances to the next element in the iteration.
	 *
	 * @return true if the iterator has a next element
	 */
	public abstract bool next ();

	/**
	 * Returns the current key in the iteration.
	 *
	 * @return the current key in the iteration
	 */
	public abstract K get_key ();

	/**
	 * Returns the current value in the iteration.
	 *
	 * @return the current value in the iteration
	 */
	public abstract V get_value ();
}



