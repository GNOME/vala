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


using GLib;


public abstract class Valadoc.Html.BasicDoclet : Valadoc.Doclet {
	protected Valadoc.Langlet langlet;
	protected Settings settings;

	protected string? get_link ( DocumentedElement element, DocumentedElement? pos ) {
		return get_html_link ( this.settings, element, pos );
	}

	protected void write_navi_entry_html_template ( GLib.FileStream file, string style, string content ) {
		file.printf ( "\t<li class=\"%s\">%s</li>\n", style, content );
	}

	protected void write_navi_entry_html_template_with_link ( GLib.FileStream file, string style, string link, string content ) {
		file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", style, css_navi_link, link, content );
	}

	protected void write_navi_entry ( GLib.FileStream file, DocumentedElement element, DocumentedElement? pos, string style, bool link, bool full_name = false ) {
		string name;

		if ( element is Class ) {
			if ( ((Class)element).is_abstract )
				name = "<i>" + element.name + "</i>";
			else
				name = element.name;
		}
		else if ( element is Package ) {
			name = element.package.name;
		}
		else if ( full_name == true && element is Namespace ) {
			string tmp = element.full_name();
			name = (tmp == null)? "Global Namespace" : tmp;
		}
		else {
			string tmp = element.name;
			name = (tmp == null)? "Global Namespace" : tmp;
		}

		if ( link == true )
			this.write_navi_entry_html_template_with_link ( file, style, this.get_link (element, pos), name );
		else
			this.write_navi_entry_html_template ( file, style, name );
	}

	protected void write_wiki_pages (Tree tree, string css_path_wiki, string contentp) {
		if ( tree.wikitree == null ) {
			return ;
		}

		if ( tree.wikitree == null ) {
			return ;
		}

		Gee.Collection<WikiPage> pages = tree.wikitree.get_pages();
		if ( pages.size == 0 ) {
			return ;
		}

		DirUtils.create (contentp, 0777);

		DirUtils.create (Path.build_filename (contentp, "img"), 0777);

		foreach ( WikiPage page in pages ) {
			if ( page.name != "index.valadoc" ) {
				GLib.FileStream file = GLib.FileStream.open ( Path.build_filename(contentp, page.name.ndup( page.name.len()-7).replace ("/", ".")+"html"), "w" );
				this.write_file_header ( file, css_path_wiki, this.settings.pkg_name );
				page.write ( file );
				this.write_file_footer ( file );
			}
		}
	}

	protected void write_navi_top_entry ( GLib.FileStream file, DocumentedElement element, DocumentedElement? mself ) {
		string name = (element.name == null)? "Global Namespace" : element.name;
		string style = null;

		if ( element is Namespace )
			style = css_navi_namespace;
		else if ( element is Enum )
			style = css_navi_enum;
		else if ( element is ErrorDomain )
			style = css_navi_error_domain;
		else if ( element is Struct )
			style = css_navi_struct;
		else if ( element is Class )
			style = ( ((Class)element).is_abstract )? css_navi_abstract_class : css_navi_class;
		else if ( element is Interface )
			style = css_navi_iface;
		else if ( element is Package ) {
			name = element.package.name;
			style = css_navi_package;
		}

		file.printf ( "<ul class=\"%s\">\n", css_navi );

		if ( element == mself || mself == null )
			this.write_navi_entry ( file, element, mself, style, false );
		else
			this.write_navi_entry ( file, element, mself, style, true );

		file.puts ( "</ul>\n" );
		file.printf ( "\n<hr class=\"%s\">\n", css_navi_hr );
	}

	protected void write_top_element_template ( GLib.FileStream file, string link ) {
		file.printf ( "<ul class=\"%s\">\n\t\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">Packages</a></li>\n</ul>\n<hr class=\"%s\">\n", css_navi, css_navi_package_index, css_navi_link, link, css_navi_hr );
	}

	protected void write_top_elements ( GLib.FileStream file, DocumentedElement element, DocumentedElement? mself ) {
		Gee.ArrayList<DocumentedElement> lst = new Gee.ArrayList<DocumentedElement> ();
		DocumentedElement pos = element;

		this.write_top_element_template ( file, "../index.html" );

		while ( pos != null ) {
			lst.add ( pos );
			pos = (DocumentedElement)pos.parent;
		}

		for ( int i = lst.size-1; i >= 0  ; i-- ) {
			DocumentedElement el = lst.get ( i );

			if ( el.name != null ) {
				this.write_navi_top_entry ( file, el, mself );
			}
		}
	}

	protected void fetch_subnamespace_names ( NamespaceHandler pos, Gee.ArrayList<Namespace> lst ) {
		Gee.ReadOnlyCollection<Namespace> nspaces = pos.get_namespace_list ();

		foreach ( Namespace ns in nspaces ) {
			lst.add ( ns );
			this.fetch_subnamespace_names ( ns, lst );
		}
	}

	protected void write_navi_file ( GLib.FileStream file, Package efile, DocumentedElement? pos ) {
		Gee.ArrayList<Namespace> ns_list = new Gee.ArrayList<Namespace> ();
		this.fetch_subnamespace_names (efile, ns_list );


		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );


		if ( pos == null )
			this.write_top_elements ( file, efile, null );
		else if ( pos == efile )
			this.write_top_elements ( file, efile, efile );
		else
			this.write_top_elements ( file, (DocumentedElement)pos.parent.parent, pos );

		file.printf ( "\t\t\t\t<ul class=\"%s\">\n", css_navi );


		Namespace globals = null;

		foreach ( Namespace ns in ns_list ) {
			if ( ns.name == null )
				globals = ns;
			else
				this.write_navi_entry ( file, ns, pos, css_navi_namespace, true, true );
		}

		if ( globals != null ) {
			this.write_navi_child_namespaces_inline_withouth_block ( file, globals, pos );
		}

