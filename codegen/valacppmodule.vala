/* valacppmodule.vala
 *
 * Copyright (C) 2012  Luca Bruno
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
 * 	Luca Bruno <lucabru@src.gnome.org>
 */


public class Vala.CppModule : CCodeDelegateModule {
	public string get_ccode_wrapper_name (CodeNode node) {
		return get_ccode_name (node).replace("*", "_").replace (":", "_").replace ("<", "_").replace (">", "_");
	}

	public override CCodeExpression? get_destroy_func_expression (DataType type, bool is_chainup = false) {
		var cl = type.data_type as Class;
		if (cl == null || !get_ccode_cpp (cl)) {
			return base.get_destroy_func_expression (type, is_chainup);
		}

		string destroy_func = "_vala_cpp_%s_free".printf (get_ccode_wrapper_name (type));
		if (!add_wrapper (destroy_func)) {
			// wrapper already defined
			return new CCodeIdentifier (destroy_func);
		}

		requires_cpp_symbols = true;

		var function = new CCodeFunction (destroy_func, "void");
		function.modifiers = CCodeModifiers.STATIC;
		function.add_parameter (new CCodeParameter ("self", get_ccode_name (type)));

		push_function (function);

		ccode.add_statement (new CppDeleteStatement (new CCodeIdentifier ("self")));

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		return new CCodeIdentifier (destroy_func);
	}
}
