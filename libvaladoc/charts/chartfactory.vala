/* chartfactory.vala
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

[CCode (cname = "valadoc_compat_gvc_graph_create_node")]
extern Gvc.Node valadoc_gvc_graph_create_node (Gvc.Graph graph, string name);

public abstract class Valadoc.Charts.Factory : Object {
	protected Gvc.Node create_type (Gvc.Graph graph, Api.Node item) {
		return valadoc_gvc_graph_create_node (graph, item.get_full_name ());
	}

	public abstract Gvc.Graph create_graph (Api.Node item);

	public abstract Gvc.Context create_context (Gvc.Graph graph);

	public abstract Gvc.Node create_class (Gvc.Graph graph, Api.Class item);

	public abstract Gvc.Node create_struct (Gvc.Graph graph, Api.Struct item);

	public abstract Gvc.Node create_interface (Gvc.Graph graph, Api.Interface item);

	public abstract Gvc.Node create_enum (Gvc.Graph graph, Api.Enum item);

	public abstract Gvc.Node create_delegate (Gvc.Graph graph, Api.Delegate item);

	public abstract Gvc.Node create_errordomain (Gvc.Graph graph, Api.ErrorDomain item);

	public abstract Gvc.Node create_namespace (Gvc.Graph graph, Api.Namespace item);

	public abstract Gvc.Edge add_children (Gvc.Graph graph, Gvc.Node parent, Gvc.Node child);
}

