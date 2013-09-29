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
	private weak CodeNode node;
	private weak Symbol sym;
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
					_type_name = "%sIface".printf (CCodeBaseModule.get_ccode_name (sym));
				}
			}
			return _type_name;
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
						_ref_function_void = CCodeBaseModule.get_ccode_ref_function_void (cl.base_class);
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
					_copy_function = lower_case_prefix + "copy";
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
					_destroy_function = lower_case_prefix + "destroy";
				}
				destroy_function_set = true;
			}
			return _destroy_function;
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
					var cl = (Class) sym;
					if (cl.base_class != null) {
						_free_function_address_of = CCodeBaseModule.get_ccode_free_function_address_of (cl.base_class);
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

	public double pos {
		get {
			if (_pos == null) {
				if (ccode != null && ccode.has_argument ("pos")) {
					_pos = ccode.get_double ("pos");
				} else {
					var param = (Parameter) node;
					var sym = param.parent_symbol;
					if (sym is Method) {
						_pos = ((Method) sym).get_parameters().index_of (param) + 1.0;
					} else if (sym is Delegate) {
						_pos = ((Delegate) sym).get_parameters().index_of (param) + 1.0;
					} else if (sym is Signal) {
						_pos = ((Signal) sym).get_parameters().index_of (param) + 1.0;
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
					_vfunc_name = sym.name;
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
				_finish_vfunc_name = get_finish_name_for_basename (vfunc_name);
			}
			return _finish_vfunc_name;
		}
	}

	public string finish_real_name {
		get {
			if (_finish_real_name == null) {
				_finish_real_name = get_finish_name_for_basename (real_name);
			}
			return _finish_real_name;
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

	public bool array_length {
		get {
			if (_array_length == null) {
				if (node.get_attribute ("NoArrayLength") != null) {
					// deprecated
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
				if (ccode != null && ccode.has_argument ("array_null_terminated")) {
					_array_null_terminated = ccode.get_bool ("array_null_terminated");
				} else {
					_array_null_terminated = get_default_array_null_terminated ();
				}
			}
			return _array_null_terminated;
		}
	}

	public string? array_length_type { get; private set; }
	public string? array_length_name { get; private set; }
	public string? array_length_expr { get; private set; }
	public bool delegate_target { get; private set; }
	public string sentinel { get; private set; }

	private string _name;
	private string _const_name;
	private string _type_name;
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
	private double? _pos;
	private string _vfunc_name;
	private string _finish_name;
	private string _finish_vfunc_name;
	private string _finish_real_name;
	private string _real_name;
	private string _delegate_target_name;
	private string _ctype;
	private bool ctype_set = false;
	private bool? _array_length;
	private bool? _array_null_terminated;

	private static int dynamic_method_id;

	public CCodeAttribute (CodeNode node) {
		this.node = node;
		this.sym = node as Symbol;

		delegate_target = true;
		ccode = node.get_attribute ("CCode");
		if (ccode != null) {
			array_length_type = ccode.get_string ("array_length_type");
			array_length_name = ccode.get_string ("array_length_cname");
			array_length_expr = ccode.get_string ("array_length_cexpr");
			if (ccode.has_argument ("pos")) {
				_pos = ccode.get_double ("pos");
			}
			delegate_target = ccode.get_bool ("delegate_target", true);
			sentinel = ccode.get_string ("sentinel");
		}
		if (sentinel == null) {
			sentinel = "NULL";
		}
	}

	private string get_default_name () {
		var sym = node as Symbol;
		if (sym != null) {
			if (sym is Constant && !(sym is EnumValue)) {
				if (sym.parent_symbol is Block) {
					// local constant
					return sym.name;
				}
				return "%s%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (sym.parent_symbol).up (), sym.name);
			} else if (sym is Field) {
				if (((Field) sym).binding == MemberBinding.STATIC) {
					return "%s%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (sym.parent_symbol), sym.name);
				} else {
					return sym.name;
				}
			} else if (sym is CreationMethod) {
				var m = (CreationMethod) sym;
				string infix;
				if (m.parent_symbol is Struct) {
					infix = "init";
				} else {
					infix = "new";
				}
				if (m.name == ".new") {
					return "%s%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (m.parent_symbol), infix);
				} else {
					return "%s%s_%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (m.parent_symbol), infix, m.name);
				}
			} else if (sym is DynamicMethod) {
				return "_dynamic_%s%d".printf (sym.name, dynamic_method_id++);
			} else if (sym is Method) {
				var m = (Method) sym;
				if (m.is_async_callback) {
					return "%s_co".printf (CCodeBaseModule.get_ccode_real_name ((Method) m.parent_symbol));
				}
				if (sym.name == "main" && sym.parent_symbol.name == null) {
					// avoid conflict with generated main function
					return "_vala_main";
				} else if (sym.name.has_prefix ("_")) {
					return "_%s%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (sym.parent_symbol), sym.name.substring (1));
				} else {
					return "%s%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (sym.parent_symbol), sym.name);
				}
			} else if (sym is PropertyAccessor) {
				var acc = (PropertyAccessor) sym;
				var t = (TypeSymbol) acc.prop.parent_symbol;

				if (acc.readable) {
					return "%sget_%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (t), acc.prop.name);
				} else {
					return "%sset_%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (t), acc.prop.name);
				}
			} else if (sym is Signal) {
				return Symbol.camel_case_to_lower_case (sym.name);
			} else if (sym is LocalVariable || sym is Parameter) {
				return sym.name;
			} else {
				return "%s%s".printf (CCodeBaseModule.get_ccode_prefix (sym.parent_symbol), sym.name);
			}
		} else if (node is ObjectType) {
			var type = (ObjectType) node;

			string cname;
			if (!type.value_owned) {
				cname = CCodeBaseModule.get_ccode_const_name (type.type_symbol);
			} else {
				cname = CCodeBaseModule.get_ccode_name (type.type_symbol);
			}
			return "%s*".printf (cname);
		} else if (node is ArrayType) {
			var type = (ArrayType) node;
			var cname = CCodeBaseModule.get_ccode_name (type.element_type);
			if (type.inline_allocated) {
				return cname;
			} else {
				return "%s*".printf (cname);
			}
		} else if (node is DelegateType) {
			var type = (DelegateType) node;
			return CCodeBaseModule.get_ccode_name (type.delegate_symbol);
		} else if (node is ErrorType) {
			return "GError*";
		} else if (node is GenericType) {
			var type = (GenericType) node;
			if (type.value_owned) {
				return "gpointer";
			} else {
				return "gconstpointer";
			}
		} else if (node is MethodType) {
			return "gpointer";
		} else if (node is NullType) {
			return "gpointer";
		} else if (node is PointerType) {
			var type = (PointerType) node;
			if (type.base_type.data_type != null && type.base_type.data_type.is_reference_type ()) {
				return CCodeBaseModule.get_ccode_name (type.base_type);
			} else {
				return "%s*".printf (CCodeBaseModule.get_ccode_name (type.base_type));
			}
		} else if (node is VoidType) {
			return "void";
		} else if (node is ClassType) {
			var type = (ClassType) node;
			return "%sClass*".printf (CCodeBaseModule.get_ccode_name (type.class_symbol));
		} else if (node is InterfaceType) {
			var type = (InterfaceType) node;
			return "%s*".printf (CCodeBaseModule.get_ccode_type_name (type.interface_symbol));
		} else if (node is ValueType) {
			var type = (ValueType) node;
			var cname = CCodeBaseModule.get_ccode_name (type.type_symbol);
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
		if (sym.parent_symbol != null) {
			var parent_headers = CCodeBaseModule.get_ccode_header_filenames (sym.parent_symbol);
			if (parent_headers.length > 0) {
				return parent_headers;
			}
		}
		if (sym.source_reference != null && !sym.external_package) {
			// don't add default include directives for VAPI files
			return sym.source_reference.file.get_cinclude_filename ();
		}
		return "";
	}

	private string get_default_prefix () {
		if (sym is ObjectTypeSymbol) {
			return name;
		} else if (sym is Enum || sym is ErrorDomain) {
			return "%s_".printf (CCodeBaseModule.get_ccode_upper_case_name (sym));
		} else if (sym is Namespace) {
			if (sym.name != null) {
				var parent_prefix = "";
				if (sym.parent_symbol != null) {
					parent_prefix = CCodeBaseModule.get_ccode_prefix (sym.parent_symbol);
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
				return "%s%s_".printf (CCodeBaseModule.get_ccode_lower_case_prefix (sym.parent_symbol), Symbol.camel_case_to_lower_case (sym.name));
			}
		} else if (sym is Method) {
			// for lambda expressions
			return "";
		} else {
			return "%s_".printf (CCodeBaseModule.get_ccode_lower_case_name (sym));
		}
	}

	private string get_default_lower_case_suffix () {
		if (sym is ObjectTypeSymbol) {
			var csuffix = Symbol.camel_case_to_lower_case (sym.name);

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
		} else if (sym.name != null) {
			return Symbol.camel_case_to_lower_case (sym.name);
		}
		return "";
	}

	private string? get_default_ref_function () {
		if (sym is Class) {
			var cl = (Class) sym;
			if (cl.is_fundamental ()) {
				return lower_case_prefix + "ref";
			} else if (cl.base_class != null) {
				return CCodeBaseModule.get_ccode_ref_function (cl.base_class);
			}
		} else if (sym is Interface) {
			foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
				var ref_func = CCodeBaseModule.get_ccode_ref_function ((ObjectTypeSymbol) prereq.data_type);
				if (ref_func != null) {
					return ref_func;
				}
			}
		}
		return null;
	}

	private string? get_default_unref_function () {
		if (sym is Class) {
			var cl = (Class) sym;
			if (cl.is_fundamental ()) {
				return lower_case_prefix + "unref";
			} else if (cl.base_class != null) {
				return CCodeBaseModule.get_ccode_unref_function (cl.base_class);
			}
		} else if (sym is Interface) {
			foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
				string unref_func = CCodeBaseModule.get_ccode_unref_function ((ObjectTypeSymbol) prereq.data_type);
				if (unref_func != null) {
					return unref_func;
				}
			}
		}
		return null;
	}

	private string get_default_ref_sink_function () {
		if (sym is Class) {
			return CCodeBaseModule.get_ccode_ref_sink_function (((Class) sym).base_class);
		} else if (sym is Interface) {
			foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
				string ref_sink_func = CCodeBaseModule.get_ccode_ref_sink_function ((ObjectTypeSymbol) prereq.data_type);
				if (ref_sink_func != "") {
					return ref_sink_func;
				}
			}
		}
		return "";
	}

	private string? get_default_free_function () {
		if (sym is Class) {
			var cl = (Class) sym;
			if (cl.base_class != null) {
				return CCodeBaseModule.get_ccode_free_function (cl.base_class);
			}
			return lower_case_prefix + "free";
		} else if (sym is Struct) {
			if (!sym.external_package) {
				return lower_case_prefix + "free";
			}
		}
		return null;
	}

	private string get_default_type_id () {
		if (sym != null) {
			if (sym is Class && !((Class) sym).is_compact || sym is Interface) {
				return CCodeBaseModule.get_ccode_upper_case_name (sym, "TYPE_");
			} else if (sym is ErrorType && sym.source_reference != null && sym.source_reference.file.context.require_glib_version (2, 26)) {
				return "G_TYPE_ERROR";
			} else if (sym is Struct) {
				var st = (Struct) sym;
				if (!CCodeBaseModule.get_ccode_has_type_id (st)) {
					var base_struct = st.base_struct;
					if (base_struct != null) {
						return CCodeBaseModule.get_ccode_type_id (base_struct);
					}
					if (!st.is_simple_type ()) {
						return "G_TYPE_POINTER";
					}
				} else {
					return CCodeBaseModule.get_ccode_upper_case_name (st, "TYPE_");
				}
			} else if (sym is Enum) {
				var en = (Enum) sym;
				if (CCodeBaseModule.get_ccode_has_type_id (en)) {
					return CCodeBaseModule.get_ccode_upper_case_name (en, "TYPE_");
				} else {
					return en.is_flags ? "G_TYPE_UINT" : "G_TYPE_INT";
				}
			} else {
				return "G_TYPE_POINTER";
			}
		} else if (node is ArrayType && ((ArrayType) node).element_type.data_type.get_full_name () == "string") {
			return "G_TYPE_STRV";
		} else if (node is PointerType || node is DelegateType) {
			return "G_TYPE_POINTER";
		} else if (node is ErrorType) {
			if (node.source_reference != null && node.source_reference.file.context.require_glib_version (2, 26)) {
				return "G_TYPE_ERROR";
			} else {
				return "G_TYPE_POINTER";
			}
		} else if (node is VoidType) {
			return "G_TYPE_NONE";
		} else {
			var type = (DataType) node;
			if (type.data_type != null) {
				return CCodeBaseModule.get_ccode_type_id (type.data_type);
			}
		}
		return "";
	}

	private string get_default_marshaller_type_name () {
		if (sym != null) {
			if (sym is Class) {
				var cl = (Class) sym;
				if (cl.base_class != null) {
					return CCodeBaseModule.get_ccode_marshaller_type_name (cl.base_class);
				} else if (!cl.is_compact) {
					return CCodeBaseModule.get_ccode_upper_case_name (cl);
				} else if (type_id == "G_TYPE_POINTER") {
					return "POINTER";
				} else {
					return "BOXED";
				}
			} else if (sym is Enum) {
				var en = (Enum) sym;
				if (CCodeBaseModule.get_ccode_has_type_id (en)) {
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
					var type_name = CCodeBaseModule.get_ccode_marshaller_type_name (prereq.data_type);
					if (type_name != "") {
						return type_name;
					}
				}
				return "POINTER";
			} else if (sym is Struct) {
				var st = (Struct) sym;
				var base_st = st.base_struct;
				while (base_st != null) {
					if (CCodeBaseModule.get_ccode_has_type_id (base_st)) {
						return CCodeBaseModule.get_ccode_marshaller_type_name (base_st);
					} else {
						base_st = base_st.base_struct;
					}
				}
				if (st.is_simple_type ()) {
					Report.error (st.source_reference, "The type `%s` doesn't declare a marshaller type name".printf (st.get_full_name ()));
				} else if (CCodeBaseModule.get_ccode_has_type_id (st)) {
					return "BOXED";
				} else {
					return "POINTER";
				}
			} else if (sym is Parameter) {
				var param = (Parameter) sym;
				if (param.direction != ParameterDirection.IN) {
					return "POINTER";
				} else {
					return CCodeBaseModule.get_ccode_marshaller_type_name (param.variable_type);
				}
			} else {
				return "POINTER";
			}
		} else if (node is PointerType || ((DataType) node).type_parameter != null) {
			return "POINTER";
		} else if (node is ErrorType) {
			return "POINTER";
		} else if (node is ArrayType) {
			if (((ArrayType) node).element_type.data_type.get_full_name () == "string") {
				return "BOXED,INT";
			} else {
				return "POINTER,INT";
			}
		} else if (node is VoidType) {
			return "VOID";
		} else {
			return CCodeBaseModule.get_ccode_marshaller_type_name (((DataType) node).data_type);
		}
		return "";
	}

	private string get_default_get_value_function () {
		if (sym is Class) {
			var cl = (Class) sym;
			if (cl.is_fundamental ()) {
				return CCodeBaseModule.get_ccode_lower_case_name (cl, "value_get_");
			} else if (cl.base_class != null) {
				return CCodeBaseModule.get_ccode_get_value_function (cl.base_class);
			} else if (type_id == "G_TYPE_POINTER") {
				return "g_value_get_pointer";
			} else {
				return "g_value_get_boxed";
			}
		} else if (sym is Enum) {
			var en = (Enum) sym;
			if (CCodeBaseModule.get_ccode_has_type_id (en)) {
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
		} else if (sym is Interface) {
			foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
				var type_name = CCodeBaseModule.get_ccode_get_value_function (prereq.data_type);
				if (type_name != "") {
					return type_name;
				}
			}
			return "g_value_get_pointer";
		} else if (sym is Struct) {
			var st = (Struct) sym;
			var base_st = st.base_struct;
			while (base_st != null) {
				if (CCodeBaseModule.get_ccode_has_type_id (base_st)) {
					return CCodeBaseModule.get_ccode_get_value_function (base_st);
				} else {
					base_st = base_st.base_struct;
				}
			}
			if (st.is_simple_type ()) {
				Report.error (st.source_reference, "The type `%s` doesn't declare a GValue get function".printf (st.get_full_name ()));
			} else if (CCodeBaseModule.get_ccode_has_type_id (st)) {
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
			var cl = (Class) sym;
			if (cl.is_fundamental ()) {
				return CCodeBaseModule.get_ccode_lower_case_name (cl, "value_set_");
			} else if (cl.base_class != null) {
				return CCodeBaseModule.get_ccode_set_value_function (cl.base_class);
			} else if (type_id == "G_TYPE_POINTER") {
				return "g_value_set_pointer";
			} else {
				return "g_value_set_boxed";
			}
		} else if (sym is Enum) {
			var en = (Enum) sym;
			if (CCodeBaseModule.get_ccode_has_type_id (en)) {
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
		} else if (sym is Interface) {
			foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
				var type_name = CCodeBaseModule.get_ccode_set_value_function (prereq.data_type);
				if (type_name != "") {
					return type_name;
				}
			}
			return "g_value_set_pointer";
		} else if (sym is Struct) {
			var st = (Struct) sym;
			var base_st = st.base_struct;
			while (base_st != null) {
				if (CCodeBaseModule.get_ccode_has_type_id (base_st)) {
					return CCodeBaseModule.get_ccode_set_value_function (base_st);
				} else {
					base_st = base_st.base_struct;
				}
			}
			if (st.is_simple_type ()) {
				Report.error (st.source_reference, "The type `%s` doesn't declare a GValue set function".printf (st.get_full_name ()));
			} else if (CCodeBaseModule.get_ccode_has_type_id (st)) {
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
			var cl = (Class) sym;
			if (cl.is_fundamental ()) {
				return CCodeBaseModule.get_ccode_lower_case_name (cl, "value_take_");
			} else if (cl.base_class != null) {
				return CCodeBaseModule.get_ccode_take_value_function (cl.base_class);
			} else if (type_id == "G_TYPE_POINTER") {
				return "g_value_set_pointer";
			} else {
				return "g_value_take_boxed";
			}
		} else if (sym is Enum) {
			var en = (Enum) sym;
			if (CCodeBaseModule.get_ccode_has_type_id (en)) {
				if (en.is_flags) {
					return "g_value_take_flags";
				} else {
					return "g_value_take_enum";
				}
			} else {
				if (en.is_flags) {
					return "g_value_take_uint";
				} else {
					return "g_value_take_int";
				}
			}
		} else if (sym is Interface) {
			foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
				var func = CCodeBaseModule.get_ccode_take_value_function (prereq.data_type);
				if (func != "") {
					return func;
				}
			}
			return "g_value_set_pointer";
		} else if (sym is Struct) {
			var st = (Struct) sym;
			var base_st = st.base_struct;
			while (base_st != null) {
				if (CCodeBaseModule.get_ccode_has_type_id (base_st)) {
					return CCodeBaseModule.get_ccode_take_value_function (base_st);
				} else {
					base_st = base_st.base_struct;
				}
			}
			if (st.is_simple_type ()) {
				Report.error (st.source_reference, "The type `%s` doesn't declare a GValue take function".printf (st.get_full_name ()));
			} else if (CCodeBaseModule.get_ccode_has_type_id (st)) {
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
				var cl = (Class) sym;
				if (cl.is_fundamental ()) {
					return CCodeBaseModule.get_ccode_lower_case_name (cl, "param_spec_");
				} else if (cl.base_class != null) {
					return CCodeBaseModule.get_ccode_param_spec_function (cl.base_class);
				} else if (type_id == "G_TYPE_POINTER") {
					return "g_param_spec_pointer";
				} else {
					return "g_param_spec_boxed";
				}
			} else if (sym is Interface) {
				foreach (var prereq in ((Interface) sym).get_prerequisites ()) {
					var func = CCodeBaseModule.get_ccode_param_spec_function (prereq.data_type);
					if (func != "") {
						return func;
					}
				}
				return "g_param_spec_pointer";
			} else if (sym is Enum) {
				var e = sym as Enum;
				if (CCodeBaseModule.get_ccode_has_type_id (e)) {
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
			} else if (sym is Struct) {
				var type_id = CCodeBaseModule.get_ccode_type_id (sym);
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
		} else if (node is ArrayType && ((ArrayType)node).element_type.data_type == CodeContext.get().analyzer.string_type.data_type) {
			return "g_param_spec_boxed";
		} else if (node is DataType && ((DataType) node).data_type != null) {
			return CCodeBaseModule.get_ccode_param_spec_function (((DataType) node).data_type);
		}

		return "g_param_spec_pointer";
	}

	private string get_default_default_value () {
		if (sym is Enum) {
			return "0";
		} else if (sym is Struct) {
			var st = (Struct) sym;
			var base_st = st.base_struct;

			if (base_st != null) {
				return CCodeBaseModule.get_ccode_default_value (base_st);
			}
		}
		return "";
	}

	private string get_finish_name_for_basename (string basename) {
		string result = basename;
		if (result.has_suffix ("_async")) {
			result = result.substring (0, result.length - "_async".length);
		}
		return result + "_finish";
	}

	private string get_default_real_name () {
		if (sym is CreationMethod) {
			var m = (CreationMethod) sym;
			var parent = m.parent_symbol as Class;

			if (parent == null || parent.is_compact) {
				return name;
			}

			string infix = "construct";

			if (m.name == ".new") {
				return "%s%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (parent), infix);
			} else {
				return "%s%s_%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (parent), infix, m.name);
			}
		} else if (sym is Method) {
			var m = (Method) sym;
			if (m.base_method != null || m.base_interface_method != null) {
				return "%sreal_%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (m.parent_symbol), m.name);
			} else {
				return name;
			}
		} else if (sym is PropertyAccessor) {
			var acc = (PropertyAccessor) sym;
			var prop = (Property) acc.prop;
			if (prop.base_property != null || prop.base_interface_property != null) {
				if (acc.readable) {
					return "%sreal_get_%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (prop.parent_symbol), prop.name);
				} else {
					return "%sreal_set_%s".printf (CCodeBaseModule.get_ccode_lower_case_prefix (prop.parent_symbol), prop.name);
				}
			} else {
				return name;
			}
		}
		assert_not_reached ();
	}

	private string get_default_const_name () {
		if (node is DataType) {
			var type = (DataType) node;
			string ptr;
			TypeSymbol t;
			// FIXME: workaround to make constant arrays possible
			if (type is ArrayType) {
				t = ((ArrayType) type).element_type.data_type;
			} else {
				t = type.data_type;
			}
			if (!t.is_reference_type ()) {
				ptr = "";
			} else {
				ptr = "*";
			}

			return "const %s%s".printf (CCodeBaseModule.get_ccode_name (t), ptr);
		} else {
			if (node is Class && ((Class) node).is_immutable) {
				return "const %s".printf (name);
			} else {
				return name;
			}
		}
	}

	private bool get_default_array_length () {
		if (node is Parameter) {
			var param = (Parameter) node;
			if (param.base_parameter != null) {
				return CCodeBaseModule.get_ccode_array_length (param.base_parameter);
			}
		}
		return true;
	}

	private bool get_default_array_null_terminated () {
		if (node is Parameter) {
			var param = (Parameter) node;
			if (param.base_parameter != null) {
				return CCodeBaseModule.get_ccode_array_null_terminated (param.base_parameter);
			}
		}
		return false;
	}
}
