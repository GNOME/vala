/* valasourcefile.vala
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
 * Represents a Vala source or VAPI package file.
 */
public class Vala.SourceFile {
	/**
	 * The name of this source file.
	 */
	public string filename { get; set; }
	
	/**
	 * The header comment of this source file.
	 */
	public string comment { get; set; }
	
	/**
	 * Specifies whether this file is a VAPI package file.
	 */
	public bool external_package { get; set; }
	
	/**
	 * Specifies the dependency cycle this source file is member of. If this
	 * source file is in a cycle, all type definitions of that cycle will
	 * only be written to the C header file of the cycle head.
	 */
	public SourceFileCycle cycle { get; set; }
	
	/**
	 * Specifies whether this source file is the head of the cycle, if it is
	 * in a cycle at all.
	 */
	public bool is_cycle_head { get; set; }
	
	/**
	 * Mark used for cycle detection.
	 *
	 * 0: not yet visited
	 * 1: currently visiting
	 * 2: already visited
	 */
	public int mark { get; set; }
	
	/**
	 * The context this source file belongs to.
	 */
	public weak CodeContext context { get; set; }

	private Gee.List<UsingDirective> using_directives = new ArrayList<UsingDirective> ();

	private Gee.List<CodeNode> nodes = new ArrayList<CodeNode> ();
	
	private string cheader_filename = null;
	private string csource_filename = null;
	private string cinclude_filename = null;
	
	private Gee.List<string> header_external_includes = new ArrayList<string> ();
	private Gee.List<string> header_internal_includes = new ArrayList<string> ();
	private Gee.List<string> source_external_includes = new ArrayList<string> ();
	private Gee.List<string> source_internal_includes = new ArrayList<string> ();
	
	private Gee.List<weak SourceFile> header_internal_full_dependencies = new ArrayList<weak SourceFile> ();
	private Gee.List<weak SourceFile> header_internal_dependencies = new ArrayList<weak SourceFile> ();

	private Gee.Set<Symbol> source_symbol_dependencies = new HashSet<Symbol> ();

	private Gee.ArrayList<string> source_array = null;

	private MappedFile mapped_file = null;

	/**
	 * Creates a new source file.
	 *
	 * @param filename source file name
	 * @param pkg      true if this is a VAPI package file
	 * @return         newly created source file
	 */
	public SourceFile (CodeContext context, string filename, bool pkg = false) {
		this.filename = filename;
		this.external_package = pkg;
		this.context = context;
	}
	
	/**
	 * Adds a new using directive with the specified namespace.
	 *
	 * @param ns reference to namespace
	 */
	public void add_using_directive (UsingDirective ns) {
		foreach (UsingDirective using_directive in using_directives) {
			if (same_symbol (using_directive.namespace_symbol, ns.namespace_symbol)) {
				// ignore duplicates
				return;
			}
		}
		using_directives.add (ns);
	}

	bool same_symbol (Symbol? sym1, Symbol? sym2) {
		if (sym1 == sym2) {
			return true;
		}

		var unresolved_symbol1 = sym1 as UnresolvedSymbol;
		var unresolved_symbol2 = sym2 as UnresolvedSymbol;
		if (unresolved_symbol1 != null && unresolved_symbol2 != null) {
			if (same_symbol (unresolved_symbol1.inner, unresolved_symbol2.inner)) {
				return (unresolved_symbol1.name == unresolved_symbol2.name);
			}
		}

		return false;
	}

	/**
	 * Returns a copy of the list of using directives.
	 *
	 * @return using directive list
	 */
	public Gee.List<UsingDirective> get_using_directives () {
		return new ReadOnlyList<UsingDirective> (using_directives);
	}
	
	/**
	 * Adds the specified code node to this source file.
	 *
	 * @param node a code node
	 */
	public void add_node (CodeNode node) {
		nodes.add (node);
	}

	public void remove_node (CodeNode node) {
		nodes.remove (node);
	}

