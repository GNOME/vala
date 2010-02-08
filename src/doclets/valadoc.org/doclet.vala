/* doclet.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */

using Valadoc;
using Valadoc.Api;
using Valadoc.Html;
using Gee;


namespace Valadoc.ValadocOrg {
	public string? get_html_link (Settings settings, Documentation element, Documentation? pos) {
		if (element is Visitable) {
			if (((Visitable)element).is_visitor_accessible (settings) == false) {
				return null;
			}
		}

		if (element is Api.Node) {
			if (((Api.Node)element).package.is_visitor_accessible (settings) == false) {
				return null;
			}
		}

		if ( pos == null || ((pos!=null)?(pos is WikiPage)? ((WikiPage)pos).name=="index.valadoc": false : false) ) {
			if (element is Package) {
				return Path.build_filename(((Package)element).name, "index.htm");
			} else if ( element is Api.Node ) {
				return Path.build_filename("..", ((Api.Node)element).package.name, ((Api.Node)element).full_name()+".html");
			} else if (element is WikiPage) {
				if (pos == element) {
					return "#";
				}
				else {
					string wikiname = ((WikiPage)element).name;
					wikiname = wikiname.ndup (wikiname.len()-8);
					wikiname = wikiname.replace ("/", ".") + ".html";
					return Path.build_filename ("content", wikiname);
				}
			}
		}
		else if (pos is Api.Node) {
			if (element is Package) {
				return Path.build_filename("..", ((Package)element).name, "index.htm");
			} else if (element is Api.Node) {
				return Path.build_filename("..", ((Api.Node)element).package.name, ((Api.Node)element).full_name()+".html");
			} else if ( element is WikiPage ) {
				string wikiname = ((WikiPage)element).name;
				wikiname = wikiname.ndup (wikiname.len()-8);
				wikiname = wikiname.replace ("/", ".")+".html";
				if ( wikiname == "index.html" ) {
					return Path.build_filename ("..", wikiname);
				} else {
					return Path.build_filename ("..", "content", wikiname);
				}
			}
		}
		else if ( pos is WikiPage ) {
			if ( element is Package ) {
				return Path.build_filename ("..", ((Package)element).name, "index.htm");
			} else if (element is Api.Node) {
				return Path.build_filename ("..", ((Api.Node)element).package.name, ((Api.Node)element).full_name()+".html");
			} else if (element is WikiPage) {
				string wikiname = ((WikiPage) element).name;
				wikiname = wikiname.ndup ( wikiname.len ()-8 );
				wikiname = wikiname.replace ("/", ".")+".html";

				if (wikiname == "index.html") {
					return Path.build_filename ("..", wikiname);
				} else {
					return wikiname;
				}
			}
		}
		return null;
	}
}



public class Valadoc.ValadocOrg.Doclet : Valadoc.Html.BasicDoclet {
	private const string css_path_wiki = "../../wiki-style.css";
	private const string css_path = "../reference-style.css";

	private ArrayList<Api.Node> nodes = new ArrayList<Api.Node> ();
	private string package_dir_name = ""; // remove
	private Api.Tree tree;

	construct {
		_renderer = new ValadocOrg.HtmlRenderer (this);
	}

	private string get_path (Api.Node element) {
		return element.full_name () + ".html";
	}

	private string get_real_path (Api.Node element, string file_extension) {
		return GLib.Path.build_filename (this.settings.path, this.package_dir_name, element.full_name () + file_extension);
	}

	public override void process (Settings settings, Api.Tree tree) {
		this.settings = settings;
		this.tree = tree;

		DirUtils.create (this.settings.path, 0777);

		write_wiki_pages (tree, css_path_wiki, Path.build_filename (this.settings.path, this.settings.pkg_name, "content"));
		tree.accept (this);
	}

	public override void visit_tree (Api.Tree tree) {
		tree.accept_children (this);
	}

