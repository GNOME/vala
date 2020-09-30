/* valaclassaccess.vala
 *
 * Copyright (C) 2020  Rico Tzschichholz
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
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */


/**
 * Represents an access to class member in the source code.
 */
public class Vala.ClassAccess : Expression {
	/**
	 * Creates a new class access expression.
	 *
	 * @param source reference to source code
	 * @return       newly created class access expression
	 */
	public ClassAccess (SourceReference? source = null) {
		source_reference = source;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_class_access (this);

		visitor.visit_expression (this);
	}

	public override string to_string () {
		return "class";
	}

	public override bool is_pure () {
		return true;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (context.analyzer.current_class == null) {
			error = true;
			Report.error (source_reference, "Class access invalid outside of class");
			return false;
		} else if (context.analyzer.current_class.is_compact) {
			error = true;
			Report.error (source_reference, "Class access invalid in compact class");
			return false;
		} else {
			value_type = SemanticAnalyzer.get_data_type_for_symbol (context.analyzer.current_class);
			value_type.value_owned = false;
		}

		symbol_reference = value_type.type_symbol;

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_class_access (this);

		codegen.visit_expression (this);
	}
}
