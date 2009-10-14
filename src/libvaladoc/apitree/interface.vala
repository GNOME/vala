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


public class Valadoc.Interface : Api.TypeSymbolNode, SignalHandler, PropertyHandler, FieldHandler, ConstantHandler, TemplateParameterListHandler, MethodHandler, DelegateHandler, EnumHandler, StructHandler, ClassHandler {
	public Interface (Valadoc.Settings settings, Vala.Interface symbol, InterfaceHandler parent, Tree root) {
		base (settings, symbol, parent, root);
		this.vinterface = symbol;

		var vtparams = this.vinterface.get_type_parameters ();
		this.set_template_parameter_list (vtparams);

		Gee.Collection<Vala.Method> methods = this.vinterface.get_methods ();
		this.add_methods (methods);

		Gee.Collection<Vala.Delegate> delegates = this.vinterface.get_delegates ();
		this.add_delegates (delegates);

		Gee.Collection<Vala.Signal> signals = this.vinterface.get_signals();
		this.add_signals (signals);

		Gee.Collection<Vala.Property> properties = this.vinterface.get_properties();
		this.add_properties (properties);

		Gee.Collection<Vala.Field> fields = this.vinterface.get_fields();
		this.add_fields (fields);

		Gee.Collection<Vala.Struct> structs = this.vinterface.get_structs();
		this.add_structs (structs);

		Gee.Collection<Vala.Class> classes = this.vinterface.get_classes();
		this.add_classes (classes);

		Gee.Collection<Vala.Enum> enums = this.vinterface.get_enums();
		this.add_enums (enums);

		Gee.Collection<Vala.Constant> constants = this.vinterface.get_constants();
		this.add_constants ( constants );
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

	private Vala.Interface vinterface;

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_interface ( this );
	}

	public override Api.NodeType node_type { get { return Api.NodeType.INTERFACE; } }

	public override void accept (Doclet doclet) {
		visit (doclet);
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_interface ( this, ptr );
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

	protected override void resolve_type_references () {
		var lst = this.vinterface.get_prerequisites ( );
		this.set_prerequisites ( lst );

		base.resolve_type_references ();
	}
}


