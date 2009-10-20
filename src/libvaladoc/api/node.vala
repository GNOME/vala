/* apinode.vala
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

public enum Valadoc.Api.NodeType {
	CLASS,
	CONSTANT,
	CREATION_METHOD,
	DELEGATE,
	ENUM,
	ENUM_VALUE,
	ERROR_CODE,
	ERROR_DOMAIN,
	FIELD,
	FORMAL_PARAMETER,
	INTERFACE,
	METHOD,
	NAMESPACE,
	PACKAGE,
	PROPERTY,
	PROPERTY_ACCESSOR,
	SIGNAL,
	STATIC_METHOD,
	STRUCT,
	TYPE_PARAMETER
}

public abstract class Valadoc.Api.Node : Item, Visitable, Documentation {
	private bool do_document = false;

	public abstract string? name { owned get; }

	public abstract NodeType node_type { get; }

	private Map<string,Node> per_name_children;
	private Map<Vala.Symbol, Node> per_symbol_children;
	private Map<NodeType?, Gee.List<Node>> per_type_children;

	public Node (Node? parent) {
		this.parent = parent;

		per_name_children = new HashMap<string,Node> ();
		per_symbol_children = new HashMap<Vala.Symbol, Node> ();
		per_type_children = new HashMap<NodeType?, Gee.List<Node>> (int_hash, int_equal);
	}

	public abstract void accept (Visitor visitor);

	public abstract bool is_visitor_accessible (Settings settings);

	public virtual string? get_filename () {
		return null;
	}

	protected void add_child (Symbol child) {
		if (child.name != null) {
			per_name_children.set (child.name, child);
		} else {
			// Special case for the root namespace
			per_name_children.set ("", child);
		}

		per_symbol_children.set (child.symbol, child);

		Gee.List<Node> children = per_type_children.get (child.node_type);
		if (children == null) {
			per_type_children.set (child.node_type, new ArrayList<Node> ());
		}

		children = per_type_children.get (child.node_type);
		children.add (child);
	}

	protected override void resolve_type_references (Tree root) {
		foreach (Node node in per_name_children.values) {
			node.resolve_type_references (root);
		}
	}

	protected override void process_comments (Settings settings, DocumentationParser parser) {
		do_document = true;

		foreach (Node node in per_symbol_children.values) {
			if (node.is_visitor_accessible (settings)) {
				node.process_comments (settings, parser);
			}
		}
	}

	public bool has_children_by_type (NodeType type) {
		Gee.List<Node> all_children = per_type_children.get (type);
		return all_children != null && !all_children.is_empty;
	}

	public bool has_children (NodeType[] types) {
		foreach (NodeType type in types) {
			if (has_children_by_type (type)) {
				return true;
			}
		}
		return false;
	}

	public Gee.List<Node> get_children_by_type (NodeType type, bool filtered = true) {
		var children = new ArrayList<Node> ();

		Gee.List<Node> all_children = per_type_children.get (type);
		if (all_children != null) {
			foreach (Node node in all_children) {
				if (node.do_document || !filtered) {
					children.add (node);
				}
			}
		}

		return children.read_only_view;
	}

	public void accept_children_by_type (NodeType type, Visitor visitor) {
		Gee.List<Node> all_children = per_type_children.get (type);
		if (all_children != null) {
			foreach (Node node in all_children) {
				if (node.do_document) {
					node.accept (visitor);
				}
			}
		}
	}

	public void accept_children (NodeType[] types, Visitor visitor) {
		foreach (NodeType type in types) {
			accept_children_by_type (type, visitor);
		}
	}

	public void accept_all_children (Visitor visitor) {
		foreach (Gee.List<Node> children in per_type_children.values) {
			foreach (Node node in children) {
				if (node.do_document) {
					node.accept (visitor);
				}
			}
		}
	}

	public Node? find_by_name (string name) {
		return per_name_children.get (name);
	}

	public Node? find_by_symbol (Vala.Symbol symbol) {
		return per_symbol_children.get (symbol);
	}

	private Namespace? _nspace = null;
	private Package? _package = null;
	private string _full_name = null;

	public Namespace? nspace {
		get {
			if (this._nspace == null) {
				Api.Item ast = this;
				while (ast is Valadoc.Api.Namespace == false) {
					ast = ast.parent;
					if (ast == null)
						return null;
				}
				this._nspace = (Valadoc.Api.Namespace)ast;
			}
			return this._nspace;
		}
	}


	public Package? package {
		get {
			if (this._package == null) {
				Api.Item ast = this;
				while (ast is Valadoc.Api.Package == false) {
					ast = ast.parent;
					if (ast == null)
						return null;
				}
				this._package = (Valadoc.Api.Package)ast;
			}
			return this._package;
		}
	}

	public Content.Comment? documentation {
		protected set;
		get;
	}

	// rename to get_full_name
	public string? full_name () {
		if (this._full_name == null) {
			if (this.name == null)
				return null;

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
}

