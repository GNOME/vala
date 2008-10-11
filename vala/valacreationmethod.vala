/* valacreationmethod.vala
 *
 * Copyright (C) 2007-2008  Raffaele Sandrini, Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Represents a type creation method.
 */
public class Vala.CreationMethod : Method {
	/**
	 * Specifies the name of the type this creation method belongs to.
	 */
	public string type_name { get; set; }

	/**
	 * Specifies the number of parameters this creation method sets.
	 */
	public int n_construction_params { get; set; }

	/**
	 * Specifies a custom C return type for that creation method.
	 * Only the idl parser and the interface writer should use this.
	 * FIXME: remove this as soon the compiler has a decent attribute
	 * handling.
	 */
	public string? custom_return_type_cname { get; set; }

	/**
	 * Specifies whether this constructor chains up to a base
	 * constructor or a different constructor of the same class.
	 */
	public bool chain_up { get; set; }

	/**
	 * Creates a new method.
	 *
	 * @param name             method name
	 * @param source_reference reference to source code
	 * @return                 newly created method
	 */
	public CreationMethod (string? type_name, string? name, SourceReference? source_reference = null) {
		base.init ();
		this.name = name;
		this.source_reference = source_reference;
		this.type_name = type_name;
		return_type = new VoidType ();

		carray_length_parameter_position = -3;
		cdelegate_target_parameter_position = -3;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_creation_method (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (FormalParameter param in get_parameters()) {
			param.accept (visitor);
		}

		foreach (DataType error_type in get_error_types ()) {
			error_type.accept (visitor);
		}

		if (body != null) {
			body.accept (visitor);
		}
	}

	public override string get_default_cname () {
		var parent = parent_symbol as TypeSymbol;

		string infix = "new";
		if (parent is Struct) {
			infix = "init";
		}

		if (name == "new") {
			return "%s%s".printf (parent.get_lower_case_cprefix (), infix);
		} else {
			return "%s%s_%s".printf (parent.get_lower_case_cprefix (), infix, name);
		}
	}

	public override CodeBinding? create_code_binding (CodeGenerator codegen) {
		return codegen.create_creation_method_binding (this);
	}

	public override string get_real_cname () {
		var parent = parent_symbol as Class;

		if (parent == null || parent.is_compact) {
			return get_cname ();
		}

		string infix = "construct";

		if (name == "new") {
			return "%s%s".printf (parent.get_lower_case_cprefix (), infix);
		} else {
			return "%s%s_%s".printf (parent.get_lower_case_cprefix (), infix, name);
		}
	}
}
