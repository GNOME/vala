/*
 * Valadoc.Api.- a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
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
 */

using Gee;


public interface Valadoc.Api.ClassHandler : Node {
	protected Class? find_vclass (Vala.Class vcl) {
		foreach (Class cl in get_class_list ()) {
			if (cl.is_vclass (vcl)) {
				return cl;
			}

			var tmp = cl.find_vclass (vcl);
			if (tmp != null) {
				return tmp;
			}
		}
		return null;
	}

	public Gee.Collection<Class> get_class_list () {
		return get_children_by_type (NodeType.CLASS);
	}

	public void visit_classes (Visitor visitor) {
		accept_children_by_type (NodeType.CLASS, visitor);
	}
}

