/* valaccodemethodmodule.vala
 *
 * Copyright (C) 2007-2009  Jürg Billeter
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

/**
 * The link between a method and generated code.
 */
internal class Vala.CCodeMethodModule : CCodeStructModule {
	public CCodeMethodModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override bool method_has_wrapper (Method method) {
		return (method.get_attribute ("NoWrapper") == null);
	}

	public override string? get_custom_creturn_type (Method m) {
		var attr = m.get_attribute ("CCode");
		if (attr != null) {
			string type = attr.get_string ("type");
			if (type != null) {
				return type;
			}
		}
		return null;
	}

	string get_creturn_type (Method m, string default_value) {
		string type = get_custom_creturn_type (m);
		if (type == null) {
			return default_value;
		}
		return type;
	}

	bool is_gtypeinstance_creation_method (Method m) {
		bool result = false;

		var cl = m.parent_symbol as Class;
		if (m is CreationMethod && cl != null && !cl.is_compact) {
			result = true;
		}

		return result;
	}

	public virtual void generate_method_result_declaration (Method m, CCodeDeclarationSpace decl_space, CCodeFunction cfunc, Map<int,CCodeFormalParameter> cparam_map, Map<int,CCodeExpression>? carg_map) {
		var creturn_type = m.return_type;
		if (m is CreationMethod) {
			var cl = m.parent_symbol as Class;
			if (cl != null) {
				// object creation methods return the new object in C
				// in Vala they have no return type
				creturn_type = new ObjectType (cl);
			}
		}
		cfunc.return_type = get_creturn_type (m, creturn_type.get_cname ());

		generate_type_declaration (m.return_type, decl_space);

		if (!m.no_array_length && m.return_type is ArrayType) {
			// return array length if appropriate
			var array_type = (ArrayType) m.return_type;

			for (int dim = 1; dim <= array_type.rank; dim++) {
				var cparam = new CCodeFormalParameter (head.get_array_length_cname ("result", dim), "int*");
				cparam_map.set (get_param_pos (m.carray_length_parameter_position + 0.01 * dim), cparam);
				if (carg_map != null) {
					carg_map.set (get_param_pos (m.carray_length_parameter_position + 0.01 * dim), get_variable_cexpression (cparam.name));
				}
			}
		} else if (m.return_type is DelegateType) {
			// return delegate target if appropriate
			var deleg_type = (DelegateType) m.return_type;
			var d = deleg_type.delegate_symbol;
			if (d.has_target) {
				var cparam = new CCodeFormalParameter (get_delegate_target_cname ("result"), "void**");
				cparam_map.set (get_param_pos (m.cdelegate_target_parameter_position), cparam);
				if (carg_map != null) {
					carg_map.set (get_param_pos (m.cdelegate_target_parameter_position), get_variable_cexpression (cparam.name));
				}
			}
		}

		if (m.get_error_types ().size > 0 || (m.base_method != null && m.base_method.get_error_types ().size > 0)) {
			foreach (DataType error_type in m.get_error_types ()) {
				generate_type_declaration (error_type, decl_space);
			}

			var cparam = new CCodeFormalParameter ("error", "GError**");
			cparam_map.set (get_param_pos (-1), cparam);
			if (carg_map != null) {
				carg_map.set (get_param_pos (-1), new CCodeIdentifier (cparam.name));
			}
		}
	}

	public CCodeStatement complete_async () {
		var complete_block = new CCodeBlock ();

		var direct_block = new CCodeBlock ();
		var direct_call = new CCodeFunctionCall (new CCodeIdentifier ("g_simple_async_result_complete"));
		var async_result_expr = new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "_async_result");
		direct_call.add_argument (async_result_expr);
		direct_block.add_statement (new CCodeExpressionStatement (direct_call));

		var idle_block = new CCodeBlock ();
		var idle_call = new CCodeFunctionCall (new CCodeIdentifier ("g_simple_async_result_complete_in_idle"));
		idle_call.add_argument (async_result_expr);
		idle_block.add_statement (new CCodeExpressionStatement (idle_call));

