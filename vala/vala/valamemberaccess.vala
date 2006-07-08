/* valamemberaccess.vala
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
 * Represents an access to a type member in the source code.
 */
public class Vala.MemberAccess : Expression {
	/**
	 * The parent of the member.
	 */
	public Expression inner { get; set; }
	
	/**
	 * The name of the member.
	 */
	public string! member_name { get; set construct; }
	
	/**
	 * Creates a new member access expression.
	 *
	 * @param inner  parent of the member
	 * @param member member name
	 * @param source reference to source code
	 * @return       newly created member access expression
	 */
	public static ref MemberAccess! new (Expression inner, string! member, SourceReference source) {
		return new MemberAccess (inner = inner, member_name = member, source_reference = source);
	}
	
	public override void accept (CodeVisitor! visitor) {
		if (inner != null) {
			inner.accept (visitor);
		}

		visitor.visit_member_access (this);
	}
}
