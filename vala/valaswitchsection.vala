/* valaswitchsection.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
using Gee;

/**
 * Represents a switch section in the source code.
 */
public class Vala.SwitchSection : Block {
	private Gee.List<SwitchLabel> labels = new ArrayList<SwitchLabel> ();
	private Gee.List<Statement> statement_list = new ArrayList<Statement> ();

	/**
	 * Creates a new switch section.
	 *
	 * @param source_reference reference to source code
	 * @return                 newly created switch section
	 */
	public SwitchSection (SourceReference source_reference) {
		this.source_reference = source_reference;
	}
	
	/**
	 * Appends the specified label to the list of switch labels.
	 *
	 * @param label a switch label
	 */
	public void add_label (SwitchLabel label) {
		labels.add (label);
	}
	
	/**
	 * Returns a copy of the list of switch labels.
	 *
	 * @return switch label list
	 */
	public Collection<SwitchLabel> get_labels () {
		return new ReadOnlyCollection<SwitchLabel> (labels);
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
	public void add_statement (Statement stmt) {
		statement_list.add (stmt);
	}
	
	/**
	 * Returns a copy of the list of statements.
	 *
	 * @return statement list
	 */
	public Collection<Statement> get_statements () {
		return new ReadOnlyCollection<Statement> (statement_list);
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_switch_section (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (SwitchLabel label in labels) {
			label.accept (visitor);
		}

		foreach (Statement st in statement_list) {
			st.accept (visitor);
		}
	}
}
