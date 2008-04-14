/* valasemanticanalyzer.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;
using Gee;

/**
 * Code visitor analyzing and checking code.
 */
public class Vala.SemanticAnalyzer : CodeVisitor {
	private CodeContext context;

	Symbol root_symbol;
	Symbol current_symbol;
	SourceFile current_source_file;
	DataType current_return_type;
	Class current_class;
	Struct current_struct;

	Collection<NamespaceReference> current_using_directives;

	DataType bool_type;
	DataType string_type;
	DataType int_type;
	DataType uint_type;
	DataType ulong_type;
	DataType size_t_type;
	DataType unichar_type;
	DataType type_type;
	Typesymbol pointer_type;
	Class object_type;
	Typesymbol initially_unowned_type;
	DataType glist_type;
	DataType gslist_type;
	Class gerror_type;
	DataType iterable_type;
	Interface iterator_type;
	Interface list_type;
	Interface map_type;

	private int next_lambda_id = 0;

	private Collection<BindingProvider> binding_providers = new ArrayList<BindingProvider> ();

	public SemanticAnalyzer () {
	}

	public void add_binding_provider (BindingProvider binding_provider) {
		binding_providers.add (binding_provider);
	}

	/**
	 * Analyze and check code in the specified context.
	 *
	 * @param context a code context
	 */
	public void analyze (CodeContext context) {
		this.context = context;

		root_symbol = context.root;

		bool_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("bool"));
		string_type = new ClassType ((Class) root_symbol.scope.lookup ("string"));

		pointer_type = (Typesymbol) root_symbol.scope.lookup ("pointer");

