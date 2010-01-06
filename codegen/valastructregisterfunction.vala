/* valastructregisterfunction.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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
 * C function to register a class at runtime.
 */
public class Vala.StructRegisterFunction : TypeRegisterFunction {
	/**
	 * Specifies the struct to be registered.
	 */
	public weak Struct struct_reference { get; set; }

	/**
	 * Creates a new C function to register the specified class at runtime.
	 *
	 * @param cl a class
	 * @return   newly created class register function
	 */
	public StructRegisterFunction (Struct st, CodeContext context) {
		struct_reference = st;
		this.context = context;
	}
	
	public override TypeSymbol get_type_declaration () {
		return struct_reference;
	}

	public override SymbolAccessibility get_accessibility () {
		return struct_reference.access;
	}

	public override CCodeFragment get_type_interface_init_statements (bool plugin) {
		return new CCodeFragment ();
	}
}
