/* valatypereference.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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
 */

using GLib;

namespace Vala {
	public class TypeReference : CodeNode {
		public string namespace_name { get; construct; }
		public string type_name { get; construct; }
		public bool is_ref { get; set; }
		public bool is_lvalue_ref { get; set; }
		public bool is_weak { get; set; }
		public bool is_out { get; set; }
		public bool array { get; set; }
		public bool array_own { get; set; }
		public bool non_null { get; set; }
		public weak DataType type;
		public TypeParameter type_parameter;
		public bool floating_reference { get; set; }

		List<TypeReference> type_argument_list;

		public static ref TypeReference new (string ns, string type_name, SourceReference source) {
			return (new TypeReference (namespace_name = ns, type_name = type_name, source_reference = source));
		}

		public static ref TypeReference new_from_expression (Expression expr, SourceReference source) {
			string ns = null;
			string type_name = null;
			if (expr is MemberAccess) {
				MemberAccess ma = (MemberAccess) expr;
				if (ma.inner != null) {
					if (ma.inner is MemberAccess) {
						var simple = (MemberAccess) ma.inner;
						return (new TypeReference (namespace_name = simple.member_name, type_name = ma.member_name, source_reference = source));
					}
				} else {
					return (new TypeReference (type_name = ma.member_name, source_reference = source));
				}
			}
			/* FIXME: raise error */
			return null;
		}
		
		public void add_type_argument (TypeReference! arg) {
			type_argument_list.append (arg);
		}
		
		public ref List<TypeReference> get_type_arguments () {
			return type_argument_list.copy ();
		}
		
		public override void accept (CodeVisitor! visitor) {
			foreach (TypeReference type_arg in type_argument_list) {
				type_arg.accept (visitor);
			}
		
			visitor.visit_type_reference (this);
		}

		public ref string get_cname (bool var_type = false) {
			if (type == null && type_parameter == null) {
				if (var_type) {
					return "gpointer";
				} else {
					return "void";
				}
			}
			
			string ptr;
			string arr;
			if (type_parameter == null && !type.is_reference_type () && !is_ref) {
				ptr = "";
			} else if (((type_parameter != null || type.is_reference_type ()) && !is_out) || is_ref) {
				ptr = "*";
			} else {
				ptr = "**";
			}
			if (!array) {
				arr = "";
			} else {
				arr = "*";
			}
			if (type != null) {
				return type.get_cname ().concat (ptr, arr, null);
			} else if (type_parameter != null) {
				return "gpointer".concat (ptr, arr, null);
			} else {
				/* raise error */
				Report.error (source_reference, "unresolved type reference");
				return null;
			}
		}

		public ref string get_const_cname () {
			string ptr;
			string arr;
			if (!type.is_reference_type () && !is_ref) {
				ptr = "";
			} else if (((type.is_reference_type ()) && !is_out) || is_ref) {
				ptr = "*";
			} else {
				ptr = "**";
			}
			return "const %s%s".printf (type.get_cname (), ptr);
		}
		
		public ref string get_upper_case_cname (string infix) {
			return type.get_upper_case_cname (infix);
		}
		
		public ref string to_string () {
			if (type != null) {
				return type.symbol.get_full_name ();
			} else if (type_parameter != null) {
				return type_parameter.name;
			} else {
				return "null";
			}
		}
		
		public ref TypeReference copy () {
			var result = new TypeReference ();
			result.is_ref = is_ref;
			result.is_lvalue_ref = is_lvalue_ref;
			result.is_weak = is_weak;
			result.is_out = is_out;
			result.array = array;
			result.array_own = array_own;
			result.non_null = non_null;
			result.type = type;
			result.type_parameter = type_parameter;
			
			return result;
		}
		
		public bool equals (TypeReference! type2) {
			if (type2.is_ref != is_ref) {
				return false;
			}
			if (type2.is_lvalue_ref != is_lvalue_ref) {
				return false;
			}
			if (type2.is_weak != is_weak) {
				return false;
			}
			if (type2.is_out != is_out) {
				return false;
			}
			if (type2.array != array) {
				return false;
			}
			if (type2.array_own != array_own) {
				return false;
			}
			if (type2.non_null != non_null) {
				return false;
			}
			if (type2.type != type) {
				return false;
			}
			if (type2.type_parameter != type_parameter) {
				return false;
			}
			if (type2.floating_reference != floating_reference) {
				return false;
			}
		
			return true;
		}
	}
}
