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



public class Valadoc.LangletIndex : Valadoc.BasicHtmlLanglet, Valadoc.HtmlHelper {
	protected override string get_link ( Basic element, Basic pos ) {
		return this.get_html_link ( this.settings, element, pos );
	}

	public LangletIndex ( Settings settings ) {
		base ( settings );
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





//public string get_html_link ( Settings settings, Basic el, Basic? pos ) {
//	return "../" + this.get_package_name ( tag.file.name ) + "/" + tag.full_name () + ".html";
//}






public class Valadoc.HtmlDoclet : Valadoc.BasicHtmlDoclet, Valadoc.HtmlHelper {
	private string package_dir_name = "";
	private DevhelpFormat devhelp;

	protected override string get_link ( Valadoc.Basic p1, Valadoc.Basic? p2 ) {
		return this.get_html_link ( this.settings, p1, p2 );		
	}

	private string get_path ( Valadoc.Basic element ) {
		return element.full_name () + ".html";
	}

	private string get_real_path ( Valadoc.Basic element ) {
		return this.settings.get_real_path ( ) + "/" + this.package_dir_name + "/" + element.full_name () + ".html";
	}

	protected override string get_img_path ( Valadoc.Basic element ) {
		return "img/" + element.full_name () + ".png";
	}

	protected override string get_img_real_path ( Valadoc.Basic element ) {
		return this.settings.get_real_path ( ) + "/" + this.package_dir_name + "/" + "img/" + element.full_name () + ".png";
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

	private string vala_file_package_name;
	private bool visited_non_package = false;


	public override void visit_package ( Package file ) {
		string pkg_name = file.name;
		string path = this.settings.get_real_path () + pkg_name + "/";
		this.package_dir_name = pkg_name;

		var rt = DirUtils.create ( path, 0777 );
		rt = DirUtils.create ( path + "img/", 0777 );
		copy_directory ( Config.doclet_path + "deps/", path );

		this.devhelp = new DevhelpFormat ( pkg_name, "" );

		GLib.FileStream ifile = GLib.FileStream.open ( path + "index.htm", "w" );
		this.write_file_header ( ifile, "style.css", pkg_name );
		this.write_file_content ( ifile, file, file );
		this.write_file_footer ( ifile );
		ifile = null;

		file.visit_namespaces ( this );

		this.devhelp.save_file ( path + pkg_name + ".devhelp2" );
	}

	public override void visit_namespace ( Namespace ns ) {
		string rpath = this.get_real_path ( ns );
		string path = this.get_path ( ns );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w" );
		this.write_file_header ( file, "style.css", ns.full_name() );
		this.write_namespace_content ( file, ns, ns );
		this.write_file_footer ( file );
		file = null;

		if ( ns.name != null ) {
			this.devhelp.add_keyword ( KeywordType.NAMESPACE, ns.name, path );
			this.devhelp.add_chapter_start ( ns.name, path );
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
		this.write_file_header ( file, "style.css", iface.full_name() );
		this.write_interface_content ( file, iface, iface );
		this.write_file_footer ( file );
		file = null;
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
		this.write_file_header ( file, "style.css", cl.full_name() );
		this.write_class_content ( file, cl, cl );
		this.write_file_footer ( file );
		file = null;
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
		this.write_file_header ( file, "style.css", stru.full_name() );

		// HIER CRASHT ES!!
		this.write_struct_content ( file, stru, stru );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_error_domain ( ErrorDomain errdom ) {
		string rpath = this.get_real_path ( errdom );
		string path = this.get_path ( errdom );

		errdom.visit_methods ( this );

		this.devhelp.add_keyword ( KeywordType.ERRORDOMAIN, errdom.name, path );
		this.devhelp.add_chapter ( errdom.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, "style.css", errdom.full_name() );
		this.write_error_domain_content ( file, errdom, errdom );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_enum ( Enum en ) {
		string rpath = this.get_real_path ( en );
		string path = this.get_path ( en );

		en.visit_enum_values ( this );
		en.visit_methods ( this );

		this.devhelp.add_keyword ( KeywordType.ENUM, en.name, path );
		this.devhelp.add_chapter ( en.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, "style.css", en.full_name() );
		this.write_enum_content ( file, en, en );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_property ( Property prop ) {
		string rpath = this.get_real_path ( prop );
		string path = this.get_path ( prop );

		this.devhelp.add_keyword ( KeywordType.PROPERTY, prop.name, path );
		this.devhelp.add_chapter ( prop.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, "style.css", prop.full_name() );
		this.write_property_content ( file, prop );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_constant ( Constant constant, ConstantHandler parent ) {
		string rpath = this.get_real_path ( constant );
		string path = this.get_path ( constant );

		this.devhelp.add_keyword ( KeywordType.VARIABLE, constant.name, path );
		this.devhelp.add_chapter ( constant.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, "style.css", constant.full_name() );
		this.write_constant_content ( file, constant, parent );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_field ( Field field, FieldHandler parent ) {
		string rpath = this.get_real_path ( field );
		string path = this.get_path ( field );

		this.devhelp.add_keyword ( KeywordType.VARIABLE, field.name, path );
		this.devhelp.add_chapter ( field.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, "style.css", field.full_name() );
		this.write_field_content ( file, field, parent );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_error_code ( ErrorCode errcode ) {
	}

	public override void visit_enum_value ( EnumValue enval ) {
	}

	public override void visit_delegate ( Delegate del ) {
		string rpath = this.get_real_path ( del );
		string path = this.get_path ( del );

		this.devhelp.add_keyword ( KeywordType.DELEGATE, del.name, path );
		this.devhelp.add_chapter ( del.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, "style.css", del.full_name() );
		this.write_delegate_content ( file, del );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_signal ( Signal sig ) {
		string rpath = this.get_real_path ( sig );
		string path = this.get_path ( sig );

		this.devhelp.add_keyword ( KeywordType.SIGNAL, sig.name, path );
		this.devhelp.add_chapter ( sig.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, "style.css", sig.full_name() );
		write_signal_content ( file, sig );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_method ( Method m, Valadoc.MethodHandler parent ) {
		string rpath = this.get_real_path ( m );
		string path = this.get_path ( m );

		this.devhelp.add_keyword ( KeywordType.FUNCTION, m.name, path );
		this.devhelp.add_chapter ( m.name, path );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, "style.css", m.full_name() );
		this.write_method_content ( file, m, parent );
		this.write_file_footer ( file );
		file = null;
	}

	public override void cleanups () {
	}
}





[ModuleInit]
public Type register_plugin ( ) {
	return typeof ( Valadoc.HtmlDoclet );
}

