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
using Valadoc.Api;
using Gee;

namespace Valadoc {
	public string? get_html_link ( Settings settings, Documentation element, Documentation? pos ) {
		if ( element is Visitable ) {
			if (! ((Visitable) element).is_visitor_accessible (settings)) {
				return null;
			}
		}

		if ( element is Api.Node ) {
			if (! ((Api.Node) element).package.is_visitor_accessible (settings)) {
				return null;
			}
		}

		if ( pos == null || ((pos!=null)?(pos is WikiPage)? ((WikiPage)pos).name=="index.valadoc": false : false) ) {
			if ( element is Package ) {
				return Path.build_filename(((Package)element).name, "index.htm");
			}
			else if ( element is Api.Node ) {
				return Path.build_filename( ((Api.Node)element).package.name, ((Api.Node)element).full_name()+".html" );
			}
			else if ( element is WikiPage ) {
				if ( pos == element ) {
					return "#";
				}
				else {
					string wikiname = ((WikiPage)element).name;
					wikiname = wikiname.ndup ( wikiname.len()-8 );
					wikiname = wikiname.replace("/", ".") + ".html";
					return Path.build_filename( "content", wikiname );
				}
			}
		}
		else if ( pos is Api.Node ) {
			if ( element is Package ) {
				return Path.build_filename("..", ((Package)element).name, "index.htm");
			}
			else if ( element is Api.Node ) {
				return Path.build_filename( "..", ((Api.Node)element).package.name, ((Api.Node)element).full_name()+".html" );
			}
			else if ( element is WikiPage ) {
				string wikiname = ((WikiPage)element).name;
				wikiname = wikiname.ndup ( wikiname.len()-8 );
				wikiname = wikiname.replace("/", ".")+".html";
				if ( wikiname == "index.html" ) {
					return Path.build_filename( "..", wikiname );
				}
				else {
					return Path.build_filename( "..", "content", wikiname );
				}
			}
		}
		else if ( pos is WikiPage ) {
			if ( element is Package ) {
				return Path.build_filename("..", ((Package)element).name, "index.htm");
			}
			else if ( element is Api.Node ) {
				return Path.build_filename( "..", ((Api.Node)element).package.name, ((Api.Node)element).full_name()+".html" );
			}
			else if ( element is WikiPage ) {
				string wikiname = ((WikiPage)element).name;
				wikiname = wikiname.ndup ( wikiname.len()-8 );
				wikiname = wikiname.replace("/", ".")+".html";

				if ( wikiname == "index.html" ) {
					return Path.build_filename("..", wikiname);
				}
				else {
					return wikiname;
				}
			}
		}
		return null;
	}
}


public class Valadoc.HtmlDoclet : Valadoc.Html.BasicDoclet {
	private const string css_path_package = "style.css";
	private const string css_path_wiki = "../style.css";
	private const string css_path = "../style.css";

	private string get_real_path ( Api.Node element ) {
		return GLib.Path.build_filename ( this.settings.path, element.package.name, element.full_name () + ".html" );
	}

	public override void initialisation ( Settings settings, Api.Tree tree ) {
		this.settings = settings;

		DirUtils.create ( this.settings.path, 0777 );
		copy_directory ( GLib.Path.build_filename ( Config.doclet_path, "deps" ), settings.path );

		this.write_wiki_pages ( tree, css_path_wiki, Path.build_filename(settings.path, "content") );

		GLib.FileStream file = GLib.FileStream.open ( GLib.Path.build_filename ( settings.path, "index.html" ), "w" );
		this.write_file_header ( file, this.css_path_package, settings.pkg_name );
		this.write_navi_packages ( file, tree );
		this.write_packages_content ( file, tree );
		this.write_file_footer ( file );
		file = null;

		Gee.Collection<Package> packages = tree.get_package_list ();
		foreach ( Package pkg in packages ) {
			pkg.visit ( this );
		}
	}

	public override void visit_package ( Package file ) {
		string pkg_name = file.name;
		string path = GLib.Path.build_filename ( this.settings.path, pkg_name );

		var rt = DirUtils.create ( path, 0777 );
		rt = DirUtils.create ( GLib.Path.build_filename ( path, "img" ), 0777 );

		GLib.FileStream ifile = GLib.FileStream.open ( GLib.Path.build_filename ( path, "index.htm" ), "w" );
		this.write_file_header ( ifile, this.css_path, pkg_name );
		this.write_navi_file ( ifile, file, file );
		this.write_file_content ( ifile, file, file );
		this.write_file_footer ( ifile );
		ifile = null;

		file.visit_namespaces ( this );
	}

