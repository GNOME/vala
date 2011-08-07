/* valaccodetransformer.vala
 *
 * Copyright (C) 2012  Luca Bruno
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
 * 	Luca Bruno <lucabru@src.gnome.org>
 */

/**
 * Code visitor for simplyfing the code tree for the C codegen.
 */
public class Vala.CCodeTransformer : CodeTransformer {
	public override void visit_constant (Constant c) {
		c.active = true;
		c.accept_children (this);
	}

	public override void visit_method (Method m) {
		if (m.body == null) {
			return;
		}

		m.accept_children (this);
	}

	public override void visit_creation_method (CreationMethod m) {
		if (m.body == null) {
			return;
		}

		m.accept_children (this);
	}

	public override void visit_block (Block b) {
		b.accept_children (this);

		foreach (LocalVariable local in b.get_local_variables ()) {
			local.active = false;
		}
		foreach (Constant constant in b.get_local_constants ()) {
			constant.active = false;
		}
	}

	public override void visit_local_variable (LocalVariable local) {
		local.active = true;
		local.accept_children (this);
	}

	public override void visit_expression (Expression expr) {
		if (expr in context.analyzer.replaced_nodes) {
			return;
		}

		base.visit_expression (expr);
	}
}
