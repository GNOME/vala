/* valaccodebinding.vala
 *
 * Copyright (C) 2007-2008  Jürg Billeter
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
 * The link between a source code node and generated code.
 */
public abstract class Vala.CCodeBinding : CodeBinding {
	/**
	 * The C Code generator.
	 */
	public CCodeGenerator codegen { get; set; }

	public CCodeModule head {
		get { return codegen.head; }
	}

	/**
	 * Generate code for this source code node.
	 */
	public virtual void emit () {
	}

	public CCodeBinding? code_binding (CodeNode node) {
		return (CCodeBinding) node.get_code_binding (codegen);
	}

	public CCodeElementAccessBinding element_access_binding (ElementAccess node) {
		return (CCodeElementAccessBinding) node.get_code_binding (codegen);
	}

	public CCodeAssignmentBinding assignment_binding (Assignment node) {
		return (CCodeAssignmentBinding) node.get_code_binding (codegen);
	}
}
