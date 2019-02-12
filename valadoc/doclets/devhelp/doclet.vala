/* doclet.vala
 *
 * Copyright (C) 2008-2012 Florian Brosch
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

public class Valadoc.Devhelp.Doclet : Valadoc.Html.BasicDoclet {
	private const string css_path_wiki = "devhelpstyle.css";
	private const string css_path = "devhelpstyle.css";

	private const string js_path_wiki = "scripts.js";
	private const string js_path = "scripts.js";


	private Vala.ArrayList<Api.Node> nodes = new Vala.ArrayList<Api.Node> ();
	private string package_dir_name = ""; // remove

	private Devhelp.MarkupWriter _devhelpwriter;

	private string get_path (Api.Node element) {
		return element.get_full_name () + ".html";
	}

	private string get_real_path (Api.Node element) {
		return GLib.Path.build_filename (this.settings.path,
				this.package_dir_name, element.get_full_name () + ".html");
	}

	protected override string get_icon_directory () {
		return "";
	}


	public override void process (Settings settings, Api.Tree tree, ErrorReporter reporter) {
		base.process (settings, tree, reporter);
		DirUtils.create_with_parents (this.settings.path, 0777);
		write_wiki_pages (tree,
						  css_path_wiki,
						  js_path_wiki,
						  Path.build_filename (this.settings.path, this.settings.pkg_name));
		tree.accept (this);
	}

	public override void visit_tree (Api.Tree tree) {
		tree.accept_children (this);
	}

	public override void visit_package (Package package) {
		if (!package.is_browsable (settings)) {
			return ;
		}

		string pkg_name = package.name;

		string path = GLib.Path.build_filename (this.settings.path, pkg_name);
		string filepath = GLib.Path.build_filename (path, "index.htm");
		string imgpath = GLib.Path.build_filename (path, "img");
		string devpath = GLib.Path.build_filename (path, pkg_name + ".devhelp2");

		this.package_dir_name = pkg_name;

		var rt = DirUtils.create (path, 0777);
		rt = DirUtils.create (imgpath, 0777);
		if (!copy_directory (Config.PACKAGE_VALADOC_ICONDIR, path)) {
			reporter.simple_warning ("Devhelp", "Couldn't copy resources from `%s'".printf (Config.PACKAGE_VALADOC_ICONDIR));
		}

		var devfile = FileStream.open (devpath, "w");
		_devhelpwriter = new Devhelp.MarkupWriter (devfile);

		_devhelpwriter.start_book (pkg_name+" Reference Manual",
								   "vala",
								   "index.htm",
								   pkg_name,
								   "",
								   "");

		GLib.FileStream file = GLib.FileStream.open (filepath, "w");
		writer = new Html.MarkupWriter (file);
		_renderer.set_writer (writer);
		write_file_header (Valadoc.Devhelp.Doclet.css_path, Valadoc.Devhelp.Doclet.js_path, pkg_name);
		write_package_content (package, package);
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

			_devhelpwriter.simple_tag ("keyword", {"type", typekeyword,
												   "name", node.get_full_name (),
												   "link", get_link (node, node.package)});
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
			write_file_header (css_path,
							   js_path,
							   node.get_full_name () + " &ndash; " + node.package.name);
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

	private void process_node (Api.Node node, bool accept_all_children) {
		string rpath = this.get_real_path (node);
		string path = this.get_path (node);

		GLib.FileStream file = GLib.FileStream.open (rpath, "w");
		writer = new Html.MarkupWriter (file);
		_renderer.set_writer (writer);
		write_file_header (css_path,
						   js_path,
						   node.get_full_name() + " &ndash; " + node.package.name);
		write_symbol_content (node);
		write_file_footer ();
		file = null;

		if (accept_all_children) {
			_devhelpwriter.start_sub (node.name, path);
			node.accept_all_children (this);
			_devhelpwriter.end_sub ();
		}
		this.nodes.add (node);
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
		process_node (item, true);
	}

	public override void visit_enum (Api.Enum item) {
		process_node (item, true);
	}

	public override void visit_property (Property item) {
		process_node (item, false);
	}

	public override void visit_constant (Constant item) {
		process_node (item, false);
	}

	public override void visit_field (Field item) {
		process_node (item, false);
	}

	public override void visit_error_code (ErrorCode item) {
		process_node (item, false);
	}

	public override void visit_enum_value (Api.EnumValue item) {
		process_node (item, false);
	}

	public override void visit_delegate (Delegate item) {
		process_node (item, false);
	}

	public override void visit_signal (Api.Signal item) {
		process_node (item, false);
	}

	public override void visit_method (Method item) {
		process_node (item, false);
	}
}


public Type register_plugin (Valadoc.ModuleLoader module_loader) {
	return typeof (Valadoc.Devhelp.Doclet);
}

