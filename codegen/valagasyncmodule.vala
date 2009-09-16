/* valagasyncmodule.vala
 *
 * Copyright (C) 2008-2009  Jürg Billeter
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
using Gee;

internal class Vala.GAsyncModule : GSignalModule {
	public GAsyncModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	CCodeStruct generate_data_struct (Method m) {
		string dataname = Symbol.lower_case_to_camel_case (m.get_cname ()) + "Data";
		var data = new CCodeStruct ("_" + dataname);

		data.add_field ("int", "state");
		data.add_field ("GAsyncResult*", "res");
		data.add_field ("GSimpleAsyncResult*", "_async_result");

		if (m.binding == MemberBinding.INSTANCE) {
			var type_sym = (TypeSymbol) m.parent_symbol;
			data.add_field (type_sym.get_cname () + "*", "self");
		}

		foreach (FormalParameter param in m.get_parameters ()) {
			data.add_field (param.parameter_type.get_cname (), get_variable_cname (param.name));
			if (param.parameter_type is ArrayType) {
				var array_type = (ArrayType) param.parameter_type;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					data.add_field ("gint", get_array_length_cname (get_variable_cname (param.name), dim));
				}
			} else if (param.parameter_type is DelegateType) {
				data.add_field ("gpointer", get_delegate_target_cname (get_variable_cname (param.name)));
			}
		}

		if (!(m.return_type is VoidType)) {
			data.add_field (m.return_type.get_cname (), "result");
			if (m.return_type is ArrayType) {
				var array_type = (ArrayType) m.return_type;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					data.add_field ("gint", get_array_length_cname ("result", dim));
				}
			} else if (m.return_type is DelegateType) {
				data.add_field ("gpointer", get_delegate_target_cname ("result"));
			}
		}

		return data;
	}

	CCodeFunction generate_free_function (Method m) {
		var dataname = Symbol.lower_case_to_camel_case (m.get_cname ()) + "Data";

		var freefunc = new CCodeFunction (m.get_real_cname () + "_data_free", "void");
		freefunc.modifiers = CCodeModifiers.STATIC;
		freefunc.add_parameter (new CCodeFormalParameter ("_data", "gpointer"));

		var freeblock = new CCodeBlock ();
		freefunc.block = freeblock;

		var datadecl = new CCodeDeclaration (dataname + "*");
		datadecl.add_declarator (new CCodeVariableDeclarator ("data", new CCodeIdentifier ("_data")));
		freeblock.add_statement (datadecl);

		if (requires_destroy (m.return_type)) {
			/* this is very evil. */
			var v = new LocalVariable (m.return_type, ".result");
			var ma = new MemberAccess.simple (".result");
			ma.symbol_reference = v;
			var old_symbol = current_symbol;
			current_symbol = m;
			var unref_expr = get_unref_expression (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "result"), m.return_type, ma);
			freeblock.add_statement (new CCodeExpressionStatement (unref_expr));
			current_symbol = old_symbol;
		}

		var freecall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_free"));
		freecall.add_argument (new CCodeIdentifier (dataname));
		freecall.add_argument (new CCodeIdentifier ("data"));
		freeblock.add_statement (new CCodeExpressionStatement (freecall));

		return freefunc;
	}

	CCodeFunction generate_async_function (Method m) {
		var asyncblock = new CCodeBlock ();

		// logic copied from valaccodemethodmodule
		if (m.overrides || (m.base_interface_method != null && !m.is_abstract && !m.is_virtual)) {
			Method base_method;

			if (m.overrides) {
				base_method = m.base_method;
			} else {
				base_method = m.base_interface_method;
			}

			var base_expression_type = new ObjectType ((ObjectTypeSymbol) base_method.parent_symbol);
			var type_symbol = m.parent_symbol as ObjectTypeSymbol;

			var self_target_type = new ObjectType (type_symbol);
			var cself = transform_expression (new CCodeIdentifier ("base"), base_expression_type, self_target_type);
			var cdecl = new CCodeDeclaration ("%s *".printf (type_symbol.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator ("self", cself));
			asyncblock.add_statement (cdecl);
		}

		var dataname = Symbol.lower_case_to_camel_case (m.get_cname ()) + "Data";
		var asyncfunc = new CCodeFunction (m.get_real_cname (), "void");
		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		var dataalloc = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_new0"));
		dataalloc.add_argument (new CCodeIdentifier (dataname));

		var datadecl = new CCodeDeclaration (dataname + "*");
		datadecl.add_declarator (new CCodeVariableDeclarator ("data"));
		asyncblock.add_statement (datadecl);
		asyncblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data"), dataalloc)));

		var create_result = new CCodeFunctionCall (new CCodeIdentifier ("g_simple_async_result_new"));

		var cl = m.parent_symbol as Class;
		if (m.binding == MemberBinding.INSTANCE &&
		    cl != null && cl.is_subtype_of (gobject_type)) {
			var gobject_cast = new CCodeFunctionCall (new CCodeIdentifier ("G_OBJECT"));
			gobject_cast.add_argument (new CCodeIdentifier ("self"));

			create_result.add_argument (gobject_cast);
		} else {
			create_result.add_argument (new CCodeConstant ("NULL"));
		}

		create_result.add_argument (new CCodeIdentifier ("callback"));
		create_result.add_argument (new CCodeIdentifier ("user_data"));
		create_result.add_argument (new CCodeIdentifier (m.get_real_cname ()));

		asyncblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "_async_result"), create_result)));

		var set_op_res_call = new CCodeFunctionCall (new CCodeIdentifier ("g_simple_async_result_set_op_res_gpointer"));
		set_op_res_call.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "_async_result"));
		set_op_res_call.add_argument (new CCodeIdentifier ("data"));
		set_op_res_call.add_argument (new CCodeIdentifier (m.get_real_cname () + "_data_free"));
		asyncblock.add_statement (new CCodeExpressionStatement (set_op_res_call));

		if (m.binding == MemberBinding.INSTANCE) {
			asyncblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "self"), new CCodeIdentifier ("self"))));
		}

		foreach (FormalParameter param in m.get_parameters ()) {
			if (param.direction != ParameterDirection.OUT) {
				asyncblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_variable_cname (param.name)), new CCodeIdentifier (get_variable_cname (param.name)))));
				if (param.parameter_type is ArrayType) {
					var array_type = (ArrayType) param.parameter_type;
					for (int dim = 1; dim <= array_type.rank; dim++) {
						asyncblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_array_length_cname (get_variable_cname (param.name), dim)), new CCodeIdentifier (get_array_length_cname (get_variable_cname (param.name), dim)))));
					}
				} else if (param.parameter_type is DelegateType) {
					asyncblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_delegate_target_cname (get_variable_cname (param.name))), new CCodeIdentifier (get_delegate_target_cname (get_variable_cname (param.name))))));
				}
			}
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_real_cname () + "_co"));
		ccall.add_argument (new CCodeIdentifier ("data"));
		asyncblock.add_statement (new CCodeExpressionStatement (ccall));

		cparam_map.set (get_param_pos (-1), new CCodeFormalParameter ("callback", "GAsyncReadyCallback"));
		cparam_map.set (get_param_pos (-0.9), new CCodeFormalParameter ("user_data", "gpointer"));

		generate_cparameters (m, source_declarations, cparam_map, asyncfunc, null, null, null, 1);

		if (m.base_method != null || m.base_interface_method != null) {
			// declare *_real_* function
			asyncfunc.modifiers |= CCodeModifiers.STATIC;
			source_declarations.add_type_member_declaration (asyncfunc.copy ());
		} else if (m.is_private_symbol ()) {
			asyncfunc.modifiers |= CCodeModifiers.STATIC;
		}

		asyncfunc.block = asyncblock;

		return asyncfunc;
	}

	void append_struct (CCodeStruct structure) {
		var typename = new CCodeVariableDeclarator (structure.name.substring (1));
		var typedef = new CCodeTypeDefinition ("struct " + structure.name, typename);
		source_declarations.add_type_declaration (typedef);
		source_declarations.add_type_definition (structure);
	}

	void append_function (CCodeFunction function) {
		var block = function.block;
		function.block = null;
 
		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);
	}

	public override void generate_method_declaration (Method m, CCodeDeclarationSpace decl_space) {
		if (m.coroutine) {
			if (decl_space.add_symbol_declaration (m, m.get_cname ())) {
				return;
			}

			var asyncfunc = new CCodeFunction (m.get_cname (), "void");
			var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);
			cparam_map.set (get_param_pos (-1), new CCodeFormalParameter ("callback", "GAsyncReadyCallback"));
			cparam_map.set (get_param_pos (-0.9), new CCodeFormalParameter ("user_data", "gpointer"));

			generate_cparameters (m, decl_space, cparam_map, asyncfunc, null, null, null, 1);

			if (m.is_private_symbol ()) {
				asyncfunc.modifiers |= CCodeModifiers.STATIC;
			}

			decl_space.add_type_member_declaration (asyncfunc);

			var finishfunc = new CCodeFunction (m.get_finish_cname ());
			cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);
			cparam_map.set (get_param_pos (0.1), new CCodeFormalParameter ("res", "GAsyncResult*"));

			generate_cparameters (m, source_declarations, cparam_map, finishfunc, null, null, null, 2);

			if (m.is_private_symbol ()) {
				finishfunc.modifiers |= CCodeModifiers.STATIC;
			}

			decl_space.add_type_member_declaration (finishfunc);
		} else {
			base.generate_method_declaration (m, decl_space);
		}
	}

	public override void visit_method (Method m) {
		if (m.coroutine) {
			source_declarations.add_include ("gio/gio.h");
			if (!m.is_internal_symbol ()) {
				header_declarations.add_include ("gio/gio.h");
			}

			if (!m.is_abstract) {
				var data = generate_data_struct (m);
				append_struct (data);

				append_function (generate_free_function (m));
				source_type_member_definition.append (generate_async_function (m));
				source_type_member_definition.append (generate_finish_function (m));
				append_function (generate_ready_function (m));

				// append the _co function
				closure_struct = data;
				base.visit_method (m);
				closure_struct = null;
			}

			if (m.is_abstract || m.is_virtual) {
				// generate virtual function wrappers
				var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);
				var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);
				generate_vfunc (m, new VoidType (), cparam_map, carg_map, "", 1);

				cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);
				carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);
				generate_vfunc (m, m.return_type, cparam_map, carg_map, "_finish", 2);
			}
		} else {
			base.visit_method (m);
		}
	}


	CCodeFunction generate_finish_function (Method m) {
		string dataname = Symbol.lower_case_to_camel_case (m.get_cname ()) + "Data";

		var finishfunc = new CCodeFunction (m.get_finish_real_cname ());

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		var finishblock = new CCodeBlock ();

		var return_type = m.return_type;
		if (!(return_type is VoidType)) {
			var cdecl = new CCodeDeclaration (m.return_type.get_cname ());
			cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
			finishblock.add_statement (cdecl);
		}

		var datadecl = new CCodeDeclaration (dataname + "*");
		datadecl.add_declarator (new CCodeVariableDeclarator ("data"));
		finishblock.add_statement (datadecl);

		var simple_async_result_cast = new CCodeFunctionCall (new CCodeIdentifier ("G_SIMPLE_ASYNC_RESULT"));
		simple_async_result_cast.add_argument (new CCodeIdentifier ("res"));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_simple_async_result_get_op_res_gpointer"));
		ccall.add_argument (simple_async_result_cast);
		finishblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data"), ccall)));

		foreach (FormalParameter param in m.get_parameters ()) {
			if (param.direction != ParameterDirection.IN) {
				finishblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (param.name)), new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_variable_cname (param.name)))));
				finishblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_variable_cname (param.name)), new CCodeConstant ("NULL"))));
			}
		}

		if (!(return_type is VoidType)) {
			finishblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("result"), new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "result"))));
			if (return_type is ArrayType) {
				var array_type = (ArrayType) return_type;
				for (int dim = 1; dim <= array_type.rank; dim++) {
					finishblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (get_array_length_cname ("result", dim))), new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_array_length_cname ("result", dim)))));
				}
			} else if (return_type is DelegateType) {
				finishblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (get_delegate_target_cname ("result"))), new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_delegate_target_cname ("result")))));
			}
			if (!(return_type is ValueType) || return_type.nullable) {
				finishblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "result"), new CCodeConstant ("NULL"))));
			}
			finishblock.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));
		}

		cparam_map.set (get_param_pos (0.1), new CCodeFormalParameter ("res", "GAsyncResult*"));

		generate_cparameters (m, source_declarations, cparam_map, finishfunc, null, null, null, 2);

		if (m.is_private_symbol () || m.base_method != null || m.base_interface_method != null) {
			finishfunc.modifiers |= CCodeModifiers.STATIC;
		}

		finishfunc.block = finishblock;

		return finishfunc;
	}

	CCodeFunction generate_ready_function (Method m) {
		// generate ready callback handler
		var dataname = Symbol.lower_case_to_camel_case (m.get_cname ()) + "Data";

		var readyfunc = new CCodeFunction (m.get_cname () + "_ready", "void");

		readyfunc.add_parameter (new CCodeFormalParameter ("source_object", "GObject*"));
		readyfunc.add_parameter (new CCodeFormalParameter ("res", "GAsyncResult*"));
		readyfunc.add_parameter (new CCodeFormalParameter ("user_data", "gpointer"));

		var readyblock = new CCodeBlock ();

		var datadecl = new CCodeDeclaration (dataname + "*");
		datadecl.add_declarator (new CCodeVariableDeclarator ("data"));
		readyblock.add_statement (datadecl);
		readyblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data"), new CCodeIdentifier ("user_data"))));
		readyblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "res"), new CCodeIdentifier ("res"))));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_real_cname () + "_co"));
		ccall.add_argument (new CCodeIdentifier ("data"));
		readyblock.add_statement (new CCodeExpressionStatement (ccall));

		readyfunc.modifiers |= CCodeModifiers.STATIC;

		readyfunc.block = readyblock;

		return readyfunc;
	}

	public override void generate_virtual_method_declaration (Method m, CCodeDeclarationSpace decl_space, CCodeStruct type_struct) {
		if (!m.coroutine) {
			base.generate_virtual_method_declaration (m, decl_space, type_struct);
			return;
		}

		if (!m.is_abstract && !m.is_virtual) {
			return;
		}

		// add vfunc field to the type struct
		var vdeclarator = new CCodeFunctionDeclarator (m.vfunc_name);
		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		generate_cparameters (m, decl_space, cparam_map, new CCodeFunction ("fake"), vdeclarator, null, null, 1);

		var vdecl = new CCodeDeclaration ("void");
		vdecl.add_declarator (vdeclarator);
		type_struct.add_declaration (vdecl);

		// add vfunc field to the type struct
		vdeclarator = new CCodeFunctionDeclarator (m.get_finish_vfunc_name ());
		cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		generate_cparameters (m, decl_space, cparam_map, new CCodeFunction ("fake"), vdeclarator, null, null, 2);

		vdecl = new CCodeDeclaration (m.return_type.get_cname ());
		vdecl.add_declarator (vdeclarator);
		type_struct.add_declaration (vdecl);
	}

	public override void visit_yield_statement (YieldStatement stmt) {
		if (current_method == null || !current_method.coroutine) {
			stmt.ccodenode = new CCodeEmptyStatement ();
			return;
		}

		if (stmt.yield_expression == null) {
			var cfrag = new CCodeFragment ();
			stmt.ccodenode = cfrag;

			int state = next_coroutine_state++;

			cfrag.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "state"), new CCodeConstant (state.to_string ()))));
			cfrag.append (new CCodeReturnStatement (new CCodeConstant ("FALSE")));
			cfrag.append (new CCodeCaseStatement (new CCodeConstant (state.to_string ())));
			cfrag.append (new CCodeEmptyStatement ());

			return;
		}

		stmt.accept_children (codegen);

		if (stmt.yield_expression.error) {
			stmt.error = true;
			return;
		}

		stmt.ccodenode = new CCodeExpressionStatement ((CCodeExpression) stmt.yield_expression.ccodenode);

		if (stmt.tree_can_fail && stmt.yield_expression.tree_can_fail) {
			// simple case, no node breakdown necessary

			var cfrag = new CCodeFragment ();

			cfrag.append (stmt.ccodenode);

			head.add_simple_check (stmt.yield_expression, cfrag);

			stmt.ccodenode = cfrag;
		}

		/* free temporary objects */

		if (((Gee.List<LocalVariable>) temp_vars).size == 0) {
			/* nothing to do without temporary variables */
			return;
		}
		
		var cfrag = new CCodeFragment ();
		append_temp_decl (cfrag, temp_vars);
		
		cfrag.append (stmt.ccodenode);
		
		foreach (LocalVariable local in temp_ref_vars) {
			var ma = new MemberAccess.simple (local.name);
			ma.symbol_reference = local;
			cfrag.append (new CCodeExpressionStatement (get_unref_expression (new CCodeIdentifier (local.name), local.variable_type, ma)));
		}
		
		stmt.ccodenode = cfrag;
		
		temp_vars.clear ();
		temp_ref_vars.clear ();
	}

	public override CCodeStatement return_with_exception (CCodeExpression error_expr)
	{
		if (!current_method.coroutine) {
			return base.return_with_exception (error_expr);
		}

		var block = new CCodeBlock ();

		var set_error = new CCodeFunctionCall (new CCodeIdentifier ("g_simple_async_result_set_from_error"));
		set_error.add_argument (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "_async_result"));
		set_error.add_argument (error_expr);
		block.add_statement (new CCodeExpressionStatement (set_error));

		var free_error = new CCodeFunctionCall (new CCodeIdentifier ("g_error_free"));
		free_error.add_argument (error_expr);
		block.add_statement (new CCodeExpressionStatement (free_error));

		var free_locals = new CCodeFragment ();
		append_local_free (current_symbol, free_locals, false);
		block.add_statement (free_locals);

		block.add_statement (complete_async ());

		return block;
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		base.visit_return_statement (stmt);

		if (current_method == null || !current_method.coroutine) {
			return;
		}

		var cfrag = (CCodeFragment) stmt.ccodenode;

		cfrag.append (complete_async ());
	}

	public override void generate_cparameters (Method m, CCodeDeclarationSpace decl_space, Map<int,CCodeFormalParameter> cparam_map, CCodeFunction func, CCodeFunctionDeclarator? vdeclarator = null, Map<int,CCodeExpression>? carg_map = null, CCodeFunctionCall? vcall = null, int direction = 3) {
		if (m.coroutine) {
			decl_space.add_include ("gio/gio.h");

			if (direction == 1) {
				cparam_map.set (get_param_pos (-1), new CCodeFormalParameter ("callback", "GAsyncReadyCallback"));
				cparam_map.set (get_param_pos (-0.9), new CCodeFormalParameter ("user_data", "gpointer"));
				if (carg_map != null) {
					carg_map.set (get_param_pos (-1), new CCodeIdentifier ("callback"));
					carg_map.set (get_param_pos (-0.9), new CCodeIdentifier ("user_data"));
				}
			} else if (direction == 2) {
				cparam_map.set (get_param_pos (0.1), new CCodeFormalParameter ("res", "GAsyncResult*"));
				if (carg_map != null) {
					carg_map.set (get_param_pos (0.1), new CCodeIdentifier ("res"));
				}
			}
		}
		base.generate_cparameters (m, decl_space, cparam_map, func, vdeclarator, carg_map, vcall, direction);
	}
}

// vim:sw=8 noet