	public override void visit_package (Package package) {
		string pkg_name = package.name;

		string path = GLib.Path.build_filename (this.settings.path, pkg_name);
		string imgpath = GLib.Path.build_filename (path, "img");


		var rt = DirUtils.create (path, 0777);
		rt = DirUtils.create (imgpath, 0777);


		this.package_dir_name = pkg_name;


		// content area:
		string filepath = GLib.Path.build_filename (path, "index.content.tpl");

		WikiPage wikipage = null;
		if (this.settings.pkg_name == package.name && this.tree.wikitree != null) {
			wikipage = this.tree.wikitree.search ("index.valadoc");
		}

		GLib.FileStream file = GLib.FileStream.open (filepath, "w");
		writer = new Html.MarkupWriter (file, false);
		_renderer.set_writer (writer);
		write_package_content (package, package, wikipage);
		file = null;


		// navigation:
		filepath = GLib.Path.build_filename (path, "index.navi.tpl");
		file = GLib.FileStream.open (filepath, "w");
		writer = new Html.MarkupWriter (file, false);
		_renderer.set_writer (writer);
		write_navi_package (package);
		file = null;


		package.accept_all_children (this);
	}

	private void process_compound_node (Api.Node node) {
		if (node.name != null) {
			// content area:
			string rpath = this.get_real_path (node, ".content.tpl");
			GLib.FileStream file = GLib.FileStream.open (rpath, "w");
			writer = new Html.MarkupWriter (file, false);
			_renderer.set_writer (writer);
			write_symbol_content (node, "/doc/glib-2.0/img/");
			file = null;


			// navigation:
			rpath = this.get_real_path (node, ".navi.tpl");
			file = GLib.FileStream.open (rpath, "w");
			writer = new Html.MarkupWriter (file, false);
			_renderer.set_writer (writer);
			write_navi_symbol (node);
			file = null;
		}

		node.accept_all_children (this);
	}

	private void process_node (Api.Node node) {
		// content area:
		string rpath = this.get_real_path (node, ".content.tpl");
		GLib.FileStream file = GLib.FileStream.open (rpath, "w");
		writer = new Html.MarkupWriter (file, false);
		_renderer.set_writer (writer);
		write_symbol_content (node, "/doc/glib-2.0/img/");
		file = null;


		// navigation:
		rpath = this.get_real_path (node, ".navi.tpl");
		file = GLib.FileStream.open (rpath, "w");
		writer = new Html.MarkupWriter (file, false);
		_renderer.set_writer (writer);
		write_navi_symbol (node);
		file = null;


		node.accept_all_children (this);
	}

	public override void visit_namespace (Api.Namespace item) {
		process_compound_node (item);
	}

	public override void visit_interface (Api.Interface item) {
		process_compound_node (item);
	}

	public override void visit_class (Api.Class item) {
		process_compound_node (item);
	}

	public override void visit_struct (Api.Struct item) {
		process_compound_node (item);
	}

	public override void visit_error_domain (Api.ErrorDomain item) {
		process_node (item);
	}

	public override void visit_enum (Api.Enum item) {
		process_node (item);
	}

	public override void visit_property (Api.Property item) {
		process_node (item);
	}

	public override void visit_constant (Api.Constant item) {
		process_node (item);
	}

	public override void visit_field (Api.Field item) {
		process_node (item);
	}

	public override void visit_error_code (Api.ErrorCode item) {
		process_node (item);
	}

	public override void visit_enum_value (Api.EnumValue item) {
		process_node (item);
	}

	public override void visit_delegate (Api.Delegate item) {
		process_node (item);
	}

	public override void visit_signal (Api.Signal item) {
		process_node (item);
	}

	public override void visit_method (Api.Method item) {
		process_node (item);
	}
}

[ModuleInit]
public Type register_plugin () {
	Valadoc.Html.get_html_link_imp = Valadoc.ValadocOrg.get_html_link;
	return typeof (Valadoc.ValadocOrg.Doclet);
}

