/* valabaseaccess.vala
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


/**
 * Represents an access to base class members in the source code.
 */
public class Vala.BaseAccess : Expression {
	/**
	 * Creates a new base access expression.
	 *
	 * @param source reference to source code
	 * @return       newly created base access expression
	 */
	public BaseAccess (SourceReference? source = null) {
		source_reference = source;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_base_access (this);

		visitor.visit_expression (this);
	}

	public override string to_string () {
		return "base";
	}

	public override bool is_pure () {
		return true;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!context.analyzer.is_in_instance_method ()) {
			error = true;
			Report.error (source_reference, "Base access invalid outside of instance methods");
			return false;
		}

		if (context.analyzer.current_class == null) {
			if (context.analyzer.current_struct == null) {
				error = true;
				Report.error (source_reference, "Base access invalid outside of class and struct");
				return false;
			} else if (context.analyzer.current_struct.base_type == null) {
				error = true;
				Report.error (source_reference, "Base access invalid without base type");
				return false;
			}
			value_type = context.analyzer.current_struct.base_type;
		} else if (context.analyzer.current_class.base_class == null) {
			error = true;
			Report.error (source_reference, "Base access invalid without base class");
			return false;
		} else {
			foreach (var base_type in context.analyzer.current_class.get_base_types ()) {
				if (base_type.data_type is Class) {
					value_type = base_type.copy ();
					value_type.value_owned = false;
				}
			}
		}

		symbol_reference = value_type.data_type;

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_base_access (this);

		codegen.visit_expression (this);
	}
}
