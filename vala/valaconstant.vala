/* valaconstant.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 * Represents a type member with a constant value.
 */
public class Vala.Constant : Member, Lockable {
	/**
	 * The data type of this constant.
	 */
	public TypeReference! type_reference { get; set; }

	/**
	 * The value of this constant.
	 */
	public Expression initializer { get; set; }
	
	/**
	 * Specifies the accessibility of this constant. Public accessibility
	 * doesn't limit access. Default accessibility limits access to this
	 * program or library. Private accessibility limits access to instances
	 * of the contained type.
	 */
	public MemberAccessibility access;
	
	private string cname;
	
	private bool lock_used = false;

	/**
	 * Creates a new constant.
	 *
	 * @param name             constant name
	 * @param type_reference   constant type
	 * @param initializer      constant value
	 * @param source_reference reference to source code
	 * @return                 newly created constant
	 */
	public Constant (construct string! name, construct TypeReference! type_reference, construct Expression initializer, construct SourceReference source_reference) {
	}

	public override void accept (CodeVisitor! visitor) {
		visitor.visit_member (this);

		visitor.visit_constant (this);
	}

	public override void accept_children (CodeVisitor! visitor) {
		type_reference.accept (visitor);

		if (initializer != null) {		
			initializer.accept (visitor);
		}
	}

	/**
	 * Returns the name of this constant as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public string! get_cname () {
		if (cname == null) {
			if (parent_symbol == null) {
				// global constant
				cname = name;
			} else {
				cname = "%s%s".printf (parent_symbol.get_lower_case_cprefix ().up (), name);
			}
		}
		return cname;
	}
	
	public bool get_lock_used () {
		return lock_used;
	}
	
	public void set_lock_used (bool used) {
		lock_used = used;
	}
}
