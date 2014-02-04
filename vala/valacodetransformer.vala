/* valacodetransformer.vala
 *
 * Copyright (C) 2011-2014  Luca Bruno
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
 * 	Luca Bruno <lucabru@src.gnome.org>
 */

/**
 * Code visitor for transforming the code tree.
 */
public class Vala.CodeTransformer : CodeVisitor {
	public CodeContext context;

	public CodeBuilder b;
	public ArrayList<CodeBuilder> builder_stack = new ArrayList<CodeBuilder> ();
	public HashMap<string, CodeNode> wrapper_cache;
	/* Keep tracks of generated stuff to avoid cycles */
	public HashSet<CodeNode> unit_generated = new HashSet<CodeNode> ();

	public Namespace current_namespace = null;

	public weak CodeTransformer head;
	public CodeTransformer next;

	public void push_builder (CodeBuilder builder) {
		builder_stack.add (b);
		b = builder;
	}

	public void pop_builder () {
		b.cleanup ();

		b = builder_stack[builder_stack.size - 1];
		builder_stack.remove_at (builder_stack.size - 1);
	}

	class ReplaceStatementData {
		internal Statement stmt;
		internal Block parent_block;
	}

	public void begin_replace_statement (Statement stmt) {
		push_builder (new CodeBuilder (context, stmt, stmt.source_reference));

		var data = new ReplaceStatementData ();
		data.stmt = stmt;
		data.parent_block = context.analyzer.get_current_block (stmt);
		b.data = (owned) data;
	}

	public void end_replace_statement () {
		var data = (ReplaceStatementData) (owned) b.data;

		context.analyzer.replaced_nodes.add (data.stmt);
		data.parent_block.replace_statement (data.stmt, new EmptyStatement (data.stmt.source_reference));

		b.check (this);
		pop_builder ();
	}

	class ReplaceExpressionData {
		internal Expression expr;
		internal CodeNode parent_node;
	}

	public void begin_replace_expression (owned Expression expr) {
		push_builder (new CodeBuilder (context, expr.parent_statement, expr.source_reference));

		var data = new ReplaceExpressionData ();
		data.expr = expr;
		data.parent_node = expr.parent_node;
		b.data = (owned) data;
	}

	public void end_replace_expression (Expression? replacement) {
		var data = (ReplaceExpressionData) (owned) b.data;

		if (replacement != null) {
			context.analyzer.replaced_nodes.add (data.expr);
			data.parent_node.replace_expression (data.expr, replacement);
			b.check (this);
		}
		pop_builder ();
		if (replacement != null) {
			check (replacement);
		}
	}

	/**
	 * Transform the code tree for the specified code context.
	 *
	 * @param context a code context
	 */
	public void transform (CodeContext context) {
		this.context = context;
		/* we're only interested in non-pkg source files */
		var source_files = context.get_source_files ();
		foreach (SourceFile file in source_files) {
			/* clear wrapper cache for every file */
			wrapper_cache = new HashMap<string, CodeNode> (str_hash, str_equal);
			file.accept (this);
		}
	}

	public static DataType? copy_type (DataType? type, bool? value_owned = null, bool? nullable = null) {
		if (type == null) {
			return null;
		}

		var ret = type.copy ();
		if (value_owned != null) {
			ret.value_owned = value_owned;
		}
		if (nullable != null) {
			ret.nullable = nullable;
		}
		return ret;
	}

	// Create an access to a temporary variable, with proper reference transfer if needed to avoid unnecessary copies
	public Expression return_temp_access (string local, DataType value_type, DataType? target_type, DataType? formal_target_type = null) {
		Expression temp_access = new MemberAccess.simple (local, b.source_reference);

		var target_owned = target_type != null && target_type.value_owned;
		if (target_owned && value_type.is_disposable ()) {
			temp_access = new ReferenceTransferExpression (temp_access, b.source_reference);
			temp_access.target_type = target_type != null ? target_type.copy () : value_type.copy ();
			temp_access.target_type.value_owned = true;
			temp_access.formal_target_type = copy_type (formal_target_type);
		} else {
			temp_access.target_type = copy_type (target_type);
		}

		return temp_access;
	}

	public bool get_cached_wrapper (string key, out CodeNode node) {
		node = wrapper_cache.get (key);
		return node != null;
	}

	public void add_cached_wrapper (string key, CodeNode node) {
		wrapper_cache.set (key, node);
	}

	public string temp_func_cname () {
		return "_vala_func_" + CodeNode.get_temp_name ().substring (1);
	}

	public bool wrapper_method (DataType return_type, string? cache_key, out Method m, Symbol? parent = null) {
		CodeNode n = null;
		if (cache_key != null && get_cached_wrapper (cache_key, out n)) {
			m = (Method) n;
			return true;
		}
		m = new Method (temp_func_cname (), return_type, b.source_reference);
		(parent == null ? context.root : parent).add_method (m);
		m.access = SymbolAccessibility.PRIVATE;
		add_cached_wrapper (cache_key, m);
		return false;
	}

