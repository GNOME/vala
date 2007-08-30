/* valacodegeneratormethod.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;
using Gee;

public class Vala.CodeGenerator {
	public override void visit_method (Method! m) {
		Method old_method = current_method;
		TypeReference old_return_type = current_return_type;
		bool old_method_inner_error = current_method_inner_error;
		current_symbol = m;
		current_method = m;
		current_return_type = m.return_type;
		current_method_inner_error = false;

		if (m is CreationMethod) {
			in_creation_method = true;
		}

		m.accept_children (this);

		if (m is CreationMethod) {
			if (current_type_symbol is Class && current_class.is_subtype_of (gobject_type) && m.body != null) {
				var cblock = new CCodeBlock ();
				
				foreach (CodeNode stmt in m.body.get_statements ()) {
					if (((ExpressionStatement) stmt).assigned_property ().set_accessor.construction) {
						if (stmt.ccodenode is CCodeFragment) {
							foreach (CCodeStatement cstmt in ((CCodeFragment) stmt.ccodenode).get_children ()) {
								cblock.add_statement (cstmt);
							}
						} else {
							cblock.add_statement ((CCodeStatement) stmt.ccodenode);
						}
					}
				}

				add_object_creation (cblock, ((CreationMethod) m).n_construction_params > 0);
				
				foreach (CodeNode stmt in m.body.get_statements ()) {
					if (!((ExpressionStatement) stmt).assigned_property ().set_accessor.construction) {
						if (stmt.ccodenode is CCodeFragment) {
							foreach (CCodeStatement cstmt in ((CCodeFragment) stmt.ccodenode).get_children ()) {
								cblock.add_statement (cstmt);
							}
						} else {
							cblock.add_statement ((CCodeStatement) stmt.ccodenode);
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

		if (current_type_symbol != null && current_type_symbol is Interface) {
			var iface = (Interface) current_type_symbol;
			if (iface.is_static) {
				return;
			}
		}

		function = new CCodeFunction (m.get_real_cname (), m.return_type.get_cname ());
		CCodeFunctionDeclarator vdeclarator = null;
		
		CCodeFormalParameter instance_param = null;
		
		if (m.instance) {
			var this_type = new TypeReference ();
			this_type.data_type = find_parent_type (m);
			if (m.base_interface_method != null) {
				var base_type = new TypeReference ();
				base_type.data_type = (DataType) m.base_interface_method.parent_symbol;
				instance_param = new CCodeFormalParameter ("base", base_type.get_cname ());
			} else if (m.overrides) {
				var base_type = new TypeReference ();
				base_type.data_type = (DataType) m.base_method.parent_symbol;
				instance_param = new CCodeFormalParameter ("base", base_type.get_cname ());
			} else {
				if (m.instance_by_reference) {
					instance_param = new CCodeFormalParameter ("*self", this_type.get_cname ());
				} else {
					instance_param = new CCodeFormalParameter ("self", this_type.get_cname ());
				}
			}
			if (!m.instance_last) {
				function.add_parameter (instance_param);
			}
			
			if (m.is_abstract || m.is_virtual) {
				var vdecl = new CCodeDeclaration (m.return_type.get_cname ());
				vdeclarator = new CCodeFunctionDeclarator (m.vfunc_name);
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);

				vdeclarator.add_parameter (instance_param);
			}
		}

		if (m is CreationMethod && current_type_symbol is Class && current_class.is_subtype_of (gobject_type)) {
			// memory management for generic types
			foreach (TypeParameter type_param in current_class.get_type_parameters ()) {
				function.add_parameter (new CCodeFormalParameter ("%s_dup_func".printf (type_param.name.down ()), "GBoxedCopyFunc"));
				function.add_parameter (new CCodeFormalParameter ("%s_destroy_func".printf (type_param.name.down ()), "GDestroyNotify"));
			}
		}

		var params = m.get_parameters ();
		foreach (FormalParameter param in params) {
			if (!param.no_array_length && param.type_reference.data_type is Array) {
				var arr = (Array) param.type_reference.data_type;
				
				var length_ctype = "int";
				if (param.type_reference.is_out) {
					length_ctype = "int*";
				}
				
				for (int dim = 1; dim <= arr.rank; dim++) {
					var cparam = new CCodeFormalParameter (get_array_length_cname (param.name, dim), length_ctype);
					function.add_parameter (cparam);
					if (vdeclarator != null) {
						vdeclarator.add_parameter (cparam);
					}
				}
			}
		
			function.add_parameter ((CCodeFormalParameter) param.ccodenode);
			if (vdeclarator != null) {
				vdeclarator.add_parameter ((CCodeFormalParameter) param.ccodenode);
			}
		}

		// return array length if appropriate
		if (!m.no_array_length && m.return_type.data_type is Array) {
			var arr = (Array) m.return_type.data_type;

			for (int dim = 1; dim <= arr.rank; dim++) {
				var cparam = new CCodeFormalParameter (get_array_length_cname ("result", dim), "int*");
				function.add_parameter (cparam);
				if (vdeclarator != null) {
					vdeclarator.add_parameter (cparam);
				}
			}
		}

		if (m.instance && m.instance_last) {
			function.add_parameter (instance_param);
		}

		if (m.get_error_domains ().size > 0) {
			var cparam = new CCodeFormalParameter ("error", "GError**");
			function.add_parameter (cparam);
			if (vdeclarator != null) {
				vdeclarator.add_parameter (cparam);
			}
		}

		bool visible = m.access != MemberAccessibility.PRIVATE;
		if (m.parent_symbol is DataType) {
			var dt = (DataType) m.parent_symbol;
			visible = visible && dt.access != MemberAccessibility.PRIVATE;
		}

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

				var cinit = new CCodeFragment ();
				function.block.prepend_statement (cinit);

				if (m.parent_symbol is Class) {
					var cl = (Class) m.parent_symbol;
					if (m.overrides || m.base_interface_method != null) {
						CCodeExpression cself;
						if (context.debug) {
							var ccall = new CCodeFunctionCall (new CCodeIdentifier (cl.get_upper_case_cname (null)));
							ccall.add_argument (new CCodeIdentifier ("base"));
							cself = ccall;
						} else {
							cself = new CCodeCastExpression (new CCodeIdentifier ("base"), cl.get_cname () + "*");
						}
						
						var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
						cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", cself));
						
						cinit.append (cdecl);
					} else if (m.instance) {
						cinit.append (create_method_type_check_statement (m, cl, true, "self"));
					}
				}
				foreach (FormalParameter param in m.get_parameters ()) {
					var t = param.type_reference.data_type;
					if (t != null && t.is_reference_type () && !param.type_reference.is_out) {
						var type_check = create_method_type_check_statement (m, t, param.type_reference.non_null, param.name);
						if (type_check != null) {
							cinit.append (type_check);
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
					if (current_type_symbol is Class && current_class.is_subtype_of (gobject_type)) {
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

						/* dup and destroy func properties for generic types */
						foreach (TypeParameter type_param in current_class.get_type_parameters ()) {
							string func_name;
							CCodeMemberAccess cmember;
							CCodeAssignment cassign;

							func_name = "%s_dup_func".printf (type_param.name.down ());
							cmember = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
							cassign = new CCodeAssignment (cmember, new CCodeIdentifier (func_name));
							function.block.add_statement (new CCodeExpressionStatement (cassign));

							func_name = "%s_destroy_func".printf (type_param.name.down ());
							cmember = new CCodeMemberAccess.pointer (new CCodeMemberAccess.pointer (new CCodeIdentifier ("self"), "priv"), func_name);
							cassign = new CCodeAssignment (cmember, new CCodeIdentifier (func_name));
							function.block.add_statement (new CCodeExpressionStatement (cassign));
						}
					} else if (current_type_symbol is Class) {
						var cl = (Class) m.parent_symbol;
						var cdecl = new CCodeDeclaration (cl.get_cname () + "*");
						var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_new0"));
						ccall.add_argument (new CCodeIdentifier (cl.get_cname ()));
						cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
						cinit.append (cdecl);
					} else {
						var st = (Struct) m.parent_symbol;
						var cdecl = new CCodeDeclaration (st.get_cname () + "*");
						var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_slice_new0"));
						ccall.add_argument (new CCodeIdentifier (st.get_cname ()));
						cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
						cinit.append (cdecl);
					}
				}

				if (context.module_init_method == m && in_plugin) {
					// GTypeModule-based plug-in, register types
					cinit.append (module_init_fragment);
				}
			}
		}
		
		if (m.is_abstract || m.is_virtual) {
			var vfunc = new CCodeFunction (m.get_cname (), m.return_type.get_cname ());

			var this_type = new TypeReference ();
			this_type.data_type = (DataType) m.parent_symbol;

			var cparam = new CCodeFormalParameter ("self", this_type.get_cname ());
			vfunc.add_parameter (cparam);
			
			var vblock = new CCodeBlock ();
			
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
			vcall.add_argument (new CCodeIdentifier ("self"));
		
			var params = m.get_parameters ();
			foreach (FormalParameter param in params) {
				if (!param.no_array_length && param.type_reference.data_type is Array) {
					var arr = (Array) param.type_reference.data_type;
					
					var length_ctype = "int";
					if (param.type_reference.is_out) {
						length_ctype = "int*";
					}
					
					for (int dim = 1; dim <= arr.rank; dim++) {
						var cparam = new CCodeFormalParameter (get_array_length_cname (param.name, dim), length_ctype);
						vfunc.add_parameter (cparam);
						vcall.add_argument (new CCodeIdentifier (cparam.name));
					}
				}

				vfunc.add_parameter ((CCodeFormalParameter) param.ccodenode);
				vcall.add_argument (new CCodeIdentifier (param.name));
			}

			// return array length if appropriate
			if (!m.no_array_length && m.return_type.data_type is Array) {
				var arr = (Array) m.return_type.data_type;

				for (int dim = 1; dim <= arr.rank; dim++) {
					var cparam = new CCodeFormalParameter (get_array_length_cname ("result", dim), "int*");
					vfunc.add_parameter (cparam);
					vcall.add_argument (new CCodeIdentifier (cparam.name));
				}
			}

			if (m.get_error_domains ().size > 0) {
				var cparam = new CCodeFormalParameter ("error", "GError**");
				vfunc.add_parameter (cparam);
				vcall.add_argument (new CCodeIdentifier (cparam.name));
			}

			if (m.return_type.data_type == null) {
				vblock.add_statement (new CCodeExpressionStatement (vcall));
			} else {
				/* pass method return value */
				vblock.add_statement (new CCodeReturnStatement (vcall));
			}

			if (visible) {
				header_type_member_declaration.append (vfunc.copy ());
			} else {
				vfunc.modifiers |= CCodeModifiers.STATIC;
				source_type_member_declaration.append (vfunc.copy ());
			}
			
			vfunc.block = vblock;
			
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

			var creturn = new CCodeReturnStatement ();
			creturn.return_expression = new CCodeIdentifier ("self");
			function.block.add_statement (creturn);
		}
		
		bool return_value = true;
		bool args_parameter = true;
		if (is_possible_entry_point (m, ref return_value, ref args_parameter)) {
			// m is possible entry point, add appropriate startup code
			var cmain = new CCodeFunction ("main", "int");
			cmain.add_parameter (new CCodeFormalParameter ("argc", "int"));
			cmain.add_parameter (new CCodeFormalParameter ("argv", "char **"));
			var main_block = new CCodeBlock ();

			if (context.thread) {
				var thread_init_call = new CCodeFunctionCall (new CCodeIdentifier ("g_thread_init"));
				thread_init_call.add_argument (new CCodeConstant ("NULL"));
				main_block.add_statement (new CCodeExpressionStatement (thread_init_call)); 
			}

			main_block.add_statement (new CCodeExpressionStatement (new CCodeFunctionCall (new CCodeIdentifier ("g_type_init"))));
			var main_call = new CCodeFunctionCall (new CCodeIdentifier (function.name));
			if (args_parameter) {
				main_call.add_argument (new CCodeIdentifier ("argc"));
				main_call.add_argument (new CCodeIdentifier ("argv"));
			}
			if (return_value) {
				main_block.add_statement (new CCodeReturnStatement (main_call));
			} else {
				// method returns void, always use 0 as exit code
				main_block.add_statement (new CCodeExpressionStatement (main_call));
				main_block.add_statement (new CCodeReturnStatement (new CCodeConstant ("0")));
			}
			cmain.block = main_block;
			source_type_member_definition.append (cmain);
		}
	}
	
	private CCodeStatement create_method_type_check_statement (Method! m, DataType! t, bool non_null, string! var_name) {
		return create_type_check_statement (m, m.return_type.data_type, t, non_null, var_name);
	}
	
	private CCodeStatement create_property_type_check_statement (Property! prop, bool getter, DataType! t, bool non_null, string! var_name) {
		if (getter) {
			return create_type_check_statement (prop, prop.type_reference.data_type, t, non_null, var_name);
		} else {
			return create_type_check_statement (prop, null, t, non_null, var_name);
		}
	}
	
	private CCodeStatement create_type_check_statement (CodeNode! method_node, DataType ret_type, DataType! t, bool non_null, string! var_name) {
		var ccheck = new CCodeFunctionCall ();
		
		if ((t is Class && ((Class) t).get_is_gobject ()) || (t is Interface && !((Interface) t).declaration_only)) {
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
		
		if (ret_type == null) {
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

	private CCodeExpression default_value_for_type (DataType! type) {
		if (type.is_reference_type () || type is Pointer) {
			return new CCodeConstant ("NULL");
		} else if (type.get_default_value () != null) {
			return new CCodeConstant (type.get_default_value ());
		}
		return null;
	}

	private DataType find_parent_type (Symbol sym) {
		while (sym != null) {
			if (sym is DataType) {
				return (DataType) sym;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}
	
	private string! get_array_length_cname (string! array_cname, int dim) {
		return "%s_length%d".printf (array_cname, dim);
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
		
		if (!(param.type_reference.data_type is Array)) {
			// parameter must be an array
			return false;
		}
		
		var array_type = (Array) param.type_reference.data_type;
		if (array_type.element_type != string_type.data_type) {
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
}

