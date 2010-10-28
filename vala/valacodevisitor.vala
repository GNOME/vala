/* valacodevisitor.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

/**
 * Abstract code node visitor for traversing source code tree.
 */
public abstract class Vala.CodeVisitor {
	/**
	 * Visit operation called for source files.
	 *
	 * @param source_file a source file
	 */
	public virtual void visit_source_file (SourceFile source_file) {
	}

	/**
	 * Visit operation called for namespaces.
	 *
	 * @param ns a namespace
	 */
	public virtual void visit_namespace (Namespace ns) {
	}

	/**
	 * Visit operation called for classes.
	 *
	 * @param cl a class
	 */
	public virtual void visit_class (Class cl) {
	}

	/**
	 * Visit operation called for structs.
	 *
	 * @param st a struct
	 */
	public virtual void visit_struct (Struct st) {
	}

	/**
	 * Visit operation called for interfaces.
	 *
	 * @param iface an interface
	 */
	public virtual void visit_interface (Interface iface) {
	}

	/**
	 * Visit operation called for enums.
	 *
	 * @param en an enum
	 */
	public virtual void visit_enum (Enum en) {
	}

	/**
	 * Visit operation called for enum values.
	 *
	 * @param ev an enum value
	 */
	public virtual void visit_enum_value (EnumValue ev) {
	}

	/**
	 * Visit operation called for error domains.
	 *
	 * @param edomain an error domain
	 */
	public virtual void visit_error_domain (ErrorDomain edomain) {
	}

	/**
	 * Visit operation called for error codes.
	 *
	 * @param ecode an error code
	 */
	public virtual void visit_error_code (ErrorCode ecode) {
	}

	/**
	 * Visit operation called for delegates.
	 *
	 * @param d a delegate
	 */
	public virtual void visit_delegate (Delegate d) {
	}

	/**
	 * Visit operation called for constants.
	 *
	 * @param c a constant
	 */
	public virtual void visit_constant (Constant c) {
	}

	/**
	 * Visit operation called for fields.
	 *
	 * @param f a field
	 */
	public virtual void visit_field (Field f) {
	}

	/**
	 * Visit operation called for methods.
	 *
	 * @param m a method
	 */
	public virtual void visit_method (Method m) {
	}

	/**
	 * Visit operation called for creation methods.
	 *
	 * @param m a method
	 */
	public virtual void visit_creation_method (CreationMethod m) {
	}

	/**
	 * Visit operation called for formal parameters.
	 *
	 * @param p a formal parameter
	 */
	public virtual void visit_formal_parameter (Parameter p) {
	}

	/**
	 * Visit operation called for properties.
	 *
	 * @param prop a property
	 */
	public virtual void visit_property (Property prop) {
	}

	/**
	 * Visit operation called for property accessors.
	 *
	 * @param acc a property accessor
	 */
	public virtual void visit_property_accessor (PropertyAccessor acc) {
	}

	/**
	 * Visit operation called for signals.
	 *
	 * @param sig a signal
	 */
	public virtual void visit_signal (Signal sig) {
	}

	/**
	 * Visit operation called for constructors.
	 *
	 * @param c a constructor
	 */
	public virtual void visit_constructor (Constructor c) {
	}

	/**
	 * Visit operation called for destructors.
	 *
	 * @param d a destructor
	 */
	public virtual void visit_destructor (Destructor d) {
	}

	/**
	 * Visit operation called for type parameters.
	 *
	 * @param p a type parameter
	 */
	public virtual void visit_type_parameter (TypeParameter p) {
	}

	/**
	 * Visit operation called for using directives.
	 *
	 * @param ns a using directive
	 */
	public virtual void visit_using_directive (UsingDirective ns) {
	}

	/**
	 * Visit operation called for type references.
	 *
	 * @param type a type reference
	 */
	public virtual void visit_data_type (DataType type) {
	}

	/**
	 * Visit operation called for blocks.
	 *
	 * @param b a block
	 */
	public virtual void visit_block (Block b) {
	}

	/**
	 * Visit operation called for empty statements.
	 *
	 * @param stmt an empty statement
	 */
	public virtual void visit_empty_statement (EmptyStatement stmt) {
	}

	/**
	 * Visit operation called for declaration statements.
	 *
	 * @param stmt a declaration statement
	 */
	public virtual void visit_declaration_statement (DeclarationStatement stmt) {
	}

	/**
	 * Visit operation called for local variables.
	 *
	 * @param local a local variable
	 */
	public virtual void visit_local_variable (LocalVariable local) {
	}

	/**
	 * Visit operation called for initializer lists
	 *
	 * @param list an initializer list
	 */
	public virtual void visit_initializer_list (InitializerList list) {
	}

	/**
	 * Visit operation called for expression statements.
	 *
	 * @param stmt an expression statement
	 */
	public virtual void visit_expression_statement (ExpressionStatement stmt) {
	}

