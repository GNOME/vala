/* valaswitchlabel.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
 * Represents a switch label in the source code.
 */
public class Vala.SwitchLabel : CodeNode {
	/**
	 * Specifies the label expression.
	 */
	public Expression expression { get; set; }

	public weak SwitchSection section { get; set; }

	/**
	 * Creates a new switch case label.
	 *
	 * @param expr   label expression
	 * @param source reference to source code
	 * @return       newly created switch case label
	 */
	public SwitchLabel (Expression expr, SourceReference? source = null) {
		expression = expr;
		source_reference = source;
	}

	/**
	 * Creates a new switch default label.
	 *
	 * @param source reference to source code
	 * @return       newly created switch default label
	 */
	public SwitchLabel.with_default (SourceReference? source = null) {
		source_reference = source;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_switch_label (this);
	}
	
	public override void accept_children (CodeVisitor visitor) {
		if (expression != null) {
			expression.accept (visitor);
			
			visitor.visit_end_full_expression (expression);
		}
	}
	
	public override bool check (CodeContext context) {
		if (expression != null) {
			expression.check (context);

			var switch_statement = (SwitchStatement) section.parent_node;
			if (!expression.is_constant ()) {
				error = true;
				Report.error (expression.source_reference, "Expression must be constant");
				return false;
			}
			if (!expression.value_type.compatible (switch_statement.expression.value_type)) {
				error = true;
				Report.error (expression.source_reference, "Cannot convert from `%s' to `%s'".printf (expression.value_type.to_string (), switch_statement.expression.value_type.to_string ()));
				return false;
			}
		}

		return true;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_switch_label (this);
	}
}
