/* valaccode.vala
 *
 * Copyright (C) 2017  Rico Tzschichholz
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
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */

namespace Vala {
	static int? ccode_attribute_cache_index = null;

	static unowned CCodeAttribute get_ccode_attribute (CodeNode node) {
		if (ccode_attribute_cache_index == null) {
			ccode_attribute_cache_index = CodeNode.get_attribute_cache_index ();

			// make sure static collections are initialized
			CCodeBaseModule.init ();
		}

		unowned AttributeCache? attr = node.get_attribute_cache (ccode_attribute_cache_index);
		if (attr == null) {
			var new_attr = new CCodeAttribute (node);
			node.set_attribute_cache (ccode_attribute_cache_index, new_attr);
			attr = new_attr;
		}
		return (CCodeAttribute) attr;
	}

	public static string get_ccode_name (CodeNode node) {
		return get_ccode_attribute(node).name;
	}

	public static string get_ccode_const_name (CodeNode node) {
		return get_ccode_attribute(node).const_name;
	}

	public static string get_ccode_type_name (ObjectTypeSymbol sym) {
		return get_ccode_attribute (sym).type_name;
	}

	public static string get_ccode_type_cast_function (ObjectTypeSymbol sym) {
		assert (!(sym is Class && ((Class) sym).is_compact));
		return get_ccode_upper_case_name (sym);
	}

	public static string get_ccode_type_get_function (ObjectTypeSymbol sym) {
		var func_name = sym.get_attribute_string ("CCode", "type_get_function");
		if (func_name != null) {
			return func_name;
		}
		if (sym is Class) {
			assert (!((Class) sym).is_compact);
			return "%s_GET_CLASS".printf (get_ccode_upper_case_name (sym));
		} else if (sym is Interface) {
			return "%s_GET_INTERFACE".printf (get_ccode_upper_case_name (sym));
		} else {
			Report.error (sym.source_reference, "`CCode.type_get_function' not supported");
			return "";
		}
	}

	public static string get_ccode_class_get_private_function (Class cl) {
		assert (!cl.is_compact);
		return "%s_GET_CLASS_PRIVATE".printf (get_ccode_upper_case_name (cl));
	}

	public static string get_ccode_class_type_function (Class cl) {
		assert (!cl.is_compact);
		return "%s_CLASS".printf (get_ccode_upper_case_name (cl));
	}

	public static string get_ccode_lower_case_name (CodeNode node, string? infix = null) {
		unowned Symbol? sym = node as Symbol;
		if (sym != null) {
			if (infix == null) {
				infix = "";
			}
			if (sym is Delegate) {
				return "%s%s%s".printf (get_ccode_lower_case_prefix (sym.parent_symbol), infix, Symbol.camel_case_to_lower_case (sym.name));
			} else if (sym is Signal) {
				return get_ccode_attribute (sym).name.replace ("-", "_");
			} else if (sym is ErrorCode) {
				return get_ccode_name (sym).ascii_down ();
			} else {
				return "%s%s%s".printf (get_ccode_lower_case_prefix (sym.parent_symbol), infix, get_ccode_lower_case_suffix (sym));
			}
		} else if (node is ErrorType) {
			unowned ErrorType type = (ErrorType) node;
			if (type.error_domain == null) {
				if (infix == null) {
					return "g_error";
				} else {
					return "g_%s_error".printf (infix);
				}
			} else if (type.error_code == null) {
				return get_ccode_lower_case_name (type.error_domain, infix);
			} else {
				return get_ccode_lower_case_name (type.error_code, infix);
			}
		} else if (node is DelegateType) {
			unowned DelegateType type = (DelegateType) node;
			return get_ccode_lower_case_name (type.delegate_symbol, infix);
		} else if (node is PointerType) {
			unowned PointerType type = (PointerType) node;
			return get_ccode_lower_case_name (type.base_type, infix);
		} else if (node is GenericType) {
			return "valageneric";
		} else if (node is VoidType) {
			return "valavoid";
		} else {
			unowned DataType type = (DataType) node;
			return get_ccode_lower_case_name (type.type_symbol, infix);
		}
	}

