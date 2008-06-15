/* valaccodetypesymbolbinding.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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

public abstract class Vala.CCodeTypeSymbolBinding : CCodeBinding {
	public CCodeFunctionCall get_param_spec (Property prop) {
		var cspec = new CCodeFunctionCall ();
		cspec.add_argument (prop.get_canonical_cconstant ());
		cspec.add_argument (new CCodeConstant ("\"%s\"".printf (prop.nick)));
		cspec.add_argument (new CCodeConstant ("\"%s\"".printf (prop.blurb)));
		if ((prop.property_type.data_type is Class && ((Class) prop.property_type.data_type).is_subtype_of (codegen.gobject_type)) || prop.property_type.data_type is Interface) {
			cspec.call = new CCodeIdentifier ("g_param_spec_object");
			cspec.add_argument (new CCodeIdentifier (prop.property_type.data_type.get_type_id ()));
		} else if (prop.property_type.data_type == codegen.string_type.data_type) {
			cspec.call = new CCodeIdentifier ("g_param_spec_string");
			cspec.add_argument (new CCodeConstant ("NULL"));
		} else if (prop.property_type.data_type is Enum) {
			var e = prop.property_type.data_type as Enum;
			if (e.has_type_id) {
				if (e.is_flags) {
					cspec.call = new CCodeIdentifier ("g_param_spec_flags");
				} else {
					cspec.call = new CCodeIdentifier ("g_param_spec_enum");
				}
				cspec.add_argument (new CCodeIdentifier (e.get_type_id ()));
			} else {
				if (e.is_flags) {
					cspec.call = new CCodeIdentifier ("g_param_spec_uint");
					cspec.add_argument (new CCodeConstant ("0"));
					cspec.add_argument (new CCodeConstant ("G_MAXUINT"));
				} else {
					cspec.call = new CCodeIdentifier ("g_param_spec_int");
					cspec.add_argument (new CCodeConstant ("G_MININT"));
					cspec.add_argument (new CCodeConstant ("G_MAXINT"));
				}
			}

			if (prop.default_expression != null) {
				cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
			} else {
				cspec.add_argument (new CCodeConstant (prop.property_type.data_type.get_default_value ()));
			}
		} else if (prop.property_type.data_type is Struct) {
			var st = (Struct) prop.property_type.data_type;
			if (st.get_type_id () == "G_TYPE_INT") {
				cspec.call = new CCodeIdentifier ("g_param_spec_int");
				cspec.add_argument (new CCodeConstant ("G_MININT"));
				cspec.add_argument (new CCodeConstant ("G_MAXINT"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0"));
				}
			} else if (st.get_type_id () == "G_TYPE_UINT") {
				cspec.call = new CCodeIdentifier ("g_param_spec_uint");
				cspec.add_argument (new CCodeConstant ("0"));
				cspec.add_argument (new CCodeConstant ("G_MAXUINT"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0U"));
				}
			} else if (st.get_type_id () == "G_TYPE_LONG") {
				cspec.call = new CCodeIdentifier ("g_param_spec_long");
				cspec.add_argument (new CCodeConstant ("G_MINLONG"));
				cspec.add_argument (new CCodeConstant ("G_MAXLONG"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0L"));
				}
			} else if (st.get_type_id () == "G_TYPE_ULONG") {
				cspec.call = new CCodeIdentifier ("g_param_spec_ulong");
				cspec.add_argument (new CCodeConstant ("0"));
				cspec.add_argument (new CCodeConstant ("G_MAXULONG"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0UL"));
				}
			} else if (st.get_type_id () == "G_TYPE_BOOLEAN") {
				cspec.call = new CCodeIdentifier ("g_param_spec_boolean");
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("FALSE"));
				}
			} else if (st.get_type_id () == "G_TYPE_CHAR") {
				cspec.call = new CCodeIdentifier ("g_param_spec_char");
				cspec.add_argument (new CCodeConstant ("G_MININT8"));
				cspec.add_argument (new CCodeConstant ("G_MAXINT8"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0"));
				}
			} else if (st.get_type_id () == "G_TYPE_FLOAT") {
				cspec.call = new CCodeIdentifier ("g_param_spec_float");
				cspec.add_argument (new CCodeConstant ("-G_MAXFLOAT"));
				cspec.add_argument (new CCodeConstant ("G_MAXFLOAT"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0.0F"));
				}
			} else if (st.get_type_id () == "G_TYPE_DOUBLE") {
				cspec.call = new CCodeIdentifier ("g_param_spec_double");
				cspec.add_argument (new CCodeConstant ("-G_MAXDOUBLE"));
				cspec.add_argument (new CCodeConstant ("G_MAXDOUBLE"));
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("0.0"));
				}
			} else if (st.get_type_id () == "G_TYPE_GTYPE") {
				cspec.call = new CCodeIdentifier ("g_param_spec_gtype");
				if (prop.default_expression != null) {
					cspec.add_argument ((CCodeExpression) prop.default_expression.ccodenode);
				} else {
					cspec.add_argument (new CCodeConstant ("G_TYPE_NONE"));
				}
			} else {
				cspec.call = new CCodeIdentifier ("g_param_spec_pointer");
			}
		} else {
			cspec.call = new CCodeIdentifier ("g_param_spec_pointer");
		}
		
		var pflags = "G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB";
		if (prop.get_accessor != null) {
			pflags = "%s%s".printf (pflags, " | G_PARAM_READABLE");
		}
		if (prop.set_accessor != null) {
			pflags = "%s%s".printf (pflags, " | G_PARAM_WRITABLE");
			if (prop.set_accessor.construction) {
				if (prop.set_accessor.writable) {
					pflags = "%s%s".printf (pflags, " | G_PARAM_CONSTRUCT");
				} else {
					pflags = "%s%s".printf (pflags, " | G_PARAM_CONSTRUCT_ONLY");
				}
			}
		}
		cspec.add_argument (new CCodeConstant (pflags));

		return cspec;
	}

	public CCodeFunctionCall get_signal_creation (Signal sig, TypeSymbol type) {	
		var csignew = new CCodeFunctionCall (new CCodeIdentifier ("g_signal_new"));
		csignew.add_argument (new CCodeConstant ("\"%s\"".printf (sig.name)));
		csignew.add_argument (new CCodeIdentifier (type.get_type_id ()));
		csignew.add_argument (new CCodeConstant ("G_SIGNAL_RUN_LAST"));
		csignew.add_argument (new CCodeConstant ("0"));
		csignew.add_argument (new CCodeConstant ("NULL"));
		csignew.add_argument (new CCodeConstant ("NULL"));

		string marshaller = codegen.get_marshaller_function (sig.get_parameters (), sig.return_type);

		var marshal_arg = new CCodeIdentifier (marshaller);
		csignew.add_argument (marshal_arg);

		var params = sig.get_parameters ();
		if (sig.return_type is PointerType || sig.return_type.type_parameter != null) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
		} else if (sig.return_type is ErrorType) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
		} else if (sig.return_type.data_type == null) {
			csignew.add_argument (new CCodeConstant ("G_TYPE_NONE"));
		} else {
			csignew.add_argument (new CCodeConstant (sig.return_type.data_type.get_type_id ()));
		}

		int params_len = 0;
		foreach (FormalParameter param in params) {
			params_len++;
			if (param.parameter_type.is_array ()) {
				params_len++;
			}
		}

		csignew.add_argument (new CCodeConstant ("%d".printf (params_len)));
		foreach (FormalParameter param in params) {
			if (param.parameter_type.is_array ()) {
				if (((ArrayType) param.parameter_type).element_type.data_type == codegen.string_type.data_type) {
					csignew.add_argument (new CCodeConstant ("G_TYPE_STRV"));
				} else {
					csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
				}
				csignew.add_argument (new CCodeConstant ("G_TYPE_INT"));
			} else if (param.parameter_type is PointerType || param.parameter_type.type_parameter != null || param.direction != ParameterDirection.IN) {
				csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
			} else if (param.parameter_type is ErrorType) {
				csignew.add_argument (new CCodeConstant ("G_TYPE_POINTER"));
			} else {
				csignew.add_argument (new CCodeConstant (param.parameter_type.data_type.get_type_id ()));
			}
		}

		marshal_arg.name = marshaller;

		return csignew;
	}
}
