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
using Valadoc.Content;

public class Valadoc.Api.Pointer : Item {
	private Vala.PointerType vtype;

	public Item data_type {
		private set;
		get;
	}

	public Pointer (Vala.PointerType vtyperef, Item parent) {
		this.vtype = vtyperef;
		this.parent = parent;

		Vala.DataType vntype = vtype.base_type;
		if (vntype is Vala.PointerType) {
			this.data_type = new Pointer ((Vala.PointerType) vntype, this);
		} else if (vntype is Vala.ArrayType) {
			this.data_type = new Array ((Vala.ArrayType) vntype, this);
		} else {
			this.data_type = new TypeReference (vntype, this);
		}
	}

	protected override void resolve_type_references (Tree root) {
		Api.Item type = this.data_type;
		if (type == null) {
			;
		} else if (type is Array) {
			((Array) type).resolve_type_references (root);
		} else if (type is Pointer) {
			((Pointer) type ).resolve_type_references (root);
		} else {
			((TypeReference) type).resolve_type_references (root);
		}
	}

	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_content (data_type.signature)
			.append ("*", false)
			.get ();
	}
}
