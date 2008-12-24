/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

using Valadoc;
using Config;
using GLib;
using Vala;
using Gee;







public class ValaDoc : Object {
	private static string basedir = null;
	private static string directory = null;
	private static string pkg_name = null;
	private static string pkg_version = null;

	private static bool add_inherited = false;
	private static bool _protected = false;
	private static bool with_deps = false;
	private static bool _private = false;
	private static bool version;

	private static string pluginpath;

	private static bool non_null_experimental = false;
	private static bool disable_non_null = false;
	private static bool disable_checking;
	private static bool force = false;


	[NoArrayLength ()]
	private static string[] vapi_directories;
	[NoArrayLength ()]
	private static weak string[] tsources;
	[NoArrayLength ()]
	private static weak string[] tpackages;

	private Gee.ArrayList<string> packages = new Gee.ArrayList<string>(); // remove
	private Gee.ArrayList<string> sources  = new Gee.ArrayList<string>(); // remove


	private const GLib.OptionEntry[] options = {
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, out vapi_directories,
			"Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, out tpackages, "Include binding for PACKAGE", "PACKAGE..." },
		{ "directory", 'o', 0, OptionArg.FILENAME, out directory, "Output directory", "DIRECTORY" },
		{ "protected", 0, 0, OptionArg.NONE, ref _protected, "Adds protected elements to documentation", null },
		{ "private", 0, 0, OptionArg.NONE, ref _private, "Adds private elements to documentation", null },
		{ "inherit", 0, 0, OptionArg.NONE, ref add_inherited, "Adds inherited elements to a class", null },
		{ "deps", 0, 0, OptionArg.NONE, ref with_deps, "Adds packages to the documentation", null },
		{ "disable-non-null", 0, 0, OptionArg.NONE, ref disable_non_null, "Disable non-null types", null },
		{ "enable-non-null-experimental", 0, 0, OptionArg.NONE, ref non_null_experimental,
				"Enable experimentalenhancements for non-null types", null },
		{ "", 0, 0, OptionArg.FILENAME_ARRAY, out tsources, null, "FILE..." },
		{ "doclet", 0, 0, OptionArg.FILENAME, ref pluginpath, "plugin", "DIRECTORY" },
		{ "package-name", 0, 0, OptionArg.STRING, ref pkg_name, "package name", "DIRECTORY" },
		{ "package-version", 0, 0, OptionArg.STRING, ref pkg_version, "package version", "DIRECTORY" },
		{ "force", 0, 0, OptionArg.NONE, ref force, "force", null },
		{ null }
	};

	private static int quit () {
		if (Report.get_errors () == 0) {
			stdout.printf ("Succeeded - %d warning(s)\n", Report.get_warnings ());
			return 0;
		}
		else {
			stdout.printf ("Failed: %d error(s), %d warning(s)\n", Report.get_errors (), Report.get_warnings ());
			return 1;
		}
	}

/*
	private bool check_doclet_structure ( string realpath ) {
		bool tmp = FileUtils.test ( realpath, FileTest.IS_DIR );
		if ( tmp == false ) {
			return false;
		}

		tmp = FileUtils.test ( realpath + "/libdoclet.so", FileTest.IS_EXECUTABLE );
		if ( tmp == false ) {
			return false;
		}


		tmp = FileUtils.test ( realpath + "/taglets/", FileTest.IS_DIR );
		if ( tmp == false ) {
			return false;
		}

		return true;
	}
*/
	private static bool check_pkg_name () {
		if ( pkg_name == null )
			return true;

		if ( pkg_name == "glib-2.0" || pkg_name == "gobject-2.0" )
			return false;

		foreach (string package in tsources ) {
			if ( pkg_name == package )
				return false;
		}
		return true;
	}

	private string get_pkg_name ( ) {
		if ( this.pkg_name == null ) {
			if ( this.directory.has_suffix ( "/" ) )
				this.pkg_name = GLib.Path.get_dirname ( this.directory );
			else
				this.pkg_name = GLib.Path.get_basename ( this.directory );
		}

		return this.pkg_name;
	}

