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

using Valadoc;
using GLib;
using Gee;







public class Valadoc.LangletIndex : Valadoc.Langlet, Valadoc.LinkHelper {
	public Valadoc.Settings settings {
		construct set;
		protected get;
	}

	public LangletIndex ( Settings settings ) {
		this.settings = settings;
	}

	private Basic position = null;

	private inline bool is_basic_type ( string name ) {
		string[] basic_types = new string[] { "bool", "char", "uchar", "int", "uint", "short", "ushort",
				"long", "ulong", "size_t", "ssize_t", "int8", "uint8", "int16", "uint16", "int32",
				"uint32", "int64", "uint64", "float", "double", "time_t", "unichar", "string"
			};

		foreach ( string str in basic_types ) {
			if ( str == name )
				return true;
		}

		return false;
	}

	private void write_type_name ( DataType? datatype, GLib.FileStream file ) {
		if ( datatype == null ) {
			file.printf ( "<font class=\"%s\">void</font>", css_keyword );
			return ;
		}

		string typename = datatype.full_name ();
		if ( datatype.parent.name == null && (datatype is Class || datatype is Struct) ) {
			if ( this.is_basic_type ( typename ) ) {
				string link = this.get_link(datatype, this.position );
				if ( link == null )
					file.printf ( "<span class=\"%s\">%s</span>", css_basic_type, typename );
				else
					file.printf ( "<a class=\"%s\" href=\"%s\">%s</a>", css_basic_type, link, typename );
				return ;
			}
		}

		string link = this.get_link(datatype, this.position);
		if ( link == null )
		file.printf ( "<span class=\"%s\">%s</span>", css_other_type, typename );
		else
			file.printf ( "<a class=\"%s\" href=\"%s\">%s</a>", css_other_type, link, typename );
	}

	private void write_type_reference_name ( TypeReference type_reference, GLib.FileStream file ) {
		if ( type_reference.type_name == "void" ) {
			file.printf ( "<font class=\"%s\">void</font>", css_keyword );
		}
		else {
			if ( type_reference.data_type == null  ) {
				file.printf ( "<font class=\"%s\">%s</font>", css_other_type, type_reference.type_name );
			}
			else {
				this.write_type_name ( type_reference.data_type, file );
			}
		}
	}

	private void write_type_reference_template_arguments ( Valadoc.TypeReference type_reference, GLib.FileStream file ) {
		Gee.Collection<TypeReference> arglst = type_reference.get_type_arguments ( );
		int size = arglst.size;
		if ( size == 0 )
			return ;

		file.puts ( "<" );
		int i = 0;

		foreach ( TypeReference arg in arglst ) {
			i++;

			this.write_nested_type_referene ( arg, file );
			if ( i != size )
				file.puts ( ", " );
		}

		file.puts ( ">" );
	}

	private void write_nested_type_referene ( Valadoc.TypeReference type_reference, GLib.FileStream file ) {
		if ( type_reference.type_name == null )
			return ;

		if ( type_reference.is_weak )
			file.printf ( "<font class=\"%s\">weak</font> ", css_keyword );

		this.write_type_reference_name ( type_reference, file );
		this.write_type_reference_template_arguments ( type_reference, file );

		if ( type_reference.is_array ) {
			string str = string.nfill ( type_reference.array_rank-1, ',');
			file.printf ( "[%s]", str );
		}

		if ( type_reference.pass_ownership ) {
			file.putc ( '#' );
		}

		if ( type_reference.is_nullable ) {
			file.putc ( '?' );
		}

		string str = string.nfill ( type_reference.pointer_rank, '*' );
		file.puts ( str );

	}

	public override void write_type_reference ( Valadoc.TypeReference type_reference, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		if ( type_reference == null )
			return ;

		this.write_nested_type_referene ( type_reference, file );
		file.putc ( ' ' );

		/*
		if ( type_reference.is_weak ) {
			file.printf ( "<font class=\"%s\">weak</font> ", css_keyword );
		}

		this.write_type_name ( type_reference.data_type, file );

		if ( type_reference.is_array ) {
			string str = string.nfill ( type_reference.array_rank-1, ',');
			file.printf ( "[%s]", str );
		}

		if ( type_reference.pass_ownership ) {
			file.putc ( '#' );
		}

		if ( type_reference.is_nullable ) {
			file.putc ( '?' );
		}

		string str = string.nfill ( type_reference.pointer_rank, '*' );
		file.puts ( str );
		*/
	}

	private void write_formal_parameter ( FormalParameter param, GLib.FileStream file ) {
		if ( param.ellipsis ) {
			file.puts ( " ..." );
		}
		else {
			if ( param.is_out )
				file.printf ( "<span class=\"%s\">out</span> ", css_keyword );
			else if ( param.is_ref )
				file.printf ( "<span class=\"%s\">ref</span> ", css_keyword );

			this.write_type_reference ( param.type_reference, file );
			file.printf ( " %s", param.name );
		}
	}

	public override void write_parameter_list ( ParameterListHandler thandler, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		bool open_bracket = false;

		Gee.ArrayList<FormalParameter> params = thandler.param_list;
		int size = params.size;
		int i = 0;

		file.putc ( '(' );

		foreach ( FormalParameter param in params ) {
			i++;

			if ( param.default_value != null && open_bracket == false ) {
				file.printf ( "<span class=\"%s\">[", css_optional_parameter );
				open_bracket = true;
			}

			this.write_formal_parameter ( param, file );
			if ( i != size ) {
				file.puts ( ", " );
			}
			else if ( open_bracket == true ) {
				file.puts ( "]</span>" );
			}
		}

		file.putc ( ')' );
	}

	private void write_exception_list ( ExceptionHandler exception_handler, GLib.FileStream file ) {
		Gee.ReadOnlyCollection<TypeReference> error_domains = exception_handler.get_error_domains ();
		int size = error_domains.size;
		int i = 1;

		if ( size == 0 )
			return ;

		file.printf ( " <span class=\"%s\">throws</span> ", css_keyword );

		foreach ( TypeReference type_reference in error_domains ) {
			if ( type_reference == null ) {
				file.printf ( "<span class=\"%s\">GLib.Error</span>", css_other_type );
			}
			else {
				this.write_type_reference ( type_reference, file );
			}

			if ( error_domains.size > i ) {
				file.puts ( ", " );
			}
			i++;
		}
	}

	public override void write_method ( void* ptr, Valadoc.Method m, Valadoc.MethodHandler parent ) {
		this.position = m;

		GLib.StringBuilder modifiers = new GLib.StringBuilder ( "" );
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		this.write_accessor ( m, file );

		if ( m.is_abstract )
			modifiers.append ( " abstract" );
		if ( m.is_virtual )
			modifiers.append ( " virtual" );
		if ( m.is_override )
			modifiers.append ( " override" );
		if ( m.is_static )
			modifiers.append ( " static" );
		if ( m.is_inline )
			modifiers.append ( " inline" );

		file.printf ( " <span class=\"%s\">%s</span> ", css_keyword, modifiers.str );
		this.write_type_reference ( m.return_type, file );
		file.puts ( m.name );
		file.puts ( " " );
		this.write_parameter_list ( m, file );
		this.write_exception_list ( m, file );
	}

	public override void write_type_parameter ( TypeParameter param, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		file.puts ( param.datatype_name );
	}

	public override void write_template_parameters ( TemplateParameterListHandler thandler, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		int i = 1;

		var lst = thandler.get_template_param_list( );
		if ( lst.size == 0 )
			return ;

		file.puts ( "&lt;" ); // <

		foreach ( TypeParameter param in lst ) {
			param.write ( this, file );
			if ( lst.size > i )
				file.puts ( ", " );

			i++;
		}
		file.puts ( "&gt;" ); // >
	}

	public override void write_field ( Valadoc.Field field, Valadoc.FieldHandler parent, void* ptr ) {
		this.position = field;
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		this.write_accessor ( field, file );

		if ( field.is_volatile )
			file.printf ( " <span class=\"%s\">volatile</span>", css_keyword );

		this.write_type_reference ( field.type_reference, file );

		file.printf ( " %s", field.name );
	}

	public override void write_constant ( Constant constant, ConstantHandler parent, void* ptr ) {
		this.position = constant;
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		this.write_accessor ( constant, file );
		file.printf ( " <span class=\"%s\"> const </span>", css_keyword );
		this.write_type_reference ( constant.type_reference, file );
		file.printf ( " %s", constant.name );
	}

