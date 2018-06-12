/* array.vala
 *
 * Copyright (C) 2011  Florian Brosch
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


using Valadoc.Content;

/**
 * Represents an array declaration.
 */
public class Valadoc.Api.Array : Item {

	/**
	 * The element type.
	 */
	public Item data_type {
		set;
		get;
	}

	public Array (Item parent, Vala.ArrayType data) {
		base (data);

		this.parent = parent;
	}

	private inline bool element_is_owned () {
		TypeReference reference = data_type as TypeReference;
		if (reference == null) {
			return true;
		}

		return !reference.is_unowned && !reference.is_weak;
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		SignatureBuilder builder = new SignatureBuilder ();
		if (element_is_owned ()) {
			builder.append_content (data_type.signature);
		} else {
			builder.append ("(", false);
			builder.append_content (data_type.signature, false);
			builder.append (")", false);
		}
		builder.append ("[]", false);
		return builder.get ();
	}
}
