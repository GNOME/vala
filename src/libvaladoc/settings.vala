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

using GLib;


public class Valadoc.Settings : Object {
	public Gee.ArrayList<string> files;
	private string rpath;
	public string path = "documentation/";
	public string package_name = null;
	public bool _private = false;
	public bool _protected = false;
	public bool with_deps = false;
	public bool add_inherited = false;

	public string get_real_path () {
		if ( rpath == null ) {
			string path = realpath ( this.path );

			if ( path.has_suffix ( "/" ) )
				this.rpath = path;
			else
				this.rpath = path + "/";	
		}

		return this.rpath;
	}

	public bool application {
		get {
			foreach ( string path in this.files ) {
				if ( path.has_prefix ( ".vapi" ) )
					return true;
			}
			return false;
		}
	}

	public bool to_doc ( string name ) {
		if ( with_deps == true )
			return true;

		// FIXME: Compare with full path
		string nstr = Path.get_basename ( name ) ;

		foreach ( string str in this.files ) {
			if ( Path.get_basename ( str ) == nstr )
				return true;
		}
		return false;
	}
}



