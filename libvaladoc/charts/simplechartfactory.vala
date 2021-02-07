/* simplechartfactory.vala
 *
 * Copyright (C) 2008  Florian Brosch
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
 * 	Florian Brosch <flo.brosch@gmail.com>
 */

[CCode (cname = "valadoc_compat_gvc_graph_new")]
extern Gvc.Graph valadoc_gvc_graph_new (string name);

[CCode (cname = "valadoc_compat_gvc_graph_create_edge")]
extern Gvc.Edge valadoc_gvc_graph_create_edge (Gvc.Graph graph, Gvc.Node from, Gvc.Node to);

public class Valadoc.Charts.SimpleFactory : Charts.Factory {
	protected virtual Gvc.Node configure_type (Gvc.Node node, Api.Node item) {
 		node.safe_set ("shape", "box", "");
		node.safe_set ("fontname", "Times", "");
		node.safe_set ("label", item.get_full_name (), "");
		return node;
	}

	public override Gvc.Graph create_graph (Api.Node item) {
		return valadoc_gvc_graph_new (item.get_full_name ());
	}

	public override Gvc.Context create_context (Gvc.Graph graph) {
		var context = new Gvc.Context ();
		context.layout_jobs (graph);
		context.layout (graph, "dot");
		return context;
	}

	public override Gvc.Node create_class (Gvc.Graph graph, Api.Class item) {
		var node = configure_type (create_type (graph, item), item);
		node.safe_set ("style", "bold", "");
		return node;
	}

	public override Gvc.Node create_struct (Gvc.Graph graph, Api.Struct item) {
		var node = configure_type (create_type (graph, item), item);
		node.safe_set ("style", "bold", "");
		return node;
	}

	public override Gvc.Node create_interface (Gvc.Graph graph, Api.Interface item) {
		return configure_type (create_type (graph, item), item);
	}

	public override Gvc.Node create_enum (Gvc.Graph graph, Api.Enum item) {
		return configure_type (create_type (graph, item), item);
	}

	public override Gvc.Node create_delegate (Gvc.Graph graph, Api.Delegate item) {
		return configure_type (create_type (graph, item), item);
	}

	public override Gvc.Node create_errordomain (Gvc.Graph graph, Api.ErrorDomain item) {
		return configure_type (create_type (graph, item), item);
	}

	public override Gvc.Node create_namespace (Gvc.Graph graph, Api.Namespace item) {
		return configure_type (create_type (graph, item), item);
	}

	public override Gvc.Edge add_children (Gvc.Graph graph, Gvc.Node parent, Gvc.Node child) {
		var edge = valadoc_gvc_graph_create_edge (graph, parent, child);
		edge.safe_set ("dir", "back", "");
		return edge;
	}
}

