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
using Mysql;
using GLib;
using Gee;



public class Valadoc.HtmlDoclet : Valadoc.Doclet {
	private Settings settings;
	private FileStream file;
	private bool run;

	public override void initialisation (Settings settings, Tree tree) {
		this.settings = settings;
		this.run = true;

		DirUtils.create (this.settings.path, 0777);



		foreach (Package pkg in tree.get_package_list ()) {
			pkg.visit (this);

			if (this.run == false) {
				break;
			}
		}
	}

	// get_type_path()
	private void write_insert_into_valadoc_element_str (string name, string pkgname, string fullname) {
		string fullname2 = (pkgname == fullname)? pkgname : pkgname+"/"+fullname;
		this.file.printf ("INSERT INTO `ValadocApiElement` (`name`, `fullname`) VALUES ('%s', '%s');\n", name, fullname2);
	}

	// get_type_path()
	private void write_insert_into_valadoc_element (DocumentedElement element) {
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

	// get_type_path()
	private void write_insert_into_code_element_str (string fullname, string pkgname, string valaapi, string parentnodepkgname, string parentnodefullname) {
		string parentnodetypepath = (parentnodepkgname == parentnodefullname)? parentnodepkgname : parentnodepkgname+"/"+parentnodefullname;
		string typepath = pkgname+"/"+fullname;
		this.file.printf ("INSERT INTO `ValadocCodeElement` (`id`, `parent`, `valaapi`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1), (SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1), '%s');\n", typepath, parentnodetypepath, valaapi);
	}

	// get_type_path()
	private void write_insert_into_code_element (DocumentedElement element) {
		string api = "foo bar foobaro";
		string parentnodepkgname;
		string parentnodename;
		string typename;
		string cname;

		Basic parent = element.parent;
		if (parent is DocumentedElement) {
			parentnodepkgname = ((DocumentedElement)parent).package.name;
			parentnodename = ((DocumentedElement)parent).full_name();
			if (parentnodename == null) {
				parentnodename = parentnodepkgname;
			}
		}
		else {
			parentnodepkgname = ((Package)parent).name;
			parentnodename = parentnodepkgname;
		}

		this.write_insert_into_code_element_str(element.full_name(), element.package.name, api, parentnodepkgname, parentnodename);
	}


	public override void visit_package (Package pkg) {
		string path = Path.build_filename(this.settings.path, pkg.name);
		if (GLib.DirUtils.create (path, 0777) == -1) {
			this.run = false;
			return ;
		}

		path = Path.build_filename(path, "dump.sql");
		this.file = FileStream.open (path , "w");
		if (this.file == null) {
			this.run = false;
			return ;
		}

		this.write_insert_into_valadoc_element_str (pkg.name, pkg.name, pkg.name);
		if ( this.run == false ) {
			return ;
		}

		this.write_insert_into_valadoc_package (pkg);
		if ( this.run == false ) {
			return ;
		}

		foreach (Namespace ns in pkg.get_namespace_list()) {
			ns.visit(this);

			if (this.run == false) {
				return ;
			}
		}
	}

	public override void visit_namespace (Namespace ns) {
		if (ns.name != null) {
			this.write_insert_into_valadoc_element (ns);
			if (this.run == false) {
				return ;
			}

			this.write_insert_into_code_element (ns);
			if (this.run == false) {
				return ;
			}
		}

		foreach (Namespace sns in ns.get_namespace_list()) {
			sns.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Interface iface in ns.get_interface_list()) {
			iface.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Class cl in ns.get_class_list()) {
			cl.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Struct stru in ns.get_struct_list()) {
			stru.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Enum en in ns.get_enum_list()) {
			en.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (ErrorDomain err in ns.get_error_domain_list()) {
			err.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Delegate del in ns.get_delegate_list()) {
			del.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Method m in ns.get_method_list()) {
			m.visit(this, ns);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Field f in ns.get_field_list()) {
			f.visit(this, ns);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Constant c in ns.get_constant_list()) {
			c.visit(this, ns);

			if (this.run == false) {
				return ;
			}			
		}

		this.file.printf ("INSERT INTO `ValadocNamespaces` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(ns));
	}

	public override void visit_interface ( Interface iface ) {
		this.write_insert_into_valadoc_element (iface);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (iface);
		if (this.run == false) {
			return ;
		}

		foreach (Delegate del in iface.get_delegate_list()) {
			del.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Struct stru in iface.get_struct_list()) {
			stru.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Method m in iface.get_method_list()) {
			m.visit(this, iface);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Field f in iface.get_field_list()) {
			f.visit(this, iface);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Enum en in iface.get_enum_list()) {
			en.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Class cl in iface.get_class_list()) {
			cl.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Property prop in iface.get_property_list()) {
			prop.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Signal sig in iface.get_signal_list()) {
			sig.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		this.file.printf ("INSERT INTO `ValadocInterfaces` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(iface));
	}

	public override void visit_class ( Class cl ) {
		this.write_insert_into_valadoc_element (cl);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (cl);
		if (this.run == false) {
			return ;
		}

		foreach (Delegate del in cl.get_delegate_list()) {
			del.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Struct stru in cl.get_struct_list()) {
			stru.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Method m in cl.get_method_list()) {
			m.visit(this, cl);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Field f in cl.get_field_list()) {
			f.visit(this, cl);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Enum en in cl.get_enum_list()) {
			en.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Class scl in cl.get_class_list()) {
			scl.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Property prop in cl.get_property_list()) {
			prop.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Signal sig in cl.get_signal_list()) {
			sig.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Constant c in cl.get_constant_list()) {
			c.visit(this, cl);

			if (this.run == false) {
				return ;
			}			
		}

		string modifier;
		if (cl.is_abstract) {
			modifier = "ABSTRACT";
		}
		else {
			modifier = "NORMAL";
		}
	
		this.file.printf ("INSERT INTO `ValadocClasses` (`id`, `modifier`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1),'%s');\n", this.get_type_path(cl), modifier);
	}

	public override void visit_struct ( Struct stru ) {
		this.write_insert_into_valadoc_element (stru);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (stru);
		if (this.run == false) {
			return ;
		}

		foreach (Method m in stru.get_method_list()) {
			m.visit(this, stru);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Field f in stru.get_field_list()) {
			f.visit(this, stru);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (Constant c in stru.get_constant_list()) {
			c.visit(this, stru);

			if (this.run == false) {
				return ;
			}			
		}

		this.file.printf ("INSERT INTO `ValadocStructs` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(stru));
	}

	public override void visit_error_domain ( ErrorDomain errdom ) {
		this.write_insert_into_valadoc_element (errdom);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (errdom);
		if (this.run == false) {
			return ;
		}

		foreach (Method m in errdom.get_method_list()) {
			m.visit(this, errdom);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (ErrorCode errc in errdom.get_error_code_list()) {
			errc.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		this.file.printf ("INSERT INTO `ValadocErrordomains` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(errdom));
	}

	public override void visit_enum ( Enum en ) {
		this.write_insert_into_valadoc_element (en);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (en);
		if (this.run == false) {
			return ;
		}

		foreach (Method m in en.get_method_list()) {
			m.visit(this, en);

			if (this.run == false) {
				return ;
			}			
		}

		foreach (EnumValue enval in en.get_enum_values()) {
			enval.visit(this);

			if (this.run == false) {
				return ;
			}			
		}

		this.file.printf ("INSERT INTO `ValadocEnum` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(en));
	}

	public override void visit_property ( Property prop ) {
		this.write_insert_into_valadoc_element (prop);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (prop);
		if (this.run == false) {
			return ;
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
	}

	public override void visit_constant ( Constant constant, ConstantHandler parent ) {
		this.write_insert_into_valadoc_element (constant);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (constant);
		if (this.run == false) {
			return ;
		}

		this.file.printf ("INSERT INTO `ValadocConstants` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(constant));
	}

	public override void visit_field ( Field field, FieldHandler parent ) {
		this.write_insert_into_valadoc_element (field);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (field);
		if (this.run == false) {
			return ;
		}

		string modifier;
		if (field.is_static) {
			modifier = "STATIC";
		}
		else {
			modifier = "NORMAL";
		}

		this.file.printf ("INSERT INTO `ValadocFields` (`id`, `modifier`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1), '%s');\n", this.get_type_path(field), modifier);
	}

	public override void visit_error_code ( ErrorCode errcode ) {
		this.write_insert_into_valadoc_element (errcode);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (errcode);
		if (this.run == false) {
			return ;
		}

		this.file.printf ("INSERT INTO `ValadocErrorcodes` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n" , this.get_type_path(errcode));
	}

	public override void visit_enum_value ( EnumValue enval ) {
		this.write_insert_into_valadoc_element (enval);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (enval);
		if (this.run == false) {
			return ;
		}

		this.file.printf ("INSERT INTO `ValadocEnumvalues` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(enval));
	}

	public override void visit_delegate ( Delegate del ) {
		this.write_insert_into_valadoc_element (del);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (del);
		if (this.run == false) {
			return ;
		}

		string modifier;
		if (del.is_static) {
			modifier = "STATIC";
		}
		else {
			modifier = "NORMAL";
		}

		this.file.printf ("INSERT INTO `ValadocDelegates` (`id`, `modifier`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE  BINARY`fullname`='%s' LIMIT 1), '%s');\n", this.get_type_path(del), modifier);
	}

	public override void visit_signal ( Signal sig ) {
		this.write_insert_into_valadoc_element (sig);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (sig);
		if (this.run == false) {
			return ;
		}

		this.file.printf ("INSERT INTO `ValadocSignals` (`id`) VALUES ((SELECT `id` FROM `ValadocApiElement` WHERE BINARY `fullname`='%s' LIMIT 1));\n", this.get_type_path(sig));
	}

	public override void visit_method ( Method m, Valadoc.MethodHandler parent ) {
		this.write_insert_into_valadoc_element (m);
		if (this.run == false) {
			return ;
		}

		this.write_insert_into_code_element (m);
		if (this.run == false) {
			return ;
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
	}

	private string get_type_path (DocumentedElement element) {
		if(element.name == null) {
			return element.package.name;
		}

		return element.package.name+"/"+element.full_name();
	}
}



[ModuleInit]
public Type register_plugin ( ) {
	return typeof ( Valadoc.HtmlDoclet );
}

