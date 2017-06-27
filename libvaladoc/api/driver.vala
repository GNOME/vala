/* driver.vala
 *
 * Copyright (C) 2011  Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc.Api;

/**
 * A plugin register function for drivers
 *
 * @see ModuleLoader
 */
[CCode (has_target = false)]
public delegate Type Valadoc.DriverRegisterFunction (ModuleLoader module_loader);



public interface Valadoc.Driver : Object {
	public abstract void write_gir (Settings settings, ErrorReporter reporter);

	public abstract Api.Tree? build (Settings settings, ErrorReporter reporter);
}


