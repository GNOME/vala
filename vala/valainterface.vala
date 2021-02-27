/* valainterface.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
 * Represents an interface declaration in the source code.
 */
public class Vala.Interface : ObjectTypeSymbol {
	private List<DataType> prerequisites = new ArrayList<DataType> ();

	private List<Symbol> virtuals = new ArrayList<Symbol> ();

	/**
	 * Creates a new interface.
	 *
	 * @param name              type name
	 * @param source_reference  reference to source code
	 * @return                  newly created interface
	 */
	public Interface (string name, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
	}

	/**
	 * Adds the specified interface or class to the list of prerequisites of
	 * this interface.
	 *
	 * @param type an interface or class reference
	 */
	public void add_prerequisite (DataType type) {
		prerequisites.add (type);
		type.parent_node = this;
	}

	/**
	 * Returns the base type list.
	 *
	 * @return list of base types
	 */
	public unowned List<DataType> get_prerequisites () {
		return prerequisites;
	}

	/**
	 * Adds the specified method as a member to this interface.
	 *
	 * @param m a method
	 */
	public override void add_method (Method m) {
		if (m is CreationMethod) {
			Report.error (m.source_reference, "construction methods may only be declared within classes and structs");

			m.error = true;
			return;
		}
		if (m.binding != MemberBinding.STATIC) {
			m.this_parameter = new Parameter ("this", SemanticAnalyzer.get_this_type (m, this), m.source_reference);
			m.scope.add (m.this_parameter.name, m.this_parameter);
		}
		if (!(m.return_type is VoidType) && m.get_postconditions ().size > 0) {
			m.result_var = new LocalVariable (m.return_type.copy (), "result", null, m.source_reference);
			m.result_var.is_result = true;
		}

		base.add_method (m);
	}

	/**
	 * Adds the specified property as a member to this interface.
	 *
	 * @param prop a property
	 */
	public override void add_property (Property prop) {
		if (prop.field != null) {
			Report.error (prop.source_reference, "interface properties should be `abstract' or have `get' accessor and/or `set' mutator");

			prop.error = true;
			return;
		}

		base.add_property (prop);

		if (prop.binding != MemberBinding.STATIC) {
			prop.this_parameter = new Parameter ("this", SemanticAnalyzer.get_this_type (prop, this), prop.source_reference);
			prop.scope.add (prop.this_parameter.name, prop.this_parameter);
		}
	}

