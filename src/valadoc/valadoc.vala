/* valadoc.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch
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
using Valadoc;
using Config;
using Gee;



public class ValaDoc : Object {
	private static string wikidirectory = null;
	private static string pkg_version = null;
	private static string pluginpath = null;
	private static string directory = null;
	private static string pkg_name = null;

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
	private static bool enable_checking;
	private static bool deprecated;
	private static bool experimental;
	private static bool experimental_non_null = false;
	private static bool disable_dbus_transformation;
	private static string profile;

	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] docu_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] vapi_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] tsources;
	[CCode (array_length = false, array_null_terminated = true)]
	private static string[] packages;

	private const GLib.OptionEntry[] options = {
		{ "basedir", 'b', 0, OptionArg.FILENAME, ref basedir, "Base source directory", "DIRECTORY" },
		{ "define", 'D', 0, OptionArg.STRING_ARRAY, ref defines, "Define SYMBOL", "SYMBOL..." },
		{ "enable-checking", 0, 0, OptionArg.NONE, ref enable_checking, "Enable additional run-time checks", null },
		{ "enable-deprecated", 0, 0, OptionArg.NONE, ref deprecated, "Enable deprecated features", null },
		{ "enable-experimental", 0, 0, OptionArg.NONE, ref experimental, "Enable experimental features", null },
		{ "enable-experimental-non-null", 0, 0, OptionArg.NONE, ref experimental_non_null, "Enable experimental enhancements for non-null types", null },
		{ "disable-dbus-transformation", 0, 0, OptionArg.NONE, ref disable_dbus_transformation, "Disable transformation of D-Bus member names", null },
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, ref vapi_directories, "Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "docudir", 0, 0, OptionArg.FILENAME_ARRAY, ref docu_directories, "Look for external documentation in DIRECTORY", "DIRECTORY..." },
		{ "profile", 0, 0, OptionArg.STRING, ref profile, "Use the given profile instead of the default", "PROFILE" },


		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, ref packages, "Include binding for PACKAGE", "PACKAGE..." },
		{ "directory", 'o', 0, OptionArg.FILENAME, ref directory, "Output directory", "DIRECTORY" },

		{ "wiki", 0, 0, OptionArg.FILENAME, ref wikidirectory, "Wiki directory", "DIRECTORY" },
		{ "deps", 0, 0, OptionArg.NONE, ref with_deps, "Adds packages to the documentation", null },
		{ "doclet", 0, 0, OptionArg.STRING, ref pluginpath, "plugin", "Name of an included doclet or path to custom doclet" },

		{ "no-protected", 0, OptionFlags.REVERSE, OptionArg.NONE, ref _protected, "Removes protected elements from documentation", null },
		{ "internal", 0, 0, OptionArg.NONE, ref _internal, "Adds internal elements to documentation", null },
		{ "private", 0, 0, OptionArg.NONE, ref _private, "Adds private elements to documentation", null },
//		{ "inherit", 0, 0, OptionArg.NONE, ref add_inherited, "Adds inherited elements to a class", null },
		{ "package-name", 0, 0, OptionArg.STRING, ref pkg_name, "package name", "DIRECTORY" },
		{ "package-version", 0, 0, OptionArg.STRING, ref pkg_version, "package version", "DIRECTORY" },
		{ "force", 0, 0, OptionArg.NONE, ref force, "force", null },
		{ "verbose", 0, 0, OptionArg.NONE, ref verbose, "Show all warnings", null },
		{ "", 0, 0, OptionArg.FILENAME_ARRAY, ref tsources, null, "FILE..." },
		{ null }
	};

	private static int quit (ErrorReporter reporter) {
		if ( reporter.errors == 0) {
			stdout.printf ("Succeeded - %d warning(s)\n", reporter.warnings);
			return 0;
		}
		else {
			stdout.printf ("Failed: %d error(s), %d warning(s)\n", reporter.errors, reporter.warnings);
			return 1;
		}
	}

	private static bool check_pkg_name () {
		if (pkg_name == null)
			return true;

		if (pkg_name == "glib-2.0" || pkg_name == "gobject-2.0")
			return false;

		foreach (string package in tsources) {
			if (pkg_name == package)
				return false;
		}
		return true;
	}

	private string get_pkg_name () {
		if (this.pkg_name == null) {
			if (this.directory.has_suffix ("/"))
				this.pkg_name = GLib.Path.get_dirname (this.directory);
			else
				this.pkg_name = GLib.Path.get_basename (this.directory);
		}

		return this.pkg_name;
	}


	private int run (ErrorReporter reporter) {
		var settings = new Valadoc.Settings ();
		settings.pkg_name = this.get_pkg_name ();
		settings.pkg_version = this.pkg_version;
		settings.add_inherited = this.add_inherited;
		settings._protected = this._protected;
		settings._internal = this._internal;
		settings.with_deps = this.with_deps;
		settings._private = this._private;
		settings.path = realpath (this.directory);
		settings.verbose = this.verbose;
		settings.wiki_directory = this.wikidirectory;

		settings.enable_checking = enable_checking;
		settings.deprecated = deprecated;
		settings.experimental = experimental;
		settings.experimental_non_null = experimental_non_null;
		settings.disable_dbus_transformation = disable_dbus_transformation;
		settings.basedir = basedir;
		settings.directory = directory;
		settings.vapi_directories = vapi_directories;
		settings.docu_directories = docu_directories;

		settings.profile = profile;
		settings.defines = defines;

		string fulldirpath = "";
		if (pluginpath == null) {
			fulldirpath = build_filename (Config.plugin_dir, "html");
		}
		else if ( is_absolute (pluginpath ) == false) {
			// Test to see if the plugin exists in the expanded path and then fallback
			// to using the configured plugin directory
			string local_path = build_filename (Environment.get_current_dir(), pluginpath);
			if ( FileUtils.test(local_path, FileTest.EXISTS)) {
				fulldirpath = local_path;
			}
			else {
				fulldirpath = build_filename (Config.plugin_dir, pluginpath);
			}
		}
		else {
			fulldirpath = pluginpath;
		}


		ModuleLoader modules = new ModuleLoader ();
		Taglets.init (modules);
		bool tmp = modules.load (fulldirpath);
		if (tmp == false) {
			reporter.simple_error ("failed to load plugin");
			return quit (reporter);
		}


		Valadoc.Api.Tree doctree = new Valadoc.Api.Tree (reporter, settings);
		Valadoc.DocumentationParser docparser = new Valadoc.DocumentationParser (settings, reporter, doctree, modules);
		Valadoc.DocumentationImporter importer = new Valadoc.Xml.DocumentationImporter (doctree, modules, settings, reporter);

		doctree.add_depencies (packages);
		if (reporter.errors > 0) {
			return quit (reporter);
		}

		doctree.add_documented_file (tsources);
		if (reporter.errors > 0) {
			return quit (reporter);
		}

		if (!doctree.create_tree()) {
			return quit (reporter);
		}

		doctree.parse_comments (docparser);
		if (reporter.errors > 0) {
			return quit (reporter);
		}

		doctree.import_documentation (importer);
		if (reporter.errors > 0) {
			return quit (reporter);
		}

		modules.doclet.process (settings, doctree);
		return quit (reporter);
	}

	private static bool remove_directory (string rpath) {
		try {
			GLib.Dir dir = GLib.Dir.open ( rpath );
			if (dir == null)
				return false;

			for (weak string entry = dir.read_name(); entry != null ; entry = dir.read_name()) {
				string path = rpath + entry;

				bool is_dir = GLib.FileUtils.test (path, GLib.FileTest.IS_DIR);
				if (is_dir == true) {
					bool tmp = remove_directory (path);
					if (tmp == false) {
						return false;
					}
				}
				else {
					int tmp = GLib.FileUtils.unlink (path);
					if (tmp > 0) {
						return false;
					}
				}
			}
		}
		catch (GLib.FileError err) {
			return false;
		}

		return true;
	}

	static int main (string[] args) {
		ErrorReporter reporter = new ErrorReporter();

		try {
			var opt_context = new OptionContext ("- Vala Documentation Tool");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);
		}
		catch (OptionError e) {
			reporter.simple_error (e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return quit (reporter);
		}

		if (version) {
			stdout.printf ("Valadoc %s\n", "0.1");
			return quit (reporter);
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
			}
			else {
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

		var valadoc = new ValaDoc( );
		return valadoc.run (reporter);
	}
}