	public override void write_property_accessor ( Valadoc.PropertyAccessor propac, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		Property prop = (Property)propac.parent;

		if ( !(prop.is_public == propac.is_public && prop.is_private == propac.is_private && prop.is_protected == propac.is_protected) ) {
			// FIXME: PropertyAccessor isn't a SymbolAccessibility. (Valac-Bug.)
			if ( propac.is_public )
				file.printf ( "<span class=\"%s\">public</span> ", css_keyword );
			else if ( propac.is_protected )
				file.printf ( "<span class=\"%s\">protected</span> ", css_keyword );
			else if ( propac.is_private )
				file.printf ( "<span class=\"%s\">private</span> ", css_keyword );
		}


		if ( propac.is_get ) {
			file.printf ( "<span class=\"%s\"> get</span>;", css_keyword );
		}
		else if ( propac.is_set ) {
			if ( propac.is_construct ) {
				file.printf ( "<span class=\"%s\"> construct</span> ", css_keyword );
			}

			file.printf ( "<span class=\"%s\"> set</span>;", css_keyword );
		}
	}

	public override void write_property ( Valadoc.Property prop, void* ptr ) {
		this.position = prop;
		GLib.StringBuilder modifiers = new GLib.StringBuilder ( "" );
		weak GLib.FileStream file = (GLib.FileStream)ptr;

		this.write_accessor ( prop, file );

		if ( prop.is_virtual )
			modifiers.append ( " virtual " );
		if ( prop.is_abstract )
			modifiers.append ( " abstract " );
		if ( prop.is_override )
			modifiers.append ( " override " );


		this.write_type_reference ( prop.return_type, file );
		file.printf ( " <span class=\"%s\">%s</span>%s { ", css_keyword, modifiers.str, prop.name );

		if ( prop.setter != null )
			this.write_property_accessor ( prop.setter, file );


		file.printf ( " " );

		if ( prop.getter != null )
			this.write_property_accessor ( prop.getter, file );

		file.printf ( " }" );
	}

	public override void write_signal ( Valadoc.Signal sig, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		this.position = sig;

		this.write_accessor ( sig, file );

		file.printf ( " <span class=\"%s\">signal</span> ", css_keyword );
		this.write_type_reference ( sig.return_type, file );
		file.printf ( " %s ", sig.name );
		this.write_parameter_list ( sig, file );
	}

	public override void write_enum_value ( Valadoc.EnumValue enval, void* ptr ) {
	}

	public override void write_error_code ( Valadoc.ErrorCode errcode, void* ptr ) {
	}

	public override void write_delegate ( Valadoc.Delegate del, void* ptr ) {
		GLib.StringBuilder modifiers = new GLib.StringBuilder ( "" );
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		this.position = del;

		this.write_accessor ( del, file );

		file.printf ( " <span class=\"%s\">delegate</span> ", css_keyword );
		this.write_type_reference ( del.return_type, file );
		file.printf ( " %s ", del.name );
		this.write_parameter_list ( del, file );
		this.write_exception_list ( del, file );
	}

	public override void write_enum ( Valadoc.Enum en, void* ptr ) {
	}

	public override void write_error_domain ( Valadoc.ErrorDomain errdom, void* ptr ) {
	}

	private void write_accessor ( Valadoc.SymbolAccessibility element, GLib.FileStream file ) {
		if ( element.is_public )
			file.printf ( "<span class=\"%s\">public</span> ", css_keyword );
		else if ( element.is_protected )
			file.printf ( "<span class=\"%s\">protected</span> ", css_keyword );
		else if ( element.is_private )
			file.printf ( "<span class=\"%s\">private</span> ", css_keyword );
	}


	public override void write_struct ( Valadoc.Struct stru, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		this.position = stru;

		this.write_accessor ( stru, file );
		file.printf ( "<span class=\"%s\">struct</span> %s", css_keyword, stru.name );
		this.write_template_parameters ( stru, ptr );
		this.write_inheritance_list ( stru, file );
	}

	private void write_inheritance_list ( Valadoc.ContainerDataType dtype, GLib.FileStream file ) {
		Gee.Collection<DataType> lst = dtype.get_parent_types ( );
		int size = lst.size;
		int i = 1;

		if ( size == 0 )
			return ;

		file.puts ( " : " );

		foreach ( DataType cntype in lst ) {
			this.write_type_name ( cntype, file );
			if ( size > i )
				file.puts ( ", " );

			i++;
		}

		file.putc ( ' ' );
	}

	public override void write_class ( Valadoc.Class cl, void* ptr ) {
		GLib.StringBuilder modifiers = new GLib.StringBuilder ( "" );
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		this.position = cl;

		this.write_accessor ( cl, file );

		if ( cl.is_abstract )
			modifiers.append ( "abstract " );
		else if ( cl.is_static )
			modifiers.append ( "static " );

		file.printf ( "<span class=\"%s\">%s class</span> %s", css_keyword, modifiers.str, cl.name );

		this.write_template_parameters ( cl, file );
		this.write_inheritance_list ( cl, file );
	}

	public override void write_interface ( Valadoc.Interface iface, void* ptr ) {
		weak GLib.FileStream file = (GLib.FileStream)ptr;
		this.position = iface;

		this.write_accessor ( iface, file );

		if ( iface.is_static  )
			file.printf ( "<span class=\"%s\">static interface</span> %s", css_keyword, iface.name );
		else
			file.printf ( "<span class=\"%s\">interface</span> %s", css_keyword, iface.name );

		this.write_template_parameters ( iface, ptr );
		this.write_inheritance_list ( iface, file );
	}

	public override void write_namespace ( Valadoc.Namespace ns, void* ptr ) {
	}

	public override void write_file ( Valadoc.File file, void* ptr ) {
	}
}




private class NamespaceBundle : Object {
	public Namespace creation_namespace { construct set; get; }
	public NamespaceBundle? parent { construct set; get; }
	public string? name { construct set; get; }
	public string path { construct set; get; }

	public Gee.ArrayList<NamespaceBundle> subnamespaces = new Gee.ArrayList<NamespaceBundle> ();

	public string full_name () {
		return this.creation_namespace.full_name ();
	}

	public NamespaceBundle ( string path, string? name, Namespace creation_namespace, NamespaceBundle? parent = null ) {
		this.creation_namespace = creation_namespace;
		this.parent = parent;
		this.name = name;
		this.path = path;
	}

	private NamespaceBundle get_namespace_bundle ( Namespace ns ) {
		foreach ( NamespaceBundle bundle in this.subnamespaces ) {
			if ( this.name == ns.name ) {
				return bundle;
			}
		}

		NamespaceBundle nsbundle = new NamespaceBundle ( this.path + ns.name + "/", ns.name, ns, this );
		this.subnamespaces.add ( nsbundle );
		return nsbundle;
	}

	public Gee.ArrayList<ErrorDomain> errordomains = new Gee.ArrayList<ErrorDomain> ();
	public Gee.ArrayList<Interface> interfaces = new Gee.ArrayList<Interface> ();
	public Gee.ArrayList<Struct> structs = new Gee.ArrayList<Struct> ();
	public Gee.ArrayList<Class> classes = new Gee.ArrayList<Class> ();
	public Gee.ArrayList<Enum> enums = new Gee.ArrayList<Enum> ();

	public Gee.ArrayList<Constant> constants = new Gee.ArrayList<Constant> ();
	public Gee.ArrayList<Delegate> delegates = new Gee.ArrayList<Delegate> ();
	public Gee.ArrayList<Method> methods = new Gee.ArrayList<Method> ();
	public Gee.ArrayList<Field> fields = new Gee.ArrayList<Field> ();

	public void merge_namespace ( Namespace ns ) {
		Gee.Collection<Namespace> subnamespaces = ns.get_namespace_list ();
		foreach ( Namespace subns in subnamespaces ) {
			NamespaceBundle nsbundle = this.get_namespace_bundle ( subns );
			nsbundle.merge_namespace ( subns );
		}

		Gee.Collection<ErrorDomain> errordomains = ns.get_error_domain_list ();
		foreach ( ErrorDomain errdom in errordomains ) {
			this.errordomains.add ( errdom );
		}

		Gee.Collection<Interface> interfaces = ns.get_interface_list ();
		foreach ( Interface iface in interfaces ) {
			this.interfaces.add ( iface );
		}

		Gee.Collection<Struct> structs = ns.get_struct_list ();
		foreach ( Struct stru in structs ) {
			this.structs.add ( stru );
		}

		Gee.Collection<Class> classes = ns.get_class_list ();
		foreach ( Class cl in classes ) {
			this.classes.add ( cl );
		}

		Gee.Collection<Enum> enums = ns.get_enum_list ();
		foreach ( Enum en in enums ) {
			this.enums.add ( en );
		}

		Gee.Collection<Constant> constants = ns.get_constant_list ();
		foreach ( Constant c in constants ) {
			this.constants.add ( c );
		}

		Gee.Collection<Delegate> delegates = ns.get_delegate_list ();
		foreach ( Delegate d in delegates ) {
			this.delegates.add ( d );
		}

		Gee.Collection<Method> methods = ns.get_method_list ();
		foreach ( Method m in methods ) {
			this.methods.add ( m );
		}

		Gee.Collection<Field> fields = ns.get_field_list ();
		foreach ( Field f in fields ) {
			this.fields.add ( f );
		}
	}
}






