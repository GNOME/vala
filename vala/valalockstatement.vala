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
public class Vala.LockStatement : CodeNode, Statement {
	/**
	 * Expression representing the resource to be locked.
	 */
	public Expression resource { get; set; }
	
	/**
	 * The statement during its execution the resource is locked.
	 */
	public Block? body { get; set; }
	
	public LockStatement (Expression resource, Block? body, SourceReference? source_reference = null) {
		this.body = body;
		this.source_reference = source_reference;
		this.resource = resource;
	}
	
	public override void accept (CodeVisitor visitor) {
		resource.accept (visitor);
		if (body != null) {
			body.accept (visitor);
		}
		visitor.visit_lock_statement (this);
	}

	public override bool check (CodeContext context) {
		if (body != null) {
			// if the statement isn't empty, it is converted into a try statement

			var fin_body = new Block (source_reference);
			fin_body.add_statement (new UnlockStatement (resource, source_reference));

			var block = new Block (source_reference);
			block.add_statement (new LockStatement (resource, null, source_reference));
			block.add_statement (new TryStatement (body, fin_body, source_reference));

			var parent_block = (Block) parent_node;
			parent_block.replace_statement (this, block);

			return block.check (context);
		}

		if (checked) {
			return !error;
		}

		checked = true;

		resource.check (context);

		/* resource must be a member access and denote a Lockable */
		if (!(resource is MemberAccess && resource.symbol_reference is Lockable)) {
			error = true;
			resource.error = true;
			Report.error (resource.source_reference, "Expression is either not a member access or does not denote a lockable member");
			return false;
		}

		/* parent symbol must be the current class */
		if (resource.symbol_reference.parent_symbol != context.analyzer.current_class) {
			error = true;
			resource.error = true;
			Report.error (resource.source_reference, "Only members of the current class are lockable");
		}

		((Lockable) resource.symbol_reference).set_lock_used (true);

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		resource.emit (codegen);
		codegen.visit_lock_statement (this);
	}
}
