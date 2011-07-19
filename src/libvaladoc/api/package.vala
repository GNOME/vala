/* package.vala
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

using Gee;
using Valadoc.Content;
using Valadoc.Importer;

public class Valadoc.Api.Package : Node {
	/**
	 * Specifies whether this package is a dependency
	 */
	public bool is_package {
		 private set;
		 get;
	}

	internal void set_dependency_list (ArrayList<Package> list) {
		this._dependencies = list;
	}

	private ArrayList<Package> _dependencies;

	/**
	 * Returns a list with all dependencies
	 */
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

	public Package (Vala.SourceFile vfile, string name, bool is_package, void* data) {
		base (null, null, name, data);

		this.is_package = is_package;
		this.parent = null;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool is_browsable (Settings settings) {
		return !(this.is_package && settings.with_deps == false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get { return NodeType.PACKAGE; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_package (this);
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_keyword ("package")
			.append (name)
			.get ();
	}
}

