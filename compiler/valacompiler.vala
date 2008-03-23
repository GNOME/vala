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
	static bool disable_assert;
	static bool disable_checking;
	static bool non_null;
	static bool verbose;
	static string cc_command;
	[NoArrayLength]
	static string[] cc_options;
	static bool save_temps;
	[NoArrayLength]
	static string[] defines;
	static bool quiet_mode;

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
		{ "define", 'D', 0, OptionArg.STRING_ARRAY, out defines, "Define SYMBOL", "SYMBOL..." },
		{ "disable-assert", 0, 0, OptionArg.NONE, ref disable_assert, "Disable assertions", null },
		{ "disable-checking", 0, 0, OptionArg.NONE, ref disable_checking, "Disable run-time checks", null },
		{ "enable-non-null", 0, 0, OptionArg.NONE, ref non_null, "Enable non-null types", null },
		{ "cc", 0, 0, OptionArg.STRING, out cc_command, "Use COMMAND as C compiler command", "COMMAND" },
		{ "Xcc", 'X', 0, OptionArg.STRING_ARRAY, out cc_options, "Pass OPTION to the C compiler", "OPTION..." },
		{ "save-temps", 0, 0, OptionArg.NONE, out save_temps, "Keep temporary files", null },
		{ "quiet", 'q', 0, OptionArg.NONE, ref quiet_mode, "Do not print messages to the console", null },
		{ "verbose", 'v', 0, OptionArg.NONE, ref verbose, "Include the source line text when reporting errors or warnings." },
		{ "", 0, 0, OptionArg.FILENAME_ARRAY, out sources, null, "FILE..." },
		{ null }
	};
	
	private int quit () {
		if (Report.get_errors () == 0 && Report.get_warnings () == 0) {
			return 0;
		}
		if (Report.get_errors () == 0) {
			if (!quiet_mode) {
				stdout.printf ("Compilation succeeded - %d warning(s)\n", Report.get_warnings ());
			}
			return 0;
		} else {
			if (!quiet_mode) {
				stdout.printf ("Compilation failed: %d error(s), %d warning(s)\n", Report.get_errors (), Report.get_warnings ());
			}
			return 1;
		}
	}
	
	private bool add_package (CodeContext! context, string! pkg) {
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
		Report.set_verbose_errors (verbose);

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
		context.save_temps = save_temps;

		if (defines != null) {
			foreach (string define in defines) {
				context.add_define (define);
			}
		}

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

		var cfg_builder = new CFGBuilder ();
		cfg_builder.build_cfg (context);

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
			string vapi_filename = "%s.vapi".printf (library);

			// put .vapi file in current directory unless -d has been explicitly specified
			if (directory != null) {
				vapi_filename = "%s/%s".printf (context.directory, vapi_filename);
			}

			interface_writer.write_file (context, vapi_filename);


			var gidl_writer = new GIdlWriter ();
			string gidl_filename = "%s.gidl".printf (library);

			// put .gidl file in current directory unless -d has been explicitly specified
			if (directory != null) {
				gidl_filename = "%s/%s".printf (context.directory, gidl_filename);
			}

			gidl_writer.write_file (context, gidl_filename);


			library = null;
		}

		if (!ccode_only) {
			var ccompiler = new CCodeCompiler ();
			ccompiler.compile (context, cc_command, cc_options);
		}

		return quit ();
	}

	private static bool ends_with_dir_separator (string s) {
		return Path.is_dir_separator (s.offset (s.len () - 1).get_char ());
	}

	/* ported from glibc */
	private static string! realpath (string! name) {
		string rpath;

		// start of path component
		weak string start;
		// end of path component
		weak string end;

		if (!Path.is_absolute (name)) {
			// relative path
			rpath = Environment.get_current_dir ();

			start = end = name;
		} else {
			// set start after root
			start = end = Path.skip_root (name);

			// extract root
			rpath = name.substring (0, name.pointer_to_offset (start));
		}

		long root_len = rpath.pointer_to_offset (Path.skip_root (rpath));

		for (; start.get_char () != 0; start = end) {
			// skip sequence of multiple path-separators
			while (Path.is_dir_separator (start.get_char ())) {
				start = start.next_char ();
			}

			// find end of path component
			long len = 0;
			for (end = start; end.get_char () != 0 && !Path.is_dir_separator (end.get_char ()); end = end.next_char ()) {
				len++;
			}

			if (len == 0) {
				break;
			} else if (len == 1 && start.get_char () == '.') {
				// do nothing
			} else if (len == 2 && start.has_prefix ("..")) {
				// back up to previous component, ignore if at root already
				if (rpath.len () > root_len) {
					do {
						rpath = rpath.substring (0, rpath.len () - 1);
					} while (!ends_with_dir_separator (rpath));
				}
			} else {
				if (!ends_with_dir_separator (rpath)) {
					rpath += Path.DIR_SEPARATOR_S;
				}

				rpath += start.substring (0, len);
			}
		}

		if (rpath.len () > root_len && ends_with_dir_separator (rpath)) {
			rpath = rpath.substring (0, rpath.len () - 1);
		}

		if (Path.DIR_SEPARATOR != '/') {
			// don't use backslashes internally,
			// to avoid problems in #include directives
			string[] components = rpath.split ("\\");
			rpath = string.joinv ("/", components);
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
