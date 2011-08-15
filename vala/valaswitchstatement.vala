/* valaswitchstatement.vala
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
	public SwitchStatement (Expression expression, SourceReference? source_reference) {
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
		return sections;
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
	
	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!expression.check (context)) {
			error = true;
			return false;
		}

		if (expression.value_type == null ||
		    (!(expression.value_type is IntegerType) &&
		     !(expression.value_type is EnumValueType) &&
		     !expression.value_type.compatible (context.analyzer.string_type))) {
			Report.error (expression.source_reference, "Integer or string expression expected");
			error = true;
			return false;
		}

		// ensure that possibly owned (string) expression stays alive
		expression.target_type = expression.value_type.copy ();
		expression.target_type.nullable = false;

		var labelset = new HashSet<string> (str_hash, str_equal);
		foreach (SwitchSection section in sections) {
			section.check (context);

			// check for duplicate literal case labels
			foreach (SwitchLabel label in section.get_labels ()) {
				if (label.expression != null) {
					string? value = null;
					if (label.expression is StringLiteral) {
						value = ((StringLiteral)label.expression).eval ();
					} else if (label.expression is Literal) {
						value = ((Literal)label.expression).to_string ();
					} else if (label.expression.is_constant ()) {
						value = label.expression.to_string ();
					}

					if (value != null && !labelset.add (value)) {
						error = true;
						Report.error (label.expression.source_reference, "Switch statement already contains this label");
					}
				}
			}
			add_error_types (section.get_error_types ());
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		expression.emit (codegen);

		codegen.visit_end_full_expression (expression);

		codegen.visit_switch_statement (this);
	}
}