public class Valadoc.HtmlDoclet : Valadoc.Doclet, Valadoc.LinkHelper {
	private Valadoc.LangletIndex langlet;

	private string current_path = null;
	private string package_name = null;
	private bool is_vapi = false;

	private int directory_level = 1;

	private void write_navi_entry_html_template ( GLib.FileStream file, string style, string content ) {
		file.printf ( "\t<li class=\"%s\">%s</li>\n", style, content );
	}

	private void write_navi_entry_html_template_with_link ( GLib.FileStream file, string style, string link, string content ) {
		file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", style, css_navi_link, link, content );
	}

	private void write_navi_entry ( GLib.FileStream file, Basic element, Basic pos, string style, bool link, bool full_name = false ) {
		string name;

		if ( element is File ) {
			string path = this.get_file_name ( element );
			name = this.get_package_name ( path );
		}
		else if ( full_name == true && element is Namespace ) {
			string tmp = ((Namespace)element).full_name ();
			name = (element.name == null)? "Global Namespace" : tmp;
		}
		else {
			string tmp = element.name;
			name = (tmp == null)? "Global Namespace" : tmp;
		}

		if ( link == true )
			this.write_navi_entry_html_template_with_link ( file, style, this.get_link (element, pos), name );
		else
			this.write_navi_entry_html_template ( file, style, name );
	}

	private void write_navi_top_entry ( GLib.FileStream file, Basic element, Basic mself ) {
		string name = (element.name == null)? "Global Namespace" : element.name;
		string style = null;

		if ( element is Namespace )
			style = css_navi_namespace;
		else if ( element is Enum )
			style = css_navi_enum;
		else if ( element is ErrorDomain )
			style = css_navi_error_domain;
		else if ( element is Struct )
			style = css_navi_struct;
		else if ( element is Class )
			style = css_navi_class;
		else if ( element is Interface )
			style = css_navi_iface;
		else if ( element is File ) {
			name = this.get_package_name ( element.name );
			style = css_navi_package;
		}

		file.printf ( "<ul class=\"%s\">\n", css_navi );

		if ( element == mself )
			this.write_navi_entry ( file, element, mself, style, false );
		else
			this.write_navi_entry ( file, element, mself, style, true );

		file.puts ( "</ul>\n" );
		file.printf ( "\n<hr class=\"%s\">\n", css_navi_hr );
	}


	private void write_top_element_template ( GLib.FileStream file, string link ) {
		file.printf ( "<ul class=\"%s\">\n\t\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">Packages</a></li>\n</ul>\n<hr class=\"%s\">\n", css_navi, css_navi_package_index, css_navi_link, link, css_navi_hr );
	}

	private void write_top_element ( GLib.FileStream file, Basic pos ) {
		string top = this.get_top_link ( pos );
		this.write_top_element_template ( file, top+"index.html" );
	}

	private void write_top_elements ( GLib.FileStream file, Basic element, Basic? mself ) {
		Gee.ArrayList<Basic> lst = new Gee.ArrayList<Basic> ();
		Basic pos = element;

		if ( mself == null )
			mself = element;

		string file_name = this.get_file_name ( element );
		string package_name = this.get_package_name ( file_name );

		this.write_top_element ( file, mself );

		while ( pos != null ) {
			lst.add ( pos );
			pos = pos.parent;
		}

		for ( int i = lst.size-1; i >= 0  ; i-- ) {
			Basic el = lst.get ( i );
			this.write_navi_top_entry ( file, el, mself );
		}
	}


	private void fetch_subnamespace_names ( NamespaceHandler pos, Gee.ArrayList<Namespace> lst ) {
		Gee.ReadOnlyCollection<Namespace> nspaces = pos.get_namespace_list ();

		foreach ( Namespace ns in nspaces ) {
			lst.add ( ns );
			this.fetch_subnamespace_names ( ns, lst );
		}
	}

	private void write_navi_file ( GLib.FileStream file, File efile ) {
		Gee.ArrayList<Namespace> ns_list = new Gee.ArrayList<Namespace> ();
		this.fetch_subnamespace_names (efile, ns_list );

		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_element_template ( file, "../index.html" );
		file.printf ( "\t\t\t\t<ul class=\"%s\">\n", css_navi );

		foreach ( Namespace ns in ns_list ) {
			this.write_navi_entry ( file, ns, efile, css_navi_namespace, true, true );
		}

		file.puts ( "\t\t\t\t</ul>\n" );
		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_navi_namespace ( GLib.FileStream file, Namespace ns ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, ns, ns );
		this.write_navi_child_namespaces_inline ( file, ns, ns );
		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_navi_child_namespaces_inline ( GLib.FileStream file, Namespace ns, Basic mself ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );
		this.write_navi_child_namespaces_without_childs ( file, ns, mself );
		this.write_navi_child_error_domains_without_childs ( file, ns, mself );
		this.write_navi_child_enums_without_childs ( file, ns, mself );
		this.write_navi_child_classes_without_childs ( file, ns, mself );
		this.write_navi_child_interfaces_without_childs ( file, ns, mself );
		this.write_navi_child_structs_without_childs ( file, ns, mself );
		this.write_navi_child_delegates ( file, ns, mself );
		this.write_navi_child_constants ( file, ns, mself );
		this.write_navi_child_fields ( file, ns, mself );
		this.write_navi_child_methods ( file, ns, mself );
		file.puts ( "</ul>\n" );
	}

	private void write_navi_child_namespaces ( GLib.FileStream file, Namespace ns, Basic mself ) {
		this.write_top_elements ( file, ns, mself );
		this.write_navi_child_namespaces_inline ( file, ns, mself );
	}

