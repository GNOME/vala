/* valatypeofexpression.vala
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
 * Represents a typeof expression in the source code.
 */
public class Vala.TypeofExpression : Expression {
	/**
	 * The type to be retrieved.
	 */
	public TypeReference! type_reference { get; set construct; }

	/**
	 * Creates a new typeof expression.
	 *
	 * @param type   a data type
	 * @param source reference to source code
	 * @return       newly created typeof expression
	 */
	public TypeofExpression (TypeReference! type, SourceReference source) {
		type_reference = type;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		type_reference.accept (visitor);
	
		visitor.visit_typeof_expression (this);
	}
}
