/* valaobjecttypesymbol.vala
 *
 * Copyright (C) 2008  Philip Van Hoof
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
 * 	Philip Van Hoof <pvanhoof@gnome.org>
 */

using GLib;
using Gee;

/**
 * Represents a runtime data type for objects and interfaces. This data type may
 * be defined in Vala source code or imported from an external library with a 
 * Vala API file.
 */
public abstract class Vala.ObjectTypesymbol : Typesymbol {
	public abstract Collection<Method> get_methods ();
	public abstract Collection<Signal> get_signals ();
	public abstract Collection<Property> get_properties ();
}
