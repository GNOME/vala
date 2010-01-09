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
	 * Enable transformation of D-Bus member names in dynamic client support.
	 */
	public bool dbus_transformation { get; set; }

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

	/**
	 * The selected code generator.
	 */
	public CodeGenerator codegen { get; set; default = new CodeGenerator (); }

	public CodeContext () {
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
		List<CodeContext>* context_stack = context_stack_key.get ();
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
		return new ReadOnlyList<SourceFile> (source_files);
	}

	/**
	 * Returns a copy of the list of C source files.
	 *
	 * @return list of C source files
	 */
	public List<string> get_c_source_files () {
		return new ReadOnlyList<string> (c_source_files);
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
		return new ReadOnlyList<string> (packages);
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
	 * Visits the complete code tree file by file.
	 *
	 * @param visitor the visitor to be called when traversing
	 */
	public void accept (CodeVisitor visitor) {
		root.accept (visitor);

		foreach (SourceFile file in source_files) {
			file.accept (visitor);
		}
	}

	public void add_define (string define) {
		defines.add (define);
	}

	public bool is_defined (string define) {
		return (define in defines);
	}

	public string? get_package_path (string pkg, string[] directories) {
		var path = get_file_path (pkg + ".vapi", "vala/vapi", directories);

		if (path == null) {
			/* last chance: try the package compiled-in vapi dir */
			var filename = Path.build_filename (Config.PACKAGE_DATADIR, "vapi", pkg + ".vapi");
			if (FileUtils.test (filename, FileTest.EXISTS)) {
				path = filename;
			}
		}

		return path;
	}

	public string? get_gir_path (string gir, string[] directories) {
		return get_file_path (gir + ".gir", "gir-1.0", directories);
	}

	string? get_file_path (string basename, string data_dir, string[] directories) {
		string filename = null;

		if (directories != null) {
			foreach (string dir in directories) {
				filename = Path.build_filename (dir, basename);
				if (FileUtils.test (filename, FileTest.EXISTS)) {
					return filename;
				}
			}
		}

		foreach (string dir in Environment.get_system_data_dirs ()) {
			filename = Path.build_filename (dir, data_dir, basename);
			if (FileUtils.test (filename, FileTest.EXISTS)) {
				return filename;
			}
		}

		return null;
	}
}
