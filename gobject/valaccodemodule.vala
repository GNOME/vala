/* valaccodemodule.vala
 *
 * Copyright (C) 2008-2009  Jürg Billeter
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

using Gee;

/**
 * Code visitor generating C Code.
 */
public abstract class Vala.CCodeModule {
	public weak CCodeGenerator codegen { get; private set; }
	
	public CCodeModule head {
		get { return _head; }
		private set {
			_head = value;
			// propagate head property to all modules
			if (next != null) {
				next.head = value;
			}
		}
	}

	weak CCodeModule _head;
	CCodeModule? next;

	public CCodeModule (CCodeGenerator codegen, CCodeModule? next) {
		this.codegen = codegen;
		this.next = next;
		this.head = this;
	}

	public virtual void emit (CodeContext context) {
		next.emit (context);
	}

	public virtual void visit_source_file (SourceFile source_file) {
		next.visit_source_file (source_file);
	}

	public virtual void visit_class (Class cl) {
		next.visit_class (cl);
	}

	public virtual void visit_interface (Interface iface) {
		next.visit_interface (iface);
	}

	public virtual void visit_struct (Struct st) {
		next.visit_struct (st);
	}

	public virtual void visit_enum (Enum en) {
		next.visit_enum (en);
	}

	public virtual void visit_enum_value (EnumValue ev) {
		next.visit_enum_value (ev);
	}

	public virtual void visit_error_domain (ErrorDomain edomain) {
		next.visit_error_domain (edomain);
	}

	public virtual void visit_error_code (ErrorCode ecode) {
		next.visit_error_code (ecode);
	}

	public virtual void visit_delegate (Delegate d) {
		next.visit_delegate (d);
	}
	
	public virtual void visit_member (Member m) {
		next.visit_member (m);
	}

	public virtual void visit_constant (Constant c) {
		next.visit_constant (c);
	}

	public virtual void visit_field (Field f) {
		next.visit_field (f);
	}

	public virtual void visit_method (Method m) {
		next.visit_method (m);
	}

	public virtual void visit_creation_method (CreationMethod m) {
		next.visit_creation_method (m);
	}

	public virtual void visit_formal_parameter (FormalParameter p) {
		next.visit_formal_parameter (p);
	}

	public virtual void visit_property (Property prop) {
		next.visit_property (prop);
	}

	public virtual void visit_property_accessor (PropertyAccessor acc) {
		next.visit_property_accessor (acc);
	}

	public virtual void visit_signal (Signal sig) {
		next.visit_signal (sig);
	}

	public virtual void visit_constructor (Constructor c) {
		next.visit_constructor (c);
	}

	public virtual void visit_destructor (Destructor d) {
		next.visit_destructor (d);
	}

	public virtual void visit_block (Block b) {
		next.visit_block (b);
	}

	public virtual void visit_empty_statement (EmptyStatement stmt) {
		next.visit_empty_statement (stmt);
	}

	public virtual void visit_declaration_statement (DeclarationStatement stmt) {
		next.visit_declaration_statement (stmt);
	}

	public virtual void visit_local_variable (LocalVariable local) {
		next.visit_local_variable (local);
	}

	public virtual void visit_initializer_list (InitializerList list) {
		next.visit_initializer_list (list);
	}

	public virtual void visit_end_full_expression (Expression expr) {
		next.visit_end_full_expression (expr);
	}
	
	public virtual void visit_expression_statement (ExpressionStatement stmt) {
		next.visit_expression_statement (stmt);
	}

	public virtual void visit_if_statement (IfStatement stmt) {
		next.visit_if_statement (stmt);
	}

	public virtual void visit_switch_statement (SwitchStatement stmt) {
		next.visit_switch_statement (stmt);
	}

	public virtual void visit_switch_section (SwitchSection section) {
		next.visit_switch_section (section);
	}

	public virtual void visit_switch_label (SwitchLabel label) {
		next.visit_switch_label (label);
	}

