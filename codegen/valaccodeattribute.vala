/* valaccodeattribute.vala
 *
 * Copyright (C) 2011  Luca Bruno
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
 * 	Luca Bruno <lucabru@src.gnome.org>
 */


/**
 * Cache for the CCode attribute
 */
public class Vala.CCodeAttribute : AttributeCache {
	private static int next_lambda_id = 0;

	private weak CodeNode node;
	private weak Symbol? sym;
	private Attribute ccode;

	public string name {
		get {
			if (_name == null) {
				if (ccode != null) {
					_name = ccode.get_string ("cname");
				}
				if (_name == null) {
					_name = get_default_name ();
				}
			}
			return _name;
		}
	}

	public string const_name {
		get {
			if (_const_name == null) {
				if (ccode != null) {
					_const_name = ccode.get_string ("const_cname");
				}
				if (_const_name == null) {
					_const_name = get_default_const_name ();
				}
			}
			return _const_name;
		}
	}

	public string type_name {
		get {
			if (_type_name == null) {
				if (ccode != null) {
					_type_name = ccode.get_string ("type_cname");
				}
				if (_type_name == null) {
					if (sym is Class) {
						_type_name = "%sClass".printf (get_ccode_name (sym));
					} else if (sym is Interface) {
						_type_name = "%sIface".printf (get_ccode_name (sym));
					} else {
						Report.error (sym.source_reference, "`CCode.type_cname' not supported");
						_type_name = "";
					}
				}
			}
			return _type_name;
		}
	}

	public string feature_test_macros {
		get {
			if (_feature_test_macros == null) {
				if (ccode != null) {
					_feature_test_macros = ccode.get_string ("feature_test_macro");
				}
				if (_feature_test_macros == null) {
					_feature_test_macros = "";
				}
			}
			return _feature_test_macros;
		}
	}

	public string header_filenames {
		get {
			if (_header_filenames == null) {
				if (ccode != null) {
					_header_filenames = ccode.get_string ("cheader_filename");
				}
				if (_header_filenames == null) {
					_header_filenames = get_default_header_filenames ();
				}
			}
			return _header_filenames;
		}
	}

	public string prefix {
		get {
			if (_prefix == null) {
				if (ccode != null) {
					_prefix = ccode.get_string ("cprefix");
				}
				if (_prefix == null) {
					_prefix = get_default_prefix ();
				}
			}
			return _prefix;
		}
	}

	public string lower_case_prefix {
		get {
			if (_lower_case_prefix == null) {
				if (ccode != null) {
					_lower_case_prefix = ccode.get_string ("lower_case_cprefix");
					if (_lower_case_prefix == null && (sym is ObjectTypeSymbol || sym is Struct)) {
						_lower_case_prefix = ccode.get_string ("cprefix");
					}
				}
				if (_lower_case_prefix == null) {
					_lower_case_prefix = get_default_lower_case_prefix ();
				}
			}
			return _lower_case_prefix;
		}
	}

	public string lower_case_suffix {
		get {
			if (_lower_case_suffix == null) {
				if (ccode != null) {
					_lower_case_suffix = ccode.get_string ("lower_case_csuffix");
				}
				if (_lower_case_suffix == null) {
					_lower_case_suffix = get_default_lower_case_suffix ();
				}
			}
			return _lower_case_suffix;
		}
	}

	public string ref_function {
		get {
			if (!ref_function_set) {
				if (ccode != null) {
					_ref_function = ccode.get_string ("ref_function");
				}
				if (_ref_function == null) {
					_ref_function = get_default_ref_function ();
				}
				ref_function_set = true;
			}
			return _ref_function;
		}
	}

	public bool ref_function_void {
		get {
			if (_ref_function_void == null) {
				if (ccode != null && ccode.has_argument ("ref_function_void")) {
					_ref_function_void = ccode.get_bool ("ref_function_void");
				} else {
					var cl = (Class) sym;
					if (cl.base_class != null) {
						_ref_function_void = get_ccode_ref_function_void (cl.base_class);
					} else {
						_ref_function_void = false;
					}
				}
			}
			return _ref_function_void;
		}
	}

	public string unref_function {
		get {
			if (!unref_function_set) {
				if (ccode != null) {
					_unref_function = ccode.get_string ("unref_function");
				}
				if (_unref_function == null) {
					_unref_function = get_default_unref_function ();
				}
				unref_function_set = true;
			}
			return _unref_function;
		}
	}

	public string ref_sink_function {
		get {
			if (_ref_sink_function == null) {
				if (ccode != null) {
					_ref_sink_function = ccode.get_string ("ref_sink_function");
				}
				if (_ref_sink_function == null) {
					_ref_sink_function = get_default_ref_sink_function ();
				}
			}
			return _ref_sink_function;
		}
	}

	public string copy_function {
		get {
			if (!copy_function_set) {
				if (ccode != null) {
					_copy_function = ccode.get_string ("copy_function");
				}
				if (_copy_function == null && sym is Struct) {
					_copy_function = "%scopy".printf (lower_case_prefix);
				}
				if (_copy_function == null && sym is TypeParameter) {
					_copy_function = "%s_dup_func".printf (sym.name.ascii_down ());
				}
				copy_function_set = true;
			}
			return _copy_function;
		}
	}

	public string destroy_function {
		get {
			if (!destroy_function_set) {
				if (ccode != null) {
					_destroy_function = ccode.get_string ("destroy_function");
				}
				if (_destroy_function == null && sym is Struct) {
					_destroy_function = "%sdestroy".printf (lower_case_prefix);
				}
				if (_destroy_function == null && sym is TypeParameter) {
					_destroy_function = "%s_destroy_func".printf (sym.name.ascii_down ());
				}
				destroy_function_set = true;
			}
			return _destroy_function;
		}
	}

	public string dup_function {
		get {
			if (!dup_function_set) {
				if (ccode != null) {
					_dup_function = ccode.get_string ("dup_function");
				}
				if (_dup_function == null && !sym.external_package
				    && sym is Struct && !((Struct) sym).is_simple_type ()) {
					_dup_function = "%sdup".printf (lower_case_prefix);
				}
				dup_function_set = true;
			}
			return _dup_function;
		}
	}

	public string free_function {
		get {
			if (!free_function_set) {
				if (ccode != null) {
					_free_function = ccode.get_string ("free_function");
				}
				if (_free_function == null) {
					_free_function = get_default_free_function ();
				}
				free_function_set = true;
			}
			return _free_function;
		}
	}

