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

		if (!context.analyzer.is_in_instance_method (this)) {
			error = true;
			Report.error (source_reference, "Base access invalid outside of instance methods");
			return false;
		}

		unowned Class? current_class = context.analyzer.get_current_class (this);
		unowned Struct? current_struct = context.analyzer.get_current_struct (this);
		unowned Method? current_method = context.analyzer.get_current_method (this);
		unowned PropertyAccessor? current_property_accessor = context.analyzer.get_current_property_accessor (this);

		if (current_class == null) {
			if (current_struct == null) {
				error = true;
				Report.error (source_reference, "Base access invalid outside of class and struct");
				return false;
			} else if (current_struct.base_type == null) {
				error = true;
				Report.error (source_reference, "Base access invalid without base type");
				return false;
			}
			value_type = current_struct.base_type;
		} else if (current_class.base_class == null) {
			error = true;
			Report.error (source_reference, "Base access invalid without base class");
			return false;
		} else if (current_class.is_compact && current_method != null
		    && !(current_method is CreationMethod)
		    && (current_method.overrides || current_method.is_virtual)) {
			error = true;
			Report.error (source_reference, "Base access invalid in virtual overridden method of compact class");
			return false;
		} else if (current_class.is_compact && current_property_accessor != null) {
			error = true;
			Report.error (source_reference, "Base access invalid in virtual overridden property of compact class");
			return false;
		} else {
			foreach (var base_type in current_class.get_base_types ()) {
				if (base_type.type_symbol is Class) {
					value_type = base_type.copy ();
					value_type.value_owned = false;
				}
			}
		}

		symbol_reference = value_type.type_symbol;

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_base_access (this);

		codegen.visit_expression (this);
	}
}
