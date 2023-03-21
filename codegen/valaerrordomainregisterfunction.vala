/* valaerrordomainregisterfunction.vala
 *
 * Copyright (C) 2018  Rico Tzschichholz
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
 * C function to register an error domain at runtime.
 */
public class Vala.ErrorDomainRegisterFunction : TypeRegisterFunction {
	/**
	 * Specifies the error domain to be registered.
	 */
	public weak ErrorDomain error_domain_reference {
		get {
			return (ErrorDomain) type_symbol;
		}
	}

	/**
	 * Creates a new C function to register the specified error domain at runtime.
	 *
	 * @param edomain an error domain
	 * @return        newly created error domain register function
	 */
	public ErrorDomainRegisterFunction (ErrorDomain edomain) {
		base (edomain);
	}
}
