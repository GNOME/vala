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


	public string? get_html_link ( Settings settings, DocumentedElement element, DocumentedElement? pos ) {
		if ( element is Package ) {
			return ( ((Package)element).is_visitor_accessible() == true )? ((pos == null)? "" : "../") + element.name + "/index.htm" : null;
		}

		if ( element is Visitable ) {
			if ( ((Visitable)element).is_visitor_accessible () == false )
				return null;

			if ( element.package.is_visitor_accessible () == false )
				return null;
		}

		string prefix = "";
		string tmp = "";
	
		if ( element != pos ) {
			prefix =  "../" + element.package.name;
		}

		if ( element is Valadoc.EnumValue || element is Valadoc.ErrorCode ) {
			tmp = "#" + element.name;
			element = (DocumentedElement)element.parent;
		}

		return prefix + "/" + element.full_name () + ".html" + tmp;
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




/*/ remove
public abstract class Valadoc.SeeHtmlHelperTaglet : MainTaglet {
	public override int order { get { return 400; } }
	private string name;
	private string link;
	private string css;

	protected abstract string? get_link ( Settings settings, Tree tree, DocumentedElement element, DocumentedElement? pos );

	// override-bug
	protected bool write_block_start_imp ( void* res ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		file.printf ( "<h2 class=\"%s\">See:</h2>\n", css_title );
		return true;
	}

	// override-bug
	protected bool write_block_end_imp ( void* res ) {
		return true;
	}

	// override-bug
	protected bool write_imp ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		file.printf ( "<a class=\"%s\" href=\"%s\">%s</a>", this.css, this.link, this.name );
		if ( max != index+1 )
			file.printf ( ", " );

		return true;
	}

	// override-bug
	protected bool parse_imp ( Settings settings, Tree tree, DocumentedElement me, Gee.Collection<DocElement> content, out string[] errmsg ) {
		if ( content.size != 1 ) {
			errmsg = new string[1];
			errmsg[0] = "Type name was expected.";
			return false;
		}

		Gee.Iterator<DocElement> it = content.iterator ();
		it.next ();

		DocElement element = it.get ();
		if ( element is StringTaglet == false ) {
			errmsg = new string[1];
			errmsg[0] = "Type name was expected.";
			return false;
		}

		Valadoc.DocumentedElement? node = tree.search_symbol_str ( me, ((StringTaglet)element).content.strip ( ) );
		if ( node == null ) {
			errmsg = new string[1];
			errmsg[0] = "Linked type is not available.";
			return false;
		}

		this.name = node.full_name ( );
		this.css = get_html_content_link_css_class ( node );
		this.link = this.get_link ( settings, tree, node, me );
		return true;
	}
}


// remove
public class Valadoc.SinceHtmlTaglet : MainTaglet {
	public override int order { get { return 400; } }
	private StringTaglet content;

	public override bool write_block_start ( void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		file.printf ( "<h2 class=\"%s\">Since:</h2>\n", css_title );
		return true;
	}

	public override bool write_block_end ( void* res ) {
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		((GLib.FileStream)res).printf ( "%s", this.content.content );
		if ( max != index+1 )
			((GLib.FileStream)res).puts ( ", " );

		return true;
	}

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.Collection<DocElement> content, out string[] errmsg ) {
		if ( content.size != 1 ) {
			errmsg = new string[1];
			errmsg[0] = "Version name was expected.";
			return false;
		}

		Gee.Iterator<DocElement> it = content.iterator ();
		it.next ();

		DocElement element = it.get ();
		if ( element is StringTaglet == false ) {
			errmsg = new string[1];
			errmsg[0] = "Version name was expected.";
			return false;
		}

		this.content = (StringTaglet)element;
		return true;
	}
}


// remove
public abstract class Valadoc.LinkHtmlHelperTaglet : InlineTaglet {
	private string? link = null;
	private string? name = null;
	private string? css = null;

	protected abstract string? get_link ( Settings settings, Tree tree, DocumentedElement element, DocumentedElement? pos );

	protected string to_string_imp ( ) {
		return this.name;
	}

	protected bool write_imp ( void* res, int max, int index ) {
		if ( this.link == null )
			((GLib.FileStream)res).printf ( "<span class=\"%s\">%s</span>", this.css, this.name );
		else
			((GLib.FileStream)res).printf ( "<a class=\"%s\" href=\"%s\">%s</a>", this.css, this.link, this.name );

		return true;
	}

	protected bool parse_imp ( Settings settings, Tree tree, DocumentedElement me, string content, out string[] errmsg ) {
		Valadoc.DocumentedElement? element = tree.search_symbol_str ( me, content.strip() );
		if ( element == null ) {
			errmsg = new string[1];
			errmsg[0] = "Linked type is not available.";
			return false;
		}

		this.name = element.full_name ();
		this.css = get_html_content_link_css_class ( element );
		this.link = this.get_link ( settings, tree, element, me );
		return true;
	}
}

// remove
public class Valadoc.ExceptionHtmlTaglet : MainTaglet {
	public override int order { get { return 200; } }
	private Gee.ArrayList<DocElement> content;
	private string paramname;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.Collection<DocElement> content, out string[] errmsg ) {
		if ( me is Valadoc.ExceptionHandler == false ) {
			errmsg = new string[1];
			errmsg[0] = "Tag @throws cannot be used in %s documentation.  It can only be used in the following types of documentation: method, signal, delegate.".printf ( this.get_data_type ( me ) );
			return false;
		}

		if ( content.size == 0 ) {
			errmsg = new string[1];
			errmsg[0] = "Errordomain was expected.";
			return false;
		}


		Gee.ArrayList<DocElement> contentlst = new Gee.ArrayList<DocElement> ();
		foreach ( DocElement element in content ) {
			contentlst.add ( element );
		}

		DocElement tag = contentlst.get( 0 );
		if ( tag is StringTaglet == false ) {
			errmsg = new string[1];
			errmsg[0] = "Exception name was expected.";
			return false;
		}

		string str = ((StringTaglet)tag).content;
		weak string lposa =  str.chr (-1, '\n');
		weak string lposb =  str.chr (-1, ' ');
		weak string lpos;

		long lposaoffset = (lposa == null)? long.MAX : str.pointer_to_offset ( lposa );
		long lposboffset = (lposb == null)? long.MAX : str.pointer_to_offset ( lposb );

		if ( lposaoffset < lposboffset )
			lpos = lposa;
		else
			lpos = lposb;

		if ( lpos == null ) {
			this.paramname = str.strip ();
			((StringTaglet)tag).content = "";
		}
		else {
			int namepos = (int)str.pointer_to_offset ( lpos );
			this.paramname = str.ndup ( namepos ).strip ();
			((StringTaglet)tag).content = lpos.ndup ( lpos.size () ).chomp ();
		}

		bool tmp = this.check_exception_parameter_name ( (Valadoc.ExceptionHandler)me, this.paramname );
		if ( tmp == false ) {
			errmsg = new string[1];
			errmsg[0] = "Unknown parameter.";
			return false;
		}

		this.content = contentlst;
		return true;
	}

	private bool check_exception_parameter_name ( Valadoc.ExceptionHandler me, string paramname ) {
		foreach ( DocumentedElement param in me.get_error_domains() ) {
			if ( param.name == paramname )
				return true;
		}
		return false;
	}

	public override bool write ( void* ptr, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		file.printf ( "\t<tr>\n" );
		file.printf ( "\t\t<td class=\"%s\">%s:</td>\n", css_parameter_table_name, this.paramname );
		file.printf ( "\t\t<td class=\"%s\">\n", css_parameter_table_text );
		file.puts ( "\t\t\t" );

		int _max = this.content.size;
		int _index = 0;

		foreach ( DocElement element in this.content ) {
			element.write ( ptr, _max, _index );
			_index++;
		}

		file.puts ( "\n" );
		file.printf ( "\t\t</td>\n" );
		file.printf ( "\t</tr>\n" );
		return true;
	}

	public override bool write_block_start ( void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		file.printf ( "<h2 class=\"%s\">Exceptions:</h2>\n", css_title );
		file.printf ( "<table class=\"%s\">\n", css_exception_table );
		return true;
	}

	public override bool write_block_end ( void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		file.printf ( "</table>\n" );
		return true;
	}
}


public class Valadoc.ParameterHtmlTaglet : MainTaglet {
	public override int order { get { return 100; } }
	private Gee.Collection<DocElement> content;
	private string paramname;

	private static bool check_parameter_name ( Valadoc.ParameterListHandler me, string name ) {
		if ( name == "" )
			return false;

		foreach ( Valadoc.FormalParameter param in me.get_parameter_list ( ) ) {
			if ( param.name == name )
				return true;
		}
		return false;
	}

	public override bool write ( void* ptr, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		file.printf ( "\t<tr>\n" );
		file.printf ( "\t\t<td class=\"%s\">%s:</td>\n", css_parameter_table_name, this.paramname );
		file.printf ( "\t\t<td class=\"%s\">\n", css_parameter_table_text );
		file.puts ( "\t\t\t" );

		int _max = this.content.size;
		int _index = 0;

		foreach ( DocElement tag in this.content ) {
			tag.write ( ptr, _max, _index );
			_index++;
		}

		file.puts ( "\n" );
		file.printf ( "\t\t</td>\n" );
		file.printf ( "\t</tr>\n" );
		return true;
	}

	public override bool write_block_start ( void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		file.printf ( "<h2 class=\"%s\">Parameters:</h2>\n", css_title );
		file.printf ( "<table class=\"%s\">\n", css_parameter_table );
		return true;
	}

	public override bool write_block_end ( void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		file.printf ( "</table>\n" );
		return true;
	}

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.Collection<DocElement> content, out string[] errmsg ) {
		if ( me is Valadoc.ParameterListHandler == false ) {
			errmsg = new string[1];
			errmsg[0] = "Tag @param cannot be used in %s documentation.  It can only be used in the following types of documentation: method, signal, delegate.".printf ( this.get_data_type ( me ) );
			return false;
		}

		if ( content.size == 0 ) {
			errmsg = new string[1];
			errmsg[0] = "Parameter name was expected.";
			return false;
		}

		Gee.ArrayList<DocElement> contentlst = new Gee.ArrayList<DocElement> ();
		foreach ( DocElement element in content ) {
			contentlst.add ( element );
		}

		DocElement tag = contentlst.get( 0 );
		if ( tag is StringTaglet == false ) {
			errmsg = new string[1];
			errmsg[0] = "Parameter name was expected.";
			return false;
		}

		string str = ((StringTaglet)tag).content;
		weak string lposa =  str.chr (-1, '\n');
		weak string lposb =  str.chr (-1, ' ');
		weak string lpos;

		long lposaoffset = (lposa == null)? long.MAX : str.pointer_to_offset ( lposa );
		long lposboffset = (lposb == null)? long.MAX : str.pointer_to_offset ( lposb );

		if ( lposaoffset < lposboffset )
			lpos = lposa;
		else
			lpos = lposb;

		if ( lpos == null ) {
			this.paramname = str.strip ();
			((StringTaglet)tag).content = "";
		}
		else {
			int namepos = (int)str.pointer_to_offset ( lpos );
			this.paramname = str.ndup ( namepos ).strip ();
			((StringTaglet)tag).content = lpos.ndup ( lpos.size () ).chomp ();
		}

		bool tmp = this.check_parameter_name ( (Valadoc.ParameterListHandler)me, this.paramname );
		if ( tmp == false ) {
			errmsg = new string[1];
			errmsg[0] = "Unknown parameter.";
			return false;
		}

		this.content = contentlst;
		return true;
	}
}


// remove
public class Valadoc.ReturnHtmlTaglet : MainTaglet {
	public override int order { get { return 300; } }
	private Gee.Collection<DocElement> content;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.Collection<DocElement> content, out string[] errmsg ) {
		if ( !(me is Valadoc.Method || me is Valadoc.Signal || me is Valadoc.Delegate) ) {
			errmsg = new string[1];
			errmsg[0] = "Tag @return cannot be used in %s documentation.  It can only be used in the following types of documentation: method, signal, delegate.".printf ( this.get_data_type ( me ) );
			return false;
		}
		this.content = content;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		int _max = this.content.size;
		int _index = 0;

		foreach ( DocElement element in this.content ) {
			element.write ( res, _max, _index );
			_index++;
		}
		return true;
	}

	public override bool write_block_start ( void* res ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		file.printf ( "<h2 class=\"%s\">Returns:</h2>\n", css_title );
		return true;
	}

	public override bool write_block_end ( void* res ) {
		return true;
	}
}


// remove
public class Valadoc.StringHtmlTaglet : StringTaglet {
	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, string content ) {
		this.content = content;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		unichar chr = content[0];
		long lpos = 0;
		int i = 0;

		for ( i = 0; chr != '\0' ; i++, chr = content[i] ) {
			switch ( chr ) {
			case '\n':
				file.puts ( content.substring (lpos, i-lpos) ); 
				file.puts ( "<br />" );
				lpos = i+1;
				break;
			case '<':
				file.puts ( content.substring (lpos, i-lpos) ); 
				file.puts ( "&lt;" );
				lpos = i+1;
				break;
			case '>':
				file.puts ( content.substring (lpos, i-lpos) ); 
				file.puts ( "&gt;" );
				lpos = i+1;
				break;
			case '&':
				file.puts ( content.substring (lpos, i-lpos) ); 
				file.puts ( "&amp;" );
				lpos = i+1;
				break;
			}
		}
		file.puts ( content.substring (lpos, i-lpos) ); 
		return true;
	}
}
*/
/*/ remove
public class Valadoc.UnderlinedHtmlHelperDocElement : UnderlinedDocElement {
	private Gee.ArrayList<DocElement> content;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content ) {
		this.content = content;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		int _max = this.content.size;
		int _index = 0;

		file.printf ( "<u>" );

		foreach ( DocElement element in this.content ) {
			element.write ( res, _max, _index );
			_index++;
		}

		file.printf ( "</u>" );
		return true;
	}
}

// remove
public class Valadoc.ListHtmlHelperEntryDocElement : ListEntryDocElement {
	private Gee.ArrayList<DocElement> content;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, ListType type, Gee.ArrayList<DocElement> content ) {
		this.content = content;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		int _max = this.content.size;
		int _index = 0;

		file.printf ( "\t<li>" );

		foreach ( DocElement element in this.content ) {
			element.write ( res, _max, _index );
			_index++;
		}

		file.printf ( "</li>\n" );

		return true;
	}
}


// remove
public class Valadoc.ListHtmlHelperDocElement : ListDocElement {
	private Gee.ArrayList<ListEntryDocElement> entries;
	private ListType type;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, ListType type, Gee.ArrayList<ListEntryDocElement> entries ) {
		this.entries = entries;
		this.type = type;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		int _max = this.entries.size;
		int _index = 0;

		file.printf ( (this.type == ListType.UNSORTED)? "<ul>\n" : "<ol>\n" );

		foreach ( ListEntryDocElement entry in this.entries ) {
			entry.write ( res, _max, _index );
			_index++;
		}

		file.printf ( (this.type == ListType.UNSORTED)? "</ul>\n" : "</ol>\n" );
		return true;
	}
}


// remove
public class Valadoc.LinkHtmlHelperDocElement : LinkDocElement {
	protected ImageDocElementPosition position;
	protected Gee.ArrayList<DocElement>? desc;
	protected string path;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, string# path, Gee.ArrayList<DocElement>? desc ) {
		this.path = #path;
		this.desc = desc;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;

		if ( this.desc == null ) {
			file.printf ( "<a href=\"%s\"/>%s<a>", this.path, this.path );
		}
		else {
			int _max = this.desc.size;
			int _index = 0;

			file.printf ( "<a href=\"%s\"/>", this.path );
			foreach ( DocElement element in this.desc ) {
				element.write ( res, _max, _index );
				_index++;
			}
			file.printf ( "<a>" );
		}
		return true;
	}
}



// remove
public class Valadoc.TableCellHtmlHelperDocElement : TableCellDocElement {
	private Gee.ArrayList<DocElement> content;
	private TextVerticalPosition hpos;
	private TextPosition pos;
	private int dcells;
	private int cells;
	
	public override void parse ( Settings settings, Tree tree, DocumentedElement me, TextPosition pos, TextVerticalPosition hpos, int cells, int dcells, Gee.ArrayList<DocElement> content ) {
		this.content = content;
		this.dcells = dcells;
		this.cells = cells;
		this.hpos = hpos;
		this.pos = pos;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		int _max = this.content.size;
		int _index = 0;

		GLib.StringBuilder td = new GLib.StringBuilder ( "\t\t<td" );
		if ( this.cells != 1 ) {
			td.append ( " colspan=\"" );
			td.append ( this.cells.to_string() );
			td.append_unichar ( '\"' );
		}

		if ( this.dcells != 1 ) {
			td.append ( " rowspan=\"" );
			td.append ( this.dcells.to_string() );
			td.append_unichar ( '\"' );
		}

		switch ( this.pos ) {
		case TextPosition.CENTER:
			td.append ( " align=\"center\"" );
			break;
		case TextPosition.RIGHT:
			td.append ( " align=\"right\"" );
			break;
		}

		switch ( this.hpos ) {
		case TextVerticalPosition.TOP:
			td.append ( " valign=\"top\"" );
			break;
		case TextVerticalPosition.BOTTOM:
			td.append ( " valign=\"bottom\"" );
			break;
		}

		td.append_unichar ( '>' );

		file.puts ( td.str );
		foreach ( DocElement cell in this.content ) {
			cell.write ( res, _max, _index );
			_index++;
		}
		file.puts ( "</td>\n" );
		return true;
	}
}


// remove
public class Valadoc.TableHtmlHelperDocElement : TableDocElement {
	private Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> cells;

	public override void parse ( Gee.ArrayList<Gee.ArrayList<TableCellDocElement>> cells ) {
		this.cells = cells;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;

		file.printf ( "<table border=\"1\" class=\"%s\">\n", css_wiki_table );
		foreach ( Gee.ArrayList<TableCellDocElement> row in this.cells ) {
			int _max = row.size;
			int _index = 0;

			file.puts ( "\t<tr>\n" );
			foreach ( TableCellDocElement cell in row ) {
				cell.write ( res, _max, _index );
				_index++;
			}
			file.puts ( "\t</tr>\n" );

		}
		file.puts ( "</table>\n" );
		return true;
	}
}


// remove
public class Valadoc.NotificationHtmlHelperDocElement : NotificationDocElement {
	private Gee.ArrayList<DocElement> content;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content ) {
		this.content = content;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		int _max = this.content.size;
		int _index = 0;

		file.printf ( "\n<div class=\"%s\">\n", css_notification_area );

		foreach ( DocElement element in this.content ) {
			element.write ( res, _max, _index );
			_index++;
		}

		file.printf ( "\n</div>\n" );
		return true;
	}
}


// remove
public class Valadoc.SourceCodeHtmlHelerDocElement : SourceCodeDocElement {
	public Language lang;
	public string src;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, string# src, Language lang ) {
		this.lang = lang;
		this.src = #src;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		file.printf ( "\n<div class=\"%s\">\n\t<pre>", css_source_sample );
		file.puts ( src );
		file.puts ( "<pre>\n</div>" );
		return true;
	}
}


// remove
public class Valadoc.ItalicHtmlHelperDocElement : ItalicDocElement {
	private Gee.ArrayList<DocElement> content;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content ) {
		this.content = content;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		int _max = this.content.size;
		int _index = 0;

		file.printf ( "<i>" );

		foreach ( DocElement element in this.content ) {
			element.write ( res, _max, _index );
			_index++;
		}

		file.printf ( "</i>" );
		return true;
	}
}

// remove
public class Valadoc.BoldHtmlHelperDocElement : BoldDocElement {
	private Gee.ArrayList<DocElement> content;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content ) {
		this.content = content;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		int _max = this.content.size;
		int _index = 0;

		file.printf ( "<b>" );

		foreach ( DocElement element in this.content ) {
			element.write ( res, _max, _index );
			_index++;
		}

		file.printf ( "</b>" );
		return true;
	}
}


// remove
public class Valadoc.RightAlignedHtmlHelperDocElement : RightAlignedDocElement {
	private Gee.ArrayList<DocElement> content;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content ) {
		this.content = content;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		int _max = this.content.size;
		int _index = 0;

		file.printf ( "<div align=\"right\">" );

		foreach ( DocElement element in this.content ) {
			element.write ( res, _max, _index );
			_index++;
		}

		file.printf ( "</div>" );
		return true;
	}
}




// remove
public class Valadoc.CenterHtmlHelperDocElement : CenterDocElement {
	private Gee.ArrayList<DocElement> content;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, Gee.ArrayList<DocElement> content ) {
		this.content = content;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		weak GLib.FileStream file = (GLib.FileStream)res;
		int _max = this.content.size;
		int _index = 0;

		file.printf ( "<div align=\"center\">" );

		foreach ( DocElement element in this.content ) {
			element.write ( res, _max, _index );
			_index++;
		}

		file.printf ( "</div>" );
		return true;
	}
}







// remove
public class Valadoc.ImageHtmlHelperDocElement : ImageDocElement {
	private ImageDocElementPosition position;
	private static uint counter = 0;

	private string htmlpath;
	private string npath;
	private string path;

	public override bool parse ( Settings settings, Tree tree, DocumentedElement me, string# path, ImageDocElementPosition pos ) {
		if ( GLib.FileUtils.test ( path, GLib.FileTest.EXISTS | GLib.FileTest.IS_REGULAR ) == false )
			return false;

		weak string? dotpos = path.rchr ( -1, '.' ); 
		this.htmlpath = GLib.Path.build_filename ( "img", "%u%s".printf ( this.counter++, (dotpos == null)? "" : dotpos.ndup ( dotpos.size() ) ) );
		this.npath = realpath ( GLib.Path.build_filename ( settings.path, me.package.name, this.htmlpath ) );
		this.path = realpath ( path );

		this.position = pos;
		return true;
	}

	public override bool write ( void* res, int max, int index ) {
		bool tmp = copy_file ( this.path, this.npath );
		if ( tmp == false )
			return false;

		switch ( this.position ) {
		case ImageDocElementPosition.NEUTRAL:
			((GLib.FileStream)res).printf ( "<img src=\"%s\" />", this.htmlpath );
			break;
		case ImageDocElementPosition.MIDDLE:
			((GLib.FileStream)res).printf ( "<img src=\"%s\" align=\"middle\"/>", this.htmlpath );
			break;
		case ImageDocElementPosition.RIGHT:
			((GLib.FileStream)res).printf ( "<img src=\"%s\" align=\"right\"/>", this.htmlpath );
			break;
		case ImageDocElementPosition.LEFT:
			((GLib.FileStream)res).printf ( "<img src=\"%s\" align=\"left\" />", this.htmlpath );
			break;
		}
		return true;
	}
}
*/


