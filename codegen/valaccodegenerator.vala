/* valaccodegenerator.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Code visitor generating C Code.
 */
public class Vala.CCodeGenerator : CodeGenerator {
	public CCodeModule head;

	public CCodeGenerator () {
	}

	public override void emit (CodeContext context) {
		if (context.profile == Profile.GOBJECT) {
			/* included by inheritance
			head = new CCodeBaseModule (this, head);
			head = new CCodeStructModule (this, head);
			head = new CCodeMethodModule (this, head);
			head = new CCodeControlFlowModule (this, head);
			head = new CCodeMemberAccessModule (this, head);
			head = new CCodeAssignmentModule (this, head);
			head = new CCodeMethodCallModule (this, head);
			head = new CCodeArrayModule (this, head);
			head = new CCodeDelegateModule (this, head);
			head = new GErrorModule (this, head);
			head = new GTypeModule (this, head);
			head = new GObjectModule (this, head);
			head = new GSignalModule (this, head);
			head = new GAsyncModule (this, head);
			head = new DBusClientModule (this, head);
			*/
			head = new DBusServerModule (this, head);
		} else {
			/* included by inheritance
			head = new CCodeBaseModule (this, head);
			head = new CCodeStructModule (this, head);
			head = new CCodeMethodModule (this, head);
			head = new CCodeControlFlowModule (this, head);
			head = new CCodeMemberAccessModule (this, head);
			head = new CCodeAssignmentModule (this, head);
			head = new CCodeMethodCallModule (this, head);
			head = new CCodeArrayModule (this, head);
			*/
			head = new CCodeDelegateModule (this, head);
		}

		head = add_modules (head);
		head.emit (context);

		head = null;
	}

	public virtual CCodeModule add_modules (CCodeModule head) {
		return head;
	}

	public override void visit_source_file (SourceFile source_file) {
		head.visit_source_file (source_file);
	}

	public override void visit_class (Class cl) {
		head.visit_class (cl);
	}

	public override void visit_interface (Interface iface) {
		head.visit_interface (iface);
	}

	public override void visit_struct (Struct st) {
		head.visit_struct (st);
	}

	public override void visit_enum (Enum en) {
		head.visit_enum (en);
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		head.visit_error_domain (edomain);
	}

	public override void visit_delegate (Delegate d) {
		head.visit_delegate (d);
	}
	
	public override void visit_member (Member m) {
		head.visit_member (m);
	}

	public override void visit_constant (Constant c) {
		head.visit_constant (c);
	}

	public override void visit_field (Field f) {
		head.visit_field (f);
	}

	public override void visit_method (Method m) {
		head.visit_method (m);
	}

	public override void visit_creation_method (CreationMethod m) {
		head.visit_creation_method (m);
	}

	public override void visit_formal_parameter (FormalParameter p) {
		head.visit_formal_parameter (p);
	}

	public override void visit_property (Property prop) {
		head.visit_property (prop);
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		head.visit_property_accessor (acc);
	}

	public override void visit_signal (Signal sig) {
		head.visit_signal (sig);
	}

	public override void visit_constructor (Constructor c) {
		head.visit_constructor (c);
	}

	public override void visit_destructor (Destructor d) {
		head.visit_destructor (d);
	}

	public override void visit_block (Block b) {
		head.visit_block (b);
	}

	public override void visit_empty_statement (EmptyStatement stmt) {
		head.visit_empty_statement (stmt);
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		head.visit_declaration_statement (stmt);
	}

	public override void visit_local_variable (LocalVariable local) {
		head.visit_local_variable (local);
	}

	public override void visit_initializer_list (InitializerList list) {
		head.visit_initializer_list (list);
	}

	public override void visit_end_full_expression (Expression expr) {
		head.visit_end_full_expression (expr);
	}
	
	public override void visit_expression_statement (ExpressionStatement stmt) {
		head.visit_expression_statement (stmt);
	}

	public override void visit_if_statement (IfStatement stmt) {
		head.visit_if_statement (stmt);
	}

	public override void visit_switch_statement (SwitchStatement stmt) {
		head.visit_switch_statement (stmt);
	}

	public override void visit_switch_section (SwitchSection section) {
		head.visit_switch_section (section);
	}

	public override void visit_switch_label (SwitchLabel label) {
		head.visit_switch_label (label);
	}

	public override void visit_loop (Loop stmt) {
		head.visit_loop (stmt);
	}

