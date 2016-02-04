/* valaccodearraymodule.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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


public class Vala.CCodeArrayModule : CCodeMethodCallModule {
	void append_initializer_list (CCodeExpression name_cnode, InitializerList initializer_list, int rank, ref int i) {
		foreach (Expression e in initializer_list.get_initializers ()) {
			if (rank > 1) {
				append_initializer_list (name_cnode, (InitializerList) e, rank - 1, ref i);
			} else {
				ccode.add_assignment (new CCodeElementAccess (name_cnode, new CCodeConstant (i.to_string ())), get_cvalue (e));
				i++;
			}
		}
	}

	public override void visit_array_creation_expression (ArrayCreationExpression expr) {
		var array_type = expr.target_type as ArrayType;
		if (array_type != null && array_type.fixed_length) {
			// no heap allocation for fixed-length arrays

			var temp_var = get_temp_variable (array_type, true, expr);
			var name_cnode = get_variable_cexpression (temp_var.name);
			int i = 0;

			emit_temp_var (temp_var);

			append_initializer_list (name_cnode, expr.initializer_list, expr.rank, ref i);

			set_cvalue (expr, name_cnode);

			return;
		}

		var gnew = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
		gnew.add_argument (new CCodeIdentifier (get_ccode_name (expr.element_type)));

		bool first = true;
		CCodeExpression cexpr = null;

		// iterate over each dimension
		foreach (Expression size in expr.get_sizes ()) {
			CCodeExpression csize = get_cvalue (size);
			append_array_length (expr, csize);

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

		var temp_var = get_temp_variable (expr.value_type, true, expr);
		var name_cnode = get_variable_cexpression (temp_var.name);
		int i = 0;

		emit_temp_var (temp_var);

		ccode.add_assignment (name_cnode, gnew);

		if (expr.initializer_list != null) {
			append_initializer_list (name_cnode, expr.initializer_list, expr.rank, ref i);
		}

		set_cvalue (expr, name_cnode);
	}

	public override string get_array_length_cname (string array_cname, int dim) {
		return "%s_length%d".printf (array_cname, dim);
	}

	public override string get_parameter_array_length_cname (Parameter param, int dim) {
		if (get_ccode_array_length_name (param) != null) {
			return get_ccode_array_length_name (param);
		} else {
			return get_array_length_cname (get_variable_cname (param.name), dim);
		}
	}

	public override CCodeExpression get_array_length_cexpression (Expression array_expr, int dim = -1) {
		return get_array_length_cvalue (array_expr.target_value, dim);
	}

	public override CCodeExpression get_array_length_cvalue (TargetValue value, int dim = -1) {
		var array_type = value.value_type as ArrayType;

		if (array_type != null && array_type.fixed_length) {
			return get_ccodenode (array_type.length);
		}

		// dim == -1 => total size over all dimensions
		if (dim == -1) {
			if (array_type != null && array_type.rank > 1) {
				CCodeExpression cexpr = get_array_length_cvalue (value, 1);
				for (dim = 2; dim <= array_type.rank; dim++) {
					cexpr = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, cexpr, get_array_length_cvalue (value, dim));
				}
				return cexpr;
			} else {
				dim = 1;
			}
		}

		List<CCodeExpression> size = ((GLibValue) value).array_length_cvalues;
		assert (size != null && size.size >= dim);
		return size[dim - 1];
	}

	public override string get_array_size_cname (string array_cname) {
		return "_%s_size_".printf (array_cname);
	}

	public override void visit_element_access (ElementAccess expr) {
		List<Expression> indices = expr.get_indices ();
		int rank = indices.size;

		var ccontainer = get_cvalue (expr.container);
		var cindex = get_cvalue (indices[0]);
		if (expr.container.symbol_reference is ArrayLengthField) {
			/* Figure if cindex is a constant expression and calculate dim...*/
			var lit = indices[0] as IntegerLiteral;
			var memberaccess = expr.container as MemberAccess;
			if (lit != null && memberaccess != null) {
				int dim = int.parse (lit.value);
				set_cvalue (expr, get_array_length_cexpression (memberaccess.inner, dim + 1));
			} else {
				Report.error (expr.source_reference, "only integer literals supported as index");
			}
		} else {
			// access to element in an array
			for (int i = 1; i < rank; i++) {
				var cmul = new CCodeBinaryExpression (CCodeBinaryOperator.MUL, cindex, get_array_length_cexpression (expr.container, i + 1));
				cindex = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, cmul, get_cvalue (indices[i]));
			}
			set_cvalue (expr, new CCodeElementAccess (ccontainer, cindex));
		}

		expr.target_value.value_type = expr.value_type.copy ();
		if (!expr.lvalue) {
			expr.target_value = store_temp_value (expr.target_value, expr);
		}
		((GLibValue) expr.target_value).lvalue = true;
	}

	public override void visit_slice_expression (SliceExpression expr) {
		var ccontainer = get_cvalue (expr.container);
		var cstart = get_cvalue (expr.start);
		var cstop = get_cvalue (expr.stop);

		var cstartpointer = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, ccontainer, cstart);
		var splicelen = new CCodeBinaryExpression (CCodeBinaryOperator.MINUS, cstop, cstart);

		set_cvalue (expr, cstartpointer);
		append_array_length (expr, splicelen);
	}

	void append_struct_array_free_loop (Struct st) {
		var cforinit = new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeConstant ("0"));
		var cforcond = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier ("i"), new CCodeIdentifier ("array_length"));
		var cforiter = new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("i"), new CCodeConstant ("1")));
		ccode.open_for (cforinit, cforcond, cforiter);

		var cptrarray = new CCodeIdentifier ("array");
		var cea = new CCodeElementAccess (cptrarray, new CCodeIdentifier ("i"));

		var cfreecall = new CCodeFunctionCall (get_destroy_func_expression (new StructValueType (st)));
		cfreecall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, cea));
		ccode.add_expression (cfreecall);

		ccode.close ();
	}

	public override string? append_struct_array_free (Struct st) {
		string cname = "_vala_%s_array_free".printf (get_ccode_name (st));

		if (cfile.add_declaration (cname)) {
			return cname;
		}

		var fun = new CCodeFunction (cname, "void");
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeParameter ("array", "%s*".printf (get_ccode_name (st))));
		fun.add_parameter (new CCodeParameter ("array_length", "gint"));

		push_function (fun);

		var ccondarr = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("array"), new CCodeConstant ("NULL"));
		ccode.open_if (ccondarr);

		ccode.add_declaration ("int", new CCodeVariableDeclarator ("i"));
		append_struct_array_free_loop (st);

		ccode.close ();

		var carrfree = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		carrfree.add_argument (new CCodeIdentifier ("array"));
		ccode.add_expression (carrfree);

		pop_function ();

		cfile.add_function_declaration (fun);
		cfile.add_function (fun);

		return cname;
	}

	void append_vala_array_free_loop () {
		var cforinit = new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeConstant ("0"));
		var cforcond = new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier ("i"), new CCodeIdentifier ("array_length"));
		var cforiter = new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, new CCodeIdentifier ("i"), new CCodeConstant ("1")));
		ccode.open_for (cforinit, cforcond, cforiter);

		var cptrarray = new CCodeCastExpression (new CCodeIdentifier ("array"), "gpointer*");
		var cea = new CCodeElementAccess (cptrarray, new CCodeIdentifier ("i"));

		var cfreecond = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, cea, new CCodeConstant ("NULL"));
		ccode.open_if (cfreecond);

		var cfreecall = new CCodeFunctionCall (new CCodeIdentifier ("destroy_func"));
		cfreecall.add_argument (cea);
		ccode.add_expression (cfreecall);

		ccode.close ();
	}

	public override void append_vala_array_free () {
		// _vala_array_destroy only frees elements but not the array itself

		var fun = new CCodeFunction ("_vala_array_destroy", "void");
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeParameter ("array", "gpointer"));
		fun.add_parameter (new CCodeParameter ("array_length", "gint"));
		fun.add_parameter (new CCodeParameter ("destroy_func", "GDestroyNotify"));

		push_function (fun);

		var ccondarr = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("array"), new CCodeConstant ("NULL"));
		var ccondfunc = new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, new CCodeIdentifier ("destroy_func"), new CCodeConstant ("NULL"));
		ccode.open_if (new CCodeBinaryExpression (CCodeBinaryOperator.AND, ccondarr, ccondfunc));

		ccode.add_declaration ("int", new CCodeVariableDeclarator ("i"));
		append_vala_array_free_loop ();

		ccode.close ();

		pop_function ();

		cfile.add_function_declaration (fun);
		cfile.add_function (fun);

		// _vala_array_free frees elements and array

		fun = new CCodeFunction ("_vala_array_free", "void");
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeParameter ("array", "gpointer"));
		fun.add_parameter (new CCodeParameter ("array_length", "gint"));
		fun.add_parameter (new CCodeParameter ("destroy_func", "GDestroyNotify"));

		push_function (fun);

		// call _vala_array_destroy to free the array elements
		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_destroy"));
		ccall.add_argument (new CCodeIdentifier ("array"));
		ccall.add_argument (new CCodeIdentifier ("array_length"));
		ccall.add_argument (new CCodeIdentifier ("destroy_func"));
		ccode.add_expression (ccall);

		var carrfree = new CCodeFunctionCall (new CCodeIdentifier ("g_free"));
		carrfree.add_argument (new CCodeIdentifier ("array"));
		ccode.add_expression (carrfree);

		pop_function ();

		cfile.add_function_declaration (fun);
		cfile.add_function (fun);
	}

	public override void append_vala_array_move () {
		cfile.add_include ("string.h");

		// assumes that overwritten array elements are null before invocation
		// FIXME will leak memory if that's not the case
		var fun = new CCodeFunction ("_vala_array_move", "void");
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeParameter ("array", "gpointer"));
		fun.add_parameter (new CCodeParameter ("element_size", "gsize"));
		fun.add_parameter (new CCodeParameter ("src", "gint"));
		fun.add_parameter (new CCodeParameter ("dest", "gint"));
		fun.add_parameter (new CCodeParameter ("length", "gint"));

		push_function (fun);

		var array = new CCodeCastExpression (new CCodeIdentifier ("array"), "char*");
		var element_size = new CCodeIdentifier ("element_size");
		var length = new CCodeIdentifier ("length");
		var src = new CCodeIdentifier ("src");
		var src_end = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, src, length);
		var dest = new CCodeIdentifier ("dest");
		var dest_end = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, dest, length);
		var src_address = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, array, new CCodeBinaryExpression (CCodeBinaryOperator.MUL, src, element_size));
		var dest_address = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, array, new CCodeBinaryExpression (CCodeBinaryOperator.MUL, dest, element_size));
		var dest_end_address = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, array, new CCodeBinaryExpression (CCodeBinaryOperator.MUL, dest_end, element_size));

		var ccall = new CCodeFunctionCall (new CCodeIdentifier ("g_memmove"));
		ccall.add_argument (dest_address);
		ccall.add_argument (src_address);
		ccall.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, length, element_size));
		ccode.add_expression (ccall);

		ccode.open_if (new CCodeBinaryExpression (CCodeBinaryOperator.AND, new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, src, dest), new CCodeBinaryExpression (CCodeBinaryOperator.GREATER_THAN, src_end, dest)));

		var czero1 = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
		czero1.add_argument (src_address);
		czero1.add_argument (new CCodeConstant ("0"));
		czero1.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeBinaryExpression (CCodeBinaryOperator.MINUS, dest, src), element_size));
		ccode.add_expression (czero1);

		ccode.else_if (new CCodeBinaryExpression (CCodeBinaryOperator.AND, new CCodeBinaryExpression (CCodeBinaryOperator.GREATER_THAN, src, dest), new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, src, dest_end)));

		var czero2 = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
		czero2.add_argument (dest_end_address);
		czero2.add_argument (new CCodeConstant ("0"));
		czero2.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeBinaryExpression (CCodeBinaryOperator.MINUS, src, dest), element_size));
		ccode.add_expression (czero2);

		ccode.else_if (new CCodeBinaryExpression (CCodeBinaryOperator.INEQUALITY, src, dest));

		var czero3 = new CCodeFunctionCall (new CCodeIdentifier ("memset"));
		czero3.add_argument (src_address);
		czero3.add_argument (new CCodeConstant ("0"));
		czero3.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, length, element_size));
		ccode.add_expression (czero3);

		ccode.close ();

		pop_function ();

		cfile.add_function_declaration (fun);
		cfile.add_function (fun);
	}

	public override void append_vala_array_length () {
		var fun = new CCodeFunction ("_vala_array_length", "gint");
		fun.modifiers = CCodeModifiers.STATIC;
		fun.add_parameter (new CCodeParameter ("array", "gpointer"));

		push_function (fun);

		ccode.add_declaration ("int", new CCodeVariableDeclarator ("length", new CCodeConstant ("0")));

		// return 0 if the array is NULL
		// avoids an extra NULL check on the caller side
		var array_check = new CCodeIdentifier ("array");
		ccode.open_if (array_check);

		var array_element_check = new CCodeElementAccess (new CCodeCastExpression (new CCodeIdentifier ("array"), "gpointer*"), new CCodeConstant ("length"));
		ccode.open_while (array_element_check);
		ccode.add_expression (new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("length")));
		ccode.close ();

		ccode.close ();

		ccode.add_return (new CCodeIdentifier ("length"));

		pop_function ();

		cfile.add_function_declaration (fun);
		cfile.add_function (fun);
	}

	public override TargetValue? copy_value (TargetValue value, CodeNode node) {
		var type = value.value_type;
		var cexpr = get_cvalue_ (value);

		if (type is ArrayType) {
			var array_type = (ArrayType) type;

			if (!array_type.fixed_length) {
				return base.copy_value (value, node);
			}

			var temp_value = create_temp_value (type, false, node);

			var copy_call = new CCodeFunctionCall (new CCodeIdentifier (generate_array_copy_wrapper (array_type)));
			copy_call.add_argument (cexpr);
			copy_call.add_argument (get_cvalue_ (temp_value));
			ccode.add_expression (copy_call);

			return temp_value;
		} else {
			return base.copy_value (value, node);
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

	public override CCodeExpression destroy_value (TargetValue value, bool is_macro_definition = false) {
		var type = value.value_type;

		if (type is ArrayType) {
			var array_type = (ArrayType) type;

			if (!array_type.fixed_length) {
				return base.destroy_value (value, is_macro_definition);
			}

			requires_array_free = true;

			var ccall = new CCodeFunctionCall (get_destroy_func_expression (type));

			ccall = new CCodeFunctionCall (new CCodeIdentifier ("_vala_array_destroy"));
			ccall.add_argument (get_cvalue_ (value));
			ccall.add_argument (get_ccodenode (array_type.length));
			ccall.add_argument (new CCodeCastExpression (get_destroy_func_expression (array_type.element_type), "GDestroyNotify"));

			return ccall;
		} else {
			return base.destroy_value (value, is_macro_definition);
		}
	}

	string generate_array_dup_wrapper (ArrayType array_type) {
		string dup_func = "_vala_%s_array_dup".printf (get_ccode_lower_case_name (array_type.element_type));

		if (!add_wrapper (dup_func)) {
			// wrapper already defined
			return dup_func;
		}

		// declaration

		var function = new CCodeFunction (dup_func, get_ccode_name (array_type));
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("self", get_ccode_name (array_type)));
		// total length over all dimensions
		function.add_parameter (new CCodeParameter ("length", "int"));
		if (array_type.element_type is GenericType) {
			// dup function array elements
			string func_name = "%s_dup_func".printf (array_type.element_type.type_parameter.name.down ());
			function.add_parameter (new CCodeParameter (func_name, "GBoxedCopyFunc"));
		}

		// definition

		push_context (new EmitContext ());
		push_function (function);

		if (requires_copy (array_type.element_type)) {
			var cvardecl = new CCodeVariableDeclarator ("result");
			var gnew = new CCodeFunctionCall (new CCodeIdentifier ("g_new0"));
			gnew.add_argument (new CCodeIdentifier (get_ccode_name (array_type.element_type)));

			CCodeExpression length_expr = new CCodeIdentifier ("length");
			// add extra item to have array NULL-terminated for all reference types
			if (array_type.element_type.data_type != null && array_type.element_type.data_type.is_reference_type ()) {
				length_expr = new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, length_expr, new CCodeConstant ("1"));
			}
			gnew.add_argument (length_expr);

			ccode.add_declaration (get_ccode_name (array_type), cvardecl);
			ccode.add_assignment (new CCodeIdentifier ("result"), gnew);

			ccode.add_declaration ("int", new CCodeVariableDeclarator ("i"));

			ccode.open_for (new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeConstant ("0")),
			                   new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier ("i"), new CCodeIdentifier ("length")),
			                   new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("i")));

			ccode.add_assignment (new CCodeElementAccess (new CCodeIdentifier ("result"), new CCodeIdentifier ("i")), get_cvalue_ (copy_value (new GLibValue (array_type.element_type, new CCodeElementAccess (new CCodeIdentifier ("self"), new CCodeIdentifier ("i")), true), array_type)));
			ccode.close ();

			ccode.add_return (new CCodeIdentifier ("result"));
		} else {
			var dup_call = new CCodeFunctionCall (new CCodeIdentifier ("g_memdup"));
			dup_call.add_argument (new CCodeIdentifier ("self"));

			var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_call.add_argument (new CCodeIdentifier (get_ccode_name (array_type.element_type)));
			dup_call.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeIdentifier ("length"), sizeof_call));

			ccode.add_return (dup_call);
		}

		// append to file

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		pop_context ();

		return dup_func;
	}

	string generate_array_copy_wrapper (ArrayType array_type) {
		string dup_func = "_vala_%s_array_copy".printf (get_ccode_lower_case_name (array_type.element_type));

		if (!add_wrapper (dup_func)) {
			// wrapper already defined
			return dup_func;
		}

		// declaration

		var function = new CCodeFunction (dup_func, "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("self", get_ccode_name (array_type) + "*"));
		function.add_parameter (new CCodeParameter ("dest", get_ccode_name (array_type) + "*"));

		// definition

		push_context (new EmitContext ());
		push_function (function);

		if (requires_copy (array_type.element_type)) {
			ccode.add_declaration ("int", new CCodeVariableDeclarator ("i"));

			ccode.open_for (new CCodeAssignment (new CCodeIdentifier ("i"), new CCodeConstant ("0")),
			                   new CCodeBinaryExpression (CCodeBinaryOperator.LESS_THAN, new CCodeIdentifier ("i"), get_ccodenode (array_type.length)),
			                   new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, new CCodeIdentifier ("i")));


			ccode.add_assignment (new CCodeElementAccess (new CCodeIdentifier ("dest"), new CCodeIdentifier ("i")), get_cvalue_ (copy_value (new GLibValue (array_type.element_type, new CCodeElementAccess (new CCodeIdentifier ("self"), new CCodeIdentifier ("i")), true), array_type)));
		} else {
			cfile.add_include ("string.h");

			var dup_call = new CCodeFunctionCall (new CCodeIdentifier ("memcpy"));
			dup_call.add_argument (new CCodeIdentifier ("dest"));
			dup_call.add_argument (new CCodeIdentifier ("self"));

			var sizeof_call = new CCodeFunctionCall (new CCodeIdentifier ("sizeof"));
			sizeof_call.add_argument (new CCodeIdentifier (get_ccode_name (array_type.element_type)));
			dup_call.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.MUL, get_ccodenode (array_type.length), sizeof_call));

			ccode.add_expression (dup_call);
		}

		// append to file

		cfile.add_function_declaration (function);
		cfile.add_function (function);

		pop_context ();

		return dup_func;
	}

	string generate_array_add_wrapper (ArrayType array_type) {
		string add_func = "_vala_%s_array_add".printf (get_ccode_lower_case_name (array_type.element_type));

		if (!add_wrapper (add_func)) {
			// wrapper already defined
			return add_func;
		}

		var function = new CCodeFunction (add_func, "void");
		function.modifiers = CCodeModifiers.STATIC;

		function.add_parameter (new CCodeParameter ("array", get_ccode_name (array_type) + "*"));
		function.add_parameter (new CCodeParameter ("length", "int*"));
		function.add_parameter (new CCodeParameter ("size", "int*"));

		push_function (function);

		string typename = get_ccode_name (array_type.element_type);
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
		function.add_parameter (new CCodeParameter ("value", typename));

		var array = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("array"));
		var length = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("length"));
		var size = new CCodeUnaryExpression (CCodeUnaryOperator.POINTER_INDIRECTION, new CCodeIdentifier ("size"));

		var renew_call = new CCodeFunctionCall (new CCodeIdentifier ("g_renew"));
		renew_call.add_argument (new CCodeIdentifier (get_ccode_name (array_type.element_type)));
		renew_call.add_argument (array);
		if (array_type.element_type.is_reference_type_or_type_parameter ()) {
			// NULL terminate array
			renew_call.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.PLUS, size, new CCodeConstant ("1")));
		} else {
			renew_call.add_argument (size);
		}

		var csizecheck = new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, length, size);
		ccode.open_if (csizecheck);
		ccode.add_assignment (size, new CCodeConditionalExpression (size, new CCodeBinaryExpression (CCodeBinaryOperator.MUL, new CCodeConstant ("2"), size), new CCodeConstant ("4")));
		ccode.add_assignment (array, renew_call);
		ccode.close ();

		ccode.add_assignment (new CCodeElementAccess (array, new CCodeUnaryExpression (CCodeUnaryOperator.POSTFIX_INCREMENT, length)), value);

		if (array_type.element_type.is_reference_type_or_type_parameter ()) {
			// NULL terminate array
			ccode.add_assignment (new CCodeElementAccess (array, length), new CCodeConstant ("NULL"));
		}

		pop_function ();

		cfile.add_function_declaration (function);
		cfile.add_function (function);

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

		var binary = (BinaryExpression) assignment.right;

		var array = assignment.left;
		var array_type = (ArrayType) array.value_type;
		var element = binary.right;

		var array_var = array.symbol_reference;
		if (array_type.rank == 1 && array_var != null && array_var.is_internal_symbol ()
		    && (array_var is LocalVariable || array_var is Field)) {
			// valid array add
		} else {
			Report.error (assignment.source_reference, "Array concatenation not supported for public array variables and parameters");
			return;
		}

		var value_param = new Parameter ("value", element.target_type);

		var ccall = new CCodeFunctionCall (new CCodeIdentifier (generate_array_add_wrapper (array_type)));
		ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_cvalue (array)));
		ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_array_length_cexpression (array)));
		ccall.add_argument (new CCodeUnaryExpression (CCodeUnaryOperator.ADDRESS_OF, get_array_size_cvalue (array.target_value)));
		ccall.add_argument (handle_struct_argument (value_param, element, get_cvalue (element)));

		ccode.add_expression (ccall);
	}

	public override CCodeParameter generate_parameter (Parameter param, CCodeFile decl_space, Map<int,CCodeParameter> cparam_map, Map<int,CCodeExpression>? carg_map) {
		if (!(param.variable_type is ArrayType)) {
			return base.generate_parameter (param, decl_space, cparam_map, carg_map);
		}

		string ctypename = get_ccode_name (param.variable_type);

		if (param.direction != ParameterDirection.IN) {
			ctypename += "*";
		}

		var main_cparam = new CCodeParameter (get_variable_cname (param.name), ctypename);

		var array_type = (ArrayType) param.variable_type;

		generate_type_declaration (array_type.element_type, decl_space);

		cparam_map.set (get_param_pos (get_ccode_pos (param)), main_cparam);
		if (carg_map != null) {
			carg_map.set (get_param_pos (get_ccode_pos (param)), get_variable_cexpression (param.name));
		}

		if (get_ccode_array_length (param)) {
			string length_ctype = "int";
			if (get_ccode_array_length_type (param) != null) {
				length_ctype = get_ccode_array_length_type (param);
			}
			if (param.direction != ParameterDirection.IN) {
				length_ctype = "%s*".printf (length_ctype);
			}
			
			for (int dim = 1; dim <= array_type.rank; dim++) {
				var cparam = new CCodeParameter (get_parameter_array_length_cname (param, dim), length_ctype);
				cparam_map.set (get_param_pos (get_ccode_array_length_pos (param) + 0.01 * dim), cparam);
				if (carg_map != null) {
					carg_map.set (get_param_pos (get_ccode_array_length_pos (param) + 0.01 * dim), get_variable_cexpression (cparam.name));
				}
			}
		}

		return main_cparam;
	}
}
