
public class Vala.AstPrinter : CodeVisitor {
	private CodeContext context;
	private int level = 0;

	private void print (string msg) {
		for (int i = 0; i < level; i ++)
			stdout.printf ("    ");

		stdout.printf ("%s\n", msg);
	}

	public AstPrinter () {
	}

	public void print_ast (CodeContext context) {
		this.context = context;
		context.accept (this);
	}


	public override void visit_namespace (Namespace ns) {
		print ("Namespace %s".printf (ns.name));

		level ++;
		ns.accept_children (this);
		level --;
	}

	public override void visit_method (Method m) {
		print ("Method %s".printf (m.name));
		m.accept_children (this);
	}

	public override void visit_source_file (SourceFile source_file) {
	}
	public override void visit_class (Class cl) {
	}
	public override void visit_struct (Struct st) {
	}

	public override void visit_interface (Interface iface) {}

	public override void visit_enum (Enum en) {
	}
	public override void visit_enum_value (EnumValue ev) {
	}

	public override void visit_error_domain (ErrorDomain edomain) {
	}
	public override void visit_error_code (ErrorCode ecode) {
	}

	public override void visit_constant (Constant c) {
	}
	public override void visit_field (Field f) {
	}

	public override void visit_creation_method (CreationMethod m) {
	}

	public override void visit_formal_parameter (Parameter p) {
	}

	public override void visit_property (Property prop) {
	}


	public override void visit_property_accessor (PropertyAccessor acc) {
	}

	public override void visit_signal (Signal sig) {
	}


	public override void visit_constructor (Constructor c) {
	}

	public override void visit_destructor (Destructor d) {
	}

	public override void visit_type_parameter (TypeParameter p) {
	}

	public override void visit_using_directive (UsingDirective ns) {
	}

	public override void visit_data_type (DataType type) {
	}


	public override void visit_block (Block b) {
		level ++;
		b.accept_children (this);
		level --;
	}


	public override void visit_empty_statement (EmptyStatement stmt) {
	}


	public override void visit_declaration_statement (DeclarationStatement stmt) {
		DataType? symbol_type = context.analyzer.get_value_type_for_symbol (stmt.declaration, false);

		string type = symbol_type != null ? symbol_type.to_qualified_string () : "??";
		print ("Declaration: %s %s".printf (type, stmt.declaration.name));
		level ++;
		stmt.accept_children (this);
		level --;
	}


	public override void visit_local_variable (LocalVariable local) {
		print ("Local Var %s %s".printf (local.variable_type.to_string (), local.name));

		if (local.initializer != null) {
			print ("Initializer: %s".printf (local.initializer.type_name));
			level ++;
			local.initializer.accept (this);
			level --;
		}
	}

	public override void visit_initializer_list (InitializerList list) {
	}


	public override void visit_expression_statement (ExpressionStatement stmt) {
		print ("ExpressionStatement");
		level ++;
		stmt.accept_children (this);
		level --;
	}

	public override void visit_if_statement (IfStatement stmt) {
		print ("If");
		level ++;
		stmt.condition.accept (this);
		level --;

		print ("True Block");
		level ++;
		stmt.true_statement.accept (this);
		level --;
		if (stmt.false_statement != null) {
			print ("False Block");
			level ++;
			stmt.false_statement.accept (this);
			level --;
		}
	}


	public override void visit_switch_statement (SwitchStatement stmt) {
	}

	public override void visit_switch_section (SwitchSection section) {
	}


	public override void visit_switch_label (SwitchLabel label) {
	}

	public override void visit_loop (Loop stmt) {
	}

	public override void visit_while_statement (WhileStatement stmt) {
	}

	public override void visit_do_statement (DoStatement stmt) {
	}


	public override void visit_for_statement (ForStatement stmt) {
	}


	public override void visit_foreach_statement (ForeachStatement stmt) {
	}


	public override void visit_break_statement (BreakStatement stmt) {
	}


