/* valanamedargument.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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
 * Represents a named argument in the source code. A named argument may be used
 * when creating objects and attributes where no parameter list exists.
 */
public class Vala.NamedArgument : CodeNode {
	/**
	 * The name of a property.
	 */
	public string name { get; set construct; }
	
	/**
	 * The expression the property should assign.
	 */
	public Expression argument { get; set construct; }
	
	/**
	 * Creates a new named argument.
	 *
	 * @param name   property name
	 * @param arg    property value expression
	 * @param source reference to source code
	 * @return       newly created named argument
	 */
	public NamedArgument (string _name, Expression arg, SourceReference source) {
		name = _name;
		argument = arg;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor visitor) {
		argument.accept (visitor);
	
		visitor.visit_named_argument (this);
	}
}
