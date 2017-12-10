/* chart.vala
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

[CCode (cname = "valadoc_compat_gvc_init")]
extern void valadoc_gvc_init ();

public class Valadoc.Charts.Chart : Api.Visitor {
	protected Gvc.Context context;
	protected Gvc.Graph graph;
	protected Factory factory;

	static construct {
		valadoc_gvc_init ();
	}

	public Chart (Factory factory, Api.Node node) {
		graph = factory.create_graph (node);
		this.factory = factory;
		node.accept (this);
	}

	public void save (string file_name, string file_type = "png") {
		if (context == null) {
			context = factory.create_context (graph);
		}
		context.render_filename (graph, file_type, file_name);
	}

	public void write (GLib.FileStream file, string file_type) {
		if (context == null) {
			context = factory.create_context (graph);
		}
		context.render (graph, file_type, file);
	}

	public uint8[]? write_buffer (string file_type) {
		if (context == null) {
			context = factory.create_context (graph);
		}

		uint8[]? data;

		/* This will return null in data if it fails. */
		context.render_data (graph, file_type, out data);
		return data;
	}

	~Chart () {
		if (context != null) {
			context.free_layout (graph);
		}
	}
}

