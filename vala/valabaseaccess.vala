/* valabaseaccess.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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

using Gee;

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

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!analyzer.is_in_instance_method ()) {
			error = true;
			Report.error (source_reference, "Base access invalid outside of instance methods");
			return false;
		}

		if (analyzer.current_class == null) {
			if (analyzer.current_struct == null) {
				error = true;
				Report.error (source_reference, "Base access invalid outside of class and struct");
				return false;
			} else if (analyzer.current_struct.get_base_types ().size != 1) {
				error = true;
				Report.error (source_reference, "Base access invalid without base type %d".printf (analyzer.current_struct.get_base_types ().size));
				return false;
			}
			Iterator<DataType> base_type_it = analyzer.current_struct.get_base_types ().iterator ();
			base_type_it.next ();
			value_type = base_type_it.get ();
		} else if (analyzer.current_class.base_class == null) {
			error = true;
			Report.error (source_reference, "Base access invalid without base class");
			return false;
		} else {
			value_type = new ObjectType (analyzer.current_class.base_class);
		}

		symbol_reference = value_type.data_type;

		return !error;
	}

	public override bool in_single_basic_block () {
		return true;
	}
}
