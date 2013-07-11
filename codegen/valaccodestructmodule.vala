/* valaccodestructmodule.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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

public abstract class Vala.CCodeStructModule : CCodeBaseModule {
	public override void generate_struct_declaration (Struct st, CCodeFile decl_space) {
		if (add_symbol_declaration (decl_space, st, get_ccode_name (st))) {
			return;
		}

		if (st.is_boolean_type () || st.is_integer_type () || st.is_floating_type ()) {
			if (st.base_struct != null) {
				generate_struct_declaration (st.base_struct, decl_space);
				decl_space.add_type_declaration (new CCodeTypeDefinition (get_ccode_name (st.base_struct), new CCodeVariableDeclarator (get_ccode_name (st))));
			} else {
				string typename = null;
				if (st.is_boolean_type ()) {
					// typedef for boolean types
					decl_space.add_include ("stdbool.h");
					typename = "bool";
				} else if (st.is_integer_type ()) {
					// typedef for integral types
					decl_space.add_include ("stdint.h");
					typename = "%sint%d_t".printf (st.signed ? "" : "u", st.width);
				} else if (st.is_floating_type ()) {
					// typedef for floating types
					typename = (st.width == 64 ? "double" : "float");
				}
				decl_space.add_type_declaration (new CCodeTypeDefinition (typename, new CCodeVariableDeclarator (get_ccode_name (st))));
			}
			return;
		}

		if (get_ccode_has_type_id (st)) {
			decl_space.add_type_declaration (new CCodeNewline ());
			var macro = "(%s_get_type ())".printf (get_ccode_lower_case_name (st, null));
			decl_space.add_type_declaration (new CCodeMacroReplacement (get_ccode_type_id (st), macro));

			var type_fun = new StructRegisterFunction (st, context);
			type_fun.init_from_type (false, true);
			decl_space.add_type_member_declaration (type_fun.get_declaration ());
		}

		var instance_struct = new CCodeStruct ("_%s".printf (get_ccode_name (st)));
		instance_struct.deprecated = st.deprecated;

		foreach (Field f in st.get_fields ()) {
			string field_ctype = get_ccode_name (f.variable_type);
			if (f.is_volatile) {
				field_ctype = "volatile " + field_ctype;
			}

			if (f.binding == MemberBinding.INSTANCE)  {
				generate_type_declaration (f.variable_type, decl_space);

				instance_struct.add_field (field_ctype, get_ccode_name (f) + get_ccode_declarator_suffix (f.variable_type), f.deprecated ? " G_GNUC_DEPRECATED" : null);
				if (f.variable_type is ArrayType && get_ccode_array_length (f)) {
					// create fields to store array dimensions
					var array_type = (ArrayType) f.variable_type;

					if (!array_type.fixed_length) {
						var len_type = int_type.copy ();

						for (int dim = 1; dim <= array_type.rank; dim++) {
							string length_cname;
							if (get_ccode_array_length_name (f) != null) {
								length_cname = get_ccode_array_length_name (f);
							} else {
								length_cname = get_array_length_cname (f.name, dim);
							}
							instance_struct.add_field (get_ccode_name (len_type), length_cname);
						}

						if (array_type.rank == 1 && f.is_internal_symbol ()) {
							instance_struct.add_field (get_ccode_name (len_type), get_array_size_cname (f.name));
						}
					}
				} else if (f.variable_type is DelegateType) {
					var delegate_type = (DelegateType) f.variable_type;
					if (delegate_type.delegate_symbol.has_target) {
						// create field to store delegate target
						instance_struct.add_field ("gpointer", get_ccode_delegate_target_name (f));
						if (delegate_type.is_disposable ()) {
							instance_struct.add_field ("GDestroyNotify", get_delegate_target_destroy_notify_cname (f.name));
						}
					}
				}
			}
		}

		if (st.base_struct == null) {
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (get_ccode_name (st)), new CCodeVariableDeclarator (get_ccode_name (st))));

			decl_space.add_type_definition (instance_struct);
		} else {
			decl_space.add_type_declaration (new CCodeTypeDefinition (get_ccode_name (st.base_struct), new CCodeVariableDeclarator (get_ccode_name (st))));
		}

		var function = new CCodeFunction (get_ccode_dup_function (st), get_ccode_name (st) + "*");
		if (st.is_private_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		}
		function.add_parameter (new CCodeParameter ("self", "const " + get_ccode_name (st) + "*"));
		decl_space.add_function_declaration (function);

		function = new CCodeFunction (get_ccode_free_function (st), "void");
		if (st.is_private_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		}
		function.add_parameter (new CCodeParameter ("self", get_ccode_name (st) + "*"));
		decl_space.add_function_declaration (function);

		if (st.is_disposable ()) {
			function = new CCodeFunction (get_ccode_copy_function (st), "void");
			if (st.is_private_symbol ()) {
				function.modifiers = CCodeModifiers.STATIC;
			}
			function.add_parameter (new CCodeParameter ("self", "const " + get_ccode_name (st) + "*"));
			function.add_parameter (new CCodeParameter ("dest", get_ccode_name (st) + "*"));
			decl_space.add_function_declaration (function);

			function = new CCodeFunction (get_ccode_destroy_function (st), "void");
			if (st.is_private_symbol ()) {
				function.modifiers = CCodeModifiers.STATIC;
			}
			function.add_parameter (new CCodeParameter ("self", get_ccode_name (st) + "*"));
			decl_space.add_function_declaration (function);
		}
	}

	public override void visit_struct (Struct st) {
		push_context (new EmitContext (st));
		push_line (st.source_reference);

		var old_instance_finalize_context = instance_finalize_context;
		instance_finalize_context = new EmitContext ();

		generate_struct_declaration (st, cfile);

		if (!st.is_internal_symbol ()) {
			generate_struct_declaration (st, header_file);
		}
		if (!st.is_private_symbol ()) {
			generate_struct_declaration (st, internal_header_file);
		}

		if (!st.is_boolean_type () && !st.is_integer_type () && !st.is_floating_type ()) {
			if (st.is_disposable ()) {
				begin_struct_destroy_function (st);
			}
		}

		st.accept_children (this);

		if (!st.is_boolean_type () && !st.is_integer_type () && !st.is_floating_type ()) {
			if (st.is_disposable ()) {
				add_struct_copy_function (st);
				add_struct_destroy_function (st);
			}

			add_struct_dup_function (st);
			add_struct_free_function (st);
		}

		instance_finalize_context = old_instance_finalize_context;

		pop_line ();
		pop_context ();
	}

	void add_struct_dup_function (Struct st) {
		var function = new CCodeFunction (get_ccode_dup_function (st), get_ccode_name (st) + "*");
		if (st.access == SymbolAccessibility.PRIVATE) {
			function.modifiers = CCodeModifiers.STATIC;
		}

		function.add_parameter (new CCodeParameter ("self", "const " + get_ccode_name (st) + "*"));

		push_function (function);

		ccode.add_declaration (get_ccode_name (st) + "*", new CCodeVariableDeclarator ("dup"));

		var creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
		creation_call.add_argument (new CCodeConstant (get_ccode_name (st)));
		creation_call.add_argument (new CCodeConstant ("1"));
		ccode.add_assignment (new CCodeIdentifier ("dup"), creation_call);

		if (st.is_disposable ()) {
			var copy_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_copy_function (st)));
			copy_call.add_argument (new CCodeIdentifier ("self"));
			copy_call.add_argument (new CCodeIdentifier ("dup"));
			ccode.add_expression (copy_call);
		} else {
			cfile.add_include ("string.h");

			var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_call.add_argument (new CCodeConstant (get_ccode_name (st)));

			var copy_call = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
			copy_call.add_argument (new CCodeIdentifier ("dup"));
			copy_call.add_argument (new CCodeIdentifier ("self"));
			copy_call.add_argument (sizeof_call);
			ccode.add_expression (copy_call);
		}

		ccode.add_return (new CCodeIdentifier ("dup"));

		pop_function ();

		cfile.add_function (function);
	}

	void add_struct_free_function (Struct st) {
		var function = new CCodeFunction (get_ccode_free_function (st), "void");
		if (st.access == SymbolAccessibility.PRIVATE) {
			function.modifiers = CCodeModifiers.STATIC;
		}

		function.add_parameter (new CCodeParameter ("self", get_ccode_name (st) + "*"));

		push_function (function);

		if (st.is_disposable ()) {
			var destroy_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_destroy_function (st)));
			destroy_call.add_argument (new CCodeIdentifier ("self"));
			ccode.add_expression (destroy_call);
		}

		var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		free_call.add_argument (new CCodeIdentifier ("self"));
		ccode.add_expression (free_call);

		pop_function ();

		cfile.add_function (function);
	}

	void add_struct_copy_function (Struct st) {
		var function = new CCodeFunction (get_ccode_copy_function (st), "void");
		if (st.access == SymbolAccessibility.PRIVATE) {
			function.modifiers = CCodeModifiers.STATIC;
		}

		function.add_parameter (new CCodeParameter ("self", "const " + get_ccode_name (st) + "*"));
		function.add_parameter (new CCodeParameter ("dest", get_ccode_name (st) + "*"));

		push_function (function);

		var dest_struct = new GLibValue (get_data_type_for_symbol (st), new CCodeIdentifier ("(*dest)"), true);
		foreach (var f in st.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE) {
				var value = load_field (f, load_this_parameter ((TypeSymbol) st));
				if (requires_copy (f.variable_type))  {
					value = copy_value (value, f);
					if (value == null) {
						// error case, continue to avoid critical
						continue;
					}
				}
				store_field (f, dest_struct, value);
			}
		}

		pop_function ();

		cfile.add_function (function);
	}

	void begin_struct_destroy_function (Struct st) {
		push_context (instance_finalize_context);

		var function = new CCodeFunction (get_ccode_destroy_function (st), "void");
		if (st.access == SymbolAccessibility.PRIVATE) {
			function.modifiers = CCodeModifiers.STATIC;
		}

		function.add_parameter (new CCodeParameter ("self", get_ccode_name (st) + "*"));

		push_function (function);

		pop_context ();
	}

	void add_struct_destroy_function (Struct st) {
		cfile.add_function (instance_finalize_context.ccode);
	}
}

