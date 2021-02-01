/* valaccodefragment.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 * Represents a container for C code nodes.
 */
public class Vala.CCodeFragment : CCodeNode {
	private List<CCodeNode> children = new ArrayList<CCodeNode> ();

	/**
	 * Appends the specified code node to this code fragment.
	 *
	 * @param node a C code node
	 */
	public void append (CCodeNode node) {
		children.add (node);
	}

	/**
	 * Returns the list of children.
	 *
	 * @return children list
	 */
	public unowned List<CCodeNode> get_children () {
		return children;
	}

	public override void write (CCodeWriter writer) {
		foreach (CCodeNode node in children) {
			node.write (writer);
		}
	}

	public override void write_declaration (CCodeWriter writer) {
		foreach (CCodeNode node in children) {
			node.write_declaration (writer);
		}
	}

	public override void write_combined (CCodeWriter writer) {
		foreach (CCodeNode node in children) {
			node.write_combined (writer);
		}
	}
}
