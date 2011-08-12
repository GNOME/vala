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

	public Package (string name, bool is_package, void* data) {
		base (null, null, name, data);

		this.is_package = is_package;
		this.parent = null;
	}

	// <version, symbols>
	private HashMap<string?, ArrayList<Symbol>> deprecated;

	internal void register_deprecated_symbol (Symbol symbol, string? version) {
		if (deprecated == null) {
			// some libgee-versions do not like nullable strings

			EqualFunc<string?> str_eq0 = (a, b) => { 
				if (a == null && b == null) {
					return true;
				} else if (a == null || b == null) {
					return false;
				}

				return a == b;
			};

			HashFunc<string?> str_hash0 = (a) => {
				if (a == null) {
					return 0;
				}

				return a.hash ();
			};

			deprecated = new HashMap<string?, ArrayList<Symbol>> (str_hash0, str_eq0);
		}

		ArrayList<Symbol> list = deprecated.get (version);
		if (list == null) {
			list = new ArrayList<Symbol> ();
			deprecated.set (version, list);
		}

		list.add (symbol);
	}

	public Map<string?, Collection<Symbol>> get_deprecated_symbols () {
		if (deprecated == null) {
			return Map<string?, Collection<Symbol>>.empty<string?, Collection<Symbol>> ();
		}

		return deprecated;
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

