/* valacallableexpression.vala
 *
 * Copyright (C) 2021  Rico Tzschichholz
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
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */

using GLib;

/**
 * Interface for all callable expressions.
 */
public interface Vala.CallableExpression : Expression {
	/**
	 * Whether it is a stateful async invocation.
	 */
	public abstract bool is_yield_expression { get; set; }

	/**
	 * Whether it is a creation chain up.
	 */
	public abstract bool is_chainup { get; set; }

	/**
	 * The expression to call.
	 */
	public abstract Expression call { get; }

	/**
	 * Appends the specified expression to the list of arguments.
	 *
	 * @param arg an argument
	 */
	public abstract void add_argument (Expression arg);

	/**
	 * Returns the argument list.
	 *
	 * @return argument list
	 */
	public abstract unowned List<Expression> get_argument_list ();
}
