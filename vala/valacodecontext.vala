/* valacodecontext.vala
 *
 * Copyright (C) 2006-2012  Jürg Billeter
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

/**
 * The root of the code tree.
 */
public class Vala.CodeContext {
	/**
	 * Enable run-time checks for programming errors.
	 */
	public bool assert { get; set; }

	/**
	 * Enable additional run-time checks such as type checks.
	 */
	public bool checking { get; set; }

	/**
	 * Do not warn when using deprecated features.
	 */
	public bool deprecated { get; set; }

	/**
	 * Hide the symbols marked as internal
	 */
	public bool hide_internal { get; set; }

	/**
	 * Do not check whether used symbols exist in local packages.
	 */
	public bool since_check { get; set; }

	/**
	 * Do not warn when using experimental features.
	 */
	public bool experimental { get; set; }

	/**
	 * Enable experimental enhancements for non-null types.
	 */
	public bool experimental_non_null { get; set; }

	/**
	 * Enable GObject creation tracing.
	 */
	public bool gobject_tracing { get; set; }

	/**
	 * Output C code, don't compile to object code.
	 */
	public bool ccode_only { get; set; }

	/**
	 * Command to run pkg-config.
	 */
	public string pkg_config_command { get; set; default = "pkg-config"; }

	/**
	 * Enable support for ABI stability.
	 */
	public bool abi_stability { get; set; }

	/**
	 * Output C header file.
	 */
	public string? header_filename { get; set; }

	/**
	 * Output internal C header file.
	 */
	public string? internal_header_filename { get; set; }

	public bool use_header { get; set; }

	/**
	 * Base directory used for header_filename in the VAPIs.
	 */
	public string? includedir { get; set; }

	/**
	 * Output symbols file.
	 */
	public string? symbols_filename { get; set; }

	/**
	 * Compile but do not link.
	 */
	public bool compile_only { get; set; }

	/**
	 * Output filename.
	 */
	public string output { get; set; }

	/**
	 * Base source directory.
	 */
	public string basedir { get; set; }

	/**
	 * Code output directory.
	 */
	public string directory { get; set; }

	/**
	 * List of directories where to find .vapi files.
	 */
	public string[] vapi_directories { get; set; default = {}; }

	/**
	 * List of directories where to find .gir files.
	 */
	public string[] gir_directories { get; set; default = {}; }

	/**
	 * List of directories where to find .metadata files for .gir files.
	 */
	public string[] metadata_directories { get; set; default = {}; }

	/**
	 * Produce debug information.
	 */
	public bool debug { get; set; }

	/**
	 * Optimization level.
	 */
	public int optlevel { get; set; }

	/**
	 * Enable memory profiler.
	 */
	public bool mem_profiler { get; set; }

	/**
	 * Specifies the optional module initialization method.
	 */
	public Method module_init_method { get; set; }

	/**
	 * Keep temporary files produced by the compiler.
	 */
	public bool save_temps { get; set; }

	public Profile profile { get; set; }

	public bool verbose_mode { get; set; }

	public bool version_header { get; set; }

	public bool nostdpkg { get; set; }

	public bool use_fast_vapi { get; set; }

	/**
	 * Continue as much as possible after an error.
	 */
	public bool keep_going { get; set; }

	/**
	 * Include comments in generated vapi.
	 */
	public bool vapi_comments { get; set; }

	/**
	 * Returns true if the target version of glib is greater than or
	 * equal to the specified version.
	 */
	public bool require_glib_version (int major, int minor) {
		return (target_glib_major > major) || (target_glib_major == major && target_glib_minor >= minor);
	}

	public bool save_csources {
		get { return save_temps; }
	}

	public Report report { get; set; default = new Report ();}

	public Method? entry_point { get; set; }

	public string entry_point_name { get; set; }

	public bool run_output { get; set; }

	public string[] gresources { get; set; default = {}; }

	public string[] gresources_directories { get; set; default = {}; }

	private List<SourceFile> source_files = new ArrayList<SourceFile> ();
	private Map<string,unowned SourceFile> source_files_map = new HashMap<string,unowned SourceFile> (str_hash, str_equal);
	private List<string> c_source_files = new ArrayList<string> ();
	private Namespace _root = new Namespace (null);

	private List<string> packages = new ArrayList<string> (str_equal);

