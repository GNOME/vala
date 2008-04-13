/* valanamespacereference.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * A reference to a namespace symbol.
 */
public class Vala.NamespaceReference : CodeNode {
	/**
	 * The name of the namespace this reference is referring to.
	 */
	public string name { get; set; }
	
	/**
	 * The resolved symbol of the namespace this reference is referring to.
	 */
	public weak Symbol namespace_symbol { get; set; }

	/**
	 * Creates a new namespace reference.
	 *
	 * @param name             namespace name
	 * @param source_reference reference to source code
	 * @return                 newly created namespace reference
	 */
	public NamespaceReference (string name, SourceReference source_reference) {
		this.source_reference = source_reference;
		this.name = name;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_namespace_reference (this);
	}
}
