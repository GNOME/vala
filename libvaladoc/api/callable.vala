/* callable.vala
 *
 * Copyright (C) 2012  Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc;

/**
 * Used to translate imported C-documentation
 */
public interface Valadoc.Api.Callable : Symbol {
	/**
	 * The return type of this symbol.
	 */
	public abstract TypeReference? return_type {
		set;
		get;
	}

	/**
	 * Used to avoid warnings for implicit parameters
	 */
	internal abstract string? implicit_array_length_cparameter_name {
		get;
		set;
	}
}

