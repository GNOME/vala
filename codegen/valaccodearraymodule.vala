/* valaccodearraymodule.vala
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

using Gee;

internal class Vala.CCodeArrayModule : CCodeMethodCallModule {
	int next_array_dup_id = 0;
	int next_array_add_id = 0;

	public CCodeArrayModule (CCodeGenerator codegen, CCodeModule? next) {
		base (codegen, next);
	}

	void append_initializer_list (CCodeCommaExpression ce, CCodeExpression name_cnode, InitializerList initializer_list, int rank, ref int i) {
		foreach (Expression e in initializer_list.get_initializers ()) {
			if (rank > 1) {
				append_initializer_list (ce, name_cnode, (InitializerList) e, rank - 1, ref i);
			} else {
				ce.append_expression (new CCodeAssignment (new CCodeElementAccess (name_cnode, new CCodeConstant (i.to_string ())), (CCodeExpression) e.ccodenode));
				i++;
			}
		}
	}

	public override void visit_array_creation_expression (ArrayCreationExpression expr) {
		expr.accept_children (codegen);

		var array_type = expr.target_type as ArrayType;
		if (array_type != null && array_type.fixed_length) {
			// no heap allocation for fixed-length arrays

			var ce = new CCodeCommaExpression ();
			var temp_var = get_temp_variable (array_type, true, expr);
			var name_cnode = new CCodeIdentifier (temp_var.name);
			int i = 0;

			temp_vars.insert (0, temp_var);

			append_initializer_list (ce, name_cnode, expr.initializer_list, expr.rank, ref i);

			ce.append_expression (name_cnode);

			expr.ccodenode = ce;

			return;
		}

		var gnew = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
		gnew.add_argument (new CCodeIdentifier (expr.element_type.get_cname ()));
		bool first = true;
		CCodeExpression cexpr = null;

		// iterate over each dimension
		foreach (Expression size in expr.get_sizes ()) {
			CCodeExpression csize = (CCodeExpression) size.ccodenode;

			if (!is_pure_ccode_expression (csize)) {
				var temp_var = get_temp_variable (int_type, false, expr);
				var name_cnode = new CCodeIdentifier (temp_var.name);
				size.ccodenode = name_cnode;

				temp_vars.insert (0, temp_var);

				csize = new CCodeAssignment (name_cnode, csize);
			}

			if (first) {
				cexpr = csize;
				first = false;
			} else {
				cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, cexpr, csize);
			}
		}
		
		// add extra item to have array NULL-terminated for all reference types
		if (expr.element_type.data_type != null && expr.element_type.data_type.is_reference_type ()) {
			cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, cexpr, new CCodeConstant ("1"));
		}
		
		gnew.add_argument (cexpr);

		if (expr.initializer_list != null) {
			var ce = new CCodeCommaExpression ();
			var temp_var = get_temp_variable (expr.value_type, true, expr);
			var name_cnode = new CCodeIdentifier (temp_var.name);
			int i = 0;
			
			temp_vars.insert (0, temp_var);
			
			ce.append_expression (new CCodeAssignment (name_cnode, gnew));

			append_initializer_list (ce, name_cnode, expr.initializer_list, expr.rank, ref i);
			
			ce.append_expression (name_cnode);
			
			expr.ccodenode = ce;
		} else {
			expr.ccodenode = gnew;
		}
	}

	public override string get_array_length_cname (string array_cname, int dim) {
		return "%s_length%d".printf (array_cname, dim);
	}

	public override CCodeExpression get_array_length_cexpression (Expression array_expr, int dim = -1) {
		var array_type = array_expr.value_type as ArrayType;

		if (array_type != null && array_type.fixed_length) {
			return new CCodeConstant (array_type.length.to_string ());
		}

		// dim == -1 => total size over all dimensions
		if (dim == -1) {
			if (array_type != null && array_type.rank > 1) {
				CCodeExpression cexpr = get_array_length_cexpression (array_expr, 1);
				for (dim = 2; dim <= array_type.rank; dim++) {
					cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, cexpr, get_array_length_cexpression (array_expr, dim));
				}
				return cexpr;
			} else {
				dim = 1;
			}
		}

		bool is_out = false;

		if (array_expr is UnaryExpression) {
			var unary_expr = (UnaryExpression) array_expr;
			if (unary_expr.operator == UnaryOperator.OUT || unary_expr.operator == UnaryOperator.REF) {
				array_expr = unary_expr.inner;
				is_out = true;
			}
		} else if (array_expr is ReferenceTransferExpression) {
			var reftransfer_expr = (ReferenceTransferExpression) array_expr;
			array_expr = reftransfer_expr.inner;
		}
		
		if (array_expr is ArrayCreationExpression) {
			Gee.List<Expression> size = ((ArrayCreationExpression) array_expr).get_sizes ();
			var length_expr = size[dim - 1];
			return (CCodeExpression) get_ccodenode (length_expr);
		} else if (array_expr is MethodCall || array_expr is CastExpression) {
			Gee.List<CCodeExpression> size = array_expr.get_array_sizes ();
			if (size.size >= dim) {
				return size[dim - 1];
			}
		} else if (array_expr.symbol_reference != null) {
			if (array_expr.symbol_reference is FormalParameter) {
				var param = (FormalParameter) array_expr.symbol_reference;
				if (param.captured) {
					// captured variables are stored on the heap
					var block = ((Method) param.parent_symbol).body;
					return new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (get_block_id (block))), get_array_length_cname (param.name, dim));
				} else if (current_method != null && current_method.coroutine) {
					return new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_array_length_cname (param.name, dim));
				} else {
					if (param.array_null_terminated) {
						var carray_expr = get_variable_cexpression (param.name);
						requires_array_length = true;
						var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
						len_call.add_argument (carray_expr);
						return len_call;
					} else if (!param.no_array_length) {
						CCodeExpression length_expr = get_variable_cexpression (get_array_length_cname (get_variable_cname (param.name), dim));
						if (param.direction != ParameterDirection.IN) {
							// accessing argument of out/ref param
							length_expr = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, length_expr);
						}
						if (is_out) {
							// passing array as out/ref
							return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, length_expr);
						} else {
							return length_expr;
						}
					}
				}
			} else if (array_expr.symbol_reference is LocalVariable) {
				var local = (LocalVariable) array_expr.symbol_reference;
				if (local.captured) {
					// captured variables are stored on the heap
					var block = (Block) local.parent_symbol;
					return new CCodeMemberAccess.pointer (new CCodeIdentifier ("_data%d_".printf (get_block_id (block))), get_array_length_cname (local.name, dim));
				} else if (current_method != null && current_method.coroutine) {
					return new CCodeMemberAccess.pointer (new CCodeIdentifier ("data"), get_array_length_cname (local.name, dim));
				} else {
					var length_expr = get_variable_cexpression (get_array_length_cname (get_variable_cname (local.name), dim));
					if (is_out) {
						return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, length_expr);
					} else {
						return length_expr;
					}
				}
			} else if (array_expr.symbol_reference is Field) {
				var field = (Field) array_expr.symbol_reference;
				if (field.array_null_terminated) {
					var ma = (MemberAccess) array_expr;

					CCodeExpression carray_expr = null;

					if (field.binding == MemberBinding.INSTANCE) {
						var cl = field.parent_symbol as Class;
						bool is_gtypeinstance = (cl != null && !cl.is_compact);

						string array_cname = field.get_cname ();
						CCodeExpression typed_inst = (CCodeExpression) get_ccodenode (ma.inner);

						CCodeExpression inst;
						if (is_gtypeinstance && field.access == SymbolAccessibility.PRIVATE) {
							inst = new CCodeMemberAccess.pointer (typed_inst, "priv");
						} else {
							inst = typed_inst;
						}
						if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
							carray_expr = new CCodeMemberAccess.pointer (inst, array_cname);
						} else {
							carray_expr = new CCodeMemberAccess (inst, array_cname);
						}
					} else {
						carray_expr = new CCodeIdentifier (field.get_cname ());
					}

					requires_array_length = true;
					var len_call = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_length"));
					len_call.add_argument (carray_expr);
					return len_call;
				} else if (!field.no_array_length) {
					var ma = (MemberAccess) array_expr;

					CCodeExpression length_expr = null;

					if (field.has_array_length_cexpr) {
						length_expr = new CCodeConstant (field.get_array_length_cexpr ());
					} else if (field.binding == MemberBinding.INSTANCE) {
						var cl = field.parent_symbol as Class;
						bool is_gtypeinstance = (cl != null && !cl.is_compact);

						string length_cname;
						if (field.has_array_length_cname) {
							length_cname = field.get_array_length_cname ();
						} else {
							length_cname = get_array_length_cname (field.name, dim);
						}
						CCodeExpression typed_inst = (CCodeExpression) get_ccodenode (ma.inner);

						CCodeExpression inst;
						if (is_gtypeinstance && field.access == SymbolAccessibility.PRIVATE) {
							inst = new CCodeMemberAccess.pointer (typed_inst, "priv");
						} else {
							inst = typed_inst;
						}
						if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
							length_expr = new CCodeMemberAccess.pointer (inst, length_cname);
						} else {
							length_expr = new CCodeMemberAccess (inst, length_cname);
						}
					} else {
						length_expr = new CCodeIdentifier (get_array_length_cname (field.get_cname (), dim));
					}

					if (is_out) {
						return new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, length_expr);
					} else {
						return length_expr;
					}
				}
			} else if (array_expr.symbol_reference is Constant) {
				var constant = (Constant) array_expr.symbol_reference;
				var ccall = new CCodeFunctionCall (new CCodeIdentifier ("G_N_ELEMENTS"));
				ccall.add_argument (new CCodeIdentifier (constant.get_cname ()));
				return ccall;
			} else if (array_expr.symbol_reference is Property) {
				var prop = (Property) array_expr.symbol_reference;
				if (!prop.no_array_length) {
					Gee.List<CCodeExpression> size = array_expr.get_array_sizes ();
					if (size.size >= dim) {
						return size[dim - 1];
					}
				}
			}
		} else if (array_expr is NullLiteral) {
			return new CCodeConstant ("0");
		}

		if (!is_out) {
			/* allow arrays with unknown length even for value types
			 * as else it may be impossible to bind some libraries
			 * users of affected libraries should explicitly set
			 * the array length as early as possible
			 * by setting the virtual length field of the array
			 */
			return new CCodeConstant ("-1");
		} else {
			return new CCodeConstant ("NULL");
		}
	}

	public override string get_array_size_cname (string array_cname) {
		return "%s_size".printf (array_cname);
	}

	public override CCodeExpression get_array_size_cexpression (Expression array_expr) {
		if (array_expr.symbol_reference is LocalVariable) {
			var local = (LocalVariable) array_expr.symbol_reference;
			return get_variable_cexpression (get_array_size_cname (get_variable_cname (local.name)));
		} else if (array_expr.symbol_reference is Field) {
			var field = (Field) array_expr.symbol_reference;
			var ma = (MemberAccess) array_expr;

			CCodeExpression size_expr = null;

			if (field.binding == MemberBinding.INSTANCE) {
				var cl = field.parent_symbol as Class;
				bool is_gtypeinstance = (cl != null && !cl.is_compact);

				string size_cname = get_array_size_cname (field.name);
				CCodeExpression typed_inst = (CCodeExpression) get_ccodenode (ma.inner);

				CCodeExpression inst;
				if (is_gtypeinstance && field.access == SymbolAccessibility.PRIVATE) {
					inst = new CCodeMemberAccess.pointer (typed_inst, "priv");
				} else {
					inst = typed_inst;
				}
				if (((TypeSymbol) field.parent_symbol).is_reference_type ()) {
					size_expr = new CCodeMemberAccess.pointer (inst, size_cname);
				} else {
					size_expr = new CCodeMemberAccess (inst, size_cname);
				}
			} else {
				size_expr = new CCodeIdentifier (get_array_size_cname (field.get_cname ()));
			}

			return size_expr;
		}

		assert_not_reached ();
	}

	public override void visit_element_access (ElementAccess expr) {
		expr.accept_children (codegen);

		Gee.List<Expression> indices = expr.get_indices ();
		int rank = indices.size;

		var container_type = expr.container.value_type.data_type;

		var ccontainer = (CCodeExpression) expr.container.ccodenode;
		var cindex = (CCodeExpression) indices[0].ccodenode;
		if (expr.container.symbol_reference is ArrayLengthField) {
			/* Figure if cindex is a constant expression and calculate dim...*/
			var lit = indices[0] as IntegerLiteral;
			var memberaccess = expr.container as MemberAccess;
			if (lit != null && memberaccess != null) {
				int dim = lit.value.to_int ();
				expr.ccodenode = head.get_array_length_cexpression (memberaccess.inner, dim + 1);
			}
		} else if (container_type == string_type.data_type) {
			// should be moved to a different module

			// access to unichar in a string
			var coffsetcall = new CCodeFunctionCall (new CCodeIdentifier ("g_utf8_offset_to_pointer"));
			coffsetcall.add_argument (ccontainer);
			coffsetcall.add_argument (cindex);

			var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_utf8_get_char"));
			ccall.add_argument (coffsetcall);

			expr.ccodenode = ccall;
		} else {
			// access to element in an array
			for (int i = 1; i < rank; i++) {
				var cmul = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, cindex, head.get_array_length_cexpression (expr.container, i + 1));
				cindex = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, cmul, (CCodeExpression) indices[i].ccodenode);
			}
			expr.ccodenode = new CCodeElementAccess (ccontainer, cindex);
		}
	}

	private CCodeForStatement get_struct_array_free_loop (Struct st) {
		var cbody = new CCodeBlock ();
		var cptrarray = new CCodeIdentifier ("array");
		var cea = new CCodeElementAccess (cptrarray, new CCodeIdentifier ("i"));

		var cfreecall = new CCodeFunctionCall (get_destroy_func_expression (new StructValueType (st)));
		cfreecall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cea));

		var cforcond = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier ("i"), new CCodeIdentifier ("array_length"));
		cbody.add_statement (new CCodeExpressionStatement (cfreecall));

		var cfor = new CCodeForStatement (cforcond, cbody);
		cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeConstant ("0")));
		cfor.add_iterator (new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("i"), new CCodeConstant ("1"))));

		return cfor;
	}

	public override string? append_struct_array_free (Struct st) {
		string cname = "_vala_%s_array_free".printf (st.get_cname ());;

		if (source_declarations.add_declaration (cname)) {
			return cname;
		}

		var fun = new CCodeFunction (cname, "void");
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeFormalParameter ("array", "%s*".printf (st.get_cname ())));
		fun.add_parameter (new CCodeFormalParameter ("array_length", "gint"));
		source_declarations.add_type_member_declaration (fun.copy ());

		var cdofree = new CCodeBlock ();

		var citdecl = new CCodeDeclaration ("int");
		citdecl.add_declarator (new CCodeVariableDeclarator ("i"));
		cdofree.add_statement (citdecl);

		cdofree.add_statement (get_struct_array_free_loop (st));

		var ccondarr = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("array"), new CCodeConstant ("NULL"));
		var cif = new CCodeIfStatement (ccondarr, cdofree);
		fun.block = new CCodeBlock ();
		fun.block.add_statement (cif);

		var carrfree = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		carrfree.add_argument (new CCodeIdentifier ("array"));
		fun.block.add_statement (new CCodeExpressionStatement (carrfree));

		source_type_member_definition.append (fun);

		return cname;
	}

	private CCodeForStatement get_vala_array_free_loop () {
		var cbody = new CCodeBlock ();
		var cptrarray = new CCodeCastExpression (new CCodeIdentifier ("array"), "gpointer*");
		var cea = new CCodeElementAccess (cptrarray, new CCodeIdentifier ("i"));

		var cfreecall = new CCodeFunctionCall (new CCodeIdentifier ("destroy_func"));
		cfreecall.add_argument (cea);

		var cfreecond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, cea, new CCodeConstant ("NULL"));
		var cforcond = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier ("i"), new CCodeIdentifier ("array_length"));
		var cfreeblock = new CCodeBlock ();
		cfreeblock.add_statement (new CCodeExpressionStatement (cfreecall));
		cbody.add_statement (new CCodeIfStatement (cfreecond, cfreeblock));

		var cfor = new CCodeForStatement (cforcond, cbody);
		cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeConstant ("0")));
		cfor.add_iterator (new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("i"), new CCodeConstant ("1"))));

		return cfor;
	}

	public override void append_vala_array_free () {
		// _vala_array_destroy only frees elements but not the array itself

		var fun = new CCodeFunction ("_vala_array_destroy", "void");
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeFormalParameter ("array", "gpointer"));
		fun.add_parameter (new CCodeFormalParameter ("array_length", "gint"));
		fun.add_parameter (new CCodeFormalParameter ("destroy_func", "GDestroyNotify"));
		source_declarations.add_type_member_declaration (fun.copy ());

		var cdofree = new CCodeBlock ();

		var citdecl = new CCodeDeclaration ("int");
		citdecl.add_declarator (new CCodeVariableDeclarator ("i"));
		cdofree.add_statement (citdecl);

		cdofree.add_statement (get_vala_array_free_loop ());

		var ccondarr = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("array"), new CCodeConstant ("NULL"));
		var ccondfunc = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("destroy_func"), new CCodeConstant ("NULL"));
		var cif = new CCodeIfStatement (new CCodeBinaryExpression (CCodeBinaryOperator.AND, ccondarr, ccondfunc), cdofree);
		fun.block = new CCodeBlock ();
		fun.block.add_statement (cif);

		source_type_member_definition.append (fun);

		// _vala_array_free frees elements and array

		fun = new CCodeFunction ("_vala_array_free", "void");
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeFormalParameter ("array", "gpointer"));
		fun.add_parameter (new CCodeFormalParameter ("array_length", "gint"));
		fun.add_parameter (new CCodeFormalParameter ("destroy_func", "GDestroyNotify"));
		source_declarations.add_type_member_declaration (fun.copy ());

		// call _vala_array_destroy to free the array elements
		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_destroy"));
		ccall.add_argument (new CCodeIdentifier ("array"));
		ccall.add_argument (new CCodeIdentifier ("array_length"));
		ccall.add_argument (new CCodeIdentifier ("destroy_func"));

		fun.block = new CCodeBlock ();
		fun.block.add_statement (new CCodeExpressionStatement (ccall));

		var carrfree = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		carrfree.add_argument (new CCodeIdentifier ("array"));
		fun.block.add_statement (new CCodeExpressionStatement (carrfree));

		source_type_member_definition.append (fun);
	}

	public override void append_vala_array_move () {
		source_declarations.add_include ("string.h");

		// assumes that overwritten array elements are null before invocation
		// FIXME will leak memory if that's not the case
		var fun = new CCodeFunction ("_vala_array_move", "void");
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeFormalParameter ("array", "gpointer"));
		fun.add_parameter (new CCodeFormalParameter ("element_size", "gsize"));
		fun.add_parameter (new CCodeFormalParameter ("src", "gint"));
		fun.add_parameter (new CCodeFormalParameter ("dest", "gint"));
		fun.add_parameter (new CCodeFormalParameter ("length", "gint"));
		source_declarations.add_type_member_declaration (fun.copy ());

		var array = new CCodeCastExpression (new CCodeIdentifier ("array"), "char*");
		var element_size = new CCodeIdentifier ("element_size");
		var length = new CCodeIdentifier ("length");
		var src = new CCodeIdentifier ("src");
		var dest = new CCodeIdentifier ("dest");
		var src_address = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, array, new CCodeBinaryExpression (CCodeBinaryOperator.MUL, src, element_size));
		var dest_address = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, array, new CCodeBinaryExpression (CCodeBinaryOperator.MUL, dest, element_size));
		var dest_end_address = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, array, new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, dest, length), element_size));

		fun.block = new CCodeBlock ();

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_memmove"));
		ccall.add_argument (dest_address);
		ccall.add_argument (src_address);
		ccall.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, length, element_size));
		fun.block.add_statement (new CCodeExpressionStatement (ccall));

		var czero1 = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
		czero1.add_argument (src_address);
		czero1.add_argument (new CCodeConstant ("0"));
		czero1.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeBinaryExpression (CCodeBinaryOperator.MINUS, dest, src), element_size));
		var czeroblock1 = new CCodeBlock ();
		czeroblock1.add_statement (new CCodeExpressionStatement (czero1));

		var czero2 = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
		czero2.add_argument (dest_end_address);
		czero2.add_argument (new CCodeConstant ("0"));
		czero2.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeBinaryExpression (CCodeBinaryOperator.MINUS, src, dest), element_size));
		var czeroblock2 = new CCodeBlock ();
		czeroblock2.add_statement (new CCodeExpressionStatement (czero2));

		fun.block.add_statement (new CCodeIfStatement (new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, src, dest), czeroblock1, czeroblock2));

		source_type_member_definition.append (fun);
	}

	public override void append_vala_array_length () {
		var fun = new CCodeFunction ("_vala_array_length", "gint");
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeFormalParameter ("array", "gpointer"));
		source_declarations.add_type_member_declaration (fun.copy ());

		var block = new CCodeBlock ();

		var len_decl = new CCodeDeclaration ("int");
		len_decl.add_declarator (new CCodeVariableDeclarator ("length", new CCodeConstant ("0")));
		block.add_statement (len_decl);

		var non_null_block = new CCodeBlock ();

		var while_body = new CCodeBlock ();
		while_body.add_statement (new CCodeExpressionStatement (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("length"))));

		var array_element_check = new CCodeElementAccess (new CCodeCastExpression (new CCodeIdentifier ("array"), "gpointer*"), new CCodeConstant ("length"));
		non_null_block.add_statement (new CCodeWhileStatement (array_element_check, while_body));

		// return 0 if the array is NULL
		// avoids an extra NULL check on the caller side
		var array_check = new CCodeIdentifier ("array");
		block.add_statement (new CCodeIfStatement (array_check, non_null_block));

		block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("length")));

		fun.block = block;

		source_type_member_definition.append (fun);
	}

	public override CCodeExpression? get_ref_cexpression (DataType expression_type, CCodeExpression cexpr, Expression? expr, CodeNode node) {
		if (expression_type is ArrayType) {
			var array_type = (ArrayType) expression_type;

			if (!array_type.fixed_length) {
				return base.get_ref_cexpression (expression_type, cexpr, expr, node);
			}

			var decl = get_temp_variable (expression_type, false, node);
			temp_vars.insert (0, decl);

			var ctemp = get_variable_cexpression (decl.name);

			var copy_call = new CCodeFunctionCall (new CCodeIdentifier (generate_array_copy_wrapper (array_type)));
			copy_call.add_argument (cexpr);
			copy_call.add_argument (ctemp);

			var ccomma = new CCodeCommaExpression ();

			ccomma.append_expression (copy_call);
			ccomma.append_expression (ctemp);

			return ccomma;
		} else {
			return base.get_ref_cexpression (expression_type, cexpr, expr, node);
		}
	}

	public override CCodeExpression? get_dup_func_expression (DataType type, SourceReference? source_reference, bool is_chainup) {
		if (type is ArrayType) {
			var array_type = (ArrayType) type;
			// fixed length arrays use different code
			// generated by overridden get_ref_cexpression method
			assert (!array_type.fixed_length);
			return new CCodeIdentifier (generate_array_dup_wrapper (array_type));
		} else {
			return base.get_dup_func_expression (type, source_reference, is_chainup);
		}
	}

	public override CCodeExpression get_unref_expression (CCodeExpression cvar, DataType type, Expression expr) {
		if (type is ArrayType) {
			var array_type = (ArrayType) type;

			if (!array_type.fixed_length) {
				return base.get_unref_expression (cvar, type, expr);
			}

			requires_array_free = true;

			var ccall = new CCodeFunctionCall (get_destroy_func_expression (type));

			ccall = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_destroy"));
			ccall.add_argument (cvar);
			ccall.add_argument (new CCodeConstant ("%d".printf (array_type.length)));
			ccall.add_argument (new CCodeCastExpression (get_destroy_func_expression (array_type.element_type), "GDestroyNotify"));

			return ccall;
		} else {
			return base.get_unref_expression (cvar, type, expr);
		}
	}

	string generate_array_dup_wrapper (ArrayType array_type) {
		string dup_func = "_vala_array_dup%d".printf (++next_array_dup_id);

		if (!add_wrapper (dup_func)) {
			// wrapper already defined
			return dup_func;
		}

		// declaration

		var function = new CCodeFunction (dup_func, array_type.get_cname ());
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("self", array_type.get_cname ()));
		// total length over all dimensions
		function.add_parameter (new CCodeFormalParameter ("length", "int"));

		// definition

		var block = new CCodeBlock ();

		if (requires_copy (array_type.element_type)) {
			var old_temp_vars = temp_vars;

			var cdecl = new CCodeDeclaration (array_type.get_cname ());
			var cvardecl = new CCodeVariableDeclarator ("result");
			cdecl.add_declarator (cvardecl);
			var gnew = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
			gnew.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
			gnew.add_argument (new CCodeIdentifier ("length"));
			cvardecl.initializer = gnew;
			block.add_statement (cdecl);

			var idx_decl = new CCodeDeclaration ("int");
			idx_decl.add_declarator (new CCodeVariableDeclarator ("i"));
			block.add_statement (idx_decl);

			var loop_body = new CCodeBlock ();
			loop_body.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeElementAccess (new CCodeIdentifier ("result"), new CCodeIdentifier ("i")), get_ref_cexpression (array_type.element_type, new CCodeElementAccess (new CCodeIdentifier ("self"), new CCodeIdentifier ("i")), null, array_type))));

			var cfor = new CCodeForStatement (new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier ("i"), new CCodeIdentifier ("length")), loop_body);
			cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeConstant ("0")));
			cfor.add_iterator (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("i")));
			block.add_statement (cfor);

			block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("result")));

			var cfrag = new CCodeFragment ();
			append_temp_decl (cfrag, temp_vars);
			block.add_statement (cfrag);
			temp_vars = old_temp_vars;
		} else {
			var dup_call = new CCodeFunctionCall (new CCodeIdentifier ("g_memdup"));
			dup_call.add_argument (new CCodeIdentifier ("self"));

			var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
			dup_call.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeIdentifier ("length"), sizeof_call));

			block.add_statement (new CCodeReturnStatement (dup_call));
		}

		// append to file

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return dup_func;
	}

	string generate_array_copy_wrapper (ArrayType array_type) {
		string dup_func = "_vala_array_copy%d".printf (++next_array_dup_id);

		if (!add_wrapper (dup_func)) {
			// wrapper already defined
			return dup_func;
		}

		// declaration

		var function = new CCodeFunction (dup_func, "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("self", array_type.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("dest", array_type.get_cname () + "*"));

		// definition

		var block = new CCodeBlock ();

		if (requires_copy (array_type.element_type)) {
			var old_temp_vars = temp_vars;

			var idx_decl = new CCodeDeclaration ("int");
			idx_decl.add_declarator (new CCodeVariableDeclarator ("i"));
			block.add_statement (idx_decl);

			var loop_body = new CCodeBlock ();
			loop_body.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeElementAccess (new CCodeIdentifier ("dest"), new CCodeIdentifier ("i")), get_ref_cexpression (array_type.element_type, new CCodeElementAccess (new CCodeIdentifier ("self"), new CCodeIdentifier ("i")), null, array_type))));

			var cfor = new CCodeForStatement (new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier ("i"), new CCodeConstant ("%d".printf (array_type.length))), loop_body);
			cfor.add_initializer (new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeConstant ("0")));
			cfor.add_iterator (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("i")));
			block.add_statement (cfor);

			var cfrag = new CCodeFragment ();
			append_temp_decl (cfrag, temp_vars);
			block.add_statement (cfrag);
			temp_vars = old_temp_vars;
		} else {
			source_declarations.add_include ("string.h");

			var dup_call = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
			dup_call.add_argument (new CCodeIdentifier ("dest"));
			dup_call.add_argument (new CCodeIdentifier ("self"));

			var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
			dup_call.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeConstant ("%d".printf (array_type.length)), sizeof_call));

			block.add_statement (new CCodeExpressionStatement (dup_call));
		}

		// append to file

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return dup_func;
	}

	string generate_array_add_wrapper (ArrayType array_type) {
		string add_func = "_vala_array_add%d".printf (++next_array_add_id);

		if (!add_wrapper (add_func)) {
			// wrapper already defined
			return add_func;
		}

		// declaration

		var function = new CCodeFunction (add_func, "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeFormalParameter ("array", array_type.get_cname () + "*"));
		function.add_parameter (new CCodeFormalParameter ("length", "int*"));
		function.add_parameter (new CCodeFormalParameter ("size", "int*"));

		string typename = array_type.element_type.get_cname ();
		CCodeExpression value = new CCodeIdentifier ("value");
		if (array_type.element_type.is_real_struct_type ()) {
			if (!array_type.element_type.nullable || !array_type.element_type.value_owned) {
				typename = "const " + typename;
			}
			if (!array_type.element_type.nullable) {
				typename += "*";
				value = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, value);
			}
		}
		function.add_parameter (new CCodeFormalParameter ("value", typename));

		var array = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("array"));
		var length = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("length"));
		var size = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("size"));

		// definition

		var block = new CCodeBlock ();

		var renew_call = new CCodeFunctionCall (new CCodeIdentifier ("g_renew"));
		renew_call.add_argument (new CCodeIdentifier (array_type.element_type.get_cname ()));
		renew_call.add_argument (array);
		if (array_type.element_type.is_reference_type_or_type_parameter ()) {
			// NULL terminate array
			renew_call.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, size, new CCodeConstant ("1")));
		} else {
			renew_call.add_argument (size);
		}

		var resize_block = new CCodeBlock ();
		resize_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (size, new CCodeConditionalExpression (size, new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeConstant ("2"), size), new CCodeConstant ("4")))));
		resize_block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (array, renew_call)));

		var csizecheck = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, length, size);
		block.add_statement (new CCodeIfStatement (csizecheck, resize_block));

		block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeElementAccess (array, new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, length)), value)));

		if (array_type.element_type.is_reference_type_or_type_parameter ()) {
			// NULL terminate array
			block.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeElementAccess (array, length), new CCodeConstant ("NULL"))));
		}

		// append to file

		source_declarations.add_type_member_declaration (function.copy ());

		function.block = block;
		source_type_member_definition.append (function);

		return add_func;
	}

	bool is_array_add (Assignment assignment) {
		var binary = assignment.right as BinaryExpression;
		if (binary != null && binary.left.value_type is ArrayType) {
			if (binary.operator == BinaryOperator.PLUS) {
				if (assignment.left.symbol_reference == binary.left.symbol_reference) {
					return true;
				}
			}
		}

		return false;
	}

	public override void visit_assignment (Assignment assignment) {
		if (!is_array_add (assignment)) {
			base.visit_assignment (assignment);
			return;
		}

		var binary = assignment.right as BinaryExpression;

		var array = binary.left;
		var array_type = (ArrayType) array.value_type;
		var element = binary.right;

		array.accept (codegen);
		element.target_type = array_type.element_type.copy ();
		element.accept (codegen);

		var value_param = new FormalParameter ("value", element.target_type);

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (generate_array_add_wrapper (array_type)));
		ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, (CCodeExpression) array.ccodenode));
		ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_array_length_cexpression (array)));
		ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_array_size_cexpression (array)));
		ccall.add_argument (handle_struct_argument (value_param, element, (CCodeExpression) element.ccodenode));

		assignment.ccodenode = ccall;
	}

	public override void generate_parameter (FormalParameter param, CCodeDeclarationSpace decl_space, Map<int,CCodeFormalParameter> cparam_map, Map<int,CCodeExpression>? carg_map) {
		if (!(param.parameter_type is ArrayType)) {
			base.generate_parameter (param, decl_space, cparam_map, carg_map);
			return;
		}

		string ctypename = param.parameter_type.get_cname ();

		if (param.direction != ParameterDirection.IN) {
			ctypename += "*";
		}

		param.ccodenode = new CCodeFormalParameter (get_variable_cname (param.name), ctypename);

		var array_type = (ArrayType) param.parameter_type;

		generate_type_declaration (array_type.element_type, decl_space);

		cparam_map.set (get_param_pos (param.cparameter_position), (CCodeFormalParameter) param.ccodenode);
		if (carg_map != null) {
			carg_map.set (get_param_pos (param.cparameter_position), get_variable_cexpression (param.name));
		}

		if (!param.no_array_length) {
			var length_ctype = "int";
			if (param.direction != ParameterDirection.IN) {
				length_ctype = "int*";
			}
			
			for (int dim = 1; dim <= array_type.rank; dim++) {
				var cparam = new CCodeFormalParameter (head.get_array_length_cname (get_variable_cname (param.name), dim), length_ctype);
				cparam_map.set (get_param_pos (param.carray_length_parameter_position + 0.01 * dim), cparam);
				if (carg_map != null) {
					carg_map.set (get_param_pos (param.carray_length_parameter_position + 0.01 * dim), get_variable_cexpression (cparam.name));
				}
			}
		}
	}
}