	public virtual void visit_while_statement (WhileStatement stmt) {
		next.visit_while_statement (stmt);
	}

	public virtual void visit_do_statement (DoStatement stmt) {
		next.visit_do_statement (stmt);
	}

	public virtual void visit_for_statement (ForStatement stmt) {
		next.visit_for_statement (stmt);
	}

	public virtual void visit_foreach_statement (ForeachStatement stmt) {
		next.visit_foreach_statement (stmt);
	}

	public virtual void visit_break_statement (BreakStatement stmt) {
		next.visit_break_statement (stmt);
	}

	public virtual void visit_continue_statement (ContinueStatement stmt) {
		next.visit_continue_statement (stmt);
	}

	public virtual void visit_return_statement (ReturnStatement stmt) {
		next.visit_return_statement (stmt);
	}

	public virtual void visit_yield_statement (YieldStatement stmt) {
		next.visit_yield_statement (stmt);
	}

	public virtual void visit_throw_statement (ThrowStatement stmt) {
		next.visit_throw_statement (stmt);
	}

	public virtual void visit_try_statement (TryStatement stmt) {
		next.visit_try_statement (stmt);
	}

	public virtual void visit_catch_clause (CatchClause clause) {
		next.visit_catch_clause (clause);
	}

	public virtual void visit_lock_statement (LockStatement stmt) {
		next.visit_lock_statement (stmt);
	}

	public virtual void visit_delete_statement (DeleteStatement stmt) {
		next.visit_delete_statement (stmt);
	}

	public virtual void visit_expression (Expression expr) {
		next.visit_expression (expr);
	}

	public virtual void visit_array_creation_expression (ArrayCreationExpression expr) {
		next.visit_array_creation_expression (expr);
	}

	public virtual void visit_boolean_literal (BooleanLiteral expr) {
		next.visit_boolean_literal (expr);
	}

	public virtual void visit_character_literal (CharacterLiteral expr) {
		next.visit_character_literal (expr);
	}

	public virtual void visit_integer_literal (IntegerLiteral expr) {
		next.visit_integer_literal (expr);
	}

	public virtual void visit_real_literal (RealLiteral expr) {
		next.visit_real_literal (expr);
	}

	public virtual void visit_string_literal (StringLiteral expr) {
		next.visit_string_literal (expr);
	}

	public virtual void visit_null_literal (NullLiteral expr) {
		next.visit_null_literal (expr);
	}

	public virtual void visit_parenthesized_expression (ParenthesizedExpression expr) {
		next.visit_parenthesized_expression (expr);
	}

	public virtual void visit_member_access (MemberAccess expr) {
		next.visit_member_access (expr);
	}

	public virtual void visit_method_call (MethodCall expr) {
		next.visit_method_call (expr);
	}
	
	public virtual void visit_element_access (ElementAccess expr) {
		next.visit_element_access (expr);
	}

	public virtual void visit_base_access (BaseAccess expr) {
		next.visit_base_access (expr);
	}

	public virtual void visit_postfix_expression (PostfixExpression expr) {
		next.visit_postfix_expression (expr);
	}

	public virtual void visit_object_creation_expression (ObjectCreationExpression expr) {
		next.visit_object_creation_expression (expr);
	}

	public virtual void visit_sizeof_expression (SizeofExpression expr) {
		next.visit_sizeof_expression (expr);
	}

	public virtual void visit_typeof_expression (TypeofExpression expr) {
		next.visit_typeof_expression (expr);
	}

	public virtual void visit_unary_expression (UnaryExpression expr) {
		next.visit_unary_expression (expr);
	}

	public virtual void visit_cast_expression (CastExpression expr) {
		next.visit_cast_expression (expr);
	}
	
	public virtual void visit_pointer_indirection (PointerIndirection expr) {
		next.visit_pointer_indirection (expr);
	}

	public virtual void visit_addressof_expression (AddressofExpression expr) {
		next.visit_addressof_expression (expr);
	}

