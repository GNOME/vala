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
using Xml;
using Gee;






private string get_full_name ( Basic element ) {
	if ( element.name == null )
		return "";

	GLib.StringBuilder str = new GLib.StringBuilder ( "" );

	for ( var pos = element; pos != null ; pos = pos.parent ) {
		str.prepend ( pos.name );
		if ( pos.parent is File || pos.parent.name == null )
			return str.str;
		else
			str.prepend_unichar ( '.' );
	}
	return str.str;
}




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

		string typename = get_full_name ( datatype );
		if ( datatype.parent.name == null && (datatype is Class || datatype is Struct) ) {
			if ( this.is_basic_type ( typename ) ) {
				string link = this.get_link( datatype );
				if ( link == null )
					file.printf ( "<span class=\"%s\">%s</span>", css_basic_type, typename );
				else
					file.printf ( "<a class=\"%s\" href=\"%s\">%s</a>", css_basic_type, link, typename );
				return ;
			}
		}

		string link = this.get_link( datatype );
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
			this.write_type_reference ( type_reference, file );
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











public class Valadoc.HtmlDoclet : Valadoc.Doclet, Valadoc.LinkHelper {
	private Valadoc.LangletIndex langlet;

	private string current_path = null;
	private bool is_vapi = false;



	// xml:
	private Xml.Doc devhelp = null;
	private Xml.Node* functions = null;
	private Xml.Node* chapters = null;
	private Xml.Node* current = null;

	private void devhelp_add_chapter_start () {
	}

	private void devhelp_add_chapter () {
	}

	private void devhelp_add_chapter_end () {
	}


	private enum KeywordType {
		NAMESPACE = 0,
		CLASS = 1,
		DELEGATE = 2,
		INTERFACE = 3,
		ERRORDOMAIN = 4,

		CONSTANT = 5,
		ENUM = 6,
		FUNCTION = 7,
		MACRO = 8,
		PROPERTY = 9,
		SIGNAL = 10,
		STRUCT = 11,
		TYPEDEF = 12,
		UNION = 13,
		VARIABLE = 14,
		UNSET = 15
	}

	private const string[] keyword_type_strings = {
		"", // namespace
		"", // class
		"", // delegate
		"", // interface
		"", // errordomain
		"constant",
		"enum",
		"function",
		"macro",
		"property",
		"signal",
		"struct",
		"typedef",
		"union",
		"variable",
		""
	};

	private void devhelp_add_keyword ( KeywordType type, string name, string link ) {
		Xml.Node* keyword = this.functions->new_child ( null, "keyword" );
		keyword->new_prop ( "type", keyword_type_strings[(int)type] );
		keyword->new_prop ( "name", name );
		keyword->new_prop ( "link", link );
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

		this.devhelp = new Xml.Doc ( "1.0" );
		this.devhelp.encoding = "utf-8";
		this.devhelp.standalone = 0;


		Xml.Node* root = new Xml.Node ( null, "book" ); // may cause an crash; string#
		this.devhelp.set_root_element( root );
		root->new_prop ( "xmlns", "http://www.devhelp.net/book" );
		root->new_prop ( "title", "GLib Reference Manual" ); // >>> Change the title!
		root->new_prop ( "link", "index.html" );
		root->new_prop ( "author", "" );
		root->new_prop ( "name", "glib" ); // >>> name
		root->new_prop ( "version", "2" ); // >>> version

		this.current = root->new_child ( null, "chapters" );
		this.functions = root->new_child ( null, "functions" );
		this.chapters = this.current;
	}

	private void write_image_block ( GLib.FileStream file, DataType element ) {
		string realimgpath = this.current_path + "tree.png";
		string imgpath = "docs/" + get_full_path ( element ) + "tree.png";

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

	public override void visit_file ( File file ) {
		string package_name = this.get_package_name ( file.name );
		this.is_vapi = file.name.has_suffix (".vapi");

		string new_path = this.settings.path + package_name + "/";
		bool dir_exists = FileUtils.test ( new_path, FileTest.EXISTS);

		if ( !dir_exists ) {
			var rt = DirUtils.create ( new_path, 0777 );
		}


		this.current_path = new_path;
		file.visit_namespaces ( this );
		this.current_path = null;
	}

	public void write_namespace_content ( GLib.FileStream file, Namespace ns ) {
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, (ns.name == null)? "Global Namespace" : ns.full_name() );
		file.printf ( "<hr class=\"%s\" />\n", css_hr );
		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		ns.write_comment ( file );
	}