	private int run (  ) {
		var settings = new Valadoc.Settings ( );
		settings.pkg_name = this.get_pkg_name ( );
		settings.pkg_version = this.pkg_version;

		settings.add_inherited = this.add_inherited;

//		settings.files = this.sort_sources ( ); /// <--- remove!

		settings._protected = this._protected;
		settings.with_deps = this.with_deps;
		settings._private = this._private;
		settings.path = this.directory;


		ErrorReporter reporter = new ErrorReporter();

		string fulldirpath = (pluginpath == null)? Config.plugin_dir : pluginpath;
		ModuleLoader modules = new ModuleLoader ();
		bool tmp = modules.load ( fulldirpath );
		if ( tmp == false ) {
			Report.error (null, "failed to load plugin" );
			return quit ();
		}

		Valadoc.Parser docparser = new Valadoc.Parser ( settings, reporter, modules );

		Valadoc.Tree doctree = new Valadoc.Tree ( settings, non_null_experimental, disable_non_null, disable_checking, basedir, directory );

		if (!doctree.add_external_package ( vapi_directories, "glib-2.0" )) {
			Report.error (null, "glib-2.0 not found in specified Vala API directories" );
			return quit ();
		}

		if (!doctree.add_external_package ( vapi_directories, "gobject-2.0" )) {
			Report.error (null, "gobject-2.0 not found in specified Vala API directories");
			return quit ();
		}

		if ( this.tpackages != null ) {
			foreach (string package in this.tpackages ) {
				if (!doctree.add_external_package ( vapi_directories, package )) {
					Report.error (null, "%s not found in specified Vala API directories".printf (package));
					return quit ();
				}
			}
			this.tpackages = null;
		}

		if ( this.tsources != null ) {
			foreach ( string src in this.tsources ) {
				if ( !doctree.add_file ( src ) ) {
					Report.error (null, "%s not found".printf (src));
					return quit ();
				}
			}
			this.tsources = null;
		}

		if ( !doctree.create_tree( ) )
			return quit ();

		doctree.parse_comments ( docparser );
		if ( reporter.errors > 0 )
			return 1;


		modules.doclet.initialisation ( settings );
		doctree.visit ( modules.doclet );
		modules.doclet.cleanups ( );

		settings = null;
		doctree = null;
		return quit ();
	}

	private static bool remove_directory ( string rpath ) {
		try {
			GLib.Dir dir = GLib.Dir.open ( rpath ); //throws GLib.FileError
			if ( dir == null )
				return false;

			for ( weak string entry = dir.read_name(); entry != null ; entry = dir.read_name() ) {
				string path = rpath + entry;

				bool is_dir = GLib.FileUtils.test ( path, GLib.FileTest.IS_DIR );
				if ( is_dir == true ) {
					bool tmp = remove_directory ( path );
					if ( tmp == false ) {
						stderr.printf ( "Error: Can't remove directory %s.\n", path );
						return false;
					}
				}
				else {
					int tmp = GLib.FileUtils.unlink ( path );
					if ( tmp > 0 ) {
						stderr.printf ( "Error: Can't remove file %s.\n", path );
						return false;
					}
				}
			}
		}
		finally {}

		return true;
	}

	static int main ( string[] args ) {
		try {
			var opt_context = new OptionContext ("- Vala Documentation Tool");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse ( ref args);
		}
		catch (OptionError e) {
			stdout.printf ("%s\n", e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return quit ();
		}

		if ( version ) {
			stdout.printf ("Valadoc %s\n", "0.1" );
			return 0;
		}

		if ( directory == null ) {
			Report.error (null, "No output directory specified." );
			return quit ();
		}

		if ( directory[ directory.len() - 1 ] != '/' ) {
			directory += "/";
		}

		if ( FileUtils.test ( directory, FileTest.EXISTS ) ) {
			if ( force == true ) {
				remove_directory ( directory );
			}
			else {
				Report.error (null, "File already exists." );
				return quit ();
			}
		}


		if ( pluginpath == null ) {
			pluginpath = Config.plugin_dir + "/template/";
		}
		else {
			if ( !pluginpath.has_suffix ( "/" ) )
				pluginpath = pluginpath + "/";
		}

		if ( !check_pkg_name () ) {
			Report.error (null, "Invalid package name." );
			return quit ();
		}

		var valadoc = new ValaDoc( );
		valadoc.run();
		return 0;
	}
}

