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


public class Valadoc.Class : DocumentedElement, SymbolAccessibility, Visitable, ClassHandler, StructHandler, SignalHandler, MethodHandler, EnumHandler, PropertyHandler, ConstructionMethodHandler, FieldHandler, DelegateHandler, ConstantHandler, TemplateParameterListHandler {
	private Gee.ArrayList<Interface> interfaces;
	private bool inherited = false;
	private Vala.Class vclass;

	public Class ( Valadoc.Settings settings, Vala.Class vclass, ClassHandler parent, Tree head ) {
		this.template_param_lst = new Gee.ArrayList<TypeParameter> ();
		this.interfaces = new Gee.ArrayList<Interface>();
		this.methods = new Gee.ArrayList<Method> ();

		this.vcomment = vclass.comment;
		this.settings = settings;
		this.vsymbol = vclass;
		this.vclass = vclass;
		this.parent = parent;
		this.head = head;

		if ( glib_error == null ) {
			if ( this.full_name () == "GLib.Error" ) {
				glib_error = this;
			}
		}

		var vtparams = this.vclass.get_type_parameters ();
		this.set_template_parameter_list ( vtparams );

		Gee.Collection<Vala.Enum> venums = this.vclass.get_enums ();
		this.enums = new Gee.ArrayList<Enum> ();
		this.add_enums ( venums );

		Gee.Collection<Vala.Delegate> vdelegates = this.vclass.get_delegates ();
		this.delegates = new Gee.ArrayList<Delegate> ();
		this.add_delegates ( vdelegates );

		Gee.Collection<Vala.Class> vclasses = this.vclass.get_classes();
		this.classes = new Gee.ArrayList<Class> ();
		this.add_classes ( vclasses );

		Gee.Collection<Vala.Struct> vstructs = this.vclass.get_structs();
		this.structs = new Gee.ArrayList<Struct> ();
		this.add_structs ( vstructs );

		Gee.Collection<Vala.Field> vfields = this.vclass.get_fields();
		this.fields = new Gee.ArrayList<Field> ();
		this.add_fields ( vfields );

		Gee.Collection<Vala.Method> vmethods = this.vclass.get_methods ();
		this.construction_methods = new Gee.ArrayList<Method>();
		this.add_methods_and_construction_methods ( vmethods );

		Gee.Collection<Vala.Signal> vsignals = this.vclass.get_signals();
		this.signals = new Gee.ArrayList<Signal>();
		this.add_signals ( vsignals );

		Gee.Collection<Vala.Property> vproperties = this.vclass.get_properties();
		this.properties = new Gee.ArrayList<Property>();
		this.add_properties ( vproperties );

		Gee.Collection<Vala.Constant> vconstants = this.vclass.get_constants();
		this.constants = new Gee.ArrayList<Constant>();
		this.add_constants ( vconstants );
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

	protected Gee.ArrayList<Delegate> delegates {
		private set;
		get;
	}

	protected Gee.ArrayList<Enum> enums {
		private set;
		get;
	}

	protected Gee.ArrayList<Field> fields {
		set;
		get;
	}

	protected Gee.ArrayList<Method> construction_methods {
		set;
		get;
	}

	protected Gee.ArrayList<Property> properties {
		get;
		set;
	}

	protected Gee.ArrayList<Class> classes {
		set;
		get;
	}

	protected Gee.ArrayList<Struct> structs {
		set;
		get;
	}

	protected Gee.ArrayList<Signal> signals {
		get;
		set;
	}

	protected Gee.ArrayList<Constant> constants {
		get;
		set;
	}

	public string? get_cname () {
		return this.vclass.get_cname();
	}

	public Gee.Collection<Interface> get_implemented_interface_list ( ) {
		return this.interfaces;
	}

	internal override DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos];

		if ( velement is Vala.Class == false )
			return null;

		if ( !this.is_vclass( (Vala.Class)velement ) )
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
		else if ( velement is Vala.Delegate ) {
			element = this.search_delegate_vala ( params, pos );
		}
		else if ( velement is Vala.CreationMethod ) {
			element = this.search_construction_method_vala ( params, pos );
		}
		else if ( velement is Vala.Signal ) {
			element = this.search_signal_vala ( params, pos );
		}
		else if ( velement is Vala.Property ) {
			element = this.search_property_vala ( params, pos );
		}
		else if ( velement is Vala.Struct ) {
			element = this.search_struct_vala ( params, pos );
		}
		else if ( velement is Vala.Class ) {
			element = this.search_class_vala ( params, pos );
		}
		else if ( velement is Vala.Enum ) {
			element = this.search_enum_vala ( params, pos );
		}
		else if ( velement is Vala.Constant ) {
			element = this.search_constant_vala ( params, pos );
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

		element = this.search_delegate ( params, pos );
		if ( element != null )
			return element;

		element = this.search_construction_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_signal ( params, pos );
		if ( element != null )
			return element;

		element = this.search_property ( params, pos );
		if ( element != null )
			return element;

		element = this.search_struct ( params, pos );
		if ( element != null )
			return element;

		element = this.search_class ( params, pos );
		if ( element != null )
			return element;

		element = this.search_enum ( params, pos );
		if ( element != null )
			return element;

		element = this.search_constant ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	internal bool is_vclass ( Vala.Class vcl ) {
		return this.vclass == vcl;
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_class ( this, ptr );
	}

	public bool is_abstract {
		get {
			return this.vclass.is_abstract;
		}
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_class ( this );
	}

	internal void parse_comments ( Valadoc.Parser docparser ) {
		if ( this.documentation != null )
			return ;

		if ( this.vcomment != null ) {
			if ( docparser.is_inherit_doc ( this ) && this.base_type != null ) {
				((Class)this.base_type).parse_comments ( docparser );
				this.documentation = this.base_type.documentation;
			}
			else {
				this.parse_comment_helper ( docparser );
			}
		}

		this.parse_construction_method_comments ( docparser );
		this.parse_delegate_comments ( docparser );
		this.parse_constant_comments ( docparser );
		this.parse_property_comments ( docparser );
		this.parse_method_comments ( docparser );
		this.parse_struct_comments ( docparser );
		this.parse_signal_comments ( docparser );
		this.parse_class_comments ( docparser );
		this.parse_field_comments ( docparser );
		this.parse_enum_comments ( docparser );
	}

	private void set_parent_type_references ( Gee.Collection<Vala.DataType> lst ) {
		if (this.interfaces.size != 0)
			return ;

		foreach ( Vala.DataType vtyperef in lst ) {
			Basic? element = this.head.search_vala_symbol ( vtyperef.data_type );
			if ( element is Class ) {
				this.base_type = (Class)element;
			}
			else {
				this.interfaces.add ( (Interface)element );
			}
		}
	}

	internal void set_type_references ( ) {
		var lst = this.vclass.get_base_types ();
		this.set_parent_type_references ( lst );

		this.set_template_parameter_list_references ( );
		this.set_construction_method_references ( );
		this.set_constant_type_references ( );
		this.set_delegate_type_references ( );
		this.set_property_type_references ( );
		this.set_method_type_references ( );
		this.set_signal_type_references ( );
		this.set_field_type_references ( );
		this.set_enum_type_references ( );
		this.set_struct_type_references ( );
		this.set_class_type_references ( );
	}
}

