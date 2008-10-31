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
using Gee;

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
	public weak CodeNode? parent_node { get; set; }

	/**
	 * References the location in the source file where this code node has
	 * been written.
	 */
	public SourceReference? source_reference { get; set; }
	
	/**
	 * Contains all attributes that have been specified for this code node.
	 */
	public GLib.List<Attribute> attributes;
	
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
	public bool tree_can_fail { 
		get { return _error_types != null && _error_types.size > 0; }
	}

	bool checked;
	private Gee.List<DataType> _error_types;
	private static Gee.List<DataType> _empty_type_list;

	private CCodeNode? _ccodenode;

	/**
	 * Specifies the exceptions that can be thrown by this node or a child node
	 */
	public Gee.List<DataType> get_error_types () { 
		if (_error_types != null) {
			return _error_types;
		}
		if (_empty_type_list == null) {
			_empty_type_list = new ReadOnlyList<DataType> (new ArrayList<DataType> ());
		}
		return _empty_type_list;
	}

	/**
	 * Adds an error type to the exceptions that can be thrown by this node
	 * or a child node 
	 */
	public void add_error_type (DataType error_type) {
		if (_error_types == null) {
			_error_types = new ArrayList<DataType> ();
		}
		_error_types.add (error_type);
		error_type.parent_node = this;
	}

	/**
	 * Adds a collection of error types to the exceptions that can be thrown by this node
	 * or a child node 
	 */
	public void add_error_types (Gee.List<DataType> error_types) {
		foreach (DataType error_type in error_types) {
			add_error_type (error_type);
		}
	}

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

	public virtual bool check (SemanticAnalyzer analyzer) {
		return false;
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

	/**
	 * Returns a string that represents this code node.
	 *
	 * @return a string representation
	 */
	public virtual string to_string () {
		var str = new StringBuilder ();

		str.append ("/* ");

		if (source_reference != null) {
			str.append ("@").append (source_reference.to_string ());
		}

		return str.append (" */").str;
	}
}
