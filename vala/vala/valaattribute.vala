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
	 */
	public static ref Attribute! new (string! name, SourceReference source) {
		return (new Attribute (name = name, source_reference = source));
	}

	/**
	 * Adds an attribute argument.
	 *
	 * @param arg named argument
	 */
	public void add_argument (NamedArgument! arg) {
		args.append (arg);
	}
}
