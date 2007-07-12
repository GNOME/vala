/* valaexpression.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 * Base class for all code nodes that might be used as an expression.
 */
public abstract class Vala.Expression : CodeNode {
	/**
	 * The static type of this expression.
	 * 
	 * The semantic analyzer computes this value.
	 */
	public TypeReference static_type { get; set; }
	
	/*
	 * The static type this expression is expected to have.
	 *
	 * The semantic analyzer computes this value, lambda expressions use it.
	 */
	public TypeReference expected_type { get; set; }
	
	/**
	 * The symbol this expression refers to.
	 */
	public Symbol symbol_reference { get; set; }
	
	/**
	 * Specifies that this expression transfers ownership without a receiver
	 * being present.
	 *
	 * The memory manager computes this value, the code generator uses it.
	 */
	public bool ref_leaked { get; set; }
	
	/**
	 * Specifies that this expression is expected to transfer ownership but
	 * doesn't.
	 *
	 * The memory manager computes this value, the code generator uses it.
	 */
	public bool ref_missing { get; set; }
	
	/**
	 * Specifies that this expression successfully transfers ownership.
	 */
	public bool ref_sink { get; set; }

	/**
	 * Specifies that this expression may throw an exception.
	 */
	public bool can_fail { get; set; }

	/**
	 * Contains all temporary variables this expression requires for
	 * execution.
	 *
	 * The code generator sets and uses them for memory management.
	 */
	public List<VariableDeclarator> temp_vars;
}
