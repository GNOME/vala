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



public class Valadoc.HtmlDoclet : Valadoc.Html.BasicDoclet {
	private const string css_path_package = "style.css";
	private const string css_path_wiki = "../style.css";
	private const string css_path = "../style.css";


	private const string js_path_package = "scripts.js";
	private const string js_path_wiki = "../scripts.js";
	private const string js_path = "../scripts.js";

	construct {
		_renderer = new HtmlRenderer (this);
	}

	private string get_real_path ( Api.Node element ) {
		return GLib.Path.build_filename ( this.settings.path, element.package.name, element.get_full_name () + ".html" );
	}

	public override void process (Settings settings, Api.Tree tree) {
		base.process (settings, tree);

		DirUtils.create (this.settings.path, 0777);
		copy_directory (icons_dir, settings.path);

		write_wiki_pages (tree, css_path_wiki, js_path_wiki, Path.build_filename(settings.path, "content"));

		GLib.FileStream file = GLib.FileStream.open (GLib.Path.build_filename ( settings.path, "index.html" ), "w");
		writer = new Html.MarkupWriter (file);
		_renderer.set_writer (writer);
		write_file_header (this.css_path_package, this.js_path_package, settings.pkg_name);
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
		if (!package.is_browsable (settings)) {
			return ;
		}

		string pkg_name = package.name;
		string path = GLib.Path.build_filename ( this.settings.path, pkg_name );

		var rt = DirUtils.create (path, 0777);
		rt = DirUtils.create (GLib.Path.build_filename ( path, "img" ), 0777);

		GLib.FileStream file = GLib.FileStream.open (GLib.Path.build_filename ( path, "index.htm" ), "w");
		writer = new Html.MarkupWriter (file);
		_renderer.set_writer (writer);
		write_file_header (this.css_path, this.js_path, pkg_name);
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
			_renderer.set_writer (writer);
			write_file_header (this.css_path, this.js_path, ns.get_full_name ());
			write_navi_symbol (ns);
			write_namespace_content (ns, ns);
			write_file_footer ();
			file = null;
		}

		ns.accept_all_children (this);
	}

	private void process_node (Api.Node node, bool accept_all_children) {
		string rpath = this.get_real_path (node);

		GLib.FileStream file = GLib.FileStream.open (rpath, "w");
		writer = new Html.MarkupWriter (file);
		_renderer.set_writer (writer);
		write_file_header (css_path, js_path, node.get_full_name());
		if (is_internal_node (node)) {
			write_navi_symbol (node);
		} else {
			write_navi_leaf_symbol (node);
		}
		write_symbol_content (node);
		write_file_footer ();
		file = null;

		if (accept_all_children) {
			node.accept_all_children (this);
		}
	}

	public override void visit_interface (Interface item) {
		process_node (item, true);
	}

	public override void visit_class (Api.Class item) {
		process_node (item, true);
	}

	public override void visit_struct (Api.Struct item) {
		process_node (item, true);
	}

	public override void visit_error_domain (Api.ErrorDomain item) {
		process_node (item, true);
	}

	public override void visit_enum (Api.Enum item) {
		process_node (item, true);
	}

	public override void visit_property (Api.Property item) {
		process_node (item, false);
	}

	public override void visit_constant (Api.Constant item) {
		process_node (item, false);
	}

	public override void visit_field (Api.Field item) {
		process_node (item, false);
	}

	public override void visit_error_code (Api.ErrorCode item) {
		process_node (item, false);
	}

	public override void visit_enum_value (Api.EnumValue item) {
		process_node (item, false);
	}

	public override void visit_delegate (Api.Delegate item) {
		process_node (item, false);
	}

	public override void visit_signal (Api.Signal item) {
		process_node (item, false);
	}

	public override void visit_method (Api.Method item) {
		process_node (item, false);
	}
}

[ModuleInit]
public Type register_plugin (GLib.TypeModule module) {
	return typeof ( Valadoc.HtmlDoclet );
}

