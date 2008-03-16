/* valaccodegeneratormethod.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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
using Gee;

public class Vala.CCodeGenerator {
	public override void visit_method (Method! m) {
		Method old_method = current_method;
		DataType old_return_type = current_return_type;
		bool old_method_inner_error = current_method_inner_error;
		int old_next_temp_var_id = next_temp_var_id;
		current_symbol = m;
		current_method = m;
		current_return_type = m.return_type;
		current_method_inner_error = false;
		next_temp_var_id = 0;

		bool in_gtypeinstance_creation_method = false;
		bool in_gobject_creation_method = false;
		bool in_fundamental_creation_method = false;

		var creturn_type = current_return_type;

		if (m is CreationMethod) {
			in_creation_method = true;
			var cl = current_type_symbol as Class;
			if (cl != null && cl.is_subtype_of (gtypeinstance_type)) {
				in_gtypeinstance_creation_method = true;
				if (cl.base_class == gtypeinstance_type) {
					in_fundamental_creation_method = true;
				} else if (cl.is_subtype_of (gobject_type)) {
					in_gobject_creation_method = true;
				}
			}

			if (cl != null) {
				creturn_type = new ClassType (cl);
			}
		}

		m.accept_children (this);

		if (m is CreationMethod) {
			if (in_gobject_creation_method && m.body != null) {
				var cblock = new CCodeBlock ();
				
				foreach (CodeNode stmt in m.body.get_statements ()) {
					if (((ExpressionStatement) stmt).assigned_property ().set_accessor.construction) {
						if (stmt.ccodenode is CCodeFragment) {
							foreach (CCodeNode cstmt in ((CCodeFragment) stmt.ccodenode).get_children ()) {
								cblock.add_statement (cstmt);
							}
						} else {
							cblock.add_statement (stmt.ccodenode);
						}
					}
				}

				add_object_creation (cblock, ((CreationMethod) m).n_construction_params > 0);
				
				foreach (CodeNode stmt in m.body.get_statements ()) {
					if (!((ExpressionStatement) stmt).assigned_property ().set_accessor.construction) {
						if (stmt.ccodenode is CCodeFragment) {
							foreach (CCodeNode cstmt in ((CCodeFragment) stmt.ccodenode).get_children ()) {
								cblock.add_statement (cstmt);
							}
						} else {
							cblock.add_statement (stmt.ccodenode);
						}
					}
				}
				
				m.body.ccodenode = cblock;
			}

			in_creation_method = false;
		}

		bool inner_error = current_method_inner_error;

		current_symbol = current_symbol.parent_symbol;
		current_method = current_method;
		current_return_type = old_return_type;
		current_method_inner_error = old_method_inner_error;
		next_temp_var_id = old_next_temp_var_id;

		if (current_type_symbol != null && current_type_symbol is Interface) {
			var iface = (Interface) current_type_symbol;
			if (iface.is_static) {
				return;
			}
		}

		function = new CCodeFunction (m.get_real_cname (), creturn_type.get_cname ());
		m.ccodenode = function;

		if (m.is_inline) {
			function.modifiers |= CCodeModifiers.INLINE;
		}

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		CCodeFunctionDeclarator vdeclarator = null;

		if (m.instance || (m.parent_symbol is Struct && m is CreationMethod)) {
			Typesymbol parent_type = find_parent_type (m);
			DataType this_type;
			if (parent_type is Class) {
				this_type = new ClassType ((Class) parent_type);
			} else if (parent_type is Interface) {
				this_type = new InterfaceType ((Interface) parent_type);
			} else {
				this_type = new ValueType (parent_type);
			}

			CCodeFormalParameter instance_param = null;
			if (m.base_interface_method != null && !m.is_abstract && !m.is_virtual) {
				var base_type = new InterfaceType ((Interface) m.base_interface_method.parent_symbol);
				instance_param = new CCodeFormalParameter ("base", base_type.get_cname ());
			} else if (m.overrides) {
				var base_type = new ClassType ((Class) m.base_method.parent_symbol);
				instance_param = new CCodeFormalParameter ("base", base_type.get_cname ());
			} else {
				if (m.parent_symbol is Struct && !((Struct) m.parent_symbol).is_simple_type ()) {
					instance_param = new CCodeFormalParameter ("*self", this_type.get_cname ());
				} else {
					instance_param = new CCodeFormalParameter ("self", this_type.get_cname ());
				}
			}
			cparam_map.set (get_param_pos (m.cinstance_parameter_position), instance_param);

			if (m.is_abstract || m.is_virtual) {
				var vdecl = new CCodeDeclaration (creturn_type.get_cname ());
				vdeclarator = new CCodeFunctionDeclarator (m.vfunc_name);
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);
			}
		}

		if (in_fundamental_creation_method) {
			cparam_map.set (get_param_pos (0.1), new CCodeFormalParameter ("type", "GType"));
		}

		if (in_gobject_creation_method) {
			// memory management for generic types
			int type_param_index = 0;
			foreach (TypeParameter type_param in current_class.get_type_parameters ()) {
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "GType"));
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeFormalParameter ("%s_dup_func".printf (type_param.name.down ()), "GBoxedCopyFunc"));
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeFormalParameter ("%s_destroy_func".printf (type_param.name.down ()), "GDestroyNotify"));
				type_param_index++;
			}
		}

		var params = m.get_parameters ();
		foreach (FormalParameter param in params) {
			if (!param.no_array_length && param.type_reference is ArrayType) {
				var array_type = (ArrayType) param.type_reference;
				
				var length_ctype = "int";
				if (param.type_reference.is_out || param.type_reference.is_ref) {
					length_ctype = "int*";
				}
				
				for (int dim = 1; dim <= array_type.rank; dim++) {
					var cparam = new CCodeFormalParameter (get_array_length_cname (param.name, dim), length_ctype);
					cparam_map.set (get_param_pos (param.carray_length_parameter_position + 0.01 * dim), cparam);
				}
			}

			cparam_map.set (get_param_pos (param.cparameter_position), (CCodeFormalParameter) param.ccodenode);

			if (param.type_reference is DelegateType) {
				var deleg_type = (DelegateType) param.type_reference;
				var d = deleg_type.delegate_symbol;
				if (d.instance) {
					var cparam = new CCodeFormalParameter (get_delegate_target_cname (param.name), "void*");
					cparam_map.set (get_param_pos (param.cdelegate_target_parameter_position), cparam);
				}
			}
		}

		if (!m.no_array_length && creturn_type is ArrayType) {
			// return array length if appropriate
			var array_type = (ArrayType) creturn_type;

			for (int dim = 1; dim <= array_type.rank; dim++) {
				var cparam = new CCodeFormalParameter (get_array_length_cname ("result", dim), "int*");
				cparam_map.set (get_param_pos (m.carray_length_parameter_position + 0.01 * dim), cparam);
			}
		} else if (creturn_type is DelegateType) {
			// return delegate target if appropriate
			var deleg_type = (DelegateType) creturn_type;
			var d = deleg_type.delegate_symbol;
			if (d.instance) {
				var cparam = new CCodeFormalParameter (get_delegate_target_cname ("result"), "void*");
				cparam_map.set (get_param_pos (m.cdelegate_target_parameter_position), cparam);
			}
		}

		if (m.get_error_domains ().size > 0) {
			var cparam = new CCodeFormalParameter ("error", "GError**");
			cparam_map.set (get_param_pos (-1), cparam);
		}

		// append C parameters in the right order
		int last_pos = -1;
		int min_pos;
		while (true) {
			min_pos = -1;
			foreach (int pos in cparam_map.get_keys ()) {
				if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
					min_pos = pos;
				}
			}
			if (min_pos == -1) {
				break;
			}
			function.add_parameter (cparam_map.get (min_pos));
			if (vdeclarator != null) {
				vdeclarator.add_parameter (cparam_map.get (min_pos));
			}
			last_pos = min_pos;
		}

		bool visible = !m.is_internal_symbol ();

		/* real function declaration and definition not needed
		 * for abstract methods */
		if (!m.is_abstract) {
			if (visible && m.base_method == null && m.base_interface_method == null) {
				/* public methods need function declaration in
				 * header file except virtual/overridden methods */
				header_type_member_declaration.append (function.copy ());
			} else {
				/* declare all other functions in source file to
				 * avoid dependency on order within source file */
				function.modifiers |= CCodeModifiers.STATIC;
				source_type_member_declaration.append (function.copy ());
			}
			
			/* Methods imported from a plain C file don't
			 * have a body, e.g. Vala.Parser.parse_file () */
			if (m.body != null) {
				function.block = (CCodeBlock) m.body.ccodenode;
				function.block.line = function.line;

				var cinit = new CCodeFragment ();
				function.block.prepend_statement (cinit);

				if (m.parent_symbol is Class) {
					var cl = (Class) m.parent_symbol;
					if (m.overrides || (m.base_interface_method != null && !m.is_abstract && !m.is_virtual)) {
						Method base_method;
						ReferenceType base_expression_type;
						if (m.overrides) {
							base_method = m.base_method;
							base_expression_type = new ClassType ((Class) base_method.parent_symbol);
						} else {
							base_method = m.base_interface_method;
							base_expression_type = new InterfaceType ((Interface) base_method.parent_symbol);
						}
						var self_target_type = new ClassType (cl);
						CCodeExpression cself = get_implicit_cast_expression (new CCodeIdentifier ("base"), base_expression_type, self_target_type);

						var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
						cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", cself));
						
						cinit.append (cdecl);
					} else if (m.instance) {
						var ccheckstmt = create_method_type_check_statement (m, creturn_type, cl, true, "self");
						ccheckstmt.line = function.line;
						cinit.append (ccheckstmt);
					}
				}
				foreach (FormalParameter param in m.get_parameters ()) {
					if (param.ellipsis) {
						break;
					}

					var t = param.type_reference.data_type;
					if (t != null && t.is_reference_type ()) {
						if (!param.type_reference.is_out) {
							var type_check = create_method_type_check_statement (m, creturn_type, t, (context.non_null && !param.type_reference.nullable), param.name);
							if (type_check != null) {
								type_check.line = function.line;
								cinit.append (type_check);
							}
						} else {
							// ensure that the passed reference for output parameter is cleared
							var a = new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier (param.name)), new CCodeConstant ("NULL"));
							cinit.append (new CCodeExpressionStatement (a));
						}
					}
				}

				if (inner_error) {
					/* always separate error parameter and inner_error local variable
					 * as error may be set to NULL but we're always interested in inner errors
					 */
					var cdecl = new CCodeDeclaration ("GError *");
					cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("inner_error", new CCodeConstant ("NULL")));
					cinit.append (cdecl);
				}

				if (m.source_reference != null && m.source_reference.comment != null) {
					source_type_member_definition.append (new CCodeComment (m.source_reference.comment));
				}
				source_type_member_definition.append (function);
				
				if (m is CreationMethod) {
					if (in_gobject_creation_method) {
						int n_params = ((CreationMethod) m).n_construction_params;

						if (n_params > 0) {
							// declare construction parameter array
							var cparamsinit = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
							cparamsinit.add_argument (new CCodeIdentifier ("GParameter"));
							cparamsinit.add_argument (new CCodeConstant (n_params.to_string ()));
							
							var cdecl = new CCodeDeclaration ("GParameter *");
							cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("__params", cparamsinit));
							cinit.append (cdecl);
							
							cdecl = new CCodeDeclaration ("GParameter *");
							cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("__params_it", new CCodeIdentifier ("__params")));
							cinit.append (cdecl);
						}

						/* type, dup func, and destroy func properties for generic types */
						foreach (TypeParameter type_param in current_class.get_type_parameters ()) {
							string func_name;
							CCodeMemberAccess cmember;
							CCodeAssignment cassign;

							func_name = "%s_type".printf (type_param.name.down ());
							cmember = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
							cassign = new CCodeAssignment (cmember, new CCodeIdentifier (func_name));
							function.block.add_statement (new CCodeExpressionStatement (cassign));

							func_name = "%s_dup_func".printf (type_param.name.down ());
							cmember = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
							cassign = new CCodeAssignment (cmember, new CCodeIdentifier (func_name));
							function.block.add_statement (new CCodeExpressionStatement (cassign));

							func_name = "%s_destroy_func".printf (type_param.name.down ());
							cmember = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
							cassign = new CCodeAssignment (cmember, new CCodeIdentifier (func_name));
							function.block.add_statement (new CCodeExpressionStatement (cassign));
						}
					} else if (in_fundamental_creation_method) {
						var cl = (Class) m.parent_symbol;
						var cdecl = new CCodeDeclaration (cl.get_cname () + "*");
						var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_create_instance"));
						ccall.add_argument (new CCodeIdentifier ("type"));
						cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", new CCodeCastExpression (ccall, cl.get_cname () + "*")));
						cinit.append (cdecl);
					} else if (in_gtypeinstance_creation_method) {
						var cl = (Class) m.parent_symbol;
						var cdecl = new CCodeDeclaration (cl.get_cname () + "*");
						var fundamental_class = find_fundamental_class (cl);
						var ccall = new CCodeFunctionCall (new CCodeIdentifier (fundamental_class.default_construction_method.get_cname ()));
						ccall.add_argument (new CCodeIdentifier (cl.get_type_id ()));
						cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
						cinit.append (cdecl);
					} else if (current_type_symbol is Class) {
						var cl = (Class) m.parent_symbol;
						var cdecl = new CCodeDeclaration (cl.get_cname () + "*");
						var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_new0"));
						ccall.add_argument (new CCodeIdentifier (cl.get_cname ()));
						cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
						cinit.append (cdecl);
					} else {
						var st = (Struct) m.parent_symbol;

						// memset needs string.h
						string_h_needed = true;
						var czero = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
						czero.add_argument (new CCodeIdentifier ("self"));
						czero.add_argument (new CCodeConstant ("0"));
						czero.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (st.get_cname ())));
						cinit.append (new CCodeExpressionStatement (czero));
					}
				}

				if (context.module_init_method == m && in_plugin) {
					// GTypeModule-based plug-in, register types
					cinit.append (module_init_fragment);
				}

				foreach (Expression precondition in m.get_preconditions ()) {
					cinit.append (create_precondition_statement (m, creturn_type, precondition));
				}
			}
		}
		
		if (m.is_abstract || m.is_virtual) {
			var vfunc = new CCodeFunction (m.get_cname (), creturn_type.get_cname ());
			vfunc.line = function.line;

			ReferenceType this_type;
			if (m.parent_symbol is Class) {
				this_type = new ClassType ((Class) m.parent_symbol);
			} else {
				this_type = new InterfaceType ((Interface) m.parent_symbol);
			}

			cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);
			var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

			var cparam = new CCodeFormalParameter ("self", this_type.get_cname ());
			cparam_map.set (get_param_pos (m.cinstance_parameter_position), cparam);
			
			var vblock = new CCodeBlock ();

			foreach (Expression precondition in m.get_preconditions ()) {
				vblock.add_statement (create_precondition_statement (m, creturn_type, precondition));
			}

			CCodeFunctionCall vcast = null;
			if (m.parent_symbol is Interface) {
				var iface = (Interface) m.parent_symbol;

				vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_INTERFACE".printf (iface.get_upper_case_cname (null))));
			} else {
				var cl = (Class) m.parent_symbol;

				vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS".printf (cl.get_upper_case_cname (null))));
			}
			vcast.add_argument (new CCodeIdentifier ("self"));
		
			var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, m.vfunc_name));
			carg_map.set (get_param_pos (m.cinstance_parameter_position), new CCodeIdentifier ("self"));
		
			var params = m.get_parameters ();
			foreach (FormalParameter param in params) {
				if (!param.no_array_length && param.type_reference is ArrayType) {
					var array_type = (ArrayType) param.type_reference;
					
					var length_ctype = "int";
					if (param.type_reference.is_out || param.type_reference.is_ref) {
						length_ctype = "int*";
					}
					
					for (int dim = 1; dim <= array_type.rank; dim++) {
						var cparam = new CCodeFormalParameter (get_array_length_cname (param.name, dim), length_ctype);
						cparam_map.set (get_param_pos (param.carray_length_parameter_position + 0.01 * dim), cparam);
						carg_map.set (get_param_pos (param.carray_length_parameter_position + 0.01 * dim), new CCodeIdentifier (cparam.name));
					}
				}

				cparam_map.set (get_param_pos (param.cparameter_position), (CCodeFormalParameter) param.ccodenode);
				carg_map.set (get_param_pos (param.cparameter_position), new CCodeIdentifier (param.name));

				if (param.type_reference is DelegateType) {
					var deleg_type = (DelegateType) param.type_reference;
					var d = deleg_type.delegate_symbol;
					if (d.instance) {
						var cparam = new CCodeFormalParameter (get_delegate_target_cname (param.name), "void*");
						cparam_map.set (get_param_pos (param.cdelegate_target_parameter_position), cparam);
						carg_map.set (get_param_pos (param.cdelegate_target_parameter_position), new CCodeIdentifier (cparam.name));
					}
				}
			}

			// return array length if appropriate
			if (!m.no_array_length && creturn_type is ArrayType) {
				var array_type = (ArrayType) creturn_type;

				for (int dim = 1; dim <= array_type.rank; dim++) {
					var cparam = new CCodeFormalParameter (get_array_length_cname ("result", dim), "int*");
					cparam_map.set (get_param_pos (m.carray_length_parameter_position), cparam);
					carg_map.set (get_param_pos (m.carray_length_parameter_position), new CCodeIdentifier (cparam.name));
				}
			} else if (creturn_type is DelegateType) {
				// return delegate target if appropriate
				var deleg_type = (DelegateType) creturn_type;
				var d = deleg_type.delegate_symbol;
				if (d.instance) {
					var cparam = new CCodeFormalParameter (get_delegate_target_cname ("result"), "void*");
					cparam_map.set (get_param_pos (m.cdelegate_target_parameter_position), cparam);
					carg_map.set (get_param_pos (m.cdelegate_target_parameter_position), new CCodeIdentifier (cparam.name));
				}
			}

			if (m.get_error_domains ().size > 0) {
				var cparam = new CCodeFormalParameter ("error", "GError**");
				cparam_map.set (get_param_pos (-1), cparam);
				carg_map.set (get_param_pos (-1), new CCodeIdentifier (cparam.name));
			}


			// append C parameters and arguments in the right order
			int last_pos = -1;
			int min_pos;
			while (true) {
				min_pos = -1;
				foreach (int pos in cparam_map.get_keys ()) {
					if (pos > last_pos && (min_pos == -1 || pos < min_pos)) {
						min_pos = pos;
					}
				}
				if (min_pos == -1) {
					break;
				}
				vfunc.add_parameter (cparam_map.get (min_pos));
				vcall.add_argument (carg_map.get (min_pos));
				last_pos = min_pos;
			}

			CCodeStatement cstmt;
			if (creturn_type is VoidType) {
				cstmt = new CCodeExpressionStatement (vcall);
			} else if (m.get_postconditions ().size == 0) {
				/* pass method return value */
				cstmt = new CCodeReturnStatement (vcall);
			} else {
				/* store method return value for postconditions */
				var cdecl = new CCodeDeclaration (creturn_type.get_cname ());
				cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("result", vcall));
				cstmt = cdecl;
			}
			cstmt.line = vfunc.line;
			vblock.add_statement (cstmt);

			if (m.get_postconditions ().size > 0) {
				foreach (Expression postcondition in m.get_postconditions ()) {
					vblock.add_statement (create_postcondition_statement (postcondition));
				}

				if (!(creturn_type is VoidType)) {
					var cret_stmt = new CCodeReturnStatement (new CCodeIdentifier ("result"));
					cret_stmt.line = vfunc.line;
					vblock.add_statement (cret_stmt);
				}
			}

			if (visible) {
				header_type_member_declaration.append (vfunc.copy ());
			} else {
				vfunc.modifiers |= CCodeModifiers.STATIC;
				source_type_member_declaration.append (vfunc.copy ());
			}
			
			vfunc.block = vblock;

			if (m.is_abstract && m.source_reference != null && m.source_reference.comment != null) {
				source_type_member_definition.append (new CCodeComment (m.source_reference.comment));
			}
			source_type_member_definition.append (vfunc);
		}
		
		if (m is CreationMethod) {
			if (((CreationMethod) m).n_construction_params > 0) {
				var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.GREATER_THAN, new CCodeIdentifier ("__params_it"), new CCodeIdentifier ("__params"));
				var cdofreeparam = new CCodeBlock ();
				cdofreeparam.add_statement (new CCodeExpressionStatement (new CCodeUnaryExpression (CCodeUnaryOperator.PREFIX_DECREMENT, new CCodeIdentifier ("__params_it"))));
				var cunsetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_unset"));
				cunsetcall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess.pointer (new CCodeIdentifier ("__params_it"), "value")));
				cdofreeparam.add_statement (new CCodeExpressionStatement (cunsetcall));
				function.block.add_statement (new CCodeWhileStatement (ccond, cdofreeparam));

				var cfreeparams = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
				cfreeparams.add_argument (new CCodeIdentifier ("__params"));
				function.block.add_statement (new CCodeExpressionStatement (cfreeparams));
			}

			if (current_type_symbol is Class) {
				var creturn = new CCodeReturnStatement ();
				creturn.return_expression = new CCodeIdentifier ("self");
				function.block.add_statement (creturn);
			}
		}
		
		bool return_value = true;
		bool args_parameter = true;
		if (is_possible_entry_point (m, ref return_value, ref args_parameter)) {
			// m is possible entry point, add appropriate startup code
			var cmain = new CCodeFunction ("main", "int");
			cmain.line = function.line;
			cmain.add_parameter (new CCodeFormalParameter ("argc", "int"));
			cmain.add_parameter (new CCodeFormalParameter ("argv", "char **"));
			var main_block = new CCodeBlock ();

			if (context.thread) {
				var thread_init_call = new CCodeFunctionCall (new CCodeIdentifier ("g_thread_init"));
				thread_init_call.line = cmain.line;
				thread_init_call.add_argument (new CCodeConstant ("NULL"));
				main_block.add_statement (new CCodeExpressionStatement (thread_init_call)); 
			}

			var type_init_call = new CCodeExpressionStatement (new CCodeFunctionCall (new CCodeIdentifier ("g_type_init")));
			type_init_call.line = cmain.line;
			main_block.add_statement (type_init_call);

			var main_call = new CCodeFunctionCall (new CCodeIdentifier (function.name));
			if (args_parameter) {
				main_call.add_argument (new CCodeIdentifier ("argv"));
				main_call.add_argument (new CCodeIdentifier ("argc"));
			}
			if (return_value) {
				var main_stmt = new CCodeReturnStatement (main_call);
				main_stmt.line = cmain.line;
				main_block.add_statement (main_stmt);
			} else {
				// method returns void, always use 0 as exit code
				var main_stmt = new CCodeExpressionStatement (main_call);
				main_stmt.line = cmain.line;
				main_block.add_statement (main_stmt);
				var ret_stmt = new CCodeReturnStatement (new CCodeConstant ("0"));
				ret_stmt.line = cmain.line;
				main_block.add_statement (ret_stmt);
			}
			cmain.block = main_block;
			source_type_member_definition.append (cmain);
		}
	}
	
	private CCodeStatement create_method_type_check_statement (Method! m, DataType! return_type, Typesymbol! t, bool non_null, string! var_name) {
		return create_type_check_statement (m, return_type, t, non_null, var_name);
	}
	
	private CCodeStatement create_property_type_check_statement (Property! prop, bool check_return_type, Typesymbol! t, bool non_null, string! var_name) {
		if (check_return_type) {
			return create_type_check_statement (prop, prop.type_reference, t, non_null, var_name);
		} else {
			return create_type_check_statement (prop, new VoidType (), t, non_null, var_name);
		}
	}

	private CCodeStatement create_type_check_statement (CodeNode! method_node, DataType ret_type, Typesymbol! t, bool non_null, string! var_name) {
		var ccheck = new CCodeFunctionCall ();
		
		if ((t is Class && ((Class) t).is_subtype_of (gobject_type)) || (t is Interface && !((Interface) t).declaration_only)) {
			var ctype_check = new CCodeFunctionCall (new CCodeIdentifier (t.get_upper_case_cname ("IS_")));
			ctype_check.add_argument (new CCodeIdentifier (var_name));
			
			CCodeExpression cexpr = ctype_check;
			if (!non_null) {
				var cnull = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier (var_name), new CCodeConstant ("NULL"));
			
				cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.OR, cnull, ctype_check);
			}
			ccheck.add_argument (cexpr);
		} else if (!non_null) {
			return null;
		} else {
			var cnonnull = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier (var_name), new CCodeConstant ("NULL"));
			ccheck.add_argument (cnonnull);
		}
		
		if (ret_type is VoidType) {
			/* void function */
			ccheck.call = new CCodeIdentifier ("g_return_if_fail");
		} else {
			ccheck.call = new CCodeIdentifier ("g_return_val_if_fail");

			var cdefault = default_value_for_type (ret_type);
			if (cdefault != null) {
				ccheck.add_argument (cdefault);
			} else {
				Report.warning (method_node.source_reference, "not supported return type for runtime type checks");
				return new CCodeExpressionStatement (new CCodeConstant ("0"));
			}
		}
		
		return new CCodeExpressionStatement (ccheck);
	}

	private CCodeStatement create_precondition_statement (CodeNode! method_node, DataType ret_type, Expression precondition) {
		var ccheck = new CCodeFunctionCall ();

		ccheck.add_argument ((CCodeExpression) precondition.ccodenode);

		if (ret_type is VoidType) {
			/* void function */
			ccheck.call = new CCodeIdentifier ("g_return_if_fail");
		} else {
			ccheck.call = new CCodeIdentifier ("g_return_val_if_fail");

			var cdefault = default_value_for_type (ret_type);
			if (cdefault != null) {
				ccheck.add_argument (cdefault);
			} else {
				Report.warning (method_node.source_reference, "not supported return type for runtime type checks");
				return new CCodeExpressionStatement (new CCodeConstant ("0"));
			}
		}
		
		return new CCodeExpressionStatement (ccheck);
	}

	private CCodeStatement create_postcondition_statement (Expression postcondition) {
		var cassert = new CCodeFunctionCall (new CCodeIdentifier ("g_assert"));

		cassert.add_argument ((CCodeExpression) postcondition.ccodenode);

		return new CCodeExpressionStatement (cassert);
	}

	private CCodeExpression default_value_for_type (DataType! type) {
		if ((type.data_type != null && type.data_type.is_reference_type ()) || type is PointerType || type is ArrayType) {
			return new CCodeConstant ("NULL");
		} else if (type.data_type != null && type.data_type.get_default_value () != null) {
			return new CCodeConstant (type.data_type.get_default_value ());
		} else if (type.data_type is Struct) {
			// 0-initialize struct with struct initializer { 0 }
			var clist = new CCodeInitializerList ();
			clist.append (new CCodeConstant ("0"));
			return clist;
		} else if (type.type_parameter != null) {
			return new CCodeConstant ("NULL");
		} else if (type is ErrorType) {
			return new CCodeConstant ("NULL");
		}
		return null;
	}

	private Typesymbol find_parent_type (Symbol sym) {
		while (sym != null) {
			if (sym is Typesymbol) {
				return (Typesymbol) sym;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}

	public override void visit_creation_method (CreationMethod! m) {
		if (m.body != null && current_type_symbol is Class && current_class.is_subtype_of (gobject_type)) {
			int n_params = 0;
			foreach (Statement stmt in m.body.get_statements ()) {
				if (!(stmt is ExpressionStatement) || ((ExpressionStatement) stmt).assigned_property () == null) {
					m.error = true;
					Report.error (stmt.source_reference, "class creation methods only allow property assignment statements");
					return;
				}
				if (((ExpressionStatement) stmt).assigned_property ().set_accessor.construction) {
					n_params++;
				}
			}
			m.n_construction_params = n_params;
		}

		visit_method (m);
	}
	
	private bool is_possible_entry_point (Method! m, ref bool return_value, ref bool args_parameter) {
		if (m.name == null || m.name != "main") {
			// method must be called "main"
			return false;
		}
		
		if (m.instance) {
			// method must be static
			return false;
		}
		
		if (m.return_type.data_type == null) {
			return_value = false;
		} else if (m.return_type.data_type == int_type.data_type) {
			return_value = true;
		} else {
			// return type must be void or int
			return false;
		}
		
		var params = m.get_parameters ();
		if (params.size == 0) {
			// method may have no parameters
			args_parameter = false;
			return true;
		}

		if (params.size > 1) {
			// method must not have more than one parameter
			return false;
		}
		
		Iterator<FormalParameter> params_it = params.iterator ();
		params_it.next ();
		var param = params_it.get ();

		if (param.type_reference.is_out) {
			// parameter must not be an out parameter
			return false;
		}
		
		if (!(param.type_reference is ArrayType)) {
			// parameter must be an array
			return false;
		}
		
		var array_type = (ArrayType) param.type_reference;
		if (array_type.element_type.data_type != string_type.data_type) {
			// parameter must be an array of strings
			return false;
		}
		
		args_parameter = true;
		return true;
	}

	private void add_object_creation (CCodeBlock! b, bool has_params) {
		var cl = (Class) current_type_symbol;
	
		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_newv"));
		ccall.add_argument (new CCodeConstant (cl.get_type_id ()));
		if (has_params) {
			ccall.add_argument (new CCodeConstant ("__params_it - __params"));
			ccall.add_argument (new CCodeConstant ("__params"));
		} else {
			ccall.add_argument (new CCodeConstant ("0"));
			ccall.add_argument (new CCodeConstant ("NULL"));
		}
		
		var cdecl = new CCodeVariableDeclarator ("self");
		cdecl.initializer = ccall;
		
		var cdeclaration = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdeclaration.add_declarator (cdecl);
		
		b.add_statement (cdeclaration);
	}

	private Class find_fundamental_class (Class! cl) {
		var fundamental_class = cl;
		while (fundamental_class != null && fundamental_class.base_class != gtypeinstance_type) {
			fundamental_class = fundamental_class.base_class;
		}
		return fundamental_class;
	}
}

