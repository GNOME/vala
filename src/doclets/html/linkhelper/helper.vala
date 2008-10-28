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



/* css-class-names: */
public const string css_inline_navigation = "main_inline_navigation";
public const string css_inline_navigation_namespace = "main_inline_navigation_namespace";
public const string css_inline_navigation_property = "main_inline_navigation_property";
public const string css_inline_navigation_method = "main_inline_navigation_method";
public const string css_inline_navigation_signal = "main_inline_navigation_signal";
public const string css_inline_navigation_fields = "main_inline_navigation_fields";
public const string css_inline_navigation_class = "main_inline_navigation_class";
public const string css_inline_navigation_enum = "main_inline_navigation_enum";
public const string css_inline_navigation_struct = "main_inline_navigation_struct";
public const string css_inline_navigation_delegate = "main_inline_navigation_delegate";
public const string css_inline_navigation_constant = "main_inline_navigation_constant";
public const string css_inline_navigation_package = "main_inline_navigation_package";

public const string css_navi_package_index = "navi_package_index";
public const string css_navi_package = "navi_package";
public const string css_navi_construction_method = "navi_construction_method";
public const string css_navi_error_domain = "navi_error_domain";
public const string css_navi_namespace = "navi_namespace";
public const string css_navi_method = "navi_method";
public const string css_navi_struct = "navi_struct";
public const string css_navi_iface = "navi_iface";
public const string css_navi_field = "navi_field";
public const string css_navi_class = "navi_class";
public const string css_navi_enum = "navi_enum";
public const string css_navi_link = "navi_link";
public const string css_navi_constant = "navi_constant";
public const string css_navi_prop = "navi_prop";
public const string css_navi_del = "navi_del";
public const string css_navi_sig = "navi_sig";
public const string css_navi = "navi_main";
public const string css_navi_enval = "main_navi_enval";
public const string css_navi_errdomcode = "main_navi_errdomcode";
public const string css_navi_hr = "navi_hr";

public const string css_errordomain_table_name = "main_errordomain_table_name";
public const string css_errordomain_table_text = "main_errordomain_table_text";
public const string css_errordomain_table = "main_errordomain_table";


public const string css_enum_table_name = "main_enum_table_name";
public const string css_enum_table_text = "main_enum_table_text";
public const string css_enum_table = "main_enum_table";

public const string css_diagram = "main_diagram";
public const string css_see_list = "main_see_list";
public const string css_exception_table = "main_parameter_table";
public const string css_parameter_table_text = "main_parameter_table_text";
public const string css_parameter_table_name = "main_parameter_table_name";
public const string css_parameter_table = "main_parameter_table";
public const string css_title = "main_title";
public const string css_other_type = "main_other_type";
public const string css_basic_type  = "main_basic_type";
public const string css_keyword  = "main_keyword";
public const string css_optional_parameter  = "main_optional_parameter";
public const string css_code_definition = "main_code_definition";
public const string css_headline_hr = "main_hr";
public const string css_hr = "main_hr";
public const string css_list_errdom = "main_list_errdom";
public const string css_list_en = "main_list_en";
public const string css_list_ns = "main_list_ns";
public const string css_list_cl = "main_list_cl";
public const string css_list_iface = "main_list_iface";
public const string css_list_stru = "main_list_stru";
public const string css_list_field = "main_list_field";
public const string css_list_prop = "main_list_prop";
public const string css_list_del = "main_list_del";
public const string css_list_sig = "main_list_sig";
public const string css_list_m = "main_list_m";



public interface Valadoc.LinkHelper : Object {
	private static string package_name = null;

	public abstract Settings settings {
		construct set;
		get;
	}

	private string get_dirname ( string file_name ) {
		if ( file_name[file_name.len()-1] == '/' )
			return GLib.Path.get_dirname ( file_name );
		else
			return GLib.Path.get_basename ( file_name );
	}

	protected string get_package_name ( string file_path ) {
		if ( file_path.has_suffix (".vapi") ) {
			string file_name = GLib.Path.get_basename (file_path);
			return file_name.ndup ( file_name.size() - ".vapi".size() );
		}

		if ( this.package_name == null ) {
			this.package_name = this.settings.package_name;
		}

		if ( this.package_name == null ) {
			string file_name = this.get_dirname( settings.path );
			this.package_name = file_name; //file_name.ndup ( file_name.size() - ".vala".size() );			
		}

		return this.package_name;
	}

	public string get_file_name ( Valadoc.Basic tag ) {
		Valadoc.Basic pos = tag;

		while ( pos != null ) {
			if ( pos is Valadoc.File )
				return pos.name;

			pos = pos.parent;
		}
		return null;
	}

	protected string get_top_link ( Valadoc.Basic postag ) {
		GLib.StringBuilder str = new GLib.StringBuilder ( "" );
		Valadoc.Basic pos = postag;

		while ( pos != null ) {
			str.append ( "../" );
			pos = pos.parent;
		}
		return str.str;
	}

	protected string? get_link ( Valadoc.Basic tag, Valadoc.Basic postag ) {
		if ( !this.settings.to_doc( tag.file_name ) )
			return null;

		GLib.StringBuilder str = new GLib.StringBuilder ( "" );
		Valadoc.Basic pos = tag;

		string? link_id = null;

		if ( tag is Valadoc.File == false ) {
			if ( tag is Valadoc.EnumValue || tag is Valadoc.ErrorCode ) {
				link_id = "#"+tag.name;
				pos = pos.parent;
			}

			while ( pos != null ) {
				if ( pos.name == null )
					str.prepend ( "0" );
				else
					str.prepend ( pos.name );

				str.prepend ( "/" );

				if ( pos.parent is Valadoc.File )
					break;

				pos = pos.parent;
			}
		}
		string filename = this.get_file_name ( tag );
		string package_name = this.get_package_name ( filename );
		str.prepend ( package_name );
		str.prepend ( this.get_top_link ( postag ) );
		str.append ( "/index.html" );

		if ( link_id != null )
			str.append ( link_id );

		return str.str;
	}
}


