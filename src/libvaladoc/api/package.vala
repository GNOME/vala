/* package.vala
 *
 * Copyright (C) 2008  Florian Brosch
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

using Gee;
using Valadoc.Content;

public class Valadoc.Api.Package : Node {
	private ArrayList<Vala.SourceFile> vfiles = new ArrayList<Vala.SourceFile> ();

	internal void add_file (Vala.SourceFile vfile) {
		this.vfiles.add (vfile);
	}

	public bool is_package {
		 private set;
		 get;
	}

	internal void set_dependency_list (ArrayList<Package> list) {
		this._dependencies = list;
	}

	private ArrayList<Package> _dependencies;

	public Collection<Package> get_full_dependency_list () {
		ArrayList<Package> list = new ArrayList<Package> ();

		if (this._dependencies == null) {
			return list.read_only_view;
		}

		foreach (Package pkg in this._dependencies) {
			if (list.contains ( pkg ) == false) {
				list.add (pkg);
			}

			var pkg_list = pkg.get_full_dependency_list ();
			foreach (Package pkg2 in pkg_list) {
				if (list.contains (pkg2) == false) {
					list.add (pkg2);
				}
			}
		}
		return list.read_only_view;
	}

	public Collection<Package> get_dependency_list () {
		if (this._dependencies == null) {
			return Collection.empty<Package> ();
		}

		return this._dependencies.read_only_view;
	}

	public Package (Vala.SourceFile vfile, string name, bool is_package = false) {
		base (null);
		this.is_package = is_package;

		this.package_name = name;

		this.vfiles.add (vfile);
		this.parent = null;
	}

	private string package_name;

	public override string? name {
		owned get {
			return package_name;
		}
	}

	internal bool is_package_for_file (Vala.SourceFile source_file) {
		return this.vfiles.contains (source_file);
	}

	public override bool is_visitor_accessible (Settings settings) {
		return !( this.is_package && settings.with_deps == false );
	}

	public override NodeType node_type { get { return NodeType.PACKAGE; } }

	public override void accept (Visitor visitor) {
		visitor.visit_package (this);
	}

	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_keyword ("package")
			.append (name)
			.get ();
	}

	protected Namespace get_namespace (Tree root, Vala.Symbol symbol) {
		Vala.Symbol namespace_symbol = symbol;
		while (!(namespace_symbol is Vala.Namespace)) {
			namespace_symbol = namespace_symbol.parent_symbol;
		}

		// Try to find it first
		var ns = (Namespace) root.search_vala_symbol_in (namespace_symbol, this);
		if (ns != null) {
			return ns;
		}

		// Find parent namespace and use it as parent if existing
		var parent_namespace_symbol = namespace_symbol.parent_symbol;

		if (parent_namespace_symbol != null) {
			ns = (Namespace) get_namespace (root, parent_namespace_symbol);
			if (ns != null) {
				var new_namespace = new Namespace ((Vala.Namespace) namespace_symbol, ns);
				ns.add_child (new_namespace);
				return new_namespace;
			}
		}

		// Else take this package as parent
		var new_namespace = new Namespace ((Vala.Namespace) namespace_symbol, this);
		add_child (new_namespace);
		return new_namespace;
	}
}