	private Set<string> defines = new HashSet<string> (str_hash, str_equal);

	static StaticPrivate context_stack_key = StaticPrivate ();

	int target_glib_major;
	int target_glib_minor;

	/**
	 * The root namespace of the symbol tree.
	 */
	public Namespace root {
		get { return _root; }
	}

	public SymbolResolver resolver { get; private set; }

	public SemanticAnalyzer analyzer { get; private set; }

	public FlowAnalyzer flow_analyzer { get; private set; }

	/**
	 * The selected code generator.
	 */
	public CodeGenerator codegen { get; set; }

	/**
	 * Mark attributes used by the compiler and report unused at the end.
	 */
	public UsedAttr used_attr { get; set; }

	public CodeContext () {
		add_default_defines ();

		resolver = new SymbolResolver ();
		analyzer = new SemanticAnalyzer ();
		flow_analyzer = new FlowAnalyzer ();
		used_attr = new UsedAttr ();
	}

	/**
	 * Return the topmost context from the context stack.
	 */
	public static CodeContext get () {
		List<CodeContext>* context_stack = context_stack_key.get ();

		return context_stack->get (context_stack->size - 1);
	}

	/**
	 * Push the specified context to the context stack.
	 */
	public static void push (CodeContext context) {
		ArrayList<CodeContext>* context_stack = context_stack_key.get ();
		if (context_stack == null) {
			context_stack = new ArrayList<CodeContext> ();
			context_stack_key.set (context_stack, null);
		}

		context_stack->add (context);
	}

	/**
	 * Remove the topmost context from the context stack.
	 */
	public static void pop () {
		List<CodeContext>* context_stack = context_stack_key.get ();

		context_stack->remove_at (context_stack->size - 1);
	}

	/**
	 * Returns the list of source files.
	 *
	 * @return list of source files
	 */
	public unowned List<SourceFile> get_source_files () {
		return source_files;
	}

	/**
	 * Returns the list of C source files.
	 *
	 * @return list of C source files
	 */
	public unowned List<string> get_c_source_files () {
		return c_source_files;
	}

	/**
	 * Adds the specified file to the list of source files.
	 *
	 * @param file a source file
	 */
	public void add_source_file (SourceFile file) {
		if (source_files_map.contains (file.filename)) {
			Report.warning (null, "Ignoring source file `%s', which was already added to this context".printf (file.filename));
			return;
		}

		source_files.add (file);
		source_files_map.set (file.filename, file);
	}

	/**
	 * Returns the source file for a given path.
	 *
	 * @param filename a path to a source file
	 * @return the source file if found
	 */
	public unowned Vala.SourceFile? get_source_file (string filename) {
		return source_files_map.get (filename);
	}

	/**
	 * Adds the specified file to the list of C source files.
	 *
	 * @param file a C source file
	 */
	public void add_c_source_file (string file) {
		c_source_files.add (file);
	}

	/**
	 * Returns the list of used packages.
	 *
	 * @return list of used packages
	 */
	public unowned List<string> get_packages () {
		return packages;
	}

	/**
	 * Returns whether the specified package is being used.
	 *
	 * @param pkg a package name
	 * @return    true if the specified package is being used
	 */
	public bool has_package (string pkg) {
		return packages.contains (pkg);
	}

	/**
	 * Adds the specified package to the list of used packages.
	 *
	 * @param pkg a package name
	 */
	public void add_package (string pkg) {
		packages.add (pkg);
	}

	/**
	 * Pull the specified package into the context.
	 * The method is tolerant if the package has been already loaded.
	 *
	 * @param pkg a package name
	 * @return false if the package could not be loaded
	 *
	 */
	public bool add_external_package (string pkg) {
		if (has_package (pkg)) {
			// ignore multiple occurrences of the same package
			return true;
		}

		// first try .vapi
		var path = get_vapi_path (pkg);
		if (path == null) {
			// try with .gir
			path = get_gir_path (pkg);
		}
		if (path == null) {
			Report.error (null, "Package `%s' not found in specified Vala API directories or GObject-Introspection GIR directories".printf (pkg));
			return false;
		}

		add_package (pkg);

		add_source_file (new SourceFile (this, SourceFileType.PACKAGE, path));

		if (verbose_mode) {
			stdout.printf ("Loaded package `%s'\n", path);
		}

		var deps_filename = Path.build_path ("/", Path.get_dirname (path), pkg + ".deps");
		if (!add_packages_from_file (deps_filename)) {
			return false;
		}

		return true;
	}

