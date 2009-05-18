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
	public Gee.HashMap< string, GLib.Type > taglets;
	public GLib.Type underlinedtag;
	public GLib.Type notifictag;
	public GLib.Type centertag;
	public GLib.Type italictag;
	public GLib.Type ulistetag;
	public GLib.Type righttag;
	public GLib.Type ulisttag;
	public GLib.Type linktag;
	public GLib.Type strtag;
	public GLib.Type srctag;
	public GLib.Type imgtag;
	public GLib.Type boldtag;

	public GLib.Type tabletag;
	public GLib.Type celltag;

	public Doclet doclet;

	private Module docletmodule;
	private Type doclettype;

	public bool load ( string path ) {
		bool tmp = this.load_doclet ( path );
		if ( tmp == false )
			return false;

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

				// FIXME: Valac-bug: switch ( entry.ndup( entry.size() - modulesuffixlen ) ) do not work!
				string soname = entry.ndup( entry.size() - modulesuffixlen );
				switch ( soname ) {
				case "libtagletstring":
					this.strtag = type;
					break;
				case "libtagletimage":
					this.imgtag = type;
					break;
				case "libtagletcenter":
					this.centertag = type;
					break;
				case "libtagletright":
					this.righttag = type;
					break;
				case "libtagletbold":
					this.boldtag = type;
					break;
				case "libtagletunderline":
					this.underlinedtag = type;
					break;
				case "libtagletitalic":
					this.italictag = type;
					break;
				case "libtagletsource":
					this.srctag = type;
					break;
				case "libtagletnotification":
					this.notifictag = type;
					break;
				case "libtaglettable":
					this.tabletag = type;
					break;
				case "libtaglettablecell":
					this.celltag = type;
					break;
				case "libtagletlink":
					this.linktag = type;
					break;
				case "libtagletlist":
					this.ulisttag = type;
					break;
				case "libtagletlistelement":
					this.ulistetag = type;
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

