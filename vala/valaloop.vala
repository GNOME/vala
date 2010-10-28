/* valaloop.vala
 *
 * Copyright (C) 2009-2010  Jürg Billeter
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
 * Represents an endless loop.
 */
public class Vala.Loop : CodeNode, Statement {
	/**
	 * Specifies the loop body.
	 */
	public Block body {
		get {
			return _body;
		}
		set {
			_body = value;
			_body.parent_node = this;
		}
	}

	private Block _body;

	/**
	 * Creates a new loop.
	 *
	 * @param body   loop body
	 * @param source reference to source code
	 * @return       newly created while statement
	 */
	public Loop (Block body, SourceReference? source_reference = null) {
		this.body = body;
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_loop (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		body.accept (visitor);
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		body.check (context);

		add_error_types (body.get_error_types ());

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_loop (this);
	}
}