	public static string get_ccode_upper_case_name (Symbol sym, string? infix = null) {
		if (sym is Property) {
			return "%s_%s".printf (get_ccode_lower_case_name (sym.parent_symbol), Symbol.camel_case_to_lower_case (sym.name)).ascii_up ();
		} else {
			return get_ccode_lower_case_name (sym, infix).ascii_up ();
		}
	}

	public static string get_ccode_header_filenames (Symbol sym) {
		return get_ccode_attribute(sym).header_filenames;
	}

	public static string get_ccode_feature_test_macros (Symbol sym) {
		return get_ccode_attribute(sym).feature_test_macros;
	}

	public static string get_ccode_prefix (Symbol sym) {
		return get_ccode_attribute(sym).prefix;
	}

	public static string get_ccode_lower_case_prefix (Symbol sym) {
		return get_ccode_attribute(sym).lower_case_prefix;
	}

	public static string get_ccode_lower_case_suffix (Symbol sym) {
		return get_ccode_attribute(sym).lower_case_suffix;
	}

	public static string get_ccode_ref_function (TypeSymbol sym) {
		return get_ccode_attribute(sym).ref_function;
	}

	public static string get_ccode_quark_name (ErrorDomain edomain) {
		return "%s-quark".printf (get_ccode_lower_case_name (edomain).replace ("_", "-"));
	}

	public static bool is_reference_counting (TypeSymbol sym) {
		if (sym is Class) {
			return get_ccode_ref_function (sym) != null;
		} else if (sym is Interface) {
			return true;
		} else {
			return false;
		}
	}

	public static bool is_ref_function_void (DataType type) {
		unowned Class? cl = type.type_symbol as Class;
		if (cl != null) {
			return get_ccode_ref_function_void (cl);
		} else {
			return false;
		}
	}

	public static bool is_free_function_address_of (DataType type) {
		unowned Class? cl = type.type_symbol as Class;
		if (cl != null) {
			return get_ccode_free_function_address_of (cl);
		} else {
			return false;
		}
	}

	public static bool get_ccode_ref_function_void (Class cl) {
		return get_ccode_attribute(cl).ref_function_void;
	}

	public static bool get_ccode_free_function_address_of (Class cl) {
		return get_ccode_attribute(cl).free_function_address_of;
	}

	public static string get_ccode_unref_function (ObjectTypeSymbol sym) {
		return get_ccode_attribute(sym).unref_function;
	}

	public static string get_ccode_ref_sink_function (ObjectTypeSymbol sym) {
		return get_ccode_attribute(sym).ref_sink_function;
	}

	public static string get_ccode_copy_function (TypeSymbol sym) {
		return get_ccode_attribute(sym).copy_function;
	}

	public static string get_ccode_destroy_function (TypeSymbol sym) {
		return get_ccode_attribute(sym).destroy_function;
	}

	public static string? get_ccode_dup_function (TypeSymbol sym) {
		if (sym is Struct) {
			return get_ccode_attribute (sym).dup_function;
		}
		return get_ccode_copy_function (sym);
	}

	public static string get_ccode_free_function (TypeSymbol sym) {
		return get_ccode_attribute(sym).free_function;
	}

	public static bool get_ccode_is_gboxed (TypeSymbol sym) {
		return get_ccode_free_function (sym) == "g_boxed_free";
	}

	public static bool get_ccode_finish_instance (Method m) {
		assert (m.coroutine);
		return get_ccode_attribute (m).finish_instance;
	}

	public static string get_ccode_type_id (CodeNode node) {
		return get_ccode_attribute(node).type_id;
	}

	public static string get_ccode_type_function (TypeSymbol sym) {
		assert (!((sym is Class && ((Class) sym).is_compact) || sym is ErrorCode || sym is Delegate));
		return "%s_get_type".printf (get_ccode_lower_case_name (sym));
	}

