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
			if (symbol is Vala.Struct) {
				var vala_struct = symbol as Vala.Struct;
				return vala_struct.base_type == null && (vala_struct.is_boolean_type () || vala_struct.is_floating_type () || vala_struct.is_integer_type ());
			} else if (symbol is Vala.Class) {
				var vala_class = symbol as Vala.Class;
				return vala_class.base_class == null && vala_class.name == "string";
			}
			return false;
		}
	}

	internal override void process_comments (Settings settings, DocumentationParser parser) {
		var source_comment = ((Vala.TypeSymbol) symbol).comment;
		if (source_comment != null) {
			documentation = parser.parse (this, source_comment);
		}

		base.process_comments (settings, parser);
	}
}
