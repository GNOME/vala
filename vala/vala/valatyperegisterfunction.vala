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

/**
 * C function to register a type at runtime.
 */
public abstract class Vala.TypeRegisterFunction : CCodeFunction {
	/**
	 * Constructs the C function from the specified type.
	 */
	public void init_from_type () {
		name = "%s_get_type".printf (get_type_declaration ().get_lower_case_cname (null));
		return_type = "GType";

		var type_block = new CCodeBlock ();
		var cdecl = new CCodeDeclaration ("GType");
		cdecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("g_define_type_id", new CCodeConstant ("0")));
		cdecl.modifiers = CCodeModifiers.STATIC;
		type_block.add_statement (cdecl);
		
		var cond = new CCodeFunctionCall (new CCodeIdentifier ("G_UNLIKELY"));
		cond.add_argument (new CCodeBinaryExpression (CCodeBinaryOperator.EQUALITY, new CCodeIdentifier ("g_define_type_id"), new CCodeConstant ("0")));
		var type_init = new CCodeBlock ();
		var ctypedecl = new CCodeDeclaration ("const GTypeInfo");
		ctypedecl.modifiers = CCodeModifiers.STATIC;
		ctypedecl.add_declarator (new CCodeVariableDeclarator.with_initializer ("g_define_type_info", new CCodeConstant ("{ sizeof (%s), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) %s, (GClassFinalizeFunc) NULL, NULL, %s, 0, (GInstanceInitFunc) %s }".printf (get_type_struct_name (), get_class_init_func_name (), get_instance_struct_size (), get_instance_init_func_name ()))));
		type_init.add_statement (ctypedecl);
		var reg_call = new CCodeFunctionCall (new CCodeIdentifier ("g_type_register_static"));
		reg_call.add_argument (new CCodeIdentifier (get_parent_type_name ()));
		reg_call.add_argument (new CCodeConstant ("\"%s\"".printf (get_type_declaration ().get_cname ())));
		reg_call.add_argument (new CCodeIdentifier ("&g_define_type_info"));
		reg_call.add_argument (new CCodeConstant (get_type_flags ()));
		type_init.add_statement (new CCodeExpressionStatement (new CCodeAssignment (new CCodeIdentifier ("g_define_type_id"), reg_call)));
		
		type_init.add_statement (get_type_interface_init_statements ());
		
		var cif = new CCodeIfStatement (cond, type_init);
		type_block.add_statement (cif);
		type_block.add_statement (new CCodeReturnStatement (new CCodeIdentifier ("g_define_type_id")));

		block = type_block;
	}
	
	/**
	 * Returns the data type to be registered.
	 *
	 * @return type to be registered
	 */
	public abstract DataType! get_type_declaration ();

	/**
	 * Returns the name of the type struct in C code.
	 *
	 * @return C struct name
	 */
	public abstract ref string! get_type_struct_name ();

	/**
	 * Returns the name of the class_init function in C code.
	 *
	 * @return C function name
	 */
	public abstract ref string! get_class_init_func_name ();

	/**
	 * Returns the size of the instance struct in C code.
	 *
	 * @return C instance struct size
	 */
	public abstract ref string! get_instance_struct_size ();

	/**
	 * Returns the name of the instance_init function in C code.
	 *
	 * @return C function name
	 */
	public abstract ref string! get_instance_init_func_name ();

	/**
	 * Returns the name of the parent type in C code.
	 *
	 * @return C parent type name
	 */
	public abstract ref string! get_parent_type_name ();

	/**
	 * Returns the set of type flags to be applied when registering.
	 *
	 * @return type flags
	 */
	public virtual string get_type_flags () {
		return "0";
	}

	/**
	 * Returns additional C initialization statements to setup interfaces.
	 *
	 * @return C statements
	 */
	public abstract ref CCodeFragment! get_type_interface_init_statements ();
	
	/**
	 * Returns the declaration for this type register function in C code.
	 *
	 * @return C function declaration
	 */
	public ref CCodeFunction! get_declaration () {
		return new CCodeFunction (name, return_type);
	}
}