	/**
	 * Read the given filename and pull in packages.
	 * The method is tolerant if the file does not exist.
	 *
	 * @param filename a filename
	 * @return false if an error occurs while reading the file or if a package could not be added
	 */
	public bool add_packages_from_file (string filename) {
		if (!FileUtils.test (filename, FileTest.EXISTS)) {
			return true;
		}

		try {
			string contents;
			FileUtils.get_contents (filename, out contents);
			foreach (string package in contents.split ("\n")) {
				package = package.strip ();
				if (package != "") {
					add_external_package (package);
				}
			}
		} catch (FileError e) {
			Report.error (null, "Unable to read dependency file: %s".printf (e.message));
			return false;
		}

		return true;
	}

	/**
	 * Add the specified source file to the context. Only .vala, .vapi, .gs,
	 * and .c extensions are supported.
	 *
	 * @param filename a filename
	 * @param is_source true to force adding the file as .vala or .gs
	 * @param cmdline true if the file came from the command line.
	 * @return false if the file is not recognized or the file does not exist
	 */
	public bool add_source_filename (string filename, bool is_source = false, bool cmdline = false) {
		if (!FileUtils.test (filename, FileTest.EXISTS)) {
			Report.error (null, "%s not found".printf (filename));
			return false;
		}

		var rpath = realpath (filename);
		if (is_source || filename.has_suffix (".vala") || filename.has_suffix (".gs")) {
			var source_file = new SourceFile (this, SourceFileType.SOURCE, rpath, null, cmdline);
			source_file.relative_filename = filename;

			if (profile == Profile.POSIX) {
				// import the Posix namespace by default (namespace of backend-specific standard library)
				var ns_ref = new UsingDirective (new UnresolvedSymbol (null, "Posix", null));
				source_file.add_using_directive (ns_ref);
				root.add_using_directive (ns_ref);
			} else if (profile == Profile.GOBJECT) {
				// import the GLib namespace by default (namespace of backend-specific standard library)
				var ns_ref = new UsingDirective (new UnresolvedSymbol (null, "GLib", null));
				source_file.add_using_directive (ns_ref);
				root.add_using_directive (ns_ref);
			}

			add_source_file (source_file);
			if (rpath != filename) {
				source_files_map.set (filename, source_file);
			}
		} else if (filename.has_suffix (".vapi") || filename.has_suffix (".gir")) {
			var source_file = new SourceFile (this, SourceFileType.PACKAGE, rpath, null, cmdline);
			source_file.relative_filename = filename;

			add_source_file (source_file);
			if (rpath != filename) {
				source_files_map.set (filename, source_file);
			}
		} else if (filename.has_suffix (".c")) {
			add_c_source_file (rpath);
		} else if (filename.has_suffix (".h")) {
			/* Ignore */
		} else {
			Report.error (null, "%s is not a supported source file type. Only .vala, .vapi, .gs, and .c files are supported.".printf (filename));
			return false;
		}

		return true;
	}

	/**
	 * Visits the complete code tree file by file.
	 * It is possible to add new source files while visiting the tree.
	 *
	 * @param visitor the visitor to be called when traversing
	 */
	public void accept (CodeVisitor visitor) {
		root.accept (visitor);

		// support queueing new source files
		int index = 0;
		while (index < source_files.size) {
			var source_file = source_files[index];
			source_file.accept (visitor);
			index++;
		}
	}

	/**
	 * Resolve and analyze.
	 */
	public void check () {
		resolver.resolve (this);

		if (!keep_going && report.get_errors () > 0) {
			return;
		}

		analyzer.analyze (this);

		if (!keep_going && report.get_errors () > 0) {
			return;
		}

		flow_analyzer.analyze (this);

		if (report.get_errors () > 0) {
			return;
		}

		used_attr.check_unused (this);
	}

	public void add_define (string define) {
		if (is_defined (define)) {
			Report.warning (null, "`%s' is already defined".printf (define));
			if (/VALA_0_\d+/.match_all (define)) {
				Report.warning (null, "`VALA_0_XX' defines are automatically added up to current compiler version in use");
			} else if (/GLIB_2_\d+/.match_all (define)) {
				Report.warning (null, "`GLIB_2_XX' defines are automatically added up to targeted glib version");
			}
		}
		defines.add (define);
	}