	public static string get_ccode_marshaller_type_name (CodeNode node) {
		return get_ccode_attribute(node).marshaller_type_name;
	}

	public static string get_ccode_get_value_function (CodeNode sym) {
		return get_ccode_attribute(sym).get_value_function;
	}

	public static string get_ccode_set_value_function (CodeNode sym) {
		return get_ccode_attribute(sym).set_value_function;
	}

	public static string get_ccode_take_value_function (CodeNode sym) {
		return get_ccode_attribute(sym).take_value_function;
	}

	public static string get_ccode_param_spec_function (CodeNode sym) {
		return get_ccode_attribute(sym).param_spec_function;
	}

	public static string get_ccode_type_check_function (TypeSymbol sym) {
		unowned Class? cl = sym as Class;
		var a = sym.get_attribute_string ("CCode", "type_check_function");
		if (cl != null && a != null) {
			return a;
		} else if ((cl != null && cl.is_compact) || sym is Struct || sym is Enum || sym is Delegate) {
			return "";
		} else {
			return get_ccode_upper_case_name (sym, "IS_");
		}
	}

	public static string get_ccode_class_type_check_function (Class cl) {
		assert (!cl.is_compact);
		return "%s_CLASS".printf (get_ccode_type_check_function (cl));
	}

	public static string get_ccode_default_value (TypeSymbol sym) {
		return get_ccode_attribute(sym).default_value;
	}

	public static string get_ccode_default_value_on_error (TypeSymbol sym) {
		return get_ccode_attribute (sym).default_value_on_error;
	}

	public static bool get_ccode_has_copy_function (Struct st) {
		return st.get_attribute_bool ("CCode", "has_copy_function", true);
	}

	public static bool get_ccode_has_destroy_function (Struct st) {
		return st.get_attribute_bool ("CCode", "has_destroy_function", true);
	}

	public static double get_ccode_instance_pos (CodeNode node) {
		if (node is Delegate) {
			return node.get_attribute_double ("CCode", "instance_pos", -2);
		} else {
			return node.get_attribute_double ("CCode", "instance_pos", 0);
		}
	}

	public static double get_ccode_error_pos (Callable c) {
		return c.get_attribute_double ("CCode", "error_pos", -1);
	}

	public static bool get_ccode_array_length (CodeNode node) {
		return get_ccode_attribute(node).array_length;
	}

	public static string get_ccode_array_length_type (CodeNode node) {
		if (node is ArrayType) {
			return get_ccode_name (((ArrayType) node).length_type);
		} else if (node is DataType) {
			Report.error (node.source_reference, "`CCode.array_length_type' not supported");
			return "";
		} else {
			assert (node is Method || node is Parameter || node is Delegate || node is Property || node is Field);
			return get_ccode_attribute(node).array_length_type;
		}
	}

	public static bool get_ccode_array_null_terminated (CodeNode node) {
		return get_ccode_attribute(node).array_null_terminated;
	}

	public static string? get_ccode_array_length_name (CodeNode node) {
		return get_ccode_attribute(node).array_length_name;
	}

	public static string? get_ccode_array_length_expr (CodeNode node) {
		return get_ccode_attribute(node).array_length_expr;
	}

	public static double get_ccode_array_length_pos (CodeNode node) {
		var a = node.get_attribute ("CCode");
		if (a != null && a.has_argument ("array_length_pos")) {
			return a.get_double ("array_length_pos");
		}
		if (node is Parameter) {
			unowned Parameter param = (Parameter) node;
			return get_ccode_pos (param) + 0.1;
		} else {
			return -3;
		}
	}

	public static double get_ccode_delegate_target_pos (CodeNode node) {
		var a = node.get_attribute ("CCode");
		if (a != null && a.has_argument ("delegate_target_pos")) {
			return a.get_double ("delegate_target_pos");
		}
		if (node is Parameter) {
			unowned Parameter param = (Parameter) node;
			return get_ccode_pos (param) + 0.1;
		} else {
			return -3;
		}
	}

