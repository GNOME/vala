/* valacodebuilder.vala
 *
 * Copyright (C) 2012  Luca Bruno
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

using GLib;

public class Vala.CodeBuilder {
	public SourceReference source_reference { get; private set; }

	Block current_block;
	Statement insert_statement;
	Block insert_block;
	ArrayList<Statement> statement_stack = new ArrayList<Statement> ();
	ArrayList<CodeNode> decl_nodes = new ArrayList<CodeNode> ();

	public CodeBuilder (CodeContext context, Statement insert_statement, SourceReference source_reference) {
		this.source_reference = source_reference;

		current_block = new Block (source_reference);
		current_block.owner = context.analyzer.get_current_symbol (insert_statement).scope;
		insert_block = context.analyzer.get_current_block (insert_statement);
		insert_block.insert_before (insert_statement, current_block);
		this.insert_statement = current_block;
	}

	public CodeBuilder.for_subroutine (Subroutine m) {
		source_reference = m.source_reference;
		insert_block = m.body = new Block (source_reference);
		insert_statement = current_block = new Block (source_reference);
		m.body.add_statement (current_block);
	}

	public void cleanup () {
		if (current_block.first_statement == null) {
			insert_block.remove_statement (current_block);
		}
	}

	public void check (CodeTransformer transformer) {
		foreach (var node in decl_nodes) {
			transformer.check (node);
		}
		transformer.check (current_block);
	}

	public void open_block () {
		statement_stack.add (current_block);
		var parent_block = current_block;

		current_block = new Block (source_reference);

		parent_block.add_statement (current_block);
	}

	public void open_if (Expression condition) {
		statement_stack.add (current_block);
		var parent_block = current_block;

		current_block = new Block (source_reference);

		var stmt = new IfStatement (condition, current_block, null, source_reference);
		statement_stack.add (stmt);

		parent_block.add_statement (stmt);
	}

	public void add_else () {
		current_block = new Block (source_reference);

		var stmt = (IfStatement) statement_stack[statement_stack.size-1];
		assert (stmt.false_statement == null);
		stmt.false_statement = current_block;
	}

	public void else_if (Expression condition) {
		var parent_if = (IfStatement) statement_stack[statement_stack.size - 1];
		assert (parent_if.false_statement == null);

		statement_stack.remove_at (statement_stack.size - 1);

		current_block = new Block (source_reference);

		var stmt = new IfStatement (condition, current_block, null, source_reference);
		var block = new Block (source_reference);
		block.add_statement (stmt);
		parent_if.false_statement = block;
		statement_stack.add (stmt);
	}

	public void open_loop () {
		statement_stack.add (current_block);
		var parent_block = current_block;

		current_block = new Block (source_reference);

		var stmt = new Loop (current_block, source_reference);
		parent_block.add_statement (stmt);
	}

	public void open_while (Expression condition) {
		statement_stack.add (current_block);
		var parent_block = current_block;

		current_block = new Block (source_reference);

		var stmt = new WhileStatement (condition, current_block, source_reference);
		parent_block.add_statement (stmt);
	}

	public void open_for (Expression? initializer, Expression condition, Expression? iterator) {
		statement_stack.add (current_block);
		var parent_block = current_block;

		current_block = new Block (source_reference);

		var stmt = new ForStatement (condition, current_block, source_reference);
		if (initializer != null) {
			stmt.add_initializer (initializer);
		}
		if (iterator != null) {
			stmt.add_iterator (iterator);
		}

		parent_block.add_statement (stmt);
	}

	public void open_switch (Expression expression, Expression? first_label) {
		var parent_block = current_block;

		var stmt = new SwitchStatement (expression, source_reference);
		statement_stack.add (stmt);

		var section = new SwitchSection (source_reference);
		SwitchLabel label;
		if (first_label == null) {
			label = new SwitchLabel.with_default (source_reference);
		} else {
			label = new SwitchLabel (first_label);
		}
		section.add_label (label);
		current_block = section;
		statement_stack.add (section);

		parent_block.add_statement (stmt);
		stmt.add_section (section);
	}

	public void add_section (Expression? expression) {
		statement_stack.remove_at (statement_stack.size - 1);

		var stmt = (SwitchStatement) statement_stack[statement_stack.size - 1];
		var section = new SwitchSection (source_reference);
		SwitchLabel label;
		if (expression == null) {
			label = new SwitchLabel.with_default (source_reference);
		} else {
			label = new SwitchLabel (expression);
		}
		section.add_label (label);
		current_block = section;
		statement_stack.add (section);

		stmt.add_section (section);
	}

	public void add_label (Expression? expression) {
		var section = (SwitchSection) statement_stack[statement_stack.size - 1];
		SwitchLabel label;
		if (expression == null) {
			label = new SwitchLabel.with_default (source_reference);
		} else {
			label = new SwitchLabel (expression);
		}
		section.add_label (label);
	}

	public void open_try () {
		statement_stack.add (current_block);
		var parent_block = current_block;

		current_block = new Block (source_reference);

		var stmt = new TryStatement (current_block, null, source_reference);
		statement_stack.add (stmt);

		parent_block.add_statement (stmt);
	}

	public void add_catch (DataType? error_type, string? variable_name) {
		current_block = new Block (source_reference);

		var stmt = (TryStatement) statement_stack[statement_stack.size-1];
		stmt.add_catch_clause (new CatchClause (error_type, variable_name, current_block, source_reference));
	}

	public void add_catch_all (string? variable_name) {
		add_catch (data_type ("GLib.Error"), variable_name);
	}

	public void add_catch_uncaught_error () {
		add_catch_all ("_uncaught_error_");
		add_expression (expression ("GLib.critical (_uncaught_error_.message)"));
		add_expression (expression ("GLib.critical (\"file %s: line %d: uncaught error: %s (%s, %d)\", GLib.Log.FILE, GLib.Log.LINE, _uncaught_error_.message, _uncaught_error_.domain.to_string(), _uncaught_error_.code)"));
	}

	public void add_statement (Statement statement) {
		current_block.add_statement (statement);
	}

	public void add_expression (Expression expression) {
		add_statement (new ExpressionStatement (expression, source_reference));
	}

	public void add_assignment (Expression left, Expression right) {
		add_expression (new Assignment (left, right, AssignmentOperator.SIMPLE, source_reference));
	}

	public void add_throw (Expression expression) {
		add_statement (new ThrowStatement (expression, source_reference));
	}

	public void add_return (Expression? expression = null) {
		add_statement (new ReturnStatement (expression, source_reference));
	}

	public void add_break () {
		add_statement (new BreakStatement (source_reference));
	}

	public void add_continue () {
		add_statement (new ContinueStatement (source_reference));
	}

	public string add_temp_declaration (DataType? type, Expression? initializer = null) {
		var local = new LocalVariable (type, CodeNode.get_temp_name (), initializer, source_reference);
		var stmt = new DeclarationStatement (local, source_reference);
		insert_block.insert_before (insert_statement, stmt);
		decl_nodes.add (stmt);
		return local.name;
	}

	public void close () {
		do {
			var top = statement_stack[statement_stack.size - 1];
			statement_stack.remove_at (statement_stack.size - 1);
			current_block = top as Block;
		} while (current_block == null);
	}

	/* Utilities for building the code */

	public Expression expression (string str, owned Expression[]? replacements = null) {
		return new Parser().parse_expression_string (str, (owned) replacements, source_reference);
	}

	public void statements (string str, owned Expression[]? replacements = null) {
		new Parser().parse_statements_string (str, current_block, (owned) replacements, source_reference);
	}

	// only qualified types, will slightly simplify the work of SymbolResolver
	public static Symbol? symbol_from_string (string symbol_string, Symbol? parent_symbol = null) {
		Symbol sym = parent_symbol != null ? parent_symbol : CodeContext.get().root;
		foreach (unowned string s in symbol_string.split (".")) {
			if (sym == null) {
				break;
			}
			sym = sym.scope.lookup (s);
		}
		return sym;
	}

	// only qualified types, will slightly simplify the work of SymbolResolver
	public static DataType data_type (string s, bool value_owned = true, bool nullable = false) {
		DataType type = SemanticAnalyzer.get_data_type_for_symbol ((TypeSymbol) symbol_from_string (s));
		type.value_owned = value_owned;
		type.nullable = nullable;
		return type;
	}
}
