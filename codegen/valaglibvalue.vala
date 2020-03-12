/* valaglibvalue.vala
 *
 * Copyright (C) 2010  Jürg Billeter
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
 * 	Jürg Billeter <j@bitron.ch>
 * 	Luca Bruno <lucabru@src.gnome.org>
 */

public class Vala.GLibValue : TargetValue {
	public CCodeExpression cvalue;
	public bool lvalue;
	public bool non_null;
	public string? ctype;

	public List<CCodeExpression> array_length_cvalues;
	public CCodeExpression? array_size_cvalue;
	public bool array_null_terminated;
	public CCodeExpression? array_length_cexpr;

	public CCodeExpression? delegate_target_cvalue;
	public CCodeExpression? delegate_target_destroy_notify_cvalue;

	public GLibValue (DataType? value_type = null, CCodeExpression? cvalue = null, bool lvalue = false) {
		base (value_type);
		this.cvalue = cvalue;
		this.lvalue = lvalue;
	}

	public void append_array_length_cvalue (CCodeExpression length_cvalue) {
		if (array_length_cvalues == null) {
			array_length_cvalues = new ArrayList<CCodeExpression> ();
		}
		array_length_cvalues.add (length_cvalue);
	}

	public GLibValue copy () {
		var result = new GLibValue (value_type.copy (), cvalue, lvalue);
		result.actual_value_type = actual_value_type;
		result.non_null = non_null;
		result.ctype = ctype;

		if (array_length_cvalues != null) {
			foreach (var cexpr in array_length_cvalues) {
				result.append_array_length_cvalue (cexpr);
			}
		}
		result.array_size_cvalue = array_size_cvalue;
		result.array_null_terminated = array_null_terminated;
		result.array_length_cexpr = array_length_cexpr;

		result.delegate_target_cvalue = delegate_target_cvalue;
		result.delegate_target_destroy_notify_cvalue = delegate_target_destroy_notify_cvalue;

		return result;
	}
}

namespace Vala {
	public static unowned CCodeExpression? get_cvalue (Expression expr) {
		if (expr.target_value == null) {
			return null;
		}
		return ((GLibValue) expr.target_value).cvalue;
	}

	public static unowned CCodeExpression? get_cvalue_ (TargetValue value) {
		return ((GLibValue) value).cvalue;
	}

	public static void set_cvalue (Expression expr, CCodeExpression? cvalue) {
		unowned GLibValue glib_value = (GLibValue) expr.target_value;
		if (glib_value == null) {
			expr.target_value = new GLibValue (expr.value_type);
			glib_value = (GLibValue) expr.target_value;
		}
		glib_value.cvalue = cvalue;
	}

	public static unowned CCodeExpression? get_array_size_cvalue (TargetValue value) {
		return ((GLibValue) value).array_size_cvalue;
	}

	public static void set_array_size_cvalue (TargetValue value, CCodeExpression? cvalue) {
		((GLibValue) value).array_size_cvalue = cvalue;
	}

	public static unowned CCodeExpression? get_delegate_target (Expression expr) {
		if (expr.target_value == null) {
			return null;
		}
		return ((GLibValue) expr.target_value).delegate_target_cvalue;
	}

	public static void set_delegate_target (Expression expr, CCodeExpression? delegate_target) {
		unowned GLibValue? glib_value = (GLibValue) expr.target_value;
		if (glib_value == null) {
			expr.target_value = new GLibValue (expr.value_type);
			glib_value = (GLibValue) expr.target_value;
		}
		glib_value.delegate_target_cvalue = delegate_target;
	}

	public static unowned CCodeExpression? get_delegate_target_destroy_notify (Expression expr) {
		unowned GLibValue? glib_value = (GLibValue) expr.target_value;
		if (glib_value == null) {
			return null;
		}
		return glib_value.delegate_target_destroy_notify_cvalue;
	}

	public static void set_delegate_target_destroy_notify (Expression expr, CCodeExpression? destroy_notify) {
		unowned GLibValue? glib_value = (GLibValue) expr.target_value;
		if (glib_value == null) {
			expr.target_value = new GLibValue (expr.value_type);
			glib_value = (GLibValue) expr.target_value;
		}
		glib_value.delegate_target_destroy_notify_cvalue = destroy_notify;
	}

	public static void append_array_length (Expression expr, CCodeExpression size) {
		unowned GLibValue? glib_value = (GLibValue) expr.target_value;
		if (glib_value == null) {
			expr.target_value = new GLibValue (expr.value_type);
			glib_value = (GLibValue) expr.target_value;
		}
		glib_value.append_array_length_cvalue (size);
	}

	public static unowned List<CCodeExpression>? get_array_lengths (Expression expr) {
		unowned GLibValue? glib_value = (GLibValue) expr.target_value;
		if (glib_value == null) {
			return null;
		}
		return glib_value.array_length_cvalues;
	}

	public static bool get_lvalue (TargetValue value) {
		return ((GLibValue) value).lvalue;
	}

	public static bool get_non_null (TargetValue value) {
		return ((GLibValue) value).non_null;
	}

	public static unowned string? get_ctype (TargetValue value) {
		return ((GLibValue) value).ctype;
	}

	public static bool get_array_null_terminated (TargetValue value) {
		return ((GLibValue) value).array_null_terminated;
	}

	public static unowned CCodeExpression? get_array_length_cexpr (TargetValue value) {
		return ((GLibValue) value).array_length_cexpr;
	}
}