	public override void visit_namespace ( Namespace ns ) {
		string old_path = this.current_path;

		if ( ns.name == null ) {
			string tmp = this.current_path + "0/";
			this.current_path = tmp;
		}
		else {
			string tmp = this.current_path + ns.name + "/";
			this.current_path = tmp;
		}

		bool dir_exists = FileUtils.test ( this.current_path, FileTest.EXISTS);
		if ( !dir_exists ) {
			var rt = DirUtils.create ( this.current_path, 0777 );

			GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w" );
			this.write_namespace_content ( file, ns );
			file = null;
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
	}

	private void write_child_classes ( GLib.FileStream file, ClassHandler clh ) {
		Gee.ReadOnlyCollection<Class> classes = clh.get_class_list ();
		if ( classes.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Classes:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Class subcl in classes ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_class, css_navi_link, this.get_link(subcl), subcl.name );
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
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_enum, css_navi_link, this.get_link(en), en.name );
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
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_struct, css_navi_link, this.get_link(stru), stru.name );
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
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_method, css_navi_link, this.get_link(m), m.name );
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
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_delegate, css_navi_link, this.get_link(d), d.name );
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
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_method, css_navi_link, this.get_link(m), m.name );
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
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_signal, css_navi_link, this.get_link(sig), sig.name );
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
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_property, css_navi_link, this.get_link(prop), prop.name );
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
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_fields, css_navi_link, this.get_link(f), f.name );
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
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_constant, css_navi_link, this.get_link(c), c.name );
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
		string full_name = get_full_name ( iface );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );

		this.write_image_block ( file, iface );

		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		iface.write_comment ( file );
		this.write_namespace_note ( file, iface );
		this.write_package_note ( file, iface );
		file.printf ( "\n<h2 class=\"%s\">Content:</h2>\n", css_title );

		this.write_child_classes ( file, iface );
		this.write_child_structs ( file, iface );
		this.write_child_delegates ( file, iface );
		this.write_child_fields ( file, iface );
		this.write_child_properties ( file, iface );
		this.write_child_signals ( file, iface );
		this.write_child_methods ( file, iface );
	}

	public override void visit_interface ( Interface iface ) {
		string old_path = this.current_path;
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

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_interface_content ( file, iface );
		file = null;

		this.current_path = old_path;
	}

	public void write_class_content ( GLib.FileStream file, Class cl ) {
		string full_name = get_full_name ( cl );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );

		this.write_image_block ( file, cl );

		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );

		file.printf ( "<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_class ( cl, file );
		file.printf ( "\n</div>\n" );
		cl.write_comment ( file );
		this.write_namespace_note ( file, cl );
		this.write_package_note ( file, cl );
		file.printf ( "\n<h2 class=\"%s\">Content:</h2>\n", css_title );
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
	}

	public override void visit_class ( Class cl ) {
		string old_path = this.current_path;
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
		this.write_class_content ( file, cl );
		file = null;

		this.current_path = old_path;
	}

	public void write_struct_content ( GLib.FileStream file, Struct stru ) {
		string full_name = get_full_name ( stru );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );

		this.write_image_block ( file, stru );

		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		stru.write_comment ( file );
		this.write_namespace_note ( file, stru );
		this.write_package_note ( file, stru );
		file.printf ( "\n<h2 class=\"%s\">Content:</h2>\n", css_title );
		file.printf ( "<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_struct ( stru, file );
		file.printf ( "\n</div>\n" );

		this.write_child_construction_methods ( file, stru );
		this.write_child_constants ( file, stru );
		this.write_child_fields ( file, stru );
		this.write_child_methods ( file, stru );
	}

	public override void visit_struct ( Struct stru ) {
		string old_path = this.current_path;
		this.current_path += stru.name + "/";
		var rt = DirUtils.create ( this.current_path, 0777 );
	
		stru.visit_constants ( this );
		stru.visit_fields ( this );
		stru.visit_construction_methods ( this );
		stru.visit_methods ( this );

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_struct_content ( file, stru );
		file = null;

		this.current_path = old_path;
	}

	public void write_error_domain_content ( GLib.FileStream file, ErrorDomain errdom ) {
		string full_name = get_full_name ( errdom );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		errdom.write_comment ( file );
		this.write_namespace_note ( file, errdom );
		this.write_package_note ( file, errdom );
		file.printf ( "\n<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_error_values ( file, errdom );
		this.write_child_methods ( file, errdom );
	}

	public override void visit_error_domain ( ErrorDomain errdom ) {
		string old_path = this.current_path;
		this.current_path += errdom.name + "/";
		var rt = DirUtils.create ( this.current_path, 0777 );

		errdom.visit_methods ( this );

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_error_domain_content ( file, errdom );
		file = null;

		this.current_path = old_path;
	}

	public void write_enum_content ( GLib.FileStream file, Enum en ) {
		string full_name = get_full_name ( en );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		en.write_comment ( file );
		this.write_namespace_note ( file, en );
		this.write_package_note ( file, en );
		file.printf ( "\n<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_enum_values ( file, en );
		this.write_child_methods ( file, en );
	}

	public override void visit_enum ( Enum en ) {
		string old_path = this.current_path;
		this.current_path += en.name + "/";
		var rt = DirUtils.create ( this.current_path, 0777 );

		en.visit_enum_values ( this );
		en.visit_methods ( this );

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_enum_content ( file, en );
		file = null;

		this.current_path = old_path;
	}

	public void write_property_content ( GLib.FileStream file, Property prop ) {
		string full_name = get_full_name ( prop );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_property ( prop, file );
		file.printf ( "\n</div>\n" );
		prop.write_comment ( file );
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

		file.printf ( "\n\n<br />\n<b>Namespace:</b> %s\n\n", element.full_name() );
	}

	public override void visit_property ( Property prop ) {
		string path = this.current_path + prop.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_property_content ( file, prop );
		file = null;
	}

	public void write_constant_content ( GLib.FileStream file, Constant constant, ConstantHandler parent ) {
		string full_name = get_full_name ( constant );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_constant ( constant, parent, file );
		file.printf ( "\n</div>\n" );
		constant.write_comment ( file );
		if ( constant.parent is Namespace ) {
			this.write_namespace_note ( file, constant );
			this.write_package_note ( file, constant );
		}
	}

	public override void visit_constant ( Constant constant, ConstantHandler parent ) {
		string path = this.current_path + constant.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_constant_content ( file, constant, parent );
		file = null;
	}

	public void write_field_content ( GLib.FileStream file, Field field, FieldHandler parent ) {
		string full_name = get_full_name ( field );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_field ( field, parent, file );
		file.printf ( "\n</div>\n" );
		field.write_comment ( file );
		if ( field.parent is Namespace ) {
			this.write_namespace_note ( file, field );
			this.write_package_note ( file, field );
		}
	}

	public override void visit_field ( Field field, FieldHandler parent ) {
		string path = this.current_path + field.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_field_content ( file, field, parent );
		file = null;
	}

	public override void visit_error_code ( ErrorCode errcode ) {
	}

	public override void visit_enum_value ( EnumValue enval ) {
	}

	public void write_delegate_content ( GLib.FileStream file, Delegate del ) {
		string full_name = get_full_name ( del );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_delegate ( del, file );
		file.printf ( "\n</div>\n" );
		del.write_comment ( file );
		if ( del.parent is Namespace ) {
			this.write_namespace_note ( file, del );
			this.write_package_note ( file, del );
		}
	}

	public override void visit_delegate ( Delegate del ) {
		string path = this.current_path + del.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_delegate_content ( file, del );
		file = null;
	}

	public void write_signal_content ( GLib.FileStream file, Signal sig ) {
		string full_name = get_full_name ( sig );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_signal ( sig, file );
		file.printf ( "\n</div>\n" );
		sig.write_comment ( file );
	}

	public override void visit_signal ( Signal sig ) {
		string path = this.current_path + sig.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		write_signal_content ( file, sig );
		file = null;
	}

	public void write_method_content ( GLib.FileStream file, Method m , Valadoc.MethodHandler parent ) {
		string full_name = get_full_name ( m );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_method ( file, m, parent );
		file.printf ( "\n</div>\n" );
		m.write_comment ( file );
		if ( m.parent is Namespace ) {
			this.write_namespace_note ( file, m );
			this.write_package_note ( file, m );
		}
	}

	public override void visit_method ( Method m, Valadoc.MethodHandler parent ) {
		string path = this.current_path + m.name + "/";
		string full_name = get_full_name ( m );
		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_method_content ( file, m, parent );
		file = null;
	}
}





[ModuleInit]
public Type register_plugin ( ) {
	return typeof ( Valadoc.HtmlDoclet );
}