	public Symbol symbol_from_string (string s) {
		return CodeBuilder.symbol_from_string (s);
	}

	public DataType data_type (string s, bool value_owned = true, bool nullable = false) {
		return CodeBuilder.data_type (s, value_owned, nullable);
	}

	public Expression expression (string str, Expression[]? replacements = null) {
		return b.expression (str, replacements);
	}

	public void statements (string str, owned Expression[]? replacements = null) {
		b.statements (str, (owned) replacements);
	}

	public void check (CodeNode node) {
		var sym = context.analyzer.get_current_symbol (node);
		if (sym != null) {
			context.resolver.current_scope = sym.scope;
		}
		node.accept (context.resolver);
		if (!node.check (context)) {
			return;
		}
		node.accept (this);
	}

	public bool is_visited (CodeNode node) {
		var file = node.source_reference.file;
		return file.file_type == SourceFileType.SOURCE || (context.header_filename != null && file.file_type == SourceFileType.FAST);
	}

	public void accept_external (CodeNode node) {
		if (node.source_reference != null) {
			if (!is_visited (node) && !unit_generated.contains (node)) {
				unit_generated.add (node);
				check (node);
			}
		}
	}

	public bool always_true (Expression condition) {
		var literal = condition as BooleanLiteral;
		return (literal != null && literal.value);
	}

	public bool always_false (Expression condition) {
		var literal = condition as BooleanLiteral;
		return (literal != null && !literal.value);
	}

	public Expression stringify (Expression expr) {
		if (expr.value_type.data_type != null && expr.value_type.data_type.is_subtype_of (context.analyzer.string_type.data_type)) {
			return expr;
		} else {
			return expression (@"%?.to_string ()", {expr});
		}
	}

	/////////////

	public override void visit_source_file (SourceFile source_file) {
		next.visit_source_file (source_file);
	}

	public override void visit_class (Class cl) {
		next.visit_class (cl);
	}

	public override void visit_struct (Struct st) {
		next.visit_struct (st);
	}

	public override void visit_interface (Interface iface) {
		next.visit_interface (iface);
	}

	public override void visit_enum (Enum en) {
		next.visit_enum (en);
	}

	public override void visit_enum_value (EnumValue ev) {
		next.visit_enum_value (ev);
	}

	public override void visit_error_domain (ErrorDomain edomain) {
		next.visit_error_domain (edomain);
	}

	public override void visit_error_code (ErrorCode ecode) {
		next.visit_error_code (ecode);
	}

	public override void visit_delegate (Delegate d) {
		next.visit_delegate (d);
	}

	public override void visit_constant (Constant c) {
		next.visit_constant (c);
	}

	public override void visit_field (Field f) {
		next.visit_field (f);
	}

	public override void visit_method (Method m) {
		next.visit_method (m);
	}

	public override void visit_creation_method (CreationMethod m) {
		next.visit_creation_method (m);
	}

	public override void visit_formal_parameter (Parameter p) {
		next.visit_formal_parameter (p);
	}

	public override void visit_property (Property prop) {
		next.visit_property (prop);
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		next.visit_property_accessor (acc);
	}

	public override void visit_signal (Signal sig) {
		next.visit_signal (sig);
	}

	public override void visit_constructor (Constructor c) {
		next.visit_constructor (c);
	}

	public override void visit_destructor (Destructor d) {
		next.visit_destructor (d);
	}

	public override void visit_type_parameter (TypeParameter p) {
		next.visit_type_parameter (p);
	}

	public override void visit_using_directive (UsingDirective ns) {
		next.visit_using_directive (ns);
	}

	public override void visit_data_type (DataType type) {
		next.visit_data_type (type);
	}

	public override void visit_block (Block b) {
		next.visit_block (b);
	}

	public override void visit_empty_statement (EmptyStatement stmt) {
		next.visit_empty_statement (stmt);
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		next.visit_declaration_statement (stmt);
	}

	public override void visit_local_variable (LocalVariable local) {
		next.visit_local_variable (local);
	}

	public override void visit_initializer_list (InitializerList list) {
		next.visit_initializer_list (list);
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		next.visit_expression_statement (stmt);
	}

	public override void visit_if_statement (IfStatement stmt) {
		next.visit_if_statement (stmt);
	}

	public override void visit_switch_statement (SwitchStatement stmt) {
		next.visit_switch_statement (stmt);
	}

	public override void visit_switch_section (SwitchSection section) {
		next.visit_switch_section (section);
	}

	public override void visit_switch_label (SwitchLabel label) {
		next.visit_switch_label (label);
	}