	public bool free_function_address_of {
		get {
			if (_free_function_address_of == null) {
				if (ccode != null && ccode.has_argument ("free_function_address_of")) {
					_free_function_address_of = ccode.get_bool ("free_function_address_of");
				} else {
					unowned Class cl = (Class) sym;
					if (cl.base_class != null) {
						_free_function_address_of = get_ccode_free_function_address_of (cl.base_class);
					} else {
						_free_function_address_of = false;
					}
				}
			}
			return _free_function_address_of;
		}
	}

	public string ctype {
		get {
			if (!ctype_set) {
				if (ccode != null) {
					_ctype = ccode.get_string ("type");
					if (_ctype == null) {
						_ctype = ccode.get_string ("ctype");
						if (_ctype != null) {
							Report.deprecated (node.source_reference, "[CCode (ctype = \"...\")] is deprecated, use [CCode (type = \"...\")] instead.");
						}
					}
				}
				ctype_set = true;
			}
			return _ctype;
		}
	}

	public string type_id {
		get {
			if (_type_id == null) {
				if (ccode != null) {
					_type_id = ccode.get_string ("type_id");
				}
				if (_type_id == null && sym is TypeParameter) {
					_type_id = "%s_type".printf (sym.name.ascii_down ());
				}
				if (_type_id == null) {
					_type_id = get_default_type_id ();
				}
			}
			return _type_id;
		}
	}

	public string marshaller_type_name {
		get {
			if (_marshaller_type_name == null) {
				if (ccode != null) {
					_marshaller_type_name = ccode.get_string ("marshaller_type_name");
				}
				if (_marshaller_type_name == null) {
					_marshaller_type_name = get_default_marshaller_type_name ();
				}
			}
			return _marshaller_type_name;
		}
	}

	public string get_value_function {
		get {
			if (_get_value_function == null) {
				if (ccode != null) {
					_get_value_function = ccode.get_string ("get_value_function");
				}
				if (_get_value_function == null) {
					_get_value_function = get_default_get_value_function ();
				}
			}
			return _get_value_function;
		}
	}

	public string set_value_function {
		get {
			if (_set_value_function == null) {
				if (ccode != null) {
					_set_value_function = ccode.get_string ("set_value_function");
				}
				if (_set_value_function == null) {
					_set_value_function = get_default_set_value_function ();
				}
			}
			return _set_value_function;
		}
	}

	public string take_value_function {
		get {
			if (_take_value_function == null) {
				if (ccode != null) {
					_take_value_function = ccode.get_string ("take_value_function");
				}
				if (_take_value_function == null) {
					_take_value_function = get_default_take_value_function ();
				}
			}
			return _take_value_function;
		}
	}

	public string param_spec_function {
		get {
			if (_param_spec_function == null) {
				if (ccode != null) {
					_param_spec_function = ccode.get_string ("param_spec_function");
				}
				if (_param_spec_function == null) {
					_param_spec_function = get_default_param_spec_function ();
				}
			}
			return _param_spec_function;
		}
	}

	public string default_value {
		get {
			if (_default_value == null) {
				if (ccode != null) {
					_default_value = ccode.get_string ("default_value");
				}
				if (_default_value == null) {
					_default_value = get_default_default_value ();
				}
			}
			return _default_value;
		}
	}

	public string default_value_on_error {
		get {
			if (_default_value_on_error == null) {
				if (ccode != null) {
					_default_value_on_error = ccode.get_string ("default_value_on_error");
				}
				if (_default_value_on_error == null) {
					_default_value_on_error = get_default_default_value_on_error ();
				}
			}
			return _default_value_on_error;
		}
	}

	public double pos {
		get {
			if (_pos == null) {
				if (ccode != null && ccode.has_argument ("pos")) {
					_pos = ccode.get_double ("pos");
				} else {
					unowned Parameter param = (Parameter) node;
					unowned Callable? callable = param.parent_symbol as Callable;
					unowned Method? method = param.parent_symbol as Method;
					if (method != null && method.coroutine) {
						int index = method.get_async_begin_parameters ().index_of (param);
						if (index < 0) {
							index = method.get_async_end_parameters ().index_of (param);
						}
						if (index < 0) {
							Report.error (param.source_reference, "internal: Parameter `%s' not found in `%s'", param.name, method.get_full_name ());
						}
						_pos = index + 1.0;
					} else if (callable != null) {
						_pos = callable.get_parameters ().index_of (param) + 1.0;
					} else {
						_pos = 0.0;
					}
				}
			}
			return _pos;
		}
	}

	public string real_name {
		get {
			if (_real_name == null) {
				if (ccode != null && sym is CreationMethod) {
					_real_name = ccode.get_string ("construct_function");
				}
				if (_real_name == null) {
					_real_name = get_default_real_name ();
				}
			}
			return _real_name;
		}
	}

	public string vfunc_name {
		get {
			if (_vfunc_name == null) {
				if (ccode != null) {
					_vfunc_name = ccode.get_string ("vfunc_name");
				}
				if (_vfunc_name == null) {
					unowned Method? m = node as Method;
					if (m != null && m.signal_reference != null) {
						_vfunc_name = get_ccode_lower_case_name (m.signal_reference);
					} else {
						_vfunc_name = sym.name;
					}
				}
			}
			return _vfunc_name;
		}
	}

	public string finish_name {
		get {
			if (_finish_name == null) {
				if (ccode != null) {
					_finish_name = ccode.get_string ("finish_name");
					if (_finish_name == null) {
						_finish_name = ccode.get_string ("finish_function");
						if (_finish_name != null) {
							Report.deprecated (node.source_reference, "[CCode (finish_function = \"...\")] is deprecated, use [CCode (finish_name = \"...\")] instead.");
						}
					}
				}
				if (_finish_name == null) {
					_finish_name = get_finish_name_for_basename (name);
				}
			}
			return _finish_name;
		}
	}

	public string finish_vfunc_name {
		get {
			if (_finish_vfunc_name == null) {
				if (ccode != null) {
					_finish_vfunc_name = ccode.get_string ("finish_vfunc_name");
				}
				if (_finish_vfunc_name == null) {
					_finish_vfunc_name = get_finish_name_for_basename (vfunc_name);
				}
			}
			return _finish_vfunc_name;
		}
	}

