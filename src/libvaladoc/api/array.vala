/* array.vala
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

using Gee;
using Valadoc.Content;

public class Valadoc.Api.Array : Item {
	private Vala.ArrayType vtype;

	public Item data_type {
		private set;
		get;
	}

	public Array (Vala.ArrayType vtyperef, Item parent) {
		this.vtype = vtyperef;
		this.parent = parent;

		Vala.DataType vntype = vtyperef.element_type;
		if (vntype is Vala.ArrayType) {
			this.data_type = new Array ((Vala.ArrayType) vntype, this);
		} else {
			this.data_type = new TypeReference (vntype, this);
		}
	}

	internal override void resolve_type_references (Tree root) {
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

	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_content (data_type.signature)
			.append ("[]", false)
			.get ();
	}
}
