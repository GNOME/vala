/*
 * Valadoc - a documentation tool for vala.
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


public class Valadoc.TypeParameter : Api.SymbolNode, ReturnTypeHandler {

	public TypeParameter (Vala.TypeParameter symbol, Api.Node parent) {
		base (symbol, parent);
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public override Api.NodeType node_type { get { return Api.NodeType.TYPE_PARAMETER; } }

	public override void accept (Doclet doclet) {
	}

	public void write (Langlet langlet, void* ptr) {
		langlet.write_type_parameter (this, ptr);
	}
}

