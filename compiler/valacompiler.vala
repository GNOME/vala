/* valacompiler.vala
 *
 * Copyright (C) 2006-2012  Jürg Billeter
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
	private const string DEFAULT_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";

	static string basedir;
	static string directory;
	static bool version;
	static bool api_version;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] sources;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] vapi_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] gir_directories;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] metadata_directories;
	static string vapi_filename;
	static string library;
	static string shared_library;
	static string gir;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] packages;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] fast_vapis;
	static string target_glib;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] gresources;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] gresources_directories;

	static bool ccode_only;
	static bool abi_stability;
	static string header_filename;
	static bool use_header;
	static string internal_header_filename;
	static string internal_vapi_filename;
	static string fast_vapi_filename;
	static bool vapi_comments;
	static string symbols_filename;
	static string includedir;
	static bool compile_only;
	static string output;
	static bool debug;
	static bool mem_profiler;
	static bool disable_assert;
	static bool enable_checking;
	static bool deprecated;
	static bool hide_internal;
	static bool experimental;
	static bool experimental_non_null;
	static bool gobject_tracing;
	static bool disable_since_check;
	static bool disable_warnings;
	static bool keep_going;
	static bool list_sources;
	static string cc_command;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] cc_options;
	static string pkg_config_command;
	static string dump_tree;
	static bool save_temps;
	[CCode (array_length = false, array_null_terminated = true)]
	static string[] defines;
	static bool quiet_mode;
	static bool verbose_mode;
	static string profile;
	static bool nostdpkg;
	static bool enable_version_header;
	static bool disable_version_header;
	static bool fatal_warnings;
	static bool disable_colored_output;
	static Report.Colored colored_output = Report.Colored.AUTO;
	static string dependencies;
	static string depfile;

	static string entry_point;

	static bool run_output;
	static string run_args;

	private CodeContext context;

	const OptionEntry[] options = {
		{ "vapidir", 0, 0, OptionArg.FILENAME_ARRAY, ref vapi_directories, "Look for package bindings in DIRECTORY", "DIRECTORY..." },
		{ "girdir", 0, 0, OptionArg.FILENAME_ARRAY, ref gir_directories, "Look for .gir files in DIRECTORY", "DIRECTORY..." },
		{ "metadatadir", 0, 0, OptionArg.FILENAME_ARRAY, ref metadata_directories, "Look for GIR .metadata files in DIRECTORY", "DIRECTORY..." },
		{ "pkg", 0, 0, OptionArg.STRING_ARRAY, ref packages, "Include binding for PACKAGE", "PACKAGE..." },
		{ "vapi", 0, 0, OptionArg.FILENAME, ref vapi_filename, "Output VAPI file name", "FILE" },
		{ "library", 0, 0, OptionArg.STRING, ref library, "Library name", "NAME" },
		{ "shared-library", 0, 0, OptionArg.STRING, ref shared_library, "Shared library name used in generated gir", "NAME" },
		{ "gir", 0, 0, OptionArg.STRING, ref gir, "GObject-Introspection repository file name", "NAME-VERSION.gir" },
		{ "basedir", 'b', 0, OptionArg.FILENAME, ref basedir, "Base source directory", "DIRECTORY" },
		{ "directory", 'd', 0, OptionArg.FILENAME, ref directory, "Change output directory from current working directory", "DIRECTORY" },
		{ "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
		{ "api-version", 0, 0, OptionArg.NONE, ref api_version, "Display API version number", null },
		{ "ccode", 'C', 0, OptionArg.NONE, ref ccode_only, "Output C code", null },
		{ "header", 'H', 0, OptionArg.FILENAME, ref header_filename, "Output C header file", "FILE" },
		{ "use-header", 0, 0, OptionArg.NONE, ref use_header, "Use C header file", null },
		{ "includedir", 0, 0, OptionArg.FILENAME, ref includedir, "Directory used to include the C header file", "DIRECTORY" },
		{ "internal-header", 'h', 0, OptionArg.FILENAME, ref internal_header_filename, "Output internal C header file", "FILE" },
		{ "internal-vapi", 0, 0, OptionArg.FILENAME, ref internal_vapi_filename, "Output vapi with internal api", "FILE" },
		{ "fast-vapi", 0, 0, OptionArg.STRING, ref fast_vapi_filename, "Output vapi without performing symbol resolution", null },
		{ "use-fast-vapi", 0, 0, OptionArg.STRING_ARRAY, ref fast_vapis, "Use --fast-vapi output during this compile", null },
		{ "vapi-comments", 0, 0, OptionArg.NONE, ref vapi_comments, "Include comments in generated vapi", null },
		{ "deps", 0, 0, OptionArg.STRING, ref dependencies, "Write make-style dependency information to this file", null },
		{ "depfile", 0, 0, OptionArg.STRING, ref depfile, "Write make-style external dependency information for build systems to this file", null },
		{ "list-sources", 0, 0, OptionArg.NONE, ref list_sources, "Output a list of all source and binding files which are used", null },
		{ "symbols", 0, 0, OptionArg.FILENAME, ref symbols_filename, "Output symbols file", "FILE" },
		{ "compile", 'c', 0, OptionArg.NONE, ref compile_only, "Compile but do not link", null },
		{ "output", 'o', 0, OptionArg.FILENAME, ref output, "Place output in file FILE", "FILE" },
		{ "debug", 'g', 0, OptionArg.NONE, ref debug, "Produce debug information", null },
		{ "thread", 0, OptionFlags.OPTIONAL_ARG | OptionFlags.NO_ARG, OptionArg.CALLBACK, (void*) option_deprecated, "Enable multithreading support (DEPRECATED AND IGNORED)", null },
		{ "enable-mem-profiler", 0, 0, OptionArg.NONE, ref mem_profiler, "Enable GLib memory profiler", null },
		{ "define", 'D', 0, OptionArg.STRING_ARRAY, ref defines, "Define SYMBOL", "SYMBOL..." },
		{ "main", 0, 0, OptionArg.STRING, ref entry_point, "Use SYMBOL as entry point", "SYMBOL..." },
		{ "nostdpkg", 0, 0, OptionArg.NONE, ref nostdpkg, "Do not include standard packages", null },
		{ "disable-assert", 0, 0, OptionArg.NONE, ref disable_assert, "Disable assertions", null },
		{ "enable-checking", 0, 0, OptionArg.NONE, ref enable_checking, "Enable additional run-time checks", null },
		{ "enable-deprecated", 0, 0, OptionArg.NONE, ref deprecated, "Enable deprecated features", null },
		{ "hide-internal", 0, 0, OptionArg.NONE, ref hide_internal, "Hide symbols marked as internal", null },
		{ "enable-experimental", 0, 0, OptionArg.NONE, ref experimental, "Enable experimental features", null },
		{ "disable-warnings", 0, 0, OptionArg.NONE, ref disable_warnings, "Disable warnings", null },
		{ "fatal-warnings", 0, 0, OptionArg.NONE, ref fatal_warnings, "Treat warnings as fatal", null },
		{ "disable-since-check", 0, 0, OptionArg.NONE, ref disable_since_check, "Do not check whether used symbols exist in local packages", null },
		{ "keep-going", 'k', 0, OptionArg.NONE, ref keep_going, "Continue as much as possible after an error", null },
		{ "enable-experimental-non-null", 0, 0, OptionArg.NONE, ref experimental_non_null, "Enable experimental enhancements for non-null types", null },
		{ "enable-gobject-tracing", 0, 0, OptionArg.NONE, ref gobject_tracing, "Enable GObject creation tracing", null },
		{ "cc", 0, 0, OptionArg.STRING, ref cc_command, "Use COMMAND as C compiler command", "COMMAND" },
		{ "Xcc", 'X', 0, OptionArg.STRING_ARRAY, ref cc_options, "Pass OPTION to the C compiler", "OPTION..." },
		{ "pkg-config", 0, 0, OptionArg.STRING, ref pkg_config_command, "Use COMMAND as pkg-config command", "COMMAND" },
		{ "dump-tree", 0, 0, OptionArg.FILENAME, ref dump_tree, "Write code tree to FILE", "FILE" },
		{ "save-temps", 0, 0, OptionArg.NONE, ref save_temps, "Keep temporary files", null },
		{ "profile", 0, 0, OptionArg.STRING, ref profile, "Use the given profile instead of the default", "PROFILE" },
		{ "quiet", 'q', 0, OptionArg.NONE, ref quiet_mode, "Do not print messages to the console", null },
		{ "verbose", 'v', 0, OptionArg.NONE, ref verbose_mode, "Print additional messages to the console", null },
		{ "no-color", 0, 0, OptionArg.NONE, ref disable_colored_output, "Disable colored output, alias for --color=never", null },
		{ "color", 0, OptionFlags.OPTIONAL_ARG, OptionArg.CALLBACK, (void*) option_parse_color, "Enable color output, options are 'always', 'never', or 'auto'", "WHEN" },
		{ "target-glib", 0, 0, OptionArg.STRING, ref target_glib, "Target version of glib for code generation", "'MAJOR.MINOR', or 'auto'" },
		{ "gresources", 0, 0, OptionArg.FILENAME_ARRAY, ref gresources, "XML of gresources", "FILE..." },
		{ "gresourcesdir", 0, 0, OptionArg.FILENAME_ARRAY, ref gresources_directories, "Look for resources in DIRECTORY", "DIRECTORY..." },
		{ "enable-version-header", 0, 0, OptionArg.NONE, ref enable_version_header, "Write vala build version in generated files", null },
		{ "disable-version-header", 0, 0, OptionArg.NONE, ref disable_version_header, "Do not write vala build version in generated files", null },
		{ "run-args", 0, 0, OptionArg.STRING, ref run_args, "Arguments passed to directly compiled executeable", null },
		{ "abi-stability", 0, 0, OptionArg.NONE, ref abi_stability, "Enable support for ABI stability", null },
		{ OPTION_REMAINING, 0, 0, OptionArg.FILENAME_ARRAY, ref sources, null, "FILE..." },
		{ null }
	};

	static bool option_parse_color (string option_name, string? val, void* data) throws OptionError {
		switch (val) {
			case "auto": colored_output = Report.Colored.AUTO; break;
			case "never": colored_output = Report.Colored.NEVER; break;
			case null:
			case "always": colored_output = Report.Colored.ALWAYS; break;
			default: throw new OptionError.FAILED ("Invalid --color argument '%s'", val);
		}
		return true;
	}

	static bool option_deprecated (string option_name, string? val, void* data) throws OptionError {
		stdout.printf ("Command-line option `%s` is deprecated and will be ignored\n", option_name);
		return true;
	}

	private int quit () {
		if (context.report.get_errors () == 0 && context.report.get_warnings () == 0) {
			return 0;
		}
		if (context.report.get_errors () == 0 && (!fatal_warnings || context.report.get_warnings () == 0)) {
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

	private int run () {
		context = new CodeContext ();
		CodeContext.push (context);

		if (disable_colored_output) {
			colored_output = Report.Colored.NEVER;
		}

		if (colored_output != Report.Colored.NEVER) {
			unowned string env_colors = Environment.get_variable ("VALA_COLORS");
			if (env_colors != null) {
				context.report.set_colors (env_colors, colored_output);
			} else {
				context.report.set_colors (DEFAULT_COLORS, colored_output);
			}
		}


		// default to build executable
		if (!ccode_only && !compile_only && output == null) {
			// strip extension if there is one
			// else we use the default output file of the C compiler
			if (sources[0].last_index_of_char ('.') != -1) {
				int dot = sources[0].last_index_of_char ('.');
				output = Path.get_basename (sources[0].substring (0, dot));
			}
		}

		context.assert = !disable_assert;
		context.checking = enable_checking;
		context.deprecated = deprecated;
		context.since_check = !disable_since_check;
		context.hide_internal = hide_internal;
		context.experimental = experimental;
		context.experimental_non_null = experimental_non_null;
		context.gobject_tracing = gobject_tracing;
		context.keep_going = keep_going;
		context.report.enable_warnings = !disable_warnings;
		context.report.set_verbose_errors (!quiet_mode);
		context.verbose_mode = verbose_mode;
		context.version_header = !disable_version_header;

		context.ccode_only = ccode_only;
		if (ccode_only && cc_options != null) {
			Report.warning (null, "-X has no effect when -C or --ccode is set");
		}
		context.abi_stability = abi_stability;
		context.compile_only = compile_only;
		context.header_filename = header_filename;
		if (header_filename == null && use_header) {
			Report.error (null, "--use-header may only be used in combination with --header");
		}
		context.use_header = use_header;
		context.internal_header_filename = internal_header_filename;
		context.symbols_filename = symbols_filename;
		context.includedir = includedir;
		context.output = output;
		if (output != null && ccode_only) {
			Report.warning (null, "--output and -o have no effect when -C or --ccode is set");
		}
		if (basedir == null) {
			context.basedir = CodeContext.realpath (".");
		} else {
			context.basedir = CodeContext.realpath (basedir);
		}
		if (directory != null) {
			context.directory = CodeContext.realpath (directory);
		} else {
			context.directory = context.basedir;
		}
		context.vapi_directories = vapi_directories;
		context.vapi_comments = vapi_comments;
		context.gir_directories = gir_directories;
		context.metadata_directories = metadata_directories;
		context.debug = debug;
		context.mem_profiler = mem_profiler;
		context.save_temps = save_temps;
		if (ccode_only && save_temps) {
			Report.warning (null, "--save-temps has no effect when -C or --ccode is set");
		}
		if (profile == "posix") {
			context.profile = Profile.POSIX;
			context.add_define ("POSIX");
		} else if (profile == "gobject-2.0" || profile == "gobject" || profile == null) {
			// default profile
			context.profile = Profile.GOBJECT;
			context.add_define ("GOBJECT");
		} else {
			Report.error (null, "Unknown profile %s".printf (profile));
		}
		nostdpkg |= fast_vapi_filename != null;
		context.nostdpkg = nostdpkg;

		context.entry_point_name = entry_point;

		context.run_output = run_output;

		if (pkg_config_command == null) {
			pkg_config_command = Environment.get_variable ("PKG_CONFIG") ?? "pkg-config";
		}
		context.pkg_config_command = pkg_config_command;

		if (defines != null) {
			foreach (string define in defines) {
				context.add_define (define);
			}
		}

		if (context.profile == Profile.POSIX) {
			if (!nostdpkg) {
				/* default package */
				context.add_external_package ("posix");
			}
		} else if (context.profile == Profile.GOBJECT) {
			if (target_glib != null) {
				context.set_target_glib_version (target_glib);
			}

			if (!nostdpkg) {
				/* default packages */
				context.add_external_package ("glib-2.0");
				context.add_external_package ("gobject-2.0");
			}
		}

		if (packages != null) {
			foreach (string package in packages) {
				context.add_external_package (package);
			}
			packages = null;
		}

		if (fast_vapis != null) {
			foreach (string vapi in fast_vapis) {
				var rpath = CodeContext.realpath (vapi);
				var source_file = new SourceFile (context, SourceFileType.FAST, rpath);
				context.add_source_file (source_file);
			}
			context.use_fast_vapi = true;
		}

		context.gresources = gresources;
		context.gresources_directories = gresources_directories;

		if (context.report.get_errors () > 0 || (fatal_warnings && context.report.get_warnings () > 0)) {
			return quit ();
		}

		if (context.profile == Profile.GOBJECT) {
			context.codegen = new GDBusServerModule ();
		} else {
			context.codegen = new CCodeDelegateModule ();
		}

		bool has_c_files = false;
		bool has_h_files = false;

		foreach (string source in sources) {
			if (context.add_source_filename (source, run_output, true)) {
				if (source.has_suffix (".c")) {
					has_c_files = true;
				} else if (source.has_suffix (".h")) {
					has_h_files = true;
				}
			}
		}
		sources = null;
		if (ccode_only && (has_c_files || has_h_files)) {
			Report.warning (null, "C header and source files are ignored when -C or --ccode is set");
		}

		if (context.report.get_errors () > 0 || (fatal_warnings && context.report.get_warnings () > 0)) {
			return quit ();
		}

		if (list_sources) {
			foreach (SourceFile file in context.get_source_files ()) {
				print ("%s\n", file.filename);
			}
			if (!ccode_only) {
				foreach (string filename in context.get_c_source_files ()) {
					print ("%s\n", filename);
				}
			}
			return 0;
		}

		var parser = new Parser ();
		parser.parse (context);

		var genie_parser = new Genie.Parser ();
		genie_parser.parse (context);

		var gir_parser = new GirParser ();
		gir_parser.parse (context);

		if (context.report.get_errors () > 0 || (fatal_warnings && context.report.get_warnings () > 0)) {
			return quit ();
		}

		if (fast_vapi_filename != null) {
			var interface_writer = new CodeWriter (CodeWriterType.FAST);
			interface_writer.write_file (context, fast_vapi_filename);
			return quit ();
		}

		context.check ();

		if (context.report.get_errors () > 0 || (fatal_warnings && context.report.get_warnings () > 0)) {
			return quit ();
		}

		if (!ccode_only && !compile_only && library == null) {
			// building program, require entry point
			if (!has_c_files && context.entry_point == null) {
				Report.error (null, "program does not contain a static `main' method");
			}
		}

		if (dump_tree != null) {
			var code_writer = new CodeWriter (CodeWriterType.DUMP);
			code_writer.write_file (context, dump_tree);
		}

		if (context.report.get_errors () > 0 || (fatal_warnings && context.report.get_warnings () > 0)) {
			return quit ();
		}

		context.codegen.emit (context);

		if (context.report.get_errors () > 0 || (fatal_warnings && context.report.get_warnings () > 0)) {
			return quit ();
		}

		if (vapi_filename == null && library != null) {
			// keep backward compatibility with --library option
			vapi_filename = "%s.vapi".printf (library);
		}

		if (library != null) {
			if (gir != null) {
				if (context.profile == Profile.GOBJECT) {
					string gir_base = Path.get_basename (gir);
					long gir_len = gir_base.length;
					int last_hyphen = gir_base.last_index_of_char ('-');

					if (last_hyphen == -1 || !gir_base.has_suffix (".gir")) {
						Report.error (null, "GIR file name `%s' is not well-formed, expected NAME-VERSION.gir".printf (gir));
					} else {
						string gir_namespace = gir_base.substring (0, last_hyphen);
						string gir_version = gir_base.substring (last_hyphen + 1, gir_len - last_hyphen - 5);
						gir_version.canon ("0123456789.", '?');
						if (gir_namespace == "" || gir_version == "" || !gir_version[0].isdigit () || gir_version.contains ("?")) {
							Report.error (null, "GIR file name `%s' is not well-formed, expected NAME-VERSION.gir".printf (gir));
						} else {
							var gir_writer = new GIRWriter ();

							// put .gir file in current directory unless -d has been explicitly specified
							string gir_directory = ".";
							if (directory != null) {
								gir_directory = context.directory;
							}

							gir_writer.write_file (context, gir_directory, gir, gir_namespace, gir_version, library, shared_library);
						}
					}
				}

				gir = null;
			}

			library = null;
		} else {
			if (gir != null) {
				Report.warning (null, "--gir has no effect without --library");
				gir = null;
			}
		}

		// The GIRWriter places the gir_namespace and gir_version into the top namespace, so write the vapi after that stage
		if (vapi_filename != null) {
			var interface_writer = new CodeWriter ();

			// put .vapi file in current directory unless -d has been explicitly specified
			if (directory != null && !Path.is_absolute (vapi_filename)) {
				vapi_filename = "%s%c%s".printf (context.directory, Path.DIR_SEPARATOR, vapi_filename);
			}

			interface_writer.write_file (context, vapi_filename);
		}

		if (internal_vapi_filename != null) {
			if (internal_header_filename == null ||
			    header_filename == null) {
				Report.error (null, "--internal-vapi may only be used in combination with --header and --internal-header");
				return quit();
			}

			var interface_writer = new CodeWriter (CodeWriterType.INTERNAL);

			if (context.includedir != null) {
				var prefixed_header_filename = Path.build_path ("/", context.includedir, Path.get_basename (header_filename));
				var prefixed_internal_header_filename = Path.build_path ("/", context.includedir, Path.get_basename (internal_header_filename));
				interface_writer.set_cheader_override (prefixed_header_filename, prefixed_internal_header_filename);
			} else {
				interface_writer.set_cheader_override (header_filename, internal_header_filename);
			}

			string vapi_filename = internal_vapi_filename;

			// put .vapi file in current directory unless -d has been explicitly specified
			if (directory != null && !Path.is_absolute (vapi_filename)) {
				vapi_filename = "%s%c%s".printf (context.directory, Path.DIR_SEPARATOR, vapi_filename);
			}

			interface_writer.write_file (context, vapi_filename);

			internal_vapi_filename = null;
		}

		if (dependencies != null) {
			context.write_dependencies (dependencies);
		}

		if (depfile != null) {
			context.write_external_dependencies (depfile);
		}

		if (context.report.get_errors () > 0 || (fatal_warnings && context.report.get_warnings () > 0)) {
			return quit ();
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

	static int run_source (string[] args) {
		try {
			var opt_context = new OptionContext ("- Vala Interpreter");
			opt_context.set_help_enabled (true);
			opt_context.add_main_entries (options, null);
			opt_context.parse (ref args);
		} catch (OptionError e) {
			stdout.printf ("%s\n", e.message);
			stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
			return 1;
		}

		if (version) {
			stdout.printf ("Vala %s\n", Vala.BUILD_VERSION);
			return 0;
		} else if (api_version) {
			stdout.printf ("%s\n", Vala.API_VERSION);
			return 0;
		}

		if (sources == null) {
			stderr.printf ("No source file specified.\n");
			return 1;
		}

		output = "%s/%s.XXXXXX".printf (Environment.get_tmp_dir (), Path.get_basename (sources[0]));
		int outputfd = FileUtils.mkstemp (output);
		if (outputfd < 0) {
			return 1;
		}

		ccode_only = false;
		compile_only = false;
		run_output = true;
		disable_warnings = true;
		quiet_mode = true;
		library = null;
		shared_library = null;

		var compiler = new Compiler ();
		int ret = compiler.run ();
		if (ret != 0) {
			return ret;
		}

		FileUtils.close (outputfd);
		if (FileUtils.chmod (output, 0700) != 0) {
			FileUtils.unlink (output);
			return 1;
		}

		string[] target_args = { output };
		if (run_args != null) {
			string[] target_run_args = run_args.split (" ");
			foreach (string arg in target_run_args) {
				target_args += arg;
			}
		}

		try {
			Pid pid;
			var loop = new MainLoop ();
			int child_status = 0;

			Process.spawn_async (null, target_args, null, SpawnFlags.CHILD_INHERITS_STDIN | SpawnFlags.DO_NOT_REAP_CHILD, null, out pid);

			FileUtils.unlink (output);
			ChildWatch.add (pid, (pid, status) => {
				child_status = (status & 0xff00) >> 8;
				loop.quit ();
			});

			loop.run ();

			return child_status;
		} catch (SpawnError e) {
			stdout.printf ("%s\n", e.message);
			return 1;
		}
	}

	static int main (string[] args) {
		// initialize locale
		Intl.setlocale (LocaleCategory.ALL, "");

		if (Path.get_basename (args[0]) == "vala" || Path.get_basename (args[0]) == "vala" + Config.PACKAGE_SUFFIX) {
			return run_source (args);
		}

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
			stdout.printf ("Vala %s\n", Vala.BUILD_VERSION);
			return 0;
		} else if (api_version) {
			stdout.printf ("%s\n", Vala.API_VERSION);
			return 0;
		}
		
		if (sources == null && fast_vapis == null) {
			stderr.printf ("No source file specified.\n");
			return 1;
		}
		
		var compiler = new Compiler ();
		return compiler.run ();
	}
}
