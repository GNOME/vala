/* tree.vala
 *
 * Copyright (C) 2008-2011  Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc.Importer;

/**
 * The root of the code tree.
 */
public class Valadoc.Api.Tree {
	private Vala.List<InheritDocContainer> inheritdocs = new Vala.ArrayList<InheritDocContainer> ();
	private Vala.ArrayList<string> external_c_files = new Vala.ArrayList<string>(str_equal);
	private Vala.ArrayList<Package> packages = new Vala.ArrayList<Package>();
	private Package source_package = null;
	private Settings settings;
	private ErrorReporter reporter;
	private Highlighter.Highlighter _highlighter;
	private CTypeResolver _cresolver = null;
	private Package _source_package;


	private class InheritDocContainer {
		public unowned Taglets.InheritDoc taglet;
		public unowned Api.Node taglet_container;

		public InheritDocContainer (Api.Node taglet_container, Taglets.InheritDoc taglet) {
			this.taglet_container = taglet_container;
			this.taglet = taglet;
		}
	}


	public void add_package(Package package) {
		this.packages.add (package);
	}

	public Vala.CodeContext context {
		set;
		get;
	}

	public Highlighter.Highlighter highlighter {
		get {
			if (_highlighter == null) {
				_highlighter = new Highlighter.Highlighter ();
			}

			return _highlighter;
		}
	}

	/**
	 * The root of the wiki tree.
	 */
	public WikiPageTree? wikitree {
		private set;
		get;
	}

	/**
	 * Returns a list of C source files.
	 *
	 * @return list of C source files
	 */
	public Vala.Collection<string> get_external_c_files () {
		return external_c_files;
	}

	public void add_external_c_files (string name) {
		external_c_files.add (name);
	}


	/**
	 * Returns a list of all packages in the tree
	 *
	 * @return list of all packages
	 */
	public Vala.Collection<Package> get_package_list () {
		return this.packages;
	}

	private void add_dependencies_to_source_package () {
		if ( this.source_package != null ) {
			Vala.ArrayList<Package> deplst = new Vala.ArrayList<Package> ();
			foreach (Package pkg in this.packages) {
				if (pkg != this.source_package) {
					deplst.add (pkg);
				}
			}
			this.source_package.set_dependency_list (deplst);
		}
	}

	/**
	 * Visits this node with the specified Visitor.
	 *
	 * @param visitor the visitor to be called while traversing
	 */
	public void accept (Visitor visitor) {
		visitor.visit_tree (this);
	}

	/**
	 * Visits all children of this node with the given types with the specified Visitor.
	 *
	 * @param visitor the visitor to be called while traversing
	 */
	public void accept_children (Visitor visitor) {
		foreach (Node node in packages) {
			node.accept (visitor);
		}
	}

	private Node? search_relative_to (Node element, string[] path) {
		Api.Node? node = element;

		foreach (string name in path) {
			node = node.find_by_name (name);
			if (node == null) {
				break;
			}
		}

		if (node == null && element.parent != null) {
			node = search_relative_to ((Node) element.parent, path);
		}

		return node;
	}

	public Node? search_symbol_path (Node? element, string[] path) {
		Api.Node? node = null;

		// relative to element
		if (element != null) {
			node = search_relative_to (element, path);
			if (node != null) {
				return node;
			}
		}


		// absolute
		foreach (Package package in packages) {
			// search in root namespace

			Node? global = package.find_by_name ("");
			if (global != null) {
				node = search_relative_to (global, path);
				if (node != null) {
					return node;
				}
			}
		}

		return null;
	}

	public TypeSymbol? search_symbol_type_cstr (string cname) {
		if (_cresolver == null) {
			_cresolver = new CTypeResolver (this);
		}

		return _cresolver.resolve_symbol_type (cname);
	}

	public Node? search_symbol_cstr (Node? element, string cname) {
		if (_cresolver == null) {
			_cresolver = new CTypeResolver (this);
		}

		return _cresolver.resolve_symbol (element, cname);
	}

	public Node? search_symbol_str (Node? element, string symname) {
		string[] path = split_name (symname);

		var node = search_symbol_path (element, path);
		if (node != null) {
			return node;
		}

		if (path.length >= 2 && path[path.length-2] == path[path.length-2]) {
			path[path.length-2] = path[path.length-2]+"."+path[path.length-1];
			path.resize (path.length-1);
			return search_symbol_path (element, path);
		}

		return null;
	}

	private string[] split_name (string full_name) {
		string[] params = (full_name).split (".", -1);
		int i = 0; while (params[i] != null) i++;
		params.length = i;
		return params;
	}

	public Tree (ErrorReporter reporter, Settings settings, Vala.CodeContext context) {
		this.settings = settings;
		this.reporter = reporter;
		this.context = context;
	}

	// copied from valacodecontext.vala
	private string? get_file_path (string basename, string[] directories) {
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
			filename = Path.build_filename (dir, basename);
			if (FileUtils.test (filename, FileTest.EXISTS)) {
				return filename;
			}
		}

		return null;
	}

	public bool create_tree ( ) {
		this.add_dependencies_to_source_package ();
		return true;
	}

	private Package? get_source_package () {
		if (_source_package == null) {
			foreach (Package pkg in packages) {
				if (!pkg.is_package) {
					_source_package = pkg;
					break;
				}
			}
		}

		return _source_package;
	}

	private void parse_wiki (DocumentationParser docparser) {
		this.wikitree = new WikiPageTree ();
		var pkg = get_source_package ();
		if (pkg != null) {
			wikitree.parse (settings, docparser, pkg, reporter);
		}
	}

	private void check_wiki (DocumentationParser docparser) {
		Package pkg = get_source_package ();
		if (pkg != null) {
			wikitree.check (settings, docparser, pkg);
		}
	}

	public void parse_comments (DocumentationParser docparser) {
		parse_wiki (docparser);

		foreach (Package pkg in this.packages) {
			if (pkg.is_browsable (settings)) {
				pkg.parse_comments (settings, docparser);
			}
		}
	}

	public void check_comments (DocumentationParser docparser) {
		check_wiki (docparser);

		foreach (Package pkg in this.packages) {
			if (pkg.is_browsable (settings)) {
				pkg.check_comments (settings, docparser);
				postprocess_inheritdoc (docparser);
			}
		}
	}

	internal void register_inheritdoc (Api.Node container, Taglets.InheritDoc taglet) {
		inheritdocs.add (new InheritDocContainer (container, taglet));
	}

	private void postprocess_inheritdoc (DocumentationParser docparser) {
		while (!this.inheritdocs.is_empty) {
			InheritDocContainer container = this.inheritdocs.remove_at (0);

			docparser.transform_inheritdoc (container.taglet_container, container.taglet);
		}
	}


	/**
	 * Import documentation from various sources
	 *
	 * @param importers a list of importers
	 * @param packages sources
	 * @param import_directories List of directories where to find the files
	 */
	public void import_comments (DocumentationImporter[] importers, string[] packages,
									  string[] import_directories)
	{
		Vala.HashSet<string> processed = new Vala.HashSet<string> ();
		foreach (string pkg_name in packages) {
			bool imported = false;
			foreach (DocumentationImporter importer in importers) {
				string? path = get_file_path ("%s.%s".printf (pkg_name, importer.file_extension),
											  import_directories);
				if (path == null) {
					continue;
				}

				path = Vala.CodeContext.realpath (path);
				imported = true;

				if (!processed.contains (path)) {
					importer.process (path);
					processed.add (path);
				}
			}

			if (imported == false) {
				reporter.simple_error (null, "'%s' not found in specified import directories", pkg_name);
			}
		}
	}
}

