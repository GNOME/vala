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


public interface Valadoc.LinkHelper {	
	public abstract Settings settings {
		construct set;
		get;
	}

	public string? get_mark_name ( Valadoc.Basic type ) {
		if ( type is Class || type is Struct || type is Enum || type is ErrorDomain || type is Interface )
			return "";

		string? strd = null;
		while ( type is Namespace == false ) {
			if ( strd == null )
				strd = type.name;
			else if ( type.name != null )
				strd = type.name + "." + strd;

			type = type.parent;
		}

		return strd;
	}

	// just use get_file_name for classes and structs!
	private string get_file_name ( Valadoc.ContainerDataType ctype ) {
		Basic dtype = ctype;

		while ( dtype.parent is Namespace == false )
			dtype = dtype.parent;

		return dtype.name;
	}

	protected string? get_link ( Valadoc.Basic tag ) {
		if ( !this.settings.to_doc( tag.file_name ) )
			return null;

		string nspace_name = ( tag.nspace.name == null )? "(Global)" : tag.nspace.full_name;
		if ( tag is Valadoc.Namespace )
			return "../../ns.%s.html".printf( nspace_name );

		string docsubdir = Path.get_basename( tag.file_name );
		string markname = this.get_mark_name ( tag );

		if ( tag is Valadoc.EnumValue || tag is Valadoc.ErrorCode )
			return "../../%s/%s/%s.htm#%s".printf( docsubdir, nspace_name, tag.parent.name, markname );

		if ( tag is Valadoc.Field && tag.parent is Valadoc.Namespace )
			return "../../%s/%s/globals.html#%s".printf( docsubdir, nspace_name, markname );

		if ( tag is Valadoc.Delegate )
			return "../../%s/%s/delegates.html#%s".printf( docsubdir, nspace_name, markname );

		if ( tag is Valadoc.Method && tag.parent is Valadoc.Namespace )
			return "../../%s/%s/functions.html#%s".printf( docsubdir, nspace_name, markname );


		if ( tag is Valadoc.ContainerDataType  ) {
			string filename = this.get_file_name ( (ContainerDataType)tag );
			return "../../%s/%s/%s.htm".printf ( docsubdir, nspace_name, filename );
		}

		if ( tag is Valadoc.Enum || tag is Valadoc.ErrorDomain )
			return "../../%s/%s/%s.htm".printf ( docsubdir, nspace_name, tag.name );


		if ( tag.parent is Valadoc.Enum || tag.parent is Valadoc.ErrorDomain )
			return "../../%s/%s/%s.htm#%s".printf ( docsubdir, nspace_name, tag.parent.name, markname );

		if ( tag.parent is Valadoc.ContainerDataType ) {
			string filename = this.get_file_name ( (ContainerDataType)tag.parent );
			return "../../%s/%s/%s.htm#%s".printf ( docsubdir, nspace_name, filename, markname );
		}

		return null;
	}
}


