/* valatypeparameter.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Represents a generic type parameter in the source code.
 */
public class Vala.TypeParameter : TypeSymbol {
	List<DataType> type_constraint_list;
	static List<DataType> _empty_type_list;

	/**
	 * Creates a new generic type parameter.
	 *
	 * @param name              parameter name
	 * @param source_reference  reference to source code
	 * @return                  newly created generic type parameter
	 */
	public TypeParameter (string name, SourceReference? source_reference = null) {
		base (name, source_reference);
		access = SymbolAccessibility.PUBLIC;
	}

	/**
	 * Appends the specified type as generic type constraint.
	 *
	 * @param arg a type reference
	 */
	public void add_type_constraint (DataType arg) {
		if (type_constraint_list == null) {
			type_constraint_list = new ArrayList<DataType> ();
		}
		type_constraint_list.add (arg);
		arg.parent_node = this;
	}

	/**
	 * Returns the list of generic type constraints.
	 *
	 * @return type constraint list
	 */
	public unowned List<DataType> get_type_constraints () {
		if (type_constraint_list != null) {
			if (type_constraint_list.size > 0 && type_constraint_list[0] is GenericType) {
				return ((GenericType) type_constraint_list[0]).type_parameter.get_type_constraints ();
			}
			return type_constraint_list;
		}
		if (_empty_type_list == null) {
			_empty_type_list = new ArrayList<DataType> ();
		}
		return _empty_type_list;
	}

	public bool has_type_constraints () {
		if (type_constraint_list == null) {
			return false;
		}

		return type_constraint_list.size > 0;
	}

	public DataType? get_constrained_type () {
		if (!has_type_constraints ()) {
			return null;
		}

		unowned List<DataType> type_constraints = get_type_constraints ();
		if (type_constraints.size == 1) {
			return type_constraints[0].copy ();
		}
		foreach (DataType type_constraint in type_constraints) {
			if (type_constraint is ClassType) {
				return type_constraint.copy ();
			} else if (type_constraint is InterfaceType) {
				//FIXME Represent all given interfaces
				return type_constraint.copy ();
			}
		}

		return null;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_type_parameter (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (type_constraint_list != null && type_constraint_list.size > 0) {
			foreach (DataType type_constraint in type_constraint_list) {
				type_constraint.accept (visitor);
			}
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_constraint_list != null) {
			for (int i = 0; i < type_constraint_list.size; i++) {
				if (type_constraint_list[i] == old_type) {
					type_constraint_list[i] = new_type;
					return;
				}
			}
		}
	}

	/**
	 * Checks two type parameters for equality.
	 *
	 * @param param2 a type parameter
	 * @return      true if this type parameter is equal to param2, false
	 *              otherwise
	 */
	public bool equals (TypeParameter param2) {
		/* only type parameters with a common scope are comparable */
		if (!owner.is_subscope_of (param2.owner) && !param2.owner.is_subscope_of (owner)) {
			Report.error (source_reference, "internal error: comparing type parameters from different scopes");
			return false;
		}

		return name == param2.name && parent_symbol == param2.parent_symbol;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		bool class_constraint = false;
		foreach (var type in get_type_constraints ()) {
			if (type.symbol is Class) {
				if (class_constraint) {
					Report.error (source_reference, "a type parameter may only be constrained by a single class type");
					error = true;
					break;
				}
				class_constraint = true;
			}
		}

		if (type_constraint_list != null && type_constraint_list.size > 1) {
			Report.error (source_reference, "currently it is only supported to constrain a type parameter with one type");
			error = true;
		}
		return !error;
	}
}
