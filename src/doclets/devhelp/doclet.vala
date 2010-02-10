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


namespace Valadoc.Devhelp {
	public string? get_html_link ( Settings settings, Documentation element, Documentation? pos ) {
		if ( element is Visitable ) {
			if ( ((Visitable)element).is_visitor_accessible (settings) == false ) {
				return null;
			}
		}

		if ( element is Api.Node ) {
			if ( ((Api.Node)element).package.is_visitor_accessible (settings) == false ) {
				return null;
			}
		}

		if ( pos == null || ((pos!=null)?(pos is WikiPage)? ((WikiPage)pos).name=="index.valadoc": false : false) ) {
			if ( element is Package ) {
				return Path.build_filename(((Package)element).name, "index.htm");
			}
			else if ( element is Api.Node ) {
				return Path.build_filename("..", ((Api.Node)element).package.name, ((Api.Node)element).full_name()+".html" );
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



public class Valadoc.Devhelp.Doclet : Valadoc.Html.BasicDoclet {
	private const string css_path_wiki = "../devhelpstyle.css";
	private const string css_path = "devhelpstyle.css";

	private ArrayList<Api.Node> nodes = new ArrayList<Api.Node> ();
	private string package_dir_name = ""; // remove
	private Api.Tree tree;

	private Devhelp.MarkupWriter _devhelpwriter;

	construct {
		_renderer = new HtmlRenderer (this);
	}

	private string get_path (Api.Node element) {
		return element.full_name () + ".html";
	}

	private string get_real_path (Api.Node element) {
		return GLib.Path.build_filename (this.settings.path, this.package_dir_name, element.full_name () + ".html");
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
		string filepath = GLib.Path.build_filename (path, "index.htm");
		string imgpath = GLib.Path.build_filename (path, "img");
		string devpath = GLib.Path.build_filename (path, pkg_name + ".devhelp2");


		WikiPage wikipage = null;
		if (this.settings.pkg_name == package.name && this.tree.wikitree != null) {
			wikipage = this.tree.wikitree.search ("index.valadoc");
		}

		this.package_dir_name = pkg_name;

		var rt = DirUtils.create (path, 0777);
		rt = DirUtils.create (imgpath, 0777);
		copy_directory (icons_dir, path);

		var devfile = FileStream.open (devpath, "w");
		_devhelpwriter = new Devhelp.MarkupWriter (devfile);

		_devhelpwriter.start_book (pkg_name+" Reference Manual", "vala", "index.htm", "", "", "");

		GLib.FileStream file = GLib.FileStream.open (filepath, "w");
		writer = new Html.MarkupWriter (file);
		_renderer.set_writer (writer);
		write_file_header (this.css_path, pkg_name);
		write_package_content (package, package, wikipage);
		write_file_footer ();
		file = null;


		_devhelpwriter.start_chapters ();
		package.accept_all_children (this);
		_devhelpwriter.end_chapters ();


		_devhelpwriter.start_functions ();
		foreach (Api.Node node in this.nodes) {
			string typekeyword = "";
			if (node is Api.Enum) {
				typekeyword = "enum";
			} else if (node is Api.Constant) {
				typekeyword = "constant";
			} else if (node is Api.Method) {
				typekeyword = "function";
			} else if (node is Api.Field) {
				typekeyword = "variable";
			} else if (node is Api.Property) {
				typekeyword = "property";
			} else if (node is Api.Signal) {
				typekeyword = "signal";
			} else if (node is Api.Struct) {
				typekeyword = "struct";
			}

			_devhelpwriter.simple_tag ("keyword", {"type", typekeyword, "name", node.name, "link", get_html_link_imp (settings, node, null)});
		}
		_devhelpwriter.end_functions ();

		_devhelpwriter.end_book ();
	}

	private void process_compound_node (Api.Node node) {
		string rpath = this.get_real_path (node);
		string path = this.get_path (node);

		if (node.name != null) {
			GLib.FileStream file = GLib.FileStream.open (rpath, "w");
			writer = new Html.MarkupWriter (file);
			_renderer.set_writer (writer);
			write_file_header (css_path, node.full_name ());
			write_symbol_content (node);
			write_file_footer ();
			file = null;
		}

		if (node.name != null) {
			_devhelpwriter.start_sub (node.name, path);
			node.accept_all_children (this);
			_devhelpwriter.end_sub ();
			this.nodes.add (node);
		} else {
			node.accept_all_children (this);
		}
	}

	private void process_node (Api.Node node) {
		string rpath = this.get_real_path (node);
		string path = this.get_path (node);

		GLib.FileStream file = GLib.FileStream.open (rpath, "w");
		writer = new Html.MarkupWriter (file);
		_renderer.set_writer (writer);
		write_file_header (css_path, node.full_name());
		write_symbol_content (node);
		write_file_footer ();
		file = null;

		_devhelpwriter.start_sub (node.name, path);
		node.accept_all_children (this);
		_devhelpwriter.end_sub ();
	}

	public override void visit_namespace (Namespace item) {
		process_compound_node (item);
	}

	public override void visit_interface (Interface item) {
		process_compound_node (item);
	}

	public override void visit_class (Class item) {
		process_compound_node (item);
	}

	public override void visit_struct (Struct item) {
		process_compound_node (item);
	}

	public override void visit_error_domain (ErrorDomain item) {
		process_node (item);
	}

	public override void visit_enum (Api.Enum item) {
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
public Type register_plugin () {
	Valadoc.Html.get_html_link_imp = Valadoc.Devhelp.get_html_link;
	return typeof (Valadoc.Devhelp.Doclet);
}