	/**
	 * Returns a copy of the list of code nodes.
	 *
	 * @return code node list
	 */
	public Gee.List<CodeNode> get_nodes () {
		return new ReadOnlyList<CodeNode> (nodes);
	}

	public void accept (CodeVisitor visitor) {
		visitor.visit_source_file (this);
	}

	public void accept_children (CodeVisitor visitor) {
		foreach (UsingDirective ns_ref in using_directives) {
			ns_ref.accept (visitor);
		}
		
		foreach (CodeNode node in nodes) {
			node.accept (visitor);
		}
	}

	private string get_subdir () {
		if (context.basedir == null) {
			return "";
		}

		// filename and basedir are already canonicalized
		if (filename.has_prefix (context.basedir)) {
			var basename = Path.get_basename (filename);
			var subdir = filename.substring (context.basedir.len (), filename.len () - context.basedir.len () - basename.len ());
			while (subdir[0] == '/') {
				subdir = subdir.offset (1);
			}
			return subdir;
		}
		return "";
	}

	private string get_destination_directory () {
		if (context.directory == null) {
			return get_subdir ();
		}
		return "%s/%s".printf (context.directory, get_subdir ());
	}

	private string get_basename () {
		long dot = filename.pointer_to_offset (filename.rchr (-1, '.'));
		return Path.get_basename (filename.substring (0, dot));
	}

	public string get_relative_filename () {
		return get_subdir () + Path.get_basename (filename);
	}

	/**
	 * Returns the filename to use when generating C header files.
	 *
	 * @return generated C header filename
	 */
	public string get_cheader_filename () {
		if (cheader_filename == null) {
			cheader_filename = "%s%s.h".printf (get_destination_directory (), get_basename ());
		}
		return cheader_filename;
	}
	
	/**
	 * Returns the filename to use when generating C source files.
	 *
	 * @return generated C source filename
	 */
	public string get_csource_filename () {
		if (csource_filename == null) {
			csource_filename = "%s%s.c".printf (get_destination_directory (), get_basename ());
		}
		return csource_filename;
	}

	/**
	 * Returns the filename to use when including the generated C header
	 * file.
	 *
	 * @return C header filename to include
	 */
	public string get_cinclude_filename () {
		if (cinclude_filename == null) {
			cinclude_filename = "%s%s.h".printf (get_subdir (), get_basename ());
		}
		return cinclude_filename;
	}
	
	/**
	 * Adds the specified symbol to the list of symbols code in this source
	 * file depends on.
	 *
	 * @param sym      a symbol
	 * @param dep_type type of dependency
	 */
	public void add_symbol_dependency (Symbol? sym, SourceFileDependencyType dep_type) {
		if (external_package) {
			return;
		}

		Symbol s;
		
		if (sym is TypeSymbol ||
		    sym is Method ||
		    sym is Field ||
		    sym is Property ||
		    sym is Constant) {
			s = sym;
		} else if (sym is FormalParameter) {
			var fp = (FormalParameter) sym;
			s = fp.parameter_type.data_type;
			if (s == null) {
				/* generic type parameter */
				return;
			}
		} else {
			return;
		}
		
		if (dep_type == SourceFileDependencyType.SOURCE) {
			source_symbol_dependencies.add (s);
			if (s.external_package) {
				foreach (string fn in s.get_cheader_filenames ()) {
					source_external_includes.add (fn);
				}
			} else {
				foreach (string fn in s.get_cheader_filenames ()) {
					source_internal_includes.add (fn);
				}
			}
			return;
		}

		if (s.external_package) {
			/* external package */
			foreach (string fn in s.get_cheader_filenames ()) {
				header_external_includes.add (fn);
			}
			return;
		}
		
		if (dep_type == SourceFileDependencyType.HEADER_FULL || (s is TypeSymbol && !((TypeSymbol)s).is_reference_type ())) {
			foreach (string fn in s.get_cheader_filenames ()) {
				header_internal_includes.add (fn);
			}
			header_internal_full_dependencies.add (s.source_reference.file);
		}

		header_internal_dependencies.add (s.source_reference.file);
	}

