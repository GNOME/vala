/* valaccodemethodbinding.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
public class Vala.CCodeMethodModule : CCodeModule {
	public CCodeMethodModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	public override bool method_has_wrapper (Method method) {
		return (method.get_attribute ("NoWrapper") == null);
	}

	public override string? get_custom_creturn_type (Method m) {
		if (m.coroutine) {
			return "gboolean";
		}

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

	public override void visit_method (Method m) {
		Method old_method = codegen.current_method;
		DataType old_return_type = codegen.current_return_type;
		bool old_method_inner_error = codegen.current_method_inner_error;
		int old_next_temp_var_id = codegen.next_temp_var_id;
		codegen.current_symbol = m;
		codegen.current_method = m;
		codegen.current_return_type = m.return_type;
		codegen.current_method_inner_error = false;
		codegen.next_temp_var_id = 0;

		bool in_gtypeinstance_creation_method = false;
		bool in_gobject_creation_method = false;
		bool in_fundamental_creation_method = false;

		var creturn_type = codegen.current_return_type;

		if (m is CreationMethod) {
			codegen.in_creation_method = true;
			var cl = codegen.current_type_symbol as Class;
			if (cl != null && !cl.is_compact) {
				in_gtypeinstance_creation_method = true;
				if (cl.base_class == null) {
					in_fundamental_creation_method = true;
				} else if (cl.is_subtype_of (codegen.gobject_type)) {
					in_gobject_creation_method = true;
				}
			}

			if (cl != null) {
				creturn_type = new ObjectType (cl);
			}
		}

		m.accept_children (codegen);

		if (m is CreationMethod) {
			if (in_gobject_creation_method && m.body != null) {
				var cblock = new CCodeBlock ();

				if (!((CreationMethod) m).chain_up) {
					// set construct properties
					foreach (CodeNode stmt in m.body.get_statements ()) {
						var expr_stmt = stmt as ExpressionStatement;
						if (expr_stmt != null) {
							var prop = expr_stmt.assigned_property ();
							if (prop != null && prop.set_accessor.construction) {
								if (stmt.ccodenode is CCodeFragment) {
									foreach (CCodeNode cstmt in ((CCodeFragment) stmt.ccodenode).get_children ()) {
										cblock.add_statement (cstmt);
									}
								} else {
									cblock.add_statement (stmt.ccodenode);
								}
							}
						}
					}

					add_object_creation (cblock, ((CreationMethod) m).n_construction_params > 0 || codegen.current_class.get_type_parameters ().size > 0);
				} else {
					var cdeclaration = new CCodeDeclaration ("%s *".printf (((Class) codegen.current_type_symbol).get_cname ()));
					cdeclaration.add_declarator (new CCodeVariableDeclarator ("self"));
		
					cblock.add_statement (cdeclaration);
				}

				// other initialization code
				foreach (CodeNode stmt in m.body.get_statements ()) {
					var expr_stmt = stmt as ExpressionStatement;
					if (expr_stmt != null) {
						var prop = expr_stmt.assigned_property ();
						if (prop != null && prop.set_accessor.construction) {
							continue;
						}
					}
					if (stmt.ccodenode is CCodeFragment) {
						foreach (CCodeNode cstmt in ((CCodeFragment) stmt.ccodenode).get_children ()) {
							cblock.add_statement (cstmt);
						}
					} else {
						cblock.add_statement (stmt.ccodenode);
					}
				}
				
				m.body.ccodenode = cblock;
			}

			codegen.in_creation_method = false;
		}

		bool inner_error = codegen.current_method_inner_error;

		codegen.current_symbol = codegen.current_symbol.parent_symbol;
		codegen.current_method = old_method;
		codegen.current_return_type = old_return_type;
		codegen.current_method_inner_error = old_method_inner_error;
		codegen.next_temp_var_id = old_next_temp_var_id;

		if (codegen.current_type_symbol is Interface) {
			var iface = (Interface) codegen.current_type_symbol;
			if (iface.is_static) {
				return;
			}
		}

		codegen.function = new CCodeFunction (m.get_real_cname (), get_creturn_type (m, creturn_type.get_cname ()));
		m.ccodenode = codegen.function;

		if (m.is_inline) {
			codegen.function.modifiers |= CCodeModifiers.INLINE;
		}

		var cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

		CCodeFunctionDeclarator vdeclarator = null;

		if (m.parent_symbol is Class && m is CreationMethod) {
			var cl = (Class) m.parent_symbol;
			if (!cl.is_compact) {
				cparam_map.set (codegen.get_param_pos (m.cinstance_parameter_position), new CCodeFormalParameter ("object_type", "GType"));
			}
		} else if (m.binding == MemberBinding.INSTANCE || (m.parent_symbol is Struct && m is CreationMethod)) {
			TypeSymbol parent_type = find_parent_type (m);
			DataType this_type;
			if (parent_type is Class) {
				this_type = new ObjectType ((Class) parent_type);
			} else if (parent_type is Interface) {
				this_type = new ObjectType ((Interface) parent_type);
			} else {
				this_type = new ValueType (parent_type);
			}

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
			cparam_map.set (codegen.get_param_pos (m.cinstance_parameter_position), instance_param);

			if (m.is_abstract || m.is_virtual) {
				var vdecl = new CCodeDeclaration (get_creturn_type (m, creturn_type.get_cname ()));
				vdeclarator = new CCodeFunctionDeclarator (m.vfunc_name);
				vdecl.add_declarator (vdeclarator);
				codegen.type_struct.add_declaration (vdecl);
			}
		} else if (m.binding == MemberBinding.CLASS) {
			TypeSymbol parent_type = find_parent_type (m);
			DataType this_type;
			this_type = new ClassType ((Class) parent_type);
			var class_param = new CCodeFormalParameter ("klass", this_type.get_cname ());
			cparam_map.set (codegen.get_param_pos (m.cinstance_parameter_position), class_param);
		}

		if (!m.coroutine) {
			generate_cparameters (m, creturn_type, in_gtypeinstance_creation_method, cparam_map, codegen.function, vdeclarator);
		} else {
			// data struct to hold parameters, local variables, and the return value
			cparam_map.set (codegen.get_param_pos (0), new CCodeFormalParameter ("data", Symbol.lower_case_to_camel_case (m.get_cname ()) + "Data*"));

			generate_cparameters (m, creturn_type, in_gtypeinstance_creation_method, cparam_map, codegen.function, vdeclarator, null, null, 0);
		}

		bool visible = !m.is_internal_symbol ();

		// generate *_real_* functions for virtual methods
		// also generate them for abstract methods of classes to prevent faulty subclassing
		if (!m.is_abstract || (m.is_abstract && codegen.current_type_symbol is Class)) {
			if (visible && m.base_method == null && m.base_interface_method == null) {
				/* public methods need function declaration in
				 * header file except virtual/overridden methods */
				codegen.header_type_member_declaration.append (codegen.function.copy ());
			} else {
				/* declare all other functions in source file to
				 * avoid dependency on order within source file */
				codegen.function.modifiers |= CCodeModifiers.STATIC;
				codegen.source_type_member_declaration.append (codegen.function.copy ());
			}
		
			/* Methods imported from a plain C file don't
			 * have a body, e.g. Vala.Parser.parse_file () */
			if (m.body != null) {
				codegen.function.block = (CCodeBlock) m.body.ccodenode;
				codegen.function.block.line = codegen.function.line;

				var cinit = new CCodeFragment ();
				codegen.function.block.prepend_statement (cinit);

				if (m.coroutine) {
					var cswitch = new CCodeSwitchStatement (new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), "state"));
					cswitch.add_statement (new CCodeCaseStatement (new CCodeConstant ("0")));
					cswitch.add_statement (codegen.function.block);
					cswitch.add_statement (new CCodeReturnStatement (new CCodeConstant ("FALSE")));

					codegen.function.block = new CCodeBlock ();
					codegen.function.block.add_statement (cswitch);
				}

				if (m.parent_symbol is Class) {
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
						CCodeExpression cself = codegen.transform_expression (new CCodeIdentifier ("base"), base_expression_type, self_target_type);

						var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
						cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", cself));
					
						cinit.append (cdecl);
					} else if (m.binding == MemberBinding.INSTANCE
					           && !(m is CreationMethod)) {
						var ccheckstmt = create_method_type_check_statement (m, creturn_type, cl, true, "self");
						ccheckstmt.line = codegen.function.line;
						cinit.append (ccheckstmt);
					}
				}
				foreach (FormalParameter param in m.get_parameters ()) {
					if (param.ellipsis) {
						break;
					}

					var t = param.parameter_type.data_type;
					if (t != null && t.is_reference_type ()) {
						if (param.direction != ParameterDirection.OUT) {
							var type_check = create_method_type_check_statement (m, creturn_type, t, (codegen.context.non_null && !param.parameter_type.nullable), param.name);
							if (type_check != null) {
								type_check.line = codegen.function.line;
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
					codegen.source_type_member_definition.append (new CCodeComment (m.source_reference.comment));
				}
				codegen.source_type_member_definition.append (codegen.function);
			
				if (m is CreationMethod) {
					if (in_gobject_creation_method) {
						int n_params = ((CreationMethod) m).n_construction_params;

						if (n_params > 0 || codegen.current_class.get_type_parameters ().size > 0) {
							// declare construction parameter array
							var cparamsinit = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
							cparamsinit.add_argument (new CCodeIdentifier ("GParameter"));
							cparamsinit.add_argument (new CCodeConstant ((n_params + 3 * codegen.current_class.get_type_parameters ().size).to_string ()));
						
							var cdecl = new CCodeDeclaration ("GParameter *");
							cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("__params", cparamsinit));
							cinit.append (cdecl);
						
							cdecl = new CCodeDeclaration ("GParameter *");
							cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("__params_it", new CCodeIdentifier ("__params")));
							cinit.append (cdecl);
						}

						/* type, dup func, and destroy func properties for generic types */
						foreach (TypeParameter type_param in codegen.current_class.get_type_parameters ()) {
							CCodeConstant prop_name;
							CCodeIdentifier param_name;

							prop_name = new CCodeConstant ("\"%s-type\"".printf (type_param.name.down ()));
							param_name = new CCodeIdentifier ("%s_type".printf (type_param.name.down ()));
							cinit.append (new CCodeExpressionStatement (get_construct_property_assignment (prop_name, new ValueType (codegen.gtype_type), param_name)));

							prop_name = new CCodeConstant ("\"%s-dup-func\"".printf (type_param.name.down ()));
							param_name = new CCodeIdentifier ("%s_dup_func".printf (type_param.name.down ()));
							cinit.append (new CCodeExpressionStatement (get_construct_property_assignment (prop_name, new PointerType (new VoidType ()), param_name)));

							prop_name = new CCodeConstant ("\"%s-destroy-func\"".printf (type_param.name.down ()));
							param_name = new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.down ()));
							cinit.append (new CCodeExpressionStatement (get_construct_property_assignment (prop_name, new PointerType (new VoidType ()), param_name)));
						}
					} else if (in_gtypeinstance_creation_method) {
						var cl = (Class) m.parent_symbol;
						var cdecl = new CCodeDeclaration (cl.get_cname () + "*");
						var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_type_create_instance"));
						ccall.add_argument (new CCodeIdentifier ("object_type"));
						cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", new CCodeCastExpression (ccall, cl.get_cname () + "*")));
						cinit.append (cdecl);

						/* type, dup func, and destroy func fields for generic types */
						foreach (TypeParameter type_param in codegen.current_class.get_type_parameters ()) {
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
					} else if (codegen.current_type_symbol is Class) {
						var cl = (Class) m.parent_symbol;
						var cdecl = new CCodeDeclaration (cl.get_cname () + "*");
						var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_new0"));
						ccall.add_argument (new CCodeIdentifier (cl.get_cname ()));
						cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
						cinit.append (cdecl);

						var cinitcall = new CCodeFunctionCall (new CCodeIdentifier ("%s_instance_init".printf (cl.get_lower_case_cname (null))));
						cinitcall.add_argument (new CCodeIdentifier ("self"));
						cinit.append (new CCodeExpressionStatement (cinitcall));
					} else {
						var st = (Struct) m.parent_symbol;

						// memset needs string.h
						codegen.string_h_needed = true;
						var czero = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
						czero.add_argument (new CCodeIdentifier ("self"));
						czero.add_argument (new CCodeConstant ("0"));
						czero.add_argument (new CCodeIdentifier ("sizeof (%s)".printf (st.get_cname ())));
						cinit.append (new CCodeExpressionStatement (czero));
					}
				}

				if (codegen.context.module_init_method == m && codegen.in_plugin) {
					// GTypeModule-based plug-in, register types
					cinit.append (codegen.module_init_fragment);
				}

				foreach (Expression precondition in m.get_preconditions ()) {
					cinit.append (create_precondition_statement (m, creturn_type, precondition));
				}
			} else if (m.is_abstract) {
				// generate helpful error message if a sublcass does not implement an abstract method.
				// This is only meaningful for subclasses implemented in C since the vala compiler would
				// complain during compile time of such en error.

				var cblock = new CCodeBlock ();

				// add a typecheck statement for "self"
				cblock.add_statement (create_method_type_check_statement (m, creturn_type, codegen.current_type_symbol, true, "self"));

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
				cblock.add_statement (new CCodeReturnStatement (codegen.default_value_for_type (creturn_type, false)));

				codegen.function.block = cblock;
				codegen.source_type_member_definition.append (codegen.function);
			}
		}

		if (m.is_abstract || m.is_virtual) {
			var vfunc = new CCodeFunction (m.get_cname (), creturn_type.get_cname ());
			vfunc.line = codegen.function.line;

			ReferenceType this_type;
			if (m.parent_symbol is Class) {
				this_type = new ObjectType ((Class) m.parent_symbol);
			} else {
				this_type = new ObjectType ((Interface) m.parent_symbol);
			}

			cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);
			var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

			var cparam = new CCodeFormalParameter ("self", this_type.get_cname ());
			cparam_map.set (codegen.get_param_pos (m.cinstance_parameter_position), cparam);
			
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
			carg_map.set (codegen.get_param_pos (m.cinstance_parameter_position), new CCodeIdentifier ("self"));

			generate_cparameters (m, creturn_type, in_gtypeinstance_creation_method, cparam_map, vfunc, null, carg_map, vcall);

			CCodeStatement cstmt;
			if (creturn_type is VoidType) {
				cstmt = new CCodeExpressionStatement (vcall);
			} else if (m.get_postconditions ().size == 0) {
				/* pass method return value */
				cstmt = new CCodeReturnStatement (vcall);
			} else {
				/* store method return value for postconditions */
				var cdecl = new CCodeDeclaration (get_creturn_type (m, creturn_type.get_cname ()));
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
				codegen.header_type_member_declaration.append (vfunc.copy ());
			} else {
				vfunc.modifiers |= CCodeModifiers.STATIC;
				codegen.source_type_member_declaration.append (vfunc.copy ());
			}
			
			vfunc.block = vblock;

			if (m.is_abstract && m.source_reference != null && m.source_reference.comment != null) {
				codegen.source_type_member_definition.append (new CCodeComment (m.source_reference.comment));
			}
			codegen.source_type_member_definition.append (vfunc);
		}

		if (m.coroutine) {
			codegen.gio_h_needed = true;

			// generate struct to hold parameters, local variables, and the return value
			string dataname = Symbol.lower_case_to_camel_case (m.get_cname ()) + "Data";
			var datastruct = new CCodeStruct ("_" + dataname);

			datastruct.add_field ("int", "state");
			datastruct.add_field ("GAsyncReadyCallback", "callback");
			datastruct.add_field ("gpointer", "user_data");

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

			cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);

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

			generate_cparameters (m, creturn_type, in_gtypeinstance_creation_method, cparam_map, asyncfunc, null, null, null, 1);

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

			generate_cparameters (m, creturn_type, in_gtypeinstance_creation_method, cparam_map, finishfunc, null, null, null, 2);

			if (visible) {
				codegen.header_type_member_declaration.append (finishfunc.copy ());
			} else {
				finishfunc.modifiers |= CCodeModifiers.STATIC;
				codegen.source_type_member_declaration.append (finishfunc.copy ());
			}
			
			finishfunc.block = finishblock;

			codegen.source_type_member_definition.append (finishfunc);
		}

		if (m is CreationMethod) {
			if (codegen.current_class != null && !codegen.current_class.is_compact) {
				var vfunc = new CCodeFunction (m.get_cname (), creturn_type.get_cname ());
				vfunc.line = codegen.function.line;

				ReferenceType this_type = new ObjectType ((Class) m.parent_symbol);

				cparam_map = new HashMap<int,CCodeFormalParameter> (direct_hash, direct_equal);
				var carg_map = new HashMap<int,CCodeExpression> (direct_hash, direct_equal);

				var vblock = new CCodeBlock ();

				var vcall = new CCodeFunctionCall (new CCodeIdentifier (m.get_real_cname ()));
				vcall.add_argument (new CCodeIdentifier (codegen.current_class.get_type_id ()));

				generate_cparameters (m, creturn_type, in_gtypeinstance_creation_method, cparam_map, vfunc, null, carg_map, vcall);
				CCodeStatement cstmt = new CCodeReturnStatement (vcall);
				cstmt.line = vfunc.line;
				vblock.add_statement (cstmt);

				if (visible) {
					codegen.header_type_member_declaration.append (vfunc.copy ());
				} else {
					vfunc.modifiers |= CCodeModifiers.STATIC;
					codegen.source_type_member_declaration.append (vfunc.copy ());
				}
			
				vfunc.block = vblock;

				codegen.source_type_member_definition.append (vfunc);
			}

			if (codegen.current_class != null && codegen.current_class.is_subtype_of (codegen.gobject_type)
			    && (((CreationMethod) m).n_construction_params > 0 || codegen.current_class.get_type_parameters ().size > 0)) {
				var ccond = new CCodeBinaryExpression (CCodeBinaryOperator.GREATER_THAN, new CCodeIdentifier ("__params_it"), new CCodeIdentifier ("__params"));
				var cdofreeparam = new CCodeBlock ();
				cdofreeparam.add_statement (new CCodeExpressionStatement (new CCodeUnaryExpression (CCodeUnaryOperator.PREFIX_DECREMENT, new CCodeIdentifier ("__params_it"))));
				var cunsetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_value_unset"));
				cunsetcall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess.pointer (new CCodeIdentifier ("__params_it"), "value")));
				cdofreeparam.add_statement (new CCodeExpressionStatement (cunsetcall));
				codegen.function.block.add_statement (new CCodeWhileStatement (ccond, cdofreeparam));

				var cfreeparams = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
				cfreeparams.add_argument (new CCodeIdentifier ("__params"));
				codegen.function.block.add_statement (new CCodeExpressionStatement (cfreeparams));
			}

			if (codegen.current_type_symbol is Class) {
				CCodeExpression cresult = new CCodeIdentifier ("self");
				if (get_custom_creturn_type (m) != null) {
					cresult = new CCodeCastExpression (cresult, get_custom_creturn_type (m));
				}

				var creturn = new CCodeReturnStatement ();
				creturn.return_expression = cresult;
				codegen.function.block.add_statement (creturn);
			}
		}
		
		bool return_value = true;
		bool args_parameter = true;
		if (is_possible_entry_point (m, ref return_value, ref args_parameter)) {
			// m is possible entry point, add appropriate startup code
			var cmain = new CCodeFunction ("main", "int");
			cmain.line = codegen.function.line;
			cmain.add_parameter (new CCodeFormalParameter ("argc", "int"));
			cmain.add_parameter (new CCodeFormalParameter ("argv", "char **"));
			var main_block = new CCodeBlock ();

			if (codegen.context.thread) {
				var thread_init_call = new CCodeFunctionCall (new CCodeIdentifier ("g_thread_init"));
				thread_init_call.line = cmain.line;
				thread_init_call.add_argument (new CCodeConstant ("NULL"));
				main_block.add_statement (new CCodeExpressionStatement (thread_init_call)); 
			}

			var type_init_call = new CCodeExpressionStatement (new CCodeFunctionCall (new CCodeIdentifier ("g_type_init")));
			type_init_call.line = cmain.line;
			main_block.add_statement (type_init_call);

			var main_call = new CCodeFunctionCall (new CCodeIdentifier (codegen.function.name));
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
			codegen.source_type_member_definition.append (cmain);
		}
	}

	public override void generate_cparameters (Method m, DataType creturn_type, bool in_gtypeinstance_creation_method, Map<int,CCodeFormalParameter> cparam_map, CCodeFunction func, CCodeFunctionDeclarator? vdeclarator = null, Map<int,CCodeExpression>? carg_map = null, CCodeFunctionCall? vcall = null, int direction = 3) {
		if (in_gtypeinstance_creation_method) {
			// memory management for generic types
			int type_param_index = 0;
			foreach (TypeParameter type_param in codegen.current_class.get_type_parameters ()) {
				cparam_map.set (codegen.get_param_pos (0.1 * type_param_index + 0.01), new CCodeFormalParameter ("%s_type".printf (type_param.name.down ()), "GType"));
				cparam_map.set (codegen.get_param_pos (0.1 * type_param_index + 0.02), new CCodeFormalParameter ("%s_dup_func".printf (type_param.name.down ()), "GBoxedCopyFunc"));
				cparam_map.set (codegen.get_param_pos (0.1 * type_param_index + 0.03), new CCodeFormalParameter ("%s_destroy_func".printf (type_param.name.down ()), "GDestroyNotify"));
				if (carg_map != null) {
					carg_map.set (codegen.get_param_pos (0.1 * type_param_index + 0.01), new CCodeIdentifier ("%s_type".printf (type_param.name.down ())));
					carg_map.set (codegen.get_param_pos (0.1 * type_param_index + 0.02), new CCodeIdentifier ("%s_dup_func".printf (type_param.name.down ())));
					carg_map.set (codegen.get_param_pos (0.1 * type_param_index + 0.03), new CCodeIdentifier ("%s_destroy_func".printf (type_param.name.down ())));
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

			if (!param.no_array_length && param.parameter_type is ArrayType) {
				var array_type = (ArrayType) param.parameter_type;
				
				var length_ctype = "int";
				if (param.direction != ParameterDirection.IN) {
					length_ctype = "int*";
				}
				
				for (int dim = 1; dim <= array_type.rank; dim++) {
					var cparam = new CCodeFormalParameter (head.get_array_length_cname (param.name, dim), length_ctype);
					cparam_map.set (codegen.get_param_pos (param.carray_length_parameter_position + 0.01 * dim), cparam);
					if (carg_map != null) {
						carg_map.set (codegen.get_param_pos (param.carray_length_parameter_position + 0.01 * dim), new CCodeIdentifier (cparam.name));
					}
				}
			}

			cparam_map.set (codegen.get_param_pos (param.cparameter_position), (CCodeFormalParameter) param.ccodenode);
			if (carg_map != null) {
				carg_map.set (codegen.get_param_pos (param.cparameter_position), new CCodeIdentifier (param.name));
			}

			if (param.parameter_type is DelegateType) {
				var deleg_type = (DelegateType) param.parameter_type;
				var d = deleg_type.delegate_symbol;
				if (d.has_target) {
					var cparam = new CCodeFormalParameter (codegen.get_delegate_target_cname (param.name), "void*");
					cparam_map.set (codegen.get_param_pos (param.cdelegate_target_parameter_position), cparam);
					if (carg_map != null) {
						carg_map.set (codegen.get_param_pos (param.cdelegate_target_parameter_position), new CCodeIdentifier (cparam.name));
					}
					if (deleg_type.value_owned) {
						cparam = new CCodeFormalParameter (codegen.get_delegate_target_destroy_notify_cname (param.name), "GDestroyNotify");
						cparam_map.set (codegen.get_param_pos (param.cdelegate_target_parameter_position + 0.01), cparam);
						if (carg_map != null) {
							carg_map.set (codegen.get_param_pos (param.cdelegate_target_parameter_position + 0.01), new CCodeIdentifier (cparam.name));
						}
					}
				}
			} else if (param.parameter_type is MethodType) {
				var cparam = new CCodeFormalParameter (codegen.get_delegate_target_cname (param.name), "void*");
				cparam_map.set (codegen.get_param_pos (param.cdelegate_target_parameter_position), cparam);
				if (carg_map != null) {
					carg_map.set (codegen.get_param_pos (param.cdelegate_target_parameter_position), new CCodeIdentifier (cparam.name));
				}
			}
		}

		if ((direction & 2) != 0) {
			if (!m.no_array_length && creturn_type is ArrayType) {
				// return array length if appropriate
				var array_type = (ArrayType) creturn_type;

				for (int dim = 1; dim <= array_type.rank; dim++) {
					var cparam = new CCodeFormalParameter (head.get_array_length_cname ("result", dim), "int*");
					cparam_map.set (codegen.get_param_pos (m.carray_length_parameter_position + 0.01 * dim), cparam);
					if (carg_map != null) {
						carg_map.set (codegen.get_param_pos (m.carray_length_parameter_position + 0.01 * dim), new CCodeIdentifier (cparam.name));
					}
				}
			} else if (creturn_type is DelegateType) {
				// return delegate target if appropriate
				var deleg_type = (DelegateType) creturn_type;
				var d = deleg_type.delegate_symbol;
				if (d.has_target) {
					var cparam = new CCodeFormalParameter (codegen.get_delegate_target_cname ("result"), "void*");
					cparam_map.set (codegen.get_param_pos (m.cdelegate_target_parameter_position), cparam);
					if (carg_map != null) {
						carg_map.set (codegen.get_param_pos (m.cdelegate_target_parameter_position), new CCodeIdentifier (cparam.name));
					}
				}
			}

			if (m.get_error_types ().size > 0) {
				var cparam = new CCodeFormalParameter ("error", "GError**");
				cparam_map.set (codegen.get_param_pos (-1), cparam);
				if (carg_map != null) {
					carg_map.set (codegen.get_param_pos (-1), new CCodeIdentifier (cparam.name));
				}
			}
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
				vcall.add_argument (carg_map.get (min_pos));
			}
			last_pos = min_pos;
		}
	}

	private CCodeStatement create_method_type_check_statement (Method m, DataType return_type, TypeSymbol t, bool non_null, string var_name) {
		return codegen.create_type_check_statement (m, return_type, t, non_null, var_name);
	}

	private CCodeStatement create_precondition_statement (CodeNode method_node, DataType ret_type, Expression precondition) {
		var ccheck = new CCodeFunctionCall ();

		ccheck.add_argument ((CCodeExpression) precondition.ccodenode);

		if (ret_type is VoidType) {
			/* void function */
			ccheck.call = new CCodeIdentifier ("g_return_if_fail");
		} else {
			ccheck.call = new CCodeIdentifier ("g_return_val_if_fail");

			var cdefault = codegen.default_value_for_type (ret_type, false);
			if (cdefault != null) {
				ccheck.add_argument (cdefault);
			} else {
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

	private TypeSymbol? find_parent_type (Symbol sym) {
		while (sym != null) {
			if (sym is TypeSymbol) {
				return (TypeSymbol) sym;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}

	private bool is_possible_entry_point (Method m, ref bool return_value, ref bool args_parameter) {
		if (m.name == null || m.name != "main") {
			// method must be called "main"
			return false;
		}
		
		if (m.binding == MemberBinding.INSTANCE) {
			// method must be static
			return false;
		}
		
		if (m.return_type.data_type == null) {
			return_value = false;
		} else if (m.return_type.data_type == codegen.int_type.data_type) {
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

		if (param.direction == ParameterDirection.OUT) {
			// parameter must not be an out parameter
			return false;
		}
		
		if (!(param.parameter_type is ArrayType)) {
			// parameter must be an array
			return false;
		}
		
		var array_type = (ArrayType) param.parameter_type;
		if (array_type.element_type.data_type != codegen.string_type.data_type) {
			// parameter must be an array of strings
			return false;
		}
		
		args_parameter = true;
		return true;
	}

	private void add_object_creation (CCodeBlock b, bool has_params) {
		var cl = (Class) codegen.current_type_symbol;

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
		    && cl.base_class != codegen.gobject_type) {
			// possibly report warning or error about missing base call
		}

		var cdecl = new CCodeVariableDeclarator ("self");
		if (chain_up) {
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
		if (m.body != null && codegen.current_type_symbol is Class && codegen.current_class.is_subtype_of (codegen.gobject_type)) {
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
	}
}
