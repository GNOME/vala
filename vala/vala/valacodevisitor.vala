/* valacodevisitor.vala
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
	public abstract class CodeVisitor {
		public virtual void visit_begin_source_file (SourceFile source_file) {
		}

		public virtual void visit_end_source_file (SourceFile source_file) {
		}

		public virtual void visit_begin_namespace (Namespace ns) {
		}

		public virtual void visit_end_namespace (Namespace ns) {
		}

		public virtual void visit_begin_class (Class cl) {
		}

		public virtual void visit_end_class (Class cl) {
		}

		public virtual void visit_begin_struct (Struct st) {
		}

		public virtual void visit_end_struct (Struct st) {
		}

		public virtual void visit_begin_enum (Enum en) {
		}

		public virtual void visit_end_enum (Enum en) {
		}

		public virtual void visit_enum_value (EnumValue ev) {
		}

		public virtual void visit_constant (Constant c) {
		}

		public virtual void visit_field (Field f) {
		}

		public virtual void visit_begin_method (Method m) {
		}

		public virtual void visit_end_method (Method m) {
		}

		public virtual void visit_formal_parameter (FormalParameter p) {
		}

		public virtual void visit_begin_property (Property prop) {
		}

		public virtual void visit_end_property (Property prop) {
		}

		public virtual void visit_begin_property_accessor (PropertyAccessor acc) {
		}

		public virtual void visit_end_property_accessor (PropertyAccessor acc) {
		}

		public virtual void visit_named_argument (NamedArgument n) {
		}

		public virtual void visit_type_parameter (TypeParameter p) {
		}

		public virtual void visit_namespace_reference (NamespaceReference ns) {
		}

		public virtual void visit_type_reference (TypeReference type) {
		}

		public virtual void visit_begin_block (Block b) {
		}

		public virtual void visit_end_block (Block b) {
		}

		public virtual void visit_empty_statement (EmptyStatement stmt) {
		}

		public virtual void visit_declaration_statement (DeclarationStatement stmt) {
		}

		public virtual void visit_local_variable_declaration (LocalVariableDeclaration decl) {
		}

		public virtual void visit_variable_declarator (VariableDeclarator decl) {
		}

		public virtual void visit_initializer_list (InitializerList list) {
		}

		public virtual void visit_expression_statement (ExpressionStatement stmt) {
		}

		public virtual void visit_if_statement (IfStatement stmt) {
		}

		public virtual void visit_while_statement (WhileStatement stmt) {
		}

		public virtual void visit_for_statement (ForStatement stmt) {
		}

		public virtual void visit_begin_foreach_statement (ForeachStatement stmt) {
		}

		public virtual void visit_end_foreach_statement (ForeachStatement stmt) {
		}

		public virtual void visit_break_statement (BreakStatement stmt) {
		}

		public virtual void visit_continue_statement (ContinueStatement stmt) {
		}

		public virtual void visit_return_statement (ReturnStatement stmt) {
		}

		public virtual void visit_boolean_literal (BooleanLiteral expr) {
		}

		public virtual void visit_character_literal (CharacterLiteral expr) {
		}

		public virtual void visit_integer_literal (IntegerLiteral expr) {
		}

		public virtual void visit_string_literal (StringLiteral expr) {
		}

		public virtual void visit_null_literal (NullLiteral expr) {
		}

		public virtual void visit_literal_expression (LiteralExpression expr) {
		}

		public virtual void visit_simple_name (SimpleName expr) {
		}

		public virtual void visit_parenthesized_expression (ParenthesizedExpression expr) {
		}

		public virtual void visit_member_access (MemberAccess expr) {
		}

		public virtual void visit_invocation_expression (InvocationExpression expr) {
		}

		public virtual void visit_postfix_expression (PostfixExpression expr) {
		}

		public virtual void visit_object_creation_expression (ObjectCreationExpression expr) {
		}

		public virtual void visit_unary_expression (UnaryExpression expr) {
		}

		public virtual void visit_cast_expression (CastExpression expr) {
		}

		public virtual void visit_binary_expression (BinaryExpression expr) {
		}

		public virtual void visit_conditional_expression (ConditionalExpression expr) {
		}

		public virtual void visit_assignment (Assignment a) {
		}
	}
}
