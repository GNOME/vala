/* valapropertyaccessor.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
 * Represents a get or set accessor of a property in the source code.
 */
public class Vala.PropertyAccessor : CodeNode {
	/**
	 * Specifies whether this accessor may be used to get the property.
	 */
	public bool readable { get; set; }
	
	/**
	 * Specifies whether this accessor may be used to set the property.
	 */
	public bool writable { get; set; }
	
	/**
	 * Specifies whether this accessor may be used to construct the
	 * property.
	 */
	public bool construction { get; set; }
	
	/**
	 * The accessor body.
	 */
	public Statement body { get; set; }
	
	/**
	 * Represents the generated value parameter in a set accessor.
	 */
	public FormalParameter value_parameter { get; set; }
	
	/**
	 * Creates a new property accessor.
	 *
	 * @param readable     true if get accessor, false otherwise
	 * @param writable     true if set accessor, false otherwise
	 * @param construction true if construct accessor, false otherwise
	 * @param body         accessor body
	 * @param source       reference to source code
	 * @return             newly created property accessor
	 */
	public construct (bool _readable, bool _writable, bool _construction, Statement _body, SourceReference source) {
		readable = _readable;
		writable = _writable;
		construction = _construction;
		body = _body;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_property_accessor (this);

		if (body != null) {
			body.accept (visitor);
		}
	
		visitor.visit_end_property_accessor (this);
	}
}
