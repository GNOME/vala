/* valacompiler.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
 * Copyright (C) 1996-2002, 2004, 2005, 2006 Free Software Foundation, Inc.
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

class Vala.Compiler : Object {
	static string basedir;
	static string directory;
	static bool version;
	[NoArrayLength ()]
	static string[] sources;
	[NoArrayLength ()]
	static string[] vapi_directories;
	static string library;
	[NoArrayLength ()]
	static string[] packages;

	static bool ccode_only;
	static bool compile_only;
	static string output;
	static bool debug;
	static bool thread;
	static int optlevel;
	static bool disable_assert;
	static bool disable_checking;
	static bool non_null;
	static string cc_command;
	[NoArrayLength]
	static string[] cc_options;
	static bool save_temps;

	private CodeContext context;

	const OptionEntry[] options = {
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, out vapi_directories, "Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, out packages, "Include binding for PACKAGE", "PACKAGE..." },
		{ "library", 0, 0, OptionArg.STRING, out library, "Library name", "NAME" },
		{ "basedir", 'b', 0, OptionArg.FILENAME, out basedir, "Base source directory", "DIRECTORY" },
		{ "directory", 'd', 0, OptionArg.FILENAME, out directory, "Output directory", "DIRECTORY" },
		{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
		{ "ccode", 'C', 0, OptionArg.NONE, ref ccode_only, "Output C code", null },
		{ "compile", 'c', 0, OptionArg.NONE, ref compile_only, "Compile but do not link", null },
		{ "output", 'o', 0, OptionArg.FILENAME, out output, "Place output in file FILE", "FILE" },
		{ "debug", 'g', 0, OptionArg.NONE, ref debug, "Produce debug information", null },
		{ "thread", 0, 0, OptionArg.NONE, ref thread, "Enable multithreading support", null },
		{ "optimize", 'O', 0, OptionArg.INT, ref optlevel, "Optimization level", "OPTLEVEL" },
		{ "disable-assert", 0, 0, OptionArg.NONE, ref disable_assert, "Disable assertions", null },
		{ "disable-checking", 0, 0, OptionArg.NONE, ref disable_checking, "Disable run-time checks", null },
		{ "enable-non-null", 0, 0, OptionArg.NONE, ref non_null, "Enable non-null types", null },
		{ "cc", 0, 0, OptionArg.STRING, out cc_command, "Use COMMAND as C compiler command", "COMMAND" },
		{ "Xcc", 'X', 0, OptionArg.STRING_ARRAY, out cc_options, "Pass OPTION to the C compiler", "OPTION..." },
		{ "save-temps", 0, 0, OptionArg.NONE, out save_temps, "Keep temporary files", null },
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
	
	private string get_package_path (string! pkg) {
		string basename = "%s.vapi".printf (pkg);

		if (vapi_directories != null) {
			foreach (string vapidir in vapi_directories) {
				var filename = Path.build_filename (vapidir, basename);
				if (FileUtils.test (filename, FileTest.EXISTS)) {
					return filename;
				}
			}
		}

		string filename = Path.build_filename (Config.PACKAGE_DATADIR, "vapi", basename);
		if (FileUtils.test (filename, FileTest.EXISTS)) {
			return filename;
		}

		filename = Path.build_filename ("/usr/local/share/vala/vapi", basename);
		if (FileUtils.test (filename, FileTest.EXISTS)) {
			return filename;
		}

		filename = Path.build_filename ("/usr/share/vala/vapi", basename);
		if (FileUtils.test (filename, FileTest.EXISTS)) {
			return filename;
		}

		return null;
	}
	
	private bool add_package (CodeContext! context, string! pkg) {
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
				ulong deps_len;
				FileUtils.get_contents (deps_filename, out deps_content, out deps_len);
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
	
	private int run () {
		context = new CodeContext ();

		/* support old command line interface */
		if (!ccode_only && !compile_only && output == null) {
			ccode_only = true;
		}

		context.library = library;
		context.assert = !disable_assert;
		context.checking = !disable_checking;
		context.non_null = non_null;

		context.ccode_only = ccode_only;
		context.compile_only = compile_only;
		context.output = output;
		if (basedir != null) {
			context.basedir = realpath (basedir);
		}
		if (directory != null) {
			context.directory = realpath (directory);
		} else {
			context.directory = context.basedir;
		}
		context.debug = debug;
		context.thread = thread;
		context.optlevel = optlevel;
		context.save_temps = save_temps;

		context.codegen = new CCodeGenerator ();

		/* default package */
		if (!add_package (context, "glib-2.0")) {
			Report.error (null, "glib-2.0 not found in specified Vala API directories");
		}
		
		if (packages != null) {
			foreach (string package in packages) {
				if (!add_package (context, package)) {
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
				var rpath = realpath (source);
				if (source.has_suffix (".vala")) {
					context.add_source_file (new SourceFile (context, rpath));
				} else if (source.has_suffix (".vapi")) {
					context.add_source_file (new SourceFile (context, rpath, true));
				} else if (source.has_suffix (".c")) {
					context.add_c_source_file (rpath);
				} else {
					Report.error (null, "%s is not a supported source file type. Only .vala, .vapi, and .c files are supported.".printf (source));
				}
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
		
		var resolver = new SymbolResolver ();
		resolver.resolve (context);
		
		if (Report.get_errors () > 0) {
			return quit ();
		}

		var dbus_binding_provider = new DBusBindingProvider ();
		dbus_binding_provider.context = context;

		var analyzer = new SemanticAnalyzer ();
		analyzer.add_binding_provider (dbus_binding_provider);
		analyzer.analyze (context);
		
		if (Report.get_errors () > 0) {
			return quit ();
		}

		var memory_manager = new MemoryManager ();
		memory_manager.analyze (context);

		if (Report.get_errors () > 0) {
			return quit ();
		}

		context.codegen.emit (context);
		
		if (Report.get_errors () > 0) {
			return quit ();
		}
		
		if (library != null) {
			var interface_writer = new InterfaceWriter ();
			interface_writer.write_file (context, "%s.vapi".printf (library));
			
			library = null;
		}

		if (!ccode_only) {
			var ccompiler = new CCodeCompiler ();
			ccompiler.compile (context, cc_command, cc_options);
		}

		return quit ();
	}

	/* ported from glibc */
	private string! realpath (string! name) {
		string rpath;

		if (name.get_char () != '/') {
			// relative path
			rpath = Environment.get_current_dir ();
		} else {
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
			} else if (len == 1 && start.get_char () == '.') {
				// do nothing
			} else if (len == 2 && start.has_prefix ("..")) {
				// back up to previous component, ignore if at root already
				if (rpath.len () > 1) {
					do {
						rpath = rpath.substring (0, rpath.len () - 1);
					} while (!rpath.has_suffix ("/"));
				}
			} else {
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

	static int main (string[] args) {
		try {
			var opt_context = new OptionContext ("- Vala Compiler");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);
		} catch (OptionError e) {
			stdout.printf ("%s\n", e.message);
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
		
		var compiler = new Compiler ();
		return compiler.run ();
	}
}
