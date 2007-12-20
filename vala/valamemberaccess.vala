/* valamemberaccess.vala
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
using Gee;

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
	public string! member_name { get; set; }

	/**
	 * Pointer member access.
	 */
	public bool pointer_member_access { get; set; }

	/**
	 * Represents access to an instance member without an actual instance,
	 * e.g. `MyClass.an_instance_method`.
	 */
	public bool prototype_access { get; set; }

	/**
	 * Specifies whether the member is used for object creation.
	 */
	public bool creation_member { get; set; }

	private Expression _inner;
	private Gee.List<DataType> type_argument_list = new ArrayList<DataType> ();
	
	/**
	 * Creates a new member access expression.
	 *
	 * @param inner            parent of the member
	 * @param member_name      member name
	 * @param source_reference reference to source code
	 * @return                 newly created member access expression
	 */
	public MemberAccess (construct Expression inner, construct string! member_name, construct SourceReference source_reference = null) {
	}

	public MemberAccess.simple (construct string! member_name, construct SourceReference source_reference = null) {
	}

	public MemberAccess.pointer (construct Expression inner, construct string! member_name, construct SourceReference source_reference = null) {
		pointer_member_access = true;
	}

	/**
	 * Appends the specified type as generic type argument.
	 *
	 * @param arg a type reference
	 */
	public void add_type_argument (DataType! arg) {
		type_argument_list.add (arg);
		arg.parent_node = this;
	}
	
	/**
	 * Returns a copy of the list of generic type arguments.
	 *
	 * @return type argument list
	 */
	public Collection<DataType> get_type_arguments () {
		return new ReadOnlyCollection<DataType> (type_argument_list);
	}
	
	public override void accept (CodeVisitor! visitor) {
		if (inner != null) {
			inner.accept (visitor);
		}
		
		foreach (DataType type_arg in type_argument_list) {
			type_arg.accept (visitor);
		}

		visitor.visit_member_access (this);
	}

	public override string! to_string () {
		if (inner == null) {
			return member_name;
		} else {
			return "%s.%s".printf (inner.to_string (), member_name);
		}
	}

	public override void replace_expression (Expression! old_node, Expression! new_node) {
		if (inner == old_node) {
			inner = new_node;
		}
	}

	public override bool is_pure () {
		// accessing property could have side-effects
		return (inner == null || inner.is_pure ()) && !(symbol_reference is Property);
	}

	public override void replace_type (DataType! old_type, DataType! new_type) {
		for (int i = 0; i < type_argument_list.size; i++) {
			if (type_argument_list[i] == old_type) {
				type_argument_list[i] = new_type;
				return;
			}
		}
	}
}
