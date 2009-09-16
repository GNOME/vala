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

using GLib.Path;
using GLib;
using Gee;



public static delegate  void Valadoc.TagletRegisterFunction (ModuleLoader loader);


public class Valadoc.ModuleLoader : Object {
	public Doclet doclet;

	public Gee.HashMap<string, GLib.Type> taglets = new Gee.HashMap<string, Type> (GLib.str_hash, GLib.str_equal);

	private Module docletmodule;
	private Type doclettype;

	public bool load ( string path ) {
		bool tmp = this.load_doclet ( path );
		if ( tmp == false ) {
			return false;
		}
		return true;
	}

	public Content.Taglet create_taglet (string keyword) {
		return (Content.Taglet) GLib.Object.new (taglets.get (keyword));
	}

	private bool load_doclet ( string path ) {
		void* function;

		docletmodule = Module.open ( build_filename(path, "libdoclet.so"), ModuleFlags.BIND_LAZY);
		if (docletmodule == null) {
			return false;
		}

		docletmodule.symbol( "register_plugin", out function );
		if ( function == null ) {
			return false;
		}

		Valadoc.DocletRegisterFunction doclet_register_function = (Valadoc.DocletRegisterFunction) function;
		doclettype = doclet_register_function ( );
		this.doclet = (Doclet)GLib.Object.new (doclettype);
		return true;
	}
}