	/**
	 * Visit operation called for if statements.
	 *
	 * @param stmt an if statement
	 */
	public virtual void visit_if_statement (IfStatement stmt) {
	}

	/**
	 * Visit operation called for switch statements.
	 *
	 * @param stmt a switch statement
	 */
	public virtual void visit_switch_statement (SwitchStatement stmt) {
	}

	/**
	 * Visit operation called for switch sections.
	 *
	 * @param section a switch section
	 */
	public virtual void visit_switch_section (SwitchSection section) {
	}

	/**
	 * Visit operation called for switch label.
	 *
	 * @param label a switch label
	 */
	public virtual void visit_switch_label (SwitchLabel label) {
	}

	/**
	 * Visit operation called for loops.
	 *
	 * @param stmt a loop
	 */
	public virtual void visit_loop (Loop stmt) {
	}

	/**
	 * Visit operation called for while statements.
	 *
	 * @param stmt an while statement
	 */
	public virtual void visit_while_statement (WhileStatement stmt) {
	}

	/**
	 * Visit operation called for do statements.
	 *
	 * @param stmt a do statement
	 */
	public virtual void visit_do_statement (DoStatement stmt) {
	}

	/**
	 * Visit operation called for for statements.
	 *
	 * @param stmt a for statement
	 */
	public virtual void visit_for_statement (ForStatement stmt) {
	}

	/**
	 * Visit operation called for foreach statements.
	 *
	 * @param stmt a foreach statement
	 */
	public virtual void visit_foreach_statement (ForeachStatement stmt) {
	}

	/**
	 * Visit operation called for break statements.
	 *
	 * @param stmt a break statement
	 */
	public virtual void visit_break_statement (BreakStatement stmt) {
	}

	/**
	 * Visit operation called for continue statements.
	 *
	 * @param stmt a continue statement
	 */
	public virtual void visit_continue_statement (ContinueStatement stmt) {
	}

	/**
	 * Visit operation called for return statements.
	 *
	 * @param stmt a return statement
	 */
	public virtual void visit_return_statement (ReturnStatement stmt) {
	}

	/**
	 * Visit operation called for yield statement.
	 *
	 * @param y a yield statement
	 */
	public virtual void visit_yield_statement (YieldStatement y) {
	}

	/**
	 * Visit operation called for throw statements.
	 *
	 * @param stmt a throw statement
	 */
	public virtual void visit_throw_statement (ThrowStatement stmt) {
	}

	/**
	 * Visit operation called for try statements.
	 *
	 * @param stmt a try statement
	 */
	public virtual void visit_try_statement (TryStatement stmt) {
	}

	/**
	 * Visit operation called for catch clauses.
	 *
	 * @param clause a catch cluase
	 */
	public virtual void visit_catch_clause (CatchClause clause) {
	}

	/**
	 * Visit operation called for lock statements before the body has been visited.
	 *
	 * @param stmt a lock statement
	 */
	public virtual void visit_lock_statement (LockStatement stmt) {
	}

	/**
	 * Visit operation called for unlock statements.
	 *
	 * @param stmt an unlock statement
	 */
	public virtual void visit_unlock_statement (UnlockStatement stmt) {
	}

	/**
	 * Visit operation called for delete statements.
	 *
	 * @param stmt a delete statement
	 */
	public virtual void visit_delete_statement (DeleteStatement stmt) {
	}

	/**
	 * Visit operations called for expresions.
	 *
	 * @param expr an expression
	 */
	public virtual void visit_expression (Expression expr) {
	}

	/**
	 * Visit operations called for array creation expresions.
	 *
	 * @param expr an array creation expression
	 */
	public virtual void visit_array_creation_expression (ArrayCreationExpression expr) {
	}

	/**
	 * Visit operation called for boolean literals.
	 *
	 * @param lit a boolean literal
	 */
	public virtual void visit_boolean_literal (BooleanLiteral lit) {
	}

	/**
	 * Visit operation called for character literals.
	 *
	 * @param lit a character literal
	 */
	public virtual void visit_character_literal (CharacterLiteral lit) {
	}

	/**
	 * Visit operation called for integer literals.
	 *
	 * @param lit an integer literal
	 */
	public virtual void visit_integer_literal (IntegerLiteral lit) {
	}

	/**
	 * Visit operation called for real literals.
	 *
	 * @param lit a real literal
	 */
	public virtual void visit_real_literal (RealLiteral lit) {
	}

	/**
	 * Visit operation called for regex literals.
	 *
	 * @param lit a regex literal
	 */
	public virtual void visit_regex_literal (RegexLiteral lit) {
	}


	/**
	 * Visit operation called for string literals.
	 *
	 * @param lit a string literal
	 */
	public virtual void visit_string_literal (StringLiteral lit) {
	}

