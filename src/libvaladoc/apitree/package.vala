/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

using Gee;
using Valadoc.Content;

public class Valadoc.Package : Api.Node, NamespaceHandler {
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

	// TODO Remove
	internal bool is_vpackage (Vala.SourceFile vfile) {
		return this.vfiles.contains (vfile);
	}

	internal bool is_package_for_file (Vala.SourceFile source_file) {
		return this.vfiles.contains (source_file);
	}

	public override bool is_visitor_accessible (Settings settings) {
		return !( this.is_package && settings.with_deps == false );
	}

	public void visit ( Doclet doclet ) {
		doclet.visit_package ( this );
	}

	public override Api.NodeType node_type { get { return Api.NodeType.PACKAGE; } }

	public override void accept (Doclet doclet) {
		visit (doclet);
	}

	protected override Inline build_signature () {
		return new Api.SignatureBuilder ()
			.append_keyword ("package")
			.append (name)
			.get ();
	}
}