		file.puts ( "\t\t\t\t</ul>\n" );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_child_namespaces_inline_withouth_block ( GLib.FileStream file, Namespace ns, DocumentedElement? mself ) {
		this.write_navi_child_namespaces_without_childs ( file, ns, mself );
		this.write_navi_child_classes_without_childs ( file, ns, mself );
		this.write_navi_child_interfaces_without_childs ( file, ns, mself );
		this.write_navi_child_structs_without_childs ( file, ns, mself );
		this.write_navi_child_enums_without_childs ( file, ns, mself );
		this.write_navi_child_error_domains_without_childs ( file, ns, mself );
		this.write_navi_child_delegates ( file, ns, mself );
		this.write_navi_child_static_methods ( file, ns, mself );
		this.write_navi_child_methods ( file, ns, mself );
		this.write_navi_child_fields ( file, ns, mself );
		this.write_navi_child_constants ( file, ns, mself );
	}

	protected void write_navi_child_namespaces_inline ( GLib.FileStream file, Namespace ns, DocumentedElement? mself ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );

		if ( ns.name == null ) {
			this.write_navi_child_namespaces_without_childs ( file, (Package)ns.parent, ns );
		}

		this.write_navi_child_namespaces_inline_withouth_block ( file, ns, mself );

		file.puts ( "</ul>\n" );
	}

	protected void write_navi_child_namespaces ( GLib.FileStream file, Namespace ns, DocumentedElement? mself ) {
		this.write_top_elements ( file, ns, mself );
		this.write_navi_child_namespaces_inline ( file, ns, mself );
	}

	protected void write_navi_struct_inline ( GLib.FileStream file, Struct stru, DocumentedElement? mself ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );
		this.write_navi_child_construction_methods ( file, stru, mself );
		this.write_navi_child_static_methods ( file, stru, mself );
		this.write_navi_child_methods ( file, stru, mself );
		this.write_navi_child_fields ( file, stru, mself );
		this.write_navi_child_constants ( file, stru, mself );
		file.puts ( "</ul>\n" );
	}

	protected void write_navi_struct ( GLib.FileStream file, Struct stru, DocumentedElement? mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, stru, mself );
		this.write_navi_struct_inline ( file, stru, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_interface_inline ( GLib.FileStream file, Interface iface, DocumentedElement? mself ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );
		this.write_navi_child_static_methods ( file, iface, mself );
		this.write_navi_child_delegates ( file, iface, mself );
		this.write_navi_child_methods ( file, iface, mself );
		this.write_navi_child_signals ( file, iface, mself );
		this.write_navi_child_properties ( file, iface, mself );
		this.write_navi_child_fields ( file, iface, mself );
		file.puts ( "</ul>\n" );
	}

	protected void write_navi_interface ( GLib.FileStream file, Interface iface, DocumentedElement? mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, iface, mself );
		this.write_navi_interface_inline ( file, iface, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_enum_inline ( GLib.FileStream file, Enum en, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<EnumValue> enum_values = en.get_enum_values ( );
		file.printf ( "<ul class=\"%s\">\n", css_navi );

		foreach ( EnumValue env in enum_values ) {
			this.write_navi_entry ( file, env, en, css_navi_enval, true );
		}

		this.write_navi_child_static_methods ( file, en, mself );
		this.write_navi_child_methods ( file, en, mself );
		file.puts ( "</ul>\n" );
	}

	protected void write_navi_enum ( GLib.FileStream file, Enum en, DocumentedElement? mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, en, mself );
		this.write_navi_enum_inline ( file, en, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_error_domain_inline ( GLib.FileStream file, ErrorDomain errdom, DocumentedElement? mself = null ) {
		Gee.ReadOnlyCollection<ErrorCode> error_codes = errdom.get_error_code_list ( );
		file.printf ( "<ul class=\"%s\">\n", css_navi );

		foreach ( ErrorCode ec in error_codes ) {
			this.write_navi_entry ( file, ec, errdom, css_navi_errdomcode, true );
		}

		this.write_navi_child_static_methods ( file, errdom, mself );
		this.write_navi_child_methods ( file, errdom, mself );
		file.puts ( "</ul>\n" );
	}

	protected void write_navi_namespace ( GLib.FileStream file, Namespace ns ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, ns, ns );
		this.write_navi_child_namespaces_inline ( file, ns, ns );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_error_domain ( GLib.FileStream file, ErrorDomain errdom, DocumentedElement? mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, errdom, mself );
		this.write_navi_error_domain_inline ( file, errdom, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_class_inline ( GLib.FileStream file, Class cl, DocumentedElement? mself ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );
		this.write_navi_child_construction_methods ( file, cl, mself );
		this.write_navi_child_static_methods ( file, cl, mself );
		this.write_navi_child_classes_without_childs ( file, cl, mself );
		this.write_navi_child_structs_without_childs ( file, cl, mself );
		this.write_navi_child_enums_without_childs ( file, cl, mself );
		this.write_navi_child_delegates ( file, cl, mself );
		this.write_navi_child_methods ( file, cl, mself );
		this.write_navi_child_signals ( file, cl, mself );
		this.write_navi_child_properties ( file, cl, mself );
		this.write_navi_child_fields ( file, cl, mself );
		this.write_navi_child_constants ( file, cl, mself );
		file.puts ( "</ul>\n" );
	}

	protected void write_navi_class ( GLib.FileStream file, Class cl, DocumentedElement? mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, cl, mself );
		this.write_navi_class_inline ( file, cl, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_method ( GLib.FileStream file, Method m ) {
		DocumentedElement parent = (DocumentedElement)m.parent;

		if ( parent.name == null ) {
			this.write_navi_file ( file, (Package)parent.parent, m );
		}
		else {
			file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );

			this.write_top_elements ( file, parent, m );

			if ( parent is Class )
				this.write_navi_class_inline ( file, (Class)parent, m );
			else if ( m.parent is Interface )
				this.write_navi_interface_inline ( file, (Interface)parent, m );
			else if ( m.parent is Struct )
				this.write_navi_struct_inline ( file, (Struct)parent, m );
			else if ( m.parent is Enum )
				this.write_navi_enum_inline ( file, (Enum)parent, m );
			else if ( m.parent is ErrorDomain )
				this.write_navi_error_domain_inline ( file, (ErrorDomain)parent, m );
			else if ( m.parent is Namespace )
				this.write_navi_child_namespaces_inline ( file, (Namespace)parent, m );

			file.puts ( "\t\t\t</div>\n" );
		}
	}

	protected void write_navi_property ( GLib.FileStream file, Property prop ) {
		DocumentedElement parent = (DocumentedElement)prop.parent;

		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_top_elements ( file, parent, prop );

		if ( parent is Class )
			this.write_navi_class_inline ( file, (Class)parent, prop );
		else if ( parent is Interface )
			this.write_navi_interface_inline ( file, (Interface)parent, prop );

		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_signal ( GLib.FileStream file, Signal sig ) {
		DocumentedElement parent = (DocumentedElement)sig.parent;

		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );

		this.write_top_elements ( file, parent, sig );

		if ( parent is Class )
			this.write_navi_class_inline ( file, (Class)parent, sig );
		else if ( parent is Interface )
			this.write_navi_interface_inline ( file, (Interface)parent, sig );

		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_navi_constant ( GLib.FileStream file, Constant c ) {
		DocumentedElement parent = (DocumentedElement)c.parent;

		if ( parent.name == null ) {
			this.write_navi_file ( file, (Package)parent.parent, c );
		}
		else {
			file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
			this.write_top_elements ( file, parent, c );

			if ( parent is Class )
				this.write_navi_class_inline ( file, (Class)parent, c );
			else  if ( parent is Struct )
				this.write_navi_struct_inline ( file, (Struct)parent, c );
			else  if ( parent is Namespace )
				this.write_navi_child_namespaces_inline ( file, (Namespace)parent, c );
			else if ( parent is Interface )
				this.write_navi_interface_inline ( file, (Interface)parent, c );

			file.puts ( "\t\t\t</div>\n" );
		}
	}

	protected void write_navi_field ( GLib.FileStream file, Field f ) {
		DocumentedElement parent = (DocumentedElement)f.parent;

		if ( parent.name == null ) {
			this.write_navi_file ( file, (Package)parent.parent, f );
		}
		else {
			file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
			this.write_top_elements ( file, parent, f );

			if ( parent is Class )
				this.write_navi_class_inline ( file, (Class)parent, f );
			else if ( parent is Struct )
				this.write_navi_struct_inline ( file, (Struct)parent, f );
			else if ( parent is Namespace )
				this.write_navi_child_namespaces_inline ( file, (Namespace)parent, f );
			else if ( parent is Interface )
				this.write_navi_interface_inline ( file, (Interface)parent, f );

			file.puts ( "\t\t\t</div>\n" );
		}
	}

	protected void write_navi_delegate ( GLib.FileStream file, Delegate del ) {
		DocumentedElement parent = (DocumentedElement)del.parent;

		if ( parent.name == null ) {
			this.write_navi_file ( file, (Package)parent.parent, del );
		}
		else {
			file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
			this.write_top_elements ( file, parent, del );

			if ( parent is Namespace )
				this.write_navi_child_namespaces_inline ( file, (Namespace)parent, del );
			else if ( parent is Class )
				this.write_navi_class_inline ( file, (Class)parent, del );
			else if ( parent is Interface )
				this.write_navi_interface_inline ( file, (Interface)parent, del );

			file.puts ( "\t\t\t</div>\n" );
		}
	}

	protected void write_navi_child_methods_collection ( GLib.FileStream file, Gee.Collection<Method> methods, DocumentedElement? mself ) {
		foreach ( Method m in methods ) {
			if ( !m.is_static ) {
				string css;
				if ( m.is_virtual || m.is_override )
					css = css_navi_virtual_method;
				else if ( m.is_abstract )
					css = css_navi_abstract_method;
				else
					css = css_navi_method;

				if ( m == mself )
					this.write_navi_entry ( file, m, mself, css, false );
				else
					this.write_navi_entry ( file, m, mself, css, true );
			}
		}
	}

	protected void write_navi_child_construction_methods_collection ( GLib.FileStream file, Gee.Collection<Method> methods, DocumentedElement? mself ) {
		foreach ( Method m in methods ) {
			if ( m == mself )
				this.write_navi_entry ( file, m, mself, css_navi_construction_method, false );
			else
				this.write_navi_entry ( file, m, mself, css_navi_construction_method, true );
		}
	}

	protected void write_navi_child_static_methods_collection ( GLib.FileStream file, Gee.Collection<Method> methods, DocumentedElement? mself ) {
		foreach ( Method m in methods ) {
			if ( m.is_static ) {
				if ( m == mself )
					this.write_navi_entry ( file, m, mself, css_navi_static_method, false );
				else
					this.write_navi_entry ( file, m, mself, css_navi_static_method, true );
			}
		}
	}

	protected void write_navi_child_methods ( GLib.FileStream file, MethodHandler mh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Method> methods = mh.get_method_list ( );
		this.write_navi_child_methods_collection ( file, methods, mself );
	}

	protected void write_navi_child_static_methods ( GLib.FileStream file, MethodHandler mh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Method> methods = mh.get_method_list ( );
		this.write_navi_child_static_methods_collection ( file, methods, mself );
	}

	protected void write_navi_child_classes_without_childs_collection ( GLib.FileStream file, Gee.Collection<Class> classes, DocumentedElement? mself ) {
		foreach ( Class cl in classes ) {
			if ( cl == mself )
				this.write_navi_entry ( file, cl, mself, (cl.is_abstract)? css_navi_abstract_class : css_navi_class, false );
			else
				this.write_navi_entry ( file, cl, mself, (cl.is_abstract)? css_navi_abstract_class : css_navi_class, true );
		}
	}

	protected void write_navi_child_classes_without_childs ( GLib.FileStream file, ClassHandler clh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Class> classes = clh.get_class_list ( );
		this.write_navi_child_classes_without_childs_collection ( file, classes, mself );
	}

	protected void write_navi_child_construction_methods ( GLib.FileStream file, ConstructionMethodHandler cmh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Method> methods = cmh.get_construction_method_list ( );
		this.write_navi_child_construction_methods_collection ( file, methods, mself );
	}

	protected void write_navi_child_signals ( GLib.FileStream file, SignalHandler sh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Signal> signals = sh.get_signal_list ( );

		foreach ( Signal sig in signals ) {
			if ( sig == mself )
				this.write_navi_entry ( file, sig, mself, css_navi_sig, false );
			else
				this.write_navi_entry ( file, sig, mself, css_navi_sig, true );
		}
	}

	protected void write_navi_child_properties ( GLib.FileStream file, PropertyHandler ph, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Property> properties = ph.get_property_list ( );

		foreach ( Property p in properties ) {
			string css;
			if ( p.is_virtual )
				css = css_navi_virtual_prop;
			else if ( p.is_abstract )
				css = css_navi_abstract_prop;
			else
				css = css_navi_prop;

			if ( p == mself )
				this.write_navi_entry ( file, p, mself, css, false );
			else
				this.write_navi_entry ( file, p, mself, css, true );
		}
	}

	protected void write_navi_child_fields_collection ( GLib.FileStream file, Gee.Collection<Field> fields, DocumentedElement? mself ) {
		foreach ( Field f in fields ) {
			if ( f == mself )
				this.write_navi_entry ( file, f, mself, css_navi_field, false );
			else
				this.write_navi_entry ( file, f, mself, css_navi_field, true );
		}
	}

	protected void write_navi_child_fields ( GLib.FileStream file, FieldHandler fh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Field> fields = fh.get_field_list ( );
		this.write_navi_child_fields_collection ( file, fields, mself );
	}

	protected void write_navi_child_constants_collection ( GLib.FileStream file, Gee.Collection<Constant> constants, DocumentedElement? mself ) {
		foreach ( Constant c in constants ) {
			if ( c == mself )
				this.write_navi_entry ( file, c, mself, css_navi_constant, false );
			else
				this.write_navi_entry ( file, c, mself, css_navi_constant, true );
		}
	}

	protected void write_navi_child_constants ( GLib.FileStream file, ConstantHandler ch, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Constant> constants = ch.get_constant_list ( );
		this.write_navi_child_constants_collection ( file, constants, mself );
	}

	protected void write_navi_child_structs_without_childs_collection ( GLib.FileStream file, Gee.Collection<Struct> structs, DocumentedElement? mself ) {
		foreach ( Struct stru in structs ) {
			if ( stru == mself )
				this.write_navi_entry ( file, stru, mself, css_navi_struct, false );
			else
				this.write_navi_entry ( file, stru, mself, css_navi_struct, true );
		}
	}

	protected void write_navi_child_structs_without_childs ( GLib.FileStream file, StructHandler strh, DocumentedElement? mself ) {
		Gee.Collection<Struct> structs = strh.get_struct_list ( );
		this.write_navi_child_structs_without_childs_collection ( file, structs, mself );
	}

	protected void write_navi_child_delegates_collection ( GLib.FileStream file, Gee.Collection<Delegate> delegates, DocumentedElement? mself ) {
		foreach ( Delegate del in delegates ) {
			if ( del == mself )
				this.write_navi_entry ( file, del, mself, css_navi_del, false );
			else
				this.write_navi_entry ( file, del, mself, css_navi_del, true );
		}
	}

	protected void write_navi_child_delegates ( GLib.FileStream file, DelegateHandler delh, DocumentedElement? mself ) {
		Gee.Collection<Delegate> delegates = delh.get_delegate_list ( );
		this.write_navi_child_delegates_collection ( file, delegates, mself );
	}

	protected void write_navi_child_interfaces_without_childs_collection ( GLib.FileStream file, Gee.Collection<Interface> interfaces, DocumentedElement? mself ) {
		foreach ( Interface iface in interfaces ) {
			if ( iface == mself )
				this.write_navi_entry ( file, iface, mself, css_navi_iface, false );
			else
				this.write_navi_entry ( file, iface, mself, css_navi_iface, true );
		}
	}

	protected void write_navi_child_interfaces_without_childs ( GLib.FileStream file, Namespace ifh, DocumentedElement? mself ) {
		Gee.Collection<Interface> interfaces = ifh.get_interface_list ( );
		this.write_navi_child_interfaces_without_childs_collection ( file, interfaces, mself );
	}

	protected void write_navi_child_enums_without_childs_collection ( GLib.FileStream file, Gee.Collection<Enum> enums, DocumentedElement? mself ) {
		foreach ( Enum en in enums ) {
			if ( en == mself )
				this.write_navi_entry ( file, en, mself, css_navi_enum, false );
			else
				this.write_navi_entry ( file, en, mself, css_navi_enum, true );
		}
	}

	protected void write_navi_child_enums_without_childs ( GLib.FileStream file, EnumHandler eh, DocumentedElement? mself ) {
		Gee.Collection<Enum> enums = eh.get_enum_list ( );
		this.write_navi_child_enums_without_childs_collection ( file, enums, mself );
	}

	protected void write_navi_child_error_domains_without_childs_collection ( GLib.FileStream file, Gee.Collection<ErrorDomain> errordomains, DocumentedElement? mself ) {
		foreach ( ErrorDomain errdom in errordomains ) {
			if ( errdom == mself )
				this.write_navi_entry ( file, errdom, mself, css_navi_error_domain, false );
			else
				this.write_navi_entry ( file, errdom, mself, css_navi_error_domain, true );
		}
	}

	protected void write_navi_child_error_domains_without_childs ( GLib.FileStream file, Namespace errdomh, DocumentedElement? mself ) {
		Gee.Collection<ErrorDomain> errordomains = errdomh.get_error_domain_list ( );
		this.write_navi_child_error_domains_without_childs_collection ( file, errordomains, mself );
	}

	protected void write_navi_child_namespaces_without_childs ( GLib.FileStream file, NamespaceHandler nsh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Namespace> namespaces = nsh.get_namespace_list ( );
		foreach ( Namespace ns in namespaces ) {
			if ( ns.name == null )
				continue ;

			if ( ns == mself )
				this.write_navi_entry ( file, ns, mself, css_navi_namespace, false );
			else
				this.write_navi_entry ( file, ns, mself, css_navi_namespace, true );
		}
	}

	protected void write_package_note ( GLib.FileStream file, DocumentedElement element ) {
		string package = element.package.name;
		if ( package == null )
			return ;

		file.printf ( "\n\n<br />\n<b>Package:</b> %s\n\n", package );
	}

	protected void write_namespace_note ( GLib.FileStream file, DocumentedElement element ) {
		Namespace? ns = element.nspace;
		if ( ns == null )
			return ;

		if ( ns.name == null )
			return ;

		file.printf ( "\n\n<br />\n<b>Namespace:</b> %s\n\n", ns.full_name() );
	}

	private void write_brief_description ( GLib.FileStream file, DocumentedElement element , DocumentedElement? pos ) {
		DocumentationTree? doctree = element.documentation;
		if ( doctree == null )
			return ;

		Gee.ReadOnlyCollection<DocElement> brief = doctree.get_brief ( );
		if ( brief.size > 0 ) {
			file.printf ( " <span class=\"%s\">- ", css_inline_navigation_brief_description );
			int _max = brief.size;
			int _index = 0;

			foreach ( DocElement element2 in brief ) {
				if ( element2 is InlineTaglet )
					file.puts ( ((InlineTaglet)element2).to_string() );
				else
					element2.write ( file, _max, _index );

				_index++;
			}

			file.printf ( " </span>\n" );
		}
	}

	private void write_documentation ( GLib.FileStream file, DocumentedElement element , DocumentedElement? pos ) {
		DocumentationTree? doctree = element.documentation;
		if ( doctree == null )
			return ;

		Gee.ReadOnlyCollection<DocElement> brief = doctree.get_brief ( );
		if ( brief.size > 0 ) {
			doctree.write_brief ( file );
		}
		file.printf ( "\n<br />\n" );
		file.printf ( "\n<br />\n" );
		doctree.write_content ( file );
	}

	public void write_navi_packages_inline ( GLib.FileStream file, Tree tree ) {
		file.printf ( "<ul class=\"%s\">\n", css_navi );
		foreach ( Package pkg in tree.get_package_list() ) {
			if ( pkg.is_visitor_accessible ( ) ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>\n", get_html_inline_navigation_link_css_class (pkg), css_navi_link, this.get_link(pkg, null), pkg.name );
				// brief description
				file.puts ( "</li>\n" );
			}
			else {
				file.printf ( "\t<li class=\"%s\">%s</a></li>\n", get_html_inline_navigation_link_css_class (pkg), pkg.name );
			}
		}
		file.puts ( "</li>\n" );
	}

	public void write_navi_packages ( GLib.FileStream file, Tree tree ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_navigation );
		this.write_navi_packages_inline ( file, tree );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_packages_content ( GLib.FileStream file, Tree tree ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">Packages:</h1>\n", css_title );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );

		WikiPage? wikiindex = (tree.wikitree == null)? null : tree.wikitree.search ( "index.valadoc" );
		if ( wikiindex != null ) {
			wikiindex.write ( file );
		}

		file.printf ( "\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<h3 class=\"%s\">Packages:</h2>\n", css_title );
		this.write_navi_packages_inline ( file, tree );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_method_content ( GLib.FileStream file, Method m , Valadoc.MethodHandler parent ) {
		string full_name = m.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );

		this.langlet.write_method ( file, m, parent );

		file.printf ( "\n\t\t\t\t</div>\n" );

		this.write_documentation ( file, m, m );

		if ( m.parent is Namespace ) {
			file.puts ( "\t\t\t\t<br />\n" );
			this.write_namespace_note ( file, m );
			this.write_package_note ( file, m );
		}

		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_child_error_values ( GLib.FileStream file, ErrorDomain errdom ) {
		Gee.ReadOnlyCollection<ErrorCode> error_codes = errdom.get_error_code_list ();
		if ( error_codes.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Error Codes:</h3>\n", css_title );
			file.printf ( "<table class=\"%s\">\n", css_errordomain_table );
			foreach ( ErrorCode errcode in error_codes ) {
				file.puts ( "<tr>\n" );
				file.printf ( "\t<td class=\"%s\" id=\"%s\">%s</td>\n", css_errordomain_table_name, errcode.name, errcode.name );
				file.printf ( "\t<td class=\"%s\">\n", css_errordomain_table_text );

				this.write_documentation ( file, errcode, errcode );

				file.puts ( "\t</td>\n" );
				file.puts ( "</tr>\n" );
			}
			file.puts ( "</table>\n" );
		}
	}

	public void write_signal_content ( GLib.FileStream file, Signal sig ) {
		string full_name = sig.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_signal ( sig, file );
		file.printf ( "\n\t\t\t\t</div>\n" );
		this.write_documentation ( file, sig, sig );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_delegate_content ( GLib.FileStream file, Delegate del ) {
		string full_name = del.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_delegate ( del, file );
		file.printf ( "\n\t\t\t\t</div>\n" );

		this.write_documentation ( file, del, del );

		if ( del.parent is Namespace ) {
			file.puts ( "\t\t\t\t<br />\n" );
			this.write_namespace_note ( file, del );
			this.write_package_note ( file, del );
		}

		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_field_content ( GLib.FileStream file, Field field, FieldHandler parent ) {
		string full_name = field.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_field ( field, parent, file );
		file.printf ( "\n\t\t\t\t</div>\n" );

		this.write_documentation ( file, field, field );

		if ( field.parent is Namespace ) {
			file.puts ( "\t\t\t\t<br />\n" );
			this.write_namespace_note ( file, field );
			this.write_package_note ( file, field );
		}

		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_constant_content ( GLib.FileStream file, Constant constant, ConstantHandler parent ) {
		string full_name = constant.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_constant ( constant, parent, file );
		file.printf ( "\n\t\t\t\t</div>\n" );

		this.write_documentation ( file, constant, constant );

		if ( constant.parent is Namespace ) {
			file.puts ( "\t\t\t\t<br />\n" );
			this.write_namespace_note ( file, constant );
			this.write_package_note ( file, constant );
		}

		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_property_content ( GLib.FileStream file, Property prop ) {
		string full_name = prop.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_property ( prop, file );
		file.printf ( "\n\t\t\t\t</div>\n" );
		this.write_documentation ( file, prop, prop );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_enum_content ( GLib.FileStream file, Enum en, DocumentedElement? mself ) {
		string full_name = en.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );

		this.write_documentation ( file, en, en );

		if ( en.parent is Namespace ) {
			file.puts ( "\t\t\t\t<br />\n" );
			this.write_namespace_note ( file, en );
			this.write_package_note ( file, en );
		}

		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_enum_values ( file, en );
		this.write_child_static_methods ( file, en, mself );
		this.write_child_methods ( file, en, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	private void write_child_enum_values ( GLib.FileStream file, Enum en ) {
		Gee.ReadOnlyCollection<EnumValue> enum_values = en.get_enum_values ();
		if ( enum_values.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Enum Values:</h3>\n", css_title );
			file.printf ( "<table class=\"%s\">\n", css_enum_table );
			foreach ( EnumValue enval in enum_values ) {
				file.puts ( "<tr>\n" );
				file.printf ( "\t<td class=\"%s\" id=\"%s\">%s</td>\n", css_enum_table_name, enval.name, enval.name );
				file.printf ( "\t<td class=\"%s\">\n", css_enum_table_text );

				this.write_documentation ( file, enval, en );

				file.puts ( "\t</td>\n" );
				file.puts ( "</tr>\n" );
			}
			file.puts ( "</table>\n" );
		}
	}

	protected void write_child_namespaces ( GLib.FileStream file, NamespaceHandler nh, DocumentedElement? mself ) {
		Gee.ArrayList<Namespace> nsl = new Gee.ArrayList<Namespace> ();
		this.fetch_subnamespace_names ( nh, nsl );

		if ( nsl.size == 0 )
			return ;

		if ( nsl.size == 1 ) {
			if ( nsl.get(0).name == null )
				return ;
		}

		bool with_childs = (mself == null)? false : mself is Package;

		file.printf ("<h3 class=\"%s\">Namespaces:</h3>\n", css_title);
		file.printf ("<ul class=\"%s\">\n", css_inline_navigation);
		foreach (Namespace ns in nsl) {
			if (ns.name != null) {
				file.printf ("\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>\n", css_inline_navigation_namespace, css_navi_link, this.get_link(ns, mself), ns.name);
				this.write_brief_description (file, ns , mself);
				file.printf ("</li>\n");
				if (with_childs == true) {
					this.write_child_classes (file, ns, mself);
					this.write_child_interfaces (file, ns, mself);
					this.write_child_structs (file, ns, mself);
					this.write_child_enums (file, ns, mself);
					this.write_child_errordomains (file, ns, mself);
					this.write_child_delegates (file, ns, mself);
					this.write_child_methods (file, ns, mself);
					this.write_child_fields (file, ns, mself);
					this.write_child_constants (file, ns, mself);
				}
			}
		}
		file.puts ( "</ul>\n" );
	}

	protected void write_child_methods ( GLib.FileStream file, MethodHandler mh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Method> methods = mh.get_method_list ();
		Gee.ArrayList<Method> imethods = new Gee.ArrayList<Method> ( );
		foreach ( Method m in methods ) {
			if ( !m.is_static )
				imethods.add ( m );
		}

		if ( imethods.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Methods:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Method m in imethods ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>", get_html_inline_navigation_link_css_class (m), css_navi_link, this.get_link(m, mself), m.name );
				this.write_brief_description ( file, m , mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_child_dependencies ( GLib.FileStream file, Package package, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Package> deps = package.get_full_dependency_list ();
		if ( deps.size == 0 )
			return ;

		file.printf ( "<h2 class=\"%s\">Dependencies:</h2>\n", css_title );
		file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
		foreach ( Package p in deps ) {
			string link = this.get_link(p, mself);
			if ( link == null )
				file.printf ( "\t<li class=\"%s\">%s</li>\n", css_inline_navigation_package, p.name );
			else
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a></li>\n", css_inline_navigation_package, css_navi_link, link, p.name );
		}
		file.puts ( "</ul>\n" );
	}

	protected void write_child_static_methods ( GLib.FileStream file, MethodHandler mh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Method> methods = mh.get_method_list ();

		Gee.ArrayList<Method> static_methods = new Gee.ArrayList<Method> ( );
		foreach ( Method m in methods ) {
			if ( m.is_static )
				static_methods.add ( m );
		}

		if ( static_methods.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Static Methods:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Method m in static_methods ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>", get_html_inline_navigation_link_css_class (m), css_navi_link, this.get_link(m, mself), m.name );
				this.write_brief_description ( file, m , mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	public void write_class_content ( GLib.FileStream file, Class cl, DocumentedElement? mself ) {
		string full_name = cl.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		this.write_image_block ( file, cl );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_class ( cl, file );
		file.printf ( "\n\t\t\t\t</div>\n" );

		this.write_documentation ( file, cl, cl );

		if ( cl.parent is Namespace ) {
			file.puts ( "\t\t\t\t<br />\n" );
			this.write_namespace_note ( file, cl );
			this.write_package_note ( file, cl );
		}
		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_construction_methods ( file, cl, mself );
		this.write_child_static_methods ( file, cl, mself );
		this.write_child_classes ( file, cl, mself );
		this.write_child_structs ( file, cl, mself );
		this.write_child_enums ( file, cl, mself );
		this.write_child_delegates ( file, cl, mself );
		this.write_child_methods ( file, cl, mself );
		this.write_child_signals ( file, cl, mself );
		this.write_child_properties ( file, cl, mself );
		this.write_child_fields ( file, cl, mself );
		this.write_child_constants ( file, cl, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_interface_content ( GLib.FileStream file, Interface iface, DocumentedElement? mself ) {
		string full_name = iface.full_name ();
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		this.write_image_block ( file, iface );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );
		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_interface ( iface, file );
		file.printf ( "\n\t\t\t\t</div>\n" );

		this.write_documentation ( file, iface, iface );

		if ( iface.parent is Namespace ) {
			file.puts ( "\t\t\t\t<br />\n" );
			this.write_namespace_note ( file, iface );
			this.write_package_note ( file, iface );
		}
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_static_methods ( file, iface, mself );
		this.write_child_classes ( file, iface, mself );
		this.write_child_structs ( file, iface, mself );
		this.write_child_enums ( file, iface, mself );
		this.write_child_delegates ( file, iface, mself );
		this.write_child_methods ( file, iface, mself );
		this.write_child_signals ( file, iface, mself );
		this.write_child_properties ( file, iface, mself );
		this.write_child_fields ( file, iface, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_error_domain_content ( GLib.FileStream file, ErrorDomain errdom, DocumentedElement? mself ) {
		string full_name = errdom.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );

		this.write_documentation ( file, errdom, errdom );

		if ( errdom.parent is Namespace ) {
			file.puts ( "\t\t\t\t<br />\n" );
			this.write_namespace_note ( file, errdom );
			this.write_package_note ( file, errdom );
		}
		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_error_values ( file, errdom );
		this.write_child_static_methods ( file, errdom, mself );
		this.write_child_methods ( file, errdom, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	public void write_struct_content ( GLib.FileStream file, Struct stru, DocumentedElement? mself ) {
		string full_name = stru.full_name ( );
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, full_name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		this.write_image_block ( file, stru );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );

		file.printf ( "\t\t\t\t<div class=\"%s\">\n\t", css_code_definition );
		this.langlet.write_struct ( stru, file );
		file.printf ( "\n\t\t\t\t</div>\n" );

		this.write_documentation ( file, stru, stru );

		if ( stru.parent is Namespace ) {
			file.puts ( "\t\t\t\t<br />\n" );
			this.write_namespace_note ( file, stru );
			this.write_package_note ( file, stru );
		}
		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		this.write_child_construction_methods ( file, stru, mself );
		this.write_child_static_methods ( file, stru, mself );
		this.write_child_methods ( file, stru, mself );
		this.write_child_fields ( file, stru, mself );
		this.write_child_constants ( file, stru, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected string get_img_path ( DocumentedElement element ) {
		return "img/" + element.full_name () + ".png";
	}

	protected string get_img_real_path ( DocumentedElement element ) {
		return this.settings.path + "/" + element.package.name + "/" + "img/" + element.full_name () + ".png";
	}

	protected void write_child_constants ( GLib.FileStream file, ConstantHandler ch, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Constant> constants = ch.get_constant_list ();
		if ( constants.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Constants:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Constant c in constants ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>", get_html_inline_navigation_link_css_class (c), css_navi_link, this.get_link(c, mself), c.name );
				this.write_brief_description ( file, c, mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_child_enums ( GLib.FileStream file, EnumHandler eh, DocumentedElement? mself ) {
		Gee.Collection<Enum> enums = eh.get_enum_list ();
		if ( enums.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Enums:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Enum en in enums ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>\n", get_html_inline_navigation_link_css_class (en), css_navi_link, this.get_link(en, mself), en.name );
				this.write_brief_description ( file, en, mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_child_errordomains ( GLib.FileStream file, ErrorDomainHandler eh, DocumentedElement? mself ) {
		Gee.Collection<ErrorDomain> errdoms = eh.get_error_domain_list ();
		if ( errdoms.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Errordomains:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( ErrorDomain err in errdoms ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>", get_html_inline_navigation_link_css_class (err), css_navi_link,  this.get_link(err, mself), err.name );
				this.write_brief_description ( file, err, mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_child_construction_methods ( GLib.FileStream file, ConstructionMethodHandler cmh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Method> methods = cmh.get_construction_method_list ();
		if ( methods.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Construction Methods:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Method m in methods ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>", get_html_inline_navigation_link_css_class (m), css_navi_link, this.get_link(m, mself), m.name );
				this.write_brief_description ( file, m, mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_image_block ( GLib.FileStream file, DocumentedElement element ) {
		string realimgpath = this.get_img_real_path ( element );
		string imgpath = this.get_img_path ( element );

		if ( element is Class ) {
			Diagrams.write_class_diagram ( (Class)element, realimgpath );
		}
		else if ( element is Interface ) {
			Diagrams.write_interface_diagram ( (Interface)element, realimgpath );
		}
		else if ( element is Struct ) {
			Diagrams.write_struct_diagram ( (Struct)element, realimgpath );
		}

		file.printf ( "<h2 cass=\"%s\">Object Hierarchy:</h2>\n", css_title );
		file.printf ( "<img cass=\"%s\" src=\"%s\"/>\n", css_diagram, imgpath );
	}

	protected void write_child_fields ( GLib.FileStream file, FieldHandler fh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Field> fields = fh.get_field_list ();
		if ( fields.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Fields:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Field f in fields ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>", get_html_inline_navigation_link_css_class(f), css_navi_link, this.get_link(f, mself), f.name );
				this.write_brief_description ( file, f, mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_child_properties ( GLib.FileStream file, PropertyHandler ph, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Property> properties = ph.get_property_list ();
		if ( properties.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Properties:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Property prop in properties ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>", get_html_inline_navigation_link_css_class (prop), css_navi_link, this.get_link(prop, mself), prop.name );
				this.write_brief_description ( file, prop, mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_child_signals ( GLib.FileStream file, SignalHandler sh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Signal> signals = sh.get_signal_list ();
		if ( signals.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Signals:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Signal sig in signals ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>", get_html_inline_navigation_link_css_class (sig), css_navi_link, this.get_link(sig, mself), sig.name );
				this.write_brief_description ( file, sig, mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_child_classes ( GLib.FileStream file, ClassHandler clh, DocumentedElement? mself ) {
		Gee.ReadOnlyCollection<Class> classes = clh.get_class_list ();
		if ( classes.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Classes:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Class subcl in classes ) {
				string name;
				if ( subcl.is_abstract ) {
					name = "<i>" + subcl.name + "</i>";
				}
				else {
					name = subcl.name;
				}

				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>", get_html_inline_navigation_link_css_class (subcl), css_navi_link, this.get_link(subcl, mself ), name );
				this.write_brief_description ( file, subcl, mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_child_interfaces ( GLib.FileStream file, InterfaceHandler ih, DocumentedElement? mself ) {
		Gee.Collection<Interface> ifaces = ih.get_interface_list ( );
		if ( ifaces.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Interfaces:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Interface iface in ifaces ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>", get_html_inline_navigation_link_css_class (iface), css_navi_link, this.get_link(iface, mself), iface.name );
				this.write_brief_description ( file, iface, mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_child_delegates ( GLib.FileStream file, DelegateHandler dh, DocumentedElement? mself ) {
		Gee.Collection<Delegate> delegates = dh.get_delegate_list ();
		if ( delegates.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Delegates:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Delegate d in delegates ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>", get_html_inline_navigation_link_css_class (d), css_navi_link, this.get_link(d, mself), d.name );
				this.write_brief_description ( file, d, mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	protected void write_child_structs ( GLib.FileStream file, StructHandler struh, DocumentedElement? mself ) {
		Gee.Collection<Struct> structs = struh.get_struct_list ();
		if ( structs.size > 0 ) {
			file.printf ( "<h3 class=\"%s\">Structs:</h3>\n", css_title );
			file.printf ( "<ul class=\"%s\">\n", css_inline_navigation );
			foreach ( Struct stru in structs ) {
				file.printf ( "\t<li class=\"%s\"><a class=\"%s\" href=\"%s\">%s</a>", get_html_inline_navigation_link_css_class ( stru ), css_navi_link, this.get_link(stru, mself), stru.name );
				this.write_brief_description ( file, stru, mself );
				file.printf ( "</li>\n" );
			}
			file.puts ( "</ul>\n" );
		}
	}

	public void write_namespace_content ( GLib.FileStream file, Namespace ns, DocumentedElement? mself ) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, (ns.name == null)? "Global Namespace" : ns.full_name () );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );

		this.write_documentation ( file, ns, ns );

		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );
		if ( ns.name == null )
			this.write_child_namespaces ( file, (Package)ns.parent, mself );
		else
			this.write_child_namespaces ( file, ns, mself );

		this.write_child_classes ( file, ns, mself );
		this.write_child_interfaces ( file, ns, mself );
		this.write_child_structs ( file, ns, mself );
		this.write_child_enums ( file, ns, mself );
		this.write_child_errordomains ( file, ns, mself );
		this.write_child_delegates ( file, ns, mself );
		this.write_child_methods ( file, ns, mself );
		this.write_child_fields ( file, ns, mself );
		this.write_child_constants ( file, ns, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_file_content ( GLib.FileStream file, Package f, DocumentedElement? mself, WikiPage? wikipage = null) {
		file.printf ( "\t\t\t<div class=\"%s\">\n", css_style_content );
		file.printf ( "\t\t\t\t<h1 class=\"%s\">%s:</h1>\n", css_title, f.name );
		file.printf ( "\t\t\t\t<hr class=\"%s\" />\n", css_headline_hr );
		file.printf ( "\t\t\t\t<h2 class=\"%s\">Description:</h2>\n", css_title );

		if (wikipage != null) {
			wikipage.write (file);
		}

		file.printf ( "\n\t\t\t\t<h2 class=\"%s\">Content:</h2>\n", css_title );

		this.write_child_namespaces ( file, f, mself );

		foreach ( Namespace ns in f.get_namespace_list() ) {
			if ( ns.name == null ) {
				this.write_child_classes ( file, ns, mself );
				this.write_child_interfaces ( file, ns, mself );
				this.write_child_structs ( file, ns, mself );
				this.write_child_enums ( file, ns, mself );
				this.write_child_errordomains ( file, ns, mself );
				this.write_child_delegates ( file, ns, mself );
				this.write_child_methods ( file, ns, mself );
				this.write_child_fields ( file, ns, mself );
				this.write_child_constants ( file, ns, mself );
			}
		}

		this.write_child_dependencies ( file, f, mself );
		file.puts ( "\t\t\t</div>\n" );
	}

	protected void write_file_header ( GLib.FileStream file, string css, string? title ) {
		file.puts ( "<?xml version=\"1.0\" encoding=\"utf-8\"?>" );
		file.puts ( "<html>\n" );
		file.puts ( "\t<head>\n" );
		file.puts ( "\t\t<title>Vala Binding Reference</title>\n" );
		file.printf ( "\t\t<link href=\"%s\" rel=\"stylesheet\" type=\"text/css\" />\n", css );
		file.puts ( "\t</head>\n" );
		file.puts ( "\t<body>\n\n" );
		file.printf ( "\t<div class=\"%s\">\n", css_site_header );
		file.printf ( "\t\t%s Reference Manual\n", (title == null)? "" : title );
		file.puts ( "\t</div>\n\n" );
		file.printf ( "\t\t<div class=\"%s\">\n", css_style_body );
	}

	protected void write_file_footer ( GLib.FileStream file ) {
		file.puts ( "\t</div>\n" );
		file.puts ( "\t<div style= \"clear: left\">\n" );
		file.puts ( "\t\t<br />\n" );
		file.puts ( "\t\t<div class=\"site_foother\">\n" );
		file.puts ( "\t\t\tcreated by <a href=\"http://www.valadoc.org\">valadoc</a>\n" );
		file.puts ( "\t\t</div>\n" );
		file.puts ( "\t</div>\n" );
		file.puts ( "\t</body>\n" );
		file.puts ( "</html>" );
	}
}