	public override void visit_foreach_statement (ForeachStatement stmt) {
		head.visit_foreach_statement (stmt);
	}

	public override void visit_break_statement (BreakStatement stmt) {
		head.visit_break_statement (stmt);
	}

	public override void visit_continue_statement (ContinueStatement stmt) {
		head.visit_continue_statement (stmt);
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		head.visit_return_statement (stmt);
	}

	public override void visit_yield_statement (YieldStatement stmt) {
		head.visit_yield_statement (stmt);
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		head.visit_throw_statement (stmt);
	}

	public override void visit_try_statement (TryStatement stmt) {
		head.visit_try_statement (stmt);
	}

	public override void visit_catch_clause (CatchClause clause) {
		head.visit_catch_clause (clause);
	}

	public override void visit_lock_statement (LockStatement stmt) {
		head.visit_lock_statement (stmt);
	}

	public override void visit_unlock_statement (UnlockStatement stmt) {
		head.visit_unlock_statement (stmt);
	}

	public override void visit_delete_statement (DeleteStatement stmt) {
		head.visit_delete_statement (stmt);
	}

	public override void visit_expression (Expression expr) {
		head.visit_expression (expr);
	}

	public override void visit_array_creation_expression (ArrayCreationExpression expr) {
		head.visit_array_creation_expression (expr);
	}

	public override void visit_boolean_literal (BooleanLiteral expr) {
		head.visit_boolean_literal (expr);
	}

	public override void visit_character_literal (CharacterLiteral expr) {
		head.visit_character_literal (expr);
	}

	public override void visit_integer_literal (IntegerLiteral expr) {
		head.visit_integer_literal (expr);
	}

	public override void visit_real_literal (RealLiteral expr) {
		head.visit_real_literal (expr);
	}

	public override void visit_string_literal (StringLiteral expr) {
		head.visit_string_literal (expr);
	}

	public override void visit_list_literal (ListLiteral expr) {
		head.visit_list_literal (expr);
	}

	public override void visit_set_literal (SetLiteral expr) {
		head.visit_set_literal (expr);
	}

	public override void visit_map_literal (MapLiteral expr) {
		head.visit_map_literal (expr);
	}

	public override void visit_tuple (Tuple expr) {
		head.visit_tuple (expr);
	}

	public override void visit_regex_literal (RegexLiteral expr) {
		head.visit_regex_literal (expr);
	}


	public override void visit_null_literal (NullLiteral expr) {
		head.visit_null_literal (expr);
	}

	public override void visit_member_access (MemberAccess expr) {
		head.visit_member_access (expr);
	}

	public override void visit_method_call (MethodCall expr) {
		head.visit_method_call (expr);
	}
	
	public override void visit_element_access (ElementAccess expr) {
		head.visit_element_access (expr);
	}

	public override void visit_slice_expression (SliceExpression expr) {
		head.visit_slice_expression (expr);
	}

	public override void visit_base_access (BaseAccess expr) {
		head.visit_base_access (expr);
	}

	public override void visit_postfix_expression (PostfixExpression expr) {
		head.visit_postfix_expression (expr);
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		head.visit_object_creation_expression (expr);
	}

	public override void visit_sizeof_expression (SizeofExpression expr) {
		head.visit_sizeof_expression (expr);
	}

	public override void visit_typeof_expression (TypeofExpression expr) {
		head.visit_typeof_expression (expr);
	}

	public override void visit_unary_expression (UnaryExpression expr) {
		head.visit_unary_expression (expr);
	}

	public override void visit_cast_expression (CastExpression expr) {
		head.visit_cast_expression (expr);
	}

	public override void visit_named_argument (NamedArgument expr) {
		head.visit_named_argument (expr);
	}

	public override void visit_pointer_indirection (PointerIndirection expr) {
		head.visit_pointer_indirection (expr);
	}

	public override void visit_addressof_expression (AddressofExpression expr) {
		head.visit_addressof_expression (expr);
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		head.visit_reference_transfer_expression (expr);
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		head.visit_binary_expression (expr);
	}

	public override void visit_type_check (TypeCheck expr) {
		head.visit_type_check (expr);
	}

	public override void visit_lambda_expression (LambdaExpression l) {
		head.visit_lambda_expression (l);
	}

	public override void visit_assignment (Assignment a) {
		head.visit_assignment (a);
	}
}
