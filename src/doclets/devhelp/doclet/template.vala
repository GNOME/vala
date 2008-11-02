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

		string typename = datatype.full_name (  );
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







public enum KeywordType {
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

public class DevhelpFormat : Object {
	private Xml.Doc* devhelp = null;
	private Xml.Node* functions = null;
	private Xml.Node* chapters = null;
	private Xml.Node* current = null;

	~DevhelpFormat ( ) {
		delete this.devhelp;
	}

	public void save_file ( string path ) {
		Xml.Doc.save_format_file ( path, this.devhelp, 1 );
	}

	public DevhelpFormat ( string name, string version ) {
		this.devhelp = new Xml.Doc ( "1.0" );
		Xml.Node* root = new Xml.Node ( null, "book" );
		this.devhelp->set_root_element( root );
		root->new_prop ( "xmlns", "http://www.devhelp.net/book" );
		root->new_prop ( "title", name + " Reference Manual" );
		root->new_prop ( "language", "vala" );
		root->new_prop ( "link", "index.htm" );
		root->new_prop ( "name", version );
		root->new_prop ( "version", "2" );
		root->new_prop ( "author", "" );

		this.current = root->new_child ( null, "chapters" );
		this.functions = root->new_child ( null, "functions" );
		this.chapters = this.current;
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

	private Xml.Node* find_child_node ( Xml.Node* element, string name ) {
		for ( Xml.Node* pos = element->children; pos != null ; pos = pos->next ) {
			if ( name == pos->get_prop ( "name" ) ) {
				return pos;
			}
		}
		return null;
	}

	private Xml.Node* get_node ( string full_name ) {
		Xml.Node* cur = this.chapters;
		string[] path = full_name.split ( "." );

		for ( int i = 0; path[i] != null ; i++ ) {
			cur = this.find_child_node ( cur, path[i] );
			if ( cur == null ) {
				return null;
			}
		}

		return null;
	}

	public void reset ( ) {
		this.current = this.chapters;
	}

	public bool jump_to_chapter ( string full_name ) {
		Xml.Node* node = this.get_node ( full_name );
		if ( node != null ) {
			this.current = node;
			return true;
		}
		return false;
	}

	public void add_chapter_start ( string name, string link ) {
		this.current = this.current->new_child ( null, "sub" );
		this.current->new_prop ( "name", name );
		this.current->new_prop ( "link", link );
	}

	public void add_chapter_end () {
		this.current = this.current->parent;
	}

	public void add_chapter ( string name, string link ) {
		this.add_chapter_start ( name, link );
		this.add_chapter_end ();
	}

	public void add_keyword ( KeywordType type, string name, string link ) {
		Xml.Node* keyword = this.functions->new_child ( null, "keyword" );
		keyword->new_prop ( "type", keyword_type_strings[(int)type] );
		keyword->new_prop ( "name", name );
		keyword->new_prop ( "link", link );
	}
}


public class Valadoc.HtmlDoclet : Valadoc.Doclet, Valadoc.LinkHelper {
	private Valadoc.LangletIndex langlet;

	private DevhelpFormat devhelp;

	private const string css_style_body = "site_body";
	private const string css_site_header = "site_header";
	private string package_dir_name = "";

	private void write_file_header_template ( GLib.FileStream file, string title ) {
		file.puts ( "<html>\n" );
		file.puts ( "\t<head>\n" );
		file.puts ( "\t\t<title>Vala Binding Reference</title>\n" );
		file.printf ( "\t\t<link href=\"style.css\" rel=\"stylesheet\" type=\"text/css\" />\n" );
		file.puts ( "\t</head>\n" );
		file.puts ( "\t<body>\n\n" );

		file.printf ( "\t<div class=\"%s\">\n", this.css_site_header );
		file.printf ( "\t\t%s Reference Manual\n", title );
		file.puts ( "\t</div>\n\n" );

		file.printf ( "\t\t<div class=\"%s\">\n", this.css_style_body );
	}

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

	private string get_path ( Valadoc.Basic element ) {
		return element.full_name () + ".html";
	}

	private string get_real_path ( Valadoc.Basic element ) {
		return this.settings.get_real_path ( ) + "/" + this.package_dir_name + "/" + element.full_name () + ".html";
	}

	private string get_img_path ( Valadoc.Basic element ) {
		return "img/" + element.full_name () + ".png";
	}

