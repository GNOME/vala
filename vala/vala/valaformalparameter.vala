/* valaformalparameter.vala
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
 * Represents a formal parameter in method and callback signatures.
 */
public class Vala.FormalParameter : CodeNode {
	/**
	 * The parameter name.
	 */
	public string! name { get; set construct; }
	
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
	 * Creates a new formal parameter.
	 *
	 * @param name   parameter name
	 * @param type   parameter type
	 * @param source reference to source code
	 * @return       newly created formal parameter
	 */
	public construct (string! _name, TypeReference type, SourceReference source = null) {
		name = _name;
		type_reference = type;
		source_reference = source;
	}
	
	/**
	 * Creates a new ellipsis parameter representing an indefinite number of
	 * parameters.
	 */
	public construct with_ellipsis (SourceReference source = null) {
		ellipsis = true;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		if (!ellipsis) {
			type_reference.accept (visitor);
			
			if (default_expression != null) {
				default_expression.accept (visitor);
			}
		}
		
		visitor.visit_formal_parameter (this);
	}
}