	public override void visit_loop (Loop stmt) {
		next.visit_loop (stmt);
	}

	public override void visit_while_statement (WhileStatement stmt) {
		next.visit_while_statement (stmt);
	}

	public override void visit_do_statement (DoStatement stmt) {
		next.visit_do_statement (stmt);
	}

	public override void visit_for_statement (ForStatement stmt) {
		next.visit_for_statement (stmt);
	}

	public override void visit_foreach_statement (ForeachStatement stmt) {
		next.visit_foreach_statement (stmt);
	}

	public override void visit_break_statement (BreakStatement stmt) {
		next.visit_break_statement (stmt);
	}

	public override void visit_continue_statement (ContinueStatement stmt) {
		next.visit_continue_statement (stmt);
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		next.visit_return_statement (stmt);
	}

	public override void visit_yield_statement (YieldStatement y) {
		next.visit_yield_statement (y);
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		next.visit_throw_statement (stmt);
	}

	public override void visit_try_statement (TryStatement stmt) {
		next.visit_try_statement (stmt);
	}

	public override void visit_catch_clause (CatchClause clause) {
		next.visit_catch_clause (clause);
	}

	public override void visit_lock_statement (LockStatement stmt) {
		next.visit_lock_statement (stmt);
	}

	public override void visit_unlock_statement (UnlockStatement stmt) {
		next.visit_unlock_statement (stmt);
	}

	public override void visit_delete_statement (DeleteStatement stmt) {
		next.visit_delete_statement (stmt);
	}

	public override void visit_expression (Expression expr) {
		next.visit_expression (expr);
	}

	public override void visit_array_creation_expression (ArrayCreationExpression expr) {
		next.visit_array_creation_expression (expr);
	}

	public override void visit_boolean_literal (BooleanLiteral lit) {
		next.visit_boolean_literal (lit);
	}

	public override void visit_character_literal (CharacterLiteral lit) {
		next.visit_character_literal (lit);
	}

	public override void visit_integer_literal (IntegerLiteral lit) {
		next.visit_integer_literal (lit);
	}

	public override void visit_real_literal (RealLiteral lit) {
		next.visit_real_literal (lit);
	}

	public override void visit_regex_literal (RegexLiteral lit) {
		next.visit_regex_literal (lit);
	}

	public override void visit_string_literal (StringLiteral lit) {
		next.visit_string_literal (lit);
	}

	public override void visit_template (Template tmpl) {
		next.visit_template (tmpl);
	}

	public override void visit_tuple (Tuple tuple) {
		next.visit_tuple (tuple);
	}

	public override void visit_null_literal (NullLiteral lit) {
		next.visit_null_literal (lit);
	}

	public override void visit_member_access (MemberAccess expr) {
		next.visit_member_access (expr);
	}

	public override void visit_method_call (MethodCall expr) {
		next.visit_method_call (expr);
	}

	public override void visit_element_access (ElementAccess expr) {
		next.visit_element_access (expr);
	}

	public override void visit_slice_expression (SliceExpression expr) {
		next.visit_slice_expression (expr);
	}

	public override void visit_base_access (BaseAccess expr) {
		next.visit_base_access (expr);
	}

	public override void visit_postfix_expression (PostfixExpression expr) {
		next.visit_postfix_expression (expr);
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		next.visit_object_creation_expression (expr);
	}

	public override void visit_sizeof_expression (SizeofExpression expr) {
		next.visit_sizeof_expression (expr);
	}

	public override void visit_typeof_expression (TypeofExpression expr) {
		next.visit_typeof_expression (expr);
	}

	public override void visit_unary_expression (UnaryExpression expr) {
		next.visit_unary_expression (expr);
	}

	public override void visit_cast_expression (CastExpression expr) {
		next.visit_cast_expression (expr);
	}

	public override void visit_named_argument (NamedArgument expr) {
		next.visit_named_argument (expr);
	}

	public override void visit_pointer_indirection (PointerIndirection expr) {
		next.visit_pointer_indirection (expr);
	}

	public override void visit_addressof_expression (AddressofExpression expr) {
		next.visit_addressof_expression (expr);
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		next.visit_reference_transfer_expression (expr);
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		next.visit_binary_expression (expr);
	}

	public override void visit_type_check (TypeCheck expr) {
		next.visit_type_check (expr);
	}

	public override void visit_conditional_expression (ConditionalExpression expr) {
		next.visit_conditional_expression (expr);
	}

	public override void visit_lambda_expression (LambdaExpression expr) {
		next.visit_lambda_expression (expr);
	}

	public override void visit_assignment (Assignment a) {
		next.visit_assignment (a);
	}

	public override void visit_end_full_expression (Expression expr) {
		next.visit_end_full_expression (expr);
	}
}
