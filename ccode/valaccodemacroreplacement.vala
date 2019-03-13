/* valaccodemacroreplacement.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Represents a preprocessor macro replacement definition in the C code.
 */
public class Vala.CCodeMacroReplacement : CCodeDefine {
	public CCodeMacroReplacement (string name, string replacement) {
		base (name, replacement);
	}

	public CCodeMacroReplacement.with_expression (string name, CCodeExpression replacement_expression) {
		base.with_expression (name, replacement_expression);
	}
}
