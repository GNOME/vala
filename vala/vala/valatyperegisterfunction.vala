/* valatyperegisterfunction.vala
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
	public abstract class TypeRegisterFunction : CCodeFunction {
		public void init_from_type () {
			name = "%s_get_type".printf (get_type_declaration ().get_lower_case_cname (null));
			return_type = "GType";

			var type_block = new CCodeBlock ();
			var cdecl = new CCodeDeclaration (type_name = "GType");
			cdecl.add_declarator (new CCodeVariableDeclarator (name = "g_define_type_id", initializer = new CCodeConstant (name = "0")));
			cdecl.modifiers = CCodeModifiers.STATIC;
			type_block.add_statement (cdecl);
			
			var cond = new CCodeFunctionCall (call = new CCodeIdentifier (name = "G_UNLIKELY"));
			cond.add_argument (new CCodeBinaryExpression (operator = CCodeBinaryOperator.EQUALITY, left = new CCodeIdentifier (name = "g_define_type_id"), right = new CCodeConstant (name = "0")));
			var type_init = new CCodeBlock ();
			var ctypedecl = new CCodeDeclaration (type_name = "const GTypeInfo");
			ctypedecl.modifiers = CCodeModifiers.STATIC;
			ctypedecl.add_declarator (new CCodeVariableDeclarator (name = "g_define_type_info", initializer = new CCodeConstant (name = "{ sizeof (%s), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) %s, (GClassFinalizeFunc) NULL, NULL, %s, 0, (GInstanceInitFunc) %s }".printf (get_type_struct_name (), get_class_init_func_name (), get_instance_struct_size (), get_instance_init_func_name ()))));
			type_init.add_statement (ctypedecl);
			var reg_call = new CCodeFunctionCall (call = new CCodeIdentifier (name = "g_type_register_static"));
			reg_call.add_argument (new CCodeIdentifier (name = get_parent_type_name ()));
			reg_call.add_argument (new CCodeConstant (name = "\"%s\"".printf (get_type_declaration ().get_cname ())));
			reg_call.add_argument (new CCodeIdentifier (name = "&g_define_type_info"));
			reg_call.add_argument (new CCodeConstant (name = "0"));
			type_init.add_statement (new CCodeExpressionStatement (expression = new CCodeAssignment (left = new CCodeIdentifier (name = "g_define_type_id"), right = reg_call)));
			var cif = new CCodeIfStatement (condition = cond, true_statement = type_init);
			type_block.add_statement (cif);
			type_block.add_statement (new CCodeReturnStatement (return_expression = new CCodeIdentifier (name = "g_define_type_id")));

			block = type_block;
		}
		
		public abstract DataType get_type_declaration ();
		public abstract ref string get_type_struct_name ();
		public abstract ref string get_class_init_func_name ();
		public abstract ref string get_instance_struct_size ();
		public abstract ref string get_instance_init_func_name ();
		public abstract ref string get_parent_type_name ();
		
		public ref CCodeFunction get_declaration () {
			return new CCodeFunction (name = name, return_type = return_type);
		}
	}
}
