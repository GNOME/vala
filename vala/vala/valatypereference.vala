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
		public SourceReference source_reference { get; construct; }
		bool _own;
		public bool own {
			get {
				return _own;
			}
			set {
				_own = value;
			}
		}
		int _array;
		public bool array {
			get {
				return _array;
			}
			set {
				_array = value;
			}
		}
		int _array_own;
		public bool array_own {
			get {
				return _array_own;
			}
			set {
				_array_own = value;
			}
		}
		public Type_ type;
		public TypeParameter type_parameter;
		public bool is_ref;
		public bool is_out;

		List<TypeReference> type_argument_list;

		public static ref TypeReference new (string ns, string type_name, SourceReference source) {
			return (new TypeReference (namespace_name = ns, type_name = type_name, source_reference = source));
		}

		public static ref TypeReference new_from_expression (Expression expr, SourceReference source) {
			string ns = null;
			string type_name = null;
			if (expr is MemberAccess) {
				MemberAccess ma = (MemberAccess) expr;
				if (ma.inner is SimpleName) {
					SimpleName simple = (SimpleName) ma.inner;
					return (new TypeReference (namespace_name = simple.name, type_name = ma.member_name, source_reference = source));
				}
			} else if (expr is SimpleName) {
				SimpleName simple = (SimpleName) expr;
				return (new TypeReference (type_name = simple.name, source_reference = source));
			}
			/* FIXME: raise error */
			return null;
		}
		
		public void add_type_argument (TypeReference arg) {
			type_argument_list.append (arg);
		}
		
		public override void accept (CodeVisitor visitor) {
			visitor.visit_type_reference (this);
		}

		public ref string get_cname () {
			if (type == null && type_parameter == null) {
				return "void";
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
	}
}