	public string finish_real_name {
		get {
			if (_finish_real_name == null) {
				unowned Method? m = node as Method;
				if (m != null && !(m is CreationMethod) && !(m.is_abstract || m.is_virtual)) {
					_finish_real_name = finish_name;
				} else {
					_finish_real_name = get_finish_name_for_basename (real_name);
				}
			}
			return _finish_real_name;
		}
	}

	public bool finish_instance {
		get {
			if (_finish_instance == null) {
				unowned Method? m = node as Method;
				bool is_creation_method = m is CreationMethod;
				if (ccode == null || m == null || m.is_abstract || m.is_virtual) {
					_finish_instance = !is_creation_method;
				} else {
					_finish_instance = ccode.get_bool ("finish_instance", !is_creation_method);
				}
			}
			return _finish_instance;
		}
	}

	public bool delegate_target {
		get {
			if (_delegate_target == null) {
				if (ccode != null) {
					_delegate_target = ccode.get_bool ("delegate_target", get_default_delegate_target ());
				} else {
					_delegate_target = get_default_delegate_target ();
				}
			}
			return _delegate_target;
		}
	}

	public string delegate_target_name {
		get {
			if (_delegate_target_name == null) {
				if (ccode != null) {
					_delegate_target_name = ccode.get_string ("delegate_target_cname");
				}
				if (_delegate_target_name == null) {
					_delegate_target_name = "%s_target".printf (name);
				}
			}
			return _delegate_target_name;
		}
	}

	public string delegate_target_destroy_notify_name {
		get {
			if (_delegate_target_destroy_notify_name == null) {
				if (ccode != null) {
					_delegate_target_destroy_notify_name = ccode.get_string ("destroy_notify_cname");
				}
				if (_delegate_target_destroy_notify_name == null) {
					_delegate_target_destroy_notify_name = "%s_destroy_notify".printf (delegate_target_name);
				}
			}
			return _delegate_target_destroy_notify_name;
		}
	}

	public bool array_length {
		get {
			if (_array_length == null) {
				if (node.has_attribute ("NoArrayLength")) {
					Report.deprecated (node.source_reference, "[NoArrayLength] is deprecated, use [CCode (array_length = false)] instead.");
					_array_length = false;
				} else if (ccode != null && ccode.has_argument ("array_length")) {
					_array_length = ccode.get_bool ("array_length");
				} else {
					_array_length = get_default_array_length ();
				}
			}
			return _array_length;
		}
	}

	public bool array_null_terminated {
		get {
			if (_array_null_terminated == null) {
				// If arrays claim to have an array-length and also are null-terminated then rely on the given length
				if (ccode != null && ccode.has_argument ("array_length") && ccode.get_bool ("array_length")) {
					_array_null_terminated = false;
				} else if (ccode != null && ccode.has_argument ("array_null_terminated")) {
					_array_null_terminated = ccode.get_bool ("array_null_terminated");
				} else {
					_array_null_terminated = get_default_array_null_terminated ();
				}
			}
			return _array_null_terminated;
		}
	}

	public string array_length_type {
		get {
			if (_array_length_type == null) {
				if (ccode != null && ccode.has_argument ("array_length_type")) {
					_array_length_type = ccode.get_string ("array_length_type");
				} else {
					_array_length_type = get_default_array_length_type ();
				}
			}
			return _array_length_type;
		}
	}

	public string sentinel {
		get {
			if (_sentinel == null) {
				if (ccode != null) {
					_sentinel = ccode.get_string ("sentinel", "NULL");
				} else {
					_sentinel = "NULL";
				}
			}
			return _sentinel;
		}
	}

	public string? array_length_name { get; private set; }
	public string? array_length_expr { get; private set; }

	private string _name;
	private string _const_name;
	private string _type_name;
	private string _feature_test_macros;
	private string _header_filenames;
	private string _prefix;
	private string _lower_case_prefix;
	private string _lower_case_suffix;
	private string? _ref_function;
	private bool ref_function_set;
	private bool? _ref_function_void;
	private string? _unref_function;
	private bool unref_function_set;
	private string _ref_sink_function;
	private string? _copy_function;
	private bool copy_function_set;
	private string? _destroy_function;
	private bool destroy_function_set;
	private string? _dup_function;
	private bool dup_function_set;
	private string? _free_function;
	private bool free_function_set;
	private bool? _free_function_address_of;
	private string _type_id;
	private string _marshaller_type_name;
	private string _get_value_function;
	private string _set_value_function;
	private string _take_value_function;
	private string _param_spec_function;
	private string _default_value;
	private string _default_value_on_error;
	private double? _pos;
	private string _vfunc_name;
	private string _finish_name;
	private string _finish_vfunc_name;
	private string _finish_real_name;
	private bool? _finish_instance;
	private string _real_name;
	private bool? _delegate_target;
	private string _delegate_target_name;
	private string _delegate_target_destroy_notify_name;
	private string _ctype;
	private bool ctype_set = false;
	private bool? _array_length;
	private string _array_length_type;
	private bool? _array_null_terminated;
	private string _sentinel;

	private static int dynamic_method_id;

	public CCodeAttribute (CodeNode node) {
		this.node = node;
		this.sym = node as Symbol;

		ccode = node.get_attribute ("CCode");
		if (ccode != null) {
			array_length_name = ccode.get_string ("array_length_cname");
			array_length_expr = ccode.get_string ("array_length_cexpr");
		}
	}

