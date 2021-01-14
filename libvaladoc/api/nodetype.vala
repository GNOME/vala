/* node.vala
 *
 * Copyright (C) 2008-2009	Didier Villevalois
 * Copyright (C) 2007-2012	Florian Brosch
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
	TYPE_PARAMETER
}

