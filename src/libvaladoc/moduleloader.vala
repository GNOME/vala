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




public class Valadoc.ModuleLoader : TypeModule {
	public HashMap<string, GLib.Type> taglets = new HashMap<string, Type> (GLib.str_hash, GLib.str_equal);

	private Module drivermodule;
	private Type drivertype;
	public Driver driver;

	private Module docletmodule;
	private Type doclettype;
	public Doclet doclet;

	public ModuleLoader () {
		Object ();
	}

	public override bool load () {
		return true;
	}

	public override void unload() {
	}

	public Content.Taglet? create_taglet (string keyword) {
		return (taglets.has_key (keyword))? (Content.Taglet) GLib.Object.new (taglets.get (keyword)) : null;
	}

	public bool load_doclet (string path) {
		void* function;

		docletmodule = Module.open (Module.build_path (path, "libdoclet"), ModuleFlags.BIND_LAZY | ModuleFlags.BIND_LOCAL);
		if (docletmodule == null) {
			return false;
		}

		docletmodule.symbol("register_plugin", out function);
		if (function == null) {
			return false;
		}

		Valadoc.DocletRegisterFunction doclet_register_function = (Valadoc.DocletRegisterFunction) function;
		doclettype = doclet_register_function (this);
		this.doclet = (Doclet) GLib.Object.new (doclettype);
		return true;
	}


	public bool load_driver (string path) {
		void* function;

		drivermodule = Module.open (Module.build_path (path, "libdriver"), ModuleFlags.BIND_LAZY | ModuleFlags.BIND_LOCAL);
		if (drivermodule == null) {
			return false;
		}

		drivermodule.symbol("register_plugin", out function);
		if (function == null) {
			return false;
		}

		Valadoc.DriverRegisterFunction driver_register_function = (Valadoc.DriverRegisterFunction) function;
		drivertype = driver_register_function (this);
		this.driver = (Driver) GLib.Object.new (drivertype);
		return true;
	}
}

