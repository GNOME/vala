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

public class Valadoc.Html.Doclet : Valadoc.Html.BasicDoclet {
	private const string css_path_package = "style.css";
	private const string css_path_wiki = "../style.css";
	private const string css_path = "../style.css";


	private const string js_path_package = "scripts.js";
	private const string js_path_wiki = "../scripts.js";
	private const string js_path = "../scripts.js";

	private class IndexLinkHelper : LinkHelper {
		protected override string? from_wiki_to_package (WikiPage from, Api.Package to) {
			if (from.name != "index.valadoc") {
				return base.from_wiki_to_package (from, to);;
			}

			return Path.build_filename (to.name, to.name + ".htm");
		}

		protected override string? from_wiki_to_wiki (WikiPage from, WikiPage to) {
			if (from.name != "index.valadoc") {
				return base.from_wiki_to_wiki (from, to);
			}

			return Path.build_filename (_settings.pkg_name, translate_wiki_name (to));
		}

		protected override string? from_wiki_to_node (WikiPage from, Api.Node to) {
			if (from.name != "index.valadoc") {
				return base.from_wiki_to_node (from, to);
			}

			if (enable_browsable_check && (!to.is_browsable(_settings) || !to.package.is_browsable (_settings))) {
				return null;
			}

			return Path.build_filename (to.package.name, to.get_full_name () + ".html");
		}
	}

	private string get_real_path ( Api.Node element ) {
		return GLib.Path.build_filename ( this.settings.path, element.package.name, element.get_full_name () + ".html" );
	}

	public override void process (Settings settings, Api.Tree tree, ErrorReporter reporter) {
		base.process (settings, tree, reporter);

		DirUtils.create_with_parents (this.settings.path, 0777);
		if (!copy_directory (Config.PACKAGE_VALADOC_ICONDIR, settings.path)) {
			reporter.simple_warning ("Html", "Couldn't copy resources from `%s'".printf (Config.PACKAGE_VALADOC_ICONDIR));
		}

		write_wiki_pages (tree, css_path_wiki, js_path_wiki, Path.build_filename(settings.path, settings.pkg_name));

		var tmp = _renderer;
		var link_helper = new IndexLinkHelper ();
		if (settings.pluginargs != null && ("--no-browsable-check" in settings.pluginargs)) {
			link_helper.enable_browsable_check = false;
		}
		_renderer = new HtmlRenderer (settings, link_helper, this.cssresolver);

		GLib.FileStream file = GLib.FileStream.open (GLib.Path.build_filename (settings.path, "index.html"), "w");
		writer = new Html.MarkupWriter (file);
		_renderer.set_writer (writer);
		write_file_header (Valadoc.Html.Doclet.css_path_package, Valadoc.Html.Doclet.js_path_package, settings.pkg_name);
		write_navi_packages (tree);
		write_package_index_content (tree);
		write_file_footer ();
		_renderer = tmp;
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

		if (package.is_package && FileUtils.test (path, FileTest.EXISTS)) {
			return;
		}

		var rt = DirUtils.create (path, 0777);
		rt = DirUtils.create (GLib.Path.build_filename (path, "img"), 0777);

		GLib.FileStream file = GLib.FileStream.open (GLib.Path.build_filename (path, "index.htm"), "w");
		writer = new Html.MarkupWriter (file);
		_renderer.set_writer (writer);
		write_file_header (Valadoc.Html.Doclet.css_path, Valadoc.Html.Doclet.js_path, pkg_name);
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
			write_file_header (Valadoc.Html.Doclet.css_path, Valadoc.Html.Doclet.js_path, ns.get_full_name () + " &ndash; " + ns.package.name);
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
		write_file_header (css_path, js_path, node.get_full_name() + " &ndash; " + node.package.name);
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


public Type register_plugin (Valadoc.ModuleLoader module_loader) {
	return typeof ( Valadoc.Html.Doclet );
}

