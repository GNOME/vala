/* typereference.vala
 *
 * Copyright (C) 2008-2011  Florian Brosch
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


using Valadoc.Content;

/**
 * A reference to a data type.
 */
public class Valadoc.Api.TypeReference : Item {
	private Vala.ArrayList<TypeReference> type_arguments = new Vala.ArrayList<TypeReference> ();
	private string? dbus_type_signature;
	private Ownership ownership;

	public TypeReference (Item parent, bool is_dynamic,
						  bool is_nullable, string? dbus_type_signature, Vala.DataType? data)
	{
		base (data);

		this.dbus_type_signature = dbus_type_signature;
		this.pass_ownership = type_reference_pass_ownership (data);
		this.is_nullable = is_nullable;
		this.is_dynamic = is_dynamic;
		this.ownership = get_type_reference_ownership (data);
		this.parent = parent;
	}

	bool is_reference_counting (Vala.TypeSymbol sym) {
		return Vala.is_reference_counting (sym);
	}

	bool type_reference_pass_ownership (Vala.DataType? element) {
		if (element == null) {
			return false;
		}

		weak Vala.CodeNode? node = element.parent_node;
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

	bool is_type_reference_unowned (Vala.DataType? element) {
			if (element == null) {
				return false;
			}

			// non ref counted types are weak, not unowned
			if (element.data_type is Vala.TypeSymbol
				&& is_reference_counting ((Vala.TypeSymbol) element.data_type) == true)
			{
				return false;
			}

			// FormalParameters are weak by default
			return (element.parent_node is Vala.Parameter == false)
				? element.is_weak ()
				: false;
	}

	bool is_type_reference_owned (Vala.DataType? element) {
		if (element == null) {
			return false;
		}

		weak Vala.CodeNode parent = element.parent_node;

		// parameter:
		if (parent is Vala.Parameter) {
			if (((Vala.Parameter)parent).direction != Vala.ParameterDirection.IN) {
				return false;
			}
			return ((Vala.Parameter)parent).variable_type.value_owned;
		}

		return false;
	}

	bool is_type_reference_weak (Vala.DataType? element) {
		if (element == null) {
			return false;
		}

		// non ref counted types are unowned, not weak
		if (element.data_type is Vala.TypeSymbol
			&& is_reference_counting ((Vala.TypeSymbol) element.data_type) == false)
		{
			return false;
		}

		// arrays are unowned, not weak
		if (element is Vala.ArrayType) {
			return false;
		}

		// FormalParameters are weak by default
		return (element.parent_node is Vala.Parameter == false)? element.is_weak () : false;
	}

	Ownership get_type_reference_ownership (Vala.DataType? element) {
		if (is_type_reference_owned (element)) {
			return Ownership.OWNED;
		} else if (is_type_reference_weak (element)) {
			return Ownership.WEAK;
		} else if (is_type_reference_unowned (element)) {
			return Ownership.UNOWNED;
		}

		return Ownership.DEFAULT;
	}

	/**
	 * Returns a copy of the list of generic type arguments.
	 *
	 * @return type argument list
	 */
	public Vala.Collection<TypeReference> get_type_arguments () {
		return this.type_arguments;
	}

	public void add_type_argument (TypeReference type_ref) {
		type_arguments.add (type_ref);
	}

	/**
	 * The referred data type.
	 */
	public Item? data_type {
		set;
		get;
	}

	public bool pass_ownership {
		private set;
		get;
	}

	/**
	 * Specifies that the expression is owned.
	 */
	public bool is_owned {
		get {
			return ownership == Ownership.OWNED;
		}
	}

	/**
	 * Specifies that the expression is weak.
	 */
	public bool is_weak {
		get {
			return ownership == Ownership.WEAK;
		}
	}

	/**
	 * Specifies that the expression is unwoned.
	 */
	public bool is_unowned {
		get {
			return ownership == Ownership.UNOWNED;
		}
	}


	/**
	 * Specifies that the expression is dynamic.
	 */
	public bool is_dynamic {
		private set;
		get;
	}

	/**
	 * Specifies that the expression may be null.
	 */
	public bool is_nullable {
		private set;
		get;
	}

	public string? get_dbus_type_signature () {
		return dbus_type_signature;
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

