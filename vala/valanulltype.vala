/* valanulltype.vala
 *
 * Copyright (C) 2007-2010  Jürg Billeter
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
 * The type of the null literal.
 */
public class Vala.NullType : ReferenceType {
	public NullType (SourceReference? source_reference) {
		this.nullable = true;
		this.source_reference = source_reference;
	}

	public override bool compatible (DataType target_type) {
		if (CodeContext.get ().experimental_non_null) {
			return target_type.nullable;
		}

		if (!(target_type is PointerType) && (target_type is NullType || (target_type.data_type == null && target_type.type_parameter == null))) {
			return true;
		}

		/* null can be cast to any reference or array type or pointer type */
		if (target_type.type_parameter != null ||
		    target_type is PointerType ||
		    target_type.nullable ||
		    target_type.data_type.get_attribute ("PointerType") != null) {
			return true;
		}

		if (target_type.data_type.is_reference_type () ||
		    target_type is ArrayType ||
		    target_type is DelegateType) {
			return true;
		}

		/* null is not compatible with any other type (i.e. value types) */
		return false;
	}

	public override DataType copy () {
		return new NullType (source_reference);
	}

	public override bool is_disposable () {
		return false;
	}

	public override string to_qualified_string (Scope? scope = null) {
		return "null";
	}
}
