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
		return this.get_html_link ( this.settings, element );
	}

	public LangletIndex ( Settings settings ) {
		base ( settings );
	}
}









public class Valadoc.HtmlDoclet : Valadoc.BasicHtmlDoclet, Valadoc.LinkHelper {
	private string current_path = null;
	private bool is_vapi = false;

	protected override string get_link ( Valadoc.Basic p1, Valadoc.Basic? p2 ) {
		return this.get_html_link ( this.settings, p1 );
	}

	private override void write_top_element ( GLib.FileStream file, Basic? pos ) {
		this.write_top_element_template ( file, "?" );
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
		return this.current_path + "tree.png";
	}

	protected override string get_img_path ( Basic element ) {
		return "docs/" + get_full_path ( element ) + "tree.png";
	}

	public override void visit_package ( Package file ) {
		string package_name = file.name;
		this.is_vapi = file.is_package;

		string new_path = this.settings.path + package_name + "/";

		var rt = DirUtils.create ( new_path, 0777 );

		GLib.FileStream nav = GLib.FileStream.open ( new_path + "navi.html", "w" );
		this.write_navi_file ( nav, file, file );
		nav = null;

		GLib.FileStream sfile = GLib.FileStream.open ( new_path + "index.html", "w" );
		this.write_file_content ( sfile, file, file );
		sfile = null;


		this.current_path = new_path;
		file.visit_namespaces ( this );
		this.current_path = null;
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

		var rt = DirUtils.create ( this.current_path, 0777 );

		GLib.FileStream navi = GLib.FileStream.open ( this.current_path + "navi.html", "w" );
		this.write_navi_namespace ( navi, ns );
		navi = null;

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w" );
		this.write_namespace_content ( file, ns, ns );
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
	}

	public override void visit_interface ( Interface iface ) {
		string old_path = this.current_path;
		this.current_path += iface.name + "/";
		var rt = DirUtils.create ( this.current_path, 0777 );

		iface.visit_classes ( this );
		iface.visit_structs ( this );
		iface.visit_delegates ( this );
		iface.visit_methods ( this );
		iface.visit_signals ( this );
		iface.visit_properties ( this );
		iface.visit_fields ( this );

		GLib.FileStream cname = GLib.FileStream.open ( this.current_path + "cname", "w" );
		cname.puts ( iface.get_cname() );
		cname = null;

		GLib.FileStream navi = GLib.FileStream.open ( this.current_path + "navi.html", "w" );
		this.write_navi_interface ( navi, iface, iface );
		navi = null;

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_interface_content ( file, iface, iface );
		file = null;

		this.current_path = old_path;
	}

	public override void visit_class ( Class cl ) {
		string old_path = this.current_path;
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

		GLib.FileStream navi = GLib.FileStream.open ( this.current_path + "navi.html", "w" );
		this.write_navi_class ( navi, cl, cl );
		navi = null;

		GLib.FileStream cname = GLib.FileStream.open ( this.current_path + "cname", "w" );
		cname.puts ( cl.get_cname() );
		cname = null;

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_class_content ( file, cl, cl );
		file = null;

		this.current_path = old_path;
	}

	public override void visit_struct ( Struct stru ) {
		string old_path = this.current_path;
		this.current_path += stru.name + "/";
		var rt = DirUtils.create ( this.current_path, 0777 );

		stru.visit_construction_methods ( this );
		stru.visit_methods ( this );
		stru.visit_fields ( this );
		stru.visit_constants ( this );

		GLib.FileStream navi = GLib.FileStream.open ( this.current_path + "navi.html", "w" );
		this.write_navi_struct ( navi, stru, stru );
		navi = null;

		// FIXME: libbonoboui-2.0
		GLib.FileStream cname = GLib.FileStream.open ( this.current_path + "cname", "w" );
		if ( cname != null ) {
			cname.puts ( stru.get_cname() );
			cname = null;
		}

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_struct_content ( file, stru, stru );
		file = null;

		this.current_path = old_path;
	}

	public override void visit_error_domain ( ErrorDomain errdom ) {
		string old_path = this.current_path;
		this.current_path += errdom.name + "/";
		var rt = DirUtils.create ( this.current_path, 0777 );

		errdom.visit_methods ( this );

		GLib.FileStream cname = GLib.FileStream.open ( this.current_path + "cname", "w" );
		cname.puts ( errdom.get_cname() );
		cname = null;

		GLib.FileStream navi = GLib.FileStream.open ( this.current_path + "navi.html", "w" );
		this.write_navi_error_domain ( navi, errdom, errdom );
		navi = null;

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_error_domain_content ( file, errdom, errdom );
		file = null;

		this.current_path = old_path;
	}

