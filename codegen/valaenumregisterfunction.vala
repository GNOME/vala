/* valaenumregisterfunction.vala
 *
 * Copyright (C) 2008  Jürg Billeter
 * Copyright (C) 2010  Marc-Andre Lureau
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
 * C function to register an enum at runtime.
 */
public class Vala.EnumRegisterFunction : TypeRegisterFunction {
	/**
	 * Specifies the enum to be registered.
	 */
	public weak Enum enum_reference { get; set; }

	/**
	 * Creates a new C function to register the specified enum at runtime.
	 *
	 * @param en an enum
	 * @return   newly created enum register function
	 */
	public EnumRegisterFunction (Enum en, CodeContext context) {
		enum_reference = en;
		this.context = context;
	}

	public override TypeSymbol get_type_declaration () {
		return enum_reference;
	}

	public override SymbolAccessibility get_accessibility () {
		return enum_reference.access;
	}
}
