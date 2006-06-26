/* valaclassregisterfunction.vala
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
	public class ClassRegisterFunction : TypeRegisterFunction {
		public Class class_reference { get; construct; }
		
		public override DataType get_type_declaration () {
			return class_reference;
		}
		
		public override ref string get_type_struct_name () {
			return "%sClass".printf (class_reference.get_cname ());
		}
		
		public override ref string get_class_init_func_name () {
			return "%s_class_init".printf (class_reference.get_lower_case_cname (null));
		}
		
		public override ref string get_instance_struct_size () {
			return "sizeof (%s)".printf (class_reference.get_cname ());
		}
		
		public override ref string get_instance_init_func_name () {
			return "%s_init".printf (class_reference.get_lower_case_cname (null));
		}
		
		public override ref string get_parent_type_name () {
			return class_reference.base_class.get_upper_case_cname ("TYPE_");
		}
	}
}
