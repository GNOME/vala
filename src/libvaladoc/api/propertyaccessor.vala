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

public class Valadoc.Api.PropertyAccessor : Symbol {
	private Vala.PropertyAccessor vpropacc;

	public PropertyAccessor (Vala.PropertyAccessor symbol, Property parent) {
		base (symbol, parent);
		this.vpropacc = symbol;
	}

	public override NodeType node_type { get { return NodeType.PROPERTY_ACCESSOR; } }

	public override void accept (Visitor visitor) {
	}

	public bool is_construct {
		get {
			return this.vpropacc.construction;
		}
	}

	public bool is_set {
		get {
			return this.vpropacc.writable;
		}
	}

	public bool is_get {
		get {
			return this.vpropacc.readable;
		}
	}

	public bool is_owned {
		get {
			return this.vpropacc.value_type.value_owned;
		}
	}

	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		if (!is_public) {
			signature.append_keyword (get_accessibility_modifier ());
		}
		if (is_set || is_construct) {
			if (is_construct) {
				signature.append_keyword ("construct");
			}
			if (is_set) {
				signature.append_keyword ("set");
			}
		} else if (is_get) {
			if (is_owned) {
				signature.append_keyword ("owned");
			}
			signature.append_keyword ("get");
		}

		return signature.get ();
	}
}