	public virtual List<Symbol> get_virtuals () {
		return virtuals;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_interface (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (DataType type in prerequisites) {
			type.accept (visitor);
		}

		// Invoke common implementation in ObjectTypeSymbol
		base.accept_children (visitor);
	}

	public override bool is_reference_type () {
		return true;
	}

	public override bool is_subtype_of (TypeSymbol t) {
		if (this == t) {
			return true;
		}

		foreach (DataType prerequisite in prerequisites) {
			if (prerequisite.type_symbol != null && prerequisite.type_symbol.is_subtype_of (t)) {
				return true;
			}
		}

		return false;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		for (int i = 0; i < prerequisites.size; i++) {
			if (prerequisites[i] == old_type) {
				prerequisites[i] = new_type;
				new_type.parent_node = this;
				return;
			}
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		if (!base.check (context)) {
			return false;
		}

		checked = true;

		var old_source_file = context.analyzer.current_source_file;
		var old_symbol = context.analyzer.current_symbol;

		if (source_reference != null) {
			context.analyzer.current_source_file = source_reference.file;
		}
		context.analyzer.current_symbol = this;

		foreach (DataType prerequisite_reference in get_prerequisites ()) {
			// check whether prerequisite is at least as accessible as the interface
			if (!context.analyzer.is_type_accessible (this, prerequisite_reference)) {
				error = true;
				Report.error (source_reference, "prerequisite `%s' is less accessible than interface `%s'".printf (prerequisite_reference.to_string (), get_full_name ()));
				return false;
			}
		}

		/* check prerequisites */
		Class prereq_class = null;
		foreach (DataType prereq in get_prerequisites ()) {
			if (!(prereq is ObjectType)) {
				error = true;
				Report.error (source_reference, "Prerequisite `%s' of interface `%s' is not a class or interface".printf (prereq.to_string (), get_full_name ()));
				return false;
			}

			/* interfaces are not allowed to have multiple instantiable prerequisites */
			if (prereq.type_symbol is Class) {
				if (prereq_class != null) {
					error = true;
					Report.error (source_reference, "%s: Interfaces cannot have multiple instantiable prerequisites (`%s' and `%s')".printf (get_full_name (), prereq.type_symbol.get_full_name (), prereq_class.get_full_name ()));
					return false;
				}

				prereq_class = (Class) prereq.type_symbol;
			}
		}

		foreach (DataType type in prerequisites) {
			type.check (context);
			context.analyzer.check_type (type);
		}

		foreach (TypeParameter p in get_type_parameters ()) {
			p.check (context);
		}

		foreach (Enum en in get_enums ()) {
			en.check (context);
		}

		foreach (Field f in get_fields ()) {
			f.check (context);
		}

		foreach (Constant c in get_constants ()) {
			c.check (context);
		}

		if (context.abi_stability) {
			foreach (Symbol s in get_members ()) {
				if (s is Method) {
					var m = (Method) s;
					m.check (context);
					if (m.is_virtual || m.is_abstract) {
						virtuals.add (m);
					}
				} else if (s is Signal) {
					var sig = (Signal) s;
					sig.check (context);
					if (sig.is_virtual) {
						virtuals.add (sig);
					}
				} else if (s is Property) {
					var prop = (Property) s;
					prop.check (context);
					if (prop.is_virtual || prop.is_abstract) {
						virtuals.add (prop);
					}
				}
			}
		} else {
			foreach (Method m in get_methods ()) {
				m.check (context);
				if (m.is_virtual || m.is_abstract) {
					virtuals.add (m);
				}
			}

			foreach (Signal sig in get_signals ()) {
				sig.check (context);
				if (sig.is_virtual) {
					virtuals.add (sig);
				}
			}

			foreach (Property prop in get_properties ()) {
				prop.check (context);
				if (prop.is_virtual || prop.is_abstract) {
					virtuals.add (prop);
				}
			}
		}

		foreach (Class cl in get_classes ()) {
			cl.check (context);
		}

		foreach (Interface iface in get_interfaces ()) {
			iface.check (context);
		}

		foreach (Struct st in get_structs ()) {
			st.check (context);
		}

		foreach (Delegate d in get_delegates ()) {
			d.check (context);
		}

		Map<int, Symbol>? positions = new HashMap<int, Symbol> ();
		bool ordered_seen = false;
		bool unordered_seen = false;
		foreach (Symbol sym in virtuals) {
			int ordering = sym.get_attribute_integer ("CCode", "ordering", -1);
			if (ordering < -1) {
				Report.error (sym.source_reference, "%s: Invalid ordering".printf (sym.get_full_name ()));
				// Mark state as invalid
				error = true;
				ordered_seen = true;
				unordered_seen = true;
				continue;
			}
			bool ordered = ordering != -1;
			if (ordered && unordered_seen && !ordered_seen) {
				Report.error (sym.source_reference, "%s: Cannot mix ordered and unordered virtuals".printf (sym.get_full_name ()));
				error = true;
			}
			ordered_seen = ordered_seen || ordered;
			if (!ordered && !unordered_seen && ordered_seen) {
				Report.error (sym.source_reference, "%s: Cannot mix ordered and unordered virtuals".printf (sym.get_full_name ()));
				error = true;
			}
			unordered_seen = unordered_seen || !ordered;
			if (!ordered_seen || !unordered_seen) {
				if (ordered) {
					Symbol? prev = positions[ordering];
					if (prev != null) {
						Report.error (sym.source_reference, "%s: Duplicate ordering (previous virtual with the same position is %s)".printf (sym.get_full_name (), prev.name));
						error = true;
					}
					positions[ordering] = sym;
				}
			}
		}
		if (ordered_seen) {
			for (int i = 0; i < virtuals.size; i++) {
				Symbol? sym = positions[i];
				if (sym == null) {
					Report.error (source_reference, "%s: Gap in ordering in position %d".printf (get_full_name (), i));
					error = true;
				}
				if (!error) {
					virtuals[i] = sym;
				}
			}
		}

		context.analyzer.current_source_file = old_source_file;
		context.analyzer.current_symbol = old_symbol;

		return !error;
	}
}