	public override void visit_namespace ( Namespace ns ) {
		string rpath = this.get_real_path ( ns );

		if ( ns.name != null ) {
			GLib.FileStream file = GLib.FileStream.open ( rpath, "w" );
			this.write_file_header ( file, this.css_path, ns.full_name() );
			this.write_navi_namespace ( file, ns );
			this.write_namespace_content ( file, ns, ns );
			this.write_file_footer ( file );
			file = null;
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
	}

	public override void visit_interface ( Interface iface ) {
		string rpath = this.get_real_path ( iface );

		iface.visit_classes ( this );
		iface.visit_structs ( this );
		iface.visit_enums ( this );
		iface.visit_delegates ( this );
		iface.visit_methods ( this );
		iface.visit_signals ( this );
		iface.visit_properties ( this );
		iface.visit_fields ( this );
		iface.visit_constants ( this );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, this.css_path, iface.full_name() );
		this.write_navi_interface ( file, iface, iface );
		this.write_interface_content ( file, iface, iface );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_class ( Class cl ) {
		string rpath = this.get_real_path ( cl );

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

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, this.css_path, cl.full_name() );
		this.write_navi_class ( file, cl, cl );
		this.write_class_content ( file, cl, cl );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_struct ( Struct stru ) {
		string rpath = this.get_real_path ( stru );

		stru.visit_construction_methods ( this );
		stru.visit_methods ( this );
		stru.visit_fields ( this );
		stru.visit_constants ( this );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, this.css_path, stru.full_name() );
		this.write_navi_struct ( file, stru, stru );
		this.write_struct_content ( file, stru, stru );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_error_domain ( ErrorDomain errdom ) {
		string rpath = this.get_real_path ( errdom );

		errdom.visit_methods ( this );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, this.css_path, errdom.full_name() );
		this.write_navi_error_domain ( file, errdom, errdom );
		this.write_error_domain_content ( file, errdom, errdom );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_enum ( Enum en ) {
		string rpath = this.get_real_path ( en );

		en.visit_enum_values ( this );
		en.visit_methods ( this );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, this.css_path, en.full_name() );
		this.write_navi_enum ( file, en, en );
		this.write_enum_content ( file, en, en );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_property ( Property prop ) {
		string rpath = this.get_real_path ( prop );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, this.css_path, prop.full_name() );
		this.write_navi_property ( file, prop );
		this.write_property_content ( file, prop );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_constant ( Constant constant, ConstantHandler parent ) {
		string rpath = this.get_real_path ( constant );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, this.css_path, constant.full_name() );
		this.write_navi_constant ( file, constant );
		this.write_constant_content ( file, constant, parent );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_field ( Field field, FieldHandler parent ) {
		string rpath = this.get_real_path ( field );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, this.css_path, field.full_name() );
		this.write_navi_field ( file, field );
		this.write_field_content ( file, field, parent );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_error_code ( ErrorCode errcode ) {
	}

	public override void visit_enum_value ( Api.EnumValue enval ) {
	}

	public override void visit_delegate ( Delegate del ) {
		string rpath = this.get_real_path ( del );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, this.css_path, del.full_name() );
		this.write_navi_delegate ( file, del );
		this.write_delegate_content ( file, del );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_signal ( Api.Signal sig ) {
		string rpath = this.get_real_path ( sig );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, this.css_path, sig.full_name() );
		this.write_navi_signal ( file, sig );
		write_signal_content ( file, sig );
		this.write_file_footer ( file );
		file = null;
	}

	public override void visit_method ( Method m, Api.MethodHandler parent ) {
		string rpath = this.get_real_path ( m );

		GLib.FileStream file = GLib.FileStream.open ( rpath, "w");
		this.write_file_header ( file, this.css_path, m.full_name() );
		this.write_navi_method ( file, m );
		this.write_method_content ( file, m, parent );
		this.write_file_footer ( file );
		file = null;
	}
}





[ModuleInit]
public Type register_plugin ( ) {
	Valadoc.Html.get_html_link_imp = Valadoc.get_html_link;
	return typeof ( Valadoc.HtmlDoclet );
}

