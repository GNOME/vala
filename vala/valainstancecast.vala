/* valainstancecast.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 * Represents a runtime checked object instance cast expression in the C code.
 */
public class Vala.InstanceCast : CCodeFunctionCall {
	/**
	 * The target type.
	 */
	public weak TypeSymbol type_reference { get; set; }
	
	/**
	 * The expression to be cast.
	 */
	public CCodeExpression inner { get; set; }
	
	/**
	 * Creates a new instance cast expression.
	 *
	 * @param expr an expression
	 * @param type the target type
	 * @return     newly created instance cast expression
	 */
	public InstanceCast (CCodeExpression expr, TypeSymbol type) {
		inner = expr;
		type_reference = type;

		call = new CCodeIdentifier (type_reference.get_upper_case_cname (null));
		add_argument ((CCodeExpression) inner);
	}
}



