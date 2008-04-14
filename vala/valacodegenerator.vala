/* valacodegenerator.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
 * Abstract code visitor generating code.
 */
public class Vala.CodeGenerator : CodeVisitor {
	/**
	 * Generate and emit C code for the specified code context.
	 *
	 * @param context a code context
	 */
	public virtual void emit (CodeContext context) {
	}

	public virtual CodeBinding? create_namespace_binding (Namespace node) {
		return null;
	}

	public virtual CodeBinding? create_class_binding (Class node) {
		return null;
	}

	public virtual CodeBinding? create_struct_binding (Struct node) {
		return null;
	}

	public virtual CodeBinding? create_interface_binding (Interface node) {
		return null;
	}

	public virtual CodeBinding? create_enum_binding (Enum node) {
		return null;
	}

	public virtual CodeBinding? create_enum_value_binding (EnumValue node) {
		return null;
	}

	public virtual CodeBinding? create_error_domain_binding (ErrorDomain node) {
		return null;
	}

	public virtual CodeBinding? create_error_code_binding (ErrorCode node) {
		return null;
	}

	public virtual CodeBinding? create_delegate_binding (Delegate node) {
		return null;
	}

	public virtual CodeBinding? create_constant_binding (Constant node) {
		return null;
	}

	public virtual CodeBinding? create_field_binding (Field node) {
		return null;
	}

	public virtual CodeBinding? create_method_binding (Method node) {
		return null;
	}

	public virtual CodeBinding? create_creation_method_binding (CreationMethod node) {
		return null;
	}

	public virtual CodeBinding? create_formal_parameter_binding (FormalParameter node) {
		return null;
	}

	public virtual CodeBinding? create_property_binding (Property node) {
		return null;
	}

	public virtual CodeBinding? create_property_accessor_binding (PropertyAccessor node) {
		return null;
	}

	public virtual CodeBinding? create_signal_binding (Signal node) {
		return null;
	}

	public virtual CodeBinding? create_constructor_binding (Constructor node) {
		return null;
	}

	public virtual CodeBinding? create_destructor_binding (Destructor node) {
		return null;
	}

	public virtual CodeBinding? create_type_parameter_binding (TypeParameter node) {
		return null;
	}

	public virtual CodeBinding? create_block_binding (Block node) {
		return null;
	}

	public virtual CodeBinding? create_empty_statement_binding (EmptyStatement node) {
		return null;
	}

	public virtual CodeBinding? create_declaration_statement_binding (DeclarationStatement node) {
		return null;
	}

	public virtual CodeBinding? create_local_variable_declaration_binding (LocalVariableDeclaration node) {
		return null;
	}

	public virtual CodeBinding? create_variable_declarator_binding (VariableDeclarator node) {
		return null;
	}

	public virtual CodeBinding? create_initializer_list_binding (InitializerList node) {
		return null;
	}

	public virtual CodeBinding? create_expression_statement_binding (ExpressionStatement node) {
		return null;
	}

	public virtual CodeBinding? create_if_statement_binding (IfStatement node) {
		return null;
	}

	public virtual CodeBinding? create_switch_statement_binding (SwitchStatement node) {
		return null;
	}

	public virtual CodeBinding? create_switch_section_binding (SwitchSection node) {
		return null;
	}

	public virtual CodeBinding? create_switch_label_binding (SwitchLabel node) {
		return null;
	}

	public virtual CodeBinding? create_while_statement_binding (WhileStatement node) {
		return null;
	}

	public virtual CodeBinding? create_do_statement_binding (DoStatement node) {
		return null;
	}

	public virtual CodeBinding? create_for_statement_binding (ForStatement node) {
		return null;
	}

	public virtual CodeBinding? create_foreach_statement_binding (ForeachStatement node) {
		return null;
	}

	public virtual CodeBinding? create_break_statement_binding (BreakStatement node) {
		return null;
	}

	public virtual CodeBinding? create_continue_statement_binding (ContinueStatement node) {
		return null;
	}

	public virtual CodeBinding? create_return_statement_binding (ReturnStatement node) {
		return null;
	}

	public virtual CodeBinding? create_throw_statement_binding (ThrowStatement node) {
		return null;
	}

	public virtual CodeBinding? create_try_statement_binding (TryStatement node) {
		return null;
	}

	public virtual CodeBinding? create_catch_clause_binding (CatchClause node) {
		return null;
	}

	public virtual CodeBinding? create_lock_statement_binding (LockStatement node) {
		return null;
	}

	public virtual CodeBinding? create_delete_statement_binding (DeleteStatement node) {
		return null;
	}

	public virtual CodeBinding? create_array_creation_expression_binding (ArrayCreationExpression node) {
		return null;
	}

	public virtual CodeBinding? create_boolean_literal_binding (BooleanLiteral node) {
		return null;
	}

	public virtual CodeBinding? create_character_literal_binding (CharacterLiteral node) {
		return null;
	}

	public virtual CodeBinding? create_integer_literal_binding (IntegerLiteral node) {
		return null;
	}

	public virtual CodeBinding? create_real_literal_binding (RealLiteral node) {
		return null;
	}

	public virtual CodeBinding? create_string_literal_binding (StringLiteral node) {
		return null;
	}

	public virtual CodeBinding? create_null_literal_binding (NullLiteral node) {
		return null;
	}

	public virtual CodeBinding? create_parenthesized_expression_binding (ParenthesizedExpression node) {
		return null;
	}

	public virtual CodeBinding? create_member_access_binding (MemberAccess node) {
		return null;
	}

	public virtual CodeBinding? create_member_access_simple_binding (MemberAccess node) {
		return null;
	}

	public virtual CodeBinding? create_invocation_expression_binding (InvocationExpression node) {
		return null;
	}

	public virtual CodeBinding? create_element_access_binding (ElementAccess node) {
		return null;
	}

	public virtual CodeBinding? create_base_access_binding (BaseAccess node) {
		return null;
	}

	public virtual CodeBinding? create_postfix_expression_binding (PostfixExpression node) {
		return null;
	}

	public virtual CodeBinding? create_object_creation_expression_binding (ObjectCreationExpression node) {
		return null;
	}

	public virtual CodeBinding? create_sizeof_expression_binding (SizeofExpression node) {
		return null;
	}

	public virtual CodeBinding? create_typeof_expression_binding (TypeofExpression node) {
		return null;
	}

	public virtual CodeBinding? create_unary_expression_binding (UnaryExpression node) {
		return null;
	}

	public virtual CodeBinding? create_cast_expression_binding (CastExpression node) {
		return null;
	}

	public virtual CodeBinding? create_pointer_indirection_binding (PointerIndirection node) {
		return null;
	}

	public virtual CodeBinding? create_addressof_expression_binding (AddressofExpression node) {
		return null;
	}

	public virtual CodeBinding? create_reference_transfer_expression_binding (ReferenceTransferExpression node) {
		return null;
	}

	public virtual CodeBinding? create_binary_expression_binding (BinaryExpression node) {
		return null;
	}

	public virtual CodeBinding? create_type_check_binding (TypeCheck node) {
		return null;
	}

	public virtual CodeBinding? create_conditional_expression_binding (ConditionalExpression node) {
		return null;
	}

	public virtual CodeBinding? create_lambda_expression_binding (LambdaExpression node) {
		return null;
	}

	public virtual CodeBinding? create_lambda_expression_with_statement_body_binding (LambdaExpression node) {
		return null;
	}

	public virtual CodeBinding? create_assignment_binding (Assignment node) {
		return null;
	}
}