	public bool is_defined (string define) {
		return (define in defines);
	}

	void add_default_defines () {
		int api_major = 0;
		int api_minor = 0;

		if (API_VERSION.scanf ("%d.%d", out api_major, out api_minor) != 2
		    || api_major > 0
		    || api_minor % 2 != 0) {
			Report.error (null, "Invalid format for Vala.API_VERSION");
			return;
		}

		for (int i = 2; i <= api_minor; i += 2) {
			defines.add ("VALA_0_%d".printf (i));
		}

		target_glib_major = 2;
		target_glib_minor = 48;

		for (int i = 16; i <= target_glib_minor; i += 2) {
			defines.add ("GLIB_2_%d".printf (i));
		}
	}

	/**
	 * Set the target version of glib for code generation.
	 *
	 * This may be called once or not at all.
	 *
	 * @param target_glib a string of the format "%d.%d"
	 */
	public void set_target_glib_version (string target_glib) {
		int glib_major = 0;
		int glib_minor = 0;

		if (target_glib == "auto") {
			var available_glib = pkg_config_modversion ("glib-2.0");
			if (available_glib != null && available_glib.scanf ("%d.%d", out glib_major, out glib_minor) >= 2) {
				glib_minor -= ++glib_minor % 2;
				set_target_glib_version ("%d.%d".printf (glib_major, glib_minor));
				return;
			}
		}

		glib_major = target_glib_major;
		glib_minor = target_glib_minor;

		if (target_glib != null && target_glib.scanf ("%d.%d", out glib_major, out glib_minor) != 2
		    || glib_minor % 2 != 0) {
			Report.error (null, "Only a stable version of GLib can be targeted, use MAJOR.MINOR format with MINOR as an even number");
		}

		if (glib_major != 2) {
			Report.error (null, "This version of valac only supports GLib 2");
		}

		if (glib_minor <= target_glib_minor) {
			// no additional defines needed
			return;
		}

		for (int i = target_glib_major + 2; i <= glib_minor; i += 2) {
			defines.add ("GLIB_2_%d".printf (i));
		}

		target_glib_major = glib_major;
		target_glib_minor = glib_minor;
	}

	public string? get_vapi_path (string pkg) {
		var path = get_file_path (pkg + ".vapi", "vala" + Config.PACKAGE_SUFFIX + "/vapi", "vala/vapi", vapi_directories);

		if (path == null) {
			/* last chance: try the package compiled-in vapi dir */
			var filename = Path.build_path ("/", Config.PACKAGE_DATADIR, "vapi", pkg + ".vapi");
			if (FileUtils.test (filename, FileTest.EXISTS)) {
				path = filename;
			}
		}

		return path;
	}

	public string? get_gir_path (string gir) {
		return get_file_path (gir + ".gir", "gir-1.0", null, gir_directories);
	}

	public string? get_gresource_path (string gresource, string resource) {
		var filename = get_file_path (resource, null, null, { Path.get_dirname (gresource) });
		if (filename == null) {
			filename = get_file_path (resource, null, null, gresources_directories);
		}
		return filename;
	}

	/*
	 * Returns the .metadata file associated with the given .gir file.
	 */
	public string? get_metadata_path (string gir_filename) {
		var basename = Path.get_basename (gir_filename);
		var metadata_basename = "%s.metadata".printf (basename.substring (0, basename.length - ".gir".length));

		// look into metadata directories
		var metadata_filename = get_file_path (metadata_basename, null, null, metadata_directories);
		if (metadata_filename != null) {
			return metadata_filename;
		}

		// look into the same directory of .gir
		metadata_filename = Path.build_path ("/", Path.get_dirname (gir_filename), metadata_basename);
		if (FileUtils.test (metadata_filename, FileTest.EXISTS)) {
			return metadata_filename;
		}

		return null;
	}

