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

[CCode (has_target = false)]
public delegate void Valadoc.TagletRegisterFunction (ModuleLoader loader);

public class Valadoc.ModuleLoader : Object {
	private Vala.HashMap<string, ModuleData> doclets = new Vala.HashMap<string, ModuleData> (str_hash, str_equal);
	private Vala.HashMap<string, GLib.Type> taglets = new Vala.HashMap<string, GLib.Type> (str_hash, str_equal);

	private static ModuleLoader instance;

	public static ModuleLoader get_instance () {
		if (instance == null) {
			instance = new ModuleLoader ();
			Taglets.init (instance);
		}
		return instance;
	}

	private ModuleLoader () {
	}

	private class ModuleData : Object {
		public Module module;
		public Type type;
	}


	//
	// path helpers:
	//

	public static bool is_doclet (string path) {
		string library_path = Path.build_filename (path, "libdoclet." + Module.SUFFIX);
		return FileUtils.test (path, FileTest.EXISTS) && FileUtils.test (library_path, FileTest.EXISTS);
	}

	private static string get_plugin_path (string pluginpath, string pluginsubdir) {
		if (Path.is_absolute (pluginpath) == false) {
			// Test to see if the plugin exists in the expanded path and then fallback
			// to using the configured plugin directory
			string local_path = Path.build_filename (Environment.get_current_dir(), pluginpath);
			if (is_doclet(local_path)) {
				return local_path;
			} else {
				return Path.build_filename (Config.PACKAGE_VALADOC_LIBDIR, pluginsubdir, pluginpath);
			}
		}

		return pluginpath;
	}

	public static string get_doclet_path (string? docletpath, ErrorReporter reporter) {
		if (docletpath == null) {
			return Path.build_filename (Config.PACKAGE_VALADOC_LIBDIR, "doclets", "html");
		}

		return get_plugin_path (docletpath, "doclets");
	}

	//
	// Creation methods:
	//

	public Content.Taglet? create_taglet (string keyword) {
		return (taglets.contains (keyword))? (Content.Taglet) GLib.Object.new (taglets.get (keyword)) : null;
	}

	public void register_taglet (string keyword, Type type) {
		taglets.set (keyword, type);
	}

	public Doclet? create_doclet (string _path) {
		string path = Vala.CodeContext.realpath (_path);

		ModuleData? data = doclets.get (path);
		if (data == null) {
			void* function;

			Module? module = Module.open (Module.build_path (path, "libdoclet"), ModuleFlags.LAZY | ModuleFlags.LOCAL);
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
}

