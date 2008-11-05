


using GLib;


public const string css_inline_navigation = "main_inline_navigation";
public const string css_inline_navigation_property = "main_inline_navigation_property";
public const string css_inline_navigation_method = "main_inline_navigation_method";
public const string css_inline_navigation_signal = "main_inline_navigation_signal";
public const string css_inline_navigation_fields = "main_inline_navigation_fields";
public const string css_inline_navigation_class = "main_inline_navigation_class";
public const string css_inline_navigation_enum = "main_inline_navigation_enum";
public const string css_inline_navigation_struct = "main_inline_navigation_struct";
public const string css_inline_navigation_delegate = "main_inline_navigation_delegate";
public const string css_inline_navigation_constant = "main_inline_navigation_constant";
public const string css_inline_navigation_namespace = "main_inline_navigation_namespace";
public const string css_inline_navigation_package = "main_inline_navigation_package";


public const string css_site_header = "site_header";

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

public const string css_style_navigation = "site_navigation";
public const string css_style_content = "site_content";
public const string css_style_body = "site_body";








public abstract class Valadoc.BasicHtmlLanglet : Valadoc.Langlet {
	public Valadoc.Settings settings {
		construct set;
		protected get;
	}

	public BasicHtmlLanglet ( Settings settings ) {
		this.settings = settings;
	}

	private Basic position = null;

	protected abstract string get_link ( Basic type, Basic position );

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

	public override void write_file ( Valadoc.Package file, void* ptr ) {
	}
}












public abstract class Valadoc.BasicHtmlDoclet : Valadoc.Doclet {
	protected Valadoc.Langlet langlet;

	protected abstract string get_link ( Valadoc.Basic p1, Valadoc.Basic p2 );


	// Navi:
	protected void write_navi_entry_html_template ( GLib.FileStream file, string style, string content ) {
		file.printf ( "\t<li class=\"%s\">%s</li>\n", style, content );
	}

	protected void write_navi_entry_html_template_with_link ( GLib.FileStream file, string style, string link, string content ) {
		file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", style, css_navi_link, link, content );
	}

