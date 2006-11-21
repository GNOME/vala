/* valaattribute.vala
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
 * Represents an attribute specified in the source code.
 */
public class Vala.Attribute : CodeNode {
	/**
	 * The name of the attribute type.
	 */
	public string! name { get; set construct; }

	/**
	 * Contains all specified attribute arguments.
	 */
	public List<NamedArgument> args;
	
	/**
	 * Creates a new attribute.
	 *
	 * @param name attribute type name
	 * @param source reference to source code
	 * @return newly created attribute
	 */
	public construct (string! _name, SourceReference source) {
		name = _name;
		source_reference = source;
	}

	/**
	 * Adds an attribute argument.
	 *
	 * @param arg named argument
	 */
	public void add_argument (NamedArgument! arg) {
		args.append (arg);
	}
	
	/**
	 * Returns whether this attribute has the specified named argument.
	 *
	 * @param name argument name
	 * @return     true if the argument has been found, false otherwise
	 */
	public bool has_argument (string! name) {
		// FIXME: use hash table
		foreach (NamedArgument arg in args) {
			if (arg.name == name) {
				return true;
			}
		}
		
		return false;
	}
	
	/**
	 * Returns the string value of the specified named argument.
	 *
	 * @param name argument name
	 * @return     string value
	 */
	public ref string get_string (string! name) {
		// FIXME: use hash table
		foreach (NamedArgument arg in args) {
			if (arg.name == name) {
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						return ((StringLiteral) lit).eval ();
					}
				}
			}
		}
		
		return null;
	}
	
	/**
	 * Returns the integer value of the specified named argument.
	 *
	 * @param name argument name
	 * @return     integer value
	 */
	public int get_integer (string! name) {
		// FIXME: use hash table
		foreach (NamedArgument arg in args) {
			if (arg.name == name) {
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is IntegerLiteral) {
						return ((IntegerLiteral) lit).value.to_int ();
					}
				}
			}
		}
		
		return 0;
	}
}
