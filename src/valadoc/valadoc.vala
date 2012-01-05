/* valadoc.vala
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
 * 	Florian Brosch <flo.brosch@gmail.com>
 */

using GLib.Path;
using Valadoc.Importer;
using Valadoc;
using Config;
using Gee;



public class ValaDoc : Object {
	private static string wikidirectory = null;
	private static string pkg_version = null;
	private static string docletpath = null;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] pluginargs;
	private static string gir_directory = null;
	private static string directory = null;
	private static string pkg_name = null;
	private static string gir_name = null;
	private static string gir_namespace = null;
	private static string gir_version = null;
	private static string driverpath = null;

	private static bool add_inherited = false;
	private static bool _protected = true;
	private static bool _internal = false;
	private static bool with_deps = false;
	private static bool _private = false;
	private static bool version = false;

	private static bool verbose = false;
	private static bool force = false;

	private static string basedir = null;
	private static string[] defines;
	private static bool experimental;
	private static bool experimental_non_null = false;
	private static string profile;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] import_packages;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] import_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] vapi_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] metadata_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] gir_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] tsources;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] packages;

	private const GLib.OptionEntry[] options = {
		{ "directory", 'o', 0, OptionArg.FILENAME, ref directory, "Output directory", "DIRECTORY" },

		{ "basedir", 'b', 0, OptionArg.FILENAME, ref basedir, "Base source directory", "DIRECTORY" },
		{ "define", 'D', 0, OptionArg.STRING_ARRAY, ref defines, "Define SYMBOL", "SYMBOL..." },
		{ "profile", 0, 0, OptionArg.STRING, ref profile, "Use the given profile instead of the default", "PROFILE" },

		{ "enable-experimental", 0, 0, OptionArg.NONE, ref experimental, "Enable experimental features", null },
		{ "enable-experimental-non-null", 0, 0, OptionArg.NONE, ref experimental_non_null, "Enable experimental enhancements for non-null types", null },

		{ "metadatadir", 0, 0, OptionArg.FILENAME_ARRAY, ref metadata_directories, "Look for GIR .metadata files in DIRECTORY", "DIRECTORY..." },
		{ "girdir", 0, 0, OptionArg.FILENAME_ARRAY, ref gir_directories, "Look for .gir files in DIRECTORY", "DIRECTORY..." },
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, ref vapi_directories, "Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, ref packages, "Include binding for PACKAGE", "PACKAGE..." },

		{ "driver", 0, 0, OptionArg.STRING, ref driverpath, "Name of an driver or path to a custom driver", null },

		{ "importdir", 0, 0, OptionArg.FILENAME_ARRAY, ref import_directories, "Look for external documentation in DIRECTORY", "DIRECTORY..." },
		{ "import", 0, 0, OptionArg.STRING_ARRAY, ref import_packages, "Include binding for PACKAGE", "PACKAGE..." },

		{ "wiki", 0, 0, OptionArg.FILENAME, ref wikidirectory, "Wiki directory", "DIRECTORY" },

		{ "deps", 0, 0, OptionArg.NONE, ref with_deps, "Adds packages to the documentation", null },

		{ "doclet", 0, 0, OptionArg.STRING, ref docletpath, "Name of an included doclet or path to custom doclet", "PLUGIN"},
		{ "doclet-arg", 'X', 0, OptionArg.STRING_ARRAY, ref pluginargs, "Pass arguments to the doclet", "ARG" },

		{ "no-protected", 0, OptionFlags.REVERSE, OptionArg.NONE, ref _protected, "Removes protected elements from documentation", null },
		{ "internal", 0, 0, OptionArg.NONE, ref _internal, "Adds internal elements to documentation", null },
		{ "private", 0, 0, OptionArg.NONE, ref _private, "Adds private elements to documentation", null },

		{ "package-name", 0, 0, OptionArg.STRING, ref pkg_name, "package name", "NAME" },
		{ "package-version", 0, 0, OptionArg.STRING, ref pkg_version, "package version", "VERSION" },
		{ "gir", 0, 0, OptionArg.STRING, ref gir_name, "GObject-Introspection repository file name", "NAME-VERSION.gir" },

		{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },

		{ "force", 0, 0, OptionArg.NONE, ref force, "force", null },
		{ "verbose", 0, 0, OptionArg.NONE, ref verbose, "Show all warnings", null },
		{ "", 0, 0, OptionArg.FILENAME_ARRAY, ref tsources, null, "FILE..." },

		{ null }
	};

	private struct LibvalaVersion {
		public int segment_a;
		public int segment_b;
		public int segment_c;

		public LibvalaVersion (int seg_a, int seg_b, int seg_c) {
			segment_a = seg_a;
			segment_b = seg_b;
			segment_c = seg_c;
		}
	}

	private struct DriverMetaData {
		public LibvalaVersion min;
		public LibvalaVersion max;
		public string driver;

		public DriverMetaData (LibvalaVersion min, LibvalaVersion max, string driver) {
			this.driver = driver;
			this.min = min;
			this.max = max;
		}
	}

	private static int quit (ErrorReporter reporter) {
		if (reporter.errors == 0) {
			stdout.printf ("Succeeded - %d warning(s)\n", reporter.warnings);
			return 0;
		} else {
			stdout.printf ("Failed: %d error(s), %d warning(s)\n", reporter.errors, reporter.warnings);
			return 1;
		}
	}

	private static bool check_pkg_name () {
		if (pkg_name == null) {
			return true;
		}

		if (pkg_name == "glib-2.0" || pkg_name == "gobject-2.0") {
			return false;
		}

		foreach (string package in tsources) {
			if (pkg_name == package) {
				return false;
			}
		}
		return true;
	}

	private string get_pkg_name () {
		if (this.pkg_name == null) {
			if (this.directory.has_suffix ("/")) {
				this.pkg_name = GLib.Path.get_dirname (this.directory);
			} else {
				this.pkg_name = GLib.Path.get_basename (this.directory);
			}
		}

		return this.pkg_name;
	}

	private string get_plugin_path (string pluginpath, string pluginsubdir) {
		if (is_absolute (pluginpath) == false) {
			// Test to see if the plugin exists in the expanded path and then fallback
			// to using the configured plugin directory
			string local_path = build_filename (Environment.get_current_dir(), pluginpath);
			if (FileUtils.test(local_path, FileTest.EXISTS)) {
				return local_path;
			} else {
				return build_filename (Config.plugin_dir, pluginsubdir, pluginpath);
			}
		}

		return pluginpath;
	}

	private string get_doclet_path (ErrorReporter reporter) {
		if (docletpath == null) {
			return build_filename (Config.plugin_dir, "doclets", "html");
		}

		return get_plugin_path (docletpath, "doclets");
	}

	private bool is_driver (string path) {
		string library_path = Path.build_filename (path, "libdriver." + Module.SUFFIX);
		return FileUtils.test (path, FileTest.EXISTS) && FileUtils.test (library_path, FileTest.EXISTS);
	}

	private string? get_driver_path (ErrorReporter reporter) {
		// no driver selected
		if (driverpath == null) {
			driverpath = Config.default_driver;
		}


		// selected string is a plugin directory
		string extended_driver_path = get_plugin_path (driverpath, "drivers");
		if (is_driver (extended_driver_path)) {
			return extended_driver_path;
		}


		// selected string is a version number:
		if (driverpath.has_prefix ("Vala ")) {
			driverpath = driverpath.substring (5);
		}

		string[] segments = driverpath.split (".");
		if (segments.length != 3 && segments.length != 4) {
			reporter.simple_error ("Invalid driver version format.");
			return null;
		}


		//TODO: add try_parse to int
		int64 segment_a;
		int64 segment_b;
		int64 segment_c;
		bool tmp;

		tmp  = int64.try_parse (segments[0], out segment_a);
		tmp &= int64.try_parse (segments[1], out segment_b);
		tmp &= int64.try_parse (segments[2], out segment_c);

		if (!tmp) {
			reporter.simple_error ("Invalid driver version format.");
			return null;
		}

		DriverMetaData[] lut = {
				DriverMetaData (LibvalaVersion (0, 10, 0), LibvalaVersion (0, 10, -1), "0.10.x"),
				DriverMetaData (LibvalaVersion (0, 12, 0), LibvalaVersion (0, 12, -1), "0.12.x"),
				DriverMetaData (LibvalaVersion (0, 14, 0), LibvalaVersion (0, 14, -1), "0.14.x")
			};

		for (int i = 0; i < lut.length ; i++) {
			if (lut[i].min.segment_a <= segment_a && lut[i].max.segment_a >= segment_a
				&& lut[i].min.segment_b <= segment_b && lut[i].max.segment_b >= segment_b
				&& lut[i].min.segment_c <= segment_c && (lut[i].max.segment_c >= segment_c || lut[i].max.segment_c < 0)) {
				return Path.build_filename (Config.plugin_dir, "drivers", lut[i].driver);
			}
		}

		// return invalid driver path
		reporter.simple_error ("No suitable driver found.");
		return null;
	}

	private ModuleLoader? create_module_loader (ErrorReporter reporter) {
		ModuleLoader modules = new ModuleLoader ();
		Taglets.init (modules);


		// doclet:
		string? pluginpath = get_doclet_path (reporter);
		if (pluginpath == null) {
			return null;
		}

		bool tmp = modules.load_doclet (pluginpath);
		if (tmp == false) {
			reporter.simple_error ("failed to load doclet");
			return null;
		}


		// driver:
		pluginpath = get_driver_path (reporter);
		if (pluginpath == null) {
			return null;
		}

		tmp = modules.load_driver (pluginpath);
		if (tmp == false) {
			reporter.simple_error ("failed to load driver");
			return null;
		}

		assert (modules.driver != null && modules.doclet != null);

		return modules;
	}

	private int run (ErrorReporter reporter) {
		// settings:
		var settings = new Valadoc.Settings ();
		settings.pkg_name = this.get_pkg_name ();
		settings.gir_namespace = this.gir_namespace;
		settings.gir_version = this.gir_version;
		if (this.gir_name != null) {
			settings.gir_name = GLib.Path.get_basename (this.gir_name);
			settings.gir_directory = GLib.Path.get_dirname (this.gir_name);
			if (settings.gir_directory == "") {
				settings.gir_directory = GLib.Path.get_dirname (this.directory);
			}
		}
		settings.pkg_version = this.pkg_version;
		settings.add_inherited = this.add_inherited;
		settings._protected = this._protected;
		settings._internal = this._internal;
		settings.with_deps = this.with_deps;
		settings._private = this._private;
		settings.path = realpath (this.directory);
		settings.verbose = this.verbose;
		settings.wiki_directory = this.wikidirectory;
		settings.pluginargs = this.pluginargs;

		settings.experimental = experimental;
		settings.experimental_non_null = experimental_non_null;
		settings.basedir = basedir;
		settings.directory = directory;
		settings.vapi_directories = vapi_directories;
		settings.metadata_directories = metadata_directories;
		settings.gir_directories = gir_directories;

		settings.source_files = tsources;
		settings.packages = packages;

		settings.profile = profile;
		settings.defines = defines;


		// load plugins:
		ModuleLoader? modules = create_module_loader (reporter);
		if (reporter.errors > 0 || modules == null) {
			return quit (reporter);
		}


		// Create tree:
		Valadoc.Driver driver = modules.driver;
		Valadoc.Api.Tree doctree = driver.build (settings, reporter);

		if (reporter.errors > 0) {
			return quit (reporter);
		}

		// register child symbols:
		Valadoc.Api.ChildSymbolRegistrar registrar = new Valadoc.Api.ChildSymbolRegistrar ();
		doctree.accept (registrar);

		// process documentation
		Valadoc.DocumentationParser docparser = new Valadoc.DocumentationParser (settings, reporter, doctree, modules);
		if (!doctree.create_tree()) {
			return quit (reporter);
		}

		doctree.process_comments (docparser);
		if (reporter.errors > 0) {
			return quit (reporter);
		}

		DocumentationImporter[] importers = {
			new ValadocDocumentationImporter (doctree, docparser, modules, settings, reporter),
			new GirDocumentationImporter (doctree, docparser, modules, settings, reporter)
		};

		doctree.import_documentation (importers, import_packages, import_directories);
		if (reporter.errors > 0) {
			return quit (reporter);
		}

		if (this.gir_name != null) {
			driver.write_gir (settings, reporter);
			if (reporter.errors > 0) {
				return quit (reporter);
			}
		}

		modules.doclet.process (settings, doctree, reporter);
		return quit (reporter);
	}

	static int main (string[] args) {
		ErrorReporter reporter = new ErrorReporter();

		try {
			var opt_context = new OptionContext ("- Vala Documentation Tool");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);
		} catch (OptionError e) {
			reporter.simple_error (e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return quit (reporter);
		}

		if (version) {
			stdout.printf ("Valadoc %s\n", Config.version);
			return 0;
		}

		if (directory == null) {
			reporter.simple_error ("No output directory specified.");
			return quit (reporter);
		}

		if (!check_pkg_name ()) {
			reporter.simple_error ("File already exists");
			return quit (reporter);
		}

		if (FileUtils.test (directory, FileTest.EXISTS)) {
			if (force == true) {
				bool tmp = remove_directory (directory);
				if (tmp == false) {
					reporter.simple_error ("Can't remove directory.");
					return quit (reporter);
				}
			} else {
				reporter.simple_error ("File already exists");
				return quit (reporter);
			}
		}

		if (wikidirectory != null) {
			if (!FileUtils.test(wikidirectory, FileTest.IS_DIR)) {
				reporter.simple_error ("Wiki-directory does not exist.");
				return quit (reporter);
			}
		}

		if (gir_name != null) {
			long gir_len = gir_name.length;
			int last_hyphen = gir_name.last_index_of_char ('-');

			if (last_hyphen == -1 || !gir_name.has_suffix (".gir")) {
				reporter.simple_error ("GIR file name `%s' is not well-formed, expected NAME-VERSION.gir", gir_name);
				return quit (reporter);
			}

			gir_namespace = gir_name.substring (0, last_hyphen);
			gir_version = gir_name.substring (last_hyphen + 1, gir_len - last_hyphen - 5);
			gir_version.canon ("0123456789.", '?');

			if (gir_namespace == "" || gir_version == "" || !gir_version[0].isdigit () || gir_version.contains ("?")) {
				reporter.simple_error ("GIR file name `%s' is not well-formed, expected NAME-VERSION.gir", gir_name);
				return quit (reporter);
			}


			bool report_warning = true;
			foreach (string source in tsources) {
				if (source.has_suffix (".vala") || source.has_suffix (".gs")) {
					report_warning = false;
					break;
				}
			}

			if (report_warning == true) {
				reporter.simple_error ("No source file specified to be compiled to gir.");
				return quit (reporter);
			}
		}

		var valadoc = new ValaDoc( );
		return valadoc.run (reporter);
	}
}


