/* typereference.vala
 *
 * Copyright (C) 2008  Florian Brosch
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

using Gee;
using Valadoc.Content;


/**
 * A reference to a data type.
 */
public class Valadoc.Api.TypeReference : Item {
	private ArrayList<TypeReference> type_arguments = new ArrayList<TypeReference> ();
	private Vala.DataType? vtyperef;

	public TypeReference (Vala.DataType? vtyperef, Item parent) {
		this.vtyperef = vtyperef;
		this.parent = parent;
	}

	/**
	 * Returns a copy of the list of generic type arguments.
	 *
	 * @return type argument list
	 */
	public Gee.Collection<TypeReference> get_type_arguments () {
		return this.type_arguments.read_only_view;
	}

	private void set_template_argument_list (Tree root, Vala.Collection<Vala.DataType> varguments) {
		foreach (Vala.DataType vdtype in varguments) {
			var dtype = new TypeReference (vdtype, this);
			dtype.resolve_type_references (root);
			this.type_arguments.add (dtype);
		}
	}

	/**
	 * The referred data type.
	 */
	public Item? data_type {
		private set;
		get;
	}

	public bool pass_ownership {
		get {
			if (this.vtyperef == null) {
				return false;
			}

			Vala.CodeNode? node = this.vtyperef.parent_node;
			if (node == null) {
				return false;
			}
			if (node is Vala.Parameter) {
				return (((Vala.Parameter)node).direction == Vala.ParameterDirection.IN &&
					((Vala.Parameter)node).variable_type.value_owned);
			}
			if (node is Vala.Property) {
				return ((Vala.Property)node).property_type.value_owned;
			}

			return false;
		}
	}

	/**
	 * Specifies that the expression is owned.
	 */
	public bool is_owned {
		get {
			if (this.vtyperef == null) {
				return false;
			}

			Vala.CodeNode parent = this.vtyperef.parent_node;

			// parameter:
			if (parent is Vala.Parameter) {
				if (((Vala.Parameter)parent).direction != Vala.ParameterDirection.IN) {
					return false;
				}
				return ((Vala.Parameter)parent).variable_type.value_owned;
			}

			return false;
		}
	}

	/**
	 * Specifies that the expression is weak.
	 */
	public bool is_weak {
		get {
			if (vtyperef == null) {
				return false;
			}

			// non ref counted types are unowned, not weak
			if (vtyperef.data_type is Vala.TypeSymbol && ((Vala.TypeSymbol) vtyperef.data_type).is_reference_counting () == false) {
				return false;
			}

			// FormalParameters are weak by default
			return (parent is FormalParameter == false)? vtyperef.is_weak () : false;
		}
	}

	/**
	 * Specifies that the expression is dynamic.
	 */
	public bool is_dynamic {
		get {
			return this.vtyperef != null && this.vtyperef.is_dynamic;
		}
	}

	/**
	 * Specifies that the expression is unwoned.
	 */
	public bool is_unowned {
		get {
			if (vtyperef == null) {
				return false;
			}

			// non ref counted types are weak, not unowned
			if (vtyperef.data_type is Vala.TypeSymbol && ((Vala.TypeSymbol) vtyperef.data_type).is_reference_counting () == true) {
				return false;
			}

			// FormalParameters are weak by default
			return (parent is FormalParameter == false)? vtyperef.is_weak () : false;
		}
	}

	/**
	 * Specifies that the expression may be null.
	 */
	public bool is_nullable {
		get {
			return this.vtyperef != null
			       && this.vtyperef.nullable
			       && !(this.vtyperef is Vala.GenericType)
			       && !(this.vtyperef is Vala.PointerType);
		}
	}

	public string? get_dbus_type_signature () {
		if (vtyperef != null) {
			return Vala.GVariantModule.get_dbus_signature (vtyperef.data_type);
		} else {
			return null;
		}
	}

	/**
	 * {@inheritDoc}
	 */ 
	internal override void resolve_type_references (Tree root) {
		if ( this.vtyperef is Vala.PointerType) {
			this.data_type = new Pointer ((Vala.PointerType) this.vtyperef, this);
		} else if (vtyperef is Vala.ArrayType) {
			this.data_type = new Array ((Vala.ArrayType) this.vtyperef, this);
		} else if (vtyperef is Vala.GenericType) {
			 this.data_type = root.search_vala_symbol (((Vala.GenericType) this.vtyperef).type_parameter);
		} else if (vtyperef is Vala.ErrorType) {
			Vala.ErrorDomain verrdom = ((Vala.ErrorType) vtyperef).error_domain;
			if (verrdom != null) {
				this.data_type = root.search_vala_symbol (verrdom);
			} else {
				this.data_type = glib_error;
			}
		} else if (vtyperef is Vala.DelegateType) {
			this.data_type = root.search_vala_symbol (((Vala.DelegateType) vtyperef).delegate_symbol);
		} else if (vtyperef.data_type != null) {
			this.data_type = root.search_vala_symbol (vtyperef.data_type);
		}

		this.set_template_argument_list (root, vtyperef.get_type_arguments ());

		if (this.data_type is Pointer) {
			((Pointer)this.data_type).resolve_type_references (root);
		} else if (this.data_type is Array) {
			((Array)this.data_type).resolve_type_references (root);
		}
	}

	/**
	 * {@inheritDoc}
	 */ 
	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		if (is_dynamic) {
			signature.append_keyword ("dynamic");
		}

		if (is_weak) {
			signature.append_keyword ("weak");
		} else if (is_owned) {
			signature.append_keyword ("owned");
		} else if (is_unowned) {
			signature.append_keyword ("unowned");
		}

		if (data_type == null) {
			signature.append_keyword ("void");
		} else if (data_type is Symbol) {
			signature.append_type ((Symbol) data_type);
		} else {
			signature.append_content (data_type.signature);
		}

		if (type_arguments.size > 0) {
			signature.append ("<", false);
			bool first = true;
			foreach (Item param in type_arguments) {
				if (!first) {
					signature.append (",", false);
				}
				signature.append_content (param.signature, false);
				first = false;
			}
			signature.append (">", false);
		}

		if (is_nullable) {
			signature.append ("?", false);
		}

		return signature.get ();
	}
}

