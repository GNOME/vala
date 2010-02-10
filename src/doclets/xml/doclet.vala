/* doclet.vala
 *
 * Copyright (C) 2009 Florian Brosch
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
using Gee;


public class Valadoc.Xml.Doclet : Api.Visitor, Valadoc.Doclet {
	private Renderer _renderer = new Xml.Renderer ();
	private Xml.MarkupWriter _writer;
	private Settings settings;
	private Api.Tree tree;

	public void process (Settings settings, Api.Tree tree) {
		this.settings = settings;
		this.tree = tree;

		DirUtils.create (settings.path, 0777);
		tree.accept (this);
	}


	private void process_node (Api.Node node, string tagname) {
		_writer.start_tag (tagname, {"name", node.name});
		var doctree = node.documentation;

		if (doctree != null) {
			_writer.start_tag ("documentation");
			_renderer.set_filestream (_writer);
			_renderer.set_container (node);
			_renderer.render (doctree);
			_writer.end_tag ("documentation");
		}

		// avoid exceptions and signal childs
		if (node is Api.Class || node is Api.Struct || node is Api.Enum || node is Api.ErrorDomain || node is Api.Namespace) {
			node.accept_all_children (this);
		}

		_writer.end_tag (tagname);
	}

	public override void visit_tree (Api.Tree tree) {
		tree.accept_children (this);
	}

	public override void visit_package (Api.Package package) {
		string path = GLib.Path.build_filename (this.settings.path, package.name);
		DirUtils.create (path, 0777);

		GLib.FileStream file = GLib.FileStream.open (Path.build_filename (path, "documentation.xml"), "w");
		_writer = new Xml.MarkupWriter (file);

		_writer.start_tag ("package", {"name", package.name});
		package.accept_all_children (this);
		_writer.end_tag ("package");

		file = null;
	}

	public override void visit_namespace (Api.Namespace ns) {
		process_node (ns, "namespace");
	}

	public override void visit_interface (Api.Interface item) {
		process_node (item, "interface");
	}

	public override void visit_class (Api.Class item) {
		process_node (item, "class");
	}

	public override void visit_struct (Api.Struct item) {
		process_node (item, "struct");
	}

	public override void visit_error_domain (Api.ErrorDomain item) {
		process_node (item, "error-domain");
	}

	public override void visit_enum (Api.Enum item) {
		process_node (item, "enum");
	}

	public override void visit_property (Api.Property item) {
		process_node (item, "property");
	}

	public override void visit_constant (Api.Constant item) {
		process_node (item, "constant");
	}

	public override void visit_field (Api.Field item) {
		process_node (item, "field");
	}

	public override void visit_error_code (Api.ErrorCode item) {
		process_node (item, "error-code");
	}

	public override void visit_enum_value (Api.EnumValue item) {
		process_node (item, "enum-value");
	}

	public override void visit_delegate (Api.Delegate item) {
		process_node (item, "delegate");
	}

	public override void visit_signal (Api.Signal item) {
		process_node (item, "signal");
	}

	public override void visit_method (Api.Method item) {
		process_node (item, "method");
	}
}

[ModuleInit]
public Type register_plugin () {
	return typeof (Valadoc.Xml.Doclet);
}
