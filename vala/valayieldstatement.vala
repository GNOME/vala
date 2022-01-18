/* valayieldstatement.vala
 *
 * Copyright (C) 2008-2010  Jürg Billeter
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

/**
 * Represents a yield statement in the source code.
 */
public class Vala.YieldStatement : CodeNode, Statement {
	/**
	 * Creates a new yield statement.
	 *
	 * @param source_reference reference to source code
	 * @return                 newly created yield statement
	 */
	public YieldStatement (SourceReference? source_reference = null) {
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_yield_statement (this);
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (context.analyzer.current_method == null || !context.analyzer.current_method.coroutine) {
			error = true;
			Report.error (source_reference, "yield statement not available outside async method");
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_yield_statement (this);
	}
}

