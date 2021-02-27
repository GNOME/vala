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

	private List<Symbol> members = new ArrayList<Symbol> ();

	// member symbols
	private List<Field> fields = new ArrayList<Field> ();
	private List<Method> methods = new ArrayList<Method> ();
	private List<Property> properties = new ArrayList<Property> ();
	private List<Signal> signals = new ArrayList<Signal> ();

	// inner types
	private List<Class> classes = new ArrayList<Class> ();
	private List<Interface> interfaces = new ArrayList<Interface> ();
	private List<Struct> structs = new ArrayList<Struct> ();
	private List<Enum> enums = new ArrayList<Enum> ();
	private List<Delegate> delegates = new ArrayList<Delegate> ();

	private List<Constant> constants = new ArrayList<Constant> ();

	protected ObjectTypeSymbol (string name, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
	}

	/**
	 * Returns the list of members.
	 *
	 * @return list of members
	 */
	public unowned List<Symbol> get_members () {
		return members;
	}

	/**
	 * Returns the list of fields.
	 *
	 * @return list of fields
	 */
	public unowned List<Field> get_fields () {
		return fields;
	}

	/**
	 * Returns the list of methods.
	 *
	 * @return list of methods
	 */
	public unowned List<Method> get_methods () {
		return methods;
	}

	/**
	 * Returns the list of properties.
	 *
	 * @return list of properties
	 */
	public unowned List<Property> get_properties () {
		return properties;
	}

	/**
	 * Returns the list of signals.
	 *
	 * @return list of signals
	 */
	public unowned List<Signal> get_signals () {
		return signals;
	}

	/**
	 * Adds the specified field as a member to this object-symbol.
	 *
	 * @param f a field
	 */
	public override void add_field (Field f) {
		fields.add (f);
		members.add (f);
		scope.add (f.name, f);
	}

	/**
	 * Adds the specified method as a member to this object-symbol.
	 *
	 * @param m a method
	 */
	public override void add_method (Method m) {
		methods.add (m);
		members.add (m);

		// explicit interface method implementation
		// virtual/abstract methods needs to be scoped and overridable
		if (this is Class && m.base_interface_type != null && !(m.is_abstract || m.is_virtual)) {
			scope.add (null, m);
		} else {
			scope.add (m.name, m);
		}
	}

	/**
	 * Adds the specified property as a member to this object-symbol.
	 *
	 * @param prop a property
	 */
	public override void add_property (Property prop) {
		properties.add (prop);
		members.add (prop);
		scope.add (prop.name, prop);
	}

	/**
	 * Adds the specified signal as a member to this object-symbol.
	 *
	 * @param sig a signal
	 */
	public override void add_signal (Signal sig) {
		signals.add (sig);
		members.add (sig);
		scope.add (sig.name, sig);
	}

	/**
	 * Returns the list of classes.
	 *
	 * @return list of classes
	 */
	public unowned List<Class> get_classes () {
		return classes;
	}

	/**
	 * Returns the list of interfaces.
	 *
	 * @return list of interfaces
	 */
	public unowned List<Interface> get_interfaces () {
		return interfaces;
	}

	/**
	 * Returns the list of structs.
	 *
	 * @return list of structs
	 */
	public unowned List<Struct> get_structs () {
		return structs;
	}

	/**
	 * Returns the list of enums.
	 *
	 * @return list of enums
	 */
	public unowned List<Enum> get_enums () {
		return enums;
	}

	/**
	 * Returns the list of delegates.
	 *
	 * @return list of delegates
	 */
	public unowned List<Delegate> get_delegates () {
		return delegates;
	}

	/**
	 * Adds the specified class as an inner class.
	 *
	 * @param cl a class
	 */
	public override void add_class (Class cl) {
		classes.add (cl);
		scope.add (cl.name, cl);
	}

	/**
	 * Adds the specified interface as an inner interface.
	 *
	 * @param iface an interface
	 */
	public override void add_interface (Interface iface) {
		interfaces.add (iface);
		scope.add (iface.name, iface);
	}

	/**
	 * Adds the specified struct as an inner struct.
	 *
	 * @param st a struct
	 */
	public override void add_struct (Struct st) {
		structs.add (st);
		scope.add (st.name, st);
	}

	/**
	 * Adds the specified enum as an inner enum.
	 *
	 * @param en an enum
	 */
	public override void add_enum (Enum en) {
		enums.add (en);
		scope.add (en.name, en);
	}

	/**
	 * Adds the specified delegate as an inner delegate.
	 *
	 * @param d a delegate
	 */
	public override void add_delegate (Delegate d) {
		delegates.add (d);
		scope.add (d.name, d);
	}

	/**
	 * Adds the specified constant as a member to this interface.
	 *
	 * @param c a constant
	 */
	public override void add_constant (Constant c) {
		constants.add (c);
		scope.add (c.name, c);
	}

	/**
	 * Returns the list of constants.
	 *
	 * @return list of constants
	 */
	public unowned List<Constant> get_constants () {
		return constants;
	}

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
	 * Returns the type parameter list.
	 *
	 * @return list of type parameters
	 */
	public unowned List<TypeParameter> get_type_parameters () {
		return type_parameters;
	}

	public bool has_type_parameters () {
		return (type_parameters != null && type_parameters.size > 0);
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
			m.this_parameter = new Parameter ("this", SemanticAnalyzer.get_this_type (m, this), m.source_reference);
			m.scope.add (m.this_parameter.name, m.this_parameter);
		}
		if (!(m.return_type is VoidType) && m.get_postconditions ().size > 0) {
			if (m.result_var != null) {
				m.scope.remove (m.result_var.name);
			}
			m.result_var = new LocalVariable (m.return_type.copy (), "result", null, m.source_reference);
			m.result_var.is_result = true;
		}

		scope.add (null, m);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (TypeParameter p in get_type_parameters ()) {
			p.accept (visitor);
		}

		/* process enums first to avoid order problems in C code */
		foreach (Enum en in get_enums ()) {
			en.accept (visitor);
		}

		foreach (Constant c in get_constants ()) {
			c.accept (visitor);
		}

		if (CodeContext.get ().abi_stability) {
			foreach (Symbol s in get_members ()) {
				s.accept (visitor);
			}
		} else {
			foreach (Field f in get_fields ()) {
				f.accept (visitor);
			}
			foreach (Method m in get_methods ()) {
				m.accept (visitor);
			}
			foreach (Property prop in get_properties ()) {
				prop.accept (visitor);
			}
			foreach (Signal sig in get_signals ()) {
				sig.accept (visitor);
			}
		}

		foreach (Class cl in get_classes ()) {
			cl.accept (visitor);
		}

		foreach (Interface iface in get_interfaces ()) {
			iface.accept (visitor);
		}

		foreach (Struct st in get_structs ()) {
			st.accept (visitor);
		}

		foreach (Delegate d in get_delegates ()) {
			d.accept (visitor);
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		if (!external_package && get_attribute ("DBus") != null && !context.has_package ("gio-2.0")) {
			error = true;
			Report.error (source_reference, "gio-2.0 package required for DBus support");
		}

		return !error;
	}
}