	/**
	 * Visit operation called for string templates.
	 *
	 * @param tmpl a string template
	 */
	public virtual void visit_template (Template tmpl) {
	}

	/**
	 * Visit operation called for list literals.
	 *
	 * @param lit a list literal
	 */
	public virtual void visit_list_literal (ListLiteral lit) {
	}

	/**
	 * Visit operation called for set literals.
	 *
	 * @param lit a set literal
	 */
	public virtual void visit_set_literal (SetLiteral lit) {
	}

	/**
	 * Visit operation called for map literals.
	 *
	 * @param lit a map literal
	 */
	public virtual void visit_map_literal (MapLiteral lit) {
	}

	/**
	 * Visit operation called for tuples.
	 *
	 * @param tuple a tuple
	 */
	public virtual void visit_tuple (Tuple tuple) {
	}

	/**
	 * Visit operation called for null literals.
	 *
	 * @param lit a null literal
	 */
	public virtual void visit_null_literal (NullLiteral lit) {
	}

	/**
	 * Visit operation called for member access expressions.
	 *
	 * @param expr a member access expression
	 */
	public virtual void visit_member_access (MemberAccess expr) {
	}

	/**
	 * Visit operation called for invocation expressions.
	 *
	 * @param expr an invocation expression
	 */
	public virtual void visit_method_call (MethodCall expr) {
	}
	
	/**
	 * Visit operation called for element access expressions.
	 *
	 * @param expr an element access expression
	 */
	public virtual void visit_element_access (ElementAccess expr) {
	}

	/**
	 * Visit operation called for array slice expressions.
	 *
	 * @param expr an array slice expression
	 */
	public virtual void visit_slice_expression (SliceExpression expr) {
	}

	/**
	 * Visit operation called for base access expressions.
	 *
	 * @param expr a base access expression
	 */
	public virtual void visit_base_access (BaseAccess expr) {
	}

	/**
	 * Visit operation called for postfix expressions.
	 *
	 * @param expr a postfix expression
	 */
	public virtual void visit_postfix_expression (PostfixExpression expr) {
	}

	/**
	 * Visit operation called for object creation expressions.
	 *
	 * @param expr an object creation expression
	 */
	public virtual void visit_object_creation_expression (ObjectCreationExpression expr) {
	}

	/**
	 * Visit operation called for sizeof expressions.
	 *
	 * @param expr a sizeof expression
	 */
	public virtual void visit_sizeof_expression (SizeofExpression expr) {
	}

	/**
	 * Visit operation called for typeof expressions.
	 *
	 * @param expr a typeof expression
	 */
	public virtual void visit_typeof_expression (TypeofExpression expr) {
	}

	/**
	 * Visit operation called for unary expressions.
	 *
	 * @param expr an unary expression
	 */
	public virtual void visit_unary_expression (UnaryExpression expr) {
	}

	/**
	 * Visit operation called for call expressions.
	 *
	 * @param expr a call expression
	 */
	public virtual void visit_cast_expression (CastExpression expr) {
	}

	/**
	 * Visit operation called for named arguments.
	 *
	 * @param expr a named argument
	 */
	public virtual void visit_named_argument (NamedArgument expr) {
	}

	/**
	 * Visit operation called for pointer indirections.
	 *
	 * @param expr a pointer indirection
	 */
	public virtual void visit_pointer_indirection (PointerIndirection expr) {
	}

	/**
	 * Visit operation called for address-of expressions.
	 *
	 * @param expr an address-of expression
	 */
	public virtual void visit_addressof_expression (AddressofExpression expr) {
	}

	/**
	 * Visit operation called for reference transfer expressions.
	 *
	 * @param expr a reference transfer expression
	 */
	public virtual void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
	}

	/**
	 * Visit operation called for binary expressions.
	 *
	 * @param expr a binary expression
	 */
	public virtual void visit_binary_expression (BinaryExpression expr) {
	}

	/**
	 * Visit operation called for type checks.
	 *
	 * @param expr a type check expression
	 */
	public virtual void visit_type_check (TypeCheck expr) {
	}

	/**
	 * Visit operation called for conditional expressions.
	 *
	 * @param expr a conditional expression
	 */
	public virtual void visit_conditional_expression (ConditionalExpression expr) {
	}

	/**
	 * Visit operation called for lambda expressions.
	 *
	 * @param expr a lambda expression
	 */
	public virtual void visit_lambda_expression (LambdaExpression expr) {
	}

	/**
	 * Visit operation called for assignments.
	 *
	 * @param a an assignment
	 */
	public virtual void visit_assignment (Assignment a) {
	}

	/**
	 * Visit operation called at end of full expressions.
	 *
	 * @param expr a full expression
	 */
	public virtual void visit_end_full_expression (Expression expr) {
	}
}
