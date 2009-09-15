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


namespace Valadoc.Html {
	public const string css_inline_navigation = "main_inline_navigation";
	public const string css_inline_navigation_errorcode = "main_inline_navigation_errorcode";
	public const string css_inline_navigation_enumvalue = "main_inline_navigation_enumvalue";
	public const string css_inline_navigation_property = "main_inline_navigation_property";
	public const string css_inline_navigation_virtual_property = "main_inline_navigation_virtual_property";
	public const string css_inline_navigation_abstract_property = "main_inline_navigation_abstract_property";
	public const string css_inline_navigation_method = "main_inline_navigation_method";
	public const string css_inline_navigation_static_method = "main_inline_navigation_static_method";
	public const string css_inline_navigation_virtual_method = "main_inline_navigation_virtual_method";
	public const string css_inline_navigation_abstract_method = "main_inline_navigation_abstract_method";
	public const string css_inline_navigation_construction_method = "main_inline_navigation_construction_method";
	public const string css_inline_navigation_brief_description = "main_inline_navigation_brief_description";
	public const string css_inline_navigation_signal = "main_inline_navigation_signal";
	public const string css_inline_navigation_fields = "main_inline_navigation_fields";
	public const string css_inline_navigation_abstract_class = "main_inline_navigation_abstract_class";
	public const string css_inline_navigation_class = "main_inline_navigation_class";
	public const string css_inline_navigation_enum = "main_inline_navigation_enum";
	public const string css_inline_navigation_struct = "main_inline_navigation_struct";
	public const string css_inline_navigation_delegate = "main_inline_navigation_delegate";
	public const string css_inline_navigation_constant = "main_inline_navigation_constant";
	public const string css_inline_navigation_namespace = "main_inline_navigation_namespace";
	public const string css_inline_navigation_package = "main_inline_navigation_package";
	public const string css_inline_navigation_interface = "main_navigation_interface";
	public const string css_inline_navigation_errordomain = "main_inline_navigation_errordomain";
	public const string css_site_header = "site_header";
	public const string css_navi_package_index = "navi_package_index";
	public const string css_navi_package = "navi_package";
	public const string css_navi_creation_method = "navi_creation_method";
	public const string css_navi_error_domain = "navi_error_domain";
	public const string css_navi_namespace = "navi_namespace";
	public const string css_navi_abstract_method = "navi_abstract_method";
	public const string css_navi_virtual_method = "navi_virtual_method";
	public const string css_navi_static_method = "navi_static_method";
	public const string css_navi_construction_method = "navi_construction_method";
	public const string css_navi_method = "navi_method";
	public const string css_navi_struct = "navi_struct";
	public const string css_navi_iface = "navi_iface";
	public const string css_navi_field = "navi_field";
	public const string css_navi_class = "navi_class";
	public const string css_navi_abstract_class = "navi_abstract_class";
	public const string css_navi_enum = "navi_enum";
	public const string css_navi_link = "navi_link";
	public const string css_navi_constant = "navi_constant";
	public const string css_navi_prop = "navi_prop";
	public const string css_navi_abstract_prop = "navi_abstract_prop";
	public const string css_navi_virtual_prop = "navi_virtual_prop";
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
	public const string css_content_link_constant = "css_content_link_constant";
	public const string css_content_link_namespace = "css_content_link_namespace";
	public const string css_content_link_struct = "css_content_link_struct";
	public const string css_content_link_interface = "css_content_link_interface";
	public const string css_content_link_enum = "css_content_link_enum";
	public const string css_content_link_errordomain = "css_content_link_errordomain";
	public const string css_content_link_delegate = "css_content_link_delegate";
	public const string css_content_link_signal = "css_content_link_signal";
	public const string css_content_link_field = "css_content_link_field";
	public const string css_content_link_enumvalue = "css_content_link_enumvalue";
	public const string css_content_link_errorcode = "css_content_link_errorcode";
	public const string css_content_link_class = "css_content_link_class";
	public const string css_content_link_abstract_class = "css_content_link_abstract_class";
	public const string css_content_link_property = "css_content_link_property";
	public const string css_content_link_virtual_property = "css_content_link_virtual_property";
	public const string css_content_link_abstract_property = "css_content_link_abstract_property";
	public const string css_content_link_method = "css_content_link_method";
	public const string css_content_link_static_method = "css_content_link_static_method";
	public const string css_content_link_virtual_method = "css_content_link_virtual_method";
	public const string css_content_link_abstract_method = "css_content_link_abstract_method";
	public const string css_content_link_construction_method = "css_content_link_construction_method";
	public const string css_content_literal = "css_content_literal";


	public delegate string? HtmlLink (Settings settings, Documented element, Documented? pos);
	public HtmlLink get_html_link_imp;

