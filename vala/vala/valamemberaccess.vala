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
	public Expression inner {
		get {
			return _inner;
		}
		set {
			_inner = value;
			if (_inner != null) {
				_inner.parent_node = this;
			}
		}
	}
	
	/**
	 * The name of the member.
	 */
	public string! member_name { get; set construct; }

	private Expression _inner;
	private List<TypeReference> type_argument_list;
	
	/**
	 * Creates a new member access expression.
	 *
	 * @param inner  parent of the member
	 * @param member member name
	 * @param source reference to source code
	 * @return       newly created member access expression
	 */
	public construct (Expression _inner, string! member, SourceReference source = null) {
		inner = _inner;
		member_name = member;
		source_reference = source;
	}

	public construct simple (string! member, SourceReference source = null) {
		member_name = member;
		source_reference = source;
	}
	
	/**
	 * Appends the specified type as generic type argument.
	 *
	 * @param arg a type reference
	 */
	public void add_type_argument (TypeReference! arg) {
		type_argument_list.append (arg);
	}
	
	/**
	 * Returns a copy of the list of generic type arguments.
	 *
	 * @return type argument list
	 */
	public ref List<weak TypeReference> get_type_arguments () {
		return type_argument_list.copy ();
	}
	
	public override void accept (CodeVisitor! visitor) {
		if (inner != null) {
			inner.accept (visitor);
		}

		visitor.visit_member_access (this);
	}

	public override ref string! to_string () {
		if (inner == null) {
			return member_name;
		} else {
			return "%s.%s".printf (inner.to_string (), member_name);
		}
	}

	public override void replace (CodeNode! old_node, CodeNode! new_node) {
		if (inner == old_node) {
			inner = (Expression) new_node;
		}
	}
}
