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


public class Valadoc.Array : Api.Item {
	private Vala.ArrayType vtype;

	public Api.Item data_type {
		private set;
		get;
	}

	public Array (Vala.ArrayType vtyperef, Api.Item parent) {
		this.vtype = vtyperef;
		this.parent = parent;

		Vala.DataType vntype = vtyperef.element_type;
		if (vntype is Vala.ArrayType) {
			this.data_type = new Array ((Vala.ArrayType) vntype, this);
		} else {
			this.data_type = new TypeReference (vntype, this);
		}
	}

	public void write (Langlet langlet, void* ptr, Api.Node parent) {
		langlet.write_array (this, ptr, parent);
	}

	protected override void resolve_type_references (Tree root) {
		if (this.data_type == null) {
			/*TODO:possible?*/;
		} else if (this.data_type is Array) {
			((Array)this.data_type).resolve_type_references (root);
		} else if (this.data_type is Pointer) {
			((Pointer)this.data_type).resolve_type_references (root);
		} else {
			((TypeReference)this.data_type).resolve_type_references (root);
		}
	}
}

