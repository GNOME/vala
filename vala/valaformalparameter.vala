/* valaformalparameter.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
public class Vala.FormalParameter : Symbol, Invokable {
	/**
	 * The parameter type.
	 */
	public TypeReference type_reference { get; set; }
	
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
	 * Creates a new formal parameter.
	 *
	 * @param name   parameter name
	 * @param type   parameter type
	 * @param source reference to source code
	 * @return       newly created formal parameter
	 */
	public FormalParameter (string! _name, TypeReference type, SourceReference source = null) {
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

	public Collection<FormalParameter> get_parameters () {
		if (!is_invokable ()) {
			return null;
		}
		
		var cb = (Callback) type_reference.data_type;
		return cb.get_parameters ();
	}
	
	public TypeReference get_return_type () {
		if (!is_invokable ()) {
			return null;
		}
		
		var cb = (Callback) type_reference.data_type;
		return cb.return_type;
	}

	public bool is_invokable () {
		return (type_reference.data_type is Callback);
	}
}
