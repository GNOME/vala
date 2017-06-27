/* node.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
 * Copyright (C) 20011 Florian Brosch
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
public abstract class Valadoc.Api.Node : Item, Browsable, Documentation {
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


	public Node (Node? parent, SourceFile? file, string? name, void* data) {
		base (data);

		per_name_children = new Vala.HashMap<string, Node> (str_hash, str_equal);
		per_type_children = new Vala.HashMap<NodeType, Vala.List<Node>> ();

		if (name != null && (is_keyword (name) || name[0].isdigit ())) {
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

	private bool is_keyword (string name) {
		switch (name[0]) {
		case 'a':
			switch (name[1]) {
			case 'b':
				return name == "abstract";

			case 's':
				if (name[2] == '\0') {
					return true;
				}

				return name == "async";
			}
			break;

		case 'b':
			switch (name[1]) {
			case 'a':
				return name == "base";

			case 'r':
				return name == "break";
			}
			break;

		case 'c':
			switch (name[1]) {
			case 'a':
				switch (name[2]) {
				case 's':
					return name == "case";

				case 't':
					return name == "catch";
				}
				break;

			case 'l':
				return name == "class";

			case 'o':
				if (name[2] != 'n') {
					return false;
				}

				switch (name[3]) {
				case 's':
					if (name[4] == 't') {
						switch (name[5]) {
						case '\0':
							return true;

						case 'r':
							return name == "construct";
						}
					}
					break;

				case 't':
					return name == "continue";
				}
				break;
			}
			break;

		case 'd':
			switch (name[1]) {
			case 'e':
				switch (name[2]) {
				case 'f':
					return name == "default";

				case 'l':
					if (name[3] != 'e') {
						return false;
					}

					switch (name[4]) {
					case 'g':
						return name == "delegate";

					case 't':
						return name == "delete";
					}
					break;
				}
				break;

			case 'o':
				return name[2] == '\0';

			case 'y':
				return name == "dynamic";
			}
			break;

		case 'e':
			switch (name[1]) {
			case 'l':
				return name == "else";

			case 'n':
				switch (name[2]) {
				case 's':
					return name == "ensures";

				case 'u':
					return name == "enum";
				}
				break;

			case 'r':
				return name == "errordomain";

			case 'x':
				return name == "extern";
			}
			break;

		case 'f':
			switch (name[1]) {
			case 'a':
				return name == "false";

			case 'i':
				return name == "finally";

			case 'o':
				if (name[2] != 'r') {
					return false;
				}

				switch (name[3]) {
				case '\0':
					return true;

				case 'e':
					return name == "foreach";
				}
				break;
			}
			break;

		case 'g':
			return name == "get";

		case 'i':
			switch (name[1]) {
			case 'f':
				return name[2] == '\0';

			case 'n':
				switch (name[2]) {
				case '\0':
					return true;

				case 'l':
					return name == "inline";

				case 't':
					return name == "interface" || name == "internal";
				}
				break;

			case 's':
				return name[2] == '\0';
			}
			break;

		case 'l':
			return name == "lock";

		case 'n':
			switch (name[1]) {
			case 'a':
				return name == "namespace";

			case 'e':
				return name == "new";

			case 'u':
				return name == "null";
			}
			break;

		case 'o':
			switch (name[1]) {
			case 'u':
				return name == "out";

			case 'v':
				return name == "override";

			case 'w':
				return name == "owned";
			}
			break;

		case 'p':
			switch (name[1]) {
			case 'a':
				return name == "params";

			case 'r':
				switch (name[2]) {
				case 'i':
					return name == "private";

				case 'o':
					return name == "protected";
				}
				break;
			case 'u':
				return name == "public";
			}
			break;

		case 'r':
			if (name[1] != 'e') {
				return false;
			}

			switch (name[2]) {
			case 'f':
				return name[3] == '\0';

			case 'q':
				return name == "requires";

			case 't':
				return name == "return";
			}
			break;

		case 's':
			switch (name[1]) {
			case 'e':
				switch (name[2]) {
				case 'a':
					return name == "sealed";

				case 't':
					return name[3] == '\0';
				}
				break;

			case 'i':
				switch (name[2]) {
				case 'g':
					return name == "signal";
				case 'z':
					return name == "sizeof";
				}
				break;

			case 't':
				switch (name[2]) {
				case 'a':
					return name == "static";

				case 'r':
					return name == "struct";
				}
				break;

			case 'w':
				return name == "switch";
			}
			break;

		case 't':
			switch (name[1]) {
			case 'h':
				switch (name[2]) {
				case 'i':
					return name == "this";

				case 'r':
					if (name[3] == 'o' && name[4] == 'w') {
						return name[5] == '\0' || (name[5] == 's' && name[6] == '\0');
					}
					break;
				}
				break;

			case 'r':
				switch (name[2]) {
				case 'u':
					return name == "true";

				case 'y':
					return name[3] == '\0';
				}
				break;

			case 'y':
				return name == "typeof";
			}
			break;

		case 'u':
			switch (name[1]) {
			case 'n':
				return name == "unowned";

			case 's':
				return name == "using";
			}
			break;

		case 'v':
			switch (name[1]) {
			case 'a':
				return name == "var";

			case 'i':
				return name == "virtual";

			case 'o':
				switch (name[2]) {
				case 'i':
					return name == "void";

				case 'l':
					return name == "volatile";
				}
				break;
			}
			break;

		case 'w':
			switch (name[1]) {
			case 'e':
				return name == "weak";

			case 'h':
				return name == "while";
			}
			break;

		case 'y':
			return name == "yield";
		}

		return false;
	}
}

