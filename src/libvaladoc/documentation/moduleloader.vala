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



public static delegate GLib.Type Valadoc.TagletRegisterFunction ( Gee.HashMap<string, Type> taglets );


public class Valadoc.ModuleLoader : Object {
	public Doclet doclet; //rm

	public Gee.HashMap<string, GLib.Type> taglets;
	public GLib.Type bold;
	public GLib.Type center;
	public GLib.Type headline;
	public GLib.Type image;
	public GLib.Type italic;
	public GLib.Type link;
	public GLib.Type list;
	public GLib.Type list_element;
	public GLib.Type notification;
	public GLib.Type right;
	public GLib.Type source;
	public GLib.Type source_inline;
	public GLib.Type @string; //
	public GLib.Type table;
	public GLib.Type table_cell;
	public GLib.Type underline;


	private Module docletmodule;
	private Type doclettype;

	public bool load ( string path ) {
		bool tmp = this.load_doclet ( path );
		if ( tmp == false ) {
			return false;
		}

		return this.load_taglets ( path );
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

	private bool load_taglets ( string fulldirpath ) {
		try {
			taglets = new Gee.HashMap<string, Type> ( GLib.str_hash, GLib.str_equal );
			Gee.ArrayList<Module*> modules = new Gee.ArrayList<weak Module*> ( );
			string pluginpath = build_filename(fulldirpath, "taglets");
			size_t modulesuffixlen = Module.SUFFIX.size() + 1;
			GLib.Dir dir = GLib.Dir.open ( pluginpath );
			void* function;

			for ( weak string entry = dir.read_name(); entry != null ; entry = dir.read_name() ) {
				if ( !entry.has_suffix( "."+Module.SUFFIX ) )
					continue ;

				string tagletpath = build_filename ( pluginpath, entry );
				Module* module = Module.open ( tagletpath, ModuleFlags.BIND_LAZY);
				if (module == null) {
					taglets = null;
					return false;
				}


				module->symbol( "register_plugin", out function );
				Valadoc.TagletRegisterFunction tagletregisterfkt = (Valadoc.TagletRegisterFunction) function;
				if ( function == null ) {
					taglets = null;
					return false;
				}

				GLib.Type type = tagletregisterfkt ( taglets );

				string soname = entry.ndup( entry.size() - modulesuffixlen );
				switch ( soname ) {
				case "libtagletstring":
					this.string = type;
					break;
				case "libtagletimage":
					this.image = type;
					break;
				case "libtagletcenter":
					this.center = type;
					break;
				case "libtagletright":
					this.right = type;
					break;
				case "libtagletbold":
					this.bold = type;
					break;
				case "libtagletunderline":
					this.underline = type;
					break;
				case "libtagletitalic":
					this.italic = type;
					break;
				case "libtagletsource":
					this.source = type;
					break;
				case "libtagletnotification":
					this.notification = type;
					break;
				case "libtaglettable":
					this.table = type;
					break;
				case "libtaglettablecell":
					this.table_cell = type;
					break;
				case "libtagletlink":
					this.link = type;
					break;
				case "libtagletlist":
					this.list = type;
					break;
				case "libtagletlistelement":
					this.list_element = type;
					break;
				case "libtagletheadline":
					this.headline = type;
					break;
				case "libtagletcodeconstant":
					this.source_inline = type;
					break;
				}
				modules.add ( module );
			}
			return true;
		}
		catch ( FileError err ) {
			taglets = null;
			return false;
		}
	}
}

