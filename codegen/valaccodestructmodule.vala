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

		if (st.base_struct != null) {
			generate_struct_declaration (st.base_struct, decl_space);
		}

		if (st.is_boolean_type () || st.is_integer_type () || st.is_floating_type ()) {
			string typename;
			// See GTypeModule.visit_struct()
			if (st.base_struct != null) {
				typename = get_ccode_name (st.base_struct);
			} else if (st.is_boolean_type ()) {
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
			} else {
				assert_not_reached ();
			}
			decl_space.add_type_declaration (new CCodeTypeDefinition (typename, new CCodeVariableDeclarator (get_ccode_name (st))));
			return;
		}

		if (context.profile == Profile.GOBJECT) {
			if (get_ccode_has_type_id (st)) {
				decl_space.add_include ("glib-object.h");
				decl_space.add_type_declaration (new CCodeNewline ());
				var macro = "(%s_get_type ())".printf (get_ccode_lower_case_name (st, null));
				decl_space.add_type_declaration (new CCodeMacroReplacement (get_ccode_type_id (st), macro));

				var type_fun = new StructRegisterFunction (st);
				type_fun.init_from_type (context, false, true);
				decl_space.add_type_member_declaration (type_fun.get_declaration ());
			}
		}

		if (st.base_struct == null) {
			decl_space.add_type_declaration (new CCodeTypeDefinition ("struct _%s".printf (get_ccode_name (st)), new CCodeVariableDeclarator (get_ccode_name (st))));
		} else {
			decl_space.add_type_declaration (new CCodeTypeDefinition (get_ccode_name (st.base_struct), new CCodeVariableDeclarator (get_ccode_name (st))));
		}

		var instance_struct = new CCodeStruct ("_%s".printf (get_ccode_name (st)));

		if (st.version.deprecated) {
			if (context.profile == Profile.GOBJECT) {
				decl_space.add_include ("glib.h");
			}
			instance_struct.modifiers |= CCodeModifiers.DEPRECATED;
		}

		foreach (Field f in st.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE)  {
				append_field (instance_struct, f, decl_space);
			}
		}

		if (st.base_struct == null) {
			decl_space.add_type_definition (instance_struct);
		}

		if (st.is_simple_type ()) {
			return;
		}

		var function = new CCodeFunction (get_ccode_dup_function (st), get_ccode_name (st) + "*");
		if (st.is_private_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		} else if (context.hide_internal && st.is_internal_symbol ()) {
			function.modifiers = CCodeModifiers.INTERNAL;
		}
		function.add_parameter (new CCodeParameter ("self", "const " + get_ccode_name (st) + "*"));
		decl_space.add_function_declaration (function);

		function = new CCodeFunction (get_ccode_free_function (st), "void");
		if (st.is_private_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		} else if (context.hide_internal && st.is_internal_symbol ()) {
			function.modifiers = CCodeModifiers.INTERNAL;
		}
		function.add_parameter (new CCodeParameter ("self", get_ccode_name (st) + "*"));
		decl_space.add_function_declaration (function);

		if (st.is_disposable ()) {
			function = new CCodeFunction (get_ccode_copy_function (st), "void");
			if (st.is_private_symbol ()) {
				function.modifiers = CCodeModifiers.STATIC;
			} else if (context.hide_internal && st.is_internal_symbol ()) {
				function.modifiers = CCodeModifiers.INTERNAL;
			}
			function.add_parameter (new CCodeParameter ("self", "const " + get_ccode_name (st) + "*"));
			function.add_parameter (new CCodeParameter ("dest", get_ccode_name (st) + "*"));
			decl_space.add_function_declaration (function);

			function = new CCodeFunction (get_ccode_destroy_function (st), "void");
			if (st.is_private_symbol ()) {
				function.modifiers = CCodeModifiers.STATIC;
			} else if (context.hide_internal && st.is_internal_symbol ()) {
				function.modifiers = CCodeModifiers.INTERNAL;
			}
			function.add_parameter (new CCodeParameter ("self", get_ccode_name (st) + "*"));
			decl_space.add_function_declaration (function);
		}
	}

	public override void visit_struct (Struct st) {
		push_context (new EmitContext (st));
		push_line (st.source_reference);

		if (get_ccode_has_type_id (st) && get_ccode_name (st).length < 3) {
			st.error = true;
			Report.error (st.source_reference, "Name `%s' is too short for struct using GType".printf (get_ccode_name (st)));
			return;
		}

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

			if (!st.is_simple_type ()) {
				add_struct_dup_function (st);
				add_struct_free_function (st);
			}
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

		if (context.profile == Profile.GOBJECT) {
			// g_new0 needs glib.h
			cfile.add_include ("glib.h");
			var creation_call = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
			creation_call.add_argument (new CCodeConstant (get_ccode_name (st)));
			creation_call.add_argument (new CCodeConstant ("1"));
			ccode.add_assignment (new CCodeIdentifier ("dup"), creation_call);
		} else if (context.profile == Profile.POSIX) {
			// calloc needs stdlib.h
			cfile.add_include ("stdlib.h");

			var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_call.add_argument (new CCodeConstant (get_ccode_name (st)));

			var creation_call = new CCodeFunctionCall (new CCodeIdentifier ("calloc"));
			creation_call.add_argument (new CCodeConstant ("1"));
			creation_call.add_argument (sizeof_call);
			ccode.add_assignment (new CCodeIdentifier ("dup"), creation_call);
		}

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
		if (st.is_private_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		} else if (context.hide_internal && st.is_internal_symbol ()) {
			function.modifiers = CCodeModifiers.INTERNAL;
		}

		function.add_parameter (new CCodeParameter ("self", get_ccode_name (st) + "*"));

		push_function (function);

		if (st.is_disposable ()) {
			var destroy_call = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_destroy_function (st)));
			destroy_call.add_argument (new CCodeIdentifier ("self"));
			ccode.add_expression (destroy_call);
		}

		if (context.profile == Profile.GOBJECT) {
			// g_free needs glib.h
			cfile.add_include ("glib.h");
			var free_call = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
			free_call.add_argument (new CCodeIdentifier ("self"));
			ccode.add_expression (free_call);
		} else if (context.profile == Profile.POSIX) {
			// free needs stdlib.h
			cfile.add_include ("stdlib.h");
			var free_call = new CCodeFunctionCall (new CCodeIdentifier ("free"));
			free_call.add_argument (new CCodeIdentifier ("self"));
			ccode.add_expression (free_call);
		}

		pop_function ();

		cfile.add_function (function);
	}

	void add_struct_copy_function (Struct st) {
		var function = new CCodeFunction (get_ccode_copy_function (st), "void");
		if (st.is_private_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		} else if (context.hide_internal && st.is_internal_symbol ()) {
			function.modifiers = CCodeModifiers.INTERNAL;
		}

		function.add_parameter (new CCodeParameter ("self", "const " + get_ccode_name (st) + "*"));
		function.add_parameter (new CCodeParameter ("dest", get_ccode_name (st) + "*"));

		push_function (function);

		var dest_struct = new GLibValue (SemanticAnalyzer.get_data_type_for_symbol (st), new CCodeIdentifier ("(*dest)"), true);
		unowned Struct sym = st;
		while (sym.base_struct != null) {
			sym = sym.base_struct;
		}
		foreach (var f in sym.get_fields ()) {
			if (f.binding == MemberBinding.INSTANCE) {
				var value = load_field (f, load_this_parameter ((TypeSymbol) st));
				if ((!(f.variable_type is DelegateType) || get_ccode_delegate_target (f)) && requires_copy (f.variable_type))  {
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
		if (st.is_private_symbol ()) {
			function.modifiers = CCodeModifiers.STATIC;
		} else if (context.hide_internal && st.is_internal_symbol ()) {
			function.modifiers = CCodeModifiers.INTERNAL;
		}

		function.add_parameter (new CCodeParameter ("self", get_ccode_name (st) + "*"));

		push_function (function);

		pop_context ();
	}

	void add_struct_destroy_function (Struct st) {
		unowned Struct sym = st;
		while (sym.base_struct != null) {
			sym = sym.base_struct;
		}
		if (st != sym) {
			push_context (instance_finalize_context);

			var destroy_func = new CCodeFunctionCall (new CCodeIdentifier (get_ccode_destroy_function (sym)));
			destroy_func.add_argument (new CCodeIdentifier ("self"));
			ccode.add_expression (destroy_func);

			pop_context ();
		}

		cfile.add_function (instance_finalize_context.ccode);
	}
}

