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

using Valadoc.Diagrams;
using Valadoc.Content;
using Valadoc.Html;
using Valadoc.Api;
using Gee;

namespace Valadoc.ValadocOrg {
	public string? get_html_link (Settings settings, Documentation element, Documentation? pos) {
		if (element is Api.Node) {
			return Path.build_filename("/"+((Api.Node)element).package.name, ((Api.Node)element).full_name () + ".html");
		}
		return null;
	}
}

public class Valadoc.ValadocOrg.Doclet : BasicDoclet {
	private WikiRenderer _wikirenderer;
	private FileStream file;
	private bool run;

	private void write_documentation (Api.Node element) {
		if(element.documentation == null) {
			return;
		}

		string path = Path.build_filename (this.settings.path, element.package.name, "documentation", element.full_name ());
		FileStream file = FileStream.open (path, "w");
		if (file == null) {
			this.run = false;
			return;
		}

		_wikirenderer.set_container (element);
		_wikirenderer.set_filestream (file);
		_wikirenderer.render (element.documentation);
	}

	public override void process (Settings settings, Api.Tree tree) {
		this.settings = settings;
		this.run = true;

		//writer

		_wikirenderer = new ValadocOrg.WikiRenderer ();
		_renderer = new HtmlRenderer (this);


		DirUtils.create (this.settings.path, 0777);
		Gee.Collection<Package> packages = tree.get_package_list ();
		foreach ( Package pkg in packages ) {
			pkg.accept (this);
		}
	}

	private string get_image_path (Api.Node element) {
		return Path.build_filename (this.settings.path, element.package.name, element.package.name, element.full_name () + ".png");
	}

	private void write_insert_into_valadoc_element_str (string name, string pkgname, string fullname) {
		string fullname2 = (pkgname == fullname)? pkgname : pkgname+"/"+fullname;
		this.file.printf ("INSERT INTO `ValadocApiElement` (`name`, `fullname`) VALUES ('%s', '%s');\n", name, fullname2);
	}

	private void write_insert_into_valadoc_element (Api.Node element) {
		string name = element.name;
		string fullname;

		if (name == null) {
			name = element.package.name;
			fullname = name;
		}
		else {
			fullname = element.full_name();
		}

		this.write_insert_into_valadoc_element_str(name, element.package.name, fullname);
	}

	private void write_insert_into_valadoc_package (Package pkg) {
		this.file.printf ("INSERT INTO `ValadocPackage` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE `fullname`='%s' LIMIT 1));\n", pkg.name);
	}




	private void write_insert_into_code_element (Api.Node element) {
		string fullname = element.full_name ();
		string pkgname = element.package.name;
		string parentnodepkgname;
		string parentnodename;

		Api.Item parent = element.parent;
		if (parent is Api.Node) {
			parentnodepkgname = ((Api.Node)parent).package.name;
			parentnodename = ((Api.Node)parent).full_name();
			if (parentnodename == null) {
				parentnodename = parentnodepkgname;
			}
		}
		else {
			parentnodepkgname = ((Package)parent).name;
			parentnodename = parentnodepkgname;
		}

		string parentnodetypepath = (parentnodepkgname == parentnodename)? parentnodepkgname : parentnodepkgname+"/"+parentnodename;
		string typepath = pkgname+"/"+fullname;
		this.file.printf ("INSERT INTO `ValadocCodeElement` (`id`, `parent`, `valaapi`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1), (SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1), '", typepath, parentnodetypepath);
		var writer = new MarkupWriter (file);
		writer.set_source_wrap (false);
		_renderer.set_writer (writer);
		_renderer.set_container (element);
		_renderer.render (element.signature);
		this.file.puts ("');\n");
	}

	public override void visit_package (Package pkg) {
		string path = Path.build_filename(this.settings.path, pkg.name);
		if (GLib.DirUtils.create (path, 0777) == -1) {
			this.run = false;
			return;
		}

		if (GLib.DirUtils.create (Path.build_filename(path, pkg.name), 0777) == -1) {
			this.run = false;
			return;
		}

		if (GLib.DirUtils.create (Path.build_filename(path, "documentation"), 0777) == -1) {
			this.run = false;
			return;
		}

		string fpath = Path.build_filename(path, "dump.sql");
		this.file = FileStream.open (fpath , "w");
		if (this.file == null) {
			this.run = false;
			return;
		}

		this.write_insert_into_valadoc_element_str (pkg.name, pkg.name, pkg.name);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_valadoc_package (pkg);
		if (this.run == false) {
			return;
		}

		pkg.accept_all_children (this);
	}

