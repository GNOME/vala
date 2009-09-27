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


public class Valadoc.TypeReference : Basic {
	private Gee.ArrayList<TypeReference> type_arguments = new Gee.ArrayList<TypeReference> ();
	private Vala.DataType? vtyperef;

	public TypeReference ( Valadoc.Settings settings, Vala.DataType? vtyperef, Basic parent, Tree head ) {
		this.settings = settings;
		this.vtyperef = vtyperef;
		this.parent = parent;
		this.head = head;
	}

	public Gee.Collection<TypeReference> get_type_arguments ( ) {
		return this.type_arguments.read_only_view;
	}

	private void set_template_argument_list ( Gee.Collection<Vala.DataType> varguments ) {
		foreach ( Vala.DataType vdtype in varguments ) {
			var dtype = new TypeReference ( this.settings, vdtype, this, this.head );
			dtype.set_type_references ( );
			this.type_arguments.add ( dtype );
		}
	}

	public Basic? data_type {
		private set;
		get;
	}

	public bool pass_ownership {
		get {
			Vala.CodeNode? node = this.vtyperef.parent_node;
			if ( node == null )
				return false;

			if ( node is Vala.FormalParameter ) {
				return ( ((Vala.FormalParameter)node).direction == ParameterDirection.IN &&
					((Vala.FormalParameter)node).parameter_type.value_owned );
			}

			if ( node is Vala.Property ) {
				return ((Vala.Property)node).property_type.value_owned;
			}

			return false;
		}
	}

	public bool is_owned {
		get {
			Vala.CodeNode parent = this.vtyperef.parent_node;

			// parameter:
			if ( parent is Vala.FormalParameter ) {
				if ( ((Vala.FormalParameter)parent).direction != ParameterDirection.IN )
					return false;

				return ((Vala.FormalParameter)parent).parameter_type.value_owned;
			}
			return false;
		}
	}

	public bool is_unowned {
		get {
			Vala.CodeNode parent = this.vtyperef.parent_node;

			// parameter:
			if ( parent is Vala.FormalParameter ) {
				if ( ((Vala.FormalParameter)parent).direction == ParameterDirection.IN )
					return false;

				return this.is_weak_helper ( ((Vala.FormalParameter)parent).parameter_type );
			}

			return false;
		}
	}


	// from vala/valacodewriter.vala
	private bool is_weak_helper ( Vala.DataType type ) {
		if (type.value_owned) {
			return false;
		} else if (type is Vala.VoidType || type is Vala.PointerType) {
			return false;
		} else if (type is Vala.ValueType) {
			if (type.nullable) {
				// nullable structs are heap allocated
				return true;
			}

			// TODO return true for structs with destroy
			return false;
		}

		return true;
	}
	
	public bool is_dynamic {
		get {
			return this.vtyperef.is_dynamic;
		}
	}

	public bool is_weak {
		get {
			Vala.CodeNode parent = this.vtyperef.parent_node;

			if (parent is Vala.FormalParameter) {
				return false;
			}

			if (parent is Vala.Method == true) {
				return this.is_weak_helper ( ((Vala.Method)parent).return_type );
			}
			else if (parent is Vala.Signal == true) {
				return this.is_weak_helper ( ((Vala.Signal)parent).return_type );
			}
			else if (parent is Vala.Delegate == true) {
				return this.is_weak_helper ( ((Vala.Delegate)parent).return_type );
			}

			return ( this.vtyperef.parent_node is Field )? this.is_weak_helper( this.vtyperef ) : false;
		}
	}

	public bool is_nullable {
		get {
			return this.vtyperef.nullable && this.vtyperef is Vala.PointerType == false;
		}
	}

	// remove
	private string extract_type_name ( Vala.DataType vdtype ) {
			if ( vdtype is Vala.VoidType ) {
				return "void";
			}
			else if ( vdtype is Vala.PointerType ) {
				return this.extract_type_name ( ((Vala.PointerType)vdtype).base_type );
			}
			else if ( vdtype is Vala.DelegateType ) {
				return ((Vala.DelegateType)this.vtyperef).delegate_symbol.name;
			}
			else if ( vdtype is Vala.MethodType ) {
				return ((Vala.MethodType)this.vtyperef).method_symbol.name;
			}
			else if ( vdtype is Vala.SignalType ) {
				return ((Vala.SignalType)this.vtyperef).signal_symbol.name;
			}
			else if ( vdtype is Vala.ArrayType ) {
				this.extract_type_name ( ((Vala.ArrayType)vdtype).element_type );
			}
			return vtyperef.to_string();
	}

	// remove
	public string type_name {
		owned get {
			return this.extract_type_name ( this.vtyperef );
		}
	}

	private TypeParameter? find_template_parameter ( GenericType vtyperef ) {
		Basic? element = this.parent;
		while ( !(element is TemplateParameterListHandler || element == null) ) {
			element = element.parent;
		}

		if ( element == null )
			return null;

		return ((TemplateParameterListHandler)element).find_vtemplateparameter ( (GenericType)vtyperef );
	}

	internal void set_type_references ( ) {
		if ( this.vtyperef != null ) {
			if ( this.vtyperef is PointerType )
				this.data_type = new Pointer ( settings, (Vala.PointerType)this.vtyperef, this, head );
			else if ( vtyperef is ArrayType )
				this.data_type = new Array ( settings, (Vala.ArrayType)this.vtyperef, this, head );
			else if ( vtyperef is GenericType )
				 this.data_type = find_template_parameter ( (GenericType)vtyperef );
		}


		if ( this.data_type == null ) {
			Vala.DataType vtype = this.vtyperef;
			this.set_template_argument_list ( vtype.get_type_arguments ()  );
			// still necessary?
			if ( vtype is Vala.ErrorType ) {
				Vala.ErrorDomain verrdom = ((Vala.ErrorType)vtype).error_domain;
				if ( verrdom != null )
					this.data_type = this.head.search_vala_symbol ( verrdom );
				else
					this.data_type = glib_error;
			}
			// necessary?
			else if (vtype is Vala.DelegateType ) {
				this.data_type = this.head.search_vala_symbol ( ((Vala.DelegateType)vtype).delegate_symbol );
			}
			else {
				this.data_type = this.head.search_vala_symbol ( vtype.data_type );
			}
		}
		else if ( this.data_type is Pointer ) {
			((Pointer)this.data_type).set_type_references ();
		}
		else if ( this.data_type is Array ) {
			((Array)this.data_type).set_type_references ();
		}
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_type_reference ( this, ptr );
	}
}