	protected void write_navi_entry ( GLib.FileStream file, Basic element, Basic pos, string style, bool link, bool full_name = false ) {
		string name;

		if ( element is Class ) {
			if ( ((Class)element).is_abstract )
				name = "<i>" + element.name + "</i>";
			else
				name = element.name;
		}
		else if ( element is Package ) {
			name = element.file.name;
		}
		else if ( full_name == true && element is Namespace ) {
			string tmp = element.full_name();
			name = (tmp == null)? "Global Namespace" : tmp;
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

	protected void write_navi_top_entry ( GLib.FileStream file, Basic element, Basic mself ) {
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
		else if ( element is Package ) {
			name = element.file.name;
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

	protected void write_top_element_template ( GLib.FileStream file, string link ) {
		file.printf ( "<ul class=\"%s\">\n\t\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">Packages</a></li>\n</ul>\n<hr class=\"%s\">\n", css_navi, css_navi_package_index, css_navi_link, link, css_navi_hr );
	}

	protected virtual void write_top_element ( GLib.FileStream file, Basic pos ) {
	}

	protected void write_top_elements ( GLib.FileStream file, Basic element, Basic? mself ) {
		Gee.ArrayList<Basic> lst = new Gee.ArrayList<Basic> ();
		Basic pos = element;

		if ( mself == null )
			mself = element;

		string package_name = element.file.name;

		this.write_top_element ( file, mself );

		while ( pos != null ) {
			lst.add ( pos );
			pos = pos.parent;
		}

		for ( int i = lst.size-1; i >= 0  ; i-- ) {
			Basic el = lst.get ( i );
			if ( el.name != null ) {
				this.write_navi_top_entry ( file, el, mself );
			}
		}
	}

	protected void fetch_subnamespace_names ( NamespaceHandler pos, Gee.ArrayList<Namespace> lst ) {
		Gee.ReadOnlyCollection<Namespace> nspaces = pos.get_namespace_list ();

		foreach ( Namespace ns in nspaces ) {
			lst.add ( ns );
			this.fetch_subnamespace_names ( ns, lst );
		}
	}

	protected void write_navi_file ( GLib.FileStream file, Package efile, Basic? pos = null ) {
		Gee.ArrayList<Namespace> ns_list = new Gee.ArrayList<Namespace> ();
		this.fetch_subnamespace_names (efile, ns_list );


		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );


		if ( pos == null )
			this.write_top_elements ( file, efile, efile );
		else
			this.write_top_elements ( file, pos.parent.parent, pos );

		file.printf ( "\t\t\t\t<ul class=\"%s\">\n", css_navi );


		Namespace globals;

		foreach ( Namespace ns in ns_list ) {
			if ( ns.name == null )
				globals = ns;
			else
				this.write_navi_entry ( file, ns, (pos == null)? efile : pos, css_navi_namespace, true, true );
		}

		if ( globals != null ) {
			this.write_navi_child_namespaces_inline_withouth_block ( file, globals, (pos == null)? efile : pos );
		}

		file.puts ( "\t\t\t\t</ul>\n" );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_child_namespaces_inline_withouth_block ( GLib.FileStream file, Namespace ns, Basic mself ) {
		this.write_navi_child_namespaces_without_childs ( file, ns, mself );
		this.write_navi_child_classes_without_childs ( file, ns, mself );
		this.write_navi_child_interfaces_without_childs ( file, ns, mself );
		this.write_navi_child_structs_without_childs ( file, ns, mself );
		this.write_navi_child_enums_without_childs ( file, ns, mself );
		this.write_navi_child_error_domains_without_childs ( file, ns, mself );
		this.write_navi_child_delegates ( file, ns, mself );
		this.write_navi_child_methods ( file, ns, mself );
		this.write_navi_child_fields ( file, ns, mself );
		this.write_navi_child_constants ( file, ns, mself );
	}

	protected void write_navi_child_namespaces_inline ( GLib.FileStream file, Namespace ns, Basic mself ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );
		this.write_navi_child_namespaces_inline_withouth_block ( file, ns, mself );
		file.puts ( "</ul>\n" );
	}

	protected void write_navi_child_namespaces ( GLib.FileStream file, Namespace ns, Basic mself ) {
		this.write_top_elements ( file, ns, mself );
		this.write_navi_child_namespaces_inline ( file, ns, mself );
	}

	protected void write_navi_struct_inline ( GLib.FileStream file, Struct stru, Basic mself ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );
		this.write_navi_child_construction_methods ( file, stru, mself );
		this.write_navi_child_methods ( file, stru, mself );
		this.write_navi_child_fields ( file, stru, mself );
		this.write_navi_child_constants ( file, stru, mself );
		file.puts ( "</ul>\n" );
	}

	protected void write_navi_struct ( GLib.FileStream file, Struct stru, Basic mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, stru, mself );
		this.write_navi_struct_inline ( file, stru, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_interface_inline ( GLib.FileStream file, Interface iface, Basic mself ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );
		this.write_navi_child_delegates ( file, iface, mself );
		this.write_navi_child_methods ( file, iface, mself );
		this.write_navi_child_signals ( file, iface, mself );
		this.write_navi_child_properties ( file, iface, mself );
		this.write_navi_child_fields ( file, iface, mself );
		file.puts ( "</ul>\n" );
	}

	protected void write_navi_interface ( GLib.FileStream file, Interface iface, Basic mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, iface, mself );
		this.write_navi_interface_inline ( file, iface, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_enum_inline ( GLib.FileStream file, Enum en, Basic mself ) {
		Gee.ReadOnlyCollection<EnumValue> enum_values = en.get_enum_values ( );
		file.printf ( "<ul class=\"%s\">\n", css_navi );

		foreach ( EnumValue env in enum_values ) {
			this.write_navi_entry ( file, env, en, css_navi_enval, true ); // en => mself
		}

		this.write_navi_child_methods ( file, en, mself );
		file.puts ( "</ul>\n" );
	}

	protected void write_navi_enum ( GLib.FileStream file, Enum en, Basic mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, en, mself );
		this.write_navi_enum_inline ( file, en, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_error_domain_inline ( GLib.FileStream file, ErrorDomain errdom, Basic mself = null ) {
		Gee.ReadOnlyCollection<ErrorCode> error_codes = errdom.get_error_code_list ( );
		file.printf ( "<ul class=\"%s\">\n", css_navi );

		foreach ( ErrorCode ec in error_codes ) {
			this.write_navi_entry ( file, ec, errdom, css_navi_errdomcode, true ); // errdom => mself
		}

		this.write_navi_child_methods ( file, errdom, mself );
		file.puts ( "</ul>\n" );
	}

	protected void write_navi_namespace ( GLib.FileStream file, Namespace ns ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, ns, ns );
		this.write_navi_child_namespaces_inline ( file, ns, ns );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_error_domain ( GLib.FileStream file, ErrorDomain errdom, Basic mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, errdom, mself );
		this.write_navi_error_domain_inline ( file, errdom, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_class_inline ( GLib.FileStream file, Class cl, Basic mself ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );
		this.write_navi_child_construction_methods ( file, cl, mself );
		this.write_navi_child_classes_without_childs ( file, cl, mself );
		this.write_navi_child_structs_without_childs ( file, cl, mself );
		this.write_navi_child_enums_without_childs ( file, cl, mself );
		this.write_navi_child_delegates ( file, cl, mself );
		this.write_navi_child_methods ( file, cl, mself );
		this.write_navi_child_signals ( file, cl, mself );
		this.write_navi_child_properties ( file, cl, mself );
		this.write_navi_child_fields ( file, cl, mself );
		this.write_navi_child_constants ( file, cl, mself );
		file.puts ( "</ul>\n" );
	}

	protected void write_navi_class ( GLib.FileStream file, Class cl, Basic mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, cl, mself );
		this.write_navi_class_inline ( file, cl, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_method ( GLib.FileStream file, Method m ) {
		Basic parent = m.parent;

		if ( parent.name == null ) {
			this.write_navi_file ( file, (Package)parent.parent, m );
		}
		else {
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
	}

	protected void write_navi_property ( GLib.FileStream file, Property prop ) {
		Basic parent = prop.parent;

		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, prop.parent, prop );

		if ( parent is Class )
			this.write_navi_class_inline ( file, (Class)parent, prop );
		else if ( parent is Interface )
			this.write_navi_interface_inline ( file, (Interface)parent, prop );

		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_signal ( GLib.FileStream file, Signal sig ) {
		Basic parent = sig.parent;

		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );

		this.write_top_elements ( file, sig.parent, sig );

		if ( parent is Class )
			this.write_navi_class_inline ( file, (Class)parent, sig );
		else if ( parent is Interface )
			this.write_navi_interface_inline ( file, (Interface)parent, sig );

		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_constant ( GLib.FileStream file, Constant c ) {
		Basic parent = c.parent;

		if ( parent.name == null ) {
			this.write_navi_file ( file, (Package)parent.parent, c );
		}
		else {
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
	}

	protected void write_navi_field ( GLib.FileStream file, Field f ) {
		Basic parent = f.parent;

		if ( parent.name == null ) {
			this.write_navi_file ( file, (Package)parent.parent, f );
		}
		else {
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
	}

	protected void write_navi_delegate ( GLib.FileStream file, Delegate del ) {
		Basic parent = del.parent;

		if ( parent.name == null ) {
			this.write_navi_file ( file, (Package)parent.parent, del );
		}
		else {
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
	}

	protected void write_navi_child_methods_collection ( GLib.FileStream file, Gee.Collection<Method> methods, Basic mself ) {
		foreach ( Method m in methods ) {
			if ( m == mself )
				this.write_navi_entry ( file, m, mself, css_navi_construction_method, false );
			else
				this.write_navi_entry ( file, m, mself, css_navi_construction_method, true );
		}
	}

	protected void write_navi_child_methods ( GLib.FileStream file, MethodHandler mh, Basic mself ) {
		Gee.ReadOnlyCollection<Method> methods = mh.get_method_list ( );
		this.write_navi_child_methods_collection ( file, methods, mself );
	}

	protected void write_navi_child_classes_without_childs_collection ( GLib.FileStream file, Gee.Collection<Class> classes, Basic mself ) {
		foreach ( Class cl in classes ) {
			if ( cl == mself )
				this.write_navi_entry ( file, cl, mself, css_navi_class, false );
			else
				this.write_navi_entry ( file, cl, mself, css_navi_class, true );
		}
	}

	protected void write_navi_child_classes_without_childs ( GLib.FileStream file, ClassHandler clh, Basic mself ) {
		Gee.ReadOnlyCollection<Class> classes = clh.get_class_list ( );
		this.write_navi_child_classes_without_childs_collection ( file, classes, mself );
	}

	protected void write_navi_child_construction_methods ( GLib.FileStream file, ConstructionMethodHandler cmh, Basic mself ) {
		Gee.ReadOnlyCollection<Method> methods = cmh.get_construction_method_list ( );
		this.write_navi_child_methods_collection ( file, methods, mself );
	}

	protected void write_navi_child_signals ( GLib.FileStream file, SignalHandler sh, Basic mself ) {
		Gee.ReadOnlyCollection<Signal> signals = sh.get_signal_list ( );

		foreach ( Signal sig in signals ) {
			if ( sig == mself )
				this.write_navi_entry ( file, sig, mself, css_navi_sig, false );
			else
				this.write_navi_entry ( file, sig, mself, css_navi_sig, true );
		}
	}

	protected void write_navi_child_properties ( GLib.FileStream file, PropertyHandler ph, Basic mself ) {
		Gee.ReadOnlyCollection<Property> properties = ph.get_property_list ( );

		foreach ( Property p in properties ) {
			if ( p == mself )
				this.write_navi_entry ( file, p, mself, css_navi_prop, false );
			else
				this.write_navi_entry ( file, p, mself, css_navi_prop, true );
		}
	}

	protected void write_navi_child_fields_collection ( GLib.FileStream file, Gee.Collection<Field> fields, Basic mself ) {
		foreach ( Field f in fields ) {
			if ( f == mself )
				this.write_navi_entry ( file, f, mself, css_navi_field, false );
			else
				this.write_navi_entry ( file, f, mself, css_navi_field, true );
		}
	}

	protected void write_navi_child_fields ( GLib.FileStream file, FieldHandler fh, Basic mself ) {
		Gee.ReadOnlyCollection<Field> fields = fh.get_field_list ( );
		this.write_navi_child_fields_collection ( file, fields, mself );
	}

	protected void write_navi_child_constants_collection ( GLib.FileStream file, Gee.Collection<Constant> constants, Basic mself ) {
		foreach ( Constant c in constants ) {
			if ( c == mself )
				this.write_navi_entry ( file, c, mself, css_navi_constant, false );
			else
				this.write_navi_entry ( file, c, mself, css_navi_constant, true );
		}
	}

	protected void write_navi_child_constants ( GLib.FileStream file, ConstantHandler ch, Basic mself ) {
		Gee.ReadOnlyCollection<Constant> constants = ch.get_constant_list ( );
		this.write_navi_child_constants_collection ( file, constants, mself );
	}

	protected void write_navi_child_structs_without_childs_collection ( GLib.FileStream file, Gee.Collection<Struct> structs, Basic mself ) {
		foreach ( Struct stru in structs ) {
			if ( stru == mself )
				this.write_navi_entry ( file, stru, mself, css_navi_struct, false );
			else
				this.write_navi_entry ( file, stru, mself, css_navi_struct, true );
		}
	}

	protected void write_navi_child_structs_without_childs ( GLib.FileStream file, StructHandler strh, Basic mself ) {
		Gee.Collection<Struct> structs = strh.get_struct_list ( );
		this.write_navi_child_structs_without_childs_collection ( file, structs, mself );
	}

	protected void write_navi_child_delegates_collection ( GLib.FileStream file, Gee.Collection<Delegate> delegates, Basic mself ) {
		foreach ( Delegate del in delegates ) {
			if ( del == mself )
				this.write_navi_entry ( file, del, mself, css_navi_del, false );
			else
				this.write_navi_entry ( file, del, mself, css_navi_del, true );
		}
	}

	protected void write_navi_child_delegates ( GLib.FileStream file, DelegateHandler delh, Basic mself ) {
		Gee.Collection<Delegate> delegates = delh.get_delegate_list ( );
		this.write_navi_child_delegates_collection ( file, delegates, mself );
	}

	protected void write_navi_child_interfaces_without_childs_collection ( GLib.FileStream file, Gee.Collection<Interface> interfaces, Basic mself ) {
		foreach ( Interface iface in interfaces ) {
			if ( iface == mself )
				this.write_navi_entry ( file, iface, mself, css_navi_iface, false );
			else
				this.write_navi_entry ( file, iface, mself, css_navi_iface, true );
		}
	}

	protected void write_navi_child_interfaces_without_childs ( GLib.FileStream file, Namespace ifh, Basic mself ) {
		Gee.Collection<Interface> interfaces = ifh.get_interface_list ( );
		this.write_navi_child_interfaces_without_childs_collection ( file, interfaces, mself );
	}

	protected void write_navi_child_enums_without_childs_collection ( GLib.FileStream file, Gee.Collection<Enum> enums, Basic mself ) {
		foreach ( Enum en in enums ) {
			if ( en == mself )
				this.write_navi_entry ( file, en, mself, css_navi_enum, false );
			else
				this.write_navi_entry ( file, en, mself, css_navi_enum, true );
		}
	}

	protected void write_navi_child_enums_without_childs ( GLib.FileStream file, EnumHandler eh, Basic mself ) {
		Gee.Collection<Enum> enums = eh.get_enum_list ( );
		this.write_navi_child_enums_without_childs_collection ( file, enums, mself );
	}

	protected void write_navi_child_error_domains_without_childs_collection ( GLib.FileStream file, Gee.Collection<ErrorDomain> errordomains, Basic mself ) {
		foreach ( ErrorDomain errdom in errordomains ) {
			if ( errdom == mself )
				this.write_navi_entry ( file, errdom, mself, css_navi_error_domain, false );
			else
				this.write_navi_entry ( file, errdom, mself, css_navi_error_domain, true );
		}
	}

	protected void write_navi_child_error_domains_without_childs ( GLib.FileStream file, Namespace errdomh, Basic mself ) {
		Gee.Collection<ErrorDomain> errordomains = errdomh.get_error_domain_list ( );
		this.write_navi_child_error_domains_without_childs_collection ( file, errordomains, mself );
	}

	protected void write_navi_child_namespaces_without_childs ( GLib.FileStream file, NamespaceHandler nsh, Basic mself ) {
		Gee.ReadOnlyCollection<Namespace> namespaces = nsh.get_namespace_list ( );
		foreach ( Namespace ns in namespaces ) {
			if ( ns == mself )
				this.write_navi_entry ( file, ns, mself, css_navi_namespace, false );
			else
				this.write_navi_entry ( file, ns, mself, css_navi_namespace, true );
		}
	}


////////////////


	protected void write_package_note ( GLib.FileStream file, Basic element ) {
		string package = element.package;
		if ( package == null )
			return ;

		file.printf ( "\n\n<br />\n<b>Package:</b> %s\n\n", package );
	}

	protected void write_namespace_note ( GLib.FileStream file, Basic element ) {
		for ( ; element is Namespace == false; element = element.parent )
			;

		if ( element.parent == null )
			return ;

		if ( element.name == null )
			return ;

		file.printf ( "\n\n<br />\n<b>Namespace:</b> %s\n\n", element.full_name() );
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
			this.write_package_note ( file, m );
		}

		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_child_error_values ( GLib.FileStream file, ErrorDomain errdom ) {
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
			this.write_package_note ( file, field );
		}

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
			this.write_package_note ( file, constant );
		}

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

	public void write_enum_content ( GLib.FileStream file, Enum en ) {
		string full_name = en.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		en.write_comment ( file );

		if ( en.parent is Namespace ) {
			this.write_namespace_note ( file, en );
			this.write_package_note ( file, en );
		}

		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_enum_values ( file, en );
		this.write_child_static_methods ( file, en );
		this.write_child_methods ( file, en );
		file.puts ( "\t\t\t</div>\n" );
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

	protected void write_child_methods ( GLib.FileStream file, MethodHandler mh ) {
		Gee.ReadOnlyCollection<Method> methods = mh.get_method_list ();

		Gee.ArrayList<Method> imethods = new Gee.ArrayList<Method> ( );
		foreach ( Method m in methods ) {
			if ( !m.is_static )
				imethods.add ( m );
		}

		if ( imethods.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Methods:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Method m in imethods ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_method, css_navi_link, this.get_link(m, mh), m.name );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_child_static_methods ( GLib.FileStream file, MethodHandler mh ) {
		Gee.ReadOnlyCollection<Method> methods = mh.get_method_list ();

		Gee.ArrayList<Method> static_methods = new Gee.ArrayList<Method> ( );
		foreach ( Method m in methods ) {
			if ( m.is_static )
				static_methods.add ( m );
		}

		if ( static_methods.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Static Methods:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Method m in static_methods ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_method, css_navi_link, this.get_link(m, mh), m.name );
			}
			file.puts ( "</ul>\n" );
		}
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
		if ( cl.parent is Namespace ) {
			this.write_namespace_note ( file, cl );
			this.write_package_note ( file, cl );
		}
		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_construction_methods ( file, cl );
		this.write_child_static_methods ( file, cl );
		this.write_child_classes ( file, cl );
		this.write_child_structs ( file, cl );
		this.write_child_enums ( file, cl );
		this.write_child_delegates ( file, cl );
		this.write_child_methods ( file, cl );
		this.write_child_signals ( file, cl );
		this.write_child_properties ( file, cl );
		this.write_child_fields ( file, cl );
		this.write_child_constants ( file, cl );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_interface_content ( GLib.FileStream file, Interface iface ) {
		string full_name = iface.full_name ();
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		this.write_image_block ( file, iface );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_interface ( iface, file );
		file.printf ( "\n\t\t\t\t</div>\n" );
		iface.write_comment ( file );
		if ( iface.parent is Namespace ) {
			this.write_namespace_note ( file, iface );
			this.write_package_note ( file, iface );
		}
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_static_methods ( file, iface );
		this.write_child_classes ( file, iface );
		this.write_child_structs ( file, iface );
		this.write_child_delegates ( file, iface );
		this.write_child_methods ( file, iface );
		this.write_child_signals ( file, iface );
		this.write_child_properties ( file, iface );
		this.write_child_fields ( file, iface );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_error_domain_content ( GLib.FileStream file, ErrorDomain errdom ) {
		string full_name = errdom.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		errdom.write_comment ( file );
		if ( errdom.parent is Namespace ) {
			this.write_namespace_note ( file, errdom );
			this.write_package_note ( file, errdom );
		}
		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_error_values ( file, errdom );
		this.write_child_static_methods ( file, errdom );
		this.write_child_methods ( file, errdom );
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
		if ( stru.parent is Namespace ) {
			this.write_namespace_note ( file, stru );
			this.write_package_note ( file, stru );
		}
		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_struct ( stru, file );
		file.printf ( "\n\t\t\t\t</div>\n" );
		this.write_child_construction_methods ( file, stru );
		this.write_child_static_methods ( file, stru );
		this.write_child_methods ( file, stru );
		this.write_child_fields ( file, stru );
		this.write_child_constants ( file, stru );
		file.puts ( "\t\t\t</div>\n" );
	}


	protected abstract string get_img_real_path ( Basic element );

	protected abstract string get_img_path ( Basic element );


	protected void write_child_constants ( GLib.FileStream file, ConstantHandler ch ) {
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

	protected void write_child_enums ( GLib.FileStream file, EnumHandler eh ) {
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

	protected void write_child_construction_methods ( GLib.FileStream file, ConstructionMethodHandler cmh ) {
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

	protected void write_image_block ( GLib.FileStream file, DataType element ) {
		string realimgpath = this.get_img_real_path ( element );
		string imgpath = this.get_img_path ( element );

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

	protected void write_child_fields ( GLib.FileStream file, FieldHandler fh ) {
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

	protected void write_child_properties ( GLib.FileStream file, PropertyHandler ph ) {
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

	protected void write_child_signals ( GLib.FileStream file, SignalHandler sh ) {
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

	protected void write_child_classes ( GLib.FileStream file, ClassHandler clh ) {
		Gee.ReadOnlyCollection<Class> classes = clh.get_class_list ();
		if ( classes.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Classes:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Class subcl in classes ) {
				string name;
				if ( subcl.is_abstract ) {
					name = "<i>" + subcl.name + "</i>";
				}
				else {
					name = subcl.name;
				}

				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_class, css_navi_link, this.get_link(subcl, clh), name );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_child_delegates ( GLib.FileStream file, DelegateHandler dh ) {
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

	protected void write_child_structs ( GLib.FileStream file, StructHandler struh ) {
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

	public void write_namespace_content ( GLib.FileStream file, Namespace ns ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, (ns.name == null)? "Global Namespace" : ns.full_name () );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		ns.write_comment ( file );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_file_content ( GLib.FileStream file, Package f ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, f.name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.puts ( "\t\t\t</div>\n" );
	}


	protected void write_file_header ( GLib.FileStream file, string css, string? title ) {
		file.puts ( "<html>\n" );
		file.puts ( "\t<head>\n" );
		file.puts ( "\t\t<title>Vala Binding Reference</title>\n" );
		file.printf ( "\t\t<link href=\"%s\" rel=\"stylesheet\" type=\"text/css\" />\n", css );
		file.puts ( "\t</head>\n" );
		file.puts ( "\t<body>\n\n" );

		file.printf ( "\t<div class=\"%s\">\n", css_site_header );
		file.printf ( "\t\t%s Reference Manual\n", (title == null)? "" : title );
		file.puts ( "\t</div>\n\n" );

		file.printf ( "\t\t<div class=\"%s\">\n", css_style_body );
	}

	protected void write_file_footer ( GLib.FileStream file ) {
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
}

