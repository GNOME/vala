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
using Xml;
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



public enum Valadoc.Devhelp.KeywordType {
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

public class Valadoc.Devhelp.DevhelpFormat : Object {
	private Xml.Doc* devhelp = null;
	private Xml.Node* functions = null;
	private Xml.Node* chapters = null;
	private Xml.Node* current = null;
/*
	~DevhelpFormat ( ) {
		delete this.devhelp;
	}
*/
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



public class Valadoc.Devhelp.Doclet : Valadoc.Html.BasicDoclet {
	private const string css_path_wiki = "../wikistyle.css";
	private const string css_path = "wikistyle.css";
	private string package_dir_name = ""; // remove
	private DevhelpFormat devhelp;
	private Api.Tree tree;

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

		this.devhelp = new DevhelpFormat (settings.pkg_name, "");

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
		copy_directory (Config.doclet_path + "deps/", path);

		this.devhelp = new DevhelpFormat (pkg_name, "");

		GLib.FileStream file = GLib.FileStream.open (filepath, "w");
		writer = new MarkupWriter (file);
		writer.xml_declaration ();
		_renderer.set_writer (writer);
		write_file_header (this.css_path, pkg_name);
		write_package_content (package, package, wikipage);
		write_file_footer ();
		file = null;

		package.accept_all_children (this);

		this.devhelp.save_file (devpath);
	}

	private void process_compound_node (Api.Node node, KeywordType type) {
		string rpath = this.get_real_path (node);
		string path = this.get_path (node);

		if (node.name != null) {
			this.devhelp.add_chapter_start (node.name, path);
	
			GLib.FileStream file = GLib.FileStream.open (rpath, "w");
			writer = new MarkupWriter (file);
			writer.xml_declaration ();
			_renderer.set_writer (writer);
			write_file_header (css_path, node.full_name ());
			write_symbol_content (node);
			write_file_footer ();
			file = null;
		}

		node.accept_all_children (this);

		if (node.name != null) {
			this.devhelp.add_chapter_end ();
			this.devhelp.add_keyword (type, node.name, path);
		}
	}

	private void process_node (Api.Node node, KeywordType type) {
		string rpath = this.get_real_path (node);
		string path = this.get_path (node);

		GLib.FileStream file = GLib.FileStream.open (rpath, "w");
		writer = new MarkupWriter (file);
		writer.xml_declaration ();
		_renderer.set_writer (writer);
		write_file_header (css_path, node.full_name());
		write_symbol_content (node);
		write_file_footer ();
		file = null;

		node.accept_all_children (this);

		this.devhelp.add_keyword (type, node.name, path);
		this.devhelp.add_chapter (node.name, path);
	}

	public override void visit_namespace (Namespace item) {
		process_compound_node (item, KeywordType.NAMESPACE);
	}

	public override void visit_interface (Interface item) {
		process_compound_node (item, KeywordType.INTERFACE);
	}

	public override void visit_class (Class item) {
		process_compound_node (item, KeywordType.CLASS);
	}

	public override void visit_struct (Struct item) {
		process_compound_node (item, KeywordType.STRUCT);
	}

	public override void visit_error_domain (ErrorDomain item) {
		process_node (item, KeywordType.ERRORDOMAIN);
	}

	public override void visit_enum ( Enum item) {
		process_node (item, KeywordType.ENUM);
	}

	public override void visit_property (Property item) {
		process_node (item, KeywordType.PROPERTY);
	}

	public override void visit_constant (Constant item) {
		process_node (item, KeywordType.VARIABLE);
	}

	public override void visit_field (Field item) {
		process_node (item, KeywordType.VARIABLE);
	}

	public override void visit_error_code (ErrorCode item) {
	}

	public override void visit_enum_value (Api.EnumValue item) {
	}

	public override void visit_delegate (Delegate item) {
		process_node (item, KeywordType.DELEGATE);
	}

	public override void visit_signal (Api.Signal item) {
		process_node (item, KeywordType.SIGNAL);
	}

	public override void visit_method (Method item) {
		process_node (item, KeywordType.FUNCTION);
	}
}

[ModuleInit]
public Type register_plugin () {
	Valadoc.Html.get_html_link_imp = Valadoc.Devhelp.get_html_link;
	return typeof (Valadoc.Devhelp.Doclet);
}