	private void write_navi_struct_inline ( GLib.FileStream file, Struct stru, Basic mself ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );
		this.write_navi_child_constants ( file, stru, mself );
		this.write_navi_child_construction_methods ( file, stru, mself );
		this.write_navi_child_fields ( file, stru, mself );
		this.write_navi_child_methods ( file, stru, mself );
		file.puts ( "</ul>\n" );
	}

	private void write_navi_struct ( GLib.FileStream file, Struct stru, Basic mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, stru, mself );
		this.write_navi_struct_inline ( file, stru, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_navi_interface_inline ( GLib.FileStream file, Interface iface, Basic mself ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );
		this.write_navi_child_delegates ( file, iface, mself );
		this.write_navi_child_fields ( file, iface, mself );
		this.write_navi_child_properties ( file, iface, mself );
		this.write_navi_child_methods ( file, iface, mself );
		this.write_navi_child_signals ( file, iface, mself );
		file.puts ( "</ul>\n" );
	}

	private void write_navi_interface ( GLib.FileStream file, Interface iface, Basic mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, iface, mself );
		this.write_navi_interface_inline ( file, iface, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_navi_enum_inline ( GLib.FileStream file, Enum en, Basic mself ) {
		Gee.ReadOnlyCollection<EnumValue> enum_values = en.get_enum_values ( );
		file.printf ( "<ul class=\"%s\">\n", css_navi );

		foreach ( EnumValue env in enum_values ) {
			this.write_navi_entry ( file, env, mself, css_navi_enval, true );
		}

		this.write_navi_child_methods ( file, en, mself );
		file.puts ( "</ul>\n" );
	}

	private void write_navi_enum ( GLib.FileStream file, Enum en, Basic mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, en, mself );
		this.write_navi_enum_inline ( file, en, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_navi_error_domain_inline ( GLib.FileStream file, ErrorDomain errdom, Basic mself ) {
		Gee.ReadOnlyCollection<ErrorCode> error_codes = errdom.get_error_code_list ( );
		file.printf ( "<ul class=\"%s\">\n", css_navi );

		foreach ( ErrorCode ec in error_codes ) {
			this.write_navi_entry ( file, ec, mself, css_navi_errdomcode, true );
		}

		this.write_navi_child_methods ( file, errdom, mself );
		file.puts ( "</ul>\n" );
	}

	private void write_navi_error_domain ( GLib.FileStream file, ErrorDomain errdom, Basic mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, errdom, mself );
		this.write_navi_error_domain_inline ( file, errdom, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_navi_class_inline ( GLib.FileStream file, Class cl, Basic mself ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );
		this.write_navi_child_enums_without_childs ( file, cl, mself );
		this.write_navi_child_classes_without_childs ( file, cl, mself );
		this.write_navi_child_structs_without_childs ( file, cl, mself );
		this.write_navi_child_delegates ( file, cl, mself );
		this.write_navi_child_constants ( file, cl, mself );
		this.write_navi_child_construction_methods ( file, cl, mself );
		this.write_navi_child_fields ( file, cl, mself );
		this.write_navi_child_properties ( file, cl, mself );
		this.write_navi_child_methods ( file, cl, mself );
		this.write_navi_child_signals ( file, cl, mself );
		file.puts ( "</ul>\n" );
	}

	private void write_navi_class ( GLib.FileStream file, Class cl, Basic mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, cl, mself );
		this.write_navi_class_inline ( file, cl, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_navi_method ( GLib.FileStream file, Method m ) {
		Basic parent = m.parent;

		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );

		this.write_top_elements ( file, parent, m );

		if ( parent is Class )
			this.write_navi_class_inline ( file, (Class)parent, m );
		else if ( m.parent is Interface )
			this.write_navi_interface_inline ( file, (Interface)parent, m );
		else if ( m.parent is Struct )
			this.write_navi_struct_inline ( file, (Struct)parent, m );
		else if ( m.parent is Enum )
			this.write_navi_enum_inline ( file, (Enum)parent, m );
		else if ( m.parent is ErrorDomain )
			this.write_navi_error_domain_inline ( file, (ErrorDomain)parent, m );
		else if ( m.parent is Namespace )
			this.write_navi_child_namespaces_inline ( file, (Namespace)parent, m );

		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_navi_property ( GLib.FileStream file, Property prop ) {
		Basic parent = prop.parent;

		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, prop.parent, prop );

		if ( parent is Class )
			this.write_navi_class_inline ( file, (Class)parent, prop );
		else if ( parent is Interface )
			this.write_navi_interface_inline ( file, (Interface)parent, prop );

		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_navi_signal ( GLib.FileStream file, Signal sig ) {
		Basic parent = sig.parent;

		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );

		this.write_top_elements ( file, sig.parent, sig );

		if ( parent is Class )
			this.write_navi_class_inline ( file, (Class)parent, sig );
		else if ( parent is Interface )
			this.write_navi_interface_inline ( file, (Interface)parent, sig );

		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_navi_constant ( GLib.FileStream file, Constant c ) {
		Basic parent = c.parent;

		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, parent, c );

		if ( parent is Class )
			this.write_navi_class_inline ( file, (Class)parent, c );
		else  if ( parent is Struct )
			this.write_navi_struct_inline ( file, (Struct)parent, c );
		else  if ( parent is Namespace )
			this.write_navi_child_namespaces_inline ( file, (Namespace)parent, c );
		//else if ( parent is Interface )
		//	this.write_navi_interface_inline ( file, (Interface)parent, c );

		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_navi_field ( GLib.FileStream file, Field f ) {
		Basic parent = f.parent;

		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, parent, f );

		if ( parent is Class )
			this.write_navi_class_inline ( file, (Class)parent, f );
		else if ( parent is Struct )
			this.write_navi_struct_inline ( file, (Struct)parent, f );
		else if ( parent is Namespace )
			this.write_navi_child_namespaces_inline ( file, (Namespace)parent, f );
		else if ( parent is Interface )
			this.write_navi_interface_inline ( file, (Interface)parent, f );

		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_navi_delegate ( GLib.FileStream file, Delegate del ) {
		Basic parent = del.parent;

		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, parent, del );

		if ( parent is Namespace )
			this.write_navi_child_namespaces_inline ( file, (Namespace)parent, del );
		else if ( parent is Class )
			this.write_navi_class_inline ( file, (Class)parent, del );
		else if ( parent is Interface )
			this.write_navi_interface_inline ( file, (Interface)parent, del );

		file.puts ( "\t\t\t</div>\n" );
	}


	private void write_navi_child_methods_collection ( GLib.FileStream file, Gee.Collection<Method> methods, Basic mself ) {
		foreach ( Method m in methods ) {
			if ( m == mself )
				this.write_navi_entry ( file, m, mself, css_navi_construction_method, false );
			else
				this.write_navi_entry ( file, m, mself, css_navi_construction_method, true );
		}
	}

	private void write_navi_child_methods ( GLib.FileStream file, MethodHandler mh, Basic mself ) {
		Gee.ReadOnlyCollection<Method> methods = mh.get_method_list ( );
		this.write_navi_child_methods_collection ( file, methods, mself );
	}

	private void write_navi_child_classes_without_childs_collection ( GLib.FileStream file, Gee.Collection<Class> classes, Basic mself ) {
		foreach ( Class cl in classes ) {
			if ( cl == mself )
				this.write_navi_entry ( file, cl, mself, css_navi_class, false );
			else
				this.write_navi_entry ( file, cl, mself, css_navi_class, true );
		}
	}

	private void write_navi_child_classes_without_childs ( GLib.FileStream file, ClassHandler clh, Basic mself ) {
		Gee.ReadOnlyCollection<Class> classes = clh.get_class_list ( );
		this.write_navi_child_classes_without_childs_collection ( file, classes, mself );
	}

	private void write_navi_child_construction_methods ( GLib.FileStream file, ConstructionMethodHandler cmh, Basic mself ) {
		Gee.ReadOnlyCollection<Method> methods = cmh.get_construction_method_list ( );
		this.write_navi_child_methods_collection ( file, methods, mself );
	}

	private void write_navi_child_signals ( GLib.FileStream file, SignalHandler sh, Basic mself ) {
		Gee.ReadOnlyCollection<Signal> signals = sh.get_signal_list ( );

		foreach ( Signal sig in signals ) {
			if ( sig == mself )
				this.write_navi_entry ( file, sig, mself, css_navi_sig, false );
			else
				this.write_navi_entry ( file, sig, mself, css_navi_sig, true );
		}
	}

	private void write_navi_child_properties ( GLib.FileStream file, PropertyHandler ph, Basic mself ) {
		Gee.ReadOnlyCollection<Property> properties = ph.get_property_list ( );

		foreach ( Property p in properties ) {
			if ( p == mself )
				this.write_navi_entry ( file, p, mself, css_navi_prop, false );
			else
				this.write_navi_entry ( file, p, mself, css_navi_prop, true );
		}
	}

	private void write_navi_child_fields_collection ( GLib.FileStream file, Gee.Collection<Field> fields, Basic mself ) {
		foreach ( Field f in fields ) {
			if ( f == mself )
				this.write_navi_entry ( file, f, mself, css_navi_field, false );
			else
				this.write_navi_entry ( file, f, mself, css_navi_field, true );
		}
	}

	private void write_navi_child_fields ( GLib.FileStream file, FieldHandler fh, Basic mself ) {
		Gee.ReadOnlyCollection<Field> fields = fh.get_field_list ( );
		this.write_navi_child_fields_collection ( file, fields, mself );
	}

	private void write_navi_child_constants_collection ( GLib.FileStream file, Gee.Collection<Constant> constants, Basic mself ) {
		foreach ( Constant c in constants ) {
			if ( c == mself )
				this.write_navi_entry ( file, c, mself, css_navi_constant, false );
			else
				this.write_navi_entry ( file, c, mself, css_navi_constant, true );
		}
	}

	private void write_navi_child_constants ( GLib.FileStream file, ConstantHandler ch, Basic mself ) {
		Gee.ReadOnlyCollection<Constant> constants = ch.get_constant_list ( );
		this.write_navi_child_constants_collection ( file, constants, mself );
	}

	private void write_navi_child_structs_without_childs_collection ( GLib.FileStream file, Gee.Collection<Struct> structs, Basic mself ) {
		foreach ( Struct stru in structs ) {
			if ( stru == mself )
				this.write_navi_entry ( file, stru, mself, css_navi_struct, false );
			else
				this.write_navi_entry ( file, stru, mself, css_navi_struct, true );
		}
	}

	private void write_navi_child_structs_without_childs ( GLib.FileStream file, StructHandler strh, Basic mself ) {
		Gee.Collection<Struct> structs = strh.get_struct_list ( );
		this.write_navi_child_structs_without_childs_collection ( file, structs, mself );
	}

	private void write_navi_child_delegates_collection ( GLib.FileStream file, Gee.Collection<Delegate> delegates, Basic mself ) {
		foreach ( Delegate del in delegates ) {
			if ( del == mself )
				this.write_navi_entry ( file, del, mself, css_navi_del, false );
			else
				this.write_navi_entry ( file, del, mself, css_navi_del, true );
		}
	}

	private void write_navi_child_delegates ( GLib.FileStream file, DelegateHandler delh, Basic mself ) {
		Gee.Collection<Delegate> delegates = delh.get_delegate_list ( );
		this.write_navi_child_delegates_collection ( file, delegates, mself );
	}

	private void write_navi_child_interfaces_without_childs_collection ( GLib.FileStream file, Gee.Collection<Interface> interfaces, Basic mself ) {
		foreach ( Interface iface in interfaces ) {
			if ( iface == mself )
				this.write_navi_entry ( file, iface, mself, css_navi_iface, false );
			else
				this.write_navi_entry ( file, iface, mself, css_navi_iface, true );
		}
	}

	private void write_navi_child_interfaces_without_childs ( GLib.FileStream file, Namespace ifh, Basic mself ) {
		Gee.Collection<Interface> interfaces = ifh.get_interface_list ( );
		this.write_navi_child_interfaces_without_childs_collection ( file, interfaces, mself );
	}

	private void write_navi_child_enums_without_childs_collection ( GLib.FileStream file, Gee.Collection<Enum> enums, Basic mself ) {
		foreach ( Enum en in enums ) {
			if ( en == mself )
				this.write_navi_entry ( file, en, mself, css_navi_enum, false );
			else
				this.write_navi_entry ( file, en, mself, css_navi_enum, true );
		}
	}

	private void write_navi_child_enums_without_childs ( GLib.FileStream file, EnumHandler eh, Basic mself ) {
		Gee.Collection<Enum> enums = eh.get_enum_list ( );
		this.write_navi_child_enums_without_childs_collection ( file, enums, mself );
	}

	private void write_navi_child_error_domains_without_childs_collection ( GLib.FileStream file, Gee.Collection<ErrorDomain> errordomains, Basic mself ) {
		foreach ( ErrorDomain errdom in errordomains ) {
			if ( errdom == mself )
				this.write_navi_entry ( file, errdom, mself, css_navi_error_domain, false );
			else
				this.write_navi_entry ( file, errdom, mself, css_navi_error_domain, true );
		}
	}

	private void write_navi_child_error_domains_without_childs ( GLib.FileStream file, Namespace errdomh, Basic mself ) {
		Gee.Collection<ErrorDomain> errordomains = errdomh.get_error_domain_list ( );
		this.write_navi_child_error_domains_without_childs_collection ( file, errordomains, mself );
	}

	private void write_navi_child_namespaces_without_childs ( GLib.FileStream file, NamespaceHandler nsh, Basic mself ) {
		Gee.ReadOnlyCollection<Namespace> namespaces = nsh.get_namespace_list ( );
		foreach ( Namespace ns in namespaces ) {
			if ( ns == mself )
				this.write_navi_entry ( file, ns, mself, css_navi_namespace, false );
			else
				this.write_navi_entry ( file, ns, mself, css_navi_namespace, true );
		}
	}

	private string get_full_path ( Basic element ) {
		if ( element.name == null )
			return "";

		GLib.StringBuilder str = new GLib.StringBuilder ( "" );

		for ( var pos = element; pos != null ; pos = pos.parent ) {
			if ( pos is File )
				break;

			str.prepend_unichar ( '/' );

			if ( pos.name == null )
				str.prepend ( "0" );
			else
				str.prepend ( pos.name );
		}

		string file_path = get_file_name ( element );
		string package_name = get_package_name ( file_path )  + "/";

		str.prepend ( package_name );
		str.append_unichar ( '/' );
		return str.str;
	}

	public Valadoc.Settings settings {
		construct set;
		protected get;
	}

	public override void initialisation ( Settings settings ) {
		this.settings = settings;

		var rt = DirUtils.create ( this.settings.path, 0777 );
		this.langlet = new Valadoc.LangletIndex ( settings );
	}

	private void write_image_block ( GLib.FileStream file, DataType element ) {
		string realimgpath = this.current_path + "tree.png";
		string imgpath = "tree.png";

		if ( element is Class ) {
			Diagrams.write_class_diagram ( (Class)element, realimgpath );
		}
		else if ( element is Interface ) {
			Diagrams.write_interface_diagram ( (Interface)element, realimgpath );
		}
		else if ( element is Struct ) {
			Diagrams.write_struct_diagram ( (Struct)element, realimgpath );
		}

		file.printf ( "<h2 cass=\"%s\">Object Hierarchy:</h2>\n", css_title );
		file.printf ( "<img cass=\"%s\" src=\"%s\"/>\n", css_diagram, imgpath );
	}

	private void write_file_content ( GLib.FileStream file, File f ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, this.package_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.puts ( "\t\t\t</div>\n" );
	}

	private Gee.ArrayList<File> files = new Gee.ArrayList<File> ();

	public override void visit_file ( File file ) {
		this.package_name = this.get_package_name ( file.name );
		this.is_vapi = file.name.has_suffix (".vapi");
		this.files.add ( file );

		string new_path = this.settings.path + this.package_name + "/";
		bool dir_exists = FileUtils.test ( new_path, FileTest.EXISTS);

		if ( !dir_exists ) {
			var rt = DirUtils.create ( new_path, 0777 );

			GLib.FileStream sfile = GLib.FileStream.open ( new_path + "index.html", "w" );
			this.write_file_header ( sfile );
			this.write_navi_file ( sfile, file );
			this.write_file_content ( sfile, file );
			this.write_file_footer ( sfile );
			sfile = null;
		}

		this.current_path = new_path;
		file.visit_namespaces ( this );
		this.current_path = null;
	}


//	private Gee.ArrayList<Namespace> namespaces = new Gee.ArrayList<Namespace> ();
//  globale Funktionen
//  globale Konstante
//  globale Delegates
//  globale Felder

	private Gee.ArrayList<NamespaceBundle> namespaces = new Gee.ArrayList<NamespaceBundle> ();

	private void add_namespace_bundle ( Namespace ns ) {
		if ( ns.parent is Namespace )
			return ;

		foreach ( NamespaceBundle bundle in this.namespaces ) {
			if ( bundle.name == ns.name ) {
				bundle.merge_namespace ( ns );
				return ;
			}
		}

		NamespaceBundle bundle = new NamespaceBundle ( this.current_path, ns.name, ns );
		this.namespaces.add ( bundle );
		bundle.merge_namespace ( ns );
	}

	private void write_navi_namespace_bundle_path_navigation ( NamespaceBundle nsbundle, GLib.FileStream navi, Basic mself ) {
		this.directory_level++;

		string top_link = this.get_top_link ( (mself == null)? nsbundle.creation_namespace : mself );

		Gee.ArrayList<NamespaceBundle> parents = new Gee.ArrayList<NamespaceBundle> ();
		for ( NamespaceBundle nsb = nsbundle.parent; nsb != null ; nsb = nsb.parent ) {
			parents.insert ( 0, nsb );
		}

		navi.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_element ( navi, mself );

		navi.printf ( "<ul class=\"%s\">\n", css_navi );
		this.write_navi_entry_html_template_with_link ( navi, css_navi_package, top_link + this.package_name + "/index.html", this.package_name );
		navi.puts ( "</ul>\n" );
		navi.printf ( "<hr class=\"%s\">\n", css_navi_hr );

		int indent = parents.size;

		foreach ( NamespaceBundle nsb in parents ) {
			string ns_link = "";

			for ( int i = 0; indent > i ; i++ )
				ns_link += "../";

			ns_link += "index.html";

			navi.printf ( "<ul class=\"%s\">\n", css_navi );
			this.write_navi_entry_html_template_with_link ( navi, css_navi_namespace, ns_link, (nsb.name == null)? "Global Namespace" : nsb.name );
			navi.puts ( "</ul>\n" );
			navi.printf ( "\n<hr class=\"%s\">\n", css_navi_hr );
		}

		navi.printf ( "<ul class=\"%s\">\n", css_navi );
		if ( mself.name == nsbundle.name ) {
			this.write_navi_entry_html_template ( navi, css_navi_namespace, (nsbundle.name == null)? "Global Namespace" : nsbundle.name );
		}
		else {
			this.write_navi_entry_html_template_with_link ( navi, css_navi_namespace, "../index.html", (nsbundle.name == null)? "Global Namespace" : nsbundle.name );
		}
		navi.puts ( "</ul>\n" );
		navi.printf ( "\n<hr class=\"%s\">\n", css_navi_hr );

		navi.printf ( "<ul class=\"%s\">\n", css_navi );
		foreach ( NamespaceBundle nsb in nsbundle.subnamespaces ) {
			this.write_navi_entry_html_template_with_link ( navi, css_navi_namespace, nsb.name + "/index.html", (nsb.name == null)? "Global Namespace" : nsb.name );
		}
		this.write_navi_child_classes_without_childs_collection ( navi, nsbundle.classes, mself );
		this.write_navi_child_methods_collection ( navi, nsbundle.methods, mself );
		this.write_navi_child_fields_collection ( navi, nsbundle.fields, mself );
		this.write_navi_child_constants_collection ( navi, nsbundle.constants, mself );
		this.write_navi_child_structs_without_childs_collection ( navi, nsbundle.structs, mself );
		this.write_navi_child_delegates_collection ( navi, nsbundle.delegates, mself );
		this.write_navi_child_interfaces_without_childs_collection ( navi, nsbundle.interfaces, mself );
		this.write_navi_child_enums_without_childs_collection ( navi, nsbundle.enums, mself );
		this.write_navi_child_error_domains_without_childs_collection ( navi, nsbundle.errordomains, mself );
		navi.puts ( "</ul>\n" );
		navi.puts ( "\t\t\t</div>\n" );

		this.directory_level--;
	}

	private void write_navi_namespace_bundle ( NamespaceBundle nsbundle, Basic mself ) {
		this.directory_level++;

		foreach ( NamespaceBundle subnsbundle in nsbundle.subnamespaces ) {
			this.write_navi_namespace_bundle ( subnsbundle, mself );
		}


		this.directory_level++;
		foreach ( Constant c in nsbundle.constants ) {
			GLib.FileStream file = GLib.FileStream.open ( nsbundle.path + c.name + "/index.html", "w" );
			this.write_file_header ( file );
			this.write_navi_namespace_bundle_path_navigation ( nsbundle, file, c );
			this.write_constant_content ( file, c, (ConstantHandler)c.parent );
			this.write_file_footer ( file );
		}
		foreach ( Delegate del in nsbundle.delegates ) {
			GLib.FileStream file = GLib.FileStream.open ( nsbundle.path + del.name + "/index.html", "w" );
			this.write_file_header ( file );
			this.write_navi_namespace_bundle_path_navigation ( nsbundle, file, del );
			this.write_delegate_content ( file, del );
			this.write_file_footer ( file );
		}
		foreach ( Method m in nsbundle.methods ) {
			GLib.FileStream file = GLib.FileStream.open ( nsbundle.path + m.name + "/index.html", "w" );
			this.write_file_header ( file );
			this.write_navi_namespace_bundle_path_navigation ( nsbundle, file, m );
			this.write_method_content ( file, m, (MethodHandler)m.parent );
			this.write_file_footer ( file );
		}
		foreach ( Field f in nsbundle.fields ) {
			GLib.FileStream file = GLib.FileStream.open ( nsbundle.path + f.name + "/index.html", "w" );
			this.write_file_header ( file );
			this.write_navi_namespace_bundle_path_navigation ( nsbundle, file, f );
			this.write_field_content ( file, f, (FieldHandler)f.parent );
			this.write_file_footer ( file );
		}
		this.directory_level--;

		GLib.FileStream file = GLib.FileStream.open ( nsbundle.path + "index.html", "w" );
		this.write_file_header ( file );
		this.write_navi_namespace_bundle_path_navigation ( nsbundle, file, (mself == null)? nsbundle.creation_namespace : mself );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, (nsbundle.name == null)? "Global Namespace" : nsbundle.full_name () );
		file.printf ( "<hr class=\"%s\" />\n", css_hr );
		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.puts ( "\t\t\t</div>\n" );
		this.write_file_footer ( file );

		this.directory_level--;
	}

	private bool copy_file ( string src, string dest ) {
		GLib.FileStream fsrc = GLib.FileStream.open ( src, "rb" );
		GLib.FileStream fdest = GLib.FileStream.open ( dest, "wb" );
		if ( fsrc == null || fdest == null )
			return false;

		for ( int c = fsrc.getc() ; !fsrc.eof() ; c = fsrc.getc() ) {
			fdest.putc ( (char)c );
		}

		return true;
	}

	private void copy_deps ( ) {
		string path = Config.doclet_path + "deps/";

		GLib.Dir dir = GLib.Dir.open ( path );
		for ( weak string name = dir.read_name (); name != null ; name = dir.read_name () ) {
			this.copy_file ( path+name, this.settings.path+name );
		}
	}

	private bool is_depency ( string dep ) {
		foreach ( string file in this.settings.files ) {
			if ( dep == file )
				return false;
		}
		return true;
	}

	~HtmlDoclet () {
		this.directory_level = 1;
		copy_deps ( );

		foreach ( NamespaceBundle nsbundle in this.namespaces ) {
			this.write_navi_namespace_bundle ( nsbundle, null );
		}

		GLib.FileStream sfile = GLib.FileStream.open ( this.settings.path + "index.html", "w" );
		string title = ( this.settings.package_name == null )? "" : this.settings.package_name;
		this.write_file_header_template ( sfile, title, 0 );

		sfile.printf ( "<h2 class=\"%s\">Namespaces:</h2>\n", css_title );
		sfile.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
		foreach ( NamespaceBundle nsb in this.namespaces ) {
			string dir = (nsb.name == null)? "0" : nsb.name;
			this.write_navi_entry_html_template_with_link ( sfile, css_inline_navigation_namespace,  this.package_name + "/" + dir + "/index.html", (nsb.name == null)? "Global Namespace" : nsb.name );
		}
		sfile.puts ( "</ul>\n\n" );


		sfile.printf ( "<h2 class=\"%s\">Depencies:</h2>\n", css_title );
		sfile.printf ( "<ul class=\"%s\">\n", css_inline_navigation );

		foreach ( File file in this.files ) {
			if ( !this.is_depency ( file.name ) )
				continue;

			if ( this.settings.with_deps )
				sfile.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s/index.html\">%s</a></li>\n", css_inline_navigation_package, css_navi_link, this.get_package_name(file.name), this.get_package_name(file.name) );
			else
				sfile.printf ( "\t<li class=\"%s\">%s</li>\n", css_inline_navigation_package, this.get_package_name(file.name) );
		}

		sfile.puts ( "</ul>\n" );

		this.write_file_footer ( sfile );
		sfile = null;
	}

	public void write_namespace_content ( GLib.FileStream file, Namespace ns ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, (ns.name == null)? "Global Namespace" : ns.full_name () );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		ns.write_comment ( file );
		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_child_classes ( GLib.FileStream file, ClassHandler clh ) {
		Gee.ReadOnlyCollection<Class> classes = clh.get_class_list ();
		if ( classes.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Classes:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Class subcl in classes ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_class, css_navi_link, this.get_link(subcl, clh), subcl.name );
			}
			file.puts ( "</ul>\n" );
		}
	}

	private void write_child_enums ( GLib.FileStream file, EnumHandler eh ) {
		Gee.Collection<Enum> enums = eh.get_enum_list ();
		if ( enums.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Enums:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Enum en in enums ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_enum, css_navi_link, this.get_link(en, eh), en.name );
			}
			file.puts ( "</ul>\n" );
		}
	}

	private void write_child_structs ( GLib.FileStream file, StructHandler struh ) {
		Gee.Collection<Struct> structs = struh.get_struct_list ();
		if ( structs.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Structs:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Struct stru in structs ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_struct, css_navi_link, this.get_link(stru, struh), stru.name );
			}
			file.puts ( "</ul>\n" );
		}
	}

	private void write_child_methods ( GLib.FileStream file, MethodHandler mh ) {
		Gee.ReadOnlyCollection<Method> methods = mh.get_method_list ();
		if ( methods.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Methods:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Method m in methods ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_method, css_navi_link, this.get_link(m, mh), m.name );
			}
			file.puts ( "</ul>\n" );
		}
	}

	private void write_child_delegates ( GLib.FileStream file, DelegateHandler dh ) {
		Gee.Collection<Delegate> delegates = dh.get_delegate_list ();
		if ( delegates.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Delegates:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Delegate d in delegates ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_delegate, css_navi_link, this.get_link(d, dh), d.name );
			}
			file.puts ( "</ul>\n" );
		}
	}

	private void write_child_construction_methods ( GLib.FileStream file, ConstructionMethodHandler cmh ) {
		Gee.ReadOnlyCollection<Method> methods = cmh.get_construction_method_list ();
		if ( methods.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Construction Methods:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Method m in methods ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_method, css_navi_link, this.get_link(m, cmh), m.name );
			}
			file.puts ( "</ul>\n" );
		}
	}

	private void write_child_signals ( GLib.FileStream file, SignalHandler sh ) {
		Gee.ReadOnlyCollection<Signal> signals = sh.get_signal_list ();
		if ( signals.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Signals:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Signal sig in signals ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_signal, css_navi_link, this.get_link(sig, sh), sig.name );
			}
			file.puts ( "</ul>\n" );
		}
	}

	private void write_child_properties ( GLib.FileStream file, PropertyHandler ph ) {
		Gee.ReadOnlyCollection<Property> properties = ph.get_property_list ();
		if ( properties.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Properties:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Property prop in properties ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_property, css_navi_link, this.get_link(prop, ph), prop.name );
			}
			file.puts ( "</ul>\n" );
		}
	}

	private void write_child_fields ( GLib.FileStream file, FieldHandler fh ) {
		Gee.ReadOnlyCollection<Field> fields = fh.get_field_list ();
		if ( fields.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Fields:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Field f in fields ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_fields, css_navi_link, this.get_link(f, fh), f.name );
			}
			file.puts ( "</ul>\n" );
		}
	}

	private void write_child_constants ( GLib.FileStream file, ConstantHandler ch ) {
		Gee.ReadOnlyCollection<Constant> constants = ch.get_constant_list ();
		if ( constants.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Constants:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Constant c in constants ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_constant, css_navi_link, this.get_link(c, ch), c.name );
			}
			file.puts ( "</ul>\n" );
		}
	}

	private void write_child_error_values ( GLib.FileStream file, ErrorDomain errdom ) {
		Gee.ReadOnlyCollection<ErrorCode> error_codes = errdom.get_error_code_list ();
		if ( error_codes.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Error Codes:</h3>\n", css_title );
			file.printf ( "<table class=\"%s\">\n", css_errordomain_table );
			foreach ( ErrorCode errcode in error_codes ) {
				file.puts ( "<tr>\n" );
				file.printf ( "\t<td class=\"%s\" id=\"%s\">%s</td>\n", css_errordomain_table_name, errcode.name, errcode.name );
				file.printf ( "\t<td class=\"%s\">\n", css_errordomain_table_text );

				errcode.write_comment ( file );

				file.puts ( "\t</td>\n" );
				file.puts ( "</tr>\n" );
			}
			file.puts ( "</table>\n" );
		}
	}

	private void write_child_enum_values ( GLib.FileStream file, Enum en ) {
		Gee.ReadOnlyCollection<EnumValue> enum_values = en.get_enum_values ();
		if ( enum_values.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Enum Values:</h3>\n", css_title );
			file.printf ( "<table class=\"%s\">\n", css_enum_table );
			foreach ( EnumValue enval in enum_values ) {
				file.puts ( "<tr>\n" );
				file.printf ( "\t<td class=\"%s\" id=\"%s\">%s</td>\n", css_enum_table_name, enval.name, enval.name );
				file.printf ( "\t<td class=\"%s\">\n", css_enum_table_text );

				enval.write_comment ( file );

				file.puts ( "\t</td>\n" );
				file.puts ( "</tr>\n" );
			}
			file.puts ( "</table>\n" );
		}
	}

	public void write_interface_content ( GLib.FileStream file, Interface iface ) {
		string full_name = iface.full_name ();
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		this.write_image_block ( file, iface );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		iface.write_comment ( file );
		this.write_namespace_note ( file, iface );
		this.write_package_note ( file, iface );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_classes ( file, iface );
		this.write_child_structs ( file, iface );
		this.write_child_delegates ( file, iface );
		this.write_child_fields ( file, iface );
		this.write_child_properties ( file, iface );
		this.write_child_signals ( file, iface );
		this.write_child_methods ( file, iface );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_class_content ( GLib.FileStream file, Class cl ) {
		string full_name = cl.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		this.write_image_block ( file, cl );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_class ( cl, file );
		file.printf ( "\n\t\t\t\t</div>\n" );
		cl.write_comment ( file );
		this.write_namespace_note ( file, cl );
		this.write_package_note ( file, cl );
		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_construction_methods ( file, cl );
		this.write_child_enums ( file, cl );
		this.write_child_classes ( file, cl );
		this.write_child_structs ( file, cl );
		this.write_child_delegates ( file, cl );
		this.write_child_constants ( file, cl );
		this.write_child_fields ( file, cl );
		this.write_child_properties ( file, cl );
		this.write_child_signals ( file, cl );
		this.write_child_methods ( file, cl );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_struct_content ( GLib.FileStream file, Struct stru ) {
		string full_name = stru.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		this.write_image_block ( file, stru );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		stru.write_comment ( file );
		this.write_namespace_note ( file, stru );
		this.write_package_note ( file, stru );
		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_struct ( stru, file );
		file.printf ( "\n\t\t\t\t</div>\n" );
		this.write_child_construction_methods ( file, stru );
		this.write_child_constants ( file, stru );
		this.write_child_fields ( file, stru );
		this.write_child_methods ( file, stru );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_error_domain_content ( GLib.FileStream file, ErrorDomain errdom ) {
		string full_name = errdom.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		errdom.write_comment ( file );
		this.write_namespace_note ( file, errdom );
		this.write_package_note ( file, errdom );
		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_error_values ( file, errdom );
		this.write_child_methods ( file, errdom );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_enum_content ( GLib.FileStream file, Enum en ) {
		string full_name = en.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		en.write_comment ( file );
		this.write_namespace_note ( file, en );
		this.write_package_note ( file, en );
		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_enum_values ( file, en );
		this.write_child_methods ( file, en );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_property_content ( GLib.FileStream file, Property prop ) {
		string full_name = prop.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_property ( prop, file );
		file.printf ( "\n\t\t\t\t</div>\n" );
		prop.write_comment ( file );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_constant_content ( GLib.FileStream file, Constant constant, ConstantHandler parent ) {
		string full_name = constant.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_constant ( constant, parent, file );
		file.printf ( "\n\t\t\t\t</div>\n" );
		constant.write_comment ( file );

		if ( constant.parent is Namespace ) {
			this.write_namespace_note ( file, constant );
		}

		this.write_package_note ( file, constant );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_field_content ( GLib.FileStream file, Field field, FieldHandler parent ) {
		string full_name = field.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_field ( field, parent, file );
		file.printf ( "\n\t\t\t\t</div>\n" );
		field.write_comment ( file );

		if ( field.parent is Namespace ) {
			this.write_namespace_note ( file, field );
		}

		this.write_package_note ( file, field );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_delegate_content ( GLib.FileStream file, Delegate del ) {
		string full_name = del.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_delegate ( del, file );
		file.printf ( "\n\t\t\t\t</div>\n" );
		del.write_comment ( file );

		if ( del.parent is Namespace ) {
			this.write_namespace_note ( file, del );
			this.write_package_note ( file, del );
		}

		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_signal_content ( GLib.FileStream file, Signal sig ) {
		string full_name = sig.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_signal ( sig, file );
		file.printf ( "\n\t\t\t\t</div>\n" );
		sig.write_comment ( file );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_method_content ( GLib.FileStream file, Method m , Valadoc.MethodHandler parent ) {
		string full_name = m.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_method ( file, m, parent );
		file.printf ( "\n\t\t\t\t</div>\n" );
		m.write_comment ( file );

		if ( m.parent is Namespace ) {
			this.write_namespace_note ( file, m );
		}

		this.write_package_note ( file, m );
		file.puts ( "\t\t\t</div>\n" );
	}

	private string css_site_header = "site_header";

	private void write_file_header_template ( GLib.FileStream file, string title, int level ) {
		GLib.StringBuilder css_path = new GLib.StringBuilder ( );
		for ( int i = 0; level > i; i++ ) {
			css_path.append ( "../" );
		}

		css_path.append ( "main.css" );

		file.puts ( "<html>\n" );
		file.puts ( "\t<head>\n" );
		file.puts ( "\t\t<title>Vala Binding Reference</title>\n" );
		file.printf ( "\t\t<link href=\"%s\" rel=\"stylesheet\" type=\"text/css\" />\n", css_path.str );
		file.puts ( "\t</head>\n" );
		file.puts ( "\t<body>\n\n" );

		file.printf ( "\t<div class=\"%s\">\n", this.css_site_header );
		file.printf ( "\t\t%s Reference Manual\n", title );
		file.puts ( "\t</div>\n\n" );

		file.printf ( "\t\t<div class=\"%s\">\n", this.css_style_body );
	}

	private void write_package_note ( GLib.FileStream file, Basic element ) {
		string package = element.package;
		if ( package == null )
			return ;

		file.printf ( "\n\n<br />\n<b>Package:</b> %s\n\n", package );
	}

	private void write_namespace_note ( GLib.FileStream file, Basic element ) {
		for ( ; element is Namespace == false; element = element.parent )
			;

		if ( element.parent == null )
			return ;

		if ( element.name == null )
			return ;

		file.printf ( "\n\n<br />\n<b>Namespace:</b> %s\n\n", ((Namespace)element).full_name () );
	}

	private void write_file_header ( GLib.FileStream file ) {
		this.write_file_header_template ( file, this.package_name, this.directory_level );
	}

	private const string css_style_navigation = "site_navigation";
	private const string css_style_content = "site_content";
	private const string css_style_body = "site_body";


	private void write_file_footer ( GLib.FileStream file ) {
		file.puts ( "\t</div>\n" );

		file.puts ( "\t<div style= \"clear: left\">\n" );
		file.puts ( "\t\t<br />\n" );
		file.puts ( "\t\t<div class=\"site_foother\">\n" );
		file.puts ( "\t\t\tcreated by <a href=\"http://www.valadoc.org\">valadoc</a>\n" );
		file.puts ( "\t\t</div>\n" );
		file.puts ( "\t</div>\n" );
		file.puts ( "\t</body>\n" );
		file.puts ( "</html>" );
	}

	public override void visit_property ( Property prop ) {
		string path = this.current_path + prop.name + "/";
		var rt = DirUtils.create ( path, 0777 );
		this.directory_level++;

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_file_header ( file );
		this.write_navi_property ( file, prop );
		this.write_property_content ( file, prop );
		this.write_file_footer ( file );

		this.directory_level--;
		file = null;
	}

	public override void visit_constant ( Constant constant, ConstantHandler parent ) {
		string path = this.current_path + constant.name + "/";

		var rt = DirUtils.create ( path, 0777 );

		if ( this.is_vapi || constant.parent is Namespace == false ) {
			this.directory_level++;
			GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
			this.write_file_header ( file );
			this.write_navi_constant ( file, constant );
			this.write_constant_content ( file, constant, parent );
			this.write_file_footer ( file );
			this.directory_level--;
			file = null;
		}
	}

	public override void visit_field ( Field field, FieldHandler parent ) {
		string path = this.current_path + field.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		if ( this.is_vapi || field.parent is Namespace == false ) {
			this.directory_level++;
			GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
			this.write_file_header ( file );
			this.write_navi_field ( file, field );
			this.write_field_content ( file, field, parent );
			this.write_file_footer ( file );
			this.directory_level--;
			file = null;
		}
	}

	public override void visit_delegate ( Delegate del ) {
		string path = this.current_path + del.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		if ( this.is_vapi || del.parent is Namespace == false ) {
			this.directory_level++;
			GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
			this.write_file_header ( file );
			this.write_navi_delegate ( file, del );
			this.write_delegate_content ( file, del );
			this.write_file_footer ( file );
			this.directory_level--;
			file = null;
		}
	}

	public override void visit_signal ( Signal sig ) {
		string path = this.current_path + sig.name + "/";
		this.directory_level++;

		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_file_header ( file );
		this.write_navi_signal ( file, sig );
		write_signal_content ( file, sig );
		this.write_file_footer ( file );

		this.directory_level--;
		file = null;
	}

	public override void visit_method ( Method m, Valadoc.MethodHandler parent ) {
		string path = this.current_path + m.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		if ( this.is_vapi || m.parent is Namespace == false ) {
			this.directory_level++;

			GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
			this.write_file_header ( file );
			this.write_navi_method ( file, m );
			this.write_method_content ( file, m, parent );
			this.write_file_footer ( file );

			this.directory_level--;
			file = null;
		}
	}

	public override void visit_namespace ( Namespace ns ) {
		string old_path = this.current_path;
		this.directory_level++;

		if ( ns.name == null ) {
			string tmp = this.current_path + "0/";
			this.current_path = tmp;
		}
		else {
			string tmp = this.current_path + ns.name + "/";
			this.current_path = tmp;
		}

		if ( !this.is_vapi ) {
			this.add_namespace_bundle ( ns );
		}

		bool dir_exists = FileUtils.test ( this.current_path, FileTest.EXISTS);
		if ( !dir_exists ) {
			var rt = DirUtils.create ( this.current_path, 0777 );
			if ( this.is_vapi ) {
				GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w" );
				this.write_file_header ( file );
				this.write_navi_namespace ( file, ns );
				this.write_namespace_content ( file, ns );
				this.write_file_footer ( file );
				file = null;
			}
		}

		// file:
		ns.visit_namespaces ( this );
		ns.visit_enums ( this );
		ns.visit_error_domains ( this );
		ns.visit_structs ( this );
		ns.visit_interfaces ( this );
		ns.visit_classes ( this );
		ns.visit_delegates ( this );
		ns.visit_constants ( this );
		ns.visit_fields ( this );
		ns.visit_methods ( this );

		this.current_path = old_path;
		this.directory_level--;
	}

	public override void visit_enum ( Enum en ) {
		string old_path = this.current_path;
		this.directory_level++;

		this.current_path += en.name + "/";
		var rt = DirUtils.create ( this.current_path, 0777 );

		en.visit_enum_values ( this );
		en.visit_methods ( this );

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_file_header ( file );
		this.write_navi_enum ( file, en, en );
		this.write_enum_content ( file, en );
		this.write_file_footer ( file );
		file = null;

		this.current_path = old_path;
		this.directory_level--;
	}

	public override void visit_error_domain ( ErrorDomain errdom ) {
		string old_path = this.current_path;
		this.directory_level++;

		this.current_path += errdom.name + "/";
		var rt = DirUtils.create ( this.current_path, 0777 );

		errdom.visit_methods ( this );

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_file_header ( file );
		this.write_navi_error_domain ( file, errdom, errdom );
		this.write_error_domain_content ( file, errdom );
		this.write_file_footer ( file );
		file = null;

		this.current_path = old_path;
		this.directory_level--;
	}

	public override void visit_struct ( Struct stru ) {
		string old_path = this.current_path;
		this.directory_level++;

		this.current_path += stru.name + "/";
		var rt = DirUtils.create ( this.current_path, 0777 );
	
		stru.visit_constants ( this );
		stru.visit_fields ( this );
		stru.visit_construction_methods ( this );
		stru.visit_methods ( this );

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_file_header ( file );
		this.write_navi_struct ( file, stru, stru );
		this.write_struct_content ( file, stru );
		this.write_file_footer ( file );
		file = null;

		this.current_path = old_path;
		this.directory_level--;
	}

	public override void visit_class ( Class cl ) {
		string old_path = this.current_path;
		this.directory_level++;

		this.current_path += cl.name + "/";
		var rt = DirUtils.create ( this.current_path, 0777 );

		cl.visit_enums ( this );
		cl.visit_classes ( this );
		cl.visit_structs ( this );
		cl.visit_delegates ( this );
		cl.visit_constants ( this );
		cl.visit_construction_methods ( this );
		cl.visit_methods ( this );
		cl.visit_fields ( this );
		cl.visit_properties ( this );
		cl.visit_signals ( this );

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_file_header ( file );
		this.write_navi_class ( file, cl, cl );
		this.write_class_content ( file, cl );
		this.write_file_footer ( file );
		file = null;

		this.current_path = old_path;
		this.directory_level--;
	}

	public override void visit_interface ( Interface iface ) {
		string old_path = this.current_path;
		this.directory_level++;

		this.current_path += iface.name + "/";
		var rt = DirUtils.create ( this.current_path, 0777 );

		iface.visit_properties ( this );
		iface.visit_delegates ( this );
		iface.visit_signals ( this );
		iface.visit_methods ( this );
		iface.visit_structs ( this );
		iface.visit_fields ( this );
		iface.visit_structs ( this );
		iface.visit_classes ( this );

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w" );
		this.write_file_header ( file );
		this.write_navi_interface ( file, iface, iface );
		this.write_interface_content ( file, iface );
		this.write_file_footer ( file );
		file = null;

		this.current_path = old_path;
		this.directory_level--;
	}

	public override void visit_error_code ( ErrorCode errcode ) {
	}

	public override void visit_enum_value ( EnumValue enval ) {
	}
}





[ModuleInit]
public Type register_plugin ( ) {
	return typeof ( Valadoc.HtmlDoclet );
}

