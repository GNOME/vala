/* apinode.vala
 * 
 * Valadoc - a documentation tool for vala.
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

using Vala;
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
	STRUCT,
	TYPE_PARAMETER
}

// TODO Drop DocumentedElement
public abstract class Valadoc.Api.Node : /*Api.Item*/DocumentedElement, Visitable {

	// TODO Drop DocumentElement
	/* public abstract string? name { owned get; } */

	public abstract NodeType node_type { get; }

	private Map<string,Node> per_name_children;
	private Map<Symbol,Node> per_symbol_children;
	private Map<NodeType?,Gee.List<Node>> per_type_children;

	public Node (Settings settings, Api.Node? parent) {
		this.settings = settings;
		this.parent = parent;

		per_name_children = new HashMap<string,Node> ();
		per_symbol_children = new HashMap<Symbol,Node> ();
		per_type_children = new HashMap<NodeType?,Gee.List<Node>> (int_hash, int_equal);
	}

	public abstract void accept (Doclet doclet);

	protected abstract bool is_type_visitor_accessible (Valadoc.Basic element);

	public abstract bool is_visitor_accessible ();

	public override string? get_filename () {
		return null;
	}

	protected void add_child (SymbolNode child) {
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

	protected override void parse_comments (DocumentationParser parser) {
		// TODO check is visitable to avoid unuseful processing

		foreach (Node node in per_name_children.values) {
			node.parse_comments (parser);
		}
	}

	public Gee.List<Node> get_children_by_type (NodeType type) {
		var children = new ArrayList<Node> ();

		Gee.List<Node> all_children = per_type_children.get (type);
		if (all_children != null) {
			foreach (Node child in all_children) {
				if (!child.is_type_visitor_accessible (this))
					continue ;

				children.add (child);
			}
		}

		return children.read_only_view;
	}

	public void accept_children_by_type (NodeType type, Doclet doclet) {
		Gee.List<Node> all_children = per_type_children.get (type);
		if (all_children != null) {
			foreach (Node node in all_children) {
				node.accept (doclet);
			}
		}
	}

	public void accept_children (NodeType[] types, Doclet doclet) {
		foreach (NodeType type in types) {
			accept_children_by_type (type, doclet);
		}
	}

	public Node? find_by_name (string name) {
		return per_name_children.get (name);
	}

	public Node? find_by_symbol (Symbol symbol) {
		return per_symbol_children.get (symbol);
	}

	
}
