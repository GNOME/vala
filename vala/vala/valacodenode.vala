/* valacodenode.vala
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
 * Represents a part of the parsed source code.
 *
 * Code nodes get created by the parser and are used throughout the whole
 * compilation process.
 */
public abstract class Vala.CodeNode {
	/**
	 * Parent of this code node.
	 */
	public CodeNode parent_node { get; set; }
	
	/**
	 * Symbol that corresponds to this code node.
	 */
	public Symbol symbol { get; set; }
	
	/**
	 * References the location in the source file where this code node has
	 * been written.
	 */
	public SourceReference source_reference { get; set; }
	
	/**
	 * Contains all attributes that have been specified for this code node.
	 */
	public List<Attribute> attributes;
	
	/**
	 * Generated CCodeNode that corresponds to this code node.
	 */
	public CCodeNode ccodenode {
		get {
			return _ccodenode;
		}
		set {
			if (source_reference != null) {
				value.line = new CCodeLineDirective (
					filename = source_reference.file.filename,
					line = source_reference.first_line);
			}

			_ccodenode = value;
		}
	}
	
	/**
	 * Specifies whether a fatal error has been detected in this code node.
	 */
	public bool error { get; set; }

	/**
	 * Visits this code node and all children with the specified
	 * CodeVisitor.
	 *
	 * @param visitor the visitor to be called while traversing
	 */
	public abstract void accept (CodeVisitor! visitor);
	
	private CCodeNode _ccodenode;
}
