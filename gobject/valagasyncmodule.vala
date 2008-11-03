/* valagasyncmodule.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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

public class Vala.GAsyncModule : GSignalModule {
	public GAsyncModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override void visit_method (Method m) {
		base.visit_method (m);

		if (!m.coroutine) {
			return;
		}

		var creturn_type = m.return_type;
		bool visible = !m.is_internal_symbol ();

		gio_h_needed = true;

		// generate struct to hold parameters, local variables, and the return value
		string dataname = Symbol.lower_case_to_camel_case (m.get_cname ()) + "Data";
		var datastruct = new CCodeStruct ("_" + dataname);

		datastruct.add_field ("int", "state");
		datastruct.add_field ("GAsyncReadyCallback", "callback");
		datastruct.add_field ("gpointer", "user_data");
		datastruct.add_field ("GAsyncResult*", "res");

		foreach (FormalParameter param in m.get_parameters ()) {
			datastruct.add_field (param.parameter_type.get_cname (), param.name);
		}

		if (!(m.return_type is VoidType)) {
			datastruct.add_field (m.return_type.get_cname (), "result");
		}

		source_type_definition.append (datastruct);
		source_type_declaration.append (new CCodeTypeDefinition ("struct _" + dataname, new CCodeVariableDeclarator (dataname)));

		// generate async function
		var asyncfunc = new CCodeFunction (m.get_cname (), "void");
		asyncfunc.line = function.line;

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		var asyncblock = new CCodeBlock ();

		var dataalloc = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_new0"));
		dataalloc.add_argument (new CCodeIdentifier (dataname));

		var datadecl = new CCodeDeclaration (dataname + "*");
		datadecl.add_declarator (new CCodeVariableDeclarator ("data"));
		asyncblock.add_statement (datadecl);
		asyncblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data"), dataalloc)));

		asyncblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "callback"), new CCodeIdentifier ("callback"))));
		asyncblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "user_data"), new CCodeIdentifier ("user_data"))));

		foreach (FormalParameter param in m.get_parameters ()) {
			asyncblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), param.name), new CCodeIdentifier (param.name))));
		}

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_real_cname ()));
		ccall.add_argument (new CCodeIdentifier ("data"));
		asyncblock.add_statement (new CCodeExpressionStatement (ccall));

		cparam_map.set (get_param_pos (-1), new CCodeFormalParameter ("callback", "GAsyncReadyCallback"));
		cparam_map.set (get_param_pos (-0.9), new CCodeFormalParameter ("user_data", "gpointer"));

		generate_cparameters (m, creturn_type, false, cparam_map, asyncfunc, null, null, null, 1);

		if (visible) {
			header_type_member_declaration.append (asyncfunc.copy ());
		} else {
			asyncfunc.modifiers |= CCodeModifiers.STATIC;
			source_type_member_declaration.append (asyncfunc.copy ());
		}
		
		asyncfunc.block = asyncblock;

		source_type_member_definition.append (asyncfunc);

		// generate finish function
		var finishfunc = new CCodeFunction (m.get_cname () + "_finish", creturn_type.get_cname ());
		finishfunc.line = function.line;

		cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		var finishblock = new CCodeBlock ();

		cparam_map.set (get_param_pos (0.1), new CCodeFormalParameter ("res", "GAsyncResult*"));

		generate_cparameters (m, creturn_type, false, cparam_map, finishfunc, null, null, null, 2);

		if (visible) {
			header_type_member_declaration.append (finishfunc.copy ());
		} else {
			finishfunc.modifiers |= CCodeModifiers.STATIC;
			source_type_member_declaration.append (finishfunc.copy ());
		}
		
		finishfunc.block = finishblock;

		source_type_member_definition.append (finishfunc);

		// generate ready callback handler
		var readyfunc = new CCodeFunction (m.get_cname () + "_ready", "void");
		readyfunc.line = function.line;

		readyfunc.add_parameter (new CCodeFormalParameter ("source_object", "GObject*"));
		readyfunc.add_parameter (new CCodeFormalParameter ("res", "GAsyncResult*"));
		readyfunc.add_parameter (new CCodeFormalParameter ("user_data", "gpointer"));

		var readyblock = new CCodeBlock ();

		datadecl = new CCodeDeclaration (dataname + "*");
		datadecl.add_declarator (new CCodeVariableDeclarator ("data"));
		readyblock.add_statement (datadecl);
		readyblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("data"), new CCodeIdentifier ("user_data"))));
		readyblock.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "res"), new CCodeIdentifier ("res"))));

		ccall = new CCodeFunctionCall (new CCodeIdentifier (m.get_real_cname ()));
		ccall.add_argument (new CCodeIdentifier ("data"));
		readyblock.add_statement (new CCodeExpressionStatement (ccall));

		readyfunc.modifiers |= CCodeModifiers.STATIC;
		source_type_member_declaration.append (readyfunc.copy ());

		readyfunc.block = readyblock;

		source_type_member_definition.append (readyfunc);
	}

	public override void visit_yield_statement (YieldStatement stmt) {
		if (stmt.yield_expression == null) {
			var cfrag = new CCodeFragment ();
			stmt.ccodenode = cfrag;

			var idle_call = new CCodeFunctionCall (new CCodeIdentifier ("g_idle_add"));
			idle_call.add_argument (new CCodeCastExpression (new CCodeIdentifier (current_method.get_real_cname ()), "GSourceFunc"));
			idle_call.add_argument (new CCodeIdentifier ("data"));

			int state = next_coroutine_state++;

			cfrag.append (new CCodeExpressionStatement (idle_call));
			cfrag.append (new CCodeExpressionStatement (new CCodeAssignment (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "state"), new CCodeConstant (state.to_string ()))));
			cfrag.append (new CCodeReturnStatement (new CCodeConstant ("FALSE")));
			cfrag.append (new CCodeCaseStatement (new CCodeConstant (state.to_string ())));

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
}