		var state = new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "state");
		var zero = new CCodeConstant ("0");
		var state_is_zero = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, state, zero);
		var dispatch = new CCodeIfStatement (state_is_zero, idle_block, direct_block);
		complete_block.add_statement (dispatch);

		var unref = new CCodeFunctionCall (new CCodeIdentifier ("g_object_unref"));
		unref.add_argument (async_result_expr);
		complete_block.add_statement (new CCodeExpressionStatement (unref));

		complete_block.add_statement (new CCodeReturnStatement (new CCodeConstant ("FALSE")));

		return complete_block;
	}

	public override void generate_method_declaration (Method m, CCodeDeclarationSpace decl_space) {
		if (decl_space.add_symbol_declaration (m, m.get_cname ())) {
			return;
		}

		var function = new CCodeFunction (m.get_cname ());

		if (m.is_private_symbol ()) {
			function.modifiers |= CCodeModifiers.STATIC;
			if (m.is_inline) {
				function.modifiers |= CCodeModifiers.INLINE;
			}
		}

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);
		var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

		generate_cparameters (m, decl_space, cparam_map, function, null, carg_map, new CCodeFunctionCall (new CCodeIdentifier ("fake")));

		decl_space.add_type_member_declaration (function);

		if (m is CreationMethod && m.parent_symbol is Class) {
			// _construct function
			function = new CCodeFunction (m.get_real_cname ());

			if (m.is_private_symbol ()) {
				function.modifiers |= CCodeModifiers.STATIC;
			}

			cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);
			generate_cparameters (m, decl_space, cparam_map, function);

			decl_space.add_type_member_declaration (function);
		}
	}

	public override void visit_method (Method m) {
		var old_type_symbol = current_type_symbol;
		var old_symbol = current_symbol;
		Method old_method = current_method;
		DataType old_return_type = current_return_type;
		bool old_method_inner_error = current_method_inner_error;
		bool old_in_creation_method = in_creation_method;
		int old_next_temp_var_id = next_temp_var_id;
		var old_temp_vars = temp_vars;
		var old_temp_ref_vars = temp_ref_vars;
		var old_variable_name_map = variable_name_map;
		var old_try = current_try;
		if (m.parent_symbol is TypeSymbol) {
			current_type_symbol = (TypeSymbol) m.parent_symbol;
		}
		current_symbol = m;
		current_method = m;
		current_return_type = m.return_type;
		current_method_inner_error = false;
		next_temp_var_id = 0;
		temp_vars = new ArrayList<LocalVariable> ();
		temp_ref_vars = new ArrayList<LocalVariable> ();
		variable_name_map = new HashMap<string,string> (str_hash, str_equal);
		current_try = null;

		bool in_gobject_creation_method = false;
		bool in_fundamental_creation_method = false;

		check_type (m.return_type);

		if (m is CreationMethod) {
			in_creation_method = true;
			var cl = current_type_symbol as Class;
			if (cl != null && !cl.is_compact) {
				if (cl.base_class == null) {
					in_fundamental_creation_method = true;
				} else if (gobject_type != null && cl.is_subtype_of (gobject_type)) {
					in_gobject_creation_method = true;
				}
			}
		} else {
			in_creation_method = false;
		}

		var creturn_type = current_return_type;

		m.accept_children (codegen);

		if (m is CreationMethod) {
			if (in_gobject_creation_method && m.body != null) {
				var cblock = new CCodeBlock ();

				// last property assignment statement
				CodeNode last_stmt = null;

				if (!((CreationMethod) m).chain_up) {
					// set construct properties
					foreach (CodeNode stmt in m.body.get_statements ()) {
						var expr_stmt = stmt as ExpressionStatement;
						if (expr_stmt != null) {
							var prop = expr_stmt.assigned_property ();
							if (prop != null && prop.set_accessor.construction) {
								last_stmt = stmt;
							}
						}
					}
					if (last_stmt != null) {
						foreach (CodeNode stmt in m.body.get_statements ()) {
							if (stmt.ccodenode is CCodeFragment) {
								foreach (CCodeNode cstmt in ((CCodeFragment) stmt.ccodenode).get_children ()) {
									cblock.add_statement (cstmt);
								}
							} else {
								cblock.add_statement (stmt.ccodenode);
							}
							if (last_stmt == stmt) {
								break;
							}
						}
					}

					add_object_creation (cblock, ((CreationMethod) m).n_construction_params > 0 || current_class.get_type_parameters ().size > 0);
				} else {
					var cdeclaration = new CCodeDeclaration ("%s *".printf (((Class) current_type_symbol).get_cname ()));
					cdeclaration.add_declarator (new CCodeVariableDeclarator ("self"));
		
					cblock.add_statement (cdeclaration);
				}

				// other initialization code
				foreach (CodeNode stmt in m.body.get_statements ()) {
					if (last_stmt != null) {
						if (last_stmt == stmt) {
							last_stmt = null;
						}
						continue;
					}
					if (stmt.ccodenode is CCodeFragment) {
						foreach (CCodeNode cstmt in ((CCodeFragment) stmt.ccodenode).get_children ()) {
							cblock.add_statement (cstmt);
						}
					} else {
						cblock.add_statement (stmt.ccodenode);
					}
				}

				foreach (LocalVariable local in m.body.get_local_variables ()) {
					if (!local.floating && requires_destroy (local.variable_type)) {
						var ma = new MemberAccess.simple (local.name);
						ma.symbol_reference = local;
						cblock.add_statement (new CCodeExpressionStatement (get_unref_expression (get_variable_cexpression (local.name), local.variable_type, ma)));
					}
				}

				m.body.ccodenode = cblock;
			}

			in_creation_method = old_in_creation_method;
		}

		bool inner_error = current_method_inner_error;

		current_type_symbol = old_type_symbol;
		current_symbol = old_symbol;
		current_method = old_method;
		current_return_type = old_return_type;
		current_method_inner_error = old_method_inner_error;
		next_temp_var_id = old_next_temp_var_id;
		temp_vars = old_temp_vars;
		temp_ref_vars = old_temp_ref_vars;
		variable_name_map = old_variable_name_map;
		current_try = old_try;

		// do not declare overriding methods and interface implementations
		if (m.is_abstract || m.is_virtual
		    || (m.base_method == null && m.base_interface_method == null)) {
			generate_method_declaration (m, source_declarations);

			if (!m.is_internal_symbol ()) {
				generate_method_declaration (m, header_declarations);
			}
			generate_method_declaration (m, internal_header_declarations);
		}

		function = new CCodeFunction (m.get_real_cname ());
		m.ccodenode = function;

		if (m.is_inline) {
			function.modifiers |= CCodeModifiers.INLINE;
		}

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		generate_cparameters (m, source_declarations, cparam_map, function);

		// generate *_real_* functions for virtual methods
		// also generate them for abstract methods of classes to prevent faulty subclassing
		if (!m.is_abstract || (m.is_abstract && current_type_symbol is Class)) {
			if (m.base_method != null || m.base_interface_method != null) {
				// declare *_real_* function
				function.modifiers |= CCodeModifiers.STATIC;
				source_declarations.add_type_member_declaration (function.copy ());
			} else if (m.is_private_symbol ()) {
				function.modifiers |= CCodeModifiers.STATIC;
			}
		
			/* Methods imported from a plain C file don't
			 * have a body, e.g. Vala.Parser.parse_file () */
			if (m.body != null) {
				function.block = (CCodeBlock) m.body.ccodenode;
				function.block.line = function.line;

				var cinit = new CCodeFragment ();
				function.block.prepend_statement (cinit);

				if (m.coroutine) {
					var co_function = new CCodeFunction (m.get_real_cname () + "_co", "gboolean");

					// data struct to hold parameters, local variables, and the return value
					co_function.add_parameter (new CCodeFormalParameter ("data", Symbol.lower_case_to_camel_case (m.get_cname ()) + "Data*"));

					co_function.modifiers |= CCodeModifiers.STATIC;
					source_declarations.add_type_member_declaration (co_function.copy ());

					var cswitch = new CCodeSwitchStatement (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "state"));

					// let gcc know that this can't happen
					cswitch.add_statement (new CCodeLabel ("default"));
					cswitch.add_statement (new CCodeExpressionStatement (new CCodeFunctionCall (new CCodeIdentifier ("g_assert_not_reached"))));

					// initial coroutine state
					cswitch.add_statement (new CCodeCaseStatement (new CCodeConstant ("0")));

					// coroutine body
					cswitch.add_statement (function.block);

					// epilogue
					cswitch.add_statement (complete_async ());

					co_function.block = new CCodeBlock ();
					co_function.block.add_statement (cswitch);

					source_type_member_definition.append (co_function);
				}

				if (m.parent_symbol is Class && !m.coroutine) {
					var cl = (Class) m.parent_symbol;
					if (m.overrides || (m.base_interface_method != null && !m.is_abstract && !m.is_virtual)) {
						Method base_method;
						ReferenceType base_expression_type;
						if (m.overrides) {
							base_method = m.base_method;
							base_expression_type = new ObjectType ((Class) base_method.parent_symbol);
						} else {
							base_method = m.base_interface_method;
							base_expression_type = new ObjectType ((Interface) base_method.parent_symbol);
						}
						var self_target_type = new ObjectType (cl);
						CCodeExpression cself = transform_expression (new CCodeIdentifier ("base"), base_expression_type, self_target_type);

						var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
						cdecl.add_declarator (new CCodeVariableDeclarator ("self", cself));
					
						cinit.append (cdecl);
					} else if (m.binding == MemberBinding.INSTANCE
					           && !(m is CreationMethod)) {
						var ccheckstmt = create_method_type_check_statement (m, creturn_type, cl, true, "self");
						if (ccheckstmt != null) {
							ccheckstmt.line = function.line;
							cinit.append (ccheckstmt);
						}
					}
				}
				foreach (FormalParameter param in m.get_parameters ()) {
					if (param.ellipsis) {
						break;
					}

					var t = param.parameter_type.data_type;
					if (t != null && t.is_reference_type ()) {
						if (param.direction != ParameterDirection.OUT) {
							var type_check = create_method_type_check_statement (m, creturn_type, t, !param.parameter_type.nullable, get_variable_cname (param.name));
							if (type_check != null) {
								type_check.line = function.line;
								cinit.append (type_check);
							}
						} else {
							// ensure that the passed reference for output parameter is cleared
							var a = new CCodeAssignment (new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, get_variable_cexpression (param.name)), new CCodeConstant ("NULL"));
							var cblock = new CCodeBlock ();
							cblock.add_statement (new CCodeExpressionStatement (a));

							var condition = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, get_variable_cexpression (param.name), new CCodeConstant ("NULL"));
							var if_statement = new CCodeIfStatement (condition, cblock);
							cinit.append (if_statement);
						}
					}
				}

				if (!(m.return_type is VoidType) && !m.coroutine) {
					var cdecl = new CCodeDeclaration (m.return_type.get_cname ());
					cdecl.add_declarator (new CCodeVariableDeclarator ("result"));
					cinit.append (cdecl);
				}

				if (inner_error) {
					/* always separate error parameter and inner_error local variable
					 * as error may be set to NULL but we're always interested in inner errors
					 */
					if (m.coroutine) {
						closure_struct.add_field ("GError *", "_inner_error_");

						// no initialization necessary, closure struct is zeroed
					} else {
						var cdecl = new CCodeDeclaration ("GError *");
						cdecl.add_declarator (new CCodeVariableDeclarator ("_inner_error_", new CCodeConstant ("NULL")));
						cinit.append (cdecl);
					}
				}

				if (!m.coroutine) {
					if (m.source_reference != null && m.source_reference.comment != null) {
						source_type_member_definition.append (new CCodeComment (m.source_reference.comment));
					}
					source_type_member_definition.append (function);
				}
			
				if (m is CreationMethod) {
					if (in_gobject_creation_method) {
						int n_params = ((CreationMethod) m).n_construction_params;

						if (!((CreationMethod) m).chain_up) {
							if (n_params > 0 || current_class.get_type_parameters ().size > 0) {
								// declare construction parameter array
								var cparamsinit = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
								cparamsinit.add_argument (new CCodeIdentifier ("GParameter"));
								cparamsinit.add_argument (new CCodeConstant ((n_params + 3 * current_class.get_type_parameters ().size).to_string ()));
						
								var cdecl = new CCodeDeclaration ("GParameter *");
								cdecl.add_declarator (new CCodeVariableDeclarator ("__params", cparamsinit));
								cinit.append (cdecl);
						
								cdecl = new CCodeDeclaration ("GParameter *");
								cdecl.add_declarator (new CCodeVariableDeclarator ("__params_it", new CCodeIdentifier ("__params")));
								cinit.append (cdecl);
							}

							/* type, dup func, and destroy func properties for generic types */
							foreach (TypeParameter type_param in current_class.get_type_parameters ()) {
								CCodeConstant prop_name;
								CCodeIdentifier param_name;

								prop_name = new CCodeConstant ("\"%s-type\"".printf (type_param.name.down ()));
								param_name = new CCodeIdentifier ("%s_type".printf (type_param.name.down ()));
								cinit.append (new CCodeExpressionStatement (get_construct_property_assignment (prop_name, new IntegerType ((Struct) gtype_type), param_name)));

								prop_name = new CCodeConstant ("\"%s-dup-func\"".printf (type_param.name.down ()));
								param_name = new CCodeIdentifier ("%s_dup_func".printf (type_param.name.down ()));
								cinit.append (new CCodeExpressionStatement (get_construct_property_assignment (prop_name, new PointerType (new VoidType ()), param_name)));

								prop_name = new CCodeConstant ("\"%s-destroy-func\"".printf (type_param.name.down ()));
								param_name = new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.down ()));
								cinit.append (new CCodeExpressionStatement (get_construct_property_assignment (prop_name, new PointerType (new VoidType ()), param_name)));
							}
						}
					} else if (is_gtypeinstance_creation_method (m)) {
						var cl = (Class) m.parent_symbol;
						var cdeclaration = new CCodeDeclaration (cl.get_cname () + "*");
						var cdecl = new CCodeVariableDeclarator ("self");
						cdeclaration.add_declarator (cdecl);
						cinit.append (cdeclaration);

						if (!((CreationMethod) m).chain_up) {
							// TODO implicitly chain up to base class as in add_object_creation
							var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_create_instance"));
							ccall.add_argument (new CCodeIdentifier ("object_type"));
							cdecl.initializer = new CCodeCastExpression (ccall, cl.get_cname () + "*");

							/* type, dup func, and destroy func fields for generic types */
							foreach (TypeParameter type_param in current_class.get_type_parameters ()) {
								CCodeIdentifier param_name;
								CCodeAssignment assign;

								var priv_access = new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv");

								param_name = new CCodeIdentifier ("%s_type".printf (type_param.name.down ()));
								assign = new CCodeAssignment (new CCodeMemberAccess.pointer (priv_access, param_name.name), param_name);
								cinit.append (new CCodeExpressionStatement (assign));

								param_name = new CCodeIdentifier ("%s_dup_func".printf (type_param.name.down ()));
								assign = new CCodeAssignment (new CCodeMemberAccess.pointer (priv_access, param_name.name), param_name);
								cinit.append (new CCodeExpressionStatement (assign));

								param_name = new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.down ()));
								assign = new CCodeAssignment (new CCodeMemberAccess.pointer (priv_access, param_name.name), param_name);
								cinit.append (new CCodeExpressionStatement (assign));
							}
						}
					} else if (current_type_symbol is Class) {
						var cl = (Class) m.parent_symbol;
						var cdeclaration = new CCodeDeclaration (cl.get_cname () + "*");
						var cdecl = new CCodeVariableDeclarator ("self");
						cdeclaration.add_declarator (cdecl);
						cinit.append (cdeclaration);

						if (!((CreationMethod) m).chain_up) {
							// TODO implicitly chain up to base class as in add_object_creation
							var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_new0"));
							ccall.add_argument (new CCodeIdentifier (cl.get_cname ()));
							cdecl.initializer = ccall;
						}

						if (cl.base_class == null) {
							// derived compact classes do not have fields
							var cinitcall = new CCodeFunctionCall (new CCodeIdentifier ("%s_instance_init".printf (cl.get_lower_case_cname (null))));
							cinitcall.add_argument (new CCodeIdentifier ("self"));
							cinit.append (new CCodeExpressionStatement (cinitcall));
						}
					} else {
						var st = (Struct) m.parent_symbol;

						// memset needs string.h
						source_declarations.add_include ("string.h");
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
					var check_stmt = create_precondition_statement (m, creturn_type, precondition);
					if (check_stmt != null) {
						cinit.append (check_stmt);
					}
				}
			} else if (m.is_abstract) {
				// generate helpful error message if a sublcass does not implement an abstract method.
				// This is only meaningful for subclasses implemented in C since the vala compiler would
				// complain during compile time of such en error.

				var cblock = new CCodeBlock ();

				// add a typecheck statement for "self"
				var check_stmt = create_method_type_check_statement (m, creturn_type, current_type_symbol, true, "self");
				if (check_stmt != null) {
					cblock.add_statement (check_stmt);
				}

				// add critical warning that this method should not have been called
				var type_from_instance_call = new CCodeFunctionCall (new CCodeIdentifier ("G_TYPE_FROM_INSTANCE"));
				type_from_instance_call.add_argument (new CCodeIdentifier ("self"));
			
				var type_name_call = new CCodeFunctionCall (new CCodeIdentifier ("g_type_name"));
				type_name_call.add_argument (type_from_instance_call);

				var error_string = "\"Type `%%s' does not implement abstract method `%s'\"".printf (m.get_cname ());

				var cerrorcall = new CCodeFunctionCall (new CCodeIdentifier ("g_critical"));
				cerrorcall.add_argument (new CCodeConstant (error_string));
				cerrorcall.add_argument (type_name_call);

				cblock.add_statement (new CCodeExpressionStatement (cerrorcall));

				// add return statement
				cblock.add_statement (new CCodeReturnStatement (default_value_for_type (creturn_type, false)));

				function.block = cblock;
				source_type_member_definition.append (function);
			}
		}

		if ((m.is_abstract || m.is_virtual) && !m.coroutine &&
		/* If the method is a signal handler, the declaration
		 * is not needed. -- the name should be reserved for the
		 * emitter! */
			    m.signal_reference == null) {

			cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);
			var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

			generate_vfunc (m, creturn_type, cparam_map, carg_map);
		}

		if (m.entry_point) {
			// m is possible entry point, add appropriate startup code
			var cmain = new CCodeFunction ("main", "int");
			cmain.line = function.line;
			cmain.add_parameter (new CCodeFormalParameter ("argc", "int"));
			cmain.add_parameter (new CCodeFormalParameter ("argv", "char **"));
			var main_block = new CCodeBlock ();

			if (context.profile == Profile.GOBJECT) {
				if (context.thread) {
					var thread_init_call = new CCodeFunctionCall (new CCodeIdentifier ("g_thread_init"));
					thread_init_call.line = cmain.line;
					thread_init_call.add_argument (new CCodeConstant ("NULL"));
					main_block.add_statement (new CCodeExpressionStatement (thread_init_call)); 
				}

				var type_init_call = new CCodeExpressionStatement (new CCodeFunctionCall (new CCodeIdentifier ("g_type_init")));
				type_init_call.line = cmain.line;
				main_block.add_statement (type_init_call);
			}

			var main_call = new CCodeFunctionCall (new CCodeIdentifier (function.name));
			if (m.get_parameters ().size == 1) {
				main_call.add_argument (new CCodeIdentifier ("argv"));
				main_call.add_argument (new CCodeIdentifier ("argc"));
			}
			if (m.return_type is VoidType) {
				// method returns void, always use 0 as exit code
				var main_stmt = new CCodeExpressionStatement (main_call);
				main_stmt.line = cmain.line;
				main_block.add_statement (main_stmt);
				var ret_stmt = new CCodeReturnStatement (new CCodeConstant ("0"));
				ret_stmt.line = cmain.line;
				main_block.add_statement (ret_stmt);
			} else {
				var main_stmt = new CCodeReturnStatement (main_call);
				main_stmt.line = cmain.line;
				main_block.add_statement (main_stmt);
			}
			cmain.block = main_block;
			source_type_member_definition.append (cmain);
		}
	}

	public virtual void generate_parameter (FormalParameter param, CCodeDeclarationSpace decl_space, Map<int,CCodeFormalParameter> cparam_map, Map<int,CCodeExpression>? carg_map) {
		if (!param.ellipsis) {
			string ctypename = param.parameter_type.get_cname ();

			generate_type_declaration (param.parameter_type, decl_space);

			// pass non-simple structs always by reference
			if (param.parameter_type.data_type is Struct) {
				var st = (Struct) param.parameter_type.data_type;
				if (!st.is_simple_type () && param.direction == ParameterDirection.IN) {
					if (st.use_const && !param.parameter_type.value_owned) {
						ctypename = "const " + ctypename;
					}

					if (!param.parameter_type.nullable) {
						ctypename += "*";
					}
				}
			}

			if (param.direction != ParameterDirection.IN) {
				ctypename += "*";
			}

			param.ccodenode = new CCodeFormalParameter (get_variable_cname (param.name), ctypename);
		} else {
			param.ccodenode = new CCodeFormalParameter.with_ellipsis ();
		}

		cparam_map.set (get_param_pos (param.cparameter_position), (CCodeFormalParameter) param.ccodenode);
		if (carg_map != null && !param.ellipsis) {
			carg_map.set (get_param_pos (param.cparameter_position), get_variable_cexpression (param.name));
		}
	}

	public override void generate_cparameters (Method m, CCodeDeclarationSpace decl_space, Map<int,CCodeFormalParameter> cparam_map, CCodeFunction func, CCodeFunctionDeclarator? vdeclarator = null, Map<int,CCodeExpression>? carg_map = null, CCodeFunctionCall? vcall = null, int direction = 3) {
		if (m.parent_symbol is Class && m is CreationMethod) {
			var cl = (Class) m.parent_symbol;
			if (!cl.is_compact && vcall == null) {
				cparam_map.set (get_param_pos (m.cinstance_parameter_position), new CCodeFormalParameter ("object_type", "GType"));
			}
		} else if (m.binding == MemberBinding.INSTANCE || (m.parent_symbol is Struct && m is CreationMethod)) {
			TypeSymbol parent_type = find_parent_type (m);
			DataType this_type;
			if (parent_type is Class) {
				this_type = new ObjectType ((Class) parent_type);
			} else if (parent_type is Interface) {
				this_type = new ObjectType ((Interface) parent_type);
			} else if (parent_type is Struct) {
				this_type = new StructValueType ((Struct) parent_type);
			} else if (parent_type is Enum) {
				this_type = new EnumValueType ((Enum) parent_type);
			} else {
				assert_not_reached ();
			}

			generate_type_declaration (this_type, decl_space);

			CCodeFormalParameter instance_param = null;
			if (m.base_interface_method != null && !m.is_abstract && !m.is_virtual) {
				var base_type = new ObjectType ((Interface) m.base_interface_method.parent_symbol);
				instance_param = new CCodeFormalParameter ("base", base_type.get_cname ());
			} else if (m.overrides) {
				var base_type = new ObjectType ((Class) m.base_method.parent_symbol);
				instance_param = new CCodeFormalParameter ("base", base_type.get_cname ());
			} else {
				if (m.parent_symbol is Struct && !((Struct) m.parent_symbol).is_simple_type ()) {
					instance_param = new CCodeFormalParameter ("*self", this_type.get_cname ());
				} else {
					instance_param = new CCodeFormalParameter ("self", this_type.get_cname ());
				}
			}
			cparam_map.set (get_param_pos (m.cinstance_parameter_position), instance_param);
		} else if (m.binding == MemberBinding.CLASS) {
			TypeSymbol parent_type = find_parent_type (m);
			DataType this_type;
			this_type = new ClassType ((Class) parent_type);
			var class_param = new CCodeFormalParameter ("klass", this_type.get_cname ());
			cparam_map.set (get_param_pos (m.cinstance_parameter_position), class_param);
		}

		if (is_gtypeinstance_creation_method (m)) {
			// memory management for generic types
			int type_param_index = 0;
			var cl = (Class) m.parent_symbol;
			foreach (TypeParameter type_param in cl.get_type_parameters ()) {
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "GType"));
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeFormalParameter ("%s_dup_func".printf (type_param.name.down ()), "GBoxedCopyFunc"));
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeFormalParameter ("%s_destroy_func".printf (type_param.name.down ()), "GDestroyNotify"));
				if (carg_map != null) {
					carg_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
					carg_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeIdentifier ("%s_dup_func".printf (type_param.name.down ())));
					carg_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.down ())));
				}
				type_param_index++;
			}
		} else {
			int type_param_index = 0;
			if (m.binding != MemberBinding.INSTANCE && m.parent_symbol is ObjectTypeSymbol) {
				// support static methods in generic types
				var type_symbol = (ObjectTypeSymbol) m.parent_symbol;
				foreach (var type_param in type_symbol.get_type_parameters ()) {
					cparam_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "GType"));
					cparam_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeFormalParameter ("%s_dup_func".printf (type_param.name.down ()), "GBoxedCopyFunc"));
					cparam_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeFormalParameter ("%s_destroy_func".printf (type_param.name.down ()), "GDestroyNotify"));
					if (carg_map != null) {
						carg_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
						carg_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeIdentifier ("%s_dup_func".printf (type_param.name.down ())));
						carg_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.down ())));
					}
					type_param_index++;
				}
			}
			foreach (var type_param in m.get_type_parameters ()) {
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "GType"));
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeFormalParameter ("%s_dup_func".printf (type_param.name.down ()), "GBoxedCopyFunc"));
				cparam_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeFormalParameter ("%s_destroy_func".printf (type_param.name.down ()), "GDestroyNotify"));
				if (carg_map != null) {
					carg_map.set (get_param_pos (0.1 * type_param_index + 0.01), new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
					carg_map.set (get_param_pos (0.1 * type_param_index + 0.02), new CCodeIdentifier ("%s_dup_func".printf (type_param.name.down ())));
					carg_map.set (get_param_pos (0.1 * type_param_index + 0.03), new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.down ())));
				}
				type_param_index++;
			}
		}

		foreach (FormalParameter param in m.get_parameters ()) {
			if (param.direction != ParameterDirection.OUT) {
				if ((direction & 1) == 0) {
					// no in paramters
					continue;
				}
			} else {
				if ((direction & 2) == 0) {
					// no out paramters
					continue;
				}
			}

			generate_parameter (param, decl_space, cparam_map, carg_map);
		}

		if ((direction & 2) != 0) {
			generate_method_result_declaration (m, decl_space, func, cparam_map, carg_map);
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
			func.add_parameter (cparam_map.get (min_pos));
			if (vdeclarator != null) {
				vdeclarator.add_parameter (cparam_map.get (min_pos));
			}
			if (vcall != null) {
				var arg = carg_map.get (min_pos);
				if (arg != null) {
					vcall.add_argument (arg);
				}
			}
			last_pos = min_pos;
		}
	}

	public void generate_vfunc (Method m, DataType return_type, Map<int,CCodeFormalParameter> cparam_map, Map<int,CCodeExpression> carg_map, string suffix = "", int direction = 3) {
		var vfunc = new CCodeFunction (m.get_cname () + suffix);
		vfunc.line = function.line;

		var vblock = new CCodeBlock ();

		foreach (Expression precondition in m.get_preconditions ()) {
			var check_stmt = create_precondition_statement (m, return_type, precondition);
			if (check_stmt != null) {
				vblock.add_statement (check_stmt);
			}
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
	
		var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, m.vfunc_name + suffix));
		carg_map.set (get_param_pos (m.cinstance_parameter_position), new CCodeIdentifier ("self"));

		generate_cparameters (m, source_declarations, cparam_map, vfunc, null, carg_map, vcall, direction);

		CCodeStatement cstmt;
		if (return_type is VoidType) {
			cstmt = new CCodeExpressionStatement (vcall);
		} else if (m.get_postconditions ().size == 0) {
			/* pass method return value */
			cstmt = new CCodeReturnStatement (vcall);
		} else {
			/* store method return value for postconditions */
			var cdecl = new CCodeDeclaration (get_creturn_type (m, return_type.get_cname ()));
			cdecl.add_declarator (new CCodeVariableDeclarator ("result", vcall));
			cstmt = cdecl;
		}
		cstmt.line = vfunc.line;
		vblock.add_statement (cstmt);

		if (m.get_postconditions ().size > 0) {
			foreach (Expression postcondition in m.get_postconditions ()) {
				vblock.add_statement (create_postcondition_statement (postcondition));
			}

			if (!(return_type is VoidType)) {
				var cret_stmt = new CCodeReturnStatement (new CCodeIdentifier ("result"));
				cret_stmt.line = vfunc.line;
				vblock.add_statement (cret_stmt);
			}
		}

		vfunc.block = vblock;

		if (m.is_abstract && m.source_reference != null && m.source_reference.comment != null) {
			source_type_member_definition.append (new CCodeComment (m.source_reference.comment));
		}
		source_type_member_definition.append (vfunc);
	}

	private CCodeStatement? create_method_type_check_statement (Method m, DataType return_type, TypeSymbol t, bool non_null, string var_name) {
		if (m.coroutine) {
			return null;
		} else {
			return create_type_check_statement (m, return_type, t, non_null, var_name);
		}
	}

	private CCodeStatement? create_precondition_statement (CodeNode method_node, DataType ret_type, Expression precondition) {
		var ccheck = new CCodeFunctionCall ();

		ccheck.add_argument ((CCodeExpression) precondition.ccodenode);

		if (ret_type is VoidType) {
			/* void function */
			ccheck.call = new CCodeIdentifier ("g_return_if_fail");
		} else {
			ccheck.call = new CCodeIdentifier ("g_return_val_if_fail");

			var cdefault = default_value_for_type (ret_type, false);
			if (cdefault != null) {
				ccheck.add_argument (cdefault);
			} else {
				return null;
			}
		}
		
		return new CCodeExpressionStatement (ccheck);
	}

	private TypeSymbol? find_parent_type (Symbol sym) {
		while (sym != null) {
			if (sym is TypeSymbol) {
				return (TypeSymbol) sym;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}

	private void add_object_creation (CCodeBlock b, bool has_params) {
		var cl = (Class) current_type_symbol;

		bool chain_up = false;
		CreationMethod cm = null;
		if (cl.base_class != null) {
			cm = cl.base_class.default_construction_method as CreationMethod;
			if (cm != null && cm.get_parameters ().size == 0
			    && cm.has_construct_function) {
				 if (!has_params) {
					chain_up = true;
				 }
			}
		}

		if (!has_params && !chain_up
		    && cl.base_class != gobject_type) {
			// possibly report warning or error about missing base call
		}

		var cdecl = new CCodeVariableDeclarator ("self");
		if (chain_up) {
			generate_method_declaration (cm, source_declarations);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier (cm.get_real_cname ()));
			ccall.add_argument (new CCodeIdentifier ("object_type"));
			cdecl.initializer = new CCodeCastExpression (ccall, "%s*".printf (cl.get_cname ()));
		} else {
			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_object_newv"));
			ccall.add_argument (new CCodeIdentifier ("object_type"));
			if (has_params) {
				ccall.add_argument (new CCodeConstant ("__params_it - __params"));
				ccall.add_argument (new CCodeConstant ("__params"));
			} else {
				ccall.add_argument (new CCodeConstant ("0"));
				ccall.add_argument (new CCodeConstant ("NULL"));
			}
			cdecl.initializer = ccall;
		}
		
		var cdeclaration = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
		cdeclaration.add_declarator (cdecl);
		
		b.add_statement (cdeclaration);
	}

	public override void visit_creation_method (CreationMethod m) {
		bool visible = !m.is_private_symbol ();

		if (m.body != null && current_type_symbol is Class
		    && gobject_type != null && current_class.is_subtype_of (gobject_type)) {
			int n_params = 0;
			foreach (Statement stmt in m.body.get_statements ()) {
				var expr_stmt = stmt as ExpressionStatement;
				if (expr_stmt != null) {
					Property prop = expr_stmt.assigned_property ();
					if (prop != null && prop.set_accessor.construction) {
						n_params++;
					}
				}
			}
			m.n_construction_params = n_params;
		}

		head.visit_method (m);

		DataType creturn_type;
		if (current_type_symbol is Class) {
			creturn_type = new ObjectType (current_class);
		} else {
			creturn_type = new VoidType ();
		}

		if (current_type_symbol is Class && !current_class.is_compact) {
			var vfunc = new CCodeFunction (m.get_cname ());
			vfunc.line = function.line;

			var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);
			var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

			var vblock = new CCodeBlock ();

			var vcall = new CCodeFunctionCall (new CCodeIdentifier (m.get_real_cname ()));
			vcall.add_argument (new CCodeIdentifier (current_class.get_type_id ()));

			generate_cparameters (m, source_declarations, cparam_map, vfunc, null, carg_map, vcall);
			CCodeStatement cstmt = new CCodeReturnStatement (vcall);
			cstmt.line = vfunc.line;
			vblock.add_statement (cstmt);

			if (!visible) {
				vfunc.modifiers |= CCodeModifiers.STATIC;
			}

			vfunc.block = vblock;

			source_type_member_definition.append (vfunc);
		}

		if (current_type_symbol is Class && gobject_type != null && current_class.is_subtype_of (gobject_type)
		    && (((CreationMethod) m).n_construction_params > 0 || current_class.get_type_parameters ().size > 0)
		    && !((CreationMethod) m).chain_up) {
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
			CCodeExpression cresult = new CCodeIdentifier ("self");
			if (get_custom_creturn_type (m) != null) {
				cresult = new CCodeCastExpression (cresult, get_custom_creturn_type (m));
			}

			var creturn = new CCodeReturnStatement ();
			creturn.return_expression = cresult;
			function.block.add_statement (creturn);
		}
	}
}

// vim:sw=8 noet
