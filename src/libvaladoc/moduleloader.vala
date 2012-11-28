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
	// driver path helpers:
	//

	private struct DriverMetaData {
		public int64[] segments_min;
		public int64[] segments_max;
		public string driver_name;

		public DriverMetaData (int64 min_a, int64 min_b, int64 max_a, int64 max_b, string driver_name) {
			this.segments_min = {min_a, min_b};
			this.segments_max = {max_a, max_b};
			this.driver_name = driver_name;
		}
	}

	public static bool is_driver (string path) {
		string library_path = Path.build_filename (path, "libdriver." + Module.SUFFIX);
		return FileUtils.test (path, FileTest.EXISTS) && FileUtils.test (library_path, FileTest.EXISTS);
	}

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
				return Path.build_filename (Config.plugin_dir, pluginsubdir, pluginpath);
			}
		}

		return pluginpath;
	}

	public static string get_doclet_path (string? docletpath, ErrorReporter reporter) {
		if (docletpath == null) {
			return Path.build_filename (Config.plugin_dir, "doclets", "html");
		}

		return get_plugin_path (docletpath, "doclets");
	}

	public static string? get_driver_path (string? _driverpath, ErrorReporter reporter) {
		string? driverpath = _driverpath;
		// no driver selected
		if (driverpath == null) {
			driverpath = Config.default_driver;
		}


		// selected string is a plugin directory
		string extended_driver_path = get_plugin_path (driverpath, "drivers");
		if (is_driver (extended_driver_path)) {
			return extended_driver_path;
		}


		// selected string is a `valac --version` number:
		if (driverpath.has_prefix ("Vala ")) {
			if (driverpath.has_suffix ("-dirty")) {
				driverpath = driverpath.substring (5, driverpath.length - 6 - 5);
			} else {
				driverpath = driverpath.substring (5);
			}
		}

		string[] segments = driverpath.split (".");
		if (segments.length != 3 && segments.length != 4) {
			reporter.simple_error ("error: Invalid driver version format.");
			return null;
		}


		int64 segment_a;
		int64 segment_b;
		int64 segment_c;
		bool tmp;

		tmp  = int64.try_parse (segments[0], out segment_a);
		tmp &= int64.try_parse (segments[1], out segment_b);
		tmp &= int64.try_parse (segments[2], out segment_c);

		if (!tmp) {
			reporter.simple_error ("error: Invalid driver version format.");
			return null;
		}

		DriverMetaData[] lut = {
				DriverMetaData (0, 10,  0, 10,  "0.10.x"),
				DriverMetaData (0, 11,  0, 12,  "0.12.x"),
				DriverMetaData (0, 13,  0, 14,  "0.14.x"),
				DriverMetaData (0, 15,  0, 16,  "0.16.x"),
				DriverMetaData (0, 17,  0, 18,  "0.18.x"),
				DriverMetaData (0, 19,  0, 20,  "0.20.x")
			};


		for (int i = 0; i < lut.length ; i++) {
			bool frst_seg = lut[i].segments_min[0] <= segment_a && lut[i].segments_max[0] >= segment_a;
			bool scnd_seg = lut[i].segments_min[1] <= segment_b && lut[i].segments_max[1] >= segment_b;
			if (frst_seg && scnd_seg) {
				return Path.build_filename (Config.plugin_dir, "drivers", lut[i].driver_name);
			}
		}


		reporter.simple_error ("error: No suitable driver found.");
		return null;
	}

	//
	// Creation methods:
	//

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

