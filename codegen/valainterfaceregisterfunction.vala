/* valainterfaceregisterfunction.vala
 *
 * Copyright (C) 2006-2011  Jürg Billeter
 * Copyright (C) 2006-2007  Raffaele Sandrini
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
 * 	Jürg Billeter <j@bitron.ch>
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

/**
 * C function to register an interface at runtime.
 */
public class Vala.InterfaceRegisterFunction : TypeRegisterFunction {
	/**
	 * Specifies the interface to be registered.
	 */
	public weak Interface interface_reference { get; set; }

	public InterfaceRegisterFunction (Interface iface) {
		interface_reference = iface;
	}

	public override TypeSymbol get_type_declaration () {
		return interface_reference;
	}

	public override string get_type_struct_name () {
		return get_ccode_type_name (interface_reference);
	}

	public override string get_base_init_func_name () {
		return "NULL";
	}

	public override string get_class_finalize_func_name () {
		return "NULL";
	}

	public override string get_base_finalize_func_name () {
		return "NULL";
	}

	public override string get_class_init_func_name () {
		return "%s_default_init".printf (get_ccode_lower_case_name (interface_reference));
	}

	public override string get_instance_struct_size () {
		return "0";
	}

	public override string get_instance_init_func_name () {
		return "NULL";
	}

	public override string get_parent_type_name () {
		return "G_TYPE_INTERFACE";
	}

	public override SymbolAccessibility get_accessibility () {
		return interface_reference.access;
	}

	public override void get_type_interface_init_statements (CodeContext context, CCodeBlock block, bool plugin) {
		/* register all prerequisites */
		foreach (DataType prereq_ref in interface_reference.get_prerequisites ()) {
			unowned TypeSymbol prereq = prereq_ref.type_symbol;

			var func = new CCodeFunctionCall (new CCodeIdentifier ("g_type_interface_add_prerequisite"));
			func.add_argument (new CCodeIdentifier ("%s_type_id".printf (get_ccode_lower_case_name (interface_reference))));
			func.add_argument (new CCodeIdentifier (get_ccode_type_id (prereq)));

			block.add_statement (new CCodeExpressionStatement (func));
		}

		((CCodeBaseModule) context.codegen).register_dbus_info (block, interface_reference);
	}
}
