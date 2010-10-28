/* valaunlockstatement.vala
 *
 * Copyright (C) 2009-2010  Jürg Billeter
 * Copyright (C) 2009  Jiří Zárevúcky
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
 * 	Jiří Zárevúcky <zarevucky.jiri@gmail.com>
 */

/**
 * Represents an unlock statement e.g. {{{ unlock (a); }}}.
 */
public class Vala.UnlockStatement : CodeNode, Statement {
	/**
	 * Expression representing the resource to be unlocked.
	 */
	public Expression resource { get; set; }

	public UnlockStatement (Expression resource, SourceReference? source_reference = null) {
		this.source_reference = source_reference;
		this.resource = resource;
	}

	public override void accept (CodeVisitor visitor) {
		resource.accept (visitor);
		visitor.visit_unlock_statement (this);
	}

	public override bool check (CodeContext context) {
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
		codegen.visit_unlock_statement (this);
	}
}
