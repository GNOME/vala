/* valasourcefile.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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

/**
 * Represents a Vala source or VAPI package file.
 */
public class Vala.SourceFile {
	/**
	 * The name of this source file.
	 */
	public string! filename { get; set construct; }
	
	/**
	 * The header comment of this source file.
	 */
	public string comment { get; set; }
	
	/**
	 * Specifies whether this file is a VAPI package file.
	 */
	public bool pkg { get; set; }
	
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

	private List<NamespaceReference> using_directives;

	private List<CodeNode> nodes;
	
	private string cheader_filename = null;
	private string csource_filename = null;
	private string cinclude_filename = null;
	
	private List<string> header_external_includes;
	private List<string> header_internal_includes;
	private List<string> source_external_includes;
	private List<string> source_internal_includes;
	
	private List<weak SourceFile> header_internal_full_dependencies;
	private List<weak SourceFile> header_internal_dependencies;
	
	/**
	 * Creates a new source file.
	 *
	 * @param filename source file name
	 * @param pkg      true if this is a VAPI package file
	 * @return         newly created source file
	 */
	public SourceFile (construct CodeContext! context, construct string! filename, construct bool pkg = false) {
	}
	
	/**
	 * Adds a new using directive with the specified namespace.
	 *
	 * @param ns reference to namespace
	 */
	public void add_using_directive (NamespaceReference! ns) {
		using_directives.append (ns);
	}
	
	/**
	 * Returns a copy of the list of using directives.
	 *
	 * @return using directive list
	 */
	public List<weak NamespaceReference> get_using_directives () {
		return using_directives.copy ();
	}
	
	/**
	 * Adds the specified code node to this source file.
	 *
	 * @param node a code node
	 */
	public void add_node (CodeNode! node) {
		nodes.append (node);
	}
	
	/**
	 * Removes the specified code node from this source file.
	 *
	 * @param node a code node
	 */
	public void remove_node (CodeNode! node) {
		nodes.remove (node);
	}

	/**
	 * Returns a copy of the list of code nodes.
	 *
	 * @return code node list
	 */
	public List<weak CodeNode> get_nodes () {
		return nodes.copy ();
	}

	public void accept (CodeVisitor! visitor) {
		visitor.visit_source_file (this);
	}

	public void accept_children (CodeVisitor! visitor) {
		foreach (NamespaceReference ns_ref in using_directives) {
			ns_ref.accept (visitor);
		}
		
		foreach (CodeNode node in nodes) {
			node.accept (visitor);
		}
	}

	/**
	 * Returns the filename to use when generating C header files.
	 *
	 * @return generated C header filename
	 */
	public string! get_cheader_filename () {
		if (cheader_filename == null) {
			var basename = filename.ndup ((uint) (filename.len () - ".vala".len ()));
			cheader_filename = "%s.h".printf (basename);
		}
		return cheader_filename;
	}
	
	/**
	 * Returns the filename to use when generating C source files.
	 *
	 * @return generated C source filename
	 */
	public string! get_csource_filename () {
		if (csource_filename == null) {
			var basename = filename.ndup ((uint) (filename.len () - ".vala".len ()));
			csource_filename = "%s.c".printf (basename);
		}
		return csource_filename;
	}

	/**
	 * Returns the filename to use when including the generated C header
	 * file.
	 *
	 * @return C header filename to include
	 */
	public string! get_cinclude_filename () {
		if (cinclude_filename == null) {
			var basename = filename.ndup ((uint) (filename.len () - ".vala".len ()));
			if (context.library != null) {
				cinclude_filename = "%s/%s.h".printf (context.library, basename);
			} else {
				cinclude_filename = "%s.h".printf (basename);
			}
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
	public void add_symbol_dependency (Symbol! sym, SourceFileDependencyType dep_type) {
		DataType t;
		
		if (sym is DataType) {
			t = (DataType) sym;
		} else if (sym is Method || sym is Field) {
			if (sym.parent_symbol is DataType) {
				t = (DataType) sym.parent_symbol;
			} else {
				return;
			}
		} else if (sym is Property) {
			t = (DataType) sym.parent_symbol;
		} else if (sym is Constant) {
			if (sym.parent_symbol is DataType) {
				t = (DataType) sym.parent_symbol;
			} else if (sym.parent_symbol is Namespace) {
				var ns = (Namespace) sym.parent_symbol;
				source_internal_includes.concat (ns.get_cheader_filenames ());
				return;
			} else {
				return;
			}
		} else if (sym is FormalParameter) {
			var fp = (FormalParameter) sym;
			t = fp.type_reference.data_type;
			if (t == null) {
				/* generic type parameter */
				return;
			}
		} else {
			return;
		}
		
		if (dep_type == SourceFileDependencyType.SOURCE) {
			if (t.source_reference.file.pkg) {
				source_external_includes.concat (t.get_cheader_filenames ());
			} else {
				source_internal_includes.concat (t.get_cheader_filenames ());
			}
			return;
		}

		if (t.source_reference.file.pkg) {
			/* external package */
			header_external_includes.concat (t.get_cheader_filenames ());
			return;
		}
		
		if (dep_type == SourceFileDependencyType.HEADER_FULL || !t.is_reference_type ()) {
			header_internal_includes.concat (t.get_cheader_filenames ());
			header_internal_full_dependencies.append (t.source_reference.file);
		}

		header_internal_dependencies.append (t.source_reference.file);
	}

	/**
	 * Returns the list of external includes the generated C header file
	 * requires.
	 *
	 * @return external include list for C header file
	 */
	public weak List<string> get_header_external_includes () {
		return header_external_includes;
	}
	
	/**
	 * Adds the specified filename to the list of package-internal includes
	 * the generated C header file requires.
	 *
	 * @param include internal include for C header file
	 */
	public void add_header_internal_include (string! include) {
		/* skip includes to self */
		if (include != get_cinclude_filename ()) {
			header_internal_includes.append (include);
		}
	}
	
	/**
	 * Returns the list of package-internal includes the generated C header
	 * file requires.
	 *
	 * @return internal include list for C header file
	 */
	public weak List<string> get_header_internal_includes () {
		return header_internal_includes;
	}
	
	/**
	 * Returns the list of external includes the generated C source file
	 * requires.
	 *
	 * @return include list for C source file
	 */
	public weak List<string> get_source_external_includes () {
		return source_external_includes;
	}
	
	/**
	 * Returns the list of package-internal includes the generated C source
	 * file requires.
	 *
	 * @return include list for C source file
	 */
	public weak List<string> get_source_internal_includes () {
		return source_internal_includes;
	}
	
	/**
	 * Returns the list of source files the generated C header file requires
	 * definitely.
	 *
	 * @return definite source file dependencies
	 */
	public weak List<SourceFile> get_header_internal_full_dependencies () {
		return header_internal_full_dependencies;
	}
	
	/**
	 * Returns the list of source files the generated C header file loosely
	 * depends on.
	 *
	 * @return loose source file dependencies
	 */
	public weak List<SourceFile> get_header_internal_dependencies () {
		return header_internal_dependencies;
	}
}

public enum Vala.SourceFileDependencyType {
	HEADER_FULL,
	HEADER_SHALLOW,
	SOURCE
}
