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

public class Vala.CodeGenerator {
	public override void visit_method (Method! m) {
		current_symbol = m.symbol;
		current_return_type = m.return_type;

		if (m is CreationMethod) {
			in_creation_method = true;
		}

		m.accept_children (this);

		if (m is CreationMethod) {
			if (current_class != null && m.body != null) {
				add_object_creation ((CCodeBlock) m.body.ccodenode);
			}

			in_creation_method = false;
		}

		current_symbol = current_symbol.parent_symbol;
		current_return_type = null;

		if (current_type_symbol != null && current_type_symbol.node is Interface) {
			var iface = (Interface) current_type_symbol.node;
			if (iface.is_static) {
				return;
			}
		}

		if (current_symbol.parent_symbol != null &&
		    current_symbol.parent_symbol.node is Method) {
			/* lambda expressions produce nested methods */
			var up_method = (Method) current_symbol.parent_symbol.node;
			current_return_type = up_method.return_type;
		}

		function = new CCodeFunction (m.get_real_cname (), m.return_type.get_cname ());
		CCodeFunctionDeclarator vdeclarator = null;
		
		CCodeFormalParameter instance_param = null;
		
		if (m.instance) {
			var this_type = new TypeReference ();
			this_type.data_type = find_parent_type (m);
			if (m.base_interface_method != null) {
				var base_type = new TypeReference ();
				base_type.data_type = (DataType) m.base_interface_method.symbol.parent_symbol.node;
				instance_param = new CCodeFormalParameter ("base", base_type.get_cname ());
			} else if (m.overrides) {
				var base_type = new TypeReference ();
				base_type.data_type = (DataType) m.base_method.symbol.parent_symbol.node;
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
				vdeclarator = new CCodeFunctionDeclarator (m.name);
				vdecl.add_declarator (vdeclarator);
				type_struct.add_declaration (vdecl);

				vdeclarator.add_parameter (instance_param);
			}
		}

		if (m is CreationMethod && current_class != null) {
			// memory management for generic types
			foreach (TypeParameter type_param in current_class.get_type_parameters ()) {
				var cparam = new CCodeFormalParameter ("%s_destroy_func".printf (type_param.name.down ()), "GDestroyNotify");
				function.add_parameter (cparam);
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
		
		if (m.instance && m.instance_last) {
			function.add_parameter (instance_param);
		}

		/* real function declaration and definition not needed
		 * for abstract methods */
		if (!m.is_abstract) {
			if (m.access != MemberAccessibility.PRIVATE && m.base_method == null && m.base_interface_method == null) {
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

				if (m.symbol.parent_symbol.node is Class) {
					var cl = (Class) m.symbol.parent_symbol.node;
					if (m.overrides || m.base_interface_method != null) {
						var ccall = new CCodeFunctionCall (new CCodeIdentifier (cl.get_upper_case_cname (null)));
						ccall.add_argument (new CCodeIdentifier ("base"));
						
						var cdecl = new CCodeDeclaration ("%s *".printf (cl.get_cname ()));
						cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("self", ccall));
						
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

				if (m.source_reference != null && m.source_reference.comment != null) {
					source_type_member_definition.append (new CCodeComment (m.source_reference.comment));
				}
				source_type_member_definition.append (function);
				
				if (m is CreationMethod) {
					if (current_class != null) {
						int n_params = ((CreationMethod) m).n_construction_params;
						n_params += (int) current_class.get_type_parameters ().length ();

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

						/* destroy func properties for generic types */
						foreach (TypeParameter type_param in current_class.get_type_parameters ()) {
							string func_name = "%s_destroy_func".printf (type_param.name.down ());
							var func_name_constant = new CCodeConstant ("\"%s-destroy-func\"".printf (type_param.name.down ()));

							// this property is used as a construction parameter
							var cpointer = new CCodeIdentifier ("__params_it");

							var ccomma = new CCodeCommaExpression ();
							// set name in array for current parameter
							var cnamemember = new CCodeMemberAccess.pointer (cpointer, "name");
							ccomma.append_expression (new CCodeAssignment (cnamemember, func_name_constant));
							var gvaluearg = new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, new CCodeMemberAccess.pointer (cpointer, "value"));

							// initialize GValue in array for current parameter
							var cvalueinit = new CCodeFunctionCall (new CCodeIdentifier ("g_value_init"));
							cvalueinit.add_argument (gvaluearg);
							cvalueinit.add_argument (new CCodeIdentifier ("G_TYPE_POINTER"));
							ccomma.append_expression (cvalueinit);

							// set GValue for current parameter
							var cvalueset = new CCodeFunctionCall (new CCodeIdentifier ("g_value_set_pointer"));
							cvalueset.add_argument (gvaluearg);
							cvalueset.add_argument (new CCodeIdentifier (func_name));
							ccomma.append_expression (cvalueset);

							// move pointer to next parameter in array
							ccomma.append_expression (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, cpointer));

							cinit.append (new CCodeExpressionStatement (ccomma));
						}
					} else {
						var st = (Struct) m.symbol.parent_symbol.node;
						var cdecl = new CCodeDeclaration (st.get_cname () + "*");
						var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
						ccall.add_argument (new CCodeConstant (st.get_cname ()));
						ccall.add_argument (new CCodeConstant ("1"));
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
			this_type.data_type = (DataType) m.symbol.parent_symbol.node;

			var cparam = new CCodeFormalParameter ("self", this_type.get_cname ());
			vfunc.add_parameter (cparam);
			
			var vblock = new CCodeBlock ();
			
			CCodeFunctionCall vcast = null;
			if (m.symbol.parent_symbol.node is Interface) {
				var iface = (Interface) m.symbol.parent_symbol.node;

				vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_INTERFACE".printf (iface.get_upper_case_cname (null))));
			} else {
				var cl = (Class) m.symbol.parent_symbol.node;

				vcast = new CCodeFunctionCall (new CCodeIdentifier ("%s_GET_CLASS".printf (cl.get_upper_case_cname (null))));
			}
			vcast.add_argument (new CCodeIdentifier ("self"));
		
			var vcall = new CCodeFunctionCall (new CCodeMemberAccess.pointer (vcast, m.name));
			vcall.add_argument (new CCodeIdentifier ("self"));
		
			var params = m.get_parameters ();
			foreach (FormalParameter param in params) {
				vfunc.add_parameter ((CCodeFormalParameter) param.ccodenode);
				vcall.add_argument (new CCodeIdentifier (param.name));
			}

			if (m.return_type.data_type == null) {
				vblock.add_statement (new CCodeExpressionStatement (vcall));
			} else {
				/* pass method return value */
				vblock.add_statement (new CCodeReturnStatement (vcall));
			}

			header_type_member_declaration.append (vfunc.copy ());
			
			vfunc.block = vblock;
			
			source_type_member_definition.append (vfunc);
		}
		
		if (m is CreationMethod) {
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
	
	private ref CCodeStatement create_method_type_check_statement (Method! m, DataType! t, bool non_null, string! var_name) {
		return create_type_check_statement (m, m.return_type.data_type, t, non_null, var_name);
	}
	
	private ref CCodeStatement create_property_type_check_statement (Property! prop, bool getter, DataType! t, bool non_null, string! var_name) {
		if (getter) {
			return create_type_check_statement (prop, prop.type_reference.data_type, t, non_null, var_name);
		} else {
			return create_type_check_statement (prop, null, t, non_null, var_name);
		}
	}
	
	private ref CCodeStatement create_type_check_statement (CodeNode! method_node, DataType ret_type, DataType! t, bool non_null, string! var_name) {
		var ccheck = new CCodeFunctionCall ();
		
		if (t is Class || t is Interface) {
			var ctype_check = new CCodeFunctionCall (new CCodeIdentifier (t.get_upper_case_cname ("IS_")));
			ctype_check.add_argument (new CCodeIdentifier (var_name));
			
			ref CCodeExpression cexpr = ctype_check;
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
			
			if (ret_type.is_reference_type () || ret_type is Pointer) {
				ccheck.add_argument (new CCodeConstant ("NULL"));
			} else if (ret_type.get_default_value () != null) {
				ccheck.add_argument (new CCodeConstant (ret_type.get_default_value ()));
			} else {
				Report.warning (method_node.source_reference, "not supported return type for runtime type checks");
				return new CCodeExpressionStatement (new CCodeConstant ("0"));
			}
		}
		
		return new CCodeExpressionStatement (ccheck);
	}

	private DataType find_parent_type (CodeNode node) {
		var sym = node.symbol;
		while (sym != null) {
			if (sym.node is DataType) {
				return (DataType) sym.node;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}
	
	private ref string! get_array_length_cname (string! array_cname, int dim) {
		return "%s_length%d".printf (array_cname, dim);
	}

	public override void visit_creation_method (CreationMethod! m) {
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
		if (params.length () == 0) {
			// method may have no parameters
			args_parameter = false;
			return true;
		}
		
		if (params.length () > 1) {
			// method must not have more than one parameter
			return false;
		}
		
		var param = (FormalParameter) params.data;

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
}

