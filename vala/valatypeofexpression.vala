/* valatypeofexpression.vala
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
 * Represents a typeof expression in the source code.
 */
public class Vala.TypeofExpression : Expression {
	/**
	 * The type to be retrieved.
	 */
	public DataType type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}

	private DataType _data_type;

	/**
	 * Creates a new typeof expression.
	 *
	 * @param type   a data type
	 * @param source reference to source code
	 * @return       newly created typeof expression
	 */
	public TypeofExpression (DataType type, SourceReference source) {
		type_reference = type;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_typeof_expression (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		type_reference.accept (visitor);
	}

	public override bool is_pure () {
		return true;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		type_reference.check (context);

		value_type = context.analyzer.type_type;

		if (context.profile == Profile.GOBJECT && type_reference.get_type_arguments ().size > 0) {
			Report.warning (_data_type.source_reference, "Type argument list without effect");
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_typeof_expression (this);

		codegen.visit_expression (this);
	}
}
