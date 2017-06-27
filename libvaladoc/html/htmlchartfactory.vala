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



public class Valadoc.Html.SimpleChartFactory : Charts.SimpleFactory {
	private Settings _settings;
	private Api.Node _container;
	private LinkHelper _linker;

	public SimpleChartFactory (Settings settings, LinkHelper linker) {
		_settings = settings;
		_linker = linker;
	}

	public override Gvc.Graph create_graph (Api.Node item) {
		var graph = base.create_graph (item);
		_container = item;
		return graph;
	}

	protected override Gvc.Node configure_type (Gvc.Node node, Api.Node item) {
		base.configure_type (node, item);

		if (_container != null) {
			var link = _linker.get_relative_link (_container, item, _settings);
			if (link != null) {
				node.safe_set ("URL", link, "");
			}
		}

		return node;
	}
}