	public override void visit_namespace (Namespace ns) {
		if (ns.name != null) {
			this.write_insert_into_valadoc_element (ns);
			if (this.run == false) {
				return;
			}

			this.write_insert_into_code_element (ns);
			if (this.run == false) {
				return;
			}
		}

		ns.accept_all_children (this);

		this.file.printf ("INSERT INTO `ValadocNamespaces` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(ns));
		this.write_documentation (ns);
	}

	public override void visit_interface ( Interface iface ) {
		write_interface_diagram (iface, this.get_image_path (iface));

		this.write_insert_into_valadoc_element (iface);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (iface);
		if (this.run == false) {
			return;
		}

		iface.accept_all_children (this);

		this.file.printf ("INSERT INTO `ValadocInterfaces` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(iface));
		this.write_documentation (iface);
	}

	public override void visit_class ( Class cl ) {
		write_class_diagram (cl, this.get_image_path (cl));

		this.write_insert_into_valadoc_element (cl);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (cl);
		if (this.run == false) {
			return;
		}

		cl.accept_all_children (this);

		string modifier;
		if (cl.is_abstract) {
			modifier = "ABSTRACT";
		}
		else {
			modifier = "NORMAL";
		}
	
		this.file.printf ("INSERT INTO `ValadocClasses` (`id`, `modifier`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1),'%s');\n", this.get_type_path(cl), modifier);
		this.write_documentation (cl);
	}

	public override void visit_struct (Struct stru) {
		write_struct_diagram (stru, this.get_image_path (stru));

		this.write_insert_into_valadoc_element (stru);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (stru);
		if (this.run == false) {
			return;
		}

		stru.accept_all_children (this);

		this.file.printf ("INSERT INTO `ValadocStructs` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(stru));
		this.write_documentation (stru);
	}

	public override void visit_error_domain ( ErrorDomain errdom ) {
		this.write_insert_into_valadoc_element (errdom);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (errdom);
		if (this.run == false) {
			return;
		}

		errdom.accept_all_children (this);

		this.file.printf ("INSERT INTO `ValadocErrordomains` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(errdom));
		this.write_documentation (errdom);
	}

	public override void visit_enum ( Enum en ) {
		this.write_insert_into_valadoc_element (en);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (en);
		if (this.run == false) {
			return;
		}

		en.accept_all_children (this);

		this.file.printf ("INSERT INTO `ValadocEnum` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(en));
		this.write_documentation (en);
	}

	public override void visit_property ( Property prop ) {
		this.write_insert_into_valadoc_element (prop);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (prop);
		if (this.run == false) {
			return;
		}

		string modifier;
		if (prop.is_virtual) {
			modifier = "VIRTUAL";
		}
		else if (prop.is_abstract) {
			modifier = "ABSTRACT";
		}
		//else if (prop.is_static) {
		//	modifier = "STATIC";
		//}
		else {
			modifier = "NORMAL";
		}

		this.file.printf ("INSERT INTO `ValadocProperties` (`id`, `modifier`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1), '%s');\n", this.get_type_path(prop), modifier);
		this.write_documentation (prop);
	}

	public override void visit_constant (Constant constant) {
		this.write_insert_into_valadoc_element (constant);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (constant);
		if (this.run == false) {
			return;
		}

		this.file.printf ("INSERT INTO `ValadocConstants` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(constant));
		this.write_documentation (constant);
	}

	public override void visit_field (Field field) {
		this.write_insert_into_valadoc_element (field);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (field);
		if (this.run == false) {
			return;
		}

		string modifier;
		if (field.is_static) {
			modifier = "STATIC";
		}
		else {
			modifier = "NORMAL";
		}

		this.file.printf ("INSERT INTO `ValadocFields` (`id`, `modifier`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1), '%s');\n", this.get_type_path(field), modifier);
		this.write_documentation (field);
	}

	public override void visit_error_code ( ErrorCode errcode ) {
		this.write_insert_into_valadoc_element (errcode);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (errcode);
		if (this.run == false) {
			return;
		}

		this.file.printf ("INSERT INTO `ValadocErrorcodes` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n" , this.get_type_path(errcode));
		this.write_documentation (errcode);
	}

	public override void visit_enum_value (Api.EnumValue enval) {
		this.write_insert_into_valadoc_element (enval);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (enval);
		if (this.run == false) {
			return;
		}

		this.file.printf ("INSERT INTO `ValadocEnumvalues` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(enval));
		this.write_documentation (enval);
	}

	public override void visit_delegate ( Delegate del ) {
		this.write_insert_into_valadoc_element (del);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (del);
		if (this.run == false) {
			return;
		}

		string modifier;
		if (del.is_static) {
			modifier = "STATIC";
		}
		else {
			modifier = "NORMAL";
		}

		this.file.printf ("INSERT INTO `ValadocDelegates` (`id`, `modifier`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE  BINARY`fullname`='%s' LIMIT 1), '%s');\n", this.get_type_path(del), modifier);
		this.write_documentation (del);
	}

	public override void visit_signal (Api.Signal sig) {
		this.write_insert_into_valadoc_element (sig);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (sig);
		if (this.run == false) {
			return;
		}

		this.file.printf ("INSERT INTO `ValadocSignals` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(sig));
		this.write_documentation (sig);
	}

	public override void visit_method (Method m) {
		this.write_insert_into_valadoc_element (m);
		if (this.run == false) {
			return;
		}

		this.write_insert_into_code_element (m);
		if (this.run == false) {
			return;
		}


		if (m.is_constructor) {
			this.file.printf ("INSERT INTO `ValadocConstructors` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE `fullname`='%s' LIMIT 1));\n", this.get_type_path(m));
		}
		else {
			string modifier;
			if (m.is_abstract) {
				modifier = "ABSTRACT";
			}
			else if (m.is_static) {
				modifier = "STATIC";
			}
			else if (m.is_virtual) {
				modifier = "VIRTUAL";
			}
			else {
				modifier = "NORMAL";
			}

			this.file.printf("INSERT INTO `ValadocMethods` (`id`, `modifier`)VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1), '%s');\n", this.get_type_path(m), modifier);
		}
		this.write_documentation (m);
	}

	private string get_type_path (Api.Node element) {
		if(element.name == null) {
			return element.package.name;
		}

		return element.package.name+"/"+element.full_name();
	}
}



[ModuleInit]
public Type register_plugin ( ) {
	Valadoc.Html.get_html_link_imp = Valadoc.ValadocOrg.get_html_link;
	return typeof (Valadoc.ValadocOrg.Doclet);
}

