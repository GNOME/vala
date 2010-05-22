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



public class Valadoc.ValadocOrg.Doclet : Valadoc.Html.BasicDoclet {
	private ArrayList<Api.Node> nodes = new ArrayList<Api.Node> ();
	private string package_dir_name = ""; // remove

	construct {
		_renderer = new ValadocOrg.HtmlRenderer (this);
	}

	protected override string get_icon_directory () {
		return "/images";
	}

	protected override string get_img_path_html (Api.Node element, string type) {
		return Path.build_filename ("/doc", element.package.name,"img", element.get_full_name () + "." + type);
	}

	private string get_path (Api.Node element) {
		return element.get_full_name () + ".html";
	}

	private string get_real_path (Api.Node element, string file_extension) {
		return GLib.Path.build_filename (this.settings.path, this.package_dir_name, element.get_full_name () + file_extension);
	}

	public override void process (Settings settings, Api.Tree tree) {
		base.process (settings, tree);

		DirUtils.create (this.settings.path, 0777);

		write_wiki_pages (tree, "", "", Path.build_filename (this.settings.path, this.settings.pkg_name, "content"));
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
			write_symbol_content (node);
			file = null;


			// navigation:
			rpath = this.get_real_path (node, ".navi.tpl");
			file = GLib.FileStream.open (rpath, "w");
			writer = new Html.MarkupWriter (file, false);
			_renderer.set_writer (writer);
			if (is_internal_node (node)) {
				write_navi_symbol (node);
			} else {
				write_navi_leaf_symbol (node);
			}
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
		write_symbol_content (node);
		file = null;


		// navigation:
		rpath = this.get_real_path (node, ".navi.tpl");
		file = GLib.FileStream.open (rpath, "w");
		writer = new Html.MarkupWriter (file, false);
		_renderer.set_writer (writer);
		if (is_internal_node (node)) {
			write_navi_symbol (node);
		} else {
			write_navi_leaf_symbol (node);
		}
		file = null;


		node.accept_all_children (this);
	}

	protected override void write_wiki_page (WikiPage page, string contentp, string css_path, string js_path, string pkg_name) {
		GLib.FileStream file = GLib.FileStream.open (Path.build_filename(contentp, page.name.ndup(page.name.len()-7).replace ("/", ".")+"wiki.tpl"), "w");
		writer = new Html.MarkupWriter (file);
		_renderer.set_writer (writer);
		_renderer.set_container (page);
		_renderer.render (page.documentation);
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
public Type register_plugin (GLib.TypeModule module) {
	return typeof (Valadoc.ValadocOrg.Doclet);
}

