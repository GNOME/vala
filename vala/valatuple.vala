/* valatuple.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Represents a fixed-length sequence of expressions in the source code.
 */
public class Vala.Tuple : Expression {
	private List<Expression> expression_list = new ArrayList<Expression> ();

	public Tuple () {
	}

	public void add_expression (Expression expr) {
		expression_list.add (expr);
	}

	public List<Expression> get_expressions () {
		return expression_list;
	}

	public override bool is_pure () {
		return false;
	}
}

