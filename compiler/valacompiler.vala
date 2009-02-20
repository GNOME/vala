/* valacompiler.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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

class Vala.Compiler {
	static string basedir;
	static string directory;
	static bool version;
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
	static string target_glib;

	static bool ccode_only;
	static string header_filename;
	static bool compile_only;
	static string output;
	static bool debug;
	static bool thread;
	static bool disable_assert;
	static bool enable_checking;
	static bool deprecated;
	static bool experimental;
	static bool non_null_experimental;
	static bool disable_dbus_transformation;
	static string cc_command;
	[CCode (array_length = false, array_null_terminated = true)]
	[NoArrayLength]
	static string[] cc_options;
	static string dump_tree;
	static bool save_temps;
	static bool quiet_mode;

	private CodeContext context;

	const OptionEntry[] options = {
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, ref vapi_directories, "Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, ref packages, "Include binding for PACKAGE", "PACKAGE..." },
		{ "library", 0, 0, OptionArg.STRING, ref library, "Library name", "NAME" },
		{ "basedir", 'b', 0, OptionArg.FILENAME, ref basedir, "Base source directory", "DIRECTORY" },
		{ "directory", 'd', 0, OptionArg.FILENAME, ref directory, "Output directory", "DIRECTORY" },
		{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
		{ "ccode", 'C', 0, OptionArg.NONE, ref ccode_only, "Output C code", null },
		{ "header", 'H', 0, OptionArg.FILENAME, ref header_filename, "Output C header file", "FILE" },
		{ "compile", 'c', 0, OptionArg.NONE, ref compile_only, "Compile but do not link", null },
		{ "output", 'o', 0, OptionArg.FILENAME, ref output, "Place output in file FILE", "FILE" },
		{ "debug", 'g', 0, OptionArg.NONE, ref debug, "Produce debug information", null },
		{ "thread", 0, 0, OptionArg.NONE, ref thread, "Enable multithreading support", null },
		{ "disable-assert", 0, 0, OptionArg.NONE, ref disable_assert, "Disable assertions", null },
		{ "enable-checking", 0, 0, OptionArg.NONE, ref enable_checking, "Enable additional run-time checks", null },
		{ "enable-deprecated", 0, 0, OptionArg.NONE, ref deprecated, "Enable deprecated features", null },
		{ "enable-experimental", 0, 0, OptionArg.NONE, ref experimental, "Enable experimental features", null },
		{ "enable-non-null-experimental", 0, 0, OptionArg.NONE, ref non_null_experimental, "Enable experimental enhancements for non-null types", null },
		{ "disable-dbus-transformation", 0, 0, OptionArg.NONE, ref disable_dbus_transformation, "Disable transformation of D-Bus member names", null },
		{ "cc", 0, 0, OptionArg.STRING, ref cc_command, "Use COMMAND as C compiler command", "COMMAND" },
		{ "Xcc", 'X', 0, OptionArg.STRING_ARRAY, ref cc_options, "Pass OPTION to the C compiler", "OPTION..." },
		{ "dump-tree", 0, 0, OptionArg.FILENAME, ref dump_tree, "Write code tree to FILE", "FILE" },
		{ "save-temps", 0, 0, OptionArg.NONE, ref save_temps, "Keep temporary files", null },
		{ "quiet", 'q', 0, OptionArg.NONE, ref quiet_mode, "Do not print messages to the console", null },
		{ "target-glib", 0, 0, OptionArg.STRING, ref target_glib, "Target version of glib for code generation", "MAJOR.MINOR" },
		{ "", 0, 0, OptionArg.FILENAME_ARRAY, ref sources, null, "FILE..." },
		{ null }
	};
	
	private int quit () {
		if (context.report.get_errors () == 0 && context.report.get_warnings () == 0) {
			return 0;
		}
		if (context.report.get_errors () == 0) {
			if (!quiet_mode) {
				stdout.printf ("Compilation succeeded - %d warning(s)\n", context.report.get_warnings ());
			}
			return 0;
		} else {
			if (!quiet_mode) {
				stdout.printf ("Compilation failed: %d error(s), %d warning(s)\n", context.report.get_errors (), context.report.get_warnings ());
			}
			return 1;
		}
	}
	
	private bool add_package (CodeContext context, string pkg) {
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
		CodeContext.push (context);

		// default to build executable
		if (!ccode_only && !compile_only && output == null) {
			// strip extension if there is one
			// else we use the default output file of the C compiler
			if (sources[0].rchr (-1, '.') != null) {
				long dot = sources[0].pointer_to_offset (sources[0].rchr (-1, '.'));
				output = Path.get_basename (sources[0].substring (0, dot));
			}
		}

		context.library = library;
		context.assert = !disable_assert;
		context.checking = enable_checking;
		context.deprecated = deprecated;
		context.experimental = experimental;
		context.non_null_experimental = non_null_experimental;
		context.dbus_transformation = !disable_dbus_transformation;
		context.report.set_verbose_errors (!quiet_mode);

		context.ccode_only = ccode_only;
		context.compile_only = compile_only;
		context.header_filename = header_filename;
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

		int glib_major = 2;
		int glib_minor = 12;
		if (target_glib != null && target_glib.scanf ("%d.%d", out glib_major, out glib_minor) != 2) {
			Report.error (null, "Invalid format for --target-glib");
		}

		context.target_glib_major = glib_major;
		context.target_glib_minor = glib_minor;
		if (context.target_glib_major != 2) {
			Report.error (null, "This version of valac only supports GLib 2");
		}

		context.codegen = new CCodeGenerator ();

		/* default packages */
		if (!add_package (context, "glib-2.0")) {
			Report.error (null, "glib-2.0 not found in specified Vala API directories");
		}
		if (!add_package (context, "gobject-2.0")) {
			Report.error (null, "gobject-2.0 not found in specified Vala API directories");
		}

		if (packages != null) {
			foreach (string package in packages) {
				if (!add_package (context, package)) {
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
				var rpath = realpath (source);
				if (source.has_suffix (".vala") || source.has_suffix (".gs")) {
					var source_file = new SourceFile (context, rpath);

					// import the GLib namespace by default (namespace of backend-specific standard library)
					source_file.add_using_directive (new UsingDirective (new UnresolvedSymbol (null, "GLib", null)));

					context.add_source_file (source_file);
				} else if (source.has_suffix (".vapi")) {
					context.add_source_file (new SourceFile (context, rpath, true));
				} else if (source.has_suffix (".c")) {
					context.add_c_source_file (rpath);
				} else {
					Report.error (null, "%s is not a supported source file type. Only .vala, .vapi, .gs, and .c files are supported.".printf (source));
				}
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

		var genie_parser = new Genie.Parser ();
		genie_parser.parse (context);

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

		if (dump_tree != null) {
			var code_writer = new CodeWriter (true);
			code_writer.write_file (context, dump_tree);
		}

		if (context.report.get_errors () > 0) {
			return quit ();
		}

		var flow_analyzer = new FlowAnalyzer ();
		flow_analyzer.analyze (context);

		if (context.report.get_errors () > 0) {
			return quit ();
		}

		if (context.non_null_experimental) {
			var null_checker = new NullChecker ();
			null_checker.check (context);

			if (context.report.get_errors () > 0) {
				return quit ();
			}
		}

		context.codegen.emit (context);
		
		if (context.report.get_errors () > 0) {
			return quit ();
		}
		
		if (library != null) {
			var interface_writer = new CodeWriter ();
			string vapi_filename = "%s.vapi".printf (library);

			// put .vapi file in current directory unless -d has been explicitly specified
			if (directory != null && !Path.is_absolute (vapi_filename)) {
				vapi_filename = "%s%c%s".printf (context.directory, Path.DIR_SEPARATOR, vapi_filename);
			}

			interface_writer.write_file (context, vapi_filename);


			var gir_writer = new GIRWriter ();
			string gir_filename = "%s.gir".printf (library);

			// put .gir file in current directory unless -d has been explicitly specified
			if (directory != null && !Path.is_absolute (gir_filename)) {
				gir_filename = "%s%c%s".printf (context.directory, Path.DIR_SEPARATOR, gir_filename);
			}

			gir_writer.write_file (context, gir_filename);


			library = null;
		}

		if (!ccode_only) {
			var ccompiler = new CCodeCompiler ();
			if (cc_command == null && Environment.get_variable ("CC") != null) {
				cc_command = Environment.get_variable ("CC");
			}
			if (cc_options == null) {
				ccompiler.compile (context, cc_command, new string[] { });
			} else {
				ccompiler.compile (context, cc_command, cc_options);
			}
		}

		return quit ();
	}

	private static bool ends_with_dir_separator (string s) {
		return Path.is_dir_separator (s.offset (s.len () - 1).get_char ());
	}

	/* ported from glibc */
	private static string realpath (string name) {
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
