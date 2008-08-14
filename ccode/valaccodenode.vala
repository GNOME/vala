/* valaccodenode.vala
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

using GLib;

/**
 * Represents a node in the C code tree.
 */
public abstract class Vala.CCodeNode {
	/**
	 * The source file name and line number to be presumed for this code
	 * node.
	 */
	public CCodeLineDirective line { get; set; }

	/**
	 * Writes this code node and all children with the specified C code
	 * writer.
	 *
	 * @param writer a C code writer
	 */
	public abstract void write (CCodeWriter writer);

	/**
	 * Writes declaration for this code node with the specified C code
	 * writer if necessary.
	 *
	 * @param writer a C code writer
	 */
	public virtual void write_declaration (CCodeWriter writer) {
	}

	/**
	 * Writes declaration and implementation combined for this code node and
	 * all children with the specified C code writer.
	 *
	 * @param writer a C code writer
	 */
	public virtual void write_combined (CCodeWriter writer) {
		write_declaration (writer);
		write (writer);
	}
}