	private string get_default_name () {
		if (sym != null) {
			if (sym is Constant && !(sym is EnumValue)) {
				if (sym.parent_symbol is Block) {
					// local constant
					return sym.name;
				}
				return "%s%s".printf (get_ccode_lower_case_prefix (sym.parent_symbol).ascii_up (), sym.name);
			} else if (sym is Field) {
				var cname = sym.name;
				if (((Field) sym).binding == MemberBinding.STATIC) {
					cname = "%s%s".printf (get_ccode_lower_case_prefix (sym.parent_symbol), sym.name);
				}
				if (cname[0].isdigit ()) {
					Report.error (node.source_reference, "Field name starts with a digit. Use the `cname' attribute to provide a valid C name if intended");
				} else if (CCodeBaseModule.reserved_identifiers.contains (cname)) {
					Report.error (node.source_reference, "Field name `%s' collides with reserved identifier. Use the `cname' attribute to provide a valid C name if intended", cname);
				}
				return cname;
			} else if (sym is CreationMethod) {
				unowned CreationMethod m = (CreationMethod) sym;
				string infix;
				if (m.parent_symbol is Struct) {
					infix = "init";
				} else {
					infix = "new";
				}
				if (m.name == ".new") {
					return "%s%s".printf (get_ccode_lower_case_prefix (m.parent_symbol), infix);
				} else {
					return "%s%s_%s".printf (get_ccode_lower_case_prefix (m.parent_symbol), infix, m.name);
				}
			} else if (sym is DynamicMethod) {
				return "_dynamic_%s%d".printf (sym.name, dynamic_method_id++);
			} else if (sym is Method) {
				unowned Method m = (Method) sym;
				if (m.parent_node is LambdaExpression) {
					return "_vala_lambda%d_".printf (next_lambda_id++);
				}
				if (m.is_async_callback) {
					return "%s_co".printf (get_ccode_real_name ((Method) m.parent_symbol));
				}
				if (m.signal_reference != null) {
					return "%s%s".printf (get_ccode_lower_case_prefix (m.parent_symbol), get_ccode_lower_case_name (m.signal_reference));
				}
				string cname;
				if (sym.name == "main" && sym.parent_symbol.name == null) {
					// avoid conflict with generated main function
					if (m.coroutine) {
						return "_vala_main_async";
					} else {
						return "_vala_main";
					}
				} else if (sym.name.has_prefix ("_")) {
					cname = "_%s%s".printf (get_ccode_lower_case_prefix (sym.parent_symbol), sym.name.substring (1));
				} else {
					cname = "%s%s".printf (get_ccode_lower_case_prefix (sym.parent_symbol), sym.name);
				}
				if (CCodeBaseModule.reserved_identifiers.contains (cname)) {
					Report.error (node.source_reference, "Method name `%s' collides with reserved identifier. Use the `cname' attribute to provide a valid C name if intended", cname);
				}
				return cname;
			} else if (sym is Property) {
				return sym.name.replace ("_", "-");
			} else if (sym is PropertyAccessor) {
				unowned PropertyAccessor acc = (PropertyAccessor) sym;
				var t = (TypeSymbol) acc.prop.parent_symbol;

				if (acc.readable) {
					return "%sget_%s".printf (get_ccode_lower_case_prefix (t), acc.prop.name);
				} else {
					return "%sset_%s".printf (get_ccode_lower_case_prefix (t), acc.prop.name);
				}
			} else if (sym is Signal) {
				return Symbol.camel_case_to_lower_case (sym.name).replace ("_", "-");;
			} else if (sym is LocalVariable) {
				unowned string name = sym.name;
				if (CCodeBaseModule.reserved_identifiers.contains (name) || CCodeBaseModule.reserved_vala_identifiers.contains (name)) {
					return "_%s_".printf (name);
				} else {
					return name;
				}
			} else if (sym is Parameter) {
				unowned Parameter param = (Parameter) sym;
				if (param.ellipsis) {
					return "...";
				}
				unowned string name = sym.name;
				if (CCodeBaseModule.reserved_identifiers.contains (name) || CCodeBaseModule.reserved_vala_identifiers.contains (name)) {
					return "_%s_".printf (name);
				} else {
					return name;
				}
			} else if (sym is TypeParameter) {
				assert (node is GenericType);
				var type = (GenericType) node;
				if (type.value_owned) {
					if (CodeContext.get ().profile == Profile.GOBJECT) {
						return "gpointer";
					} else {
						return "void *";
					}
				} else {
					if (CodeContext.get ().profile == Profile.GOBJECT) {
						return "gconstpointer";
					} else {
						return "const void *";
					}
				}
			} else {
				return "%s%s".printf (get_ccode_prefix (sym.parent_symbol), sym.name);
			}
		} else if (node is ObjectType) {
			var type = (ObjectType) node;

			string cname;
			if (!type.value_owned) {
				cname = get_ccode_const_name (type.type_symbol);
			} else {
				cname = get_ccode_name (type.type_symbol);
			}
			return "%s*".printf (cname);
		} else if (node is ArrayType) {
			var type = (ArrayType) node;
			var cname = get_ccode_name (type.element_type);
			if (type.inline_allocated) {
				return cname;
			} else {
				return "%s*".printf (cname);
			}
		} else if (node is DelegateType) {
			var type = (DelegateType) node;
			return get_ccode_name (type.delegate_symbol);
		} else if (node is ErrorType) {
			return "GError*";
		} else if (node is GenericType) {
			var type = (GenericType) node;
			if (type.value_owned) {
				if (CodeContext.get ().profile == Profile.GOBJECT) {
					return "gpointer";
				} else {
					return "void *";
				}
			} else {
				if (CodeContext.get ().profile == Profile.GOBJECT) {
					return "gconstpointer";
				} else {
					return "const void *";
				}
			}
		} else if (node is MethodType) {
			if (CodeContext.get ().profile == Profile.GOBJECT) {
				return "gpointer";
			} else {
				return "void *";
			}
		} else if (node is NullType) {
			if (CodeContext.get ().profile == Profile.GOBJECT) {
				return "gpointer";
			} else {
				return "void *";
			}
		} else if (node is PointerType) {
			var type = (PointerType) node;
			if (type.base_type.type_symbol != null && type.base_type.type_symbol.is_reference_type ()) {
				return get_ccode_name (type.base_type);
			} else {
				return "%s*".printf (get_ccode_name (type.base_type));
			}
		} else if (node is VoidType) {
			return "void";
		} else if (node is ClassType) {
			var type = (ClassType) node;
			return "%s*".printf (get_ccode_type_name (type.class_symbol));
		} else if (node is InterfaceType) {
			var type = (InterfaceType) node;
			return "%s*".printf (get_ccode_type_name (type.interface_symbol));
		} else if (node is ValueType) {
			var type = (ValueType) node;
			var cname = get_ccode_name (type.type_symbol);
			if (type.nullable) {
				return "%s*".printf (cname);
			} else {
				return cname;
			}
		} else if (node is CType) {
			return ((CType) node).ctype_name;
		} else {
			Report.error (node.source_reference, "Unresolved type reference");
			return "";
		}
	}

	private string get_default_header_filenames () {
		if (sym is DynamicProperty || sym is DynamicMethod) {
			return "";
		}
		if (sym.parent_symbol != null && !sym.is_extern) {
			var parent_headers = get_ccode_header_filenames (sym.parent_symbol);
			if (parent_headers.length > 0) {
				return parent_headers;
			}
		}
		if (sym.source_reference != null && !sym.external_package && !sym.is_extern) {
			// don't add default include directives for VAPI files
			return sym.source_reference.file.get_cinclude_filename ();
		}
		return "";
	}

