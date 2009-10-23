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
using Valadoc.Html;
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

	construct {
		_renderer = new HtmlRenderer (this);
	}

	private string get_real_path ( Api.Node element ) {
		return GLib.Path.build_filename ( this.settings.path, element.package.name, element.full_name () + ".html" );
	}

	public override void process (Settings settings, Api.Tree tree) {
		this.settings = settings;

		DirUtils.create (this.settings.path, 0777);
		copy_directory (icons_dir, settings.path);

		write_wiki_pages (tree, css_path_wiki, Path.build_filename(settings.path, "content"));

		GLib.FileStream file = GLib.FileStream.open (GLib.Path.build_filename ( settings.path, "index.html" ), "w");
		writer = new Html.MarkupWriter (file);
		writer.xml_declaration ();
		_renderer.set_writer (writer);
		write_file_header (this.css_path_package, settings.pkg_name);
		write_navi_packages (tree);
		write_package_index_content (tree);
		write_file_footer ();
		file = null;

		tree.accept (this);
	}

	public override void visit_tree (Api.Tree tree) {
		tree.accept_children (this);
	}

	public override void visit_package (Package package) {
		string pkg_name = package.name;
		string path = GLib.Path.build_filename ( this.settings.path, pkg_name );

		var rt = DirUtils.create (path, 0777);
		rt = DirUtils.create (GLib.Path.build_filename ( path, "img" ), 0777);

		GLib.FileStream file = GLib.FileStream.open (GLib.Path.build_filename ( path, "index.htm" ), "w");
		writer = new Html.MarkupWriter (file);
		writer.xml_declaration ();
		_renderer.set_writer (writer);
		write_file_header (this.css_path, pkg_name);
		write_navi_package (package);
		write_package_content (package, package);
		write_file_footer ();
		file = null;

		package.accept_all_children (this);
	}

	public override void visit_namespace (Namespace ns) {
		string rpath = this.get_real_path (ns);

		if (ns.name != null) {
			GLib.FileStream file = GLib.FileStream.open (rpath, "w");
			writer = new Html.MarkupWriter (file);
			writer.xml_declaration ();
			_renderer.set_writer (writer);
			write_file_header (this.css_path, ns.full_name ());
			write_navi_symbol (ns);
			write_namespace_content (ns, ns);
			write_file_footer ();
			file = null;
		}

		ns.accept_all_children (this);
	}

	private void process_node (Api.Node node) {
		string rpath = this.get_real_path (node);

		GLib.FileStream file = GLib.FileStream.open (rpath, "w");
		writer = new Html.MarkupWriter (file);
		writer.xml_declaration ();
		_renderer.set_writer (writer);
		write_file_header (css_path, node.full_name());
		if (is_internal_node (node)) {
			write_navi_symbol (node);
		} else {
			write_navi_leaf_symbol (node);
		}
		write_symbol_content (node);
		write_file_footer ();
		file = null;
		node.accept_all_children (this);
	}

	public override void visit_interface (Interface item) {
		process_node (item);
	}

	public override void visit_class (Class item) {
		process_node (item);
	}

	public override void visit_struct (Struct item) {
		process_node (item);
	}

	public override void visit_error_domain (ErrorDomain item) {
		process_node (item);
	}

	public override void visit_enum (Enum item) {
		process_node (item);
	}

	public override void visit_property (Property item) {
		process_node (item);
	}

	public override void visit_constant (Constant item) {
		process_node (item);
	}

	public override void visit_field (Field item) {
		process_node (item);
	}

	public override void visit_error_code (ErrorCode item) {
	}

	public override void visit_enum_value (Api.EnumValue item) {
	}

	public override void visit_delegate (Delegate item) {
		process_node (item);
	}

	public override void visit_signal (Api.Signal item) {
		process_node (item);
	}

	public override void visit_method (Method item) {
		process_node (item);
	}
}

[ModuleInit]
public Type register_plugin ( ) {
	Valadoc.Html.get_html_link_imp = Valadoc.get_html_link;
	return typeof ( Valadoc.HtmlDoclet );
}

