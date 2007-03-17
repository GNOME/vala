/* valacompiler.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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

class Vala.Compiler {
	static string directory;
	static bool version;
	[NoArrayLength ()]
	static string[] sources;
	[NoArrayLength ()]
	static string[] vapi_directories;
	static string library;
	[NoArrayLength ()]
	static string[] packages;
	static bool disable_memory_management;

	private CodeContext context;
	private List<string> added_packages;

	const OptionEntry[] options = {
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, out vapi_directories, "Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, out packages, "Include binding for PACKAGE", "PACKAGE..." },
		{ "library", 0, 0, OptionArg.STRING, out library, "Library name", "NAME" },
		{ "directory", 'd', 0, OptionArg.FILENAME, out directory, "Output directory", "DIRECTORY" },
		{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
		{ "disable-memory-management", 0, 0, OptionArg.NONE, ref disable_memory_management, "Disable memory management", null },
		{ "", 0, 0, OptionArg.FILENAME_ARRAY, out sources, null, "FILE..." },
		{ null }
	};
	
	private int quit () {
		if (Report.get_errors () == 0) {
			stdout.printf ("Compilation succeeded - %d warning(s)\n", Report.get_warnings ());
			return 0;
		} else {
			stdout.printf ("Compilation failed: %d error(s), %d warning(s)\n", Report.get_errors (), Report.get_warnings ());
			return 1;
		}
	}
	
	private ref string get_package_path (string! pkg) {
		string basename = "%s.vala".printf (pkg);

		if (vapi_directories != null) {
			foreach (string vapidir in vapi_directories) {
				var filename = Path.build_filename (vapidir, basename);
				if (File.test (filename, FileTest.EXISTS)) {
					return filename;
				}
			}
		}

		string filename = Path.build_filename (Config.PACKAGE_DATADIR, "vapi", basename);
		if (File.test (filename, FileTest.EXISTS)) {
			return filename;
		}

		filename = Path.build_filename ("/usr/local/share/vala/vapi", basename);
		if (File.test (filename, FileTest.EXISTS)) {
			return filename;
		}

		filename = Path.build_filename ("/usr/share/vala/vapi", basename);
		if (File.test (filename, FileTest.EXISTS)) {
			return filename;
		}

		return null;
	}
	
	private bool add_package (string! pkg) {
		if (added_packages.find_custom (pkg, strcmp) != null) {
			// ignore multiple occurences of the same package
			return true;
		}
	
		var package_path = get_package_path (pkg);
		
		if (package_path == null) {
			return false;
		}
		
		added_packages.append (pkg);
		
		context.add_source_file (new SourceFile (context, package_path, true));
		
		var deps_filename = Path.build_filename (Path.get_dirname (package_path), "%s.deps".printf (pkg));
		if (File.test (deps_filename, FileTest.EXISTS)) {
			string deps_content;
			File.get_contents (deps_filename, out deps_content, null, null);
			foreach (string dep in deps_content.split ("\n")) {
				if (dep != "") {
					if (!add_package (dep)) {
						Report.error (null, "%s, dependency of %s, not found in specified Vala API directories".printf (dep, pkg));
					}
				}
			}
		}
		
		return true;
	}
	
	private int run () {
		context = new CodeContext ();
		
		context.library = library;
		
		/* default package */
		if (!add_package ("glib-2.0")) {
			Report.error (null, "glib-2.0 not found in specified Vala API directories");
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
			if (File.test (source, FileTest.EXISTS)) {
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
		
		var builder = new SymbolBuilder ();
		builder.build (context);
		
		if (Report.get_errors () > 0) {
			return quit ();
		}
		
		var attributeprocessor = new AttributeProcessor ();
		attributeprocessor.process (context);
		
		if (Report.get_errors () > 0) {
			return quit ();
		}
		
		var resolver = new SymbolResolver ();
		resolver.resolve (context);
		
		if (Report.get_errors () > 0) {
			return quit ();
		}
		
		var analyzer = new SemanticAnalyzer (!disable_memory_management);
		analyzer.analyze (context);
		
		if (Report.get_errors () > 0) {
			return quit ();
		}
		
		if (!disable_memory_management) {
			var memory_manager = new MemoryManager ();
			memory_manager.analyze (context);
			
			if (Report.get_errors () > 0) {
				return quit ();
			}
		}
		
		var code_generator = new CodeGenerator (!disable_memory_management);
		code_generator.emit (context);
		
		if (Report.get_errors () > 0) {
			return quit ();
		}
		
		if (library != null) {
			var interface_writer = new InterfaceWriter ();
			interface_writer.write_file (context, "%s.vala".printf (library));
			
			library = null;
		}
		
		return quit ();
	}
	
	static int main (string[] args) {
		Error err = null;
	
		var opt_context = new OptionContext ("- Vala Compiler");
		opt_context.set_help_enabled (true);
		opt_context.add_main_entries (options, null);
		opt_context.parse (out args, out err);
		
		if (err != null) {
			stdout.printf ("%s\n", err.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return 1;
		}
		
		if (version) {
			stdout.printf ("Vala %s\n", Config.PACKAGE_VERSION);
			return 0;
		}
		
		if (sources == null) {
			stderr.printf ("No source file specified.\n");
			return 1;
		}
		
		foreach (string source in sources) {
			if (!source.has_suffix (".vala")) {
				stderr.printf ("Only .vala source files supported.\n");
				return 1;
			}
		}
		
		var compiler = new Compiler ();
		return compiler.run ();
	}
}
