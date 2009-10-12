/* valaswitchstatement.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Represents a switch selection statement in the source code.
 */
public class Vala.SwitchStatement : CodeNode, Statement {
	/**
	 * Specifies the switch expression.
	 */
	public Expression expression {
		get {
			return _expression;
		}
		set {
			_expression = value;
			_expression.parent_node = this;
		}
	}

	private Expression _expression;
	private List<SwitchSection> sections = new ArrayList<SwitchSection> ();

	/**
	 * Creates a new switch statement.
	 *
	 * @param expression       switch expression
	 * @param source_reference reference to source code
	 * @return                 newly created switch statement
	 */
	public SwitchStatement (Expression expression, SourceReference source_reference) {
		this.source_reference = source_reference;
		this.expression = expression;
	}
	
	/**
	 * Appends the specified section to the list of switch sections.
	 *
	 * @param section a switch section
	 */
	public void add_section (SwitchSection section) {
		section.parent_node = this;
		sections.add (section);
	}
	
	/**
	 * Returns a copy of the list of switch sections.
	 *
	 * @return section list
	 */
	public List<SwitchSection> get_sections () {
		return new ReadOnlyList<SwitchSection> (sections);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_switch_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		expression.accept (visitor);

		visitor.visit_end_full_expression (expression);
		
		foreach (SwitchSection section in sections) {
			section.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (expression == old_node) {
			expression = new_node;
		}
	}
	
	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!expression.check (analyzer)) {
			error = true;
			return false;
		}

		if (!(expression.value_type is IntegerType)
		    && !(expression.value_type is EnumValueType)
		    && !expression.value_type.compatible (analyzer.string_type)) {
			Report.error (expression.source_reference, "Integer or string expression expected");
			error = true;
			return false;
		}

		// ensure that possibly owned (string) expression stays alive
		expression.target_type = expression.value_type.copy ();

		foreach (SwitchSection section in sections) {
			section.check (analyzer);
		}

		return !error;
	}
}
