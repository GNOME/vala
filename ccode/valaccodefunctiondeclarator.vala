/* valaccodefunctiondeclarator.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 */

using GLib;

/**
 * Represents a function pointer declarator in the C code.
 */
public class Vala.CCodeFunctionDeclarator : CCodeDeclarator {
	private List<CCodeParameter> parameters = new ArrayList<CCodeParameter> ();

	public CCodeFunctionDeclarator (string name) {
		this.name = name;
	}

	/**
	 * Appends the specified parameter to the list of function parameters.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (CCodeParameter param) {
		parameters.add (param);
	}

	public override void write (CCodeWriter writer) {
		write_declaration (writer);
	}

	public override void write_declaration (CCodeWriter writer) {
		writer.write_string ("(*");
		writer.write_string (name);
		writer.write_string (") (");

		bool has_args = (CCodeModifiers.PRINTF in modifiers || CCodeModifiers.SCANF in modifiers);
		int i = 0;
		int format_arg_index = -1;
		int args_index = -1;
		foreach (CCodeParameter param in parameters) {
			if (i > 0) {
				writer.write_string (", ");
			}
			param.write (writer);
			if (CCodeModifiers.FORMAT_ARG in param.modifiers) {
				format_arg_index = i;
			}
			if (has_args && param.ellipsis) {
				args_index = i;
			} else if (has_args && param.type_name == "va_list" && format_arg_index < 0) {
				format_arg_index = i - 1;
			}
			i++;
		}
		if (i == 0) {
			writer.write_string ("void");
		}

		writer.write_string (")");

		if (CCodeModifiers.DEPRECATED in modifiers) {
			writer.write_string (GNUC_DEPRECATED);
		}

		if (CCodeModifiers.PRINTF in modifiers) {
			format_arg_index = (format_arg_index >= 0 ? format_arg_index + 1 : args_index);
			writer.write_string (GNUC_PRINTF.printf (format_arg_index, args_index + 1));
		} else if (CCodeModifiers.SCANF in modifiers) {
			format_arg_index = (format_arg_index >= 0 ? format_arg_index + 1 : args_index);
			writer.write_string (GNUC_SCANF.printf (format_arg_index, args_index + 1));
		} else if (format_arg_index >= 0) {
			writer.write_string (GNUC_FORMAT.printf (format_arg_index + 1));
		}
	}
}