	public string? get_html_link ( Settings settings, Documented element, Documented? pos ) {
		if (get_html_link_imp == null) {
			return null;
		}
		return get_html_link_imp(settings, element, pos);
	}

	public string get_html_type_link (Settings settings, Documented element, Documented? pos) {
		string prefix = "";
		string tmp = "";

		bool tmp2 = (element is WikiPage)? ((WikiPage)element).name!="index.valadoc" : element != pos;
		if ( tmp2 == true ) {
			prefix =  "../" + ((DocumentedElement)element).package.name;
		}

		if ( element is Valadoc.EnumValue || element is Valadoc.ErrorCode ) {
			tmp = "#" + ((DocumentedElement)element).name;
			element = (DocumentedElement)((DocumentedElement)element).parent;
		}

		return prefix + "/" + ((DocumentedElement)element).full_name() + ".html" + tmp;
	}

	public string get_html_content_link_css_class ( Valadoc.Basic element ) {
		if ( element is Namespace ) {
			return css_content_link_namespace;
		}
		else if ( element is Struct ) {
			return css_content_link_struct;
		}
		else if ( element is Interface ) {
			return css_content_link_interface;
		}
		else if ( element is Class ) {
			if ( ((Class)element).is_abstract )
				return css_content_link_abstract_class;
			else
				return css_content_link_class;
		}
		else if ( element is Enum ) {
			return css_content_link_enum;
		}
		else if ( element is ErrorDomain ) {
			return css_content_link_errordomain;
		}
		else if ( element is Delegate ) {
			return css_content_link_delegate;
		}
		else if ( element is Method ) {
			if ( ((Method)element).is_constructor )
				return css_content_link_construction_method;
			else if ( ((Method)element).is_abstract )
				return css_content_link_abstract_method;
			else if ( ((Method)element).is_override || ((Method)element).is_override )
				return css_content_link_virtual_method;
			else if ( ((Method)element).is_static )
				return css_content_link_static_method;
			else
				return css_content_link_method;
		}
		else if ( element is Signal ) {
			return css_content_link_signal;
		}
		else if ( element is Property ) {
			if ( ((Property)element).is_virtual || ((Property)element).is_override )
				return css_content_link_virtual_property;
			else if ( ((Property)element).is_abstract )
				return css_content_link_abstract_property;
			else
				return css_content_link_property;
		}
		else if ( element is Field ) {
			return css_content_link_field;
		}
		else if ( element is Constant ) {
			return css_content_link_constant;
		}
		else if ( element is EnumValue ) {
			return css_content_link_enumvalue;
		}
		else if ( element is ErrorCode ) {
			return css_content_link_errorcode;
		}
		return "";
	}

	public string get_html_inline_navigation_link_css_class ( Valadoc.Basic element ) {
		if ( element is Namespace ) {
			return css_inline_navigation_namespace;
		}
		else if ( element is Struct ) {
			return css_inline_navigation_struct;
		}
		else if ( element is Interface ) {
			return css_inline_navigation_interface;
		}
		else if ( element is Class ) {
			return (((Class)element).is_abstract)? css_inline_navigation_abstract_class : css_inline_navigation_class;
		}
		else if ( element is Enum ) {
			return css_inline_navigation_enum;
		}
		else if ( element is ErrorDomain ) {
			return css_inline_navigation_errordomain;
		}
		else if ( element is Delegate ) {
			return css_inline_navigation_delegate;
		}
		else if ( element is Method ) {
			if ( ((Method)element).is_static )
				return css_inline_navigation_static_method;
			else if ( ((Method)element).is_static )
				return css_inline_navigation_static_method;
			else if ( ((Method)element).is_constructor )
				return css_inline_navigation_construction_method;
			else if ( ((Method)element).is_abstract )
				return css_inline_navigation_abstract_method;
			else if ( ((Method)element).is_virtual || ((Method)element).is_override )
				return css_inline_navigation_virtual_method;
			else
				return css_inline_navigation_method;
		}
		else if ( element is Signal ) {
			return css_inline_navigation_signal;
		}
		else if ( element is Property ) {
			if ( ((Property)element).is_virtual || ((Property)element).is_override )
				return css_inline_navigation_virtual_property;
			else if ( ((Property)element).is_abstract )
				return css_inline_navigation_abstract_property;
			else
				return css_inline_navigation_property;
		}
		else if ( element is Field ) {
			return css_inline_navigation_fields;
		}
		else if ( element is Constant ) {
			return css_inline_navigation_constant;
		}
		else if ( element is EnumValue ) {
			return css_inline_navigation_enumvalue;
		}
		else if ( element is ErrorCode ) {
			return css_inline_navigation_errorcode;
		}
		else if ( element is Package ) {
			return css_inline_navigation_package;
		}
		return "";
	}
}



