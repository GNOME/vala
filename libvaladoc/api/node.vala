/* node.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
 * Copyright (C) 2011 Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */


/**
 * Represents a node in the api tree.
 */
public abstract class Valadoc.Api.Node : Item, Documentation {
	protected bool do_document = false;
	private SourceFile file;

	/**
	 * The name of the node
	 */
	public string? name {
		private set;
		get;
	}

	public SourceFile get_source_file () {
		return file;
	}

	/**
	 * Returns the type of this node
	 */
	public abstract NodeType node_type { get; }

	private Vala.Map<string, Node> per_name_children;
	private Vala.Map<NodeType, Vala.List<Node>> per_type_children;


	protected Node (Node? parent, SourceFile? file, string? name, Vala.CodeNode? data) {
		base (data);

		per_name_children = new Vala.HashMap<string, Node> (str_hash, str_equal);
		per_type_children = new Vala.HashMap<NodeType, Vala.List<Node>> ();

		if (name != null && (Vala.Scanner.get_identifier_or_keyword (name, name.length) != Vala.TokenType.IDENTIFIER || name[0].isdigit ())) {
			this.name = "@" + name;
		} else {
			this.name = name;
		}

		this.parent = parent;
		this.file = file;
	}

	/**
	 * Visits this node with the specified Visitor.
	 *
	 * @param visitor the visitor to be called while traversing
	 */
	public abstract void accept (Visitor visitor);

	/**
	 * {@inheritDoc}
	 */
	// TODO: rename to is_visible
	public abstract bool is_browsable (Settings settings);

	/**
	 * {@inheritDoc}
	 */
	public string? get_filename () {
		if (file == null) {
			return null;
		}

		return file.relative_path;
	}

	public void add_child (Symbol child) {
		if (child.name != null) {
			if (child.name[0] == '@') {
				per_name_children.set (child.name.next_char (), child);
			} else {
				per_name_children.set (child.name, child);
			}
		} else {
			// Special case for the root namespace
			per_name_children.set ("", child);
		}

		Vala.List<Node> children = per_type_children.get (child.node_type);
		if (children == null) {
			children = new Vala.ArrayList<Node> ();
			per_type_children.set (child.node_type, children);
		}

		children.add (child);
	}

	/**
	 * {@inheritDoc}
	 */
	internal override void parse_comments (Settings settings, DocumentationParser parser) {
		do_document = true;

		foreach (Node node in per_name_children.get_values ()) {
			if (this.parent == node) {
				continue;
			}
			if (node.is_browsable (settings)) {
				node.parse_comments (settings, parser);
			}
		}
	}

	/**
	 * {@inheritDoc}
	 */
	internal override void check_comments (Settings settings, DocumentationParser parser) {

		foreach (Node node in per_name_children.get_values ()) {
			if (this.parent == node) {
				continue;
			}
			if (node.is_browsable (settings)) {
				node.check_comments (settings, parser);
			}
		}
	}


	/**
	 * Specifies whether this node has at least one visible child with the given type
	 *
	 * @param type a node type
	 */
	public bool has_visible_children_by_type (NodeType type, Settings settings) {
		Vala.List<Node>? all_children = per_type_children.get (type);
		if (all_children != null) {
			foreach (Node node in all_children) {
				if (node.is_browsable (settings)) {
					return true;
				}
			}
		}

		return false;
	}

	/**
	 * Specifies whether this node has at least one visible child with the given types
	 *
	 * @param types a list of node types
	 */
	public bool has_visible_children_by_types (NodeType[] types, Settings settings) {
		foreach (NodeType type in types) {
			if (has_visible_children_by_type (type, settings)) {
				return true;
			}
		}

		return false;
	}

	/**
	 * Specifies whether this node has at least one visible child
	 */
	public bool has_visible_children (Settings settings) {
		return has_visible_children_by_types (per_type_children.get_keys ().to_array (), settings);
	}

	/**
	 * Specifies whether this node has at least one child with the given type
	 *
	 * @param type a node type
	 */
	public bool has_children_by_type (NodeType type) {
		Vala.List<Node>? all_children = per_type_children.get (type);
		return all_children != null && !all_children.is_empty;
	}

