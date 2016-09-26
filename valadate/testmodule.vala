/*
 * Valadate - Unit testing library for GObject-based libraries.
 * Copyright (C) 2016  Chris Daley <chebizarro@gmail.com>
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
 * Authors:
 * 	Chris Daley <chebizarro@gmail.com>
 */

public errordomain Valadate.TestModuleError {
	NOT_FOUND,
	LOAD,
	METHOD
}

/**
 * Represents a loadable module containing {@link Valadate.Test}s
 */
public class Valadate.TestModule : Object {

	private string lib_path;
	private GLib.Module module;

	public TestModule (string libpath) {
		lib_path = libpath;
	}

	public void load_module () throws TestModuleError {
		if (!File.new_for_path (lib_path).query_exists ())
			throw new TestModuleError.NOT_FOUND ("Module: %s does not exist", lib_path);
		
		module = GLib.Module.open (lib_path, ModuleFlags.BIND_LOCAL);
		if (module == null)
			throw new TestModuleError.LOAD (GLib.Module.error ());
		module.make_resident ();
	}

	internal void* get_method (string method_name) throws TestModuleError {
		void* function;
		if (module.symbol (method_name, out function))
			if (function != null)
				return function;
		throw new TestModuleError.METHOD (GLib.Module.error ());
	}
}
