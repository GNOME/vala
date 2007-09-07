/* valalockstatement.vala
 *
 * Copyright (C) 2006-2007  Raffaele Sandrini, Jürg Billeter
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
 * 	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;

/**
 * Represents a lock statement e.g. "lock (a) { f(a) }".
 */
public class Vala.LockStatement : CodeNode, Statement {
	/**
	 * Expression representing the resource to be locked.
	 */
	public Expression! resource { get; set construct; }
	
	/**
	 * The statement during its execution the resource is locked.
	 */
	public Block! body { get; set construct; }
	
	public LockStatement (construct Expression resource, construct Block body, construct SourceReference source_reference = null) {
	}
	
	public override void accept (CodeVisitor! visitor) {
		resource.accept (visitor);
		body.accept (visitor);
		visitor.visit_lock_statement (this);
	}
}