		int_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("int"));
		uint_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("uint"));
		ulong_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("ulong"));
		size_t_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("size_t"));
		unichar_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("unichar"));

		// TODO: don't require GLib namespace in semantic analyzer
		var glib_ns = root_symbol.scope.lookup ("GLib");
		if (glib_ns != null) {
			object_type = (Class) glib_ns.scope.lookup ("Object");
			initially_unowned_type = (Typesymbol) glib_ns.scope.lookup ("InitiallyUnowned");

			type_type = new ValueType ((Typesymbol) glib_ns.scope.lookup ("Type"));

			glist_type = new ClassType ((Class) glib_ns.scope.lookup ("List"));
			gslist_type = new ClassType ((Class) glib_ns.scope.lookup ("SList"));

			gerror_type = (Class) glib_ns.scope.lookup ("Error");
		}

		var gee_ns = root_symbol.scope.lookup ("Gee");
		if (gee_ns != null) {
			iterable_type = new InterfaceType ((Interface) gee_ns.scope.lookup ("Iterable"));
			iterator_type = (Interface) gee_ns.scope.lookup ("Iterator");
			list_type = (Interface) gee_ns.scope.lookup ("List");
			map_type = (Interface) gee_ns.scope.lookup ("Map");
		}

		current_symbol = root_symbol;
		context.accept (this);
	}

	public override void visit_source_file (SourceFile file) {
		current_source_file = file;
		current_using_directives = file.get_using_directives ();

		next_lambda_id = 0;

		file.accept_children (this);

		current_using_directives = null;
	}

	public override void visit_class (Class cl) {
		current_symbol = cl;
		current_class = cl;

		foreach (DataType base_type_reference in cl.get_base_types ()) {
			current_source_file.add_type_dependency (base_type_reference, SourceFileDependencyType.HEADER_FULL);
		}

		cl.accept_children (this);

		/* gather all prerequisites */
		Gee.List<Typesymbol> prerequisites = new ArrayList<Typesymbol> ();
		foreach (DataType base_type in cl.get_base_types ()) {
			if (base_type.data_type is Interface) {
				get_all_prerequisites ((Interface) base_type.data_type, prerequisites);
			}
		}
		/* check whether all prerequisites are met */
		Gee.List<string> missing_prereqs = new ArrayList<string> ();
		foreach (Typesymbol prereq in prerequisites) {
			if (!class_is_a (cl, prereq)) {
				missing_prereqs.insert (0, prereq.get_full_name ());
			}
		}
		/* report any missing prerequisites */
		if (missing_prereqs.size > 0) {
			cl.error = true;

			string error_string = "%s: some prerequisites (".printf (cl.get_full_name ());
			bool first = true;
			foreach (string s in missing_prereqs) {
				if (first) {
					error_string = "%s`%s'".printf (error_string, s);
					first = false;
				} else {
					error_string = "%s, `%s'".printf (error_string, s);
				}
			}
			error_string += ") are not met";
			Report.error (cl.source_reference, error_string);
		}

		/* VAPI classes don't have to specify overridden methods */
		if (!cl.source_reference.file.pkg) {
			/* all abstract symbols defined in base types have to be at least defined (or implemented) also in this type */
			foreach (DataType base_type in cl.get_base_types ()) {
				if (base_type.data_type is Interface) {
					Interface iface = (Interface) base_type.data_type;

					/* We do not need to do expensive equality checking here since this is done
					 * already. We only need to guarantee the symbols are present.
					 */

					/* check methods */
					foreach (Method m in iface.get_methods ()) {
						if (m.is_abstract) {
							var sym = cl.scope.lookup (m.name);
							if (!(sym is Method)) {
								cl.error = true;
								Report.error (cl.source_reference, "`%s' does not implement interface method `%s'".printf (cl.get_full_name (), m.get_full_name ()));
							}
						}
					}
				}
			}

			/* all abstract symbols defined in base classes have to be implemented in non-abstract classes */
			if (!cl.is_abstract) {
				var base_class = cl.base_class;
				while (base_class != null && base_class.is_abstract) {
					foreach (Method base_method in base_class.get_methods ()) {
						if (base_method.is_abstract) {
							var override_method = symbol_lookup_inherited (cl, base_method.name) as Method;
							if (override_method == null || !override_method.overrides) {
								cl.error = true;
								Report.error (cl.source_reference, "`%s' does not implement abstract method `%s'".printf (cl.get_full_name (), base_method.get_full_name ()));
							}
						}
					}
					base_class = base_class.base_class;
				}
			}
		}

		current_symbol = current_symbol.parent_symbol;
		current_class = null;
	}

	private void get_all_prerequisites (Interface iface, Collection<Typesymbol> list) {
		foreach (DataType prereq in iface.get_prerequisites ()) {
			Typesymbol type = prereq.data_type;
			/* skip on previous errors */
			if (type == null) {
				continue;
			}

			list.add (type);
			if (type is Interface) {
				get_all_prerequisites ((Interface) type, list);

			}
		}
	}

	private bool class_is_a (Class cl, Typesymbol t) {
		if (cl == t) {
			return true;
		}

		foreach (DataType base_type in cl.get_base_types ()) {
			if (base_type.data_type is Class) {
				if (class_is_a ((Class) base_type.data_type, t)) {
					return true;
				}
			} else if (base_type.data_type == t) {
				return true;
			}
		}

		return false;
	}

	public override void visit_struct (Struct st) {
		current_symbol = st;
		current_struct = st;

		st.accept_children (this);

		current_symbol = current_symbol.parent_symbol;
		current_struct = null;
	}

	public override void visit_interface (Interface iface) {
		current_symbol = iface;

		foreach (DataType prerequisite_reference in iface.get_prerequisites ()) {
			current_source_file.add_type_dependency (prerequisite_reference, SourceFileDependencyType.HEADER_FULL);
		}

		/* check prerequisites */
		Class prereq_class;
		foreach (DataType prereq in iface.get_prerequisites ()) {
			Typesymbol class_or_interface = prereq.data_type;
			/* skip on previous errors */
			if (class_or_interface == null) {
				iface.error = true;
				continue;
			}
			/* interfaces are not allowed to have multiple instantiable prerequisites */
			if (class_or_interface is Class) {
				if (prereq_class != null) {
					iface.error = true;
					Report.error (iface.source_reference, "%s: Interfaces cannot have multiple instantiable prerequisites (`%s' and `%s')".printf (iface.get_full_name (), class_or_interface.get_full_name (), prereq_class.get_full_name ()));
					return;
				}

				prereq_class = (Class) class_or_interface;
			}
		}

		iface.accept_children (this);

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_enum (Enum en) {
		en.accept_children (this);
	}

	public override void visit_enum_value (EnumValue ev) {
		ev.accept_children (this);
	}

	public override void visit_delegate (Delegate d) {
		d.accept_children (this);
	}

	public override void visit_constant (Constant c) {
		c.type_reference.accept (this);

		if (!current_source_file.pkg) {
			if (c.initializer == null) {
				c.error = true;
				Report.error (c.source_reference, "A const field requires a initializer to be provided");
			} else {
				c.initializer.expected_type = c.type_reference;

				c.initializer.accept (this);
			}
		}
	}

	public override void visit_field (Field f) {
		f.accept_children (this);

		if (f.instance && f.parent_symbol is Interface) {
			f.error = true;
			Report.error (f.source_reference, "Interfaces may not have instance fields");
			return;
		}

		if (!f.is_internal_symbol ()) {
			current_source_file.add_type_dependency (f.type_reference, SourceFileDependencyType.HEADER_SHALLOW);
		} else {
			if (f.parent_symbol is Namespace) {
				f.error = true;
				Report.error (f.source_reference, "Namespaces may not have private members");
				return;
			}

			current_source_file.add_type_dependency (f.type_reference, SourceFileDependencyType.SOURCE);
		}
	}

	public override void visit_method (Method m) {
		if (m.is_abstract) {
			if (m.parent_symbol is Class) {
				var cl = (Class) m.parent_symbol;
				if (!cl.is_abstract) {
					m.error = true;
					Report.error (m.source_reference, "Abstract methods may not be declared in non-abstract classes");
					return;
				}
			} else if (!(m.parent_symbol is Interface)) {
				m.error = true;
				Report.error (m.source_reference, "Abstract methods may not be declared outside of classes and interfaces");
				return;
			}
		} else if (m.is_virtual) {
			if (!(m.parent_symbol is Class)) {
				m.error = true;
				Report.error (m.source_reference, "Virtual methods may not be declared outside of classes");
				return;
			}
		} else if (m.overrides) {
			if (!(m.parent_symbol is Class)) {
				m.error = true;
				Report.error (m.source_reference, "Methods may not be overridden outside of classes");
				return;
			}
		}

		var old_symbol = current_symbol;
		var old_return_type = current_return_type;
		current_symbol = m;
		current_return_type = m.return_type;

		var init_attr = m.get_attribute ("ModuleInit");
		if (init_attr != null) {
			m.source_reference.file.context.module_init_method = m;
		}

		if (!m.is_internal_symbol ()) {
			current_source_file.add_type_dependency (m.return_type, SourceFileDependencyType.HEADER_SHALLOW);
		}
		current_source_file.add_type_dependency (m.return_type, SourceFileDependencyType.SOURCE);

		m.accept_children (this);

		current_symbol = old_symbol;
		current_return_type = old_return_type;

		if (current_symbol.parent_symbol is Method) {
			/* lambda expressions produce nested methods */
			var up_method = (Method) current_symbol.parent_symbol;
			current_return_type = up_method.return_type;
		}

		if (current_symbol is Class) {
			/* VAPI classes don't specify overridden methods */
			if (!current_symbol.source_reference.file.pkg) {
				if (!(m is CreationMethod)) {
					find_base_interface_method (m, (Class) current_symbol);
					if (m.is_virtual || m.overrides) {
						find_base_class_method (m, (Class) current_symbol);
						if (m.base_method == null) {
							Report.error (m.source_reference, "%s: no suitable method found to override".printf (m.get_full_name ()));
						}
					}
				}
			} else if (m.is_virtual || m.is_abstract) {
				m.base_method = m;
			}
		} else if (current_symbol is Interface) {
			if (m.is_virtual || m.is_abstract) {
				m.base_interface_method = m;
			}
		} else if (current_symbol is Struct) {
			if (m.is_abstract || m.is_virtual || m.overrides) {
				Report.error (m.source_reference, "A struct member `%s' cannot be marked as override, virtual, or abstract".printf (m.get_full_name ()));
				return;
			}
		}

		// check whether return type is at least as accessible as the method
		if (!is_type_accessible (m, m.return_type)) {
			m.error = true;
			Report.error (m.source_reference, "return type `%s` is less accessible than method `%s`".printf (m.return_type.to_string (), m.get_full_name ()));
			return;
		}

		foreach (Expression precondition in m.get_preconditions ()) {
			if (precondition.error) {
				// if there was an error in the precondition, skip this check
				m.error = true;
				return;
			}

			if (!precondition.static_type.compatible (bool_type)) {
				m.error = true;
				Report.error (precondition.source_reference, "Precondition must be boolean");
				return;
			}
		}

		foreach (Expression postcondition in m.get_postconditions ()) {
			if (postcondition.error) {
				// if there was an error in the postcondition, skip this check
				m.error = true;
				return;
			}

			if (!postcondition.static_type.compatible (bool_type)) {
				m.error = true;
				Report.error (postcondition.source_reference, "Postcondition must be boolean");
				return;
			}
		}
	}

	private void find_base_class_method (Method m, Class cl) {
		var sym = cl.scope.lookup (m.name);
		if (sym is Method) {
			var base_method = (Method) sym;
			if (base_method.is_abstract || base_method.is_virtual) {
				string invalid_match;
				if (!m.compatible (base_method, out invalid_match)) {
					m.error = true;
					Report.error (m.source_reference, "overriding method `%s' is incompatible with base method `%s': %s.".printf (m.get_full_name (), base_method.get_full_name (), invalid_match));
					return;
				}

				m.base_method = base_method;
				return;
			}
		}

		if (cl.base_class != null) {
			find_base_class_method (m, cl.base_class);
		}
	}

	private void find_base_interface_method (Method m, Class cl) {
		// FIXME report error if multiple possible base methods are found
		foreach (DataType type in cl.get_base_types ()) {
			if (type.data_type is Interface) {
				var sym = type.data_type.scope.lookup (m.name);
				if (sym is Method) {
					var base_method = (Method) sym;
					if (base_method.is_abstract) {
						string invalid_match;
						if (!m.compatible (base_method, out invalid_match)) {
							m.error = true;
							Report.error (m.source_reference, "overriding method `%s' is incompatible with base method `%s': %s.".printf (m.get_full_name (), base_method.get_full_name (), invalid_match));
							return;
						}

						m.base_interface_method = base_method;
						return;
					}
				}
			}
		}
	}

	public override void visit_creation_method (CreationMethod m) {
		if (m.type_name != null && m.type_name != current_symbol.name) {
			// type_name is null for constructors generated by GIdlParser
			Report.error (m.source_reference, "missing return type in method `%s.%s´".printf (current_symbol.get_full_name (), m.type_name));
			m.error = true;
			return;
		}

		current_symbol = m;
		current_return_type = m.return_type;

		m.accept_children (this);

		current_symbol = current_symbol.parent_symbol;
		current_return_type = null;

		if (current_symbol.parent_symbol is Method) {
			/* lambda expressions produce nested methods */
			var up_method = (Method) current_symbol.parent_symbol;
			current_return_type = up_method.return_type;
		}

		if (m.is_abstract || m.is_virtual || m.overrides) {
			Report.error (m.source_reference, "The creation method `%s' cannot be marked as override, virtual, or abstract".printf (m.get_full_name ()));
			return;
		}
	}

	public override void visit_formal_parameter (FormalParameter p) {
		p.accept_children (this);

		if (p.default_expression != null) {
			if (p.default_expression is NullLiteral
			    && !p.type_reference.nullable
			    && !p.type_reference.is_out) {
				p.error = true;
				Report.error (p.source_reference, "`null' incompatible with parameter type `%s`".printf (p.type_reference.to_string ()));
				return;
			}
		}

		if (!p.ellipsis) {
			if (!p.is_internal_symbol ()) {
				current_source_file.add_type_dependency (p.type_reference, SourceFileDependencyType.HEADER_SHALLOW);
			}
			current_source_file.add_type_dependency (p.type_reference, SourceFileDependencyType.SOURCE);

			// check whether parameter type is at least as accessible as the method
			if (!is_type_accessible (p, p.type_reference)) {
				p.error = true;
				Report.error (p.source_reference, "parameter type `%s` is less accessible than method `%s`".printf (p.type_reference.to_string (), p.parent_symbol.get_full_name ()));
				return;
			}
		}

		/* special treatment for construct formal parameters used in creation methods */
		if (p.construct_parameter) {
			if (!(p.parent_symbol is CreationMethod)) {
				p.error = true;
				Report.error (p.source_reference, "construct parameters are only allowed in type creation methods");
				return;
			}

			var method_body = ((CreationMethod) p.parent_symbol).body;
			var left = new MemberAccess (new MemberAccess.simple ("this"), p.name);
			var right = new MemberAccess.simple (p.name);

			method_body.add_statement (new ExpressionStatement (context.create_assignment (left, right), p.source_reference));
		}
	}

	// check whether type is at least as accessible as the specified symbol
	private bool is_type_accessible (Symbol sym, DataType type) {
		foreach (Symbol type_symbol in type.get_symbols ()) {
			Scope method_scope = sym.get_top_accessible_scope ();
			Scope type_scope = type_symbol.get_top_accessible_scope ();
			if ((method_scope == null && type_scope != null)
			    || (method_scope != null && !method_scope.is_subscope_of (type_scope))) {
				return false;
			}
		}

		return true;
	}

	private void find_base_class_property (Property prop, Class cl) {
		var sym = cl.scope.lookup (prop.name);
		if (sym is Property) {
			var base_property = (Property) sym;
			if (base_property.is_abstract || base_property.is_virtual) {
				if (!prop.equals (base_property)) {
					prop.error = true;
					Report.error (prop.source_reference, "Type and/or accessors of overriding property `%s' do not match overridden property `%s'.".printf (prop.get_full_name (), base_property.get_full_name ()));
					return;
				}

				prop.base_property = base_property;
				return;
			}
		}

		if (cl.base_class != null) {
			find_base_class_property (prop, cl.base_class);
		}
	}

	private void find_base_interface_property (Property prop, Class cl) {
		// FIXME report error if multiple possible base properties are found
		foreach (DataType type in cl.get_base_types ()) {
			if (type.data_type is Interface) {
				var sym = type.data_type.scope.lookup (prop.name);
				if (sym is Property) {
					var base_property = (Property) sym;
					if (base_property.is_abstract) {
						if (!prop.equals (base_property)) {
							prop.error = true;
							Report.error (prop.source_reference, "Type and/or accessors of overriding property `%s' do not match overridden property `%s'.".printf (prop.get_full_name (), base_property.get_full_name ()));
							return;
						}

						prop.base_interface_property = base_property;
						return;
					}
				}
			}
		}
	}

	public override void visit_property (Property prop) {
		current_symbol = prop;

		if (!prop.instance) {
			Report.error (prop.source_reference, "static properties are not yet supported");
			prop.error = true;
			return;
		}

		prop.accept_children (this);

		// check whether property type is at least as accessible as the property
		if (!is_type_accessible (prop, prop.type_reference)) {
			prop.error = true;
			Report.error (prop.source_reference, "property type `%s` is less accessible than property `%s`".printf (prop.type_reference.to_string (), prop.get_full_name ()));
			return;
		}

		/* abstract/virtual properties using reference types without
		 * reference counting need to transfer ownership of their
		 * return values because of limitations in the GObject property
		 * system (g_object_get always returns strong references).
		 * Reference counting types can simulate to return a weak
		 * reference */
		if ((prop.is_abstract || prop.is_virtual) &&
		    prop.type_reference.data_type != null &&
		    prop.type_reference.data_type.is_reference_type () &&
		    !prop.type_reference.data_type.is_reference_counting () &&
		    !prop.type_reference.transfers_ownership)
		{
			Report.error (prop.source_reference, "%s: abstract or virtual properties using reference types not supporting reference counting, like `%s', have to mark their return value to transfer ownership.".printf (prop.get_full_name (), prop.type_reference.data_type.get_full_name ()));
			prop.error = true;
		}

		current_symbol = current_symbol.parent_symbol;

		if (!prop.is_internal_symbol ()) {
			current_source_file.add_type_dependency (prop.type_reference, SourceFileDependencyType.HEADER_SHALLOW);
		}
		current_source_file.add_type_dependency (prop.type_reference, SourceFileDependencyType.SOURCE);

		if (prop.parent_symbol is Class) {
			var cl = (Class) prop.parent_symbol;

			/* VAPI classes don't specify overridden properties */
			if (!cl.source_reference.file.pkg) {
				find_base_interface_property (prop, cl);
				if (prop.is_virtual || prop.overrides) {
					find_base_class_property (prop, cl);
					if (prop.base_property == null) {
						prop.error = true;
						Report.error (prop.source_reference, "%s: no suitable property found to override".printf (prop.get_full_name ()));
					}
				}
			}
		}

		/* construct properties must be public */
		if (prop.set_accessor != null && prop.set_accessor.construction) {
			if (prop.access != SymbolAccessibility.PUBLIC) {
				prop.error = true;
				Report.error (prop.source_reference, "%s: construct properties must be public".printf (prop.get_full_name ()));
			}
		}
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		acc.prop = (Property) current_symbol;

		if (acc.readable) {
			current_return_type = acc.prop.type_reference;
		} else {
			// void
			current_return_type = new VoidType ();
		}

		if (!acc.source_reference.file.pkg) {
			if (acc.body == null && !acc.prop.interface_only && !acc.prop.is_abstract) {
				/* no accessor body specified, insert default body */

				if (acc.prop.parent_symbol is Interface) {
					acc.error = true;
					Report.error (acc.source_reference, "Automatic properties can't be used in interfaces");
					return;
				}
				acc.automatic_body = true;
				acc.body = new Block ();
				var ma = context.create_member_access_simple ("_%s".printf (acc.prop.name), acc.source_reference);
				if (acc.readable) {
					acc.body.add_statement (context.create_return_statement (ma, acc.source_reference));
				} else {
					var assignment = context.create_assignment (ma, context.create_member_access_simple ("value", acc.source_reference), AssignmentOperator.SIMPLE, acc.source_reference);
					acc.body.add_statement (context.create_expression_statement (assignment));
				}
			}

			if (acc.body != null && (acc.writable || acc.construction)) {
				acc.value_parameter = new FormalParameter ("value", acc.prop.type_reference, acc.source_reference);
				acc.body.scope.add (acc.value_parameter.name, acc.value_parameter);
			}
		}

		acc.accept_children (this);

		current_return_type = null;
	}

	public override void visit_signal (Signal sig) {
		sig.accept_children (this);
	}

	public override void visit_constructor (Constructor c) {
		c.this_parameter = new FormalParameter ("this", new ClassType (current_class));
		c.scope.add (c.this_parameter.name, c.this_parameter);

		c.owner = current_symbol.scope;
		current_symbol = c;

		c.accept_children (this);

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_destructor (Destructor d) {
		d.owner = current_symbol.scope;
		current_symbol = d;

		d.accept_children (this);

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_named_argument (NamedArgument n) {
	}

	public override void visit_block (Block b) {
		b.owner = current_symbol.scope;
		current_symbol = b;

		b.accept_children (this);

		foreach (VariableDeclarator decl in b.get_local_variables ()) {
			decl.active = false;
		}

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_variable_declarator (VariableDeclarator decl) {
		if (decl.initializer != null) {
			decl.initializer.expected_type = decl.type_reference;
		}

		decl.accept_children (this);

		if (decl.type_reference == null) {
			/* var type */

			if (decl.initializer == null) {
				decl.error = true;
				Report.error (decl.source_reference, "var declaration not allowed without initializer");
				return;
			}
			if (decl.initializer.static_type == null) {
				decl.error = true;
				Report.error (decl.source_reference, "var declaration not allowed with non-typed initializer");
				return;
			}

			decl.type_reference = decl.initializer.static_type.copy ();
			decl.type_reference.takes_ownership = (decl.type_reference.data_type == null || decl.type_reference.data_type.is_reference_type ());
			decl.type_reference.transfers_ownership = false;
		}

		if (decl.initializer != null) {
			if (decl.initializer.static_type == null) {
				if (!(decl.initializer is MemberAccess) && !(decl.initializer is LambdaExpression)) {
					decl.error = true;
					Report.error (decl.source_reference, "expression type not allowed as initializer");
					return;
				}

				if (decl.initializer.symbol_reference is Method &&
				    decl.type_reference is DelegateType) {
					var m = (Method) decl.initializer.symbol_reference;
					var dt = (DelegateType) decl.type_reference;
					var cb = dt.delegate_symbol;

					/* check whether method matches callback type */
					if (!cb.matches_method (m)) {
						decl.error = true;
						Report.error (decl.source_reference, "declaration of method `%s' doesn't match declaration of callback `%s'".printf (m.get_full_name (), cb.get_full_name ()));
						return;
					}

					decl.initializer.static_type = decl.type_reference;
				} else {
					decl.error = true;
					Report.error (decl.source_reference, "expression type not allowed as initializer");
					return;
				}
			}

			if (!decl.initializer.static_type.compatible (decl.type_reference)) {
				decl.error = true;
				Report.error (decl.source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (decl.initializer.static_type.to_string (), decl.type_reference.to_string ()));
				return;
			}

			if (decl.initializer.static_type.transfers_ownership) {
				/* rhs transfers ownership of the expression */
				if (!(decl.type_reference is PointerType) && !decl.type_reference.takes_ownership) {
					/* lhs doesn't own the value */
					decl.error = true;
					Report.error (decl.source_reference, "Invalid assignment from owned expression to unowned variable");
					return;
				}
			}
		}

		current_source_file.add_type_dependency (decl.type_reference, SourceFileDependencyType.SOURCE);

		current_symbol.scope.add (decl.name, decl);

		var block = (Block) current_symbol;
		block.add_local_variable (decl);

		decl.active = true;
	}

	/**
	 * Visit operation called for initializer lists
	 *
	 * @param list an initializer list
	 */
	public override void visit_initializer_list (InitializerList list) {
		if (list.expected_type is ArrayType) {
			/* initializer is used as array initializer */
			var array_type = (ArrayType) list.expected_type;

			foreach (Expression e in list.get_initializers ()) {
				e.expected_type = array_type.element_type.copy ();
			}
		} else if (list.expected_type != null && list.expected_type.data_type is Struct) {
			/* initializer is used as struct initializer */
			var st = (Struct) list.expected_type.data_type;

			var field_it = st.get_fields ().iterator ();
			foreach (Expression e in list.get_initializers ()) {
				Field field = null;
				while (field == null) {
					if (!field_it.next ()) {
						list.error = true;
						Report.error (e.source_reference, "too many expressions in initializer list for `%s'".printf (list.expected_type.to_string ()));
						return;
					}
					field = field_it.get ();
					if (!field.instance) {
						// we only initialize instance fields
						field = null;
					}
				}

				e.expected_type = field.type_reference.copy ();
			}
		} else if (list.expected_type == null) {
			list.error = true;
			Report.error (list.source_reference, "initializer list used for unknown type");
			return;
		} else {
			list.error = true;
			Report.error (list.source_reference, "initializer list used for `%s', which is neither array nor struct".printf (list.expected_type.to_string ()));
			return;
		}

		list.accept_children (this);

		bool error = false;
		foreach (Expression e in list.get_initializers ()) {
			if (e.static_type == null) {
				error = true;
				continue;
			}

			var unary = e as UnaryExpression;
			if (unary != null && (unary.operator == UnaryOperator.REF || unary.operator == UnaryOperator.OUT)) {
				// TODO check type for ref and out expressions
			} else if (!e.static_type.compatible (e.expected_type)) {
				error = true;
				e.error = true;
				Report.error (e.source_reference, "Expected initializer of type `%s' but got `%s'".printf (e.expected_type.to_string (), e.static_type.to_string ()));
			}
		}

		if (!error) {
			/* everything seems to be correct */
			list.static_type = list.expected_type;
		}
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		if (stmt.expression.error) {
			// ignore inner error
			stmt.error = true;
			return;
		}

		stmt.tree_can_fail = stmt.expression.tree_can_fail;
	}

	public override void visit_if_statement (IfStatement stmt) {
		stmt.accept_children (this);

		if (stmt.condition.error) {
			/* if there was an error in the condition, skip this check */
			stmt.error = true;
			return;
		}

		if (!stmt.condition.static_type.compatible (bool_type)) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}
	}

	public override void visit_switch_section (SwitchSection section) {
		foreach (SwitchLabel label in section.get_labels ()) {
			label.accept (this);
		}

		section.owner = current_symbol.scope;
		current_symbol = section;

		foreach (Statement st in section.get_statements ()) {
			st.accept (this);
		}

		foreach (VariableDeclarator decl in section.get_local_variables ()) {
			decl.active = false;
		}

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_while_statement (WhileStatement stmt) {
		stmt.accept_children (this);

		if (stmt.condition.error) {
			/* if there was an error in the condition, skip this check */
			stmt.error = true;
			return;
		}

		if (!stmt.condition.static_type.compatible (bool_type)) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}
	}

	public override void visit_do_statement (DoStatement stmt) {
		stmt.accept_children (this);

		if (stmt.condition.error) {
			/* if there was an error in the condition, skip this check */
			stmt.error = true;
			return;
		}

		if (!stmt.condition.static_type.compatible (bool_type)) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}
	}

	public override void visit_for_statement (ForStatement stmt) {
		stmt.accept_children (this);

		if (stmt.condition != null && stmt.condition.error) {
			/* if there was an error in the condition, skip this check */
			stmt.error = true;
			return;
		}

		if (stmt.condition != null && !stmt.condition.static_type.compatible (bool_type)) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}
	}

	public override void visit_foreach_statement (ForeachStatement stmt) {
		current_source_file.add_type_dependency (stmt.type_reference, SourceFileDependencyType.SOURCE);

		stmt.variable_declarator = new VariableDeclarator (stmt.variable_name);
		stmt.variable_declarator.type_reference = stmt.type_reference;

		stmt.body.scope.add (stmt.variable_name, stmt.variable_declarator);

		stmt.body.add_local_variable (stmt.variable_declarator);
		stmt.variable_declarator.active = true;

		stmt.owner = current_symbol.scope;
		current_symbol = stmt;

		stmt.accept_children (this);

		foreach (VariableDeclarator decl in stmt.get_local_variables ()) {
			decl.active = false;
		}

		current_symbol = current_symbol.parent_symbol;

		if (stmt.collection.error) {
			// ignore inner error
			stmt.error = true;
			return;
		} else if (stmt.collection.static_type == null) {
			Report.error (stmt.collection.source_reference, "invalid collection expression");
			stmt.error = true;
			return;
		}

		stmt.collection_variable_declarator = new VariableDeclarator ("%s_collection".printf (stmt.variable_name));
		stmt.collection_variable_declarator.type_reference = stmt.collection.static_type.copy ();
		stmt.collection_variable_declarator.type_reference.transfers_ownership = false;
		stmt.collection_variable_declarator.type_reference.takes_ownership = stmt.collection.static_type.transfers_ownership;

		stmt.add_local_variable (stmt.collection_variable_declarator);
		stmt.collection_variable_declarator.active = true;
	
		var collection_type = stmt.collection.static_type;
		DataType element_data_type = null;
		bool need_type_check = false;
	
		if (collection_type.is_array ()) {
			var array_type = (ArrayType) collection_type;
			element_data_type = array_type.element_type;
			need_type_check = true;
		} else if (collection_type.compatible (glist_type) || collection_type.compatible (gslist_type)) {
			if (collection_type.get_type_arguments ().size > 0) {
				element_data_type = (DataType) collection_type.get_type_arguments ().get (0);
				need_type_check = true;
			}
		} else if (iterable_type != null && collection_type.compatible (iterable_type)) {
			stmt.iterator_variable_declarator = new VariableDeclarator ("%s_it".printf (stmt.variable_name));
			stmt.iterator_variable_declarator.type_reference = new InterfaceType (iterator_type);
			stmt.iterator_variable_declarator.type_reference.takes_ownership = true;
			stmt.iterator_variable_declarator.type_reference.add_type_argument (stmt.type_reference);

			stmt.add_local_variable (stmt.iterator_variable_declarator);
			stmt.iterator_variable_declarator.active = true;

			var it_method = (Method) iterable_type.data_type.scope.lookup ("iterator");
			if (it_method.return_type.get_type_arguments ().size > 0) {
				var type_arg = it_method.return_type.get_type_arguments ().get (0);
				if (type_arg.type_parameter != null) {
					element_data_type = SemanticAnalyzer.get_actual_type (collection_type, it_method, type_arg, stmt);
				} else {
					element_data_type = type_arg;
				}
				need_type_check = true;
			}
		} else {
			stmt.error = true;
			Report.error (stmt.source_reference, "Collection not iterable");
			return;
		}

		if (need_type_check && element_data_type != null) {
			/* allow implicit upcasts ? */
			if (!element_data_type.compatible (stmt.type_reference)) {
				stmt.error = true;
				Report.error (stmt.source_reference, "Foreach: Cannot convert from `%s' to `%s'".printf (element_data_type.to_string (), stmt.type_reference.to_string ()));
				return;
			}
		}

		stmt.tree_can_fail = stmt.collection.tree_can_fail || stmt.body.tree_can_fail;
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		stmt.accept_children (this);

		if (stmt.return_expression != null && stmt.return_expression.error) {
			// ignore inner error
			stmt.error = true;
			return;
		}

		if (current_return_type == null) {
			stmt.error = true;
			Report.error (stmt.source_reference, "Return not allowed in this context");
			return;
		}

		if (stmt.return_expression == null && !(current_return_type is VoidType)) {
			stmt.error = true;
			Report.error (stmt.source_reference, "Return without value in non-void function");
			return;
		}

		if (stmt.return_expression != null && current_return_type is VoidType) {
			Report.error (stmt.source_reference, "Return with value in void function");
			return;
		}

		if (stmt.return_expression != null &&
		     !stmt.return_expression.static_type.compatible (current_return_type)) {
			Report.error (stmt.source_reference, "Return: Cannot convert from `%s' to `%s'".printf (stmt.return_expression.static_type.to_string (), current_return_type.to_string ()));
			return;
		}

		if (stmt.return_expression != null &&
		    stmt.return_expression.static_type.transfers_ownership &&
		    !current_return_type.transfers_ownership) {
			stmt.error = true;
			Report.error (stmt.source_reference, "Return value transfers ownership but method return type hasn't been declared to transfer ownership");
			return;
		}

		if (stmt.return_expression != null &&
		    stmt.return_expression.symbol_reference is VariableDeclarator &&
		    stmt.return_expression.static_type.takes_ownership &&
		    !current_return_type.transfers_ownership) {
			Report.warning (stmt.source_reference, "Local variable with strong reference used as return value and method return type hasn't been declared to transfer ownership");
		}

		if (stmt.return_expression is NullLiteral
		    && !current_return_type.nullable) {
			Report.warning (stmt.source_reference, "`null' incompatible with return type `%s`".printf (current_return_type.to_string ()));
		}
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_try_statement (TryStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_catch_clause (CatchClause clause) {
		if (clause.type_reference != null) {
			current_source_file.add_type_dependency (clause.type_reference, SourceFileDependencyType.SOURCE);

			clause.variable_declarator = new VariableDeclarator (clause.variable_name);
			clause.variable_declarator.type_reference = clause.type_reference.copy ();

			clause.body.scope.add (clause.variable_name, clause.variable_declarator);
		} else {
			clause.type_reference = new ErrorType (null, clause.source_reference);
		}

		clause.accept_children (this);
	}

	public override void visit_lock_statement (LockStatement stmt) {
		/* resource must be a member access and denote a Lockable */
		if (!(stmt.resource is MemberAccess && stmt.resource.symbol_reference is Lockable)) {
		    	stmt.error = true;
			stmt.resource.error = true;
			Report.error (stmt.resource.source_reference, "Expression is either not a member access or does not denote a lockable member");
			return;
		}

		/* parent symbol must be the current class */
		if (stmt.resource.symbol_reference.parent_symbol != current_class) {
		    	stmt.error = true;
			stmt.resource.error = true;
			Report.error (stmt.resource.source_reference, "Only members of the current class are lockable");
		}

		((Lockable) stmt.resource.symbol_reference).set_lock_used (true);
	}

	public override void visit_delete_statement (DeleteStatement stmt) {
		stmt.accept_children (this);

		if (stmt.expression.error) {
			// if there was an error in the inner expression, skip this check
			return;
		}

		if (!(stmt.expression.static_type is PointerType)) {
			stmt.error = true;
			Report.error (stmt.source_reference, "delete operator not supported for `%s'".printf (stmt.expression.static_type.to_string ()));
		}
	}

	private int create_sizes_from_initializer_list (InitializerList il, int rank, Gee.List<Literal> sl) {
		var init = new IntegerLiteral (il.size.to_string (), il.source_reference);
		init.accept (this);
		sl.add (init);

		int subsize = -1;
		foreach (Expression e in il.get_initializers ()) {
			if (e is InitializerList) {
				if (rank == 1) {
					il.error = true;
					e.error = true;
					Report.error (e.source_reference, "Expected array element, got array initializer list");
					return -1;
				}
				int size = create_sizes_from_initializer_list ((InitializerList)e, rank - 1, sl);
				if (size == -1) {
					return -1;
				}
				if (subsize >= 0 && subsize != size) {
					il.error = true;
					Report.error (il.source_reference, "Expected initializer list of size %d, got size %d".printf (subsize, size));
					return -1;
				} else {
					subsize = size;
				}
			} else {
				if (rank != 1) {
					il.error = true;
					e.error = true;
					Report.error (e.source_reference, "Expected array initializer list, got array element");
					return -1;
				}
			}
		}
		return il.size;
	}

	/**
	 * Visit operations called for array creation expresions.
	 *
	 * @param expr an array creation expression
	 */
	public override void visit_array_creation_expression (ArrayCreationExpression expr) {
		Collection<Expression> size = expr.get_sizes ();
		var initlist = expr.initializer_list;

		if (expr.element_type != null) {
			expr.element_type.accept (this);
		}

		foreach (Expression e in size) {
			e.accept (this);
		}

		var calc_sizes = new ArrayList<Literal> ();
		if (initlist != null) {
			initlist.expected_type = new ArrayType (expr.element_type, expr.rank, expr.source_reference);
			initlist.expected_type.add_type_argument (expr.element_type);

			initlist.accept (this);

			var ret = create_sizes_from_initializer_list (initlist, expr.rank, calc_sizes);
			if (ret == -1) {
				expr.error = true;
			}
		}

		if (size.size > 0) {
			/* check for errors in the size list */
			foreach (Expression e in size) {
				if (e.static_type == null) {
					/* return on previous error */
					return;
				} else if (!(e.static_type.data_type is Struct) || !((Struct) e.static_type.data_type).is_integer_type ()) {
					expr.error = true;
					Report.error (e.source_reference, "Expression of integer type expected");
				}
			}
		} else {
			if (initlist == null) {
				expr.error = true;
				/* this is an internal error because it is already handeld by the parser */
				Report.error (expr.source_reference, "internal error: initializer list expected");
			} else {
				foreach (Expression size in calc_sizes) {
					expr.append_size (size);
				}
			}
		}

		if (expr.error) {
			return;
		}

		/* check for wrong elements inside the initializer */
		if (expr.initializer_list != null && expr.initializer_list.static_type == null) {
			return;
		}

		/* try to construct the type of the array */
		if (expr.element_type == null) {
			expr.error = true;
			Report.error (expr.source_reference, "Cannot determine the element type of the created array");
			return;
		}

		/* arrays of struct type elements do not take ownership since they are copied into the array */
		if (expr.element_type.data_type is Struct) {
			expr.element_type.takes_ownership = false;
		} else {
			expr.element_type.takes_ownership = true;
		}

		expr.static_type = new ArrayType (expr.element_type, expr.rank, expr.source_reference);
		expr.static_type.transfers_ownership = true;
		expr.static_type.takes_ownership = true;

		expr.static_type.add_type_argument (expr.element_type);
	}

	public override void visit_boolean_literal (BooleanLiteral expr) {
		expr.static_type = bool_type;
	}

	public override void visit_character_literal (CharacterLiteral expr) {
		expr.static_type = new ValueType ((Typesymbol) root_symbol.scope.lookup ("char"));
	}

	public override void visit_integer_literal (IntegerLiteral expr) {
		var int_type = new IntegerType ((Typesymbol) root_symbol.scope.lookup (expr.get_type_name ()));
		int_type.literal = expr;
		expr.static_type = int_type;
	}

	public override void visit_real_literal (RealLiteral expr) {
		expr.static_type = new ValueType ((Typesymbol) root_symbol.scope.lookup (expr.get_type_name ()));
	}

	public override void visit_string_literal (StringLiteral expr) {
		expr.static_type = string_type.copy ();
	}

	public override void visit_null_literal (NullLiteral expr) {
		expr.static_type = new NullType (expr.source_reference);
	}

	private DataType? get_static_type_for_symbol (Symbol sym) {
		if (sym is Field) {
			var f = (Field) sym;
			return f.type_reference;
		} else if (sym is Constant) {
			var c = (Constant) sym;
			return c.type_reference;
		} else if (sym is Property) {
			var prop = (Property) sym;
			var type = prop.type_reference.copy ();
			type.takes_ownership = false;
			return type;
		} else if (sym is FormalParameter) {
			var p = (FormalParameter) sym;
			var type = p.type_reference.copy ();
			type.transfers_ownership = false;
			return type;
		} else if (sym is DataType) {
			return (DataType) sym;
		} else if (sym is VariableDeclarator) {
			var decl = (VariableDeclarator) sym;
			return decl.type_reference;
		} else if (sym is EnumValue) {
			return new ValueType ((Typesymbol) sym.parent_symbol);
		} else if (sym is Method) {
			return new MethodType ((Method) sym);
		} else if (sym is Signal) {
			return new SignalType ((Signal) sym);
		}
		return null;
	}

	public static Symbol? symbol_lookup_inherited (Symbol sym, string name) {
		var result = sym.scope.lookup (name);
		if (result != null) {
			return result;
		}

		if (sym is Class) {
			var cl = (Class) sym;
			// first check interfaces without prerequisites
			// (prerequisites can be assumed to be met already)
			foreach (DataType base_type in cl.get_base_types ()) {
				if (base_type.data_type is Interface) {
					result = base_type.data_type.scope.lookup (name);
					if (result != null) {
						return result;
					}
				}
			}
			// then check base class recursively
			if (cl.base_class != null) {
				return symbol_lookup_inherited (cl.base_class, name);
			}
		} else if (sym is Struct) {
			var st = (Struct) sym;
			foreach (DataType base_type in st.get_base_types ()) {
				result = symbol_lookup_inherited (base_type.data_type, name);
				if (result != null) {
					return result;
				}
			}
		} else if (sym is Interface) {
			var iface = (Interface) sym;
			// first check interface prerequisites recursively
			foreach (DataType prerequisite in iface.get_prerequisites ()) {
				if (prerequisite.data_type is Interface) {
					result = symbol_lookup_inherited (prerequisite.data_type, name);
					if (result != null) {
						return result;
					}
				}
			}
			// then check class prerequisite recursively
			foreach (DataType prerequisite in iface.get_prerequisites ()) {
				if (prerequisite.data_type is Class) {
					result = symbol_lookup_inherited (prerequisite.data_type, name);
					if (result != null) {
						return result;
					}
				}
			}
		}

		return null;
	}

	public override void visit_parenthesized_expression (ParenthesizedExpression expr) {
		expr.inner.expected_type = expr.expected_type;

		expr.accept_children (this);

		if (expr.inner.error) {
			// ignore inner error
			expr.error = true;
			return;
		}

		if (expr.inner.static_type == null) {
			// static type may be null for method references
			expr.error = true;
			Report.error (expr.inner.source_reference, "Invalid expression type");
			return;
		}

		expr.static_type = expr.inner.static_type.copy ();
		// don't call g_object_ref_sink on inner and outer expression
		expr.static_type.floating_reference = false;
	}

	public override void visit_member_access (MemberAccess expr) {
		Symbol base_symbol = null;
		bool may_access_instance_members = false;

		expr.symbol_reference = null;

		if (expr.inner == null) {
			base_symbol = current_symbol;

			var sym = current_symbol;
			while (sym != null && expr.symbol_reference == null) {
				if (sym is CreationMethod || sym is Property || sym is Constructor || sym is Destructor) {
					may_access_instance_members = true;
				} else if (sym is Method) {
					var m = (Method) sym;
					may_access_instance_members = m.instance;
				}

				expr.symbol_reference = symbol_lookup_inherited (sym, expr.member_name);
				sym = sym.parent_symbol;
			}

			if (expr.symbol_reference == null) {
				foreach (NamespaceReference ns in current_using_directives) {
					var local_sym = ns.namespace_symbol.scope.lookup (expr.member_name);
					if (local_sym != null) {
						if (expr.symbol_reference != null) {
							expr.error = true;
							Report.error (expr.source_reference, "`%s' is an ambiguous reference between `%s' and `%s'".printf (expr.member_name, expr.symbol_reference.get_full_name (), local_sym.get_full_name ()));
							return;
						}
						expr.symbol_reference = local_sym;
					}
				}
			}
		} else {
			if (expr.inner.error) {
				/* if there was an error in the inner expression, skip this check */
				expr.error = true;
				return;
			}

			if (expr.inner is MemberAccess) {
				var ma = (MemberAccess) expr.inner;
				if (ma.prototype_access) {
					expr.error = true;
					Report.error (expr.source_reference, "Access to instance member `%s' denied".printf (expr.inner.symbol_reference.get_full_name ()));
					return;
				}
			}

			if (expr.inner is MemberAccess || expr.inner is BaseAccess) {
				base_symbol = expr.inner.symbol_reference;

				if (expr.creation_member && base_symbol is Typesymbol) {
					// check for named creation method
					expr.symbol_reference = base_symbol.scope.lookup (".new." + expr.member_name);
				}

				if (expr.symbol_reference == null && (base_symbol is Namespace || base_symbol is Typesymbol)) {
					expr.symbol_reference = base_symbol.scope.lookup (expr.member_name);
					if (expr.inner is BaseAccess) {
						// inner expression is base access
						// access to instance members of the base type possible
						may_access_instance_members = true;
					}
				}
			}

			if (expr.symbol_reference == null && expr.inner.static_type != null) {
				if (expr.pointer_member_access) {
					expr.symbol_reference = expr.inner.static_type.get_pointer_member (expr.member_name);
				} else {
					if (expr.inner.static_type.data_type != null) {
						base_symbol = expr.inner.static_type.data_type;
					}
					expr.symbol_reference = expr.inner.static_type.get_member (expr.member_name);
				}
				if (expr.symbol_reference != null) {
					// inner expression is variable, field, or parameter
					// access to instance members of the corresponding type possible
					may_access_instance_members = true;
				}
			}

			if (expr.symbol_reference == null && expr.inner is MemberAccess && base_symbol is Struct) {
				// check for named struct creation method
				expr.symbol_reference = base_symbol.scope.lookup (".new." + expr.member_name);
			}
		}

		if (expr.symbol_reference == null) {
			/* allow plug-ins to provide custom member bindings */
			foreach (BindingProvider binding_provider in binding_providers) {
				expr.symbol_reference = binding_provider.get_binding (expr);
				if (expr.symbol_reference != null) {
					may_access_instance_members = true;
					break;
				}
			}

			if (expr.symbol_reference == null) {
				expr.error = true;

				string base_type_name = "(null)";
				if (expr.inner != null && expr.inner.static_type != null) {
					base_type_name = expr.inner.static_type.to_string ();
				} else if (base_symbol != null) {
					base_type_name = base_symbol.get_full_name ();
				}

				Report.error (expr.source_reference, "The name `%s' does not exist in the context of `%s'".printf (expr.member_name, base_type_name));
				return;
			}
		}

		var member = expr.symbol_reference;
		var access = SymbolAccessibility.PUBLIC;
		bool instance = false;
		if (member is Field) {
			var f = (Field) member;
			access = f.access;
			instance = f.instance;
		} else if (member is Method) {
			var m = (Method) member;
			access = m.access;
			instance = m.instance;
		} else if (member is Property) {
			var prop = (Property) member;
			access = prop.access;
			if (expr.lvalue) {
				if (prop.set_accessor == null) {
					expr.error = true;
					Report.error (expr.source_reference, "Property `%s' is read-only".printf (prop.get_full_name ()));
					return;
				}
				if (prop.access == SymbolAccessibility.PUBLIC) {
					access = prop.set_accessor.access;
				} else if (prop.access == SymbolAccessibility.PROTECTED
				           && prop.set_accessor.access != SymbolAccessibility.PUBLIC) {
					access = prop.set_accessor.access;
				}
			} else {
				if (prop.get_accessor == null) {
					expr.error = true;
					Report.error (expr.source_reference, "Property `%s' is write-only".printf (prop.get_full_name ()));
					return;
				}
				if (prop.access == SymbolAccessibility.PUBLIC) {
					access = prop.get_accessor.access;
				} else if (prop.access == SymbolAccessibility.PROTECTED
				           && prop.get_accessor.access != SymbolAccessibility.PUBLIC) {
					access = prop.get_accessor.access;
				}
			}
			instance = prop.instance;
		} else if (member is Signal) {
			instance = true;
		}

		if (access == SymbolAccessibility.PRIVATE) {
			var target_type = member.parent_symbol;

			bool in_target_type = false;
			for (Symbol this_symbol = current_symbol; this_symbol != null; this_symbol = this_symbol.parent_symbol) {
				if (target_type == this_symbol) {
					in_target_type = true;
					break;
				}
			}

			if (!in_target_type) {
				expr.error = true;
				Report.error (expr.source_reference, "Access to private member `%s' denied".printf (member.get_full_name ()));
				return;
			}
		}
		if (instance && !may_access_instance_members) {
			expr.prototype_access = true;

			// also set static type for prototype access
			// required when using instance methods as delegates in constants
			expr.static_type = get_static_type_for_symbol (expr.symbol_reference);
		} else {
			expr.static_type = get_static_type_for_symbol (expr.symbol_reference);

			// resolve generic return values
			if (expr.static_type != null && expr.static_type.type_parameter != null) {
				if (expr.inner != null) {
					expr.static_type = get_actual_type (expr.inner.static_type, expr.symbol_reference, expr.static_type, expr);
					if (expr.static_type == null) {
						return;
					}
				}
			}
		}

		current_source_file.add_symbol_dependency (expr.symbol_reference, SourceFileDependencyType.SOURCE);
	}

	public override void visit_invocation_expression (InvocationExpression expr) {
		expr.call.accept (this);

		if (expr.call.error) {
			/* if method resolving didn't succeed, skip this check */
			expr.error = true;
			return;
		}

		if (expr.call is MemberAccess) {
			var ma = (MemberAccess) expr.call;
			if (ma.prototype_access) {
				expr.error = true;
				Report.error (expr.source_reference, "Access to instance member `%s' denied".printf (expr.call.symbol_reference.get_full_name ()));
				return;
			}
		}

		var mtype = expr.call.static_type;

		// check for struct construction
		if (expr.call is MemberAccess &&
		    (expr.call.symbol_reference is CreationMethod
		     || expr.call.symbol_reference is Struct)) {
			var struct_creation_expression = context.create_object_creation_expression ((MemberAccess) expr.call, expr.source_reference);
			struct_creation_expression.struct_creation = true;
			foreach (Expression arg in expr.get_argument_list ()) {
				struct_creation_expression.add_argument (arg);
			}
			expr.parent_node.replace_expression (expr, struct_creation_expression);
			struct_creation_expression.accept (this);
			return;
		}

		Collection<FormalParameter> params;

		if (mtype != null && mtype.is_invokable ()) {
			params = mtype.get_parameters ();
		} else {
			expr.error = true;
			Report.error (expr.source_reference, "invocation not supported in this context");
			return;
		}

		var args = expr.get_argument_list ();
		Iterator<Expression> arg_it = args.iterator ();
		foreach (FormalParameter param in params) {
			if (param.ellipsis) {
				break;
			}

			if (arg_it.next ()) {
				Expression arg = arg_it.get ();

				/* store expected type for callback parameters */
				arg.expected_type = param.type_reference;
			}
		}

		foreach (Expression arg in expr.get_argument_list ()) {
			arg.accept (this);
		}

		DataType ret_type;

		ret_type = mtype.get_return_type ();
		params = mtype.get_parameters ();

		if (ret_type is VoidType) {
			// void return type
			if (!(expr.parent_node is ExpressionStatement)) {
				expr.error = true;
				Report.error (expr.source_reference, "invocation of void method not allowed as expression");
				return;
			}
		}

		// resolve generic return values
		var ma = expr.call as MemberAccess;
		if (ret_type.type_parameter != null) {
			if (ma != null && ma.inner != null) {
				ret_type = get_actual_type (ma.inner.static_type, ma.symbol_reference, ret_type, expr);
				if (ret_type == null) {
					return;
				}
			}
		}
		Gee.List<DataType> resolved_type_args = new ArrayList<DataType> ();
		foreach (DataType type_arg in ret_type.get_type_arguments ()) {
			if (type_arg.type_parameter != null && ma != null && ma.inner != null) {
				resolved_type_args.add (get_actual_type (ma.inner.static_type, ma.symbol_reference, type_arg, expr));
			} else {
				resolved_type_args.add (type_arg);
			}
		}
		ret_type = ret_type.copy ();
		ret_type.remove_all_type_arguments ();
		foreach (DataType resolved_type_arg in resolved_type_args) {
			ret_type.add_type_argument (resolved_type_arg);
		}

		if (mtype is MethodType) {
			var m = ((MethodType) mtype).method_symbol;
			expr.tree_can_fail = expr.can_fail = (m.get_error_domains ().size > 0);
		}

		expr.static_type = ret_type;

		check_arguments (expr, mtype, params, expr.get_argument_list ());
	}

	private bool check_arguments (Expression expr, DataType mtype, Collection<FormalParameter> params, Collection<Expression> args) {
		Expression prev_arg = null;
		Iterator<Expression> arg_it = args.iterator ();

		bool diag = (mtype is MethodType && ((MethodType) mtype).method_symbol.get_attribute ("Diagnostics") != null);

		bool ellipsis = false;
		int i = 0;
		foreach (FormalParameter param in params) {
			if (param.ellipsis) {
				ellipsis = true;
				break;
			}

			/* header file necessary if we need to cast argument */
			current_source_file.add_type_dependency (param.type_reference, SourceFileDependencyType.SOURCE);

			if (!arg_it.next ()) {
				if (param.default_expression == null) {
					expr.error = true;
					Report.error (expr.source_reference, "Too few arguments, method `%s' does not take %d arguments".printf (mtype.to_string (), args.size));
					return false;
				}
			} else {
				var arg = arg_it.get ();
				if (arg.error) {
					// ignore inner error
					expr.error = true;
					return false;
				} else if (arg.static_type == null) {
					// disallow untyped arguments except for type inference of callbacks
					if (!(param.type_reference is DelegateType) || !(arg.symbol_reference is Method)) {
						expr.error = true;
						Report.error (arg.source_reference, "Invalid type for argument %d".printf (i + 1));
						return false;
					}
				} else if (!arg.static_type.compatible (param.type_reference)) {
					expr.error = true;
					Report.error (arg.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.static_type.to_string (), param.type_reference.to_string ()));
					return false;
				} else {
					// 0 => null, 1 => in, 2 => ref, 3 => out
					int arg_type = 1;
					if (arg.static_type is NullType) {
						arg_type = 0;
					} else if (arg is UnaryExpression) {
						var unary = (UnaryExpression) arg;
						if (unary.operator == UnaryOperator.REF) {
							arg_type = 2;
						} else if (unary.operator == UnaryOperator.OUT) {
							arg_type = 3;
						}
					}

					if (arg_type == 0) {
						if (param.type_reference.is_ref) {
							expr.error = true;
							Report.error (arg.source_reference, "Argument %d: Cannot pass null to reference parameter".printf (i + 1));
							return false;
						} else if (!param.type_reference.is_out && !param.type_reference.nullable) {
							Report.warning (arg.source_reference, "Argument %d: Cannot pass null to non-null parameter type".printf (i + 1));
						}
					} else if (arg_type == 1) {
						if (param.type_reference.is_ref || param.type_reference.is_out) {
							expr.error = true;
							Report.error (arg.source_reference, "Argument %d: Cannot pass value to reference or output parameter".printf (i + 1));
							return false;
						}
					} else if (arg_type == 2) {
						if (!param.type_reference.is_ref) {
							expr.error = true;
							Report.error (arg.source_reference, "Argument %d: Cannot pass ref argument to non-reference parameter".printf (i + 1));
							return false;
						}
					} else if (arg_type == 3) {
						if (!param.type_reference.is_out) {
							expr.error = true;
							Report.error (arg.source_reference, "Argument %d: Cannot pass out argument to non-output parameter".printf (i + 1));
							return false;
						}
					}
				}

				prev_arg = arg;

				i++;
			}
		}

		if (ellipsis) {
			while (arg_it.next ()) {
				var arg = arg_it.get ();
				if (arg.error) {
					// ignore inner error
					expr.error = true;
					return false;
				} else if (arg.static_type == null) {
					// disallow untyped arguments except for type inference of callbacks
					if (!(arg.symbol_reference is Method)) {
						expr.error = true;
						Report.error (expr.source_reference, "Invalid type for argument %d".printf (i + 1));
						return false;
					}
				}

				i++;
			}
		} else if (!ellipsis && arg_it.next ()) {
			expr.error = true;
			Report.error (expr.source_reference, "Too many arguments, method `%s' does not take %d arguments".printf (mtype.to_string (), args.size));
			return false;
		}

		if (diag && prev_arg != null) {
			var format_arg = prev_arg as StringLiteral;
			if (format_arg != null) {
				format_arg.value = "\"%s:%d: %s".printf (Path.get_basename (expr.source_reference.file.filename), expr.source_reference.first_line, format_arg.value.offset (1));
			}
		}

		return true;
	}

	private static DataType? get_instance_base_type (DataType instance_type, DataType base_type, CodeNode node_reference) {
		// construct a new type reference for the base type with correctly linked type arguments
		ReferenceType instance_base_type;
		if (base_type.data_type is Class) {
			instance_base_type = new ClassType ((Class) base_type.data_type);
		} else {
			instance_base_type = new InterfaceType ((Interface) base_type.data_type);
		}
		foreach (DataType type_arg in base_type.get_type_arguments ()) {
			if (type_arg.type_parameter != null) {
				// link to type argument of derived type
				int param_index = instance_type.data_type.get_type_parameter_index (type_arg.type_parameter.name);
				if (param_index == -1) {
					Report.error (node_reference.source_reference, "internal error: unknown type parameter %s".printf (type_arg.type_parameter.name));
					node_reference.error = true;
					return null;
				}
				type_arg = instance_type.get_type_arguments ().get (param_index);
			}
			instance_base_type.add_type_argument (type_arg);
		}
		return instance_base_type;
	}

	public static DataType? get_actual_type (DataType derived_instance_type, Symbol generic_member, DataType generic_type, CodeNode node_reference) {
		DataType instance_type = derived_instance_type;

		while (instance_type is PointerType) {
			var instance_pointer_type = (PointerType) instance_type;
			instance_type = instance_pointer_type.base_type;
		}

		// trace type arguments back to the datatype where the method has been declared
		while (instance_type.data_type != generic_member.parent_symbol) {
			DataType instance_base_type = null;

			// use same algorithm as symbol_lookup_inherited
			if (instance_type.data_type is Class) {
				var cl = (Class) instance_type.data_type;
				// first check interfaces without prerequisites
				// (prerequisites can be assumed to be met already)
				foreach (DataType base_type in cl.get_base_types ()) {
					if (base_type.data_type is Interface) {
						if (base_type.data_type.scope.lookup (generic_member.name) == generic_member) {
							instance_base_type = get_instance_base_type (instance_type, base_type, node_reference);
							break;
						}
					}
				}
				// then check base class recursively
				if (instance_base_type == null) {
					foreach (DataType base_type in cl.get_base_types ()) {
						if (base_type.data_type is Class) {
							if (symbol_lookup_inherited (cl.base_class, generic_member.name) == generic_member) {
								instance_base_type = get_instance_base_type (instance_type, base_type, node_reference);
								break;
							}
						}
					}
				}
			} else if (instance_type.data_type is Struct) {
				var st = (Struct) instance_type.data_type;
				foreach (DataType base_type in st.get_base_types ()) {
					if (base_type.data_type.scope.lookup (generic_member.name) == generic_member) {
						instance_base_type = get_instance_base_type (instance_type, base_type, node_reference);
						break;
					}
				}
			} else if (instance_type.data_type is Interface) {
				var iface = (Interface) instance_type.data_type;
				// first check interface prerequisites recursively
				foreach (DataType prerequisite in iface.get_prerequisites ()) {
					if (prerequisite.data_type is Interface) {
						if (symbol_lookup_inherited (prerequisite.data_type, generic_member.name) == generic_member) {
							instance_base_type = get_instance_base_type (instance_type, prerequisite, node_reference);
							break;
						}
					}
				}
				if (instance_base_type == null) {
					// then check class prerequisite recursively
					foreach (DataType prerequisite in iface.get_prerequisites ()) {
						if (prerequisite.data_type is Class) {
							if (symbol_lookup_inherited (prerequisite.data_type, generic_member.name) == generic_member) {
								instance_base_type = get_instance_base_type (instance_type, prerequisite, node_reference);
								break;
							}
						}
					}
				}
			} else {
				Report.error (node_reference.source_reference, "internal error: unsupported generic type");
				node_reference.error = true;
				return null;
			}

			if (instance_base_type == null) {
				Report.error (node_reference.source_reference, "internal error: unable to find generic member `%s'".printf (generic_member.name));
				node_reference.error = true;
				return null;
			}
			instance_type = instance_base_type;

			while (instance_type is PointerType) {
				var instance_pointer_type = (PointerType) instance_type;
				instance_type = instance_pointer_type.base_type;
			}
		}
		if (instance_type.data_type != generic_member.parent_symbol) {
			Report.error (node_reference.source_reference, "internal error: generic type parameter tracing not supported yet");
			node_reference.error = true;
			return null;
		}
		int param_index = instance_type.data_type.get_type_parameter_index (generic_type.type_parameter.name);
		if (param_index == -1) {
			Report.error (node_reference.source_reference, "internal error: unknown type parameter %s".printf (generic_type.type_parameter.name));
			node_reference.error = true;
			return null;
		}

		DataType actual_type = null;
		if (param_index < instance_type.get_type_arguments ().size) {
			actual_type = (DataType) instance_type.get_type_arguments ().get (param_index);
		}
		if (actual_type == null) {
			// no actual type available
			return generic_type;
		}
		actual_type = actual_type.copy ();
		actual_type.transfers_ownership = actual_type.takes_ownership && generic_type.transfers_ownership;
		actual_type.takes_ownership = actual_type.takes_ownership && generic_type.takes_ownership;
		return actual_type;
	}

	public override void visit_element_access (ElementAccess expr) {
		if (expr.container.static_type == null) {
			/* don't proceed if a child expression failed */
			expr.error = true;
			return;
		}

		var container_type = expr.container.static_type.data_type;

		bool index_int_type_check = true;

		var pointer_type = expr.container.static_type as PointerType;

		/* assign a static_type when possible */
		if (expr.container.static_type is ArrayType) {
			var args = expr.container.static_type.get_type_arguments ();

			if (args.size != 1) {
				expr.error = true;
				Report.error (expr.source_reference, "internal error: array reference with %d type arguments, expected 1".printf (args.size));
				return;
			}

			expr.static_type = args.get (0);
		} else if (pointer_type != null && !pointer_type.base_type.is_reference_type_or_type_parameter ()) {
			expr.static_type = pointer_type.base_type.copy ();
		} else if (container_type == string_type.data_type) {
			if (expr.get_indices ().size != 1) {
				expr.error = true;
				Report.error (expr.source_reference, "Element access with more than one dimension is not supported for strings");
				return;
			}

			expr.static_type = unichar_type;
		} else if (container_type != null && list_type != null && map_type != null &&
		           (container_type.is_subtype_of (list_type) || container_type.is_subtype_of (map_type))) {
			Collection<Expression> indices = expr.get_indices ();
			if (indices.size != 1) {
				expr.error = true;
				Report.error (expr.source_reference, "Element access with more than one dimension is not supported for the specified type");
				return;
			}
			Iterator<Expression> indices_it = indices.iterator ();
			indices_it.next ();
			var index = indices_it.get ();
			index_int_type_check = false;

			var get_sym = container_type.scope.lookup ("get");
			if (!(get_sym is Method)) {
				expr.error = true;
				Report.error (expr.source_reference, "invalid get method in specified collection type");
				return;
			}
			var get_method = (Method) get_sym;
			Collection<FormalParameter> get_params = get_method.get_parameters ();
			Iterator<FormalParameter> get_params_it = get_params.iterator ();
			get_params_it.next ();
			var get_param = get_params_it.get ();

			var index_type = get_param.type_reference;
			if (index_type.type_parameter != null) {
				index_type = get_actual_type (expr.container.static_type, get_method, get_param.type_reference, expr);
			}

			if (!index.static_type.compatible (index_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "index expression: Cannot convert from `%s' to `%s'".printf (index.static_type.to_string (), index_type.to_string ()));
				return;
			}

			expr.static_type = get_actual_type (expr.container.static_type, get_method, get_method.return_type, expr).copy ();
			expr.static_type.takes_ownership = false;
		} else {
			expr.error = true;
			Report.error (expr.source_reference, "The expression `%s' does not denote an Array".printf (expr.container.static_type.to_string ()));
		}

		if (index_int_type_check) {
			/* check if the index is of type integer */
			foreach (Expression e in expr.get_indices ()) {
				/* don't proceed if a child expression failed */
				if (e.static_type == null) {
					return;
				}

				/* check if the index is of type integer */
				if (!(e.static_type.data_type is Struct) || !((Struct) e.static_type.data_type).is_integer_type ()) {
					expr.error = true;
					Report.error (e.source_reference, "Expression of integer type expected");
				}
			}
		}
	}

	public override void visit_base_access (BaseAccess expr) {
		if (current_class == null) {
			if (current_struct == null) {
				expr.error = true;
				Report.error (expr.source_reference, "Base access invalid outside of class and struct");
				return;
			} else if (current_struct.get_base_types ().size != 1) {
				expr.error = true;
				Report.error (expr.source_reference, "Base access invalid without base type %d".printf (current_struct.get_base_types ().size));
				return;
			}
			Iterator<DataType> base_type_it = current_struct.get_base_types ().iterator ();
			base_type_it.next ();
			expr.static_type = base_type_it.get ();
		} else {
			expr.static_type = new ClassType (current_class.base_class);
		}

		expr.symbol_reference = expr.static_type.data_type;
	}

	public override void visit_postfix_expression (PostfixExpression expr) {
		expr.static_type = expr.inner.static_type;
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		if (expr.member_name != null) {
			expr.member_name.accept (this);
		}

		Typesymbol type = null;

		if (expr.type_reference == null) {
			if (expr.member_name == null) {
				expr.error = true;
				Report.error (expr.source_reference, "Incomplete object creation expression");
				return;
			}

			if (expr.member_name.symbol_reference == null) {
				expr.error = true;
				return;
			}

			var constructor_sym = expr.member_name.symbol_reference;
			var type_sym = expr.member_name.symbol_reference;

			var type_args = expr.member_name.get_type_arguments ();

			if (constructor_sym is Method) {
				type_sym = constructor_sym.parent_symbol;

				var constructor = (Method) constructor_sym;
				if (!(constructor_sym is CreationMethod)) {
					expr.error = true;
					Report.error (expr.source_reference, "`%s' is not a creation method".printf (constructor.get_full_name ()));
					return;
				}

				expr.symbol_reference = constructor;

				type_args = ((MemberAccess) expr.member_name.inner).get_type_arguments ();
			} else if (constructor_sym is ErrorCode) {
				type_sym = constructor_sym.parent_symbol;

				expr.symbol_reference = constructor_sym;
			}

			if (type_sym is Class) {
				type = (Typesymbol) type_sym;
				expr.type_reference = new ClassType ((Class) type);
			} else if (type_sym is Struct) {
				type = (Typesymbol) type_sym;
				expr.type_reference = new ValueType (type);
			} else if (type_sym is ErrorDomain) {
				expr.type_reference = new ErrorType ((ErrorDomain) type_sym, expr.source_reference);
			} else {
				expr.error = true;
				Report.error (expr.source_reference, "`%s' is not a class, struct, or error domain".printf (type_sym.get_full_name ()));
				return;
			}

			foreach (DataType type_arg in type_args) {
				expr.type_reference.add_type_argument (type_arg);

				current_source_file.add_type_dependency (type_arg, SourceFileDependencyType.SOURCE);
			}
		} else {
			type = expr.type_reference.data_type;
		}

		current_source_file.add_symbol_dependency (type, SourceFileDependencyType.SOURCE);

		expr.static_type = expr.type_reference.copy ();
		expr.static_type.transfers_ownership = true;

		if (type is Class) {
			var cl = (Class) type;

			if (expr.struct_creation) {
				expr.error = true;
				Report.error (expr.source_reference, "syntax error, use `new' to create new objects");
				return;
			}

			if (cl.is_abstract) {
				expr.static_type = null;
				expr.error = true;
				Report.error (expr.source_reference, "Can't create instance of abstract class `%s'".printf (cl.get_full_name ()));
				return;
			}

			if (expr.symbol_reference == null) {
				expr.symbol_reference = cl.default_construction_method;
			}

			while (cl != null) {
				if (cl == initially_unowned_type) {
					expr.static_type.floating_reference = true;
					break;
				}

				cl = cl.base_class;
			}
		} else if (type is Struct) {
			var st = (Struct) type;

			if (!expr.struct_creation) {
				Report.warning (expr.source_reference, "deprecated syntax, don't use `new' to initialize structs");
			}

			expr.static_type.transfers_ownership = false;

			if (expr.symbol_reference == null) {
				expr.symbol_reference = st.default_construction_method;
			}
		}

		if (expr.symbol_reference == null && expr.get_argument_list ().size != 0) {
			expr.static_type = null;
			expr.error = true;
			Report.error (expr.source_reference, "No arguments allowed when constructing type `%s'".printf (type.get_full_name ()));
			return;
		}

		if (expr.symbol_reference is Method) {
			var m = (Method) expr.symbol_reference;

			var args = expr.get_argument_list ();
			Iterator<Expression> arg_it = args.iterator ();
			foreach (FormalParameter param in m.get_parameters ()) {
				if (param.ellipsis) {
					break;
				}

				if (arg_it.next ()) {
					Expression arg = arg_it.get ();

					/* store expected type for callback parameters */
					arg.expected_type = param.type_reference;
				}
			}

			foreach (Expression arg in args) {
				arg.accept (this);
			}

			check_arguments (expr, new MethodType (m), m.get_parameters (), args);

			expr.tree_can_fail = expr.can_fail = (m.get_error_domains ().size > 0);
		} else if (expr.type_reference is ErrorType) {
			expr.accept_children (this);

			if (expr.get_argument_list ().size == 0) {
				expr.error = true;
				Report.error (expr.source_reference, "Too few arguments, errors need at least 1 argument");
			} else {
				Iterator<Expression> arg_it = expr.get_argument_list ().iterator ();
				arg_it.next ();
				var ex = arg_it.get ();
				if (ex.static_type == null || !ex.static_type.compatible (string_type)) {
					expr.error = true;
					Report.error (expr.source_reference, "Invalid type for argument 1");
				}
			}
			expr.static_type = new VoidType ();
		}

		foreach (MemberInitializer init in expr.get_object_initializer ()) {
			visit_member_initializer (init, expr.type_reference);
		}
	}

	void visit_member_initializer (MemberInitializer init, DataType type) {
		init.accept (this);

		init.symbol_reference = symbol_lookup_inherited (type.data_type, init.name);
		if (!(init.symbol_reference is Field || init.symbol_reference is Property)) {
			init.error = true;
			Report.error (init.source_reference, "Invalid member `%s' in `%s'".printf (init.name, type.data_type.get_full_name ()));
			return;
		}
		if (init.symbol_reference.access != SymbolAccessibility.PUBLIC) {
			init.error = true;
			Report.error (init.source_reference, "Access to private member `%s' denied".printf (init.symbol_reference.get_full_name ()));
			return;
		}
		DataType member_type;
		if (init.symbol_reference is Field) {
			var f = (Field) init.symbol_reference;
			member_type = f.type_reference;
		} else if (init.symbol_reference is Property) {
			var prop = (Property) init.symbol_reference;
			member_type = prop.type_reference;
			if (prop.set_accessor == null || !prop.set_accessor.writable) {
				init.error = true;
				Report.error (init.source_reference, "Property `%s' is read-only".printf (prop.get_full_name ()));
				return;
			}
		}
		if (init.initializer.static_type == null || !init.initializer.static_type.compatible (member_type)) {
			init.error = true;
			Report.error (init.source_reference, "Invalid type for member `%s'".printf (init.name));
			return;
		}
	}

	public override void visit_sizeof_expression (SizeofExpression expr) {
		expr.static_type = ulong_type;
	}

	public override void visit_typeof_expression (TypeofExpression expr) {
		expr.static_type = type_type;
	}

	private bool is_numeric_type (DataType type) {
		if (!(type.data_type is Struct)) {
			return false;
		}

		var st = (Struct) type.data_type;
		return st.is_integer_type () || st.is_floating_type ();
	}

	private bool is_integer_type (DataType type) {
		if (!(type.data_type is Struct)) {
			return false;
		}

		var st = (Struct) type.data_type;
		return st.is_integer_type ();
	}

	public override void visit_unary_expression (UnaryExpression expr) {
		if (expr.inner.error) {
			/* if there was an error in the inner expression, skip type check */
			expr.error = true;
			return;
		}

		if (expr.operator == UnaryOperator.PLUS || expr.operator == UnaryOperator.MINUS) {
			// integer or floating point type
			if (!is_numeric_type (expr.inner.static_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "Operator not supported for `%s'".printf (expr.inner.static_type.to_string ()));
				return;
			}

			expr.static_type = expr.inner.static_type;
		} else if (expr.operator == UnaryOperator.LOGICAL_NEGATION) {
			// boolean type
			if (!expr.inner.static_type.compatible (bool_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "Operator not supported for `%s'".printf (expr.inner.static_type.to_string ()));
				return;
			}

			expr.static_type = expr.inner.static_type;
		} else if (expr.operator == UnaryOperator.BITWISE_COMPLEMENT) {
			// integer type
			if (!is_integer_type (expr.inner.static_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "Operator not supported for `%s'".printf (expr.inner.static_type.to_string ()));
				return;
			}

			expr.static_type = expr.inner.static_type;
		} else if (expr.operator == UnaryOperator.INCREMENT ||
		           expr.operator == UnaryOperator.DECREMENT) {
			// integer type
			if (!is_integer_type (expr.inner.static_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "Operator not supported for `%s'".printf (expr.inner.static_type.to_string ()));
				return;
			}

			var ma = find_member_access (expr.inner);
			if (ma == null) {
				expr.error = true;
				Report.error (expr.source_reference, "Prefix operators not supported for this expression");
				return;
			}

			var old_value = new MemberAccess (ma.inner, ma.member_name, expr.inner.source_reference);
			var bin = new BinaryExpression (expr.operator == UnaryOperator.INCREMENT ? BinaryOperator.PLUS : BinaryOperator.MINUS, old_value, new IntegerLiteral ("1"), expr.source_reference);

			var assignment = context.create_assignment (ma, bin, AssignmentOperator.SIMPLE, expr.source_reference);
			var parenthexp = new ParenthesizedExpression (assignment, expr.source_reference);
			expr.parent_node.replace_expression (expr, parenthexp);
			parenthexp.accept (this);
			return;
		} else if (expr.operator == UnaryOperator.REF || expr.operator == UnaryOperator.OUT) {
			if (expr.inner.symbol_reference is Field || expr.inner.symbol_reference is FormalParameter || expr.inner.symbol_reference is VariableDeclarator) {
				// ref and out can only be used with fields, parameters, and local variables
				expr.static_type = expr.inner.static_type;
			} else {
				expr.error = true;
				Report.error (expr.source_reference, "ref and out method arguments can only be used with fields, parameters, and local variables");
				return;
			}
		} else {
			expr.error = true;
			Report.error (expr.source_reference, "internal error: unsupported unary operator");
			return;
		}
	}

	private MemberAccess? find_member_access (Expression expr) {
		if (expr is ParenthesizedExpression) {
			var pe = (ParenthesizedExpression) expr;
			return find_member_access (pe.inner);
		}

		if (expr is MemberAccess) {
			return (MemberAccess) expr;
		}

		return null;
	}

	public override void visit_cast_expression (CastExpression expr) {
		if (expr.inner.error) {
			expr.error = true;
			return;
		}

		// FIXME: check whether cast is allowed

		current_source_file.add_type_dependency (expr.type_reference, SourceFileDependencyType.SOURCE);

		expr.static_type = expr.type_reference;
		expr.static_type.transfers_ownership = expr.inner.static_type.transfers_ownership;
	}

	public override void visit_pointer_indirection (PointerIndirection expr) {
		if (expr.inner.error) {
			return;
		}
		if (expr.inner.static_type == null) {
			expr.error = true;
			Report.error (expr.source_reference, "internal error: unknown type of inner expression");
			return;
		}
		if (expr.inner.static_type is PointerType) {
			var pointer_type = (PointerType) expr.inner.static_type;
			expr.static_type = pointer_type.base_type;
		} else {
			expr.error = true;
			Report.error (expr.source_reference, "Pointer indirection not supported for this expression");
			return;
		}
	}

	public override void visit_addressof_expression (AddressofExpression expr) {
		if (expr.inner.error) {
			return;
		}
		if (!(expr.inner.static_type is ValueType
		      || expr.inner.static_type is ClassType
		      || expr.inner.static_type is InterfaceType
		      || expr.inner.static_type is PointerType)) {
			expr.error = true;
			Report.error (expr.source_reference, "Address-of operator not supported for this expression");
			return;
		}

		if (expr.inner.static_type.is_reference_type_or_type_parameter ()) {
			expr.static_type = new PointerType (new PointerType (expr.inner.static_type));
		} else {
			expr.static_type = new PointerType (expr.inner.static_type);
		}
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		if (expr.inner.error) {
			/* if there was an error in the inner expression, skip type check */
			expr.error = true;
			return;
		}

		if (!(expr.inner is MemberAccess || expr.inner is ElementAccess)) {
			expr.error = true;
			Report.error (expr.source_reference, "Reference transfer not supported for this expression");
			return;
		}

		if (!expr.inner.static_type.takes_ownership
		    && !(expr.inner.static_type is PointerType)) {
			expr.error = true;
			Report.error (expr.source_reference, "No reference to be transferred");
			return;
		}

		expr.static_type = expr.inner.static_type.copy ();
		expr.static_type.transfers_ownership = true;
		expr.static_type.takes_ownership = false;
	}

	private DataType? get_arithmetic_result_type (DataType left_type, DataType right_type) {
		 if (!(left_type.data_type is Struct) || !(right_type.data_type is Struct)) {
			// at least one operand not struct
		 	return null;
		 }

		 var left = (Struct) left_type.data_type;
		 var right = (Struct) right_type.data_type;

		 if ((!left.is_floating_type () && !left.is_integer_type ()) ||
		     (!right.is_floating_type () && !right.is_integer_type ())) {
			// at least one operand not numeric
		 	return null;
		 }

		 if (left.is_floating_type () == right.is_floating_type ()) {
			// both operands integer or floating type
		 	if (left.get_rank () >= right.get_rank ()) {
		 		return left_type;
		 	} else {
		 		return right_type;
		 	}
		 } else {
			// one integer and one floating type operand
		 	if (left.is_floating_type ()) {
		 		return left_type;
		 	} else {
		 		return right_type;
		 	}
		 }
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		if (expr.left.error || expr.right.error) {
			/* if there were any errors in inner expressions, skip type check */
			expr.error = true;
			return;
		}

		if (expr.left.static_type == null) {
			Report.error (expr.left.source_reference, "invalid left operand");
			expr.error = true;
			return;
		}

		if (expr.operator != BinaryOperator.IN && expr.right.static_type == null) {
			Report.error (expr.right.source_reference, "invalid right operand");
			expr.error = true;
			return;
		}

		if (expr.left.static_type.data_type == string_type.data_type
		    && expr.operator == BinaryOperator.PLUS) {
			if (expr.right.static_type == null || expr.right.static_type.data_type != string_type.data_type) {
				expr.error = true;
				Report.error (expr.source_reference, "Operands must be strings");
				return;
			}

			/* string concatenation: convert to a.concat (b) */

			var concat_call = new InvocationExpression (new MemberAccess (expr.left, "concat"));
			concat_call.add_argument (expr.right);

			expr.parent_node.replace_expression (expr, concat_call);

			concat_call.accept (this);
		} else if (expr.operator == BinaryOperator.PLUS
			   || expr.operator == BinaryOperator.MINUS
			   || expr.operator == BinaryOperator.MUL
			   || expr.operator == BinaryOperator.DIV) {
			// check for pointer arithmetic
			if (expr.left.static_type is PointerType) {
				var offset_type = expr.right.static_type.data_type as Struct;
				if (offset_type != null && offset_type.is_integer_type ()) {
					if (expr.operator == BinaryOperator.PLUS
					    || expr.operator == BinaryOperator.MINUS) {
						// pointer arithmetic: pointer +/- offset
						expr.static_type = expr.left.static_type.copy ();
					}
				} else if (expr.right.static_type is PointerType) {
					// pointer arithmetic: pointer - pointer
					expr.static_type = size_t_type;
				}
			}

			if (expr.static_type == null) {
				expr.static_type = get_arithmetic_result_type (expr.left.static_type, expr.right.static_type);
			}

			if (expr.static_type == null) {
				expr.error = true;
				Report.error (expr.source_reference, "Arithmetic operation not supported for types `%s' and `%s'".printf (expr.left.static_type.to_string (), expr.right.static_type.to_string ()));
				return;
			}
		} else if (expr.operator == BinaryOperator.MOD
			   || expr.operator == BinaryOperator.SHIFT_LEFT
			   || expr.operator == BinaryOperator.SHIFT_RIGHT
			   || expr.operator == BinaryOperator.BITWISE_XOR) {
			expr.static_type = get_arithmetic_result_type (expr.left.static_type, expr.right.static_type);

			if (expr.static_type == null) {
				expr.error = true;
				Report.error (expr.source_reference, "Arithmetic operation not supported for types `%s' and `%s'".printf (expr.left.static_type.to_string (), expr.right.static_type.to_string ()));
				return;
			}
		} else if (expr.operator == BinaryOperator.LESS_THAN
			   || expr.operator == BinaryOperator.GREATER_THAN
			   || expr.operator == BinaryOperator.LESS_THAN_OR_EQUAL
			   || expr.operator == BinaryOperator.GREATER_THAN_OR_EQUAL) {
			if (expr.left.static_type.compatible (string_type)
			    && expr.right.static_type.compatible (string_type)) {
				// string comparison
				} else if (expr.left.static_type is PointerType && expr.right.static_type is PointerType) {
					// pointer arithmetic
			} else {
				var resulting_type = get_arithmetic_result_type (expr.left.static_type, expr.right.static_type);

				if (resulting_type == null) {
					expr.error = true;
					Report.error (expr.source_reference, "Relational operation not supported for types `%s' and `%s'".printf (expr.left.static_type.to_string (), expr.right.static_type.to_string ()));
					return;
				}
			}

			expr.static_type = bool_type;
		} else if (expr.operator == BinaryOperator.EQUALITY
			   || expr.operator == BinaryOperator.INEQUALITY) {
			/* relational operation */

			if (!expr.right.static_type.compatible (expr.left.static_type)
			    && !expr.left.static_type.compatible (expr.right.static_type)) {
				Report.error (expr.source_reference, "Equality operation: `%s' and `%s' are incompatible".printf (expr.right.static_type.to_string (), expr.left.static_type.to_string ()));
				expr.error = true;
				return;
			}

			if (expr.left.static_type.compatible (string_type)
			    && expr.right.static_type.compatible (string_type)) {
				// string comparison
			}

			expr.static_type = bool_type;
		} else if (expr.operator == BinaryOperator.BITWISE_AND
			   || expr.operator == BinaryOperator.BITWISE_OR) {
			// integer type or flags type

			expr.static_type = expr.left.static_type;
		} else if (expr.operator == BinaryOperator.AND
			   || expr.operator == BinaryOperator.OR) {
			if (!expr.left.static_type.compatible (bool_type) || !expr.right.static_type.compatible (bool_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "Operands must be boolean");
			}

			expr.static_type = bool_type;
		} else if (expr.operator == BinaryOperator.IN) {
			// integer type or flags type

			expr.static_type = bool_type;
		} else {
			assert_not_reached ();
		}
	}

	public override void visit_type_check (TypeCheck expr) {
		if (expr.type_reference.data_type == null) {
			/* if type resolving didn't succeed, skip this check */
			expr.error = true;
			return;
		}

		current_source_file.add_type_dependency (expr.type_reference, SourceFileDependencyType.SOURCE);

		expr.static_type = bool_type;
	}

	public override void visit_conditional_expression (ConditionalExpression expr) {
		if (!expr.condition.static_type.compatible (bool_type)) {
			expr.error = true;
			Report.error (expr.condition.source_reference, "Condition must be boolean");
			return;
		}

		/* FIXME: support memory management */
		if (expr.false_expression.static_type.compatible (expr.true_expression.static_type)) {
			expr.static_type = expr.true_expression.static_type.copy ();
		} else if (expr.true_expression.static_type.compatible (expr.false_expression.static_type)) {
			expr.static_type = expr.false_expression.static_type.copy ();
		} else {
			expr.error = true;
			Report.error (expr.condition.source_reference, "Incompatible expressions");
			return;
		}
	}

	private string get_lambda_name () {
		var result = "__lambda%d".printf (next_lambda_id);

		next_lambda_id++;

		return result;
	}

	private Method? find_current_method () {
		var sym = current_symbol;
		while (sym != null) {
			if (sym is Method) {
				return (Method) sym;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}

	private bool is_in_constructor () {
		var sym = current_symbol;
		while (sym != null) {
			if (sym is Constructor) {
				return true;
			}
			sym = sym.parent_symbol;
		}
		return false;
	}

	public override void visit_lambda_expression (LambdaExpression l) {
		if (!(l.expected_type is DelegateType)) {
			l.error = true;
			Report.error (l.source_reference, "lambda expression not allowed in this context");
			return;
		}

		bool in_instance_method = false;
		var current_method = find_current_method ();
		if (current_method != null) {
			in_instance_method = current_method.instance;
		} else {
			in_instance_method = is_in_constructor ();
		}

		var cb = (Delegate) ((DelegateType) l.expected_type).delegate_symbol;
		l.method = new Method (get_lambda_name (), cb.return_type);
		l.method.instance = cb.instance && in_instance_method;
		l.method.owner = current_symbol.scope;

		var lambda_params = l.get_parameters ();
		Iterator<string> lambda_param_it = lambda_params.iterator ();
		foreach (FormalParameter cb_param in cb.get_parameters ()) {
			if (!lambda_param_it.next ()) {
				/* lambda expressions are allowed to have less parameters */
				break;
			}

			string lambda_param = lambda_param_it.get ();

			var param = new FormalParameter (lambda_param, cb_param.type_reference);

			l.method.add_parameter (param);
		}

		if (lambda_param_it.next ()) {
			/* lambda expressions may not expect more parameters */
			l.error = true;
			Report.error (l.source_reference, "lambda expression: too many parameters");
			return;
		}

		if (l.expression_body != null) {
			var block = new Block ();
			block.scope.parent_scope = l.method.scope;

			if (l.method.return_type.data_type != null) {
				block.add_statement (new ReturnStatement (l.expression_body, l.source_reference));
			} else {
				block.add_statement (new ExpressionStatement (l.expression_body, l.source_reference));
			}

			l.method.body = block;
		} else {
			l.method.body = l.statement_body;
		}
		l.method.body.owner = l.method.scope;

		/* lambda expressions should be usable like MemberAccess of a method */
		l.symbol_reference = l.method;

		l.accept_children (this);
	}

	public override void visit_assignment (Assignment a) {
		a.left.lvalue = true;

		a.left.accept (this);

		if (a.left.error) {
			// skip on error in inner expression
			a.error = true;
			return;
		}

		if (a.left is MemberAccess) {
			var ma = (MemberAccess) a.left;

			if (!(ma.symbol_reference is Signal) && ma.static_type == null) {
				a.error = true;
				Report.error (a.source_reference, "unsupported lvalue in assignment");
				return;
			}
			if (ma.prototype_access) {
				a.error = true;
				Report.error (a.source_reference, "Access to instance member `%s' denied".printf (ma.symbol_reference.get_full_name ()));
				return;
			}

			if (ma.error || ma.symbol_reference == null) {
				a.error = true;
				/* if no symbol found, skip this check */
				return;
			}

			if (ma.symbol_reference is Signal) {
				var sig = (Signal) ma.symbol_reference;

				a.right.expected_type = new DelegateType (sig.get_delegate ());
			} else {
				a.right.expected_type = ma.static_type;
			}
		} else if (a.left is ElementAccess) {
			// do nothing
		} else if (a.left is PointerIndirection) {
			// do nothing
		} else {
			a.error = true;
			Report.error (a.source_reference, "unsupported lvalue in assignment");
			return;
		}

		a.right.accept (this);

		if (a.right.error) {
			// skip on error in inner expression
			a.error = true;
			return;
		}

		if (a.operator != AssignmentOperator.SIMPLE && a.left is MemberAccess) {
			// transform into simple assignment
			// FIXME: only do this if the backend doesn't support
			// the assignment natively

			var ma = (MemberAccess) a.left;

			if (!(ma.symbol_reference is Signal)) {
				var old_value = new MemberAccess (ma.inner, ma.member_name);

				var bin = new BinaryExpression (BinaryOperator.PLUS, old_value, new ParenthesizedExpression (a.right, a.right.source_reference));

				if (a.operator == AssignmentOperator.BITWISE_OR) {
					bin.operator = BinaryOperator.BITWISE_OR;
				} else if (a.operator == AssignmentOperator.BITWISE_AND) {
					bin.operator = BinaryOperator.BITWISE_AND;
				} else if (a.operator == AssignmentOperator.BITWISE_XOR) {
					bin.operator = BinaryOperator.BITWISE_XOR;
				} else if (a.operator == AssignmentOperator.ADD) {
					bin.operator = BinaryOperator.PLUS;
				} else if (a.operator == AssignmentOperator.SUB) {
					bin.operator = BinaryOperator.MINUS;
				} else if (a.operator == AssignmentOperator.MUL) {
					bin.operator = BinaryOperator.MUL;
				} else if (a.operator == AssignmentOperator.DIV) {
					bin.operator = BinaryOperator.DIV;
				} else if (a.operator == AssignmentOperator.PERCENT) {
					bin.operator = BinaryOperator.MOD;
				} else if (a.operator == AssignmentOperator.SHIFT_LEFT) {
					bin.operator = BinaryOperator.SHIFT_LEFT;
				} else if (a.operator == AssignmentOperator.SHIFT_RIGHT) {
					bin.operator = BinaryOperator.SHIFT_RIGHT;
				}

				a.right = bin;
				a.right.accept (this);

				a.operator = AssignmentOperator.SIMPLE;
			}
		}

		if (a.left is MemberAccess) {
			var ma = (MemberAccess) a.left;

			if (ma.symbol_reference is Signal) {
				var sig = (Signal) ma.symbol_reference;

				if (a.right.symbol_reference == null) {
					a.error = true;
					Report.error (a.right.source_reference, "unsupported expression for signal handler");
					return;
				}
			} else if (ma.symbol_reference is Property) {
				var prop = (Property) ma.symbol_reference;

				if (prop.set_accessor == null) {
					ma.error = true;
					Report.error (ma.source_reference, "Property `%s' is read-only".printf (prop.get_full_name ()));
					return;
				}
			} else if (ma.symbol_reference is VariableDeclarator && a.right.static_type == null) {
				var decl = (VariableDeclarator) ma.symbol_reference;

				if (a.right.symbol_reference is Method &&
				    decl.type_reference is DelegateType) {
					var m = (Method) a.right.symbol_reference;
					var dt = (DelegateType) decl.type_reference;
					var cb = dt.delegate_symbol;

					/* check whether method matches callback type */
					if (!cb.matches_method (m)) {
						decl.error = true;
						Report.error (a.source_reference, "declaration of method `%s' doesn't match declaration of callback `%s'".printf (m.get_full_name (), cb.get_full_name ()));
						return;
					}

					a.right.static_type = decl.type_reference;
				} else {
					a.error = true;
					Report.error (a.source_reference, "Assignment: Invalid callback assignment attempt");
					return;
				}
			} else if (ma.symbol_reference is Field && a.right.static_type == null) {
				var f = (Field) ma.symbol_reference;

				if (a.right.symbol_reference is Method &&
				    f.type_reference is DelegateType) {
					var m = (Method) a.right.symbol_reference;
					var dt = (DelegateType) f.type_reference;
					var cb = dt.delegate_symbol;

					/* check whether method matches callback type */
					if (!cb.matches_method (m)) {
						f.error = true;
						Report.error (a.source_reference, "declaration of method `%s' doesn't match declaration of callback `%s'".printf (m.get_full_name (), cb.get_full_name ()));
						return;
					}

					a.right.static_type = f.type_reference;
				} else {
					a.error = true;
					Report.error (a.source_reference, "Assignment: Invalid callback assignment attempt");
					return;
				}
			} else if (a.left.static_type != null && a.right.static_type != null) {
				/* if there was an error on either side,
				 * i.e. a.{left|right}.static_type == null, skip type check */

				if (!a.right.static_type.compatible (a.left.static_type)) {
					a.error = true;
					Report.error (a.source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (a.right.static_type.to_string (), a.left.static_type.to_string ()));
					return;
				}

				if (a.right.static_type.transfers_ownership) {
					/* rhs transfers ownership of the expression */
					if (!(a.left.static_type is PointerType) && !a.left.static_type.takes_ownership) {
						/* lhs doesn't own the value */
						a.error = true;
						Report.error (a.source_reference, "Invalid assignment from owned expression to unowned variable");
					}
				} else if (a.left.static_type.takes_ownership) {
					/* lhs wants to own the value
					 * rhs doesn't transfer the ownership
					 * code generator needs to add reference
					 * increment calls */
				}
			}
		} else if (a.left is ElementAccess) {
			var ea = (ElementAccess) a.left;

			if (!a.right.static_type.compatible (a.left.static_type)) {
				a.error = true;
				Report.error (a.source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (a.right.static_type.to_string (), a.left.static_type.to_string ()));
				return;
			}

			if (a.right.static_type.transfers_ownership) {
				/* rhs transfers ownership of the expression */

				var args = ea.container.static_type.get_type_arguments ();
				if (args.size != 1) {
					a.error = true;
					Report.error (ea.source_reference, "internal error: array reference with %d type arguments".printf (args.size));
					return;
				}
				var element_type = args.get (0);

				if (!(element_type is PointerType) && !element_type.takes_ownership) {
					/* lhs doesn't own the value */
					a.error = true;
					Report.error (a.source_reference, "Invalid assignment from owned expression to unowned variable");
					return;
				}
			} else if (a.left.static_type.takes_ownership) {
				/* lhs wants to own the value
				 * rhs doesn't transfer the ownership
				 * code generator needs to add reference
				 * increment calls */
			}
		} else {
			return;
		}

		if (a.left.static_type != null) {
			a.static_type = a.left.static_type.copy ();
			if (a.parent_node is ExpressionStatement) {
				// Gee.List.get () transfers ownership but void function Gee.List.set () doesn't
				a.static_type.transfers_ownership = false;
			}
		} else {
			a.static_type = null;
		}

		a.tree_can_fail = a.left.tree_can_fail || a.right.tree_can_fail;
	}
}