	private string get_default_prefix () {
		if (sym is ObjectTypeSymbol) {
			return name;
		} else if (sym is Enum || sym is ErrorDomain) {
			return "%s_".printf (get_ccode_upper_case_name (sym));
		} else if (sym is Namespace) {
			if (sym.name != null) {
				var parent_prefix = "";
				if (sym.parent_symbol != null) {
					parent_prefix = get_ccode_prefix (sym.parent_symbol);
				}
				return "%s%s".printf (parent_prefix, sym.name);
			} else {
				return "";
			}
		} else if (sym.name != null) {
			return sym.name;
		}
		return "";
	}

	private string get_default_lower_case_prefix () {
		if (sym is Namespace) {
			if (sym.name == null) {
				return "";
			} else {
				return "%s%s_".printf (get_ccode_lower_case_prefix (sym.parent_symbol), Symbol.camel_case_to_lower_case (sym.name));
			}
		} else if (sym is Method) {
			// for lambda expressions
			return "";
		} else {
			return "%s_".printf (get_ccode_lower_case_name (sym));
		}
	}

	private string get_default_lower_case_suffix () {
		if (sym is ObjectTypeSymbol) {
			var csuffix = Symbol.camel_case_to_lower_case (sym.name);

			// FIXME Code duplication with GirParser.Node.get_default_lower_case_suffix()
			// remove underscores in some cases to avoid conflicts of type macros
			if (csuffix.has_prefix ("type_")) {
				csuffix = "type" + csuffix.substring ("type_".length);
			} else if (csuffix.has_prefix ("is_")) {
				csuffix = "is" + csuffix.substring ("is_".length);
			}
			if (csuffix.has_suffix ("_class")) {
				csuffix = csuffix.substring (0, csuffix.length - "_class".length) + "class";
			}
			return csuffix;
		} else if (sym is Signal) {
			return get_ccode_attribute (sym).name.replace ("-", "_");
		} else if (sym.name != null) {
			return Symbol.camel_case_to_lower_case (sym.name);
		}
		return "";
	}

