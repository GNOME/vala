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

using Drawer;
using GLib;
using Vala;
using Gee;



public class ValaDoc : Object {
	private static string basedir;
	private static string directory;

	private static bool add_documentation = false;
	private static bool add_inherited = false;
	private static bool _protected = false;
	private static bool with_deps = false;
	private static bool _private = false;
	private static bool version;

	private static bool non_null_experimental = false;
	private static bool disable_non_null = false;
	private static bool disable_checking;

	[NoArrayLength ()]
	private static string[] vapi_directories;
	[NoArrayLength ()]
	private static weak string[] tsources;
	[NoArrayLength ()]
	private static string library;
	[NoArrayLength ()]
	private static weak string[] tpackages;


	private Gee.ArrayList<string> packages = new Gee.ArrayList<string>();
	private Gee.ArrayList<string> sources  = new Gee.ArrayList<string>();



	private const GLib.OptionEntry[] options = {
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, out vapi_directories,
			"Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, out tpackages, "Include binding for PACKAGE", "PACKAGE..." },
		//{ "library", 0, 0, OptionArg.STRING, out library, "Library name", "NAME" },
		//{ "basedir", 'b', 0, OptionArg.FILENAME, out basedir, "Base source directory", "DIRECTORY" },
		{ "directory", 'o', 0, OptionArg.FILENAME, out directory, "Output directory", "DIRECTORY" },
		{ "protected", 0, 0, OptionArg.NONE, ref _protected, "Adds protected elements to documentation", null },
		{ "private", 0, 0, OptionArg.NONE, ref _private, "Adds private elements to documentation", null },
		{ "inherit", 0, 0, OptionArg.NONE, ref add_inherited, "Adds inherited elements to a class", null },
//		{ "extend", 0, 0, OptionArg.NONE, ref add_documentation, "Adds documentation to a given directory", null },
		{ "deps", 0, 0, OptionArg.NONE, ref with_deps, "Adds packages to the documentation", null },
		{ "disable-non-null", 0, 0, OptionArg.NONE, ref disable_non_null, "Disable non-null types", null },
		{ "enable-non-null-experimental", 0, 0, OptionArg.NONE, ref non_null_experimental, "Enable experimentalenhancements for non-null types", null },
		{ "", 0, 0, OptionArg.FILENAME_ARRAY, out tsources, null, "FILE..." },
		{ null }
	};

	private int quit () {
		if (Report.get_errors () == 0) {
			stdout.printf ("Succeeded - %d warning(s)\n", Report.get_warnings ());
			return 0;
		}
		else {
			stdout.printf ("Failed: %d error(s), %d warning(s)\n", Report.get_errors (), Report.get_warnings ());
			return 1;
		}
	}

	private bool add_package (CodeContext context, string pkg) {
		if (context.has_package (pkg)) {
			// ignore multiple occurences of the same package
			return true;
		}

		var package_path = get_package_path (pkg);
		
		if (package_path == null) {
			return false;
		}
		
		context.add_package (pkg);
		context.add_source_file (new SourceFile (context, package_path, true));
		
		var deps_filename = Path.build_filename (Path.get_dirname (package_path), "%s.deps".printf (pkg));

		if (FileUtils.test (deps_filename, FileTest.EXISTS)) {
			try {
				string deps_content;
				//ulong deps_len;
				FileUtils.get_contents (deps_filename, out deps_content, null );
				foreach (string dep in deps_content.split ("\n")) {
					if (dep != "") {
						if (!add_package (context, dep)) {
							Report.error (null, "%s, dependency of %s, not found in specified Vala API directories".printf (dep, pkg));
						}
					}
				}
			} catch (FileError e) {
				Report.error (null, "Unable to read dependency file: %s".printf (e.message));
			}
		}

		return true;
	}

	private string get_package_path (string pkg) {
		if (FileUtils.test ( pkg, FileTest.EXISTS))
			return pkg;

		string basename = "%s.vapi".printf (pkg);

		if ( this.vapi_directories != null ) {
			foreach (string vapidir in this.vapi_directories ) {
				var filename = Path.build_filename (vapidir, basename);
				if (FileUtils.test (filename, FileTest.EXISTS)) {
					return filename;
				}
			}
		}

/*
		string filename = Path.build_filename (Config.PACKAGE_DATADIR, "vapi", basename);
		if (FileUtils.test (filename, FileTest.EXISTS)) {
			return filename;
		}
*/

		string filename = Path.build_filename ("/usr/local/share/vala/vapi", basename);
		if (FileUtils.test (filename, FileTest.EXISTS)) {
			return filename;
		}

		filename = Path.build_filename ("/usr/share/vala/vapi", basename);
		if (FileUtils.test (filename, FileTest.EXISTS)) {
			return filename;
		}
		return null;
	}

	private void add_files ( Vala.CodeContext context ) {
		foreach ( string source in this.sources ) {
			if (FileUtils.test (source, FileTest.EXISTS)) {
				var rpath = realpath (source);
				if (source.has_suffix (".vala")) {
					context.add_source_file (new SourceFile (context, rpath, false));
				}
				else if (source.has_suffix (".vapi")) {
					context.add_source_file (new SourceFile (context, rpath, true));
				}
				else {
					Report.error (null, "%s is not a supported source file type.".printf (source));
				}
			}
			else {
				Report.error (null, "%s not found".printf (source));
			}
		}
	}


