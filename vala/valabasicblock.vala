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

/**
 * Represents a basic block, i.e. a straight-line piece of code without any
 * jumps or jump targets.
 */
public class Vala.BasicBlock {
	private List<CodeNode> nodes = new ArrayList<CodeNode> ();

	// control flow graph
	private List<weak BasicBlock> predecessors = new ArrayList<weak BasicBlock> ();
	private List<BasicBlock> successors = new ArrayList<BasicBlock> ();

	// dominator tree
	public BasicBlock parent { get; private set; }
	List<BasicBlock> children = new ArrayList<BasicBlock> ();
	Set<BasicBlock> df = new HashSet<BasicBlock> ();

	Set<PhiFunction> phi_functions = new HashSet<PhiFunction> ();

	public bool postorder_visited { get; set; }
	public int postorder_number { get; set; }

	public BasicBlock () {
	}

	public BasicBlock.entry () {
	}

	public BasicBlock.exit () {
	}

	public void add_node (CodeNode node) {
		nodes.add (node);
	}

	public List<CodeNode> get_nodes () {
		return nodes;
	}

	public void connect (BasicBlock target) {
		if (!successors.contains (target)) {
			successors.add (target);
		}
		if (!target.predecessors.contains (this)) {
			target.predecessors.add (this);
		}
	}

	public List<weak BasicBlock> get_predecessors () {
		return predecessors;
	}

	public List<weak BasicBlock> get_successors () {
		return successors;
	}

	public void add_child (BasicBlock block) {
		children.add (block);
		block.parent = this;
	}

	public List<BasicBlock> get_children () {
		return children;
	}

	public void add_dominator_frontier (BasicBlock block) {
		df.add (block);
	}

	public Set<BasicBlock> get_dominator_frontier () {
		return df;
	}

	public void add_phi_function (PhiFunction phi) {
		phi_functions.add (phi);
	}

	public Set<PhiFunction> get_phi_functions () {
		return phi_functions;
	}
}
