/* valaswitchsection.vala
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
 * Represents a switch section in the source code.
 */
public class Vala.SwitchSection : Block {
	private List<SwitchLabel> labels = new ArrayList<SwitchLabel> ();

	/**
	 * Creates a new switch section.
	 *
	 * @param source_reference reference to source code
	 * @return                 newly created switch section
	 */
	public SwitchSection (SourceReference? source_reference) {
		base (source_reference);
	}
	
	/**
	 * Appends the specified label to the list of switch labels.
	 *
	 * @param label a switch label
	 */
	public void add_label (SwitchLabel label) {
		labels.add (label);
		label.section = this;
	}
	
	/**
	 * Returns a copy of the list of switch labels.
	 *
	 * @return switch label list
	 */
	public List<SwitchLabel> get_labels () {
		return labels;
	}
	
	public bool has_default_label () {
		foreach (SwitchLabel label in labels) {
			if (label.expression == null) {
				return true;
			}
		}
		
		return false;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_switch_section (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (SwitchLabel label in labels) {
			label.accept (visitor);
		}

		foreach (Statement st in get_statements ()) {
			st.accept (visitor);
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		foreach (SwitchLabel label in get_labels ()) {
			label.check (context);
		}

		owner = context.analyzer.current_symbol.scope;

		var old_symbol = context.analyzer.current_symbol;
		var old_insert_block = context.analyzer.insert_block;
		context.analyzer.current_symbol = this;
		context.analyzer.insert_block = this;

		foreach (Statement st in get_statements ()) {
			st.check (context);
		}

		foreach (LocalVariable local in get_local_variables ()) {
			local.active = false;
		}

		// use get_statements () instead of statement_list to not miss errors within StatementList objects
		foreach (Statement stmt in get_statements ()) {
			add_error_types (stmt.get_error_types ());
		}

		context.analyzer.current_symbol = old_symbol;
		context.analyzer.insert_block = old_insert_block;

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		foreach (SwitchLabel label in labels) {
			label.emit (codegen);
		}

		base.emit (codegen);
	}
}
