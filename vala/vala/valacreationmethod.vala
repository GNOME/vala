/* valacreationmethod.vala
 *
 * Copyright (C) 2007  Raffaele Sandrini
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
 * 	Raffaele Sandrini <j@bitron.ch>
 */

using GLib;

/**
 * Represents a type creation method.
 */
public class Vala.CreationMethod : Method {
	/**
	 * Specifies the number of parameters this creation method sets.
	 */
	public int n_construction_params { get; set; }
	
	private string cname;
	
	/**
	 * Creates a new method.
	 *
	 * @param name        method name
	 * @param source      reference to source code
	 * @return            newly created method
	 */
	public CreationMethod (string _name, SourceReference source = null) {
		name = _name;
		source_reference = source;
	}

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_creation_method (this);
		
		foreach (FormalParameter param in get_parameters()) {
			param.accept (visitor);
		}
		
		if (body != null) {
			body.accept (visitor);
		}

		visitor.visit_end_creation_method (this);
	}
	
	/**
	 * Returns the interface name of this method as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public override string! get_cname () {
		if (cname == null) {
			var parent = symbol.parent_symbol.node;
			if (parent is DataType) {
				if (name == null) {
					cname = "%snew".printf (((DataType) parent).get_lower_case_cprefix ());
				} else {
					cname = "%snew_%s".printf (((DataType) parent).get_lower_case_cprefix (), name);
				}
			}
		}
		return cname;
	}
}