	private string get_img_real_path ( Valadoc.Basic element ) {
		return this.settings.get_real_path ( ) + "/" + this.package_dir_name + "/" + "img/" + element.full_name () + ".png";
	}

	~HtmlDoclet ( ) {
		this.devhelp.save_file ( this.settings.get_real_path () + "/" + vala_file_package_name + "/" + vala_file_package_name + ".devhelp2" );
	}

	public Valadoc.Settings settings {
		construct set;
		protected get;
	}

	public override void initialisation ( Settings settings ) {
		this.settings = settings;

		var rt = DirUtils.create ( this.settings.path, 0777 );
		rt = DirUtils.create ( this.settings.path + settings.pkg_name, 0777 );

		this.langlet = new Valadoc.LangletIndex ( settings );
		this.devhelp = new DevhelpFormat ( settings.pkg_name, "" );
	}

	private void write_image_block ( GLib.FileStream file, DataType element ) {
		string rpath = this.get_img_real_path ( element );
		string path = this.get_img_path ( element );

		if ( element is Class ) {
			Diagrams.write_class_diagram ( (Class)element, rpath );
		}
		else if ( element is Interface ) {
			Diagrams.write_interface_diagram ( (Interface)element, rpath );
		}
		else if ( element is Struct ) {
			Diagrams.write_struct_diagram ( (Struct)element, rpath );
		}

		file.printf ( "<h2 cass=\"%s\">Object Hierarchy:</h2>\n", css_title );
		file.printf ( "<img cass=\"%s\" src=\"%s\"/>\n", css_diagram, path );
	}

	private string vala_file_package_name;
	private bool visited_non_package = false;


	public override void visit_file ( File file ) {
		string pkg_name = get_package_name ( file.name );
		string path = this.settings.get_real_path () + pkg_name + "/";
		this.package_dir_name = pkg_name;

		if ( file.is_package == true ) {
			var rt = DirUtils.create ( path, 0777 );
			rt = DirUtils.create ( path + "img/", 0777 );
			copy_directory ( Config.doclet_path + "deps/", path );

			DevhelpFormat tmp = this.devhelp;

			this.devhelp = new DevhelpFormat ( pkg_name, "" );

			GLib.FileStream ifile = GLib.FileStream.open ( path + "index.htm", "w" );
			this.write_file_header_template ( ifile, pkg_name );
			this.write_file_footer ( ifile );
			ifile = null;

			file.visit_namespaces ( this );

			this.devhelp.save_file ( path + pkg_name + ".devhelp2" );
			this.devhelp = tmp;
		}
		else {
			if ( !visited_non_package ) {
				this.vala_file_package_name = pkg_name;
				var rt = DirUtils.create ( path, 0777 );
				rt = DirUtils.create ( path + "img/", 0777 );
				copy_directory ( Config.doclet_path + "deps/", path );
				this.devhelp.reset ( );
			}

			GLib.FileStream ifile = GLib.FileStream.open ( path + "index.htm", "w" );
			this.write_file_header_template ( ifile, pkg_name );
			this.write_file_footer ( ifile );
			ifile = null;

			file.visit_namespaces ( this );

			this.visited_non_package = true;
		}
	}

	public void write_namespace_content ( GLib.FileStream file, Namespace ns ) {
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, (ns.name == null)? "Global Namespace" : ns.full_name() );
		file.printf ( "<hr class=\"%s\" />\n", css_hr );
		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		ns.write_comment ( file );
	}

	public override void visit_namespace ( Namespace ns ) {
		string rpath = this.get_real_path ( ns );
		string path = this.get_path ( ns );

		bool file_exists = FileUtils.test ( rpath, FileTest.EXISTS);
		if ( !file_exists ) {
			GLib.FileStream file = GLib.FileStream.open ( rpath, "w" );
			this.write_file_header_template ( file, ns.full_name() );
			this.write_namespace_content ( file, ns );
			this.write_file_footer ( file );
			file = null;

			if ( ns.name != null ) {
				this.devhelp.add_keyword ( KeywordType.NAMESPACE, ns.name, path );
				this.devhelp.add_chapter_start ( ns.name, path );
			}
		}
		else {
			bool available = this.devhelp.jump_to_chapter ( ns.full_name () );
			if ( available == false ) {
				this.devhelp.add_keyword ( KeywordType.NAMESPACE, ns.name, path );
				this.devhelp.add_chapter_start ( ns.name, path );
			}
		}

		// file:
		ns.visit_namespaces ( this );
		ns.visit_classes ( this );
		ns.visit_interfaces ( this );
		ns.visit_structs ( this );
		ns.visit_enums ( this );
		ns.visit_error_domains ( this );
		ns.visit_delegates ( this );
		ns.visit_methods ( this );
		ns.visit_fields ( this );
		ns.visit_constants ( this );

		if ( ns.name != null ) {
			this.devhelp.add_chapter_end ( );
		}
	}

