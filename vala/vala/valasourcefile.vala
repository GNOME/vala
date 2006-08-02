/* valasourcefile.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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
	
	private List<NamespaceReference> using_directives;

	private Namespace global_namespace;
	private List<Namespace> namespaces;
	
	private string cheader_filename = null;
	
	private string csource_filename = null;
	
	private List<weak string> header_external_includes;
	private List<weak string> header_internal_includes;
	private List<weak string> source_includes;
	
	private List<weak SourceFile> header_internal_full_dependencies;
	private List<weak SourceFile> header_internal_dependencies;
	
	/**
	 * Creates a new source file.
	 *
	 * @param filename source file name
	 * @param pkg      true if this is a VAPI package file
	 * @return         newly created source file
	 */
	public construct (string! _filename, bool _pkg =  false) {
		filename = _filename;
		pkg = _pkg;
	}
	
	SourceFile () {
		global_namespace = new Namespace (null, new SourceReference (this));
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
	public ref List<NamespaceReference> get_using_directives () {
		return using_directives.copy ();
	}
	
	/**
	 * Adds the specified namespace to this source file.
	 *
	 * @param ns a namespace
	 */
	public void add_namespace (Namespace! ns) {
		namespaces.append (ns);
	}

	/**
	 * Returns the implicitly declared root namespace of this source file.
	 *
	 * @return root namespace
	 */
	public Namespace! get_global_namespace () {
		return global_namespace;
	}
	
	/**
	 * Returns a copy of the list of namespaces.
	 *
	 * @return namespace list
	 */
	public ref List<Namespace> get_namespaces () {
		return namespaces.copy ();
	}
	
	/**
	 * Visits this source file and all children with the specified
	 * CodeVisitor.
	 *
	 * @param visitor the visitor to be called while traversing
	 */
	public void accept (CodeVisitor! visitor) {
		visitor.visit_begin_source_file (this);

		foreach (NamespaceReference ns_ref in using_directives) {
			ns_ref.accept (visitor);
		}
		
		global_namespace.accept (visitor);
		
		foreach (Namespace ns in namespaces) {
			ns.accept (visitor);
		}

		visitor.visit_end_source_file (this);
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
	 * Adds the specified symbol to the list of symbols code in this source
	 * file depends on.
	 *
	 * @param sym      a symbol
	 * @param dep_type type of dependency
	 */
	public void add_symbol_dependency (Symbol! sym, SourceFileDependencyType dep_type) {
		DataType t;
		
		if (sym.node is DataType) {
			t = (DataType) sym.node;
		} else if (sym.node is Method || sym.node is Field) {
			if (sym.parent_symbol.node is DataType) {
				t = (DataType) sym.parent_symbol.node;
			} else {
				return;
			}
		} else if (sym.node is Property) {
			t = (DataType) sym.parent_symbol.node;
		} else if (sym.node is FormalParameter) {
			var fp = (FormalParameter) sym.node;
			t = fp.type_reference.data_type;
			if (t == null) {
				/* generic type parameter */
				return;
			}
		} else {
			return;
		}
		
		if (dep_type == SourceFileDependencyType.SOURCE) {
			source_includes.concat (t.get_cheader_filenames ());
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
	 * Returns the list of externel includes the generated C header file
	 * requires.
	 *
	 * @return external include list for C header file
	 */
	public List<string> get_header_external_includes () {
		return header_external_includes;
	}
	
	/**
	 * Adds the specified filename to the list of package-internal includes
	 * the generated C header file requires.
	 *
	 * @param include internal include for C header file
	 */
	public void add_header_internal_include (string! include) {
		header_internal_includes.append (include);
	}
	
	/**
	 * Returns the list of package-internal includes the generated C header file
	 * requires.
	 *
	 * @return internal include list for C header file
	 */
	public List<string> get_header_internal_includes () {
		return header_internal_includes;
	}
	
	/**
	 * Returns the list of includes the generated C source file requires.
	 *
	 * @return include list for C source file
	 */
	public List<string> get_source_includes () {
		return source_includes;
	}
	
	/**
	 * Returns the list of source files the generated C header file requires
	 * definitely.
	 *
	 * @return definite source file dependencies
	 */
	public List<SourceFile> get_header_internal_full_dependencies () {
		return header_internal_full_dependencies;
	}
	
	/**
	 * Returns the list of source files the generated C header file loosely
	 * depends on.
	 *
	 * @return loose source file dependencies
	 */
	public List<SourceFile> get_header_internal_dependencies () {
		return header_internal_dependencies;
	}
}

public enum Vala.SourceFileDependencyType {
	HEADER_FULL,
	HEADER_SHALLOW,
	SOURCE
}
