/* valadestructor.vala
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
 * Represents a class or instance destructor.
 */
public class Vala.Destructor : Symbol {
	/**
	 * The body of this constructor.
	 */
	public Block body { get; set; }
	
	private bool _instance = true;
	
	/**
	 * Specifies whether this is an instance or a class destructor.
	 */
	public bool instance {
		get { return _instance; }
		set { _instance = value; }
	}
	
	/**
	 * Creates a new destructor.
	 *
	 * @param source_reference reference to source code
	 * @return                 newly created destructor
	 */
	public Destructor (SourceReference? source_reference = null) {
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_destructor (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (body != null) {
			body.accept (visitor);
		}
	}
}
