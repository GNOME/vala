/* valaformalparameter.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;
using Gee;

/**
 * Represents a formal parameter in method and callback signatures.
 */
public class Vala.FormalParameter : Symbol {
	/**
	 * The parameter type.
	 */
	public DataType type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}
	
	/**
	 * Specifies whether the methods accepts an indefinite number of
	 * parameters.
	 */
	public bool ellipsis { get; set; }
	
	/**
	 * Specifies the expression used when the caller doesn't supply an
	 * argument for this parameter.
	 */
	public Expression default_expression { get; set; }
	
	/**
	 * Specifies whether the array length should implicitly be passed
	 * if the parameter type is an array.
	 */
	public bool no_array_length { get; set; }
	
	/**
	 * Specifies whether this parameter holds a value to be assigned to a
	 * construct property. This is only allowed in CreationMethod headers.
	 */
	public bool construct_parameter { get; set; }

	/**
	 * Specifies the position of the parameter in the C function.
	 */
	public double cparameter_position { get; set; }

	/**
	 * Specifies the position of the array length parameter in the C
	 * function.
	 */
	public double carray_length_parameter_position { get; set; }

	/**
	 * Specifies the position of the delegate target parameter in the C
	 * function.
	 */
	public double cdelegate_target_parameter_position { get; set; }

	private DataType _data_type;

	/**
	 * Creates a new formal parameter.
	 *
	 * @param name   parameter name
	 * @param type   parameter type
	 * @param source reference to source code
	 * @return       newly created formal parameter
	 */
	public FormalParameter (string! _name, DataType type, SourceReference source = null) {
		name = _name;
		type_reference = type;
		source_reference = source;
	}
	
	/**
	 * Creates a new ellipsis parameter representing an indefinite number of
	 * parameters.
	 */
	public FormalParameter.with_ellipsis (SourceReference source = null) {
		ellipsis = true;
		source_reference = source;
	}

	construct {
		access = SymbolAccessibility.PUBLIC;
	}

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_formal_parameter (this);
	}

	public override void accept_children (CodeVisitor! visitor) {
		if (!ellipsis) {
			type_reference.accept (visitor);
			
			if (default_expression != null) {
				default_expression.accept (visitor);
			}
		}
	}

	public override void replace_type (DataType! old_type, DataType! new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}

	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("array_length_pos")) {
			carray_length_parameter_position = a.get_double ("array_length_pos");
		}
		if (a.has_argument ("delegate_target_pos")) {
			cdelegate_target_parameter_position = a.get_double ("delegate_target_pos");
		}
	}

	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			}
		}
	}
}
