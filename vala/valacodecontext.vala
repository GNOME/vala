/* valacodecontext.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
using Gee;

/**
 * The root of the code tree.
 */
public class Vala.CodeContext : Object {
	/**
	 * Specifies the name of the library to be built.
	 *
	 * Public header files of a library will be assumed to be installed in
	 * a subdirectory named like the library.
	 */
	public string library { get; set; }

	/**
	 * Enable automatic memory management.
	 */
	public bool memory_management { get; set; }

	/**
	 * Enable run-time checks for programming errors.
	 */
	public bool assert { get; set; }

	/**
	 * Enable additional run-time checks.
	 */
	public bool checking { get; set; }

	/**
	 * Enable non-null types.
	 */
	public bool non_null { get; set; }

	/**
	 * Enable experimental enhancements for non-null types.
	 */
	public bool non_null_experimental { get; set; }

	/**
	 * Output C code, don't compile to object code.
	 */
	public bool ccode_only { get; set; }

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
	 * Specifies the optional module initialization method.
	 */
	public Method module_init_method { get; set; }

	/**
	 * Keep temporary files produced by the compiler.
	 */
	public bool save_temps { get; set; }

	public bool save_csources {
		get { return save_temps; }
	}

	public bool save_cheaders {
		get { return save_csources || null != library; }
	}

	private Gee.List<SourceFile> source_files = new ArrayList<SourceFile> ();
	private Gee.List<string> c_source_files = new ArrayList<string> ();
	private Namespace _root = new Namespace (null);
	
	private Gee.List<SourceFileCycle> cycles = new ArrayList<SourceFileCycle> ();

	private Gee.List<string> packages = new ArrayList<string> (str_equal);

	private Gee.List<string> defines = new ArrayList<string> (str_equal);

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
	public CodeGenerator codegen { get; set; }

	public CodeContext () {
	}

	construct {
		codegen = new CodeGenerator ();
	}

	/**
	 * Returns a copy of the list of source files.
	 *
	 * @return list of source files
	 */
	public Collection<SourceFile> get_source_files () {
		return new ReadOnlyCollection<SourceFile> (source_files);
	}

	/**
	 * Returns a copy of the list of C source files.
	 *
	 * @return list of C source files
	 */
	public Collection<string> get_c_source_files () {
		return new ReadOnlyCollection<string> (c_source_files);
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
	public Collection<string> get_packages () {
		return new ReadOnlyCollection<string> (packages);
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
	
	/**
	 * Find and resolve cycles in source file dependencies.
	 */
	public void find_header_cycles () {
		/* find cycles in dependencies between source files */
		foreach (SourceFile file in source_files) {
			/* we're only interested in internal source files */
			if (file.pkg) {
				continue;
			}
			
			if (file.mark == 0) {
				visit (file, new ArrayList<SourceFile> ());
			}
		}
		
		/* find one head for each cycle, it must not have any
		 * hard dependencies on other files in the cycle
		 */
		foreach (SourceFileCycle cycle in cycles) {
			cycle.head = find_cycle_head (cycle.files.get (0));
			cycle.head.is_cycle_head = true;
		}

		/* connect the source files in a non-cyclic way
		 * cycle members connect to the head of their cycle
		 */
		foreach (SourceFile file2 in source_files) {
			/* we're only interested in internal source files */
			if (file2.pkg) {
				continue;
			}

			foreach (SourceFile dep in file2.get_header_internal_dependencies ()) {
				if (file2.cycle != null && dep.cycle == file2.cycle) {
					/* in the same cycle */
					if (!file2.is_cycle_head) {
						/* include header of cycle head */
						file2.add_header_internal_include (file2.cycle.head.get_cinclude_filename ());
					}
				} else {
					/* we can just include the headers if they are not in a cycle or not in the same cycle as the current file */
					file2.add_header_internal_include (dep.get_cinclude_filename ());
				}
			}
		}
		
	}
	
	private weak SourceFile find_cycle_head (SourceFile file) {
		foreach (SourceFile dep in file.get_header_internal_full_dependencies ()) {
			if (dep == file) {
				/* ignore file-internal dependencies */
				continue;
			}
			
			foreach (SourceFile cycle_file in file.cycle.files) {
				if (dep == cycle_file) {
					return find_cycle_head (dep);
				}
			}
		}
		/* no hard dependencies on members of the same cycle found
		 * source file suitable as cycle head
		 */
		return file;
	}
	
	private void visit (SourceFile file, Collection<SourceFile> chain) {
		Gee.List<SourceFile> l = new ArrayList<SourceFile> ();
		foreach (SourceFile chain_file in chain) {
			l.add (chain_file);
		}
		l.add (file);

		/* mark file as currently being visited */
		file.mark = 1;
		
		foreach (SourceFile dep in file.get_header_internal_dependencies ()) {
			if (file == dep) {
				continue;
			}
			
			if (dep.mark == 1) {
				/* found cycle */
				
				var cycle = new SourceFileCycle ();
				cycles.add (cycle);
				
				bool cycle_start_found = false;
				foreach (SourceFile cycle_file in l) {
					SourceFileCycle ref_cycle_file_cycle = cycle_file.cycle;
					if (!cycle_start_found) {
						if (cycle_file == dep) {
							cycle_start_found = true;
						}
					}
					
					if (!cycle_start_found) {
						continue;
					}
					
					if (cycle_file.cycle != null) {
						/* file already in a cycle */
						
						if (cycle_file.cycle == cycle) {
							/* file is in the same cycle, nothing to do */
							continue;
						}
						
						/* file is in an other cycle, merge the two cycles */
						
						cycles.remove (cycle_file.cycle);
						
						foreach (SourceFile inner_cycle_file in cycle_file.cycle.files) {
							if (inner_cycle_file.cycle != cycle) {
								/* file in inner cycle not yet added to outer cycle */
								cycle.files.add (inner_cycle_file);
								inner_cycle_file.cycle = cycle;
							}
						}
					} else {
						cycle.files.add (cycle_file);
						cycle_file.cycle = cycle;
					}
				}
			} else if (dep.mark == 0) {
				/* found not yet visited file */
				
				visit (dep, l);
			}
		}
		
		/* mark file as successfully visited */
		file.mark = 2;
	}

	public void add_define (string define) {
		defines.add (define);
	}

	public bool ignore_node (CodeNode node) {
		var attr = node.get_attribute ("Conditional");
		if (attr == null) {
			return false;
		} else {
			var condition = attr.get_string ("condition");
			if (condition == null) {
				return false;
			} else {
				return !defines.contains (condition);
			}
		}
	}

	public string? get_package_path (string pkg, [CCode (array_length_pos = 1.9)] string[] vapi_directories) {
		string basename = "%s.vapi".printf (pkg);
		string filename = null;

		if (vapi_directories != null) {
			foreach (string vapidir in vapi_directories) {
				filename = Path.build_filename (vapidir, basename);
				if (FileUtils.test (filename, FileTest.EXISTS)) {
					return filename;
				}
			}
		}

		filename = Path.build_filename (Config.PACKAGE_DATADIR, "vapi", basename);
		if (FileUtils.test (filename, FileTest.EXISTS)) {
			return filename;
		}

		foreach (string vapidir in Environment.get_system_data_dirs ()) {
			filename = Path.build_filename (vapidir, "vala/vapi", basename);
			if (FileUtils.test (filename, FileTest.EXISTS)) {
				return filename;
			}
		}

		return null;
	}
}
