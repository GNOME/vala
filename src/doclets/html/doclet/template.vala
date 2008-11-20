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





public class Valadoc.LangletIndex : Valadoc.BasicHtmlLanglet, Valadoc.LinkHelper {
	protected override string get_link ( Basic element, Basic pos ) {
		return this.get_html_link ( this.settings, element, pos );
	}

	public LangletIndex ( Settings settings ) {
		base ( settings );
	}
}






public class Valadoc.HtmlDoclet : Valadoc.BasicHtmlDoclet, Valadoc.LinkHelper {
	private string current_path = null;
	private string package_name = null;
	private bool is_vapi = false;

	private int directory_level = 1;

 	private string get_css_link ( ) {
		GLib.StringBuilder css_path = new GLib.StringBuilder ( );
		for ( int i = 0; this.directory_level > i; i++ ) {
			css_path.append ( "../" );
		}
		css_path.append ( "main.css" );
		return css_path.str;
	}

	protected override string get_link ( Valadoc.Basic element, Valadoc.Basic? pos ) {
		return this.get_html_link ( this.settings, element, pos );
	}

	protected override void write_top_element ( GLib.FileStream file, Basic? pos ) {
		string top = "";

		if ( pos != null )
			top = get_html_top_link ( pos ) ;

		this.write_top_element_template ( file, top+"packages.html" );
	}



	private string get_full_path ( Basic element ) {
		if ( element.name == null )
			return "";

		GLib.StringBuilder str = new GLib.StringBuilder ( "" );

		for ( var pos = element; pos != null ; pos = pos.parent ) {
			if ( pos is Package )
				break;

			str.prepend_unichar ( '/' );

			if ( pos.name == null )
				str.prepend ( "0" );
			else
				str.prepend ( pos.name );
		}

		string package_name = element.file.name  + "/";

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

	protected override string get_img_real_path ( Basic element ) {
		if ( element is Package ) {
			return this.current_path + element.name + ".png";
		}

		return this.current_path + "tree.png";
	}

	protected override string get_img_path ( Basic element ) {
		if ( element is Package ) {
			return element.name + ".png";
		}

		return "tree.png";
	}

	public override void visit_package ( Package file ) {
		this.package_name = file.name;

		this.is_vapi = file.is_package;
		if ( this.is_vapi )
			this.files.add ( file );
		else
			source_package = file;

		this.current_path = this.settings.path + this.package_name + "/";

		var rt = DirUtils.create ( this.current_path, 0777 );
		GLib.FileStream sfile = GLib.FileStream.open ( this.current_path + "index.html", "w" );
		this.write_file_header ( sfile, this.get_css_link ( ), file.name );
		this.write_navi_file ( sfile, file, file );
		this.write_file_content ( sfile, file, file );
		this.write_file_footer ( sfile );
		sfile = null;


		file.visit_namespaces ( this );
		this.current_path = null;
	}


	private bool is_depency ( string dep ) {
		foreach ( string file in this.settings.files ) {
			if ( dep == file )
				return false;
		}
		return true;
	}

	private Gee.ArrayList<Package> files = new Gee.ArrayList<Package> ();
	private Package source_package;

	public override void cleanups () {
		this.directory_level = 0;
		copy_directory ( Config.doclet_path + "deps/", this.settings.path );


		if ( this.source_package != null ) {
			GLib.FileStream sfile = GLib.FileStream.open ( this.settings.path + "index.html", "w" );
			this.write_file_header ( sfile, this.get_css_link ( ), source_package.name );
			this.write_navi_file ( sfile, source_package, null );
			this.write_file_content ( sfile, source_package, null );
			this.write_file_footer ( sfile );
			sfile = null;
		}

		GLib.FileStream sfile = GLib.FileStream.open ( this.settings.path + "packages.html", "w" );
		string title = ( this.settings.pkg_name == null )? "" : this.settings.pkg_name;
		this.write_file_header ( sfile, this.get_css_link ( ), title );

		sfile.printf ( "<h2 class=\"%s\">Packages:</h2>\n", css_title );
		sfile.printf ( "<ul class=\"%s\">\n", css_inline_navigation );

		foreach ( Package file in this.files ) {
			if ( this.settings.with_deps )
				sfile.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s/index.html\">%s</a></li>\n", css_inline_navigation_package, css_navi_link, file.name, file.name );
			else
				sfile.printf ( "\t<li class=\"%s\">%s</li>\n", css_inline_navigation_package, file.name );
		}

		sfile.puts ( "</ul>\n" );
		this.write_file_footer ( sfile );
	}

