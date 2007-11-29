/* valaccodemethodbinding.vala
 *
 * Copyright (C) 2007  Jürg Billeter
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
using Gee;

/**
 * The link between a method and generated code.
 */
public class Vala.CCodeMethodBinding : CCodeBinding {
	public Method! method { get; set; }

	public bool has_wrapper {
		get { return (method.get_attribute ("NoWrapper") == null); }
	}

	public CCodeMethodBinding (construct CodeGenerator! codegen, construct Method! method) {
	}

	public static CCodeMethodBinding! get (Method! method) {
		return (CCodeMethodBinding) method.code_binding;
	}

	public override void emit () {
	}
}