	string? get_file_path (string basename, string? versioned_data_dir, string? data_dir, string[] directories) {
		string filename = null;

		if (directories != null) {
			foreach (unowned string dir in directories) {
				filename = Path.build_path ("/", dir, basename);
				if (FileUtils.test (filename, FileTest.EXISTS)) {
					return filename;
				}
			}
		}

		if (data_dir != null) {
			foreach (unowned string dir in Environment.get_system_data_dirs ()) {
				filename = Path.build_path ("/", dir, data_dir, basename);
				if (FileUtils.test (filename, FileTest.EXISTS)) {
					return filename;
				}
			}
		}

		if (versioned_data_dir != null) {
			foreach (unowned string dir in Environment.get_system_data_dirs ()) {
				filename = Path.build_path ("/", dir, versioned_data_dir, basename);
				if (FileUtils.test (filename, FileTest.EXISTS)) {
					return filename;
				}
			}
		}

		return null;
	}

	public void write_dependencies (string filename) {
		var stream = FileStream.open (filename, "w");

		if (stream == null) {
			Report.error (null, "unable to open `%s' for writing".printf (filename));
			return;
		}

		stream.printf ("%s:", filename);
		foreach (var src in source_files) {
			if (src.file_type == SourceFileType.FAST && src.used) {
				stream.printf (" %s", src.filename);
			}
		}
		stream.printf ("\n\n");
	}

	public void write_external_dependencies (string filename) {
		var stream = FileStream.open (filename, "w");

		if (stream == null) {
			Report.error (null, "unable to open `%s' for writing".printf (filename));
			return;
		}

		bool first = true;
		foreach (var src in source_files) {
			if (src.file_type != SourceFileType.SOURCE && src.used) {
				if (first) {
					first = false;
					stream.printf ("%s: ", filename);
				} else {
					stream.puts (" \\\n\t");
				}
				stream.printf ("%s", src.filename);
			}
		}
		stream.puts ("\n\n");
	}

	private static bool ends_with_dir_separator (string s) {
		return Path.is_dir_separator (s.get_char (s.length - 1));
	}

	/**
	 * Returns canonicalized absolute pathname
	 * ported from glibc
	 *
	 * @param name the path being checked
	 * @return a canonicalized absolute pathname
	 */
	public static string realpath (string name) {
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
			rpath = name.substring (0, (int) ((char*) start - (char*) name));
		}

		long root_len = (long) ((char*) Path.skip_root (rpath) - (char*) rpath);

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
				if (rpath.length > root_len) {
					do {
						rpath = rpath.substring (0, rpath.length - 1);
					} while (!ends_with_dir_separator (rpath));
				}
			} else {
				if (!ends_with_dir_separator (rpath)) {
					rpath += Path.DIR_SEPARATOR_S;
				}

				// don't use len, substring works on bytes
				rpath += start.substring (0, (long)((char*)end - (char*)start));
			}
		}

		if (rpath.length > root_len && ends_with_dir_separator (rpath)) {
			rpath = rpath.substring (0, rpath.length - 1);
		}

		if (Path.DIR_SEPARATOR != '/') {
			// don't use backslashes internally,
			// to avoid problems in #include directives
			string[] components = rpath.split ("\\");
			rpath = string.joinv ("/", components);
		}

		return rpath;
	}

	public bool pkg_config_exists (string package_name) {
		string pc = pkg_config_command + " --exists " + package_name;
		int exit_status;

		try {
			Process.spawn_command_line_sync (pc, null, null, out exit_status);
			return (0 == exit_status);
		} catch (SpawnError e) {
			Report.error (null, e.message);
			return false;
		}
	}

	public string? pkg_config_modversion (string package_name) {
		string pc = pkg_config_command + " --silence-errors --modversion " + package_name;
		string? output = null;
		int exit_status;

		try {
			Process.spawn_command_line_sync (pc, out output, null, out exit_status);
			if (exit_status != 0) {
				output = output[0:-1];
				if (output == "") {
					output = null;
				}
			}
		} catch (SpawnError e) {
			output = null;
		}

		return output;
	}

	public string? pkg_config_compile_flags (string package_name) {
		string pc = pkg_config_command + " --cflags";
		if (!compile_only) {
			pc += " --libs";
		}
		pc += package_name;

		string? output = null;
		int exit_status;

		try {
			Process.spawn_command_line_sync (pc, out output, null, out exit_status);
			if (exit_status != 0) {
				Report.error (null, "%s exited with status %d".printf (pkg_config_command, exit_status));
				return null;
			}
		} catch (SpawnError e) {
			Report.error (null, e.message);
			output = null;
		}

		return output;
	}
}
