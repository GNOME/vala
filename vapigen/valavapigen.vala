/* valavapigen.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

class Vala.VAPIGen : Object {
	static string directory;
	static bool version;
	static bool quiet_mode;
	[CCode (array_length = false, array_null_terminated = true)]
	[NoArrayLength]
	static string[] sources;
	[CCode (array_length = false, array_null_terminated = true)]
	[NoArrayLength]
	static string[] vapi_directories;
	static string library;
	[CCode (array_length = false, array_null_terminated = true)]
	[NoArrayLength]
	static string[] packages;
	static string metadata_filename;
	CodeContext context;

	const OptionEntry[] options = {
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, ref vapi_directories, "Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, ref packages, "Include binding for PACKAGE", "PACKAGE..." },
		{ "library", 0, 0, OptionArg.STRING, ref library, "Library name", "NAME" },
		{ "metadata", 0, 0, OptionArg.FILENAME, ref metadata_filename, "Metadata filename", "FILE" },
		{ "directory", 'd', 0, OptionArg.FILENAME, ref directory, "Output directory", "DIRECTORY" },
		{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
		{ "quiet", 'q', 0, OptionArg.NONE, ref quiet_mode, "Do not print messages to the console", null },
		{ "", 0, 0, OptionArg.FILENAME_ARRAY, ref sources, null, "FILE..." },
		{ null }
	};
	
	private int quit () {
		if (context.report.get_errors () == 0) {
			if (!quiet_mode) {
				stdout.printf ("Generation succeeded - %d warning(s)\n", context.report.get_warnings ());
			}
			return 0;
		} else {
			if (!quiet_mode) {
				stdout.printf ("Generation failed: %d error(s), %d warning(s)\n", context.report.get_errors (), context.report.get_warnings ());
			}
			return 1;
		}
	}

	private bool add_package (string pkg) {
		if (context.has_package (pkg)) {
			// ignore multiple occurences of the same package
			return true;
		}

		var package_path = context.get_package_path (pkg, vapi_directories);
		
		if (package_path == null) {
			return false;
		}
		
		context.add_package (pkg);

		context.add_source_file (new SourceFile (context, package_path, true));
		
		return true;
	}
	
	private static string[]? get_packages_from_depsfile (string depsfile) {
		try {
			string contents;
			FileUtils.get_contents (depsfile, out contents);
			return contents.strip ().split ("\n");
		} catch (FileError e) {
			// deps files are optional
			return null;
		}
	}

	private int run () {
		context = new CodeContext ();
		context.profile = Profile.GOBJECT;
		CodeContext.push (context);
		
		/* default package */
		if (!add_package ("glib-2.0")) {
			Report.error (null, "glib-2.0 not found in specified Vala API directories");
		}
		if (!add_package ("gobject-2.0")) {
			Report.error (null, "gobject-2.0 not found in specified Vala API directories");
		}

		/* load packages from .deps file */
		foreach (string source in sources) {
			if (!source.has_suffix (".gi")) {
				continue;
			}

			var depsfile = source.substring (0, source.len () - "gi".len ()) + "deps";

			if (!FileUtils.test (depsfile, FileTest.EXISTS)) continue;
			
			string[] deps = get_packages_from_depsfile (depsfile);
			
			foreach (string dep in deps) {
				if (!add_package (dep)) {
					Report.error (null, "%s not found in specified Vala API directories".printf (dep));
				}
			}
		}

		// depsfile for gir case
		if (library != null) {
			var depsfile = library + ".deps";
			if (FileUtils.test (depsfile, FileTest.EXISTS)) {

				string[] deps = get_packages_from_depsfile (depsfile);

				foreach (string dep in deps) {
					if (!add_package (dep)) {
						Report.error (null, "%s not found in specified Vala API directories".printf (dep));
					}
				}
			}
		}

		if (packages != null) {
			foreach (string package in packages) {
				if (!add_package (package)) {
					Report.error (null, "%s not found in specified Vala API directories".printf (package));
				}
			}
			packages = null;
		}
		
		if (context.report.get_errors () > 0) {
			return quit ();
		}
		
		foreach (string source in sources) {
			if (FileUtils.test (source, FileTest.EXISTS)) {
				context.add_source_file (new SourceFile (context, source, true));
			} else {
				Report.error (null, "%s not found".printf (source));
			}
		}
		sources = null;
		
		if (context.report.get_errors () > 0) {
			return quit ();
		}
		
		var parser = new Parser ();
		parser.parse (context);
		
		if (context.report.get_errors () > 0) {
			return quit ();
		}
		
		var girparser = new GirParser ();
		if (metadata_filename != null) {
			girparser.parse_metadata (metadata_filename);
		}
		girparser.parse (context);
		
		if (context.report.get_errors () > 0) {
			return quit ();
		}
		
		var gidlparser = new GIdlParser ();
		gidlparser.parse (context);
		
		if (context.report.get_errors () > 0) {
			return quit ();
		}
		
		var resolver = new SymbolResolver ();
		resolver.resolve (context);
		
		if (context.report.get_errors () > 0) {
			return quit ();
		}

		var analyzer = new SemanticAnalyzer ();
		analyzer.analyze (context);

		if (context.report.get_errors () > 0) {
			return quit ();
		}
		
		if (library == null && girparser.package_name != null) {
			library = girparser.package_name;
		}

		if (library != null) {
			// interface writer ignores external packages
			foreach (SourceFile file in context.get_source_files ()) {
				if (!file.filename.has_suffix (".vapi")) {
					file.external_package = false;
				}
	 		}

			var interface_writer = new CodeWriter ();
			interface_writer.write_file (context, "%s.vapi".printf (library));
			
			library = null;
		}
		
		return quit ();
	}
	
	static int main (string[] args) {
		try {
			var opt_context = new OptionContext ("- Vala API Generator");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);
		} catch (OptionError e) {
			stdout.printf ("%s\n", e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return 1;
		}

		if (version) {
			stdout.printf ("Vala API Generator %s\n", Config.PACKAGE_VERSION);
			return 0;
		}

		if (sources == null) {
			stderr.printf ("No source file specified.\n");
			return 1;
		}
		
		var vapigen = new VAPIGen ();
		return vapigen.run ();
	}
}