	public override void visit_continue_statement (ContinueStatement stmt) {
	}

	public override void visit_return_statement (ReturnStatement stmt) {
	}


	public override void visit_yield_statement (YieldStatement y) {
	}


	public override void visit_throw_statement (ThrowStatement stmt) {
	}


	public override void visit_try_statement (TryStatement stmt) {
	}


	public override void visit_catch_clause (CatchClause clause) {
	}


	public override void visit_lock_statement (LockStatement stmt) {
	}

	public override void visit_unlock_statement (UnlockStatement stmt) {
	}

	public override void visit_delete_statement (DeleteStatement stmt) {
	}

	public override void visit_expression (Expression expr) {
		//print ("Expression %s (value_type: %s, target_type: %s, constant: %s, non_null: %s)"
			   //.printf (expr.type_name, type_str (expr.value_type), type_str (expr.target_type),
						//expr.is_constant ().to_string (), expr.is_non_null ().to_string ()));
	}

	public override void visit_array_creation_expression (ArrayCreationExpression expr) {
	}


	public override void visit_boolean_literal (BooleanLiteral lit) {
	}


	public override void visit_character_literal (CharacterLiteral lit) {
	}


	public override void visit_integer_literal (IntegerLiteral lit) {
	}

	public override void visit_real_literal (RealLiteral lit) {
	}

	public override void visit_regex_literal (RegexLiteral lit) {
	}



	public override void visit_string_literal (StringLiteral lit) {
	}


	public override void visit_template (Template tmpl) {
	}

	public override void visit_tuple (Tuple tuple) {
	}


	public override void visit_null_literal (NullLiteral lit) {
	}


	public override void visit_member_access (MemberAccess expr) {
		print ("MemberAccess (%s), Inner: %s".printf (expr.member_name,
		                                              expr.inner != null ? expr.inner.type_name : "null"));
		level ++;
		expr.accept_children (this);
		level --;
	}


	public override void visit_method_call (MethodCall expr) {
	}


	public override void visit_element_access (ElementAccess expr) {
	}


	public override void visit_slice_expression (SliceExpression expr) {
	}

	public override void visit_base_access (BaseAccess expr) {
	}


	public override void visit_postfix_expression (PostfixExpression expr) {
	}


	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
	}


	public override void visit_sizeof_expression (SizeofExpression expr) {
	}


	public override void visit_typeof_expression (TypeofExpression expr) {
	}


	public override void visit_unary_expression (UnaryExpression expr) {
	}

	public override void visit_cast_expression (CastExpression expr) {
	}

	public override void visit_named_argument (NamedArgument expr) {
	}

	public override void visit_addressof_expression (AddressofExpression expr) {
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		print ("Binary Expr (op: %s, non_null: %s, constant: %s)".printf (expr.get_operator_string (), expr.is_non_null ().to_string (), expr.is_constant ().to_string ()));
		print ("Nullability: %s".printf (expr.get_null_state ().to_string ()));

		print ("Left: %s (%s)".printf (expr.left.to_string (), expr.left.type_name));
		level ++;
		expr.left.accept (this);
		level --;


		print ("Right: %s (%s)".printf (expr.right.to_string (), expr.right.type_name));
		level ++;
		expr.right.accept (this);
		level --;
	}

	public override void visit_type_check (TypeCheck expr) {
	}

	public override void visit_conditional_expression (ConditionalExpression expr) {
	}

	public override void visit_lambda_expression (LambdaExpression expr) {
	}

	public override void visit_assignment (Assignment a) {
		print ("Assignment");
		print ("From %s".printf (a.right.type_name));
		level ++;
		a.right.accept (this);
		level --;

		  print ("To %s".printf (a.left.type_name));
		level ++;
		a.left.accept (this);
		level --;
		//print ("Assignment from %s to %s".printf (a.left.type_name, a.right.type_name));
	}

	public override void visit_end_full_expression (Expression expr) {
	}

}