	private void write_child_classes ( GLib.FileStream file, ClassHandler clh ) {
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

				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_class, css_navi_link, this.get_link(subcl), name );
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
		string full_name = iface.full_name ( );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );

		this.write_image_block ( file, iface );

		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );

		file.printf ( "<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_interface ( iface, file );
		file.printf ( "\n</div>\n" );

		iface.write_comment ( file );
		this.write_namespace_note ( file, iface );
		this.write_package_note ( file, iface );
		file.printf ( "\n<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_classes ( file, iface );
		this.write_child_structs ( file, iface );
		this.write_child_delegates ( file, iface );
		this.write_child_methods ( file, iface );
		this.write_child_signals ( file, iface );
		this.write_child_properties ( file, iface );
		this.write_child_fields ( file, iface );
	}

	public override void visit_interface ( Interface iface ) {
		string rpath = this.get_real_path ( iface );
		string path = this.get_path ( iface );


		this.devhelp.add_chapter_start ( iface.name, path );

		iface.visit_classes ( this );
		iface.visit_structs ( this );
		iface.visit_delegates ( this );
		iface.visit_methods ( this );
		iface.visit_signals ( this );
		iface.visit_properties ( this );
		iface.visit_fields ( this );

		this.devhelp.add_chapter_end ( );

		this.devhelp.add_keyword ( KeywordType.INTERFACE, iface.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header_template ( file, iface.full_name() );
		this.write_interface_content ( file, iface );
		this.write_file_footer ( file );
		file = null;
	}

	public void write_class_content ( GLib.FileStream file, Class cl ) {
		string full_name = cl.full_name ( );
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
		this.write_child_classes ( file, cl );
		this.write_child_structs ( file, cl );
		this.write_child_enums ( file, cl );
		this.write_child_delegates ( file, cl );
		this.write_child_methods ( file, cl );
		this.write_child_signals ( file, cl );
		this.write_child_properties ( file, cl );
		this.write_child_fields ( file, cl );
		this.write_child_constants ( file, cl );
	}

	public override void visit_class ( Class cl ) {
		string rpath = this.get_real_path ( cl );
		string path = this.get_path ( cl );


		this.devhelp.add_keyword ( KeywordType.CLASS, cl.name, path );
		this.devhelp.add_chapter_start ( cl.name, path );

		cl.visit_construction_methods ( this );
		cl.visit_classes ( this );
		cl.visit_structs ( this );
		cl.visit_enums ( this );
		cl.visit_delegates ( this );
		cl.visit_methods ( this );
		cl.visit_signals ( this );
		cl.visit_properties ( this );
		cl.visit_fields ( this );
		cl.visit_constants ( this );

		this.devhelp.add_chapter_end ( );


		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header_template ( file, cl.full_name() );
		this.write_class_content ( file, cl );
		this.write_file_footer ( file );
		file = null;
	}

	public void write_struct_content ( GLib.FileStream file, Struct stru ) {
		string full_name = stru.full_name ( );
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
		this.write_child_methods ( file, stru );
		this.write_child_fields ( file, stru );
		this.write_child_constants ( file, stru );
	}

	public override void visit_struct ( Struct stru ) {
		string rpath = this.get_real_path ( stru );
		string path = this.get_path ( stru );


		this.devhelp.add_keyword ( KeywordType.STRUCT, stru.name, path );
		this.devhelp.add_chapter_start ( stru.name, path );

		stru.visit_construction_methods ( this );
		stru.visit_methods ( this );
		stru.visit_fields ( this );
		stru.visit_constants ( this );

		this.devhelp.add_chapter_end ( );


		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header_template ( file, stru.full_name() );
		this.write_struct_content ( file, stru );
		this.write_file_footer ( file );
		file = null;
	}

	public void write_error_domain_content ( GLib.FileStream file, ErrorDomain errdom ) {
		string full_name = errdom.full_name ( );
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
		string rpath = this.get_real_path ( errdom );
		string path = this.get_path ( errdom );

		errdom.visit_methods ( this );

		this.devhelp.add_keyword ( KeywordType.ERRORDOMAIN, errdom.name, path );
		this.devhelp.add_chapter ( errdom.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header_template ( file, errdom.full_name() );
		this.write_error_domain_content ( file, errdom );
		this.write_file_footer ( file );
		file = null;
	}

	public void write_enum_content ( GLib.FileStream file, Enum en ) {
		string full_name = en.full_name ( );
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
		string rpath = this.get_real_path ( en );
		string path = this.get_path ( en );

		en.visit_enum_values ( this );
		en.visit_methods ( this );

		this.devhelp.add_keyword ( KeywordType.ENUM, en.name, path );
		this.devhelp.add_chapter ( en.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header_template ( file, en.full_name() );
		this.write_enum_content ( file, en );
		this.write_file_footer ( file );
		file = null;
	}

	public void write_property_content ( GLib.FileStream file, Property prop ) {
		string full_name = prop.full_name ( );
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
		string rpath = this.get_real_path ( prop );
		string path = this.get_path ( prop );

		this.devhelp.add_keyword ( KeywordType.PROPERTY, prop.name, path );
		this.devhelp.add_chapter ( prop.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header_template ( file, prop.full_name() );
		this.write_property_content ( file, prop );
		this.write_file_footer ( file );
		file = null;
	}

	public void write_constant_content ( GLib.FileStream file, Constant constant, ConstantHandler parent ) {
		string full_name = constant.full_name ( );
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
		string rpath = this.get_real_path ( constant );
		string path = this.get_path ( constant );

		this.devhelp.add_keyword ( KeywordType.VARIABLE, constant.name, path );
		this.devhelp.add_chapter ( constant.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header_template ( file, constant.full_name() );
		this.write_constant_content ( file, constant, parent );
		this.write_file_footer ( file );
		file = null;
	}

	public void write_field_content ( GLib.FileStream file, Field field, FieldHandler parent ) {
		string full_name = field.full_name ( );
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
		string rpath = this.get_real_path ( field );
		string path = this.get_path ( field );

		this.devhelp.add_keyword ( KeywordType.VARIABLE, field.name, path );
		this.devhelp.add_chapter ( field.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header_template ( file, field.full_name() );
		this.write_field_content ( file, field, parent );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_error_code ( ErrorCode errcode ) {
	}

	public override void visit_enum_value ( EnumValue enval ) {
	}

	public void write_delegate_content ( GLib.FileStream file, Delegate del ) {
		string full_name = del.full_name ( );
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
		string rpath = this.get_real_path ( del );
		string path = this.get_path ( del );

		this.devhelp.add_keyword ( KeywordType.DELEGATE, del.name, path );
		this.devhelp.add_chapter ( del.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header_template ( file, del.full_name() );
		this.write_delegate_content ( file, del );
		this.write_file_footer ( file );
		file = null;
	}

	public void write_signal_content ( GLib.FileStream file, Signal sig ) {
		string full_name = sig.full_name ( );
		file.printf ( "<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_signal ( sig, file );
		file.printf ( "\n</div>\n" );
		sig.write_comment ( file );
	}

	public override void visit_signal ( Signal sig ) {
		string rpath = this.get_real_path ( sig );
		string path = this.get_path ( sig );

		this.devhelp.add_keyword ( KeywordType.SIGNAL, sig.name, path );
		this.devhelp.add_chapter ( sig.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header_template ( file, sig.full_name() );
		write_signal_content ( file, sig );
		this.write_file_footer ( file );
		file = null;
	}

	public void write_method_content ( GLib.FileStream file, Method m , Valadoc.MethodHandler parent ) {
		string full_name = m.full_name ( );
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
		string rpath = this.get_real_path ( m );
		string path = this.get_path ( m );

		this.devhelp.add_keyword ( KeywordType.FUNCTION, m.name, path );
		this.devhelp.add_chapter ( m.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header_template ( file, m.full_name() );
		this.write_method_content ( file, m, parent );
		this.write_file_footer ( file );
		file = null;
	}
}





[ModuleInit]
public Type register_plugin ( ) {
	return typeof ( Valadoc.HtmlDoclet );
}

