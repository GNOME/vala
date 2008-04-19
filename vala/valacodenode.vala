/* valacodenode.vala
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
 * Represents a part of the parsed source code.
 *
 * Code nodes get created by the parser and are used throughout the whole
 * compilation process.
 */
public abstract class Vala.CodeNode : Object {
	/**
	 * Parent of this code node.
	 */
	public weak CodeNode? parent_node { get; set; }

	/**
	 * References the location in the source file where this code node has
	 * been written.
	 */
	public SourceReference? source_reference { get; set; }
	
	/**
	 * Contains all attributes that have been specified for this code node.
	 */
	public List<Attribute> attributes;
	
	/**
	 * Generated CCodeNode that corresponds to this code node.
	 */
	public CCodeNode? ccodenode {
		get {
			return _ccodenode;
		}
		set {
			if (value != null && source_reference != null) {
				value.line = new CCodeLineDirective (
					Path.get_basename (source_reference.file.filename),
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
	 * Specifies that this node or a child node may throw an exception.
	 */
	public bool tree_can_fail { get; set; }

	/**
	 * Visits this code node with the specified CodeVisitor.
	 *
	 * @param visitor the visitor to be called while traversing
	 */
	public virtual void accept (CodeVisitor visitor) {
	}

	/**
	 * Visits all children of this code node with the specified CodeVisitor.
	 *
	 * @param visitor the visitor to be called while traversing
	 */
	public virtual void accept_children (CodeVisitor visitor) {
	}

	public virtual void replace_type (DataType old_type, DataType new_type) {
	}

	public virtual void replace_expression (Expression old_node, Expression new_node) {
	}

	/**
	 * Returns the specified attribute.
	 *
	 * @param name attribute name
	 * @return     attribute
	 */
	public Attribute? get_attribute (string name) {
		// FIXME: use hash table
		foreach (Attribute a in attributes) {
			if (a.name == name) {
				return a;
			}
		}
		
		return null;
	}

	private CodeBinding? code_binding;
	private CCodeNode? _ccodenode;

	/**
	 * Returns a string that represents this code node.
	 *
	 * @return a string representation
	 */
	public virtual string to_string () {
		var str = new StringBuilder ();

		str.append ("/* ").append (get_type ().name ());

		if (source_reference != null) {
			str.append ("@").append (source_reference.to_string ());
		}

		return str.append (" */").str;
	}

	/**
	 * Returns the binding to the generated code.
	 *
	 * @return code binding
	 */
	public CodeBinding? get_code_binding (CodeGenerator codegen) {
		if (code_binding == null) {
			code_binding = create_code_binding (codegen);
		}
		return code_binding;
	}

	/**
	 * Creates the binding to the generated code.
	 */
	public virtual CodeBinding? create_code_binding (CodeGenerator codegen) {
		return null;
	}
}
