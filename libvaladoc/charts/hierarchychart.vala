/* hierarchychart.vala
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


public class Valadoc.Charts.Hierarchy : Charts.Chart {
	public Hierarchy (Factory factory, Api.Node node) {
		base (factory, node);
	}

	private void draw_implemented_interfaces (Gvc.Node child, Vala.Collection<Api.TypeReference> interfaces) {
		foreach (Api.TypeReference typeref in interfaces) {
			var parent = factory.create_interface (graph, (Api.Interface) typeref.data_type);
			factory.add_children (graph, parent, child);
		}
	}

	private void draw_parent_classes (Api.Class item, Gvc.Node? child = null) {
		var parent = factory.create_class (graph, item);

		if (child != null) {
			factory.add_children (graph, parent, child);
		}

		if (item.base_type != null) {
			draw_parent_classes ((Api.Class) item.base_type.data_type, parent);
		}

		draw_implemented_interfaces (parent, item.get_implemented_interface_list ());
	}

	private void draw_parent_structs (Api.Struct item, Gvc.Node? child = null) {
		var parent = factory.create_struct (graph, item);

		if (child != null) {
			factory.add_children (graph, parent, child);
		}

		if (item.base_type != null) {
			draw_parent_structs ((Api.Struct) item.base_type.data_type, parent);
		}
	}

	public override void visit_interface (Api.Interface item) {
		var iface = factory.create_interface (graph, item);

		if (item.base_type != null) {
			draw_parent_classes ((Api.Class) item.base_type.data_type, iface);
		}

		draw_implemented_interfaces (iface, item.get_implemented_interface_list ());
	}

	public override void visit_class (Api.Class item) {
		draw_parent_classes (item);
	}

	public override void visit_struct (Api.Struct item) {
		draw_parent_structs (item);
	}
}

