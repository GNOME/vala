/* valagenerictype.vala
 *
 * Copyright (C) 2008-2009  Jürg Billeter
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
 */

using GLib;

/**
 * The type of a generic type parameter.
 */
public class Vala.GenericType : DataType {
	/**
	 * The referred generic type parameter.
	 */
	public weak TypeParameter type_parameter { get; set; }

	GenericDupField? dup_field;
	GenericDestroyField? destroy_field;

	public GenericType (TypeParameter type_parameter) {
		this.type_parameter = type_parameter;
		// type parameters are always considered nullable
		this.nullable = true;
	}

	public override DataType copy () {
		var result = new GenericType (type_parameter);
		result.source_reference = source_reference;
		result.value_owned = value_owned;
		result.nullable = nullable;
		result.floating_reference = floating_reference;

		return result;
	}

	public override DataType get_actual_type (DataType? derived_instance_type, List<DataType>? method_type_arguments, CodeNode? node_reference) {
		var result = this.copy ();

		if (derived_instance_type == null && method_type_arguments == null) {
			return result;
		}

		result = SemanticAnalyzer.get_actual_type (derived_instance_type, method_type_arguments, (GenericType) result, node_reference);

		return result;
	}

	public override DataType? infer_type_argument (TypeParameter type_param, DataType value_type) {
		if (type_parameter == type_param) {
			var ret = value_type.copy ();
			ret.value_owned = true;
			return ret;
		}

		return null;
	}

	public override string to_qualified_string (Scope? scope = null) {
		return type_parameter.name;
	}

	public override Symbol? get_member (string member_name) {
		if (member_name == "dup") {
			return get_dup_field ();
		} else if (member_name == "destroy") {
			return get_destroy_field ();
		}
		return null;
	}

	unowned GenericDupField get_dup_field () {
		if (dup_field == null) {
			dup_field = new GenericDupField (source_reference);
			dup_field.access = SymbolAccessibility.PUBLIC;
		}
		return dup_field;
	}

	unowned GenericDestroyField get_destroy_field () {
		if (destroy_field == null) {
			destroy_field = new GenericDestroyField (source_reference);
			destroy_field.access = SymbolAccessibility.PUBLIC;
		}
		return destroy_field;
	}
}
