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

		codegen.gio_h_needed = true;

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

		codegen.source_type_definition.append (datastruct);
		codegen.source_type_declaration.append (new CCodeTypeDefinition ("struct _" + dataname, new CCodeVariableDeclarator (dataname)));

		// generate async function
		var asyncfunc = new CCodeFunction (m.get_cname (), "void");
		asyncfunc.line = codegen.function.line;

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

		cparam_map.set (codegen.get_param_pos (-1), new CCodeFormalParameter ("callback", "GAsyncReadyCallback"));
		cparam_map.set (codegen.get_param_pos (-0.9), new CCodeFormalParameter ("user_data", "gpointer"));

		generate_cparameters (m, creturn_type, false, cparam_map, asyncfunc, null, null, null, 1);

		if (visible) {
			codegen.header_type_member_declaration.append (asyncfunc.copy ());
		} else {
			asyncfunc.modifiers |= CCodeModifiers.STATIC;
			codegen.source_type_member_declaration.append (asyncfunc.copy ());
		}
		
		asyncfunc.block = asyncblock;

		codegen.source_type_member_definition.append (asyncfunc);

		// generate finish function
		var finishfunc = new CCodeFunction (m.get_cname () + "_finish", creturn_type.get_cname ());
		finishfunc.line = codegen.function.line;

		cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		var finishblock = new CCodeBlock ();

		cparam_map.set (codegen.get_param_pos (0.1), new CCodeFormalParameter ("res", "GAsyncResult*"));

		generate_cparameters (m, creturn_type, false, cparam_map, finishfunc, null, null, null, 2);

		if (visible) {
			codegen.header_type_member_declaration.append (finishfunc.copy ());
		} else {
			finishfunc.modifiers |= CCodeModifiers.STATIC;
			codegen.source_type_member_declaration.append (finishfunc.copy ());
		}
		
		finishfunc.block = finishblock;

		codegen.source_type_member_definition.append (finishfunc);

		// generate ready callback handler
		var readyfunc = new CCodeFunction (m.get_cname () + "_ready", "void");
		readyfunc.line = codegen.function.line;

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
		codegen.source_type_member_declaration.append (readyfunc.copy ());

		readyfunc.block = readyblock;

		codegen.source_type_member_definition.append (readyfunc);
	}
}
