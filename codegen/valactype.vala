/* valactype.vala
 *
 * Copyright (C) 2009  Mark Lee
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
 *	Mark Lee <marklee@src.gnome.org>
 */

/**
 * A C type, used only for code generation purposes.
 */
public class Vala.CType : DataType {
	/**
	 * The name of the C type.
	 */
	public string ctype_name { get; set; }

	/**
	 * The default value of the C type.
	 */
	public string cdefault_value { get; set; }

	public CType (string ctype_name, string cdefault_value) {
		this.ctype_name = ctype_name;
		this.cdefault_value = cdefault_value;
	}

	public override DataType copy () {
		return new CType (ctype_name, cdefault_value);
	}
}