	private string? get_default_ref_function () {
		if (sym is Class) {
			unowned Class cl = (Class) sym;
			if (cl.is_fundamental ()) {
				return "%sref".printf (lower_case_prefix);
			} else if (cl.base_class != null) {
				return get_ccode_ref_function (cl.base_class);
			}
		} else if (sym is Interface) {
			foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
				string ref_func = get_ccode_ref_function ((ObjectTypeSymbol) prereq.type_symbol);
				if (ref_func != null) {
					return ref_func;
				}
			}
		}
		return null;
	}

	private string? get_default_unref_function () {
		if (sym is Class) {
			unowned Class cl = (Class) sym;
			if (cl.is_fundamental ()) {
				return "%sunref".printf (lower_case_prefix);
			} else if (cl.base_class != null) {
				return get_ccode_unref_function (cl.base_class);
			}
		} else if (sym is Interface) {
			foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
				string unref_func = get_ccode_unref_function ((ObjectTypeSymbol) prereq.type_symbol);
				if (unref_func != null) {
					return unref_func;
				}
			}
		}
		return null;
	}

	private string get_default_ref_sink_function () {
		if (sym is Class) {
			unowned Class? base_class = ((Class) sym).base_class;
			if (base_class != null) {
				return get_ccode_ref_sink_function (base_class);
			}
		} else if (sym is Interface) {
			foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
				string ref_sink_func = get_ccode_ref_sink_function ((ObjectTypeSymbol) prereq.type_symbol);
				if (ref_sink_func != "") {
					return ref_sink_func;
				}
			}
		}
		return "";
	}

	private string? get_default_free_function () {
		if (sym is Class) {
			unowned Class cl = (Class) sym;
			if (cl.base_class != null) {
				return get_ccode_free_function (cl.base_class);
			}
			return "%sfree".printf (lower_case_prefix);
		} else if (sym is Struct) {
			if (!sym.external_package && !((Struct) sym).is_simple_type ()) {
				return "%sfree".printf (lower_case_prefix);
			}
		}
		return null;
	}

	private string get_default_type_id () {
		if (sym != null) {
			if (sym is Class && !((Class) sym).is_compact || sym is Interface) {
				return get_ccode_upper_case_name (sym, "TYPE_");
			} else if (sym is Struct) {
				unowned Struct st = (Struct) sym;
				unowned Struct? base_struct = st.base_struct;
				if (!get_ccode_has_type_id (st) || (base_struct != null && base_struct.is_simple_type ())) {
					if (base_struct != null) {
						return get_ccode_type_id (base_struct);
					}
					if (!st.is_simple_type ()) {
						return "G_TYPE_POINTER";
					}
				} else {
					return get_ccode_upper_case_name (st, "TYPE_");
				}
			} else if (sym is Enum) {
				unowned Enum en = (Enum) sym;
				if (get_ccode_has_type_id (en)) {
					return get_ccode_upper_case_name (en, "TYPE_");
				} else {
					return en.is_flags ? "G_TYPE_UINT" : "G_TYPE_INT";
				}
			} else if (sym is ErrorDomain) {
				unowned ErrorDomain edomain = (ErrorDomain) sym;
				if (get_ccode_has_type_id (edomain)) {
					return get_ccode_upper_case_name (edomain, "TYPE_");
				} else {
					return "G_TYPE_ERROR";
				}
			} else {
				return "G_TYPE_POINTER";
			}
		} else if (node is ArrayType && ((ArrayType) node).element_type.type_symbol == CodeContext.get ().analyzer.string_type.type_symbol) {
			return "G_TYPE_STRV";
		} else if (node is PointerType || node is DelegateType) {
			return "G_TYPE_POINTER";
		} else if (node is ErrorType) {
			return "G_TYPE_ERROR";
		} else if (node is VoidType) {
			return "G_TYPE_NONE";
		} else {
			var type = (DataType) node;
			if (type.type_symbol != null) {
				return get_ccode_type_id (type.type_symbol);
			}
		}
		return "";
	}

	private string get_default_marshaller_type_name () {
		if (sym != null) {
			if (sym is Class) {
				unowned Class cl = (Class) sym;
				if (cl.base_class != null) {
					return get_ccode_marshaller_type_name (cl.base_class);
				} else if (!cl.is_compact) {
					return get_ccode_upper_case_name (cl);
				} else if (type_id == "G_TYPE_POINTER") {
					return "POINTER";
				} else {
					return "BOXED";
				}
			} else if (sym is Enum) {
				unowned Enum en = (Enum) sym;
				if (get_ccode_has_type_id (en)) {
					if (en.is_flags) {
						return "FLAGS";
					} else {
						return "ENUM";
					}
				} else {
					if (en.is_flags) {
						return "UINT";
					} else {
						return "INT";
					}
				}
			} else if (sym is Interface) {
				foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
					var type_name = get_ccode_marshaller_type_name (prereq.type_symbol);
					if (type_name != "") {
						return type_name;
					}
				}
				return "POINTER";
			} else if (sym is Struct) {
				unowned Struct st = (Struct) sym;
				unowned Struct? base_st = st.base_struct;
				while (base_st != null) {
					if (get_ccode_has_type_id (base_st)) {
						return get_ccode_marshaller_type_name (base_st);
					} else {
						base_st = base_st.base_struct;
					}
				}
				if (st.is_simple_type ()) {
					Report.error (st.source_reference, "The type `%s' doesn't declare a marshaller type name", st.get_full_name ());
				} else if (get_ccode_has_type_id (st)) {
					return "BOXED";
				} else {
					return "POINTER";
				}
			} else if (sym is Parameter) {
				unowned Parameter param = (Parameter) sym;
				if (param.direction != ParameterDirection.IN) {
					return "POINTER";
				} else {
					return get_ccode_marshaller_type_name (param.variable_type);
				}
			} else {
				return "POINTER";
			}
		} else if (node is ValueType && ((ValueType) node).nullable) {
			return "POINTER";
		} else if (node is PointerType || node is GenericType) {
			return "POINTER";
		} else if (node is ErrorType) {
			return "BOXED";
		} else if (node is ArrayType) {
			unowned ArrayType array_type = (ArrayType) node;
			if (array_type.element_type.type_symbol == CodeContext.get ().analyzer.string_type.type_symbol) {
				return "BOXED,%s".printf (get_ccode_marshaller_type_name (array_type.length_type.type_symbol));
			} else {
				var ret = "POINTER";
				var length_marshaller_type_name = get_ccode_marshaller_type_name (array_type.length_type.type_symbol);
				for (var i = 0; i < array_type.rank; i++) {
					ret = "%s,%s".printf (ret, length_marshaller_type_name);
				}
				return ret;
			}
		} else if (node is DelegateType) {
			unowned DelegateType delegate_type = (DelegateType) node;
			var ret = "POINTER";
			if (delegate_type.delegate_symbol.has_target) {
				ret = "%s,POINTER".printf (ret);
				if (delegate_type.is_disposable ()) {
					ret = "%s,POINTER".printf (ret);
				}
			}
			return ret;
		} else if (node is VoidType) {
			return "VOID";
		} else {
			return get_ccode_marshaller_type_name (((DataType) node).type_symbol);
		}
		return "";
	}

	private string get_default_get_value_function () {
		if (sym is Class) {
			unowned Class cl = (Class) sym;
			if (cl.is_fundamental ()) {
				return get_ccode_lower_case_name (cl, "value_get_");
			} else if (cl.base_class != null) {
				return get_ccode_get_value_function (cl.base_class);
			} else if (type_id == "G_TYPE_POINTER") {
				return "g_value_get_pointer";
			} else {
				return "g_value_get_boxed";
			}
		} else if (sym is Enum) {
			unowned Enum en = (Enum) sym;
			if (get_ccode_has_type_id (en)) {
				if (en.is_flags) {
					return "g_value_get_flags";
				} else {
					return "g_value_get_enum";
				}
			} else {
				if (en.is_flags) {
					return "g_value_get_uint";
				} else {
					return "g_value_get_int";
				}
			}
		} else if (sym is ErrorDomain) {
			return "g_value_get_boxed";
		} else if (sym is Interface) {
			foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
				var type_name = get_ccode_get_value_function (prereq.type_symbol);
				if (type_name != "") {
					return type_name;
				}
			}
			return "g_value_get_pointer";
		} else if (sym is Struct) {
			unowned Struct st = (Struct) sym;
			unowned Struct? base_st = st.base_struct;
			while (base_st != null) {
				if (get_ccode_has_type_id (base_st)) {
					return get_ccode_get_value_function (base_st);
				} else {
					base_st = base_st.base_struct;
				}
			}
			if (st.is_simple_type ()) {
				Report.error (st.source_reference, "The type `%s' doesn't declare a GValue get function", st.get_full_name ());
			} else if (get_ccode_has_type_id (st)) {
				return "g_value_get_boxed";
			} else {
				return "g_value_get_pointer";
			}
		} else {
			return "g_value_get_pointer";
		}
		return "";
	}

	private string get_default_set_value_function () {
		if (sym is Class) {
			unowned Class cl = (Class) sym;
			if (cl.is_fundamental ()) {
				return get_ccode_lower_case_name (cl, "value_set_");
			} else if (cl.base_class != null) {
				return get_ccode_set_value_function (cl.base_class);
			} else if (type_id == "G_TYPE_POINTER") {
				return "g_value_set_pointer";
			} else {
				return "g_value_set_boxed";
			}
		} else if (sym is Enum) {
			unowned Enum en = (Enum) sym;
			if (get_ccode_has_type_id (en)) {
				if (en.is_flags) {
					return "g_value_set_flags";
				} else {
					return "g_value_set_enum";
				}
			} else {
				if (en.is_flags) {
					return "g_value_set_uint";
				} else {
					return "g_value_set_int";
				}
			}
		} else if (sym is ErrorDomain) {
			return "g_value_set_boxed";
		} else if (sym is Interface) {
			foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
				var type_name = get_ccode_set_value_function (prereq.type_symbol);
				if (type_name != "") {
					return type_name;
				}
			}
			return "g_value_set_pointer";
		} else if (sym is Struct) {
			unowned Struct st = (Struct) sym;
			unowned Struct? base_st = st.base_struct;
			while (base_st != null) {
				if (get_ccode_has_type_id (base_st)) {
					return get_ccode_set_value_function (base_st);
				} else {
					base_st = base_st.base_struct;
				}
			}
			if (st.is_simple_type ()) {
				Report.error (st.source_reference, "The type `%s' doesn't declare a GValue set function", st.get_full_name ());
			} else if (get_ccode_has_type_id (st)) {
				return "g_value_set_boxed";
			} else {
				return "g_value_set_pointer";
			}
		} else {
			return "g_value_set_pointer";
		}
		return "";
	}

	private string get_default_take_value_function () {
		if (sym is Class) {
			unowned Class cl = (Class) sym;
			if (cl.is_fundamental ()) {
				return get_ccode_lower_case_name (cl, "value_take_");
			} else if (cl.base_class != null) {
				return get_ccode_take_value_function (cl.base_class);
			} else if (type_id == "G_TYPE_POINTER") {
				return "g_value_set_pointer";
			} else {
				return "g_value_take_boxed";
			}
		} else if (sym is ErrorDomain) {
			return "g_value_take_boxed";
		} else if (sym is Interface) {
			foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
				var func = get_ccode_take_value_function (prereq.type_symbol);
				if (func != "") {
					return func;
				}
			}
			return "g_value_set_pointer";
		} else if (sym is Struct) {
			unowned Struct st = (Struct) sym;
			unowned Struct? base_st = st.base_struct;
			while (base_st != null) {
				if (get_ccode_has_type_id (base_st)) {
					return get_ccode_take_value_function (base_st);
				} else {
					base_st = base_st.base_struct;
				}
			}
			if (st.is_simple_type ()) {
				Report.error (st.source_reference, "The type `%s' doesn't declare a GValue take function", st.get_full_name ());
			} else if (get_ccode_has_type_id (st)) {
				return "g_value_take_boxed";
			} else {
				return "g_value_set_pointer";
			}
		} else {
			return "g_value_set_pointer";
		}
		return "";
	}

	private string get_default_param_spec_function () {
		if (node is Symbol) {
			if (sym is Class) {
				unowned Class cl = (Class) sym;
				if (cl.is_fundamental ()) {
					return get_ccode_lower_case_name (cl, "param_spec_");
				} else if (cl.base_class != null) {
					return get_ccode_param_spec_function (cl.base_class);
				} else if (type_id == "G_TYPE_POINTER") {
					return "g_param_spec_pointer";
				} else {
					return "g_param_spec_boxed";
				}
			} else if (sym is Interface) {
				foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
					var func = get_ccode_param_spec_function (prereq.type_symbol);
					if (func != "") {
						return func;
					}
				}
				return "g_param_spec_pointer";
			} else if (sym is Enum) {
				unowned Enum e = (Enum) sym;
				if (get_ccode_has_type_id (e)) {
					if (e.is_flags) {
						return "g_param_spec_flags";
					} else {
						return "g_param_spec_enum";
					}
				} else {
					if (e.is_flags) {
						return "g_param_spec_uint";
					} else {
						return "g_param_spec_int";
					}
				}
			} else if (sym is ErrorDomain) {
				return "g_param_spec_boxed";
			} else if (sym is Struct) {
				var type_id = get_ccode_type_id (sym);
				if (type_id == "G_TYPE_INT") {
					return "g_param_spec_int";
				} else if (type_id == "G_TYPE_UINT") {
					return "g_param_spec_uint";
				} else if (type_id == "G_TYPE_INT64") {
					return "g_param_spec_int64";
				} else if (type_id == "G_TYPE_UINT64") {
					return "g_param_spec_uint64";
				} else if (type_id == "G_TYPE_LONG") {
					return "g_param_spec_long";
				} else if (type_id == "G_TYPE_ULONG") {
					return "g_param_spec_ulong";
				} else if (type_id == "G_TYPE_BOOLEAN") {
					return "g_param_spec_boolean";
				} else if (type_id == "G_TYPE_CHAR") {
					return "g_param_spec_char";
				} else if (type_id == "G_TYPE_UCHAR") {
					return "g_param_spec_uchar";
				}else if (type_id == "G_TYPE_FLOAT") {
					return "g_param_spec_float";
				} else if (type_id == "G_TYPE_DOUBLE") {
					return "g_param_spec_double";
				} else if (type_id == "G_TYPE_GTYPE") {
					return "g_param_spec_gtype";
				} else {
					return "g_param_spec_boxed";
				}
			}
		} else if (node is ArrayType && ((ArrayType) node).element_type.type_symbol == CodeContext.get ().analyzer.string_type.type_symbol) {
			return "g_param_spec_boxed";
		} else if (node is DataType && ((DataType) node).type_symbol != null) {
			return get_ccode_param_spec_function (((DataType) node).type_symbol);
		}

		return "g_param_spec_pointer";
	}

	private string get_default_default_value () {
		if (sym is Enum) {
			unowned Enum en = (Enum) sym;
			if (en.is_flags) {
				return "0U";
			} else {
				return "0";
			}
		} else if (sym is Struct) {
			unowned Struct st = (Struct) sym;
			unowned Struct? base_st = st.base_struct;
			if (base_st != null) {
				return get_ccode_default_value (base_st);
			}
		}
		return "";
	}

	private string get_default_default_value_on_error () {
		if (sym is Struct) {
			unowned Struct? base_st = ((Struct) sym).base_struct;
			if (base_st != null) {
				return get_ccode_default_value_on_error (base_st);
			}
		}
		return default_value;
	}

	private string get_finish_name_for_basename (string basename) {
		string result = basename;
		if (result.has_suffix ("_async")) {
			result = result.substring (0, result.length - "_async".length);
		}
		return "%s_finish".printf (result);
	}

	private string get_default_real_name () {
		if (sym is CreationMethod) {
			unowned CreationMethod m = (CreationMethod) sym;
			unowned Class? parent = m.parent_symbol as Class;

			if (parent == null || parent.is_compact) {
				return name;
			}

			string infix = "construct";

			if (m.name == ".new") {
				return "%s%s".printf (get_ccode_lower_case_prefix (parent), infix);
			} else {
				return "%s%s_%s".printf (get_ccode_lower_case_prefix (parent), infix, m.name);
			}
		} else if (sym is Method) {
			unowned Method m = (Method) sym;
			if (m.base_method != null || m.base_interface_method != null || m.signal_reference != null) {
				string m_name;
				if (m.signal_reference != null) {
					m_name = get_ccode_lower_case_name (m.signal_reference);
				} else {
					m_name = m.name;
				}
				if (m.base_interface_type != null) {
					return "%sreal_%s%s".printf (get_ccode_lower_case_prefix (m.parent_symbol),
												 get_ccode_lower_case_prefix (m.base_interface_type.type_symbol),
												 m_name);
				} else {
					return "%sreal_%s".printf (get_ccode_lower_case_prefix (m.parent_symbol), m_name);
				}
			} else {
				return name;
			}
		} else if (sym is PropertyAccessor) {
			unowned PropertyAccessor acc = (PropertyAccessor) sym;
			unowned Property prop = (Property) acc.prop;
			if (prop.base_property != null || prop.base_interface_property != null) {
				if (acc.readable) {
					return "%sreal_get_%s".printf (get_ccode_lower_case_prefix (prop.parent_symbol), prop.name);
				} else {
					return "%sreal_set_%s".printf (get_ccode_lower_case_prefix (prop.parent_symbol), prop.name);
				}
			} else {
				return name;
			}
		}
		assert_not_reached ();
	}

	private string get_default_const_name () {
		if (node is DataType) {
			unowned DataType type = (DataType) node;
			string ptr;
			TypeSymbol t;
			// FIXME: workaround to make constant arrays possible
			if (type is ArrayType) {
				t = ((ArrayType) type).element_type.type_symbol;
			} else {
				t = type.type_symbol;
			}
			if (!t.is_reference_type ()) {
				ptr = "";
			} else {
				ptr = "*";
			}

			return "const %s%s".printf (get_ccode_name (t), ptr);
		} else {
			if (node is Class && ((Class) node).is_immutable) {
				return "const %s".printf (name);
			} else {
				return name;
			}
		}
	}

	private bool get_default_delegate_target () {
		if (node is Field || node is Parameter || node is LocalVariable) {
			if (node is Parameter) {
				unowned Parameter param = (Parameter) node;
				if (param.base_parameter != null) {
					return get_ccode_delegate_target (param.base_parameter);
				}
			}
			unowned DelegateType? delegate_type = ((Variable) node).variable_type as DelegateType;
			return delegate_type != null && delegate_type.delegate_symbol.has_target;
		} else if (node is Callable) {
			if (node is Method) {
				unowned Method method = (Method) node;
				if (method.base_method != null && method.base_method != method) {
					return get_ccode_delegate_target (method.base_method);
				} else if (method.base_interface_method != null && method.base_interface_method != method) {
					return get_ccode_delegate_target (method.base_interface_method);
				}
			}
			unowned DelegateType? delegate_type = ((Callable) node).return_type as DelegateType;
			return delegate_type != null && delegate_type.delegate_symbol.has_target;
		} else if (node is Property) {
			unowned Property prop = (Property) node;
			if (prop.base_property != null && prop.base_property != prop) {
				return get_ccode_delegate_target (prop.base_property);
			} else if (prop.base_interface_property != null && prop.base_interface_property != prop) {
				return get_ccode_delegate_target (prop.base_interface_property);
			}
			unowned DelegateType? delegate_type = prop.property_type as DelegateType;
			return delegate_type != null && delegate_type.delegate_symbol.has_target;
		} else if (node is PropertyAccessor) {
			return get_ccode_delegate_target (((PropertyAccessor) node).prop);
		} else if (node is Expression) {
			unowned Symbol? symbol = ((Expression) node).symbol_reference;
			if (symbol != null) {
				return get_ccode_delegate_target (symbol);
			}
		}
		return false;
	}

	private bool get_default_array_length () {
		if (node is Parameter) {
			unowned Parameter param = (Parameter) node;
			if (param.base_parameter != null) {
				return get_ccode_array_length (param.base_parameter);
			}
		} else if (node is Method) {
			unowned Method method = (Method) node;
			if (method.base_method != null && method.base_method != method) {
				return get_ccode_array_length (method.base_method);
			} else if (method.base_interface_method != null && method.base_interface_method != method) {
				return get_ccode_array_length (method.base_interface_method);
			}
		} else if (node is Property) {
			unowned Property prop = (Property) node;
			if (prop.base_property != null && prop.base_property != prop) {
				return get_ccode_array_length (prop.base_property);
			} else if (prop.base_interface_property != null && prop.base_interface_property != prop) {
				return get_ccode_array_length (prop.base_interface_property);
			}
		} else if (node is PropertyAccessor) {
			return get_ccode_array_length (((PropertyAccessor) node).prop);
		}
		return true;
	}

	private bool get_default_array_null_terminated () {
		if (node is Parameter) {
			unowned Parameter param = (Parameter) node;
			if (param.base_parameter != null) {
				return get_ccode_array_null_terminated (param.base_parameter);
			}
		} else if (node is Method) {
			unowned Method method = (Method) node;
			if (method.base_method != null && method.base_method != method) {
				return get_ccode_array_null_terminated (method.base_method);
			} else if (method.base_interface_method != null && method.base_interface_method != method) {
				return get_ccode_array_null_terminated (method.base_interface_method);
			}
		} else if (node is Property) {
			unowned Property prop = (Property) node;
			if (prop.base_property != null && prop.base_property != prop) {
				return get_ccode_array_null_terminated (prop.base_property);
			} else if (prop.base_interface_property != null && prop.base_interface_property != prop) {
				return get_ccode_array_null_terminated (prop.base_interface_property);
			}
		} else if (node is PropertyAccessor) {
			return get_ccode_array_null_terminated (((PropertyAccessor) node).prop);
		}
		return false;
	}

	private string get_default_array_length_type () {
		if (node is Field || node is Parameter) {
			if (node is Parameter) {
				unowned Parameter param = (Parameter) node;
				if (param.base_parameter != null) {
					return get_ccode_array_length_type (param.base_parameter);
				}
			}
			return get_ccode_array_length_type (((Variable) node).variable_type);
		} else if (node is Method || node is Delegate) {
			if (node is Method) {
				unowned Method method = (Method) node;
				if (method.base_method != null && method.base_method != method) {
					return get_ccode_array_length_type (method.base_method);
				} else if (method.base_interface_method != null && method.base_interface_method != method) {
					return get_ccode_array_length_type (method.base_interface_method);
				}
			}
			return get_ccode_array_length_type (((Callable) node).return_type);
		} else if (node is Property) {
			unowned Property prop = (Property) node;
			if (prop.base_property != null && prop.base_property != prop) {
				return get_ccode_array_length_type (prop.base_property);
			} else if (prop.base_interface_property != null && prop.base_interface_property != prop) {
				return get_ccode_array_length_type (prop.base_interface_property);
			} else {
				return get_ccode_array_length_type (prop.property_type);
			}
		} else if (node is PropertyAccessor) {
			return get_ccode_array_length_type (((PropertyAccessor) node).prop);
		} else {
			Report.error (node.source_reference, "`CCode.array_length_type' not supported");
			return "";
		}
	}
}
