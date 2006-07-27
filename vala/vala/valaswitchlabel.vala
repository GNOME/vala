/* valaswitchlabel.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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

	/**
	 * Creates a new switch case label.
	 *
	 * @param expr   label expression
	 * @param source reference to source code
	 * @return       newly created switch case label
	 */
	public static ref SwitchLabel! new (Expression expr, SourceReference source) {
		return (new SwitchLabel (expression = expr, source_reference = source));
	}

	/**
	 * Creates a new switch default label.
	 *
	 * @param source reference to source code
	 * @return       newly created switch default label
	 */
	public static ref SwitchLabel! new_default (SourceReference source) {
		return (new SwitchLabel (source_reference = source));
	}
	
	public override void accept (CodeVisitor! visitor) {
		if (expression != null) {
			expression.accept (visitor);
			
			visitor.visit_end_full_expression (expression);
		}

		visitor.visit_switch_label (this);
	}
}
