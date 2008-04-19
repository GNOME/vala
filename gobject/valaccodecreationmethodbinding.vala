/* valaccodecreationmethodbinding.vala
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
using Gee;

/**
 * The link between a creation method and generated code.
 */
public class Vala.CCodeCreationMethodBinding : CCodeMethodBinding {
	public CreationMethod creation_method { get; set; }

	public CCodeCreationMethodBinding (CCodeGenerator codegen, CreationMethod creation_method) {
		this.creation_method = creation_method;
		this.method = creation_method;
		this.codegen = codegen;
	}

	public override void emit () {
		var m = creation_method;

		if (m.body != null && codegen.current_type_symbol is Class && codegen.current_class.is_subtype_of (codegen.gobject_type)) {
			int n_params = 0;
			foreach (Statement stmt in m.body.get_statements ()) {
				if (!(stmt is ExpressionStatement) || ((ExpressionStatement) stmt).assigned_property () == null) {
					m.error = true;
					Report.error (stmt.source_reference, "class creation methods only allow property assignment statements");
					return;
				}
				if (((ExpressionStatement) stmt).assigned_property ().set_accessor.construction) {
					n_params++;
				}
			}
			m.n_construction_params = n_params;
		}

		base.emit ();
	}
}