	/**
	 * Specifies whether this node has at least one child with the given types
	 *
	 * @param types a list of node types
	 */
	public bool has_children (NodeType[] types) {
		foreach (NodeType type in types) {
			if (has_children_by_type (type)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Returns a list of all children with the given type.
	 *
	 * @param type a node type
	 * @param filtered specifies whether nodes which are not browsable should appear in the list
	 */
	public Vala.List<Node> get_children_by_type (NodeType type, bool filtered = true) {
		var children = new Vala.ArrayList<Node> ();

		Vala.List<Node> all_children = per_type_children.get (type);
		if (all_children != null) {
			foreach (Node node in all_children) {
				if (node.do_document || !filtered) {
					children.add (node);
				}
			}
		}

		return children;
	}

	/**
	 * Returns a list of all children with the given types.
	 *
	 * @param types a list of node types
	 * @param filtered specifies whether nodes which are not browsable should appear in the list
	 */
	public Vala.List<Node> get_children_by_types (NodeType[] types, bool filtered = true) {
		var children = new Vala.ArrayList<Node> ();

		foreach (NodeType type in types) {
			children.add_all (get_children_by_type (type, filtered));
		}

		return children;
	}

	/**
	 * Visits all children of this node with the given type with the specified Visitor.
	 *
	 * @param type a node type
	 * @param visitor the visitor to be called while traversing
	 * @param filtered specifies whether nodes which are not browsable should appear in the list
	 */
	public void accept_children_by_type (NodeType type, Visitor visitor, bool filtered = true) {
		Vala.List<Node> all_children = per_type_children.get (type);
		if (all_children != null) {
			foreach (Node node in all_children) {
				if (node.do_document || !filtered) {
					node.accept (visitor);
				}
			}
		}
	}

	/**
	 * Visits all children of this node with the given types with the specified Visitor.
	 *
	 * @param types a list of node types
	 * @param visitor the visitor to be called while traversing
	 * @param filtered specifies whether nodes which are not browsable should appear in the list
	 */
	public void accept_children (NodeType[] types, Visitor visitor, bool filtered = true) {
		foreach (NodeType type in types) {
			accept_children_by_type (type, visitor, filtered);
		}
	}

	/**
	 * Visits all children of this node with the specified Visitor.
	 *
	 * @param visitor the visitor to be called while traversing
	 * @param filtered specifies whether nodes which are not browsable should appear in the list
	 */
	public void accept_all_children (Visitor visitor, bool filtered = true) {
		foreach (Vala.List<Node> children in per_type_children.get_values ()) {
			if (this.parent == children[0]) {
				continue;
			}
			foreach (Node node in children) {
				if (node.do_document || !filtered) {
					node.accept (visitor);
				}
			}
		}
	}

	public Node? find_by_name (string name) {
		if (name[0] == '@') {
			return per_name_children.get (name.next_char ());
		} else {
			return per_name_children.get (name);
		}
	}

	private Namespace? _nspace = null;
	private Package? _package = null;
	private string _full_name = null;

	/**
	 * The corresponding namespace
	 */
	public Namespace? nspace {
		get {
			if (this._nspace == null) {
				Api.Item ast = this;
				while (ast is Valadoc.Api.Namespace == false) {
					ast = ast.parent;
					if (ast == null) {
						return null;
					}
				}
				this._nspace = (Valadoc.Api.Namespace)ast;
			}
			return this._nspace;
		}
	}

	/**
	 * The corresponding package such as a vapi or gir file
	 */
	public Package? package {
		get {
			if (this._package == null) {
				Api.Item ast = this;
				while (ast is Valadoc.Api.Package == false) {
					ast = ast.parent;
					if (ast == null) {
						return null;
					}
				}
				this._package = (Valadoc.Api.Package)ast;
			}
			return this._package;
		}
	}

	public Content.Comment? documentation {
		internal set;
		get;
	}

	/**
	 * Returns canonicalized absolute name (GLib.FileStream for instance)
	 */
	public string? get_full_name () {
		if (this._full_name == null) {
			if (this.name == null) {
				return null;
			}

			GLib.StringBuilder full_name = new GLib.StringBuilder (this.name);

			if (this.parent != null) {
				for (Item pos = this.parent; pos is Package == false ; pos = pos.parent) {
					string name = ((Node)pos).name;
					if (name != null) {
						full_name.prepend_unichar ('.');
						full_name.prepend (name);
					}
				}
			}
			this._full_name = full_name.str;
		}
		return this._full_name;
	}

	/**
	 * A comparison function used to sort nodes in alphabetical order
	 */
	public int compare_to (Node node) {
		return strcmp (name, node.name);
	}
}

