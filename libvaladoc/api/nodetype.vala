/* node.vala
 *
 * Copyright (C) 2008-2009	Didier Villevalois
 * Copyright (C) 2007-20012	Florian Brosch
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


/**
 * Specifies the context of a node.
 */
public enum Valadoc.Api.NodeType {
	CLASS,
	CONSTANT,
	CREATION_METHOD,
	DELEGATE,
	ENUM,
	ENUM_VALUE,
	ERROR_CODE,
	ERROR_DOMAIN,
	FIELD,
	FORMAL_PARAMETER,
	INTERFACE,
	METHOD,
	NAMESPACE,
	PACKAGE,
	PROPERTY,
	PROPERTY_ACCESSOR,
	SIGNAL,
	STATIC_METHOD,
	STRUCT,
	TYPE_PARAMETER;

	public unowned string to_string () {
		switch (this) {
		case CLASS:
			return "CLASS";

		case CONSTANT:
			return "CONSTANT";

		case CREATION_METHOD:
			return "CREATION_METHOD";

		case DELEGATE:
			return "DELEGATE";

		case ENUM:
			return "ENUM";

		case ENUM_VALUE:
			return "ENUM_VALUE";

		case ERROR_CODE:
			return "ERROR_CODE";

		case ERROR_DOMAIN:
			return "ERROR_DOMAIN";

		case FIELD:
			return "FIELD";

		case FORMAL_PARAMETER:
			return "FORMAL_PARAMETER";

		case INTERFACE:
			return "INTERFACE";

		case METHOD:
			return "METHOD";

		case NAMESPACE:
			return "NAMESPACE";

		case PACKAGE:
			return "PACKAGE";

		case PROPERTY:
			return "PROPERTY";

		case PROPERTY_ACCESSOR:
			return "PROPERTY_ACCESSOR";

		case SIGNAL:
			return "SIGNAL";

		case STATIC_METHOD:
			return "STATIC_METHOD";

		case STRUCT:
			return "STRUCT";

		case TYPE_PARAMETER:
			return "TYPE_PARAMETER";

		default:
			assert_not_reached ();
		}
	}
}