	public override void visit_enum ( Enum en ) {
		string old_path = this.current_path;
		this.current_path += en.name + "/";
		var rt = DirUtils.create ( this.current_path, 0777 );

		en.visit_enum_values ( this );
		en.visit_methods ( this );

		GLib.FileStream cname = GLib.FileStream.open ( this.current_path + "cname", "w" );
		cname.puts ( en.get_cname() );
		cname = null;

		GLib.FileStream navi = GLib.FileStream.open ( this.current_path + "navi.html", "w" );
		this.write_navi_enum ( navi, en, en );
		navi = null;

		GLib.FileStream file = GLib.FileStream.open ( this.current_path + "index.html", "w");
		this.write_enum_content ( file, en, en );
		file = null;

		this.current_path = old_path;
	}

	public override void visit_property ( Property prop ) {
		string path = this.current_path + prop.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream cname = GLib.FileStream.open ( path + "cname", "w" );
		if ( prop.parent is Class ) {
			cname.printf ( "%s:%s", ((Class)prop.parent).get_cname(), prop.get_cname() );
		}
		else {
			cname.printf ( "%s:%s", ((Interface)prop.parent).get_cname(), prop.get_cname() );
		}
		cname = null;

		GLib.FileStream navi = GLib.FileStream.open ( path + "navi.html", "w" );
		this.write_navi_property ( navi, prop );
		navi = null;

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_property_content ( file, prop );
		file = null;
	}

	public override void visit_constant ( Constant constant, ConstantHandler parent ) {
		string path = this.current_path + constant.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream navi = GLib.FileStream.open ( path + "navi.html", "w" );
		this.write_navi_constant ( navi, constant );
		navi = null;

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_constant_content ( file, constant, parent );
		file = null;
	}

	public override void visit_field ( Field field, FieldHandler parent ) {
		string path = this.current_path + field.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream cname = GLib.FileStream.open ( path + "cname", "w" );
		if ( field.parent is Class ) {
			cname.puts( ((Class)field.parent).get_cname() );
		}
		else if ( field.parent is Struct ) {
			cname.puts( ((Struct)field.parent).get_cname() );
		}
		else if ( field.parent is Interface ) {
			cname.puts( ((Interface)field.parent).get_cname() );
		}
		else if ( field.parent is Namespace ) {
			cname.puts( field.get_cname() );
		}
		cname = null;

		GLib.FileStream navi = GLib.FileStream.open ( path + "navi.html", "w" );
		this.write_navi_field ( navi, field );
		navi = null;

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_field_content ( file, field, parent );
		file = null;
	}

	public override void visit_error_code ( ErrorCode errcode ) {
	}

	public override void visit_enum_value ( EnumValue enval ) {
	}

	public override void visit_delegate ( Delegate del ) {
		string path = this.current_path + del.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream cname = GLib.FileStream.open ( path + "cname", "w" );
		cname.puts ( del.get_cname() );
		cname = null;

		GLib.FileStream navi = GLib.FileStream.open ( path + "navi.html", "w" );
		this.write_navi_delegate ( navi, del );
		navi = null;

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_delegate_content ( file, del );
		file = null;
	}

	public override void visit_signal ( Signal sig ) {
		string path = this.current_path + sig.name + "/";
		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream cname = GLib.FileStream.open ( path + "cname", "w" );
		if ( sig.parent is Class ) {
			cname.printf ( "%s::%s", ((Class)sig.parent).get_cname(), sig.get_cname() );
		}
		else {
			cname.printf ( "%s::%s", ((Interface)sig.parent).get_cname(), sig.get_cname() );
		}
		cname = null;

		GLib.FileStream navi = GLib.FileStream.open ( path + "navi.html", "w" );
		this.write_navi_signal ( navi, sig );
		navi = null;

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		write_signal_content ( file, sig );
		file = null;
	}

	public override void visit_method ( Method m, Valadoc.MethodHandler parent ) {
		string path = this.current_path + m.name + "/";
		string full_name = m.full_name ();
		var rt = DirUtils.create ( path, 0777 );

		GLib.FileStream cname = GLib.FileStream.open ( path + "cname", "w" );
		cname.puts ( m.get_cname () );
		cname = null;

		GLib.FileStream navi = GLib.FileStream.open ( path + "navi.html", "w" );
		this.write_navi_method ( navi, m );
		navi = null;

		GLib.FileStream file = GLib.FileStream.open ( path + "index.html", "w");
		this.write_method_content ( file, m, parent );
		file = null;
	}

	public override void cleanups () {
	}
}





[ModuleInit]
public Type register_plugin ( ) {
	return typeof ( Valadoc.HtmlDoclet );
}

