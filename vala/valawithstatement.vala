/* valalockstatement.vala
 *
 * Copyright (C) 2009  Jiří Zárevúcky
 * Copyright (C) 2006-2010  Jürg Billeter
 * Copyright (C) 2006-2007  Raffaele Sandrini
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
 * Authors:
 * 	Raffaele Sandrini <raffaele@sandrini.ch>
 * 	Jiří Zárevúcky <zarevucky.jiri@gmail.com>
 */

using GLib;

/**
 * Represents a lock statement e.g. {{{ lock (a); }}} or {{{ lock (a) { f(a); } }}}.
 *
 * If the statement is empty, the mutex remains locked until a corresponding UnlockStatement
 * occurs. Otherwise it's translated into a try/finally statement which unlocks the mutex
 * after the block is finished.
 */
public class Vala.WithStatement : Symbol, Statement {
	/**
	 * Expression representing the expression to be locked.
	 */
	public Expression expression {
		get { return _expression; }
		set {
			_expression = value;
			_expression.parent_node = this;
		}
	}

	/**
	 * The statement during its execution the expression is locked.
	 */
	public Block? body {
		get { return _body; }
		set {
			_body = value;
			if (_body != null) {
				_body.parent_node = this;
			}
		}
	}

	/* public Scope scope {
		get { 
			stdout.printf("with scope\n");
			return expression.symbol_reference.scope; 
		}
	} */

	private Expression _expression;
	private Block _body;

	public WithStatement (Expression expression, Block? body, SourceReference? source_reference = null) {
		base("with", source_reference);
		this.body = body;
		this.source_reference = source_reference;
		this.expression = expression;
	}

	public override void accept (CodeVisitor visitor) {
		stdout.printf("Accept with\n");
		visitor.visit_with_statement (this);
	}

	public override void accept_children(CodeVisitor visitor) {
		stdout.printf("Accept children with\n");
		expression.accept (visitor);
		if (body != null) {
			body.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (expression == old_node) {
			expression = new_node;
		}
	}

	public override bool check (CodeContext context) {
		stdout.printf("Check with\n");

		expression.check(context);

		var old_symbol = context.analyzer.current_symbol;
		var old_insert_block = context.analyzer.insert_block;
		owner = context.analyzer.current_symbol.scope;
		//owner = expression.symbol_reference.scope;
		context.analyzer.current_symbol = this;

		stdout.printf("With expression: %s\n", Type.from_instance(expression).name());

		/*var sr = expression.symbol_reference;
		var sc = sr.scope;
		var st = sc.get_symbol_table();
		var iter = st.map_iterator();
		while (iter.next()) {
			scope.add(iter.get_key(), iter.get_value());
			stdout.printf("Symbol %s\n", iter.get_key());
		}*/

		//context.analyzer.current_symbol = expression.symbol_reference;
		//context.analyzer.insert_block = body;

		//  var cc = context.analyzer.current_class;
		//  var cs = context.analyzer.current_symbol;
		//  var cm = context.analyzer.current_method_or_property_accessor;

		//  stdout.printf("cs %s, cc %s, cm %s\n", cc.name, cs.name, cm.name);

		//body.parent_node = expression;
		body.check(context);

		//context.analyzer.current_symbol = old_symbol;
		//context.analyzer.insert_block = old_insert_block;
		context.analyzer.current_symbol = old_symbol;
		return true;
		// Ehh change context somehow...
		//  if (body != null) {
		//  	// if the statement isn't empty, it is converted into a try statement

		//  	var fin_body = new Block (source_reference);
		//  	fin_body.add_statement (new UnlockStatement (resource, source_reference));

		//  	var block = new Block (source_reference);
		//  	block.add_statement (new LockStatement (resource, null, source_reference));
		//  	block.add_statement (new TryStatement (body, fin_body, source_reference));

		//  	var parent_block = (Block) parent_node;
		//  	parent_block.replace_statement (this, block);

		//  	return block.check (context);
		//  }

		//  if (checked) {
		//  	return !error;
		//  }

		//  checked = true;

		//  resource.check (context);

		//  /* resource must be a member access and denote a Lockable */
		//  if (!(resource is MemberAccess && resource.symbol_reference is Lockable)) {
		//  	error = true;
		//  	resource.error = true;
		//  	Report.error (resource.source_reference, "Expression is either not a member access or does not denote a lockable member");
		//  	return false;
		//  }

		//  /* parent symbol must be the current class */
		//  if (resource.symbol_reference.parent_symbol != context.analyzer.current_class) {
		//  	error = true;
		//  	resource.error = true;
		//  	Report.error (resource.source_reference, "Only members of the current class are lockable");
		//  	return false;
		//  }

		//  /* parent class must not be compact */
		//  if (context.analyzer.current_class.is_compact) {
		//  	error = true;
		//  	resource.error = true;
		//  	Report.error (resource.source_reference, "Only members of the non-compact classes are lockable");
		//  	return false;
		//  }

		//  ((Lockable) resource.symbol_reference).lock_used = true;

		//  return !error;
	}

	public override void emit (CodeGenerator codegen) {
		expression.emit (codegen);
		body.emit (codegen);
		//codegen.visit_with_statement (this);
	}
}
