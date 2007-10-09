/* valavapigen.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
	[NoArrayLength ()]
	static string[] sources;
	[NoArrayLength ()]
	static string[] vapi_directories;
	static string library;
	[NoArrayLength ()]
	static string[] packages;
	CodeContext context;

	const OptionEntry[] options = {
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, out vapi_directories, "Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, out packages, "Include binding for PACKAGE", "PACKAGE..." },
		{ "library", 0, 0, OptionArg.STRING, out library, "Library name", "NAME" },
		{ "directory", 'd', 0, OptionArg.FILENAME, out directory, "Output directory", "DIRECTORY" },
		{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
		{ "", 0, 0, OptionArg.FILENAME_ARRAY, out sources, null, "FILE..." },
		{ null }
	};
	
	private int quit () {
		if (Report.get_errors () == 0) {
			stdout.printf ("Generation succeeded - %d warning(s)\n", Report.get_warnings ());
			return 0;
		} else {
			stdout.printf ("Generation failed: %d error(s), %d warning(s)\n", Report.get_errors (), Report.get_warnings ());
			return 1;
		}
	}
	
	private string get_package_path (string! pkg) {
		var basename = "%s.vapi".printf (pkg);
	
		if (vapi_directories != null) {
			foreach (string vapidir in vapi_directories) {
				var filename = Path.build_filename (vapidir, basename, null);
				if (FileUtils.test (filename, FileTest.EXISTS)) {
					return filename;
				}
			}
		}
		
		var filename = Path.build_filename ("/usr/local/share/vala/vapi", basename, null);
		if (FileUtils.test (filename, FileTest.EXISTS)) {
			return filename;
		}
		
		filename = Path.build_filename ("/usr/share/vala/vapi", basename, null);
		if (FileUtils.test (filename, FileTest.EXISTS)) {
			return filename;
		}
		
		return null;
	}
	
	private bool add_package (string! pkg) {
		if (context.has_package (pkg)) {
			// ignore multiple occurences of the same package
			return true;
		}

		var package_path = get_package_path (pkg);
		
		if (package_path == null) {
			return false;
		}
		
		context.add_source_file (new SourceFile (context, package_path, true));
		
		return true;
	}
	
	private static string[] get_packages_from_depsfile (string depsfile) {
		string contents;
		if (FileUtils.get_contents (depsfile, out contents)) {
			return contents.strip ().split ("\n");
		}
		return null;
	}

	private int run () {
		context = new CodeContext ();
		
		/* default package */
		if (!add_package ("glib-2.0")) {
			Report.error (null, "glib-2.0 not found in specified Vala API directories");
		}
		
		/* load packages from .deps file */
		foreach (string source in sources) {
			if (!source.has_suffix (".gidl")) {
				continue;
			}

			var depsfile = source.substring (0, source.len () - 4) + "deps";

			if (!FileUtils.test (depsfile, FileTest.EXISTS)) continue;
			
			string[] deps = get_packages_from_depsfile (depsfile);
			
			foreach (string dep in deps) {
				if (!add_package (dep)) {
					Report.error (null, "%s not found in specified Vala API directories".printf (dep));
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
		
		if (Report.get_errors () > 0) {
			return quit ();
		}
		
		foreach (string source in sources) {
			if (FileUtils.test (source, FileTest.EXISTS)) {
				context.add_source_file (new SourceFile (context, source));
			} else {
				Report.error (null, "%s not found".printf (source));
			}
		}
		sources = null;
		
		if (Report.get_errors () > 0) {
			return quit ();
		}
		
		var parser = new Parser ();
		parser.parse (context);
		
		if (Report.get_errors () > 0) {
			return quit ();
		}
		
		var attributeprocessor = new AttributeProcessor ();
		attributeprocessor.process (context);
		
		if (Report.get_errors () > 0) {
			return quit ();
		}
		
		var gidlparser = new GIdlParser ();
		gidlparser.parse (context);
		
		if (Report.get_errors () > 0) {
			return quit ();
		}
		
		var resolver = new SymbolResolver ();
		resolver.resolve (context);
		
		if (Report.get_errors () > 0) {
			return quit ();
		}
		
		if (library != null) {
			var interface_writer = new InterfaceWriter ();
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
			opt_context.parse (out args);
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