	/**
	 * Adds the symbols that define the specified type to the list of
	 * symbols code in this source file depends on.
	 *
	 * @param type     a data type
	 * @param dep_type type of dependency
	 */
	public void add_type_dependency (DataType type, SourceFileDependencyType dep_type) {
		foreach (Symbol type_symbol in type.get_symbols ()) {
			add_symbol_dependency (type_symbol, dep_type);
		}
	}

	/**
	 * Returns the list of external includes the generated C header file
	 * requires.
	 *
	 * @return external include list for C header file
	 */
	public Gee.List<string> get_header_external_includes () {
		return new ReadOnlyList<string> (header_external_includes);
	}
	
	/**
	 * Adds the specified filename to the list of package-internal includes
	 * the generated C header file requires.
	 *
	 * @param include internal include for C header file
	 */
	public void add_header_internal_include (string include) {
		/* skip includes to self */
		if (include != get_cinclude_filename ()) {
			header_internal_includes.add (include);
		}
	}
	
	/**
	 * Returns the list of package-internal includes the generated C header
	 * file requires.
	 *
	 * @return internal include list for C header file
	 */
	public Gee.List<string> get_header_internal_includes () {
		return new ReadOnlyList<string> (header_internal_includes);
	}
	
	/**
	 * Returns the list of external includes the generated C source file
	 * requires.
	 *
	 * @return include list for C source file
	 */
	public Gee.List<string> get_source_external_includes () {
		return new ReadOnlyList<string> (source_external_includes);
	}
	
	/**
	 * Returns the list of package-internal includes the generated C source
	 * file requires.
	 *
	 * @return include list for C source file
	 */
	public Gee.List<string> get_source_internal_includes () {
		return new ReadOnlyList<string> (source_internal_includes);
	}
	
	/**
	 * Returns the list of source files the generated C header file requires
	 * definitely.
	 *
	 * @return definite source file dependencies
	 */
	public Gee.List<weak SourceFile> get_header_internal_full_dependencies () {
		return new ReadOnlyList<weak SourceFile> (header_internal_full_dependencies);
	}
	
	/**
	 * Returns the list of source files the generated C header file loosely
	 * depends on.
	 *
	 * @return loose source file dependencies
	 */
	public Gee.List<weak SourceFile> get_header_internal_dependencies () {
		return new ReadOnlyList<weak SourceFile> (header_internal_dependencies);
	}

	public Gee.Set<Symbol> get_source_symbol_dependencies () {
		return new ReadOnlySet<Symbol> (source_symbol_dependencies);
	}

	/**
	 * Returns the requested line from this file, loading it if needed.
	 *
	 * @param lineno 1-based line number
	 * @return       the specified source line
	 */
	public string? get_source_line (int lineno) {
		if (source_array == null) {
			read_source_file ();
		}
		if (lineno < 1 || lineno > source_array.size) {
			return null;
		}
		return source_array.get (lineno - 1);
	}

	/**
	 * Parses the input file into ::source_array.
	 */
	private void read_source_file () {
		string cont;
		source_array = new Gee.ArrayList<string> ();
		try {
			FileUtils.get_contents (filename, out cont);
		} catch (FileError fe) {
			return;
		}
		string[] lines = cont.split ("\n", 0);
		uint idx;
		for (idx = 0; lines[idx] != null; ++idx) {
			source_array.add (lines[idx]);
		}
	}

	public char* get_mapped_contents () {
		if (mapped_file == null) {
			try {
				mapped_file = new MappedFile (filename, false);
			} catch (FileError e) {
				Report.error (null, "Unable to map file `%s': %s".printf (filename, e.message));
				return null;
			}
		}

		return mapped_file.get_contents ();
	}
	
	public size_t get_mapped_length () {
		return mapped_file.get_length ();
	}
}

public enum Vala.SourceFileDependencyType {
	HEADER_FULL,
	HEADER_SHALLOW,
	SOURCE
}
