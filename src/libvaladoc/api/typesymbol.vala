/* typesymbol.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
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
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */

using Gee;

public abstract class Valadoc.Api.TypeSymbol : Symbol {

	public TypeSymbol (Vala.TypeSymbol symbol, Node parent) {
		base (symbol, parent);
	}

	public bool is_basic_type {
		get {
			if (this.symbol is Vala.Struct) {
				unowned Vala.Struct mystruct = (Vala.Struct) this.symbol;
				return mystruct.base_type == null && (mystruct.is_boolean_type () || mystruct.is_floating_type () || mystruct.is_integer_type ());
			} else if (this.symbol is Vala.Class) {
				unowned Vala.Class myclass = (Vala.Class) this.symbol;
				return myclass.base_class == null && myclass.name == "string";
			}
			return false;
		}
	}

	protected override void process_comments (Settings settings, DocumentationParser parser) {
		var source_comment = ((Vala.TypeSymbol) symbol).comment;
		if (source_comment != null) {
			documentation = parser.parse (this, source_comment);
		}

		base.process_comments (settings, parser);
	}
}
