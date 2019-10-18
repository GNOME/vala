/* visitor.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
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
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */


/**
 * Abstract visitor for traversing API.
 */
public abstract class Valadoc.Api.Visitor : GLib.Object {
	/**
	 * Visit operation called for api trees.
	 *
	 * @param item a tree
	 */
	public virtual void visit_tree (Tree item) {
	}

	/**
	 * Visit operation called for packages like gir-files and vapi-files.
	 *
	 * @param item a package
	 */
	public virtual void visit_package (Package item) {
	}

	/**
	 * Visit operation called for namespaces
	 *
	 * @param item a namespace
	 */
	public virtual void visit_namespace (Namespace item) {
	}

	/**
	 * Visit operation called for interfaces.
	 *
	 * @param item a interface
	 */
	public virtual void visit_interface (Interface item) {
	}

	/**
	 * Visit operation called for classes.
	 *
	 * @param item a class
	 */
	public virtual void visit_class (Class item) {
	}

	/**
	 * Visit operation called for structs.
	 *
	 * @param item a struct
	 */
	public virtual void visit_struct (Struct item) {
	}

	/**
	 * Visit operation called for properties.
	 *
	 * @param item a property
	 */
	public virtual void visit_property (Property item) {
	}

	/**
	 * Visit operation called for fields.
	 *
	 * @param item a field
	 */
	public virtual void visit_field (Field item) {
	}

	/**
	 * Visit operation called for constants.
	 *
	 * @param item a constant
	 */
	public virtual void visit_constant (Constant item) {
	}

	/**
	 * Visit operation called for delegates.
	 *
	 * @param item a delegate
	 */
	public virtual void visit_delegate (Delegate item) {
	}

	/**
	 * Visit operation called for signals.
	 *
	 * @param item a signal
	 */
	public virtual void visit_signal (Signal item) {
	}

	/**
	 * Visit operation called for methods.
	 *
	 * @param item a method
	 */
	public virtual void visit_method (Method item) {
	}

	/**
	 * Visit operation called for type parameters.
	 *
	 * @param item a type parameter
	 */
	public virtual void visit_type_parameter (TypeParameter item) {
	}

	/**
	 * Visit operation called for parameters.
	 *
	 * @param item a parameter
	 */
	public virtual void visit_formal_parameter (Parameter item) {
	}

	/**
	 * Visit operation called for error domains.
	 *
	 * @param item a error domain
	 */
	public virtual void visit_error_domain (ErrorDomain item) {
	}

	/**
	 * Visit operation called for error codes.
	 *
	 * @param item a error code
	 */
	public virtual void visit_error_code (ErrorCode item) {
	}

	/**
	 * Visit operation called for enums.
	 *
	 * @param item a enum
	 */
	public virtual void visit_enum (Enum item) {
	}

	/**
	 * Visit operation called for enum values.
	 *
	 * @param item a enum value
	 */
	public virtual void visit_enum_value (EnumValue item) {
	}
}
