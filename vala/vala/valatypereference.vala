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
		public readonly string# namespace_name;
		public readonly string# type_name;
		public readonly Expression# expression;
		public readonly SourceReference# source_reference;
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

		public static TypeReference# @new (string ns, string type_name, List type_argument_list, SourceReference source) {
			return (new TypeReference (namespace_name = ns, type_name = type_name, source_reference = source));
		}

		public static TypeReference# new_from_expression (Expression expr, SourceReference source) {
			return (new TypeReference (expression = expr, source_reference = source));
		}
	}
}