	public virtual void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		next.visit_reference_transfer_expression (expr);
	}

	public virtual void visit_binary_expression (BinaryExpression expr) {
		next.visit_binary_expression (expr);
	}

	public virtual void visit_type_check (TypeCheck expr) {
		next.visit_type_check (expr);
	}

	public virtual void visit_lambda_expression (LambdaExpression l) {
		next.visit_lambda_expression (l);
	}

	public virtual void visit_assignment (Assignment a) {
		next.visit_assignment (a);
	}

	public virtual void generate_cparameters (Method m, DataType creturn_type, bool in_gtypeinstance_creation_method, Map<int,CCodeFormalParameter> cparam_map, CCodeFunction func, CCodeFunctionDeclarator? vdeclarator = null, Map<int,CCodeExpression>? carg_map = null, CCodeFunctionCall? vcall = null, int direction = 3) {
		next.generate_cparameters (m, creturn_type, in_gtypeinstance_creation_method, cparam_map, func, vdeclarator, carg_map, vcall, direction);
	}

	public virtual string? get_custom_creturn_type (Method m) {
		return next.get_custom_creturn_type (m);
	}

	public virtual void generate_dynamic_method_wrapper (DynamicMethod method) {
		next.generate_dynamic_method_wrapper (method);
	}

	public virtual bool method_has_wrapper (Method method) {
		return next.method_has_wrapper (method);
	}

	public virtual CCodeIdentifier get_value_setter_function (DataType type_reference) {
		return next.get_value_setter_function (type_reference);
	}

	public virtual CCodeExpression get_construct_property_assignment (CCodeConstant canonical_cconstant, DataType property_type, CCodeExpression value) {
		return next.get_construct_property_assignment (canonical_cconstant, property_type, value);
	}

	public virtual CCodeFunctionCall get_param_spec (Property prop) {
		return next.get_param_spec (prop);
	}

	public virtual CCodeFunctionCall get_signal_creation (Signal sig, TypeSymbol type) {
		return next.get_signal_creation (sig, type);
	}

	public virtual CCodeFragment register_dbus_info (ObjectTypeSymbol bindable) {
		return next.register_dbus_info (bindable);
	}

	public virtual string get_dynamic_property_getter_cname (DynamicProperty node) {
		return next.get_dynamic_property_getter_cname (node);
	}

	public virtual string get_dynamic_property_setter_cname (DynamicProperty node) {
		return next.get_dynamic_property_setter_cname (node);
	}

	public virtual string get_dynamic_signal_cname (DynamicSignal node) {
		return next.get_dynamic_signal_cname (node);
	}

	public virtual string get_dynamic_signal_connect_wrapper_name (DynamicSignal node) {
		return next.get_dynamic_signal_connect_wrapper_name (node);
	}

	public virtual string get_dynamic_signal_disconnect_wrapper_name (DynamicSignal node) {
		return next.get_dynamic_signal_disconnect_wrapper_name (node);
	}

	public virtual void generate_marshaller (Gee.List<FormalParameter> params, DataType return_type, bool dbus = false) {
		next.generate_marshaller (params, return_type, dbus);
	}
	
	public virtual string get_marshaller_function (Gee.List<FormalParameter> params, DataType return_type, string? prefix = null, bool dbus = false) {
		return next.get_marshaller_function (params, return_type, prefix, dbus);
	}

	public virtual string get_array_length_cname (string array_cname, int dim) {
		return next.get_array_length_cname (array_cname, dim);
	}

	public virtual CCodeExpression get_array_length_cexpression (Expression array_expr, int dim = -1) {
		return next.get_array_length_cexpression (array_expr, dim);
	}

	public virtual string get_array_size_cname (string array_cname) {
		return next.get_array_size_cname (array_cname);
	}

	public virtual CCodeExpression get_array_size_cexpression (Expression array_expr) {
		return next.get_array_size_cexpression (array_expr);
	}

	public virtual void add_simple_check (CodeNode node, CCodeFragment cfrag) {
		next.add_simple_check (node, cfrag);
	}
}
