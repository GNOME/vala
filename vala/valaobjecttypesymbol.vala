/* valaobjecttypesymbol.vala
 *
 * Copyright (C) 2008-2009  Jürg Billeter
 * Copyright (C) 2008  Philip Van Hoof
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
 * 	Philip Van Hoof <pvanhoof@gnome.org>
 */


/**
 * Represents a runtime data type for objects and interfaces. This data type may
 * be defined in Vala source code or imported from an external library with a 
 * Vala API file.
 */
public abstract class Vala.ObjectTypeSymbol : TypeSymbol {
	private List<TypeParameter> type_parameters = new ArrayList<TypeParameter> ();

	public ObjectTypeSymbol (string name, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
	}

	public abstract List<Method> get_methods ();
	public abstract List<Signal> get_signals ();
	public abstract List<Property> get_properties ();

	/**
	 * Appends the specified parameter to the list of type parameters.
	 *
	 * @param p a type parameter
	 */
	public void add_type_parameter (TypeParameter p) {
		type_parameters.add (p);
		scope.add (p.name, p);
	}

	/**
	 * Returns a copy of the type parameter list.
	 *
	 * @return list of type parameters
	 */
	public List<TypeParameter> get_type_parameters () {
		return type_parameters;
	}

	public override int get_type_parameter_index (string name) {
		int i = 0;
		foreach (TypeParameter parameter in type_parameters) {
			if (parameter.name == name) {
				return i;
			}
			i++;
		}
		return -1;
	}

	public ObjectType get_this_type () {
		var result = new ObjectType (this);
		foreach (var type_parameter in get_type_parameters ()) {
			var type_arg = new GenericType (type_parameter);
			type_arg.value_owned = true;
			result.add_type_argument (type_arg);
		}
		return result;
	}

	/**
	 * Adds the specified method as a hidden member to this class,
	 * primarily used for default signal handlers.
	 *
	 * The hidden methods are not part of the `methods` collection.
	 *
	 * There may also be other use cases, eg, convert array.resize() to
	 * this type of method?
	 *
	 * @param m a method
	 */
	public void add_hidden_method (Method m) {
		if (m.binding == MemberBinding.INSTANCE) {
			if (m.this_parameter != null) {
				m.scope.remove (m.this_parameter.name);
			}
			m.this_parameter = new Parameter ("this", get_this_type ());
			m.scope.add (m.this_parameter.name, m.this_parameter);
		}
		if (!(m.return_type is VoidType) && m.get_postconditions ().size > 0) {
			if (m.result_var != null) {
				m.scope.remove (m.result_var.name);
			}
			m.result_var = new LocalVariable (m.return_type.copy (), "result");
			m.result_var.is_result = true;
		}

		scope.add (null, m);
	}
}
