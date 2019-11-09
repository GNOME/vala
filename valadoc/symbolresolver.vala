/* symbolresolver.vala
 *
 * Copyright (C) 2011  Florian Brosch
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


using Valadoc.Api;

public class Valadoc.SymbolResolver : Visitor {
	private Vala.HashMap<Vala.Symbol, Symbol> symbol_map;
	private Valadoc.Api.Class glib_error;
	private Api.Tree root;

	public SymbolResolver (TreeBuilder builder) {
		this.symbol_map = builder.get_symbol_map ();
		this.glib_error = builder.get_glib_error ();
	}

	public Symbol? resolve (Vala.Symbol symbol) {
		return symbol_map.get (symbol);
	}

	private void resolve_thrown_list (Symbol symbol, Vala.Symbol vala_symbol) {
		var error_types = new Vala.ArrayList<Vala.DataType> ();
		vala_symbol.get_error_types (error_types);
		foreach (Vala.DataType type in error_types) {
			unowned Vala.ErrorDomain? vala_edom = ((Vala.ErrorType) type).error_domain;
			Symbol? edom = symbol_map.get (vala_edom);
			symbol.add_child (edom ?? glib_error);
		}
	}

	private void resolve_array_type_references (Api.Array ptr) {
		Api.Item data_type = ptr.data_type;
		if (data_type == null) {
			// void
		} else if (data_type is Api.Array) {
			resolve_array_type_references ((Api.Array) data_type);
		} else if (data_type is Pointer) {
			resolve_pointer_type_references ((Api.Pointer) data_type);
		} else {
			resolve_type_reference ((TypeReference) data_type);
		}
	}

	private void resolve_pointer_type_references (Pointer ptr) {
		Api.Item type = ptr.data_type;
		if (type == null) {
			// void
		} else if (type is Api.Array) {
			resolve_array_type_references ((Api.Array) type);
		} else if (type is Pointer) {
			resolve_pointer_type_references ((Pointer) type);
		} else {
			resolve_type_reference ((TypeReference) type);
		}
	}

	private void resolve_type_reference (TypeReference reference) {
		Vala.DataType vtyperef = (Vala.DataType) reference.data;
		if (vtyperef is Vala.ErrorType) {
			Vala.ErrorDomain verrdom = ((Vala.ErrorType) vtyperef).error_domain;
			if (verrdom != null) {
				reference.data_type = resolve (verrdom);
			} else {
				reference.data_type = glib_error;
			}
		} else if (vtyperef is Vala.DelegateType) {
			reference.data_type = resolve (((Vala.DelegateType) vtyperef).delegate_symbol);
		} else if (vtyperef is Vala.GenericType) {
			reference.data_type = resolve (((Vala.GenericType) vtyperef).type_parameter);
		} else if (vtyperef.type_symbol != null) {
			reference.data_type = resolve (vtyperef.type_symbol);
		}

		// Type parameters:
		foreach (TypeReference type_param_ref in reference.get_type_arguments ()) {
			resolve_type_reference (type_param_ref);
		}

		if (reference.data_type is Pointer) {
			resolve_pointer_type_references ((Pointer)reference.data_type);
		} else if (reference.data_type is Api.Array) {
			resolve_array_type_references ((Api.Array)reference.data_type);
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_tree (Api.Tree item) {
		this.root = item;
		item.accept_children (this);
		this.root = null;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_package (Package item) {
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_namespace (Namespace item) {
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_interface (Interface item) {
		Vala.Collection<TypeReference> interfaces = item.get_implemented_interface_list ();
		foreach (var type_ref in interfaces) {
			resolve_type_reference (type_ref);
		}

		if (item.base_type != null) {
			resolve_type_reference (item.base_type);
		}

		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_class (Class item) {
		Vala.Collection<TypeReference> interfaces = item.get_implemented_interface_list ();
		foreach (TypeReference type_ref in interfaces) {
			resolve_type_reference (type_ref);
		}

		if (item.base_type != null)	{
			resolve_type_reference (item.base_type);
		}

		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_struct (Struct item) {
		if (item.base_type != null) {
			resolve_type_reference (item.base_type);
		}

		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_property (Property item) {
		Vala.Property vala_property = item.data as Vala.Property;
		Vala.Property? base_vala_property = null;

		if (vala_property.base_property != null) {
			base_vala_property = vala_property.base_property;
		} else if (vala_property.base_interface_property != null) {
			base_vala_property = vala_property.base_interface_property;
		}
		if (base_vala_property == vala_property && vala_property.base_interface_property != null) {
			base_vala_property = vala_property.base_interface_property;
		}
		if (base_vala_property != null) {
			item.base_property = (Property?) resolve (base_vala_property);
		}

		resolve_type_reference (item.property_type);

		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_field (Field item) {
		resolve_type_reference (item.field_type);

		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_constant (Constant item) {
		resolve_type_reference (item.constant_type);

		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_delegate (Delegate item) {
		Vala.Delegate vala_delegate = item.data as Vala.Delegate;

		resolve_type_reference (item.return_type);

		resolve_thrown_list (item, vala_delegate);

		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_signal (Api.Signal item) {
		resolve_type_reference (item.return_type);

		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_method (Method item) {
		Vala.Method vala_method = item.data as Vala.Method;
		Vala.Method? base_vala_method = null;
		if (vala_method.base_method != null) {
			base_vala_method = vala_method.base_method;
		} else if (vala_method.base_interface_method != null) {
			base_vala_method = vala_method.base_interface_method;
		}
		if (base_vala_method == vala_method && vala_method.base_interface_method != null) {
			base_vala_method = vala_method.base_interface_method;
		}
		if (base_vala_method != null) {
			item.base_method = (Method?) resolve (base_vala_method);
		}

		resolve_thrown_list (item, vala_method);

		resolve_type_reference (item.return_type);

		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_type_parameter (TypeParameter item) {
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_formal_parameter (Api.Parameter item) {
		if (item.ellipsis) {
			return;
		}

		if (((Vala.Parameter) item.data).initializer != null) {
			SignatureBuilder signature = new SignatureBuilder ();
			InitializerBuilder ibuilder = new InitializerBuilder (signature, symbol_map);
			((Vala.Parameter) item.data).initializer.accept (ibuilder);
			item.default_value = signature.get ();
		}

		resolve_type_reference (item.parameter_type);
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_error_domain (ErrorDomain item) {
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_error_code (ErrorCode item) {
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_enum (Enum item) {
		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_enum_value (Api.EnumValue item) {

		if (((Vala.EnumValue) item.data).value != null) {
			SignatureBuilder signature = new SignatureBuilder ();
			InitializerBuilder ibuilder = new InitializerBuilder (signature, symbol_map);
			((Vala.EnumValue) item.data).value.accept (ibuilder);
			item.default_value = signature.get ();
		}

		item.accept_all_children (this, false);
	}
}



