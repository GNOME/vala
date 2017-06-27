/* childsymbolregistrar.vala
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

public class Valadoc.Api.ChildSymbolRegistrar : Visitor {
	/**
	 * {@inheritDoc}
	 */
	public override void visit_tree (Api.Tree item) {
		item.accept_children (this);
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
			((Interface) type_ref.data_type).register_related_interface (item);
		}

		if (item.base_type != null) {
			((Class) item.base_type.data_type).register_derived_interface (item);
		}

		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_class (Class item) {
		Vala.Collection<TypeReference> interfaces = item.get_implemented_interface_list ();
		foreach (TypeReference type_ref in interfaces) {
			((Interface) type_ref.data_type).register_implementation (item);
		}

		if (item.base_type != null)	{
			((Class) item.base_type.data_type).register_child_class (item);
		}

		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_struct (Struct item) {
		if (item.base_type != null) {
			((Struct) item.base_type.data_type).register_child_struct (item);
		}

		item.accept_all_children (this, false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_property (Property item) {
		item.accept_all_children (this, false);
	}
}

