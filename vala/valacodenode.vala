/* valacodenode.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
public abstract class Vala.CodeNode {
	/**
	 * Parent of this code node.
	 */
	public weak CodeNode? parent_node { get; protected set; }

	/**
	 * References the location in the source file where this code node has
	 * been written.
	 */
	public SourceReference? source_reference { get; set; }

	public bool unreachable { get; set; }

	/**
	 * Contains all attributes that have been specified for this code node.
	 */
	public GLib.List<Attribute> attributes;

	public string type_name {
		get { return Type.from_instance (this).name (); }
	}

	public bool checked { get; set; }

	/**
	 * Specifies whether a fatal error has been detected in this code node.
	 */
	public bool error { get; set; }

	/**
	 * Specifies that this node or a child node may throw an exception.
	 */
	public bool tree_can_fail {
		get {
			var error_types = new ArrayList<DataType> ();
			get_error_types (error_types);
			return error_types.size > 0;
		}
	}

	private AttributeCache[] attributes_cache;

	static int last_temp_nr = 0;
	static int next_attribute_cache_index = 0;

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

	public virtual bool check (CodeContext context) {
		return true;
	}

	public virtual void emit (CodeGenerator codegen) {
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
	public unowned Attribute? get_attribute (string name) {
		// FIXME: use hash table
		foreach (unowned Attribute a in attributes) {
			if (a.name == name) {
				return a;
			}
		}

		return null;
	}

	/**
	 * Add attribute and append key/value pairs to an existing one.
	 *
	 * @param a  an attribute to add
	 */
	public void add_attribute (Attribute a) {
		unowned Attribute? old_a = get_attribute (a.name);
		if (old_a == null) {
			attributes.append (a);
		} else {
			var it = a.args.map_iterator ();
			while (it.next ()) {
				old_a.args.set (it.get_key (), it.get_value ());
			}
		}
	}

	unowned Attribute get_or_create_attribute (string name) {
		unowned Attribute? a = get_attribute (name);
		if (a == null) {
			var new_a = new Attribute (name, source_reference);
			attributes.append (new_a);
			a = new_a;
		}
		return (!) a;
	}

	/**
	 * Returns true if the specified attribute is set.
	 *
	 * @param  attribute attribute name
	 * @return           true if the node has the given attribute
	 */
	public bool has_attribute (string attribute) {
		return get_attribute (attribute) != null;
	}

	/**
	 * Returns true if the specified attribute argument is set.
	 *
	 * @param  attribute attribute name
	 * @param  argument  argument name
	 * @return           true if the attribute has the given argument
	 */
	public bool has_attribute_argument (string attribute, string argument) {
		unowned Attribute? a = get_attribute (attribute);
		if (a == null) {
			return false;
		}
		return a.has_argument (argument);
	}

	/**
	 * Sets the specified named attribute to this code node.
	 *
	 * @param name  attribute name
	 * @param value true to add the attribute, false to remove it
	 */
	public void set_attribute (string name, bool value, SourceReference? source_reference = null) {
		unowned Attribute? a = get_attribute (name);
		if (value && a == null) {
			attributes.append (new Attribute (name, source_reference));
		} else if (!value && a != null) {
			attributes.remove (a);
		}
	}

	/**
	 * Remove the specified named attribute argument
	 *
	 * @param attribute attribute name
	 * @param argument  argument name
	 */
	public void remove_attribute_argument (string attribute, string argument) {
		unowned Attribute? a = get_attribute (attribute);
		if (a != null) {
			a.args.remove (argument);
			if (a.args.size == 0) {
				attributes.remove (a);
			}
		}
	}

	/**
	 * Returns the string value of the specified attribute argument.
	 *
	 * @param attribute attribute name
	 * @param argument  argument name
	 * @return          string value
	 */
	public string? get_attribute_string (string attribute, string argument, string? default_value = null) {
		unowned Attribute? a = get_attribute (attribute);
		if (a == null) {
			return default_value;
		}
		return a.get_string (argument, default_value);
	}

	/**
	 * Returns the integer value of the specified attribute argument.
	 *
	 * @param attribute attribute name
	 * @param argument  argument name
	 * @return          integer value
	 */
	public int get_attribute_integer (string attribute, string argument, int default_value = 0) {
		unowned Attribute? a = get_attribute (attribute);
		if (a == null) {
			return default_value;
		}
		return a.get_integer (argument, default_value);
	}

	/**
	 * Returns the double value of the specified attribute argument.
	 *
	 * @param attribute attribute name
	 * @param argument  argument name
	 * @return          double value
	 */
	public double get_attribute_double (string attribute, string argument, double default_value = 0) {
		if (attributes == null) {
			return default_value;
		}
		unowned Attribute? a = get_attribute (attribute);
		if (a == null) {
			return default_value;
		}
		return a.get_double (argument, default_value);
	}

	/**
	 * Returns the bool value of the specified attribute argument.
	 *
	 * @param attribute attribute name
	 * @param argument  argument name
	 * @return          bool value
	 */
	public bool get_attribute_bool (string attribute, string argument, bool default_value = false) {
		if (attributes == null) {
			return default_value;
		}
		unowned Attribute? a = get_attribute (attribute);
		if (a == null) {
			return default_value;
		}
		return a.get_bool (argument, default_value);
	}

	/**
	 * Sets the string value of the specified attribute argument.
	 *
	 * @param attribute attribute name
	 * @param argument  argument name
	 * @param value     string value
	 */
	public void set_attribute_string (string attribute, string argument, string? value, SourceReference? source_reference = null) {
		if (value == null) {
			remove_attribute_argument (attribute, argument);
			return;
		}

		unowned Attribute a = get_or_create_attribute (attribute);
		a.add_argument (argument, "\"%s\"".printf (value));
	}

	/**
	 * Sets the integer value of the specified attribute argument.
	 *
	 * @param attribute attribute name
	 * @param argument  argument name
	 * @param value     integer value
	 */
	public void set_attribute_integer (string attribute, string argument, int value, SourceReference? source_reference = null) {
		unowned Attribute a = get_or_create_attribute (attribute);
		a.add_argument (argument, value.to_string ());
	}

	/**
	 * Sets the integer value of the specified attribute argument.
	 *
	 * @param attribute attribute name
	 * @param argument  argument name
	 * @param value     double value
	 */
	public void set_attribute_double (string attribute, string argument, double value, SourceReference? source_reference = null) {
		unowned Attribute a = get_or_create_attribute (attribute);
		a.add_argument (argument, value.format (new char[double.DTOSTR_BUF_SIZE]));
	}

	/**
	 * Sets the boolean value of the specified attribute argument.
	 *
	 * @param attribute attribute name
	 * @param argument  argument name
	 * @param value     bool value
	 */
	public void set_attribute_bool (string attribute, string argument, bool value, SourceReference? source_reference = null) {
		unowned Attribute a = get_or_create_attribute (attribute);
		a.add_argument (argument, value.to_string ());
	}

	/**
	 * Copy the string value of the specified attribute argument if available.
	 *
	 * @param source    codenode to copy from
	 * @param attribute attribute name
	 * @param argument  argument name
	 * @return          true if successful
	 */
	public bool copy_attribute_string (CodeNode source, string attribute, string argument) {
		if (source.has_attribute_argument (attribute, argument)) {
			set_attribute_string (attribute, argument, source.get_attribute_string (attribute, argument));
			return true;
		}
		return false;
	}

	/**
	 * Copy the integer value of the specified attribute argument if available.
	 *
	 * @param source    codenode to copy from
	 * @param attribute attribute name
	 * @param argument  argument name
	 * @return          true if successful
	 */
	public bool copy_attribute_integer (CodeNode source, string attribute, string argument) {
		if (source.has_attribute_argument (attribute, argument)) {
			set_attribute_integer (attribute, argument, source.get_attribute_integer (attribute, argument));
			return true;
		}
		return false;
	}

	/**
	 * Copy the double value of the specified attribute argument if available.
	 *
	 * @param source    codenode to copy from
	 * @param attribute attribute name
	 * @param argument  argument name
	 * @return          true if successful
	 */
	public bool copy_attribute_double (CodeNode source, string attribute, string argument) {
		if (source.has_attribute_argument (attribute, argument)) {
			set_attribute_double (attribute, argument, source.get_attribute_double (attribute, argument));
			return true;
		}
		return false;
	}

	/**
	 * Copy the boolean value of the specified attribute argument if available.
	 *
	 * @param source    codenode to copy from
	 * @param attribute attribute name
	 * @param argument  argument name
	 * @return          true if successful
	 */
	public bool copy_attribute_bool (CodeNode source, string attribute, string argument) {
		if (source.has_attribute_argument (attribute, argument)) {
			set_attribute_bool (attribute, argument, source.get_attribute_bool (attribute, argument));
			return true;
		}
		return false;
	}

	/**
	 * Returns the attribute cache at the specified index.
	 *
	 * @param index attribute cache index
	 * @return      attribute cache
	 */
	public unowned AttributeCache? get_attribute_cache (int index) {
		if (index >= attributes_cache.length) {
			return null;
		}
		return attributes_cache[index];
	}

	/**
	 * Sets the specified attribute cache to this code node.
	 *
	 * @param index attribute cache index
	 * @param cache attribute cache
	 */
	public void set_attribute_cache (int index, AttributeCache cache) {
		if (index >= attributes_cache.length) {
			attributes_cache.resize (index * 2 + 1);
		}
		attributes_cache[index] = cache;
	}

	/**
	 * Returns a string that represents this code node.
	 *
	 * @return a string representation
	 */
	public virtual string to_string () {
		var str = new StringBuilder ();

		str.append ("/* ");
		str.append (type_name);

		if (source_reference != null) {
			str.append ("@").append (source_reference.to_string ());
		}

		return str.append (" */").str;
	}

	public virtual void get_defined_variables (Collection<Variable> collection) {
	}

	public virtual void get_used_variables (Collection<Variable> collection) {
	}

	public virtual void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
	}

	public static string get_temp_name () {
		return "." + (++last_temp_nr).to_string ();
	}

	/**
	 * Returns a new cache index for accessing the attributes cache of code nodes
	 *
	 * @return a new cache index
	 */
	public static int get_attribute_cache_index () {
		return next_attribute_cache_index++;
	}
}

public class Vala.AttributeCache {
}
