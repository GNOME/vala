/* valacodenode.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
	public SourceReference source_reference { get; set construct; }
	
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
					source_reference.file.filename,
					source_reference.first_line);
			}

			_ccodenode = value;
		}
	}
	
	/**
	 * Specifies whether a fatal error has been detected in this code node.
	 */
	public bool error { get; set; }

	/**
	 * Visits this code node with the specified CodeVisitor.
	 *
	 * @param visitor the visitor to be called while traversing
	 */
	public virtual void accept (CodeVisitor! visitor) {
	}

	/**
	 * Visits all children of this code node with the specified CodeVisitor.
	 *
	 * @param visitor the visitor to be called while traversing
	 */
	public virtual void accept_children (CodeVisitor! visitor) {
	}

	public virtual void replace (CodeNode! old_node, CodeNode! new_node) {
	}

	/**
	 * Returns the specified attribute.
	 *
	 * @param name attribute name
	 * @return     attribute
	 */
	public Attribute get_attribute (string! name) {
		// FIXME: use hash table
		foreach (Attribute a in attributes) {
			if (a.name == name) {
				return a;
			}
		}
		
		return null;
	}
	
	private CCodeNode _ccodenode;

	/**
	 * Returns a string that represents this code node.
	 *
	 * @return a string representation
	 */
	public virtual ref string! to_string () {
		if (source_reference != null) {
			return source_reference.to_string ();
		}
		return "(unknown)";
	}
}
