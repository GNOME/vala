/* valacodecontext.vala
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
	public string[] vapi_directories;

	/**
	 * List of directories where to find .gir files.
	 */
	public string[] gir_directories;

	/**
	 * List of directories where to find .metadata files for .gir files.
	 */
	public string[] metadata_directories;

	/**
	 * Produce debug information.
	 */
	public bool debug { get; set; }

	/**
	 * Optimization level.
	 */
	public int optlevel { get; set; }

	/**
	 * Enable multithreading support.
	 */
	public bool thread { get; set; }

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

	/**
	 * Target major version number of glib for code generation.
	 */
	public int target_glib_major { get; set; }

	/**
	 * Target minor version number of glib for code generation.
	 */
	public int target_glib_minor { get; set; }

	public bool verbose_mode { get; set; }

	public bool version_header { get; set; }

	public bool nostdpkg { get; set; }

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

	private List<SourceFile> source_files = new ArrayList<SourceFile> ();
	private List<string> c_source_files = new ArrayList<string> ();
	private Namespace _root = new Namespace (null);

	private List<string> packages = new ArrayList<string> (str_equal);

	private Set<string> defines = new HashSet<string> (str_hash, str_equal);

	static StaticPrivate context_stack_key = StaticPrivate ();

	/**
	 * The root namespace of the symbol tree.
	 *
	 * @return root namespace
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

	public CodeContext () {
		resolver = new SymbolResolver ();
		analyzer = new SemanticAnalyzer ();
		flow_analyzer = new FlowAnalyzer ();
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
	 * Returns a copy of the list of source files.
	 *
	 * @return list of source files
	 */
	public List<SourceFile> get_source_files () {
		return source_files;
	}

	/**
	 * Returns a copy of the list of C source files.
	 *
	 * @return list of C source files
	 */
	public List<string> get_c_source_files () {
		return c_source_files;
	}
	
	/**
	 * Adds the specified file to the list of source files.
	 *
	 * @param file a source file
	 */
	public void add_source_file (SourceFile file) {
		source_files.add (file);
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
	 * Returns a copy of the list of used packages.
	 *
	 * @return list of used packages
	 */
	public List<string> get_packages () {
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
			// ignore multiple occurences of the same package
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
	 * @param filename a filanem
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
			} else if (profile == Profile.DOVA) {
				// import the Dova namespace by default (namespace of backend-specific standard library)
				var ns_ref = new UsingDirective (new UnresolvedSymbol (null, "Dova", null));
				source_file.add_using_directive (ns_ref);
				root.add_using_directive (ns_ref);
			}

			add_source_file (source_file);
		} else if (filename.has_suffix (".vapi") || filename.has_suffix (".gir")) {
			var source_file = new SourceFile (this, SourceFileType.PACKAGE, rpath, null, cmdline);
			source_file.relative_filename = filename;

			add_source_file (source_file);
		} else if (filename.has_suffix (".c")) {
			add_c_source_file (rpath);
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

		if (report.get_errors () > 0) {
			return;
		}

		analyzer.analyze (this);

		if (report.get_errors () > 0) {
			return;
		}

		flow_analyzer.analyze (this);
	}

	public void add_define (string define) {
		defines.add (define);
	}

	public bool is_defined (string define) {
		return (define in defines);
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
			foreach (string dir in directories) {
				filename = Path.build_path ("/", dir, basename);
				if (FileUtils.test (filename, FileTest.EXISTS)) {
					return filename;
				}
			}
		}

		if (data_dir != null) {
			foreach (string dir in Environment.get_system_data_dirs ()) {
				filename = Path.build_path ("/", dir, data_dir, basename);
				if (FileUtils.test (filename, FileTest.EXISTS)) {
					return filename;
				}
			}
		}

		if (versioned_data_dir != null) {
			foreach (string dir in Environment.get_system_data_dirs ()) {
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

	private static bool ends_with_dir_separator (string s) {
		return Path.is_dir_separator (s.get_char (s.length - 1));
	}

	/* ported from glibc */
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

				rpath += start.substring (0, len);
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
}
