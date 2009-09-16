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


using Vala;
using GLib;
using Gee;


public class Valadoc.Namespace : DocumentedElement, MethodHandler, FieldHandler, NamespaceHandler, ErrorDomainHandler,
                                 EnumHandler, ClassHandler, StructHandler, InterfaceHandler,
                                 DelegateHandler, ConstantHandler
{
	protected Gee.ArrayList<Constant> constants {
		protected set;
		get;
	}

	protected Gee.ArrayList<Enum> enums {
		private set;
		get;
	}

	protected Gee.ArrayList<Interface> interfaces {
		private set;
		get;
	}

	protected Gee.ArrayList<Delegate> delegates {
		private set;
		get;
	}

	protected Gee.ArrayList<ErrorDomain> errdoms {
		private set;
		get;
	}

	public Gee.ArrayList<Namespace> namespaces {
		private set;
		get;
	}

	protected Gee.ArrayList<Class> classes {
		private set;
		get;
	}

	protected Gee.ArrayList<Struct> structs {
		private set;
		get;
	}

	internal DocumentedElement? search_namespace (string[] params, int pos) {
		foreach (Namespace ns in this.namespaces) {
			DocumentedElement? element = ns.search_element (params, pos+1);
			if (element != null)
				return element;
		}
		return null;
	}

	internal DocumentedElement? search_namespace_vala (Gee.ArrayList<Vala.Symbol> params, int pos) {
		foreach (Namespace ns in this.namespaces) {
			DocumentedElement? element = ns.search_element_vala (params, pos+1);
			if (element != null)
				return element;
		}
		return null;
	}

	internal override DocumentedElement? search_element_vala (Gee.ArrayList<Vala.Symbol> params, int pos) {
		Vala.Symbol velement = params[pos];

		if (velement is Vala.Namespace == false)
			return null;

		if (this.is_vnspace ((Vala.Namespace)velement) == false)
			return null;

		if (params.size == pos+1)
			return this;

		velement = params[pos+1];

		DocumentedElement? element = null;

		if (velement is Vala.Namespace) {
			element = this.search_namespace_vala (params, pos);
		}
		else if (velement is Vala.Class) {
			element = this.search_class_vala (params, pos);
		}
		else if (velement is Vala.Interface) {
			element = this.search_interface_vala (params, pos);
		}
		else if (velement is Vala.Struct) {
			element = this.search_struct_vala (params, pos);
		}
		else if (velement is Vala.Enum) {
			element = this.search_enum_vala (params, pos);
		}
		else if (velement is Vala.ErrorDomain) {
			element = this.search_error_domain_vala (params, pos);
		}
		else if (velement is Vala.Method) {
			element = this.search_method_vala (params, pos);
		}
		else if (velement is Vala.Field) {
			element = this.search_field_vala (params, pos);
		}
		else if (velement is Vala.DelegateType || velement is Vala.Delegate) {
			element = this.search_delegate_vala (params, pos);
		}
		else if (velement is Vala.Constant) {
			element = this.search_constant_vala (params, pos);
		}
		return element;
	}

	internal override DocumentedElement? search_element ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos] == this.name && params[pos+1] == null )
			return this;


		DocumentedElement? element = this.search_namespace ( params, pos );
		if ( element != null )
			return element;

		element = this.search_class ( params, pos );
		if ( element != null )
			return element;

		element = this.search_interface ( params, pos );
		if ( element != null )
			return element;

		element = this.search_struct ( params, pos );
		if ( element != null )
			return element;

		element = this.search_enum ( params, pos );
		if ( element != null )
			return element;

		element = this.search_error_domain ( params, pos );
		if ( element != null )
			return element;

		element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_field ( params, pos );
		if ( element != null )
			return element;

		element = this.search_delegate ( params, pos );
		if ( element != null )
			return element;

		element = search_constant ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	protected Gee.ArrayList<Field> fields {
		set;
		get;
	}

	protected Gee.ArrayList<Method> methods {
		set;
		get;
	}

	public Namespace ( Valadoc.Settings settings, Vala.Namespace vnspace, NamespaceHandler parent, Tree head ) {
		this.settings = settings;
		this.vsymbol = vnspace;
		this.vnspace = vnspace;
		this.parent = parent;
		this.head = head;

		this.namespaces = new Gee.ArrayList<Namespace> ();
		this.structs = new Gee.ArrayList<Struct>();
		this.classes = new Gee.ArrayList<Class>();

		this.constants = new Gee.ArrayList<Constant> ();
		this.interfaces = new Gee.ArrayList<Interface>();
		this.methods = new Gee.ArrayList<Method> ();
		this.delegates = new Gee.ArrayList<Delegate>();
		this.errdoms = new Gee.ArrayList<ErrorDomain>();
		this.enums = new Gee.ArrayList<Enum>();
		this.fields = new Gee.ArrayList<Field> ();

		if (vnspace.source_reference != null) {
			var vfile = vnspace.source_reference.file;
			foreach (Comment c in vnspace.get_comments()) {
				if (this.package.is_vpackage (c.source_reference.file)) {
					this.vcomment = c;
					break;
				}
			}
		}
	}

	public void visit (Doclet doclet) {
		doclet.visit_namespace (this);
	}

	public Vala.Namespace vnspace {
		private get;
		set;
	}

	internal void set_type_references ( ) {
		this.set_errordomain_type_referenes ();
		this.set_namespace_type_references ();
		this.set_interface_type_references ();
		this.set_delegate_type_references ();
		this.set_constant_type_references ();
		this.set_method_type_references ();
		this.set_field_type_references ();
		this.set_struct_type_references ();
		this.set_class_type_references ();
		this.set_enum_type_references ();
	}

	internal void parse_comments (DocumentationParser docparser) {
		this.parse_comment_helper (docparser);
		this.parse_enum_comments (docparser);
		this.parse_field_comments (docparser);
		this.parse_class_comments (docparser);
		this.parse_method_comments (docparser);
		this.parse_struct_comments (docparser);
		this.parse_constant_comments (docparser);
		this.parse_delegate_comments (docparser);
		this.parse_interface_comments (docparser);
		this.parse_namespace_comments (docparser);
 		this.parse_errordomain_comments (docparser);
	}

	internal bool is_vnspace ( Vala.Namespace vns ) {
		return (this.vnspace == vns);
	}

	public void write (Langlet langlet, void* ptr) {
		langlet.write_namespace (this, ptr);
	}
}



