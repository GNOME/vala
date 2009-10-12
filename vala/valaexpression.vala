/* valaexpression.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Base class for all code nodes that might be used as an expression.
 */
public abstract class Vala.Expression : CodeNode {
	/**
	 * The static type of the value of this expression.
	 * 
	 * The semantic analyzer computes this value.
	 */
	public DataType value_type { get; set; }

	public DataType? formal_value_type { get; set; }

	/*
	 * The static type this expression is expected to have.
	 *
	 * The semantic analyzer computes this value, lambda expressions use it.
	 */
	public DataType target_type { get; set; }

	public DataType? formal_target_type { get; set; }

	/**
	 * The symbol this expression refers to.
	 */
	public weak Symbol symbol_reference { get; set; }

	/**
	 * Specifies that this expression is used as lvalue, i.e. the
	 * left hand side of an assignment.
	 */
	public bool lvalue { get; set; }

	/**
	 * Contains all temporary variables this expression requires for
	 * execution.
	 *
	 * The code generator sets and uses them for memory management.
	 */
	public ArrayList<LocalVariable> temp_vars = new ArrayList<LocalVariable> ();

	private List<CCodeExpression> array_sizes = new ArrayList<CCodeExpression> ();

	public CCodeExpression? delegate_target { get; set; }
	public CCodeExpression? delegate_target_destroy_notify { get; set; }

	/**
	 * Returns whether this expression is constant, i.e. whether this
	 * expression only consists of literals and other constants.
	 */
	public virtual bool is_constant () {
		return false;
	}

	/**
	 * Returns whether this expression is pure, i.e. whether this expression
	 * is free of side-effects.
	 */
	public abstract bool is_pure ();

	/**
	 * Returns whether this expression is guaranteed to be non-null.
	 */
	public virtual bool is_non_null () {
		return false;
	}

	/**
	 * Add an array size C code expression.
	 */
	public void append_array_size (CCodeExpression size) {
		array_sizes.add (size);
	}

	/**
	 * Get the C code expression for array sizes for all dimensions
	 * ascending from left to right.
	 */
	public List<CCodeExpression> get_array_sizes () {
		return new ReadOnlyList<CCodeExpression> (array_sizes);
	}

	public Statement? parent_statement {
		get {
			var expr = parent_node as Expression;
			var stmt = parent_node as Statement;
			var local = parent_node as LocalVariable;
			if (stmt != null) {
				return (Statement) parent_node;
			} else if (expr != null) {
				return expr.parent_statement;
			} else if (local != null) {
				return (Statement) local.parent_node;
			} else {
				return null;
			}
		}
	}

	public void insert_statement (Block block, Statement stmt) {
		block.insert_before (parent_statement, stmt);
	}
}
