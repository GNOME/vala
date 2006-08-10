/* valaswitchsection.vala
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
 * Represents a switch section in the source code.
 */
public class Vala.SwitchSection : CodeNode {
	private List<SwitchLabel> labels;
	private List<Statement> statement_list;

	/**
	 * Creates a new switch section.
	 *
	 * @param source reference to source code
	 * @return       newly created switch section
	 */
	public construct (SourceReference source) {
		source_reference = source;
	}
	
	/**
	 * Appends the specified label to the list of switch labels.
	 *
	 * @param label a switch label
	 */
	public void add_label (SwitchLabel! label) {
		labels.append (label);
	}
	
	/**
	 * Returns a copy of the list of switch labels.
	 *
	 * @return switch label list
	 */
	public ref List<SwitchLabel> get_labels () {
		return labels.copy ();
	}
	
	public bool has_default_label () {
		foreach (SwitchLabel label in labels) {
			if (label.expression == null) {
				return true;
			}
		}
		
		return false;
	}
	
	/**
	 * Appends the specified statement to this switch section.
	 *
	 * @param stmt a statement
	 */
	public void add_statement (Statement! stmt) {
		statement_list.append (stmt);
	}
	
	/**
	 * Returns a copy of the list of statements.
	 *
	 * @return statement list
	 */
	public ref List<Statement> get_statements () {
		return statement_list.copy ();
	}
	
	public override void accept (CodeVisitor! visitor) {
		foreach (SwitchLabel label in labels) {
			label.accept (visitor);
		}

		foreach (Statement st in statement_list) {
			st.accept (visitor);
		}
		
		visitor.visit_switch_section (this);
	}
}
