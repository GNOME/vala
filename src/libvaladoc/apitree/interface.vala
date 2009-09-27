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


public class Valadoc.Interface : DocumentedElement, SymbolAccessibility, Visitable, SignalHandler, PropertyHandler, FieldHandler, TemplateParameterListHandler, MethodHandler, DelegateHandler, EnumHandler, StructHandler, ClassHandler {
	public Interface (Valadoc.Settings settings, Vala.Interface vinterface, InterfaceHandler parent, Tree head) {
		this.vcomment = vinterface.comment;
		this.settings = settings;
		this.vinterface = vinterface;
		this.vsymbol = vinterface;
		this.parent = parent;
		this.head = head;

		this.template_param_lst = new Gee.ArrayList<TypeParameter> ();
		this.methods = new Gee.ArrayList<Method> ();

		var vtparams = this.vinterface.get_type_parameters ();
		this.set_template_parameter_list (vtparams);

		Gee.Collection<Vala.Method> methods = this.vinterface.get_methods ();
		this.methods = new Gee.ArrayList<Method>();
		this.add_methods (methods);

		Gee.Collection<Vala.Delegate> delegates = this.vinterface.get_delegates ();
		this.delegates = new Gee.ArrayList<Delegate>();
		this.add_delegates (delegates);

		Gee.Collection<Vala.Signal> signals = this.vinterface.get_signals();
		this.signals = new Gee.ArrayList<Signal>();
		this.add_signals (signals);

		Gee.Collection<Vala.Property> properties = this.vinterface.get_properties();
		this.properties = new Gee.ArrayList<Property>();
		this.add_properties (properties);

		Gee.Collection<Vala.Field> fields = this.vinterface.get_fields();
		this.fields = new Gee.ArrayList<Field>();
		this.add_fields (fields);

		Gee.Collection<Vala.Struct> structs = this.vinterface.get_structs();
		this.structs = new Gee.ArrayList<Struct>();
		this.add_structs (structs);

		Gee.Collection<Vala.Class> classes = this.vinterface.get_classes();
		this.classes = new Gee.ArrayList<Class>();
		this.add_classes (classes);

		Gee.Collection<Vala.Enum> enums = this.vinterface.get_enums();
		this.enums = new Gee.ArrayList<Enum>();
		this.add_enums (enums);
	}

	private Gee.ArrayList<Interface> interfaces = new Gee.ArrayList<Interface>();

	public Gee.Collection<Interface> get_implemented_interface_list ( ) {
		return this.interfaces;
	}

	public string? get_cname () {
		return this.vinterface.get_cname();
	}

	protected Class? base_type {
		private set;
		get;
	}

	protected Gee.ArrayList<TypeParameter> template_param_lst {
		set;
		get;
	}

	protected Gee.ArrayList<Method> methods {
		set;
		get;
	}

	protected Gee.ArrayList<Property> properties {
		get;
		set;
	}

	protected Gee.ArrayList<Field> fields {
		get;
		set;
	}

	protected Gee.ArrayList<Signal> signals {
		get;
		set;
	}

	protected Gee.ArrayList<Enum> enums {
		get;
		set;
	}

	protected Gee.ArrayList<Delegate> delegates {
		get;
		set;
	}

	protected Gee.ArrayList<Struct> structs {
		get;
		set;
	}

	protected Gee.ArrayList<Class> classes {
		get;
		set;
	}

	private Vala.Interface vinterface;

	internal override DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos];

		if ( velement is Vala.Interface == false )
			return null;

		if ( this.is_vinterface ( (Vala.Interface)velement ) == false )
			return null;

		if ( params.size == pos+1 )
			return this;

		velement = params[pos+1];

		DocumentedElement? element = null;

		if ( velement is Vala.Field ) {
			element = this.search_field_vala ( params, pos );
		}
		else if ( velement is Vala.Method ) {
			element = this.search_method_vala ( params, pos );
		}
		else if ( velement is Vala.Signal ) {
			element = this.search_signal_vala ( params, pos );
		}
		else if ( velement is Vala.Property ) {
			element = this.search_property_vala ( params, pos );
		}
		else if ( velement is Vala.Delegate ) {
			element = this.search_delegate_vala ( params, pos );
		}
		else if ( velement is Vala.Struct ) {
			element = this.search_struct_vala ( params, pos );
		}
		else if ( velement is Vala.Enum ) {
			element = this.search_enum_vala ( params, pos );
		}
		else if ( velement is Vala.Class ) {
			element = this.search_class_vala ( params, pos );
		}
		return element;
	}

	internal override DocumentedElement? search_element ( string[] params, int pos ) {
		if ( !(this.name == params[pos] || params[0] == "this") )
			return null;

		if ( params[pos] == this.name && params[pos+1] == null )
			return this;

		DocumentedElement? element = this.search_field ( params, pos );
		if ( element != null )
			return element;

		element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_signal ( params, pos );
		if ( element != null )
			return element;

		element = this.search_property ( params, pos );
		if ( element != null )
			return element;

		element = this.search_delegate ( params, pos );
		if ( element != null )
			return element;

		element = this.search_struct ( params, pos );
		if ( element != null )
			return element;

		element = this.search_enum ( params, pos );
		if ( element != null )
			return element;

		element = this.search_class ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	internal bool is_vinterface ( Vala.Interface viface ) {
		return ( this.vinterface == viface );
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_interface ( this );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_interface ( this, ptr );
	}

	internal void parse_comments ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );
		this.parse_delegate_comments ( docparser );
		this.parse_property_comments ( docparser );
		this.parse_signal_comments ( docparser );
		this.parse_method_comments ( docparser );
		this.parse_struct_comments ( docparser );
		this.parse_field_comments ( docparser );
		this.parse_class_comments ( docparser );
		this.parse_enum_comments ( docparser );
	}

	private void set_prerequisites ( Gee.Collection<Vala.DataType> lst ) {
		if ( ((Gee.Collection)this.interfaces).size != 0 )
			return ;

		foreach ( Vala.DataType vtyperef in lst ) {
			Basic? element = this.head.search_vala_symbol ( vtyperef.data_type );
			if ( element is Class )
				this.base_type = (Class)element;
			else
				this.interfaces.add ( (Interface)element );
		}
	}

	internal void set_type_references ( ) {
		this.set_template_parameter_list_references ( );
		this.set_delegate_type_references ();
		this.set_property_type_references ();
		this.set_signal_type_references ();
		this.set_method_type_references ();
		this.set_struct_type_references ();
		this.set_field_type_references ();
		this.set_enum_type_references ();
		this.set_class_type_references ();

		var lst = this.vinterface.get_prerequisites ( );
		this.set_prerequisites ( lst );
	}
}


