/* nodebuilder.vala
 * 
 * Valadoc.Api.- a documentation tool for vala.
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using Gee;

internal class Valadoc.Api.NodeBuilder : Vala.CodeVisitor {
	private Tree root;
	private Collection<Package> packages;
	private Node current_node;

	internal NodeBuilder (Tree root) {
		this.root = root;
		packages = root.get_package_list ();
		current_node = null;
	}

	private void process_children (Node node, Vala.Symbol element) {
		Node old_node = current_node;
		current_node = node;
		element.accept_children (this);
		current_node = old_node;
	}

	private Node get_parent_node_for (Vala.Symbol element) {
		if (current_node != null) {
			return current_node;
		}

		Vala.SourceFile source_file = element.source_reference.file;
		Package package = find_package_for (source_file);
		Namespace ns = package.get_namespace (element);
		return ns;
	}

	private Package? find_package_for (Vala.SourceFile source_file) {
		foreach (Package package in packages) {
			if (package.is_package_for_file (source_file))
				return package;
		}
		return null;
	}

	public override void visit_namespace (Vala.Namespace element) {
		element.accept_children (this);
	}

	public override void visit_class (Vala.Class element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new Class (element, parent);
		parent.add_child (node);

		process_children (node, element);
	}

	public override void visit_interface (Vala.Interface element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new Interface (element, parent);
		parent.add_child (node);

		process_children (node, element);
	}

	public override void visit_struct (Vala.Struct element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new Struct (element, parent);
		parent.add_child (node);

		process_children (node, element);
	}

	public override void visit_field (Vala.Field element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new Field (element, parent);
		parent.add_child (node);

		// Process field type

		process_children (node, element);
	}

	public override void visit_property (Vala.Property element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new Property (element, parent);
		parent.add_child (node);

		// Process property type

		process_children (node, element);
	}

	public override void visit_creation_method (Vala.CreationMethod element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new Method (element, parent);
		parent.add_child (node);

		// Process error types
		// Process return type

		process_children (node, element);
	}

	public override void visit_method (Vala.Method element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new Method (element, parent);
		parent.add_child (node);

		// Process error types
		// Process return type

		process_children (node, element);
	}

	public override void visit_signal (Vala.Signal element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new Signal (element, parent);
		parent.add_child (node);

		// Process return type

		process_children (node, element);
	}

	public override void visit_delegate (Vala.Delegate element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new Delegate (element, parent);
		parent.add_child (node);

		// Process error types
		// Process return type

		process_children (node, element);
	}

	public override void visit_enum (Vala.Enum element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new Enum (element, parent);
		parent.add_child (node);

		process_children (node, element);
	}

	public override void visit_enum_value (Vala.EnumValue element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new EnumValue (element, parent);
		parent.add_child (node);

		process_children (node, element);
	}

	public override void visit_constant (Vala.Constant element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new Constant (element, parent);
		parent.add_child (node);

		process_children (node, element);
	}

	public override void visit_error_domain (Vala.ErrorDomain element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new ErrorDomain (element, parent);
		parent.add_child (node);

		process_children (node, element);
	}

	public override void visit_error_code (Vala.ErrorCode element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new ErrorCode (element, parent);
		parent.add_child (node);

		process_children (node, element);
	}

	public override void visit_type_parameter (Vala.TypeParameter element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new TypeParameter (element, parent);
		parent.add_child (node);

		process_children (node, element);
	}

	public override void visit_formal_parameter (Vala.FormalParameter element) {
		Node parent = get_parent_node_for (element);

		Symbol node = new FormalParameter (element, parent);
		parent.add_child (node);

		process_children (node, element);
	}
}