	public override void visit_property ( Property prop ) {
		string path = this.current_path + prop.name + "/";
		var rt = DirUtils.create ( path, 0777 );
		this.directory_level++;

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_file_header ( file, this.get_css_link ( ), prop.name );
		this.write_navi_property ( file, prop );
		this.write_property_content ( file, prop );
		this.write_file_footer ( file );

		this.directory_level--;
		file = null;
	}

	public override void visit_constant ( Constant constant, ConstantHandler parent ) {
		string path = this.current_path + constant.name + "/";

		var rt = DirUtils.create ( path, 0777 );
		this.directory_level++;
		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_file_header ( file, this.get_css_link ( ), constant.name );
		this.write_navi_constant ( file, constant );
		this.write_constant_content ( file, constant, parent );
		this.write_file_footer ( file );
		this.directory_level--;
		file = null;
	}

	public override void visit_field ( Field field, FieldHandler parent ) {
		string path = this.current_path + field.name + "/";
		var rt = DirUtils.create ( path, 0777 );
		this.directory_level++;
		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_file_header ( file, this.get_css_link ( ), field.name );
		this.write_navi_field ( file, field );
		this.write_field_content ( file, field, parent );
		this.write_file_footer ( file );
		this.directory_level--;
		file = null;
	}

	public override void visit_delegate ( Delegate del ) {
		string path = this.current_path + del.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		this.directory_level++;
		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_file_header ( file, this.get_css_link ( ), del.name );
		this.write_navi_delegate ( file, del );
		this.write_delegate_content ( file, del );
		this.write_file_footer ( file );
		this.directory_level--;
		file = null;
	}

	public override void visit_signal ( Signal sig ) {
		string path = this.current_path + sig.name + "/";
		this.directory_level++;

		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_file_header ( file, this.get_css_link ( ), sig.name );
		this.write_navi_signal ( file, sig );
		write_signal_content ( file, sig );
		this.write_file_footer ( file );

		this.directory_level--;
		file = null;
	}

	public override void visit_method ( Method m, Valadoc.MethodHandler parent ) {
		string path = this.current_path + m.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		this.directory_level++;
		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_file_header ( file, this.get_css_link ( ), m.name );
		this.write_navi_method ( file, m );
		this.write_method_content ( file, m, parent );
		this.write_file_footer ( file );

		this.directory_level--;
		file = null;
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

		var rt = DirUtils.create ( this.current_path, 0777 );
		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w" );
		this.write_file_header ( file, this.get_css_link ( ), ns.name );
		this.write_navi_namespace ( file, ns );
		this.write_namespace_content ( file, ns, ns );
		this.write_file_footer ( file );
		file = null;

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
		this.write_file_header ( file, this.get_css_link ( ), en.name );
		this.write_navi_enum ( file, en, en );
		this.write_enum_content ( file, en, en );
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
		this.write_file_header ( file, this.get_css_link ( ), errdom.name );
		this.write_navi_error_domain ( file, errdom, errdom );
		this.write_error_domain_content ( file, errdom, errdom );
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

		stru.visit_construction_methods ( this );
		stru.visit_methods ( this );
		stru.visit_fields ( this );	
		stru.visit_constants ( this );

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_file_header ( file, this.get_css_link ( ), stru.name );
		this.write_navi_struct ( file, stru, stru );
		this.write_struct_content ( file, stru, stru );
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

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_file_header ( file, this.get_css_link ( ), cl.name );
		this.write_navi_class ( file, cl, cl );
		this.write_class_content ( file, cl, cl );
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

		iface.visit_classes ( this );
		iface.visit_structs ( this );
		iface.visit_delegates ( this );
		iface.visit_methods ( this );
		iface.visit_signals ( this );
		iface.visit_properties ( this );
		iface.visit_fields ( this );

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w" );
		this.write_file_header ( file, this.get_css_link ( ), iface.name );
		this.write_navi_interface ( file, iface, iface );
		this.write_interface_content ( file, iface, iface );
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

