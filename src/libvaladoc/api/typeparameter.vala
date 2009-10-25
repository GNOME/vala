/* typeparameter.vala
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

public class Valadoc.Api.TypeParameter : Symbol {

	public TypeParameter (Vala.TypeParameter symbol, Node parent) {
		base (symbol, parent);
	}

	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_symbol (this)
			.get ();
	}

	public override NodeType node_type { get { return NodeType.TYPE_PARAMETER; } }

	public override void accept (Visitor visitor) {
		visitor.visit_type_parameter (this);
	}
}

