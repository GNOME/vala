/* valaloopstatement.vala
 *
 * Copyright (C) 2009-2010  Jürg Billeter
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
 * Represents an endless loop.
 */
public class Vala.LoopStatement : Loop, Statement {
	/**
	 * Creates a new loop.
	 *
	 * @param body             loop body
	 * @param source_reference reference to source code
	 * @return                 newly created while statement
	 */
	public LoopStatement (Block body, SourceReference? source_reference = null) {
		base (new BooleanLiteral (true, source_reference), body, source_reference);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_loop_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		body.accept (visitor);
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		body.get_error_types (collection, source_reference);
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		condition.check (context);
		body.check (context);

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_loop_statement (this);
	}
}

