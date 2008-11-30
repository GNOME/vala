/* valadostatement.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
 * Represents a do iteration statement in the source code.
 */
public class Vala.DoStatement : CodeNode, Statement {
	/**
	 * Specifies the loop body.
	 */
	public Block body {
		get {
			return _body;
		}
		set {
			_body = value;
			_body.parent_node = this;
		}
	}

	/**
	 * Specifies the loop condition.
	 */
	public Expression condition {
		get {
			return _condition;
		}
		set {
			_condition = value;
			_condition.parent_node = this;
		}
	}

	private Expression _condition;
	private Block _body;

	/**
	 * Creates a new do statement.
	 *
	 * @param cond   loop condition
	 * @param body   loop body
	 * @param source reference to source code
	 * @return       newly created do statement
	 */
	public DoStatement (Block body, Expression condition, SourceReference? source_reference = null) {
		this.condition = condition;
		this.source_reference = source_reference;
		this.body = body;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_do_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		body.accept (visitor);

		condition.accept (visitor);
		
		visitor.visit_end_full_expression (condition);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (condition == old_node) {
			condition = new_node;
		}
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!condition.check (analyzer)) {
			/* if there was an error in the condition, skip this check */
			error = true;
			return false;
		}

		if (!condition.value_type.compatible (analyzer.bool_type)) {
			error = true;
			Report.error (condition.source_reference, "Condition must be boolean");
			return false;
		}

		body.check (analyzer);

		add_error_types (condition.get_error_types ());
		add_error_types (body.get_error_types ());

		return !error;
	}

	public Block prepare_condition_split (SemanticAnalyzer analyzer) {
		/* move condition into the loop body to allow split
		 * in multiple statements
		 *
		 * first = false;
		 * do {
		 *     if (first) {
		 *         if (!condition) {
		 *             break;
		 *         }
		 *     }
		 *     first = true;
		 *     ...
		 * } while (true);
		 */

		var first_local = new LocalVariable (new ValueType (analyzer.bool_type.data_type), get_temp_name (), new BooleanLiteral (false, source_reference), source_reference);
		var first_decl = new DeclarationStatement (first_local, source_reference);
		first_decl.check (analyzer);
		var block = (Block) analyzer.current_symbol;
		block.insert_before (this, first_decl);

		var if_condition = new UnaryExpression (UnaryOperator.LOGICAL_NEGATION, condition, condition.source_reference);
		var true_block = new Block (condition.source_reference);
		true_block.add_statement (new BreakStatement (condition.source_reference));
		var if_stmt = new IfStatement (if_condition, true_block, null, condition.source_reference);

		var condition_block = new Block (condition.source_reference);
		condition_block.add_statement (if_stmt);

		var first_if = new IfStatement (new MemberAccess.simple (first_local.name, source_reference), condition_block, null, source_reference);
		body.insert_statement (0, first_if);
		body.insert_statement (1, new ExpressionStatement (new Assignment (new MemberAccess.simple (first_local.name, source_reference), new BooleanLiteral (true, source_reference), AssignmentOperator.SIMPLE, source_reference), source_reference));

		condition = new BooleanLiteral (true, source_reference);
		condition.check (analyzer);

		return condition_block;
	}
}