	//ported from glibc
	private string realpath (string name) {
		string rpath;

		if (name.get_char () != '/') {
			// relative path
			rpath = Environment.get_current_dir ();
		}
		else {
			rpath = "/";
		}

		weak string start;
		weak string end;

		for (start = end = name; start.get_char () != 0; start = end) {
			// skip sequence of multiple path-separators
			while (start.get_char () == '/') {
				start = start.next_char ();
			}

			// find end of path component
			long len = 0;
			for (end = start; end.get_char () != 0 && end.get_char () != '/'; end = end.next_char ()) {
				len++;
			}

			if (len == 0) {
				break;
			}
			else if (len == 1 && start.get_char () == '.') {
				// do nothing
			}
			else if (len == 2 && start.has_prefix ("..")) {
				// back up to previous component, ignore if at root already
				if (rpath.len () > 1) {
					do {
						rpath = rpath.substring (0, rpath.len () - 1);
					}
					while (!rpath.has_suffix ("/"));
				}
			}
			else {
				if (!rpath.has_suffix ("/")) {
					rpath += "/";
				}

				rpath += start.substring (0, len);
			}
		}

		if (rpath.len () > 1 && rpath.has_suffix ("/")) {
			rpath = rpath.substring (0, rpath.len () - 1);
		}

		return rpath;
	}


	private Gee.ArrayList<string> sort_sources ( ) {
		var to_doc = new Gee.ArrayList<string>();

		if ( tsources != null ) {
			foreach ( string str in this.tsources ) {
				string rpath = this.realpath ( str );
				if ( str.has_suffix ( ".vala" ) )
					this.sources.add ( str );
				else
					this.packages.add ( str );

				to_doc.add ( rpath );
			}
		}

		if ( tpackages != null ) {
			foreach ( string str in this.tpackages ) {
				this.packages.add ( str );
			}
		}

		this.tpackages = null;
		this.tsources = null;
		return to_doc;
	}



	private void add_vapi ( ) {
		
	}

	private void add_source_file ( ) {
		
	}

	private int run (  ) {
		var settings = new Valadoc.Settings ( );

		settings.add_inherited = this.add_inherited;
		settings.files = this.sort_sources ( );
		settings._protected = this._protected;
		settings.with_deps = this.with_deps;
		settings._private = this._private;
		settings.path = this.directory;


		var context = new Vala.CodeContext();
		context.library = this.library;
		context.memory_management = false;
		context.assert = false;
		context.checking = false;
		context.ccode_only = false;
		context.compile_only = false;
		context.output = null;

		context.checking = !disable_checking;
		context.non_null = !disable_non_null || non_null_experimental;
		context.non_null_experimental = non_null_experimental;


		if ( this.basedir != null ) {
			context.basedir = realpath ( this.basedir );
		}

		if ( this.directory != null ) {
			context.directory = realpath ( this.directory );
		}
		else {
			context.directory = context.basedir;
		}

		context.optlevel = 0;
		context.debug = false;
		context.thread = false;
		context.save_temps = false;


		if ( this.packages != null ) {
			foreach (string package in this.packages ) {
				if (!add_package (context, package)) {
					Report.error (null, "%s not found in specified Vala API directories".printf (package));
				}
			}
			this.packages = null;
		}

		if (Report.get_errors () > 0) {
			return quit ();
		}


		if ( this.sources != null ) {
			this.add_files( context );
			this.sources = null;
			if (Report.get_errors () > 0) {
				return quit ();
			}
		}

		var parser  = new Vala.Parser ();
		parser.parse ( context );
		if (Report.get_errors () > 0) {
			return quit ();
		}

		var attributeprocessor = new AttributeProcessor ();
		attributeprocessor.process( context );
		if (Report.get_errors () > 0) {
			return quit ();
		}

		var resolver = new SymbolResolver ();
		resolver.resolve( context );
		if (Report.get_errors () > 0) {
			return quit ();
		}

		var analyzer = new SemanticAnalyzer ( );
		analyzer.analyze( context );
		if (Report.get_errors () > 0) {
			return quit ();
		}

		if (context.non_null_experimental) {
			var null_checker = new NullChecker ();
			null_checker.check (context);

			if (Report.get_errors () > 0) {
				return quit ();
			}
		}

		var err = new Valadoc.ErrorReporter ( );
		var docparser = new Valadoc.Tree( settings, context, err );
		docparser.create( );
		if ( err.numbers > 0 ) {
		 err.print_errors ( );
		 return 1;
		}

		var doclet = new Valadoc.Doclet ( settings, err );
		doclet.initialisation ( );
		docparser.visit ( doclet );
		return quit ();
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
			return 1;
		}

		if ( version ) {
			stdout.printf ("Valadoc %s\n", "0.1" );
			return 0;
		}

		if ( tsources == null ) {
			stderr.printf ("No source file specified.\n");
			return -1;
		}

		if ( directory == null ) {
			stderr.printf ("No output directory specified.\n");
			return -1;
		}

		if ( directory[ directory.len() - 1 ] != '/' ) {
			directory += "/";
		}

		if ( !add_documentation ) {
			if ( FileUtils.test ( directory, FileTest.EXISTS ) ) {
				stderr.printf ("File already exists.\n");
				return -1;
			}
		}

		var valadoc = new ValaDoc( );
		valadoc.run();
		return 0;
	}
}