	public static double get_ccode_destroy_notify_pos (CodeNode node) {
		var a = node.get_attribute ("CCode");
		if (a != null && a.has_argument ("destroy_notify_pos")) {
			return a.get_double ("destroy_notify_pos");
		}
		return get_ccode_delegate_target_pos (node) + 0.01;
	}

	public static bool get_ccode_delegate_target (CodeNode node) {
		return get_ccode_attribute(node).delegate_target;
	}

	public static string get_ccode_delegate_target_name (Variable variable) {
		return get_ccode_attribute(variable).delegate_target_name;
	}

	public static string get_ccode_delegate_target_destroy_notify_name (Variable variable) {
		return get_ccode_attribute(variable).delegate_target_destroy_notify_name;
	}

	public static double get_ccode_pos (Parameter param) {
		return get_ccode_attribute(param).pos;
	}

	public static string? get_ccode_type (CodeNode node) {
		return get_ccode_attribute(node).ctype;
	}

	public static bool get_ccode_simple_generics (Method m) {
		return m.get_attribute_bool ("CCode", "simple_generics");
	}

	public static string get_ccode_real_name (Symbol sym) {
		return get_ccode_attribute(sym).real_name;
	}

	public static string get_ccode_constructv_name (CreationMethod m) {
		const string infix = "constructv";

		unowned Class parent = (Class) m.parent_symbol;

		if (m.name == ".new") {
			return "%s%s".printf (get_ccode_lower_case_prefix (parent), infix);
		} else {
			return "%s%s_%s".printf (get_ccode_lower_case_prefix (parent), infix, m.name);
		}
	}

	public static string get_ccode_vfunc_name (Method m) {
		return get_ccode_attribute(m).vfunc_name;
	}

	public static double get_ccode_async_result_pos (Method m) {
		assert (m.coroutine);
		return m.get_attribute_double ("CCode", "async_result_pos", 0.1);
	}

	public static string get_ccode_finish_name (Method m) {
		assert (m.coroutine);
		return get_ccode_attribute(m).finish_name;
	}

	public static string get_ccode_finish_vfunc_name (Method m) {
		assert (m.coroutine);
		return get_ccode_attribute(m).finish_vfunc_name;
	}

	public static string get_ccode_finish_real_name (Method m) {
		assert (m.coroutine);
		return get_ccode_attribute(m).finish_real_name;
	}

	public static bool get_ccode_no_accessor_method (Property p) {
		return p.has_attribute ("NoAccessorMethod");
	}

	public static bool get_ccode_concrete_accessor (Property p) {
		return p.has_attribute ("ConcreteAccessor");
	}

	public static bool get_ccode_has_emitter (Signal sig) {
		return sig.has_attribute ("HasEmitter");
	}

	public static bool get_ccode_has_type_id (TypeSymbol sym) {
		if (sym is ErrorDomain && sym.external_package) {
			return sym.get_attribute_bool ("CCode", "has_type_id", false);
		} else {
			return sym.get_attribute_bool ("CCode", "has_type_id", true);
		}
	}

	public static bool get_ccode_has_new_function (Method m) {
		return m.get_attribute_bool ("CCode", "has_new_function", true);
	}

	public static bool get_ccode_has_generic_type_parameter (Method m) {
		var a = m.get_attribute ("CCode");
		return a != null && a.has_argument ("generic_type_pos");
	}

	public static double get_ccode_generic_type_pos (Method m) {
		return m.get_attribute_double ("CCode", "generic_type_pos");
	}

	public static bool get_ccode_no_wrapper (Method m) {
		return m.has_attribute ("NoWrapper");
	}

	public static string get_ccode_sentinel (Method m) {
		return get_ccode_attribute(m).sentinel;
	}
}
