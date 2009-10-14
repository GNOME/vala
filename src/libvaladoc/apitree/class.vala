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


public class Valadoc.Class : Api.TypeSymbolNode, ClassHandler, StructHandler, SignalHandler, MethodHandler, EnumHandler, PropertyHandler, ConstructionMethodHandler, FieldHandler, DelegateHandler, ConstantHandler, TemplateParameterListHandler {
	private Gee.ArrayList<Interface> interfaces;
	private Vala.Class vclass;

	public Class (Valadoc.Settings settings, Vala.Class symbol, Api.Node parent, Tree root) {
		base (settings, symbol, parent, root);
		this.interfaces = new Gee.ArrayList<Interface>();

		this.vclass = symbol;

		if ( glib_error == null ) {
			if ( this.full_name () == "GLib.Error" ) {
				glib_error = this;
			}
		}
	}

	protected Class? base_type {
		private set;
		get;
	}

	public string? get_cname () {
		return this.vclass.get_cname();
	}

	public Gee.Collection<Interface> get_implemented_interface_list ( ) {
		return this.interfaces;
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

	public override Api.NodeType node_type { get { return Api.NodeType.CLASS; } }

	public override void accept (Doclet doclet) {
		visit (doclet);
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

	protected override void resolve_type_references () {
		var lst = this.vclass.get_base_types ();
		this.set_parent_type_references ( lst );

		base.resolve_type_references ( );
	}
}

