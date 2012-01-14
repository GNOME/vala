/* moduleloader.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch
 * Copyright (C) 2011      Florian Brosch
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
 * 	Brosch Florian <flo.brosch@gmail.com>
 */

using Gee;


[CCode (has_target = false)]
public delegate void Valadoc.TagletRegisterFunction (ModuleLoader loader);




public class Valadoc.ModuleLoader : Object {
	private HashMap<string, ModuleData> doclets = new HashMap<string, ModuleData> ();
	private HashMap<string, ModuleData> drivers = new HashMap<string, ModuleData> ();
	private HashMap<string, GLib.Type> taglets = new HashMap<string, GLib.Type> ();

	private class ModuleData : Object {
		public Module module;
		public Type type;
	}

	public Content.Taglet? create_taglet (string keyword) {
		return (taglets.has_key (keyword))? (Content.Taglet) GLib.Object.new (taglets.get (keyword)) : null;
	}

	public void register_taglet (string keyword, Type type) {
		taglets.set (keyword, type);
	}

	public Doclet? create_doclet (string _path) {
		string path = realpath (_path);

		ModuleData? data = doclets.get (path);
		if (data == null) {
			void* function;

			Module? module = Module.open (Module.build_path (path, "libdoclet"), ModuleFlags.BIND_LAZY | ModuleFlags.BIND_LOCAL);
			if (module == null) {
				return null;
			}

			module.symbol("register_plugin", out function);
			if (function == null) {
				return null;
			}

			Valadoc.DocletRegisterFunction register_func = (Valadoc.DocletRegisterFunction) function;
			data = new ModuleData ();
			doclets.set (path, data);

			data.type = register_func (this);
			data.module = (owned) module;
		}

		return (Doclet) GLib.Object.new (data.type);
	}

	public Driver? create_driver (string _path) {
		string path = realpath (_path);

		ModuleData? data = drivers.get (path);
		if (data == null) {
			void* function;

			Module? module = Module.open (Module.build_path (path, "libdriver"), ModuleFlags.BIND_LAZY | ModuleFlags.BIND_LOCAL);
			if (module == null) {
				return null;
			}

			module.symbol("register_plugin", out function);
			if (function == null) {
				return null;
			}

			Valadoc.DriverRegisterFunction register_func = (Valadoc.DriverRegisterFunction) function;
			data = new ModuleData ();
			drivers.set (path, data);

			data.type = register_func (this);
			data.module = (owned) module;
		}

		return (Driver) GLib.Object.new (data.type);
	}
}

