/* valaobjectcreationexpression.vala
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
 * Represents an object creation expression in the source code.
 */
public class Vala.ObjectCreationExpression : Expression {
	/**
	 * The object type to create.
	 */
	public TypeReference type_reference { get; set; }

	/**
	 * The construction method to use. May be null to indicate that
	 * the default construction method should be used.
	 */
	public Method constructor { get; set; }

	/**
	 * The construction method to use or the data type to be created
	 * with the default construction method.
	 */
	public MemberAccess member_name { get; set; }

	private List<Expression> argument_list;

	/**
	 * Creates a new object creation expression.
	 *
	 * @param type   object type to create
	 * @param source reference to source code
	 * @return       newly created object creation expression
	 */
	public construct (MemberAccess! name, SourceReference source) {
		member_name = name;
		source_reference = source;
	}
	
	/**
	 * Appends the specified expression to the list of arguments.
	 *
	 * @param arg an argument
	 */
	public void add_argument (Expression! arg) {
		argument_list.append (arg);
	}
	
	/**
	 * Returns a copy of the argument list.
	 *
	 * @return argument list
	 */
	public ref List<Expression> get_argument_list () {
		return argument_list.copy ();
	}
	
	public override void accept (CodeVisitor! visitor) {
		if (type_reference != null) {
			type_reference.accept (visitor);
		}

		if (member_name != null) {
			member_name.accept (visitor);
		}
		
		visitor.visit_begin_object_creation_expression (this);

		foreach (Expression arg in argument_list) {
			arg.accept (visitor);
		}
	
		visitor.visit_end_object_creation_expression (this);
	}
}
