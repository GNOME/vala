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


using Vala;
using GLib;
using Gee;



public class Valadoc.Package : DocumentedElement, NamespaceHandler {
	private Gee.ArrayList<Vala.SourceFile> vfiles = new Gee.ArrayList<Vala.SourceFile> ();

	internal void add_file (Vala.SourceFile vfile) {
		this.vfiles.add (vfile);
	}

	public Gee.ArrayList<Namespace> namespaces {
		default = new Gee.ArrayList<Namespace>();
		private set;
		private get;
	}

	public bool is_package {
		 private set;
		 get;
	}

	internal void set_dependency_list ( Gee.ArrayList<Package> list ) {
		this._dependencies = list;
	}

	private Gee.ArrayList<Package> _dependencies;

	public Gee.ReadOnlyCollection<Package> get_full_dependency_list () {
		Gee.ArrayList<Package> list = new Gee.ArrayList<Package> ();

		if ( this._dependencies == null )
			return new Gee.ReadOnlyCollection<Package> ( list );

		foreach ( Package pkg in this._dependencies ) {
			if ( list.contains ( pkg ) == false ) {
				list.add ( pkg );
			}

			var pkg_list = pkg.get_full_dependency_list ();
			foreach ( Package pkg2 in pkg_list ) {
				if ( list.contains ( pkg2 ) == false ) {
					list.add ( pkg2 );
				}
			}
		}
		return new Gee.ReadOnlyCollection<Package> ( list );
	}

	public Gee.ReadOnlyCollection<Package> get_dependency_list () {
		if ( this._dependencies == null ) {
			return new Gee.ReadOnlyCollection<Package> ( new Gee.ArrayList<Package> () );
		}

		return new Gee.ReadOnlyCollection<Package> ( this._dependencies );
	}

	private static string extract_package_name ( Settings settings, Vala.SourceFile vfile ) {
		if ( vfile.filename.has_suffix (".vapi") ) {
			string file_name = GLib.Path.get_basename (vfile.filename);
			return file_name.ndup ( file_name.size() - ".vapi".size() );
		}
		else if ( vfile.filename.has_suffix (".gidl") ) {
			string file_name = GLib.Path.get_basename (vfile.filename);
			return file_name.ndup ( file_name.size() - ".gidl".size() );
		}
		else {
			return settings.pkg_name;
		}
	}

	public Package.with_name (Valadoc.Settings settings, Vala.SourceFile vfile, string name, Tree head, bool is_package = false) {
		this.is_package = is_package;
		this.settings = settings;
		this.head = head;

		this.package_name = name;

		this.vfiles.add (vfile);
		this.parent = null;
	}

	public Package (Valadoc.Settings settings, Vala.SourceFile vfile, Tree head, bool is_package = false) {
		this.with_name (settings, vfile, this.extract_package_name (settings, vfile), head, is_package);
	}

	private string package_name;

	public override string? name {
		owned get {
			return package_name;
		}
	}

	internal override DocumentedElement? search_element (string[] params, int pos) {
		foreach (Namespace ns in this.namespaces) {
			DocumentedElement? element = ns.search_element ( params, pos );
			if (element != null) {
				return element;
			}
		}
		return null;
	}

	internal override DocumentedElement? search_element_vala (Gee.ArrayList<Vala.Symbol> params, int pos) {
		foreach (Namespace ns in this.namespaces) {
			DocumentedElement? element = ns.search_element_vala (params, pos);
			if (element != null) {
				return element;
			}
		}
		return null;
	}

	internal bool is_vpackage (Vala.SourceFile vfile) {
		return this.vfiles.contains (vfile);
	}

	public bool is_visitor_accessible () {
		return !( this.is_package && this.settings.with_deps == false );
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible () ) {
			return ;
		}
		doclet.visit_package ( this );
	}

	internal void parse_comments ( Valadoc.Parser docparser ) {
		this.parse_namespace_comments ( docparser );
	}

	internal void set_type_references ( ) {
		this.set_namespace_type_references ( );
	}

	public void write (Langlet langlet, void* ptr) {
		langlet.write_file (this, ptr);
	}
}

