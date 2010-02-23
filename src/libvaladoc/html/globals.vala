/* globals.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch
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

using Valadoc.Api;

namespace Valadoc.Html {
	public const string css_inline_navigation = "navi_inline";

	public const string css_errorcode = "errorcode";
	public const string css_enumvalue = "enumvalue";
	public const string css_property = "property";
	public const string css_virtual_property = "virtual_property";
	public const string css_abstract_property = "abstract_property";
	public const string css_method = "method";
	public const string css_static_method = "static_method";
	public const string css_virtual_method = "virtual_method";
	public const string css_abstract_method = "abstract_method";
	public const string css_creation_method = "creation_method";
	public const string css_signal = "signal";
	public const string css_field = "field";
	public const string css_abstract_class = "abstract_class";
	public const string css_class = "class";
	public const string css_enum = "enum";
	public const string css_struct = "struct";
	public const string css_delegate = "delegate";
	public const string css_constant = "constant";
	public const string css_namespace = "namespace";
	public const string css_package = "package";
	public const string css_interface = "interface";
	public const string css_errordomain = "errordomain";

	public const string css_package_index = "package_index";
	public const string css_brief_description = "brief_description";
	public const string css_description = "description";
	public const string css_known_list = "known_nodes";
	public const string css_leaf_brief_description = "leaf_brief_description";
	public const string css_leaf_code_definition = "leaf_code_definition";

	public const string css_site_header = "site_header";
	public const string css_navi = "navi_main";
	public const string css_navi_hr = "navi_hr";
	public const string css_errordomain_table_name = "main_errordomain_table_name";
	public const string css_errordomain_table_text = "main_errordomain_table_text";
	public const string css_errordomain_table = "main_errordomain_table";
	public const string css_enum_table_name = "main_enum_table_name";
	public const string css_enum_table_text = "main_enum_table_text";
	public const string css_enum_table = "main_enum_table";
	public const string css_diagram = "main_diagram";
	public const string css_see_list = "main_see_list";
	public const string css_wiki_table = "main_table";
	public const string css_notification_area = "main_notification";
	public const string css_source_sample = "main_sourcesample";
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
	public const string css_style_navigation = "site_navigation";
	public const string css_style_content = "site_content";
	public const string css_style_body = "site_body";

	public const string css_box_headline_text = "text";
	public const string css_box_headline_toggle = "toggle";
	public const string css_box_headline = "headline";
	public const string css_box_content = "content";
	public const string css_box_column = "column";
	public const string css_box = "box";

	public const string css_namespace_note = "namespace_note";
	public const string css_package_note = "package_note";


	public string get_html_type_link (Settings settings, Documentation element, Documentation? pos) {
		string prefix = "";
		string tmp = "";

		bool tmp2 = (element is WikiPage)? ((WikiPage)element).name!="index.valadoc" : element != pos;
		if ( tmp2 == true ) {
			prefix =  "../" + ((Api.Node)element).package.name;
		}

		if ( element is Api.EnumValue || element is Api.ErrorCode ) {
			tmp = "#" + ((Api.Node)element).name;
			element = (Api.Node)((Api.Node)element).parent;
		}

		return prefix + "/" + ((Api.Node)element).full_name() + ".html" + tmp;
	}


	public string get_html_css_class (Valadoc.Api.Item element) {
		if ( element is Api.Namespace ) {
			return css_namespace;
		}
		else if ( element is Api.Struct ) {
			return css_struct;
		}
		else if ( element is Api.Interface ) {
			return css_interface;
		}
		else if ( element is Api.Class ) {
			return (((Class)element).is_abstract)? css_abstract_class : css_class;
		}
		else if ( element is Api.Enum ) {
			return css_enum;
		}
		else if ( element is Api.ErrorDomain ) {
			return css_errordomain;
		}
		else if ( element is Api.Delegate ) {
			return css_delegate;
		}
		else if ( element is Api.Method ) {
			if ( ((Api.Method)element).is_static )
				return css_static_method;
			else if ( ((Api.Method)element).is_static )
				return css_static_method;
			else if ( ((Api.Method)element).is_constructor )
				return css_creation_method;
			else if ( ((Api.Method)element).is_abstract )
				return css_abstract_method;
			else if ( ((Api.Method)element).is_virtual || ((Api.Method)element).is_override )
				return css_virtual_method;
			else
				return css_method;
		}
		else if ( element is Api.Signal ) {
			return css_signal;
		}
		else if ( element is Api.Property ) {
			if ( ((Api.Property)element).is_virtual || ((Property)element).is_override )
				return css_virtual_property;
			else if ( ((Api.Property)element).is_abstract )
				return css_abstract_property;
			else
				return css_property;
		}
		else if ( element is Api.Field ) {
			return css_field;
		}
		else if ( element is Api.Constant ) {
			return css_constant;
		}
		else if ( element is Api.EnumValue ) {
			return css_enumvalue;
		}
		else if ( element is Api.ErrorCode ) {
			return css_errorcode;
		}
		else if ( element is Api.Package ) {
			return css_package;
		}
		return "";
	}
}




