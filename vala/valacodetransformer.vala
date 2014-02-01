/* valacodetransformer.vala
 *
 * Copyright (C) 2011  Luca Bruno
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
	public weak CodeContext context { get; private set; }

	public CodeBuilder b { get; private set; }

	ArrayList<CodeBuilder> builder_stack = new ArrayList<CodeBuilder> ();
	Map<weak CodeBuilder, void*> builder_data = new HashMap<weak CodeBuilder, void*> ();
	Map<string, CodeNode> wrapper_cache;

	// Keep tracks of generated and visited stuff to avoid cycles
	Set<CodeNode> unit_generated = new HashSet<CodeNode> ();
	Set<weak CodeNode> visited = new HashSet<weak CodeNode> ();

	public void push_builder (CodeBuilder builder) {
		builder_stack.add (b);
		b = builder;
	}

	public void pop_builder () {
		b.cleanup ();
		b = builder_stack.remove_at (builder_stack.size - 1);
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
		builder_data.set (b, (void*) (owned) data);
	}

	public void end_replace_statement () {
		var data = (ReplaceStatementData) builder_data.get (b);
		builder_data.remove (b);

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
		builder_data.set (b, (void*) (owned) data);
	}

	public void end_replace_expression (Expression? replacement) {
		var data = (ReplaceExpressionData) builder_data.get (b);
		builder_data.remove (b);

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

		this.context = null;
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
		return "_vala_func_"+CodeNode.get_temp_name ().substring (1);
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

	public Expression expression (string str) {
		return b.expression (str);
	}

	public void statements (string str) {
		b.statements (str);
	}

	public void check (CodeNode node) {
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

	public Expression stringify (Expression expr) {
		if (expr.value_type != null && expr.value_type.type_symbol != null && expr.value_type.type_symbol.is_subtype_of (context.analyzer.string_type.type_symbol)) {
			return expr;
		} else {
			return expression (@"$expr.to_string ()");
		}
	}

	public override void visit_addressof_expression (Vala.AddressofExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_array_creation_expression (Vala.ArrayCreationExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_assignment (Vala.Assignment a) {
		a.accept_children (this);
	}

	public override void visit_base_access (Vala.BaseAccess expr) {
		expr.accept_children (this);
	}

	public override void visit_binary_expression (Vala.BinaryExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_block (Vala.Block b) {
		b.accept_children (this);
	}

	public override void visit_boolean_literal (Vala.BooleanLiteral lit) {
		lit.accept_children (this);
	}

	public override void visit_break_statement (Vala.BreakStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_cast_expression (Vala.CastExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_catch_clause (Vala.CatchClause clause) {
		clause.accept_children (this);
	}

	public override void visit_character_literal (Vala.CharacterLiteral lit) {
		lit.accept_children (this);
	}

	public override void visit_class (Vala.Class cl) {
		cl.accept_children (this);
	}

	public override void visit_conditional_expression (Vala.ConditionalExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_constant (Vala.Constant c) {
		c.accept_children (this);
	}

	public override void visit_constructor (Vala.Constructor c) {
		c.accept_children (this);
	}

	public override void visit_continue_statement (Vala.ContinueStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_creation_method (Vala.CreationMethod m) {
		m.accept_children (this);
	}

	public override void visit_data_type (Vala.DataType type) {
		type.accept_children (this);
	}

	public override void visit_declaration_statement (Vala.DeclarationStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_delegate (Vala.Delegate d) {
		d.accept_children (this);
	}

	public override void visit_delete_statement (Vala.DeleteStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_destructor (Vala.Destructor d) {
		d.accept_children (this);
	}

	public override void visit_do_statement (Vala.DoStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_element_access (Vala.ElementAccess expr) {
		expr.accept_children (this);
	}

	public override void visit_empty_statement (Vala.EmptyStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_end_full_expression (Vala.Expression expr) {
		expr.accept_children (this);
	}

	public override void visit_enum (Vala.Enum en) {
		en.accept_children (this);
	}

	public override void visit_enum_value (Vala.EnumValue ev) {
		ev.accept_children (this);
	}

	public override void visit_error_code (Vala.ErrorCode ecode) {
		ecode.accept_children (this);
	}

	public override void visit_error_domain (Vala.ErrorDomain edomain) {
		edomain.accept_children (this);
	}

	public override void visit_expression (Vala.Expression expr) {
		if (expr in visited) {
			return;
		}
		visited.add (expr);

		expr.accept_children (this);
	}

	public override void visit_expression_statement (Vala.ExpressionStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_field (Vala.Field f) {
		f.accept_children (this);
	}

	public override void visit_for_statement (Vala.ForStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_foreach_statement (Vala.ForeachStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_formal_parameter (Vala.Parameter p) {
		p.accept_children (this);
	}

	public override void visit_if_statement (Vala.IfStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_initializer_list (Vala.InitializerList list) {
		list.accept_children (this);
	}

	public override void visit_integer_literal (Vala.IntegerLiteral lit) {
		lit.accept_children (this);
	}

	public override void visit_interface (Vala.Interface iface) {
		iface.accept_children (this);
	}

	public override void visit_lambda_expression (Vala.LambdaExpression expr) {
		if (expr in visited) {
			return;
		}
		visited.add (expr);

		expr.accept_children (this);
	}

	public override void visit_local_variable (Vala.LocalVariable local) {
		local.accept_children (this);
	}

	public override void visit_lock_statement (Vala.LockStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_loop (Vala.Loop stmt) {
		stmt.accept_children (this);
	}

	public override void visit_member_access (Vala.MemberAccess expr) {
		expr.accept_children (this);
	}

	public override void visit_method (Vala.Method m) {
		m.accept_children (this);
	}

	public override void visit_method_call (Vala.MethodCall expr) {
		expr.accept_children (this);
	}

	public override void visit_named_argument (Vala.NamedArgument expr) {
		expr.accept_children (this);
	}

	public override void visit_namespace (Vala.Namespace ns) {
		ns.accept_children (this);
	}

	public override void visit_null_literal (Vala.NullLiteral lit) {
		lit.accept_children (this);
	}

	public override void visit_object_creation_expression (Vala.ObjectCreationExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_pointer_indirection (Vala.PointerIndirection expr) {
		expr.accept_children (this);
	}

	public override void visit_postfix_expression (Vala.PostfixExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_property (Vala.Property prop) {
		prop.accept_children (this);
	}

	public override void visit_property_accessor (Vala.PropertyAccessor acc) {
		acc.accept_children (this);
	}

	public override void visit_real_literal (Vala.RealLiteral lit) {
		lit.accept_children (this);
	}

	public override void visit_reference_transfer_expression (Vala.ReferenceTransferExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_regex_literal (Vala.RegexLiteral lit) {
		lit.accept_children (this);
	}

	public override void visit_return_statement (Vala.ReturnStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_signal (Vala.Signal sig) {
		sig.accept_children (this);
	}

	public override void visit_sizeof_expression (Vala.SizeofExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_slice_expression (Vala.SliceExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_source_file (Vala.SourceFile source_file) {
		source_file.accept_children (this);
	}

	public override void visit_string_literal (Vala.StringLiteral lit) {
		lit.accept_children (this);
	}

	public override void visit_struct (Vala.Struct st) {
		st.accept_children (this);
	}

	public override void visit_switch_label (Vala.SwitchLabel label) {
		label.accept_children (this);
	}

	public override void visit_switch_section (Vala.SwitchSection section) {
		section.accept_children (this);
	}

	public override void visit_switch_statement (Vala.SwitchStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_template (Vala.Template tmpl) {
		tmpl.accept_children (this);
	}

	public override void visit_throw_statement (Vala.ThrowStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_try_statement (Vala.TryStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_tuple (Vala.Tuple tuple) {
		tuple.accept_children (this);
	}

	public override void visit_type_check (Vala.TypeCheck expr) {
		expr.accept_children (this);
	}

	public override void visit_type_parameter (Vala.TypeParameter p) {
		p.accept_children (this);
	}

	public override void visit_typeof_expression (Vala.TypeofExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_unary_expression (Vala.UnaryExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_unlock_statement (Vala.UnlockStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_while_statement (Vala.WhileStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_yield_statement (Vala.YieldStatement y) {
		y.accept_children (this);
	}
}
