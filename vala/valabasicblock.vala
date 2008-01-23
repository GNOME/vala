/* valabasicblock.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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
 * Represents a basic block, i.e. a straight-line piece of code without any
 * jumps or jump targets.
 */
public class Vala.BasicBlock : Object {
	private Gee.List<CodeNode> nodes = new ArrayList<CodeNode> ();

	private Gee.List<weak BasicBlock> predecessors = new ArrayList<weak BasicBlock> ();
	private Gee.List<BasicBlock> successors = new ArrayList<BasicBlock> ();

	public BasicBlock () {
	}

	public BasicBlock.entry () {
	}

	public BasicBlock.exit () {
	}

	public void add_node (CodeNode node) {
		nodes.add (node);
	}

	public void connect (BasicBlock target) {
		if (!successors.contains (target)) {
			successors.add (target);
		}
		if (!target.predecessors.contains (this)) {
			target.predecessors.add (this);
		}
	}

	public Gee.List<weak BasicBlock> get_predecessors () {
		return new ReadOnlyList<weak BasicBlock> (predecessors);
	}

	public Gee.List<weak BasicBlock> get_successors () {
		return new ReadOnlyList<weak BasicBlock> (successors);
	}
}
