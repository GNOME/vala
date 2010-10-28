/* valamemberinitializer.vala
 *
 * Copyright (C) 2007-2010  Jürg Billeter
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
 * Represents a member initializer, i.e. an element of an object initializer, in
 * the source code.
 */
public class Vala.MemberInitializer : CodeNode {
	/**
	 * Member name.
	 */
	public string name { get; set; }

	/**
	 * Initializer expression.
	 */
	public Expression initializer {
		get { return _initializer; }
		set {
			_initializer = value;
			_initializer.parent_node = this;
		}
	}

	/**
	 * The symbol this expression refers to.
	 */
	public weak Symbol symbol_reference { get; set; }

	Expression _initializer;

	/**
	 * Creates a new member initializer.
	 *
	 * @param name             member name
	 * @param initializer      initializer expression
	 * @param source_reference reference to source code
	 * @return                 newly created member initializer
	 */
	public MemberInitializer (string name, Expression initializer, SourceReference? source_reference = null) {
		this.initializer = initializer;
		this.source_reference = source_reference;
		this.name = name;
	}
	
	public override void accept (CodeVisitor visitor) {
		initializer.accept (visitor);
	}
	
	public override bool check (CodeContext context) {
		return initializer.check (context);
	}

	public override void emit (CodeGenerator codegen) {
		initializer.emit (codegen);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (initializer == old_node) {
			initializer = new_node;
		}
	}
}

