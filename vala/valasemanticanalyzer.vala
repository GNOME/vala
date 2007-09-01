/* valasemanticanalyzer.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;
using Gee;

/**
 * Code visitor analyzing and checking code.
 */
public class Vala.SemanticAnalyzer : CodeVisitor {
	/**
	 * Specifies whether automatic memory management is active.
	 */
	public bool memory_management { get; set; }

	Symbol root_symbol;
	Symbol current_symbol;
	SourceFile current_source_file;
	TypeReference current_return_type;
	Class current_class;
	Struct current_struct;

	Collection<NamespaceReference> current_using_directives;

	TypeReference bool_type;
	TypeReference string_type;
	TypeReference int_type;
	TypeReference uint_type;
	TypeReference ulong_type;
	TypeReference unichar_type;
	TypeReference type_type;
	DataType pointer_type;
	DataType object_type;
	DataType initially_unowned_type;
	DataType glist_type;
	DataType gslist_type;
	DataType gerror_type;
	DataType iterable_type;
	DataType iterator_type;
	DataType list_type;
	DataType map_type;

	private int next_lambda_id = 0;

	private Collection<BindingProvider> binding_providers = new ArrayList<BindingProvider> ();

	public SemanticAnalyzer (bool manage_memory = true) {
		memory_management = manage_memory;
	}

	public void add_binding_provider (BindingProvider! binding_provider) {
		binding_providers.add (binding_provider);
	}

	/**
	 * Analyze and check code in the specified context.
	 *
	 * @param context a code context
	 */
	public void analyze (CodeContext! context) {
		root_symbol = context.root;

		bool_type = new TypeReference ();
		bool_type.data_type = (DataType) root_symbol.scope.lookup ("bool");

		string_type = new TypeReference ();
		string_type.data_type = (DataType) root_symbol.scope.lookup ("string");

		pointer_type = (DataType) root_symbol.scope.lookup ("pointer");

		int_type = new TypeReference ();
		int_type.data_type = (DataType) root_symbol.scope.lookup ("int");

		uint_type = new TypeReference ();
		uint_type.data_type = (DataType) root_symbol.scope.lookup ("uint");

		ulong_type = new TypeReference ();
		ulong_type.data_type = (DataType) root_symbol.scope.lookup ("ulong");

		unichar_type = new TypeReference ();
		unichar_type.data_type = (DataType) root_symbol.scope.lookup ("unichar");

		// TODO: don't require GLib namespace in semantic analyzer
		var glib_ns = root_symbol.scope.lookup ("GLib");
		if (glib_ns != null) {
			object_type = (DataType) glib_ns.scope.lookup ("Object");
			initially_unowned_type = (DataType) glib_ns.scope.lookup ("InitiallyUnowned");

			type_type = new TypeReference ();
			type_type.data_type = (DataType) glib_ns.scope.lookup ("Type");

			glist_type = (DataType) glib_ns.scope.lookup ("List");
			gslist_type = (DataType) glib_ns.scope.lookup ("SList");

			gerror_type = (DataType) glib_ns.scope.lookup ("Error");
		}

		var gee_ns = root_symbol.scope.lookup ("Gee");
		if (gee_ns != null) {
			iterable_type = (DataType) gee_ns.scope.lookup ("Iterable");
			iterator_type = (DataType) gee_ns.scope.lookup ("Iterator");
			list_type = (DataType) gee_ns.scope.lookup ("List");
			map_type = (DataType) gee_ns.scope.lookup ("Map");
		}

		current_symbol = root_symbol;
		context.accept (this);
	}

	public override void visit_source_file (SourceFile! file) {
		current_source_file = file;
		current_using_directives = file.get_using_directives ();

		next_lambda_id = 0;

		file.accept_children (this);

		current_using_directives = null;
	}

	public override void visit_class (Class! cl) {
		current_symbol = cl;
		current_class = cl;

		if (cl.base_class != null) {
			current_source_file.add_symbol_dependency (cl.base_class, SourceFileDependencyType.HEADER_FULL);
		}

		foreach (TypeReference base_type_reference in cl.get_base_types ()) {
			current_source_file.add_symbol_dependency (base_type_reference.data_type, SourceFileDependencyType.HEADER_FULL);
		}

		cl.accept_children (this);

		/* gather all prerequisites */
		Gee.List<DataType> prerequisites = new ArrayList<DataType> ();
		foreach (TypeReference base_type in cl.get_base_types ()) {
			if (base_type.data_type is Interface) {
				get_all_prerequisites ((Interface) base_type.data_type, prerequisites);
			}
		}
		/* check whether all prerequisites are met */
		Gee.List<string> missing_prereqs = new ArrayList<string> ();
		foreach (DataType prereq in prerequisites) {
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
			foreach (TypeReference base_type in cl.get_base_types ()) {
				if (base_type.data_type is Interface) {
					Interface iface = (Interface) base_type.data_type;

					/* We do not need to do expensive equality checking here since this is done
					 * already. We only need to guarantee the symbols are present.
					 */

					/* check methods */
					foreach (Method m in iface.get_methods ()) {
						if (m.is_abstract) {
							var sym = cl.scope.lookup (m.name);
							if (sym == null || !(sym is Method) || ((Method) sym).base_interface_method != m) {
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
					foreach (Method m in base_class.get_methods ()) {
						if (m.is_abstract) {
							var sym = cl.scope.lookup (m.name);
							if (sym == null || !(sym is Method) || ((Method) sym).base_method != m) {
								cl.error = true;
								Report.error (cl.source_reference, "`%s' does not implement abstract method `%s'".printf (cl.get_full_name (), m.get_full_name ()));
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

	private void get_all_prerequisites (Interface! iface, Collection<DataType> list) {
		foreach (TypeReference prereq in iface.get_prerequisites ()) {
			DataType type = prereq.data_type;
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

	private bool class_is_a (Class! cl, DataType! t) {
		if (cl == t) {
			return true;
		}

		foreach (TypeReference base_type in cl.get_base_types ()) {
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

	public override void visit_struct (Struct! st) {
		current_symbol = st;
		current_struct = st;

		st.accept_children (this);

		current_symbol = current_symbol.parent_symbol;
		current_struct = null;
	}

	public override void visit_interface (Interface! iface) {
		current_symbol = iface;

		foreach (TypeReference prerequisite_reference in iface.get_prerequisites ()) {
			current_source_file.add_symbol_dependency (prerequisite_reference.data_type, SourceFileDependencyType.HEADER_FULL);
		}

		/* check prerequisites */
		Class prereq_class;
		foreach (TypeReference prereq in iface.get_prerequisites ()) {
			DataType class_or_interface = prereq.data_type;
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

	public override void visit_callback (Callback! cb) {
		cb.accept_children (this);
	}

	public override void visit_constant (Constant! c) {
		c.accept_children (this);

		if (!current_source_file.pkg) {
			if (c.initializer == null) {
				c.error = true;
				Report.error (c.source_reference, "A const field requires a initializer to be provided");
			}
		}
	}

	public override void visit_field (Field! f) {
		f.accept_children (this);

		if (!f.is_internal_symbol ()) {
			if (f.type_reference.data_type != null) {
				/* is null if it references a type parameter */
				current_source_file.add_symbol_dependency (f.type_reference.data_type, SourceFileDependencyType.HEADER_SHALLOW);
			}
		} else {
			if (f.parent_symbol is Namespace) {
				f.error = true;
				Report.error (f.source_reference, "Namespaces may not have private members");
				return;
			}

			if (f.type_reference.data_type != null) {
				/* is null if it references a type parameter */
				current_source_file.add_symbol_dependency (f.type_reference.data_type, SourceFileDependencyType.SOURCE);
			}
		}
	}

	public override void visit_method (Method! m) {
		current_symbol = m;
		current_return_type = m.return_type;

		var init_attr = m.get_attribute ("ModuleInit");
		if (init_attr != null) {
			m.source_reference.file.context.module_init_method = m;
		}

		if (m.return_type.data_type != null) {
			/* is null if it is void or a reference to a type parameter */
			if (!m.is_internal_symbol ()) {
				current_source_file.add_symbol_dependency (m.return_type.data_type, SourceFileDependencyType.HEADER_SHALLOW);
			}
			current_source_file.add_symbol_dependency (m.return_type.data_type, SourceFileDependencyType.SOURCE);
		}

		m.accept_children (this);

		current_symbol = current_symbol.parent_symbol;
		current_return_type = null;

		if (current_symbol.parent_symbol is Method) {
			/* lambda expressions produce nested methods */
			var up_method = (Method) current_symbol.parent_symbol;
			current_return_type = up_method.return_type;
		}

		if (current_symbol is Class) {
			if (!(m is CreationMethod)) {
				find_base_interface_method (m, (Class) current_symbol);
				if (m.is_virtual || m.overrides) {
					find_base_class_method (m, (Class) current_symbol);
					if (m.base_method == null) {
						Report.error (m.source_reference, "%s: no suitable method found to override".printf (m.get_full_name ()));
					}
				}
			}
		} else if (current_symbol is Struct) {
			if (m.is_abstract || m.is_virtual || m.overrides) {
				Report.error (m.source_reference, "A struct member `%s' cannot be marked as override, virtual, or abstract".printf (m.get_full_name ()));
				return;
			}
		}
	}

	private void find_base_class_method (Method! m, Class! cl) {
		var sym = cl.scope.lookup (m.name);
		if (sym is Method) {
			var base_method = (Method) sym;
			if (base_method.is_abstract || base_method.is_virtual) {
				if (!cl.source_reference.file.pkg && !m.equals (base_method)) {
					m.error = true;
					Report.error (m.source_reference, "Return type and/or parameters of overriding method `%s' do not match overridden method `%s'.".printf (m.get_full_name (), base_method.get_full_name ()));
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

	private void find_base_interface_method (Method! m, Class! cl) {
		// FIXME report error if multiple possible base methods are found
		foreach (TypeReference type in cl.get_base_types ()) {
			if (type.data_type is Interface) {
				var sym = type.data_type.scope.lookup (m.name);
				if (sym is Method) {
					var base_method = (Method) sym;
					if (base_method.is_abstract) {
						if (!cl.source_reference.file.pkg && !m.equals (base_method)) {
							m.error = true;
							Report.error (m.source_reference, "Return type and/or parameters of overriding method `%s' do not match overridden method `%s'.".printf (m.get_full_name (), base_method.get_full_name ()));
							return;
						}

						m.base_interface_method = base_method;
						return;
					}
				}
			}
		}
	}

	public override void visit_creation_method (CreationMethod! m) {
		m.return_type = new TypeReference ();
		m.return_type.data_type = (DataType) m.parent_symbol;
		m.return_type.transfers_ownership = true;

		if (current_symbol is Class) {
			// check for floating reference
			var cl = (Class) current_symbol;
			while (cl != null) {
				if (cl == initially_unowned_type) {
					m.return_type.floating_reference = true;
					break;
				}

				cl = cl.base_class;
			}
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

	public override void visit_formal_parameter (FormalParameter! p) {
		p.accept_children (this);

		if (!p.ellipsis) {
			if (p.type_reference.data_type != null) {
				/* is null if it references a type parameter */
				if (!p.is_internal_symbol ()) {
					current_source_file.add_symbol_dependency (p.type_reference.data_type, SourceFileDependencyType.HEADER_SHALLOW);
				}
				current_source_file.add_symbol_dependency (p.type_reference.data_type, SourceFileDependencyType.SOURCE);
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

			method_body.add_statement (new ExpressionStatement (new Assignment (left, right), p.source_reference));
		}
	}

	private void find_base_class_property (Property! prop, Class! cl) {
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

	private void find_base_interface_property (Property! prop, Class! cl) {
		// FIXME report error if multiple possible base properties are found
		foreach (TypeReference type in cl.get_base_types ()) {
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

	public override void visit_property (Property! prop) {
		current_symbol = prop;

		prop.accept_children (this);

		current_symbol = current_symbol.parent_symbol;

		if (prop.type_reference.data_type != null) {
			/* is null if it references a type parameter */
			if (!prop.is_internal_symbol ()) {
				current_source_file.add_symbol_dependency (prop.type_reference.data_type, SourceFileDependencyType.HEADER_SHALLOW);
			}
			current_source_file.add_symbol_dependency (prop.type_reference.data_type, SourceFileDependencyType.SOURCE);
		}

		if (prop.parent_symbol is Class) {
			var cl = (Class) prop.parent_symbol;
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

	public override void visit_property_accessor (PropertyAccessor! acc) {
		acc.prop = (Property) current_symbol;

		if (acc.readable) {
			current_return_type = acc.prop.type_reference;
		} else {
			// void
			current_return_type = new TypeReference ();
		}

		if (!acc.source_reference.file.pkg) {
			if (acc.body == null && !acc.prop.interface_only && !acc.prop.is_abstract) {
				/* no accessor body specified, insert default body */
			
				acc.body = new Block ();
				if (acc.readable) {
					acc.body.add_statement (new ReturnStatement (new MemberAccess.simple ("_%s".printf (acc.prop.name)), acc.source_reference));
				} else {
					acc.body.add_statement (new ExpressionStatement (new Assignment (new MemberAccess.simple ("_%s".printf (acc.prop.name)), new MemberAccess.simple ("value")), acc.source_reference));
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

	public override void visit_signal (Signal! sig) {
		sig.accept_children (this);
	}

	public override void visit_constructor (Constructor! c) {
		c.this_parameter = new FormalParameter ("this", new TypeReference ());
		c.this_parameter.type_reference.data_type = (DataType) current_symbol;
		c.scope.add (c.this_parameter.name, c.this_parameter);

		c.owner = current_symbol.scope;
		current_symbol = c;

		c.accept_children (this);

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_destructor (Destructor! d) {
		d.owner = current_symbol.scope;
		current_symbol = d;

		d.accept_children (this);

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_named_argument (NamedArgument! n) {
	}

	public override void visit_begin_block (Block! b) {
		b.owner = current_symbol.scope;
		current_symbol = b;
	}

	public override void visit_end_block (Block! b) {
		foreach (VariableDeclarator decl in b.get_local_variables ()) {
			decl.active = false;
		}

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_variable_declarator (VariableDeclarator! decl) {
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
				if (!(decl.initializer is MemberAccess)) {
					decl.error = true;
					Report.error (decl.source_reference, "expression type not allowed as initializer");
					return;
				}

				if (decl.initializer.symbol_reference is Method &&
				    decl.type_reference.data_type is Callback) {
					var m = (Method) decl.initializer.symbol_reference;
					var cb = (Callback) decl.type_reference.data_type;

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

			if (memory_management) {
				if (decl.initializer.static_type.transfers_ownership) {
					/* rhs transfers ownership of the expression */
					if (!decl.type_reference.takes_ownership) {
						/* lhs doesn't own the value */
						decl.error = true;
						Report.error (decl.source_reference, "Invalid assignment from owned expression to unowned variable");
						return;
					}
				}
			}
		}

		if (decl.type_reference.data_type != null) {
			current_source_file.add_symbol_dependency (decl.type_reference.data_type, SourceFileDependencyType.SOURCE);
		}

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
	public override void visit_initializer_list (InitializerList! list) {
		if (list.expected_type != null && list.expected_type.data_type is Array) {
			/* initializer is used as array initializer */
			Array edt = (Array)list.expected_type.data_type;
			var inits = list.get_initializers ();
			int rank = ((Array)list.expected_type.data_type).rank;
			var child_type = list.expected_type.copy ();

			if (rank > 1) {
				child_type.data_type = edt.element_type.get_array (rank - 1);
			} else {
				child_type.data_type = edt.element_type;
			}

			foreach (Expression e in inits) {
				e.expected_type = child_type.copy ();
			}
		}

		list.accept_children (this);

		if (list.expected_type != null && list.expected_type.data_type is Array) {
			Array edt = (Array)list.expected_type.data_type;
			var inits = list.get_initializers ();
			int rank = edt.rank;
			var child_type = list.expected_type.copy ();
			bool error = false;

			if (rank > 1) {
				child_type.data_type = edt.element_type.get_array (rank - 1);
				foreach (Expression e in inits) {
					if (e.static_type == null) {
						error = true;
						continue;
					}
					if (!(e is InitializerList)) {
						error = true;
						e.error = true;
						Report.error (e.source_reference, "Initializer list expected");
						continue;
					}
					if (!e.static_type.equals (child_type)) {
						error = true;
						e.error = true;
						Report.error (e.source_reference, "Expected initializer list of type `%s' but got `%s'".printf (child_type.data_type.name, e.static_type.data_type.name));
					}
				}
			} else {
				child_type.data_type = edt.element_type;
				foreach (Expression e in inits) {
					if (e.static_type == null) {
						error = true;
						continue;
					}
					if (!is_type_compatible (e.static_type, child_type)) {
						error = true;
						e.error = true;
						Report.error (e.source_reference, "Expected initializer of type `%s' but got `%s'".printf (child_type.data_type.name, e.static_type.data_type.name));
					}
				}
			}

			if (!error) {
				/* everything seems to be correct */
				list.static_type = list.expected_type;
			}
		}
	}

	public override void visit_expression_statement (ExpressionStatement! stmt) {
		if (stmt.expression.error) {
			// ignore inner error
			stmt.error = true;
			return;
		}

		if (stmt.expression.static_type != null &&
		    stmt.expression.static_type.transfers_ownership) {
			Report.warning (stmt.source_reference, "Short-living reference");
		}

		stmt.tree_can_fail = stmt.expression.tree_can_fail;
	}

	public override void visit_if_statement (IfStatement! stmt) {
		if (stmt.condition.error) {
			/* if there was an error in the condition, skip this check */
			stmt.error = true;
			return;
		}

		if (stmt.condition.static_type.data_type != bool_type.data_type) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}
	}

	public override void visit_while_statement (WhileStatement! stmt) {
		if (stmt.condition.error) {
			/* if there was an error in the condition, skip this check */
			stmt.error = true;
			return;
		}

		if (stmt.condition.static_type.data_type != bool_type.data_type) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}
	}

	public override void visit_for_statement (ForStatement! stmt) {
		if (stmt.condition.error) {
			/* if there was an error in the condition, skip this check */
			stmt.error = true;
			return;
		}

		if (stmt.condition.static_type.data_type != bool_type.data_type) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}
	}

	public override void visit_begin_foreach_statement (ForeachStatement! stmt) {
		if (stmt.type_reference.data_type != null) {
			current_source_file.add_symbol_dependency (stmt.type_reference.data_type, SourceFileDependencyType.SOURCE);
		}

		stmt.variable_declarator = new VariableDeclarator (stmt.variable_name);
		stmt.variable_declarator.type_reference = stmt.type_reference;

		stmt.body.scope.add (stmt.variable_name, stmt.variable_declarator);

		stmt.body.add_local_variable (stmt.variable_declarator);
		stmt.variable_declarator.active = true;
	}

	public override void visit_end_foreach_statement (ForeachStatement! stmt) {
		if (stmt.collection.error) {
			// ignore inner error
			stmt.error = true;
			return;
		}

		stmt.collection_variable_declarator = new VariableDeclarator ("%s_collection".printf (stmt.variable_name));
		stmt.collection_variable_declarator.type_reference = stmt.collection.static_type.copy ();
		stmt.collection_variable_declarator.type_reference.transfers_ownership = false;
		stmt.collection_variable_declarator.type_reference.takes_ownership = stmt.collection.static_type.transfers_ownership;

		stmt.add_local_variable (stmt.collection_variable_declarator);
		stmt.collection_variable_declarator.active = true;

		var collection_type = stmt.collection.static_type.data_type;
		if (iterable_type != null && collection_type.is_subtype_of (iterable_type)) {
			stmt.iterator_variable_declarator = new VariableDeclarator ("%s_it".printf (stmt.variable_name));
			stmt.iterator_variable_declarator.type_reference = new TypeReference ();
			stmt.iterator_variable_declarator.type_reference.data_type = iterator_type;
			stmt.iterator_variable_declarator.type_reference.takes_ownership = true;
			stmt.iterator_variable_declarator.type_reference.add_type_argument (stmt.type_reference);

			stmt.add_local_variable (stmt.iterator_variable_declarator);
			stmt.iterator_variable_declarator.active = true;
		} else if (!(collection_type is Array || collection_type == glist_type || collection_type == gslist_type)) {
			stmt.error = true;
			Report.error (stmt.source_reference, "Collection not iterable");
			return;
		}

		stmt.tree_can_fail = stmt.collection.tree_can_fail || stmt.body.tree_can_fail;
	}

	public override void visit_end_return_statement (ReturnStatement! stmt) {
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

		if (stmt.return_expression == null && current_return_type.data_type != null) {
			stmt.error = true;
			Report.error (stmt.source_reference, "Return without value in non-void function");
			return;
		}

		if (stmt.return_expression != null &&
		    current_return_type.data_type == null &&
		    current_return_type.type_parameter == null) {
			Report.error (stmt.source_reference, "Return with value in void function");
			return;
		}

		if (stmt.return_expression != null &&
		     !is_type_compatible (stmt.return_expression.static_type, current_return_type)) {
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
	}

	public override void visit_throw_statement (ThrowStatement! stmt) {
		stmt.accept_children (this);
	}

	public override void visit_try_statement (TryStatement! stmt) {
		stmt.accept_children (this);
	}

	public override void visit_catch_clause (CatchClause! clause) {
		if (clause.type_reference.data_type != null) {
			current_source_file.add_symbol_dependency (clause.type_reference.data_type, SourceFileDependencyType.SOURCE);
		}

		clause.variable_declarator = new VariableDeclarator (clause.variable_name);
		clause.variable_declarator.type_reference = new TypeReference ();
		clause.variable_declarator.type_reference.data_type = gerror_type;

		clause.body.scope.add (clause.variable_name, clause.variable_declarator);

		clause.accept_children (this);
	}

	/**
	 * Visit operation called for lock statements.
	 *
	 * @param stmt a lock statement
	 */
	public override void visit_lock_statement (LockStatement! stmt) {
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

	private int create_sizes_from_initializer_list (InitializerList! il, int rank, Gee.List<LiteralExpression>! sl) {
		var init = new LiteralExpression (new IntegerLiteral (il.size.to_string (), il.source_reference), il.source_reference);
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
	public override void visit_array_creation_expression (ArrayCreationExpression! expr) {
		Collection<Expression> size = expr.get_sizes ();
		var initlist = expr.initializer_list;

		if (expr.element_type != null) {
			expr.element_type.accept (this);
		}

		foreach (Expression e in size) {
			e.accept (this);
		}

		var calc_sizes = new ArrayList<LiteralExpression> ();
		if (initlist != null) {
			initlist.expected_type = expr.element_type.copy ();
			initlist.expected_type.data_type = initlist.expected_type.data_type.get_array (expr.rank);
			// FIXME: add element type to type_argument

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

		expr.static_type = expr.element_type.copy ();
		if (expr.element_type.data_type != null) {
			expr.static_type.data_type = expr.element_type.data_type.get_array (expr.rank);
		} else {
			expr.static_type.data_type = expr.element_type.type_parameter.get_array (expr.rank);
		}
		expr.static_type.transfers_ownership = true;
		expr.static_type.takes_ownership = true;

		expr.static_type.add_type_argument (expr.element_type);
	}

	public override void visit_boolean_literal (BooleanLiteral! expr) {
		expr.static_type = bool_type;
	}

	public override void visit_character_literal (CharacterLiteral! expr) {
		expr.static_type = new TypeReference ();
		expr.static_type.data_type = (DataType) root_symbol.scope.lookup ("char");
	}

	public override void visit_integer_literal (IntegerLiteral! expr) {
		expr.static_type = new TypeReference ();
		expr.static_type.data_type = (DataType) root_symbol.scope.lookup (expr.get_type_name ());
	}

	public override void visit_real_literal (RealLiteral! expr) {
		expr.static_type = new TypeReference ();
		expr.static_type.data_type = (DataType) root_symbol.scope.lookup (expr.get_type_name ());
	}

	public override void visit_string_literal (StringLiteral! expr) {
		expr.static_type = string_type.copy ();
		expr.static_type.non_null = true;
	}

	public override void visit_null_literal (NullLiteral! expr) {
		/* empty TypeReference represents null */

		expr.static_type = new TypeReference ();
	}

	public override void visit_literal_expression (LiteralExpression! expr) {
		expr.static_type = expr.literal.static_type;
	}

	private TypeReference get_static_type_for_symbol (Symbol! sym) {
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
			return p.type_reference;
		} else if (sym is TypeReference) {
			return (TypeReference) sym;
		} else if (sym is VariableDeclarator) {
			var decl = (VariableDeclarator) sym;
			return decl.type_reference;
		} else if (sym is EnumValue) {
			var type = new TypeReference ();
			type.data_type = (DataType) sym.parent_symbol;
			return type;
		}
		return null;
	}

	public static Symbol symbol_lookup_inherited (Symbol! sym, string! name) {
		var result = sym.scope.lookup (name);
		if (result != null) {
			return result;
		}

		if (sym is Class) {
			var cl = (Class) sym;
			foreach (TypeReference base_type in cl.get_base_types ()) {
				result = symbol_lookup_inherited (base_type.data_type, name);
				if (result != null) {
					return result;
				}
			}
		} else if (sym is Struct) {
			var st = (Struct) sym;
			foreach (TypeReference base_type in st.get_base_types ()) {
				result = symbol_lookup_inherited (base_type.data_type, name);
				if (result != null) {
					return result;
				}
			}
		} else if (sym is Interface) {
			var iface = (Interface) sym;
			foreach (TypeReference prerequisite in iface.get_prerequisites ()) {
				result = symbol_lookup_inherited (prerequisite.data_type, name);
				if (result != null) {
					return result;
				}
			}
		}

		return null;
	}

	public override void visit_parenthesized_expression (ParenthesizedExpression! expr) {
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

	public override void visit_member_access (MemberAccess! expr) {
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
				if (base_symbol is Namespace || base_symbol is DataType) {
					expr.symbol_reference = base_symbol.scope.lookup (expr.member_name);
					if (expr.inner is BaseAccess) {
						// inner expression is base access
						// access to instance members of the base type possible
						may_access_instance_members = true;
					}
				}
			}

			if (expr.symbol_reference == null && expr.inner.static_type != null) {
				base_symbol = expr.inner.static_type.data_type;
				expr.symbol_reference = symbol_lookup_inherited (base_symbol, expr.member_name);
				if (expr.symbol_reference != null) {
					// inner expression is variable, field, or parameter
					// access to instance members of the corresponding type possible
					may_access_instance_members = true;
				}
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
				Report.error (expr.source_reference, "The name `%s' does not exist in the context of `%s'".printf (expr.member_name, base_symbol.get_full_name ()));
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
		} else if (member is Property || member is Signal) {
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
			// no static type for prototype access
		} else {
			expr.static_type = get_static_type_for_symbol (expr.symbol_reference);
		}

		current_source_file.add_symbol_dependency (expr.symbol_reference, SourceFileDependencyType.SOURCE);
	}

	private bool is_type_compatible (TypeReference! expression_type, TypeReference! expected_type) {
		/* only null is compatible to null */
		if (expected_type.data_type == null && expected_type.type_parameter == null) {
			return (expression_type.data_type == null && expected_type.type_parameter == null);
		}

		if (expression_type.data_type == null) {
			/* null can be cast to any reference or array type or pointer type */
			if (expected_type.type_parameter != null ||
			    expected_type.data_type.is_reference_type () ||
			    expected_type.is_out ||
			    expected_type.data_type is Pointer ||
			    expected_type.data_type is Array ||
			    expected_type.data_type is Callback ||
			    expected_type.data_type == pointer_type) {
				return true;
			}

			/* null is not compatible with any other type (i.e. value types) */
			return false;
		}

		if (expected_type.data_type == pointer_type) {
			/* any reference or array type or pointer type can be cast to a generic pointer */
			if (expression_type.type_parameter != null ||
			    expression_type.data_type.is_reference_type () ||
			    expression_type.data_type is Pointer ||
			    expression_type.data_type is Array ||
			    expression_type.data_type is Callback ||
			    expression_type.data_type == pointer_type) {
				return true;
			}

			return false;
		}

		/* temporarily ignore type parameters */
		if (expected_type.type_parameter != null) {
			return true;
		}

		if (expression_type.data_type is Array != expected_type.data_type is Array) {
			return false;
		}

		if (expression_type.data_type is Enum && expected_type.data_type == int_type.data_type) {
			return true;
		}

		if (expression_type.data_type == expected_type.data_type) {
			return true;
		}

		if (expression_type.data_type is Struct && expected_type.data_type is Struct) {
			var expr_struct = (Struct) expression_type.data_type;
			var expect_struct = (Struct) expected_type.data_type;

			/* integer types may be implicitly cast to floating point types */
			if (expr_struct.is_integer_type () && expect_struct.is_floating_type ()) {
				return true;
			}

			if ((expr_struct.is_integer_type () && expect_struct.is_integer_type ()) ||
			    (expr_struct.is_floating_type () && expect_struct.is_floating_type ())) {
				if (expr_struct.get_rank () <= expect_struct.get_rank ()) {
					return true;
				}
			}
		}

		return expression_type.data_type.is_subtype_of (expected_type.data_type);
	}

	public override void visit_begin_invocation_expression (InvocationExpression! expr) {
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

		var msym = expr.call.symbol_reference;

		if (msym == null) {
			/* if no symbol found, skip this check */
			expr.error = true;
			return;
		}

		Collection<FormalParameter> params;

		if (msym is Invokable) {
			var m = (Invokable) msym;
			if (m.is_invokable ()) {
				params = m.get_parameters ();
			} else {
				expr.error = true;
				Report.error (expr.source_reference, "invocation not supported in this context");
				return;
			}
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
	}

	private bool check_arguments (Expression! expr, Symbol! msym, Collection<FormalParameter> params, Collection<Expression> args) {
		Expression prev_arg = null;
		Iterator<Expression> arg_it = args.iterator ();

		bool diag = (msym.get_attribute ("Diagnostics") != null);

		bool ellipsis = false;
		int i = 0;
		foreach (FormalParameter param in params) {
			if (param.ellipsis) {
				ellipsis = true;
				break;
			}

			/* header file necessary if we need to cast argument */
			if (param.type_reference.data_type != null) {
				current_source_file.add_symbol_dependency (param.type_reference.data_type, SourceFileDependencyType.SOURCE);
			}

			if (!arg_it.next ()) {
				if (param.default_expression == null) {
					expr.error = true;
					Report.error (expr.source_reference, "Too few arguments, method `%s' does not take %d arguments".printf (msym.get_full_name (), args.size));
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
					if (!(param.type_reference.data_type is Callback) || !(arg.symbol_reference is Method)) {
						expr.error = true;
						Report.error (expr.source_reference, "Invalid type for argument %d".printf (i + 1));
						return false;
					}
				} else if (!is_type_compatible (arg.static_type, param.type_reference)) {
					expr.error = true;
					Report.error (expr.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.static_type.to_string (), param.type_reference.to_string ()));
					return false;
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
			Report.error (expr.source_reference, "Too many arguments, method `%s' does not take %d arguments".printf (msym.get_full_name (), args.size));
			return false;
		}

		if (diag && prev_arg != null) {
			var format_arg = prev_arg;
			if (format_arg is LiteralExpression) {
				var format_lit = (StringLiteral) ((LiteralExpression) format_arg).literal;
				format_lit.value = "\"%s:%d: %s".printf (expr.source_reference.file.filename, expr.source_reference.first_line, format_lit.value.offset (1));
			}
		}

		return true;
	}

	public override void visit_end_invocation_expression (InvocationExpression! expr) {
		if (expr.error) {
			return;
		}

		var msym = expr.call.symbol_reference;

		TypeReference ret_type;
		Collection<FormalParameter> params;

		if (msym is Invokable) {
			var m = (Invokable) msym;
			ret_type = m.get_return_type ();
			params = m.get_parameters ();

			if (ret_type.data_type == null && ret_type.type_parameter == null) {
				// void return type
				if (!(expr.parent_node is ExpressionStatement)) {
					expr.error = true;
					Report.error (expr.source_reference, "invocation of void method not allowed as expression");
					return;
				}
			}

			// resolve generic return values
			if (ret_type.type_parameter != null) {
				if (!(expr.call is MemberAccess)) {
					Report.error (((CodeNode) m).source_reference, "internal error: unsupported generic return value");
					expr.error = true;
					return;
				}
				var ma = (MemberAccess) expr.call;
				if (ma.inner == null) {
					// TODO resolve generic return values within the type hierarchy if possible
					Report.error (expr.source_reference, "internal error: resolving generic return values within type hierarchy not supported yet");
					expr.error = true;
					return;
				} else {
					ret_type = get_actual_type (ma.inner.static_type, msym, ret_type, expr);
					if (ret_type == null) {
						return;
					}
				}
			}
		}

		if (msym is Method) {
			var m = (Method) msym;
			expr.tree_can_fail = expr.can_fail = (m.get_error_domains ().size > 0);
		}

		expr.static_type = ret_type;

		check_arguments (expr, msym, params, expr.get_argument_list ());
	}

	public static TypeReference get_actual_type (TypeReference derived_instance_type, Symbol generic_member, TypeReference generic_type, CodeNode node_reference) {
		TypeReference instance_type = derived_instance_type;
		// trace type arguments back to the datatype where the method has been declared
		while (instance_type.data_type != generic_member.parent_symbol) {
			Collection<TypeReference> base_types = null;
			if (instance_type.data_type is Class) {
				var cl = (Class) instance_type.data_type;
				base_types = cl.get_base_types ();
			} else if (instance_type.data_type is Interface) {
				var iface = (Interface) instance_type.data_type;
				base_types = iface.get_prerequisites ();
			} else {
				Report.error (node_reference.source_reference, "internal error: unsupported generic type");
				node_reference.error = true;
				return null;
			}
			foreach (TypeReference base_type in base_types) {
				if (SemanticAnalyzer.symbol_lookup_inherited (base_type.data_type, generic_member.name) != null) {
					// construct a new type reference for the base type with correctly linked type arguments
					var instance_base_type = new TypeReference ();
					instance_base_type.data_type = base_type.data_type;
					foreach (TypeReference type_arg in base_type.get_type_arguments ()) {
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
					instance_type = instance_base_type;
				}
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

		TypeReference actual_type = null;
		if (param_index < instance_type.get_type_arguments ().size) {
			actual_type = (TypeReference) instance_type.get_type_arguments ().get (param_index);
		}
		if (actual_type == null) {
			Report.error (node_reference.source_reference, "internal error: no actual argument found for type parameter %s".printf (generic_type.type_parameter.name));
			node_reference.error = true;
			return null;
		}
		actual_type = actual_type.copy ();
		actual_type.transfers_ownership = actual_type.takes_ownership && generic_type.transfers_ownership;
		actual_type.takes_ownership = actual_type.takes_ownership && generic_type.takes_ownership;
		return actual_type;
	}

	public override void visit_element_access (ElementAccess! expr) {
		if (expr.container.static_type == null) {
			/* don't proceed if a child expression failed */
			expr.error = true;
			return;
		}

		var container_type = expr.container.static_type.data_type;

		bool index_int_type_check = true;

		/* assign a static_type when possible */
		if (container_type is Array) {
			var args = expr.container.static_type.get_type_arguments ();

			if (args.size != 1) {
				expr.error = true;
				Report.error (expr.source_reference, "internal error: array reference with %d type arguments, expected 1".printf (args.size));
				return;
			}

			expr.static_type = args.get (0);
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

			if (!is_type_compatible (index.static_type, index_type)) {
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

	public override void visit_base_access (BaseAccess! expr) {
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
			Iterator<TypeReference> base_type_it = current_struct.get_base_types ().iterator ();
			base_type_it.next ();
			expr.static_type = base_type_it.get ();
		} else {
			expr.static_type = new TypeReference ();
			expr.static_type.data_type = current_class.base_class;
		}

		expr.symbol_reference = expr.static_type.data_type;
	}

	public override void visit_postfix_expression (PostfixExpression! expr) {
		expr.static_type = expr.inner.static_type;
	}

	public override void visit_end_object_creation_expression (ObjectCreationExpression! expr) {
		DataType type = null;

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
			} else if (constructor_sym is EnumValue) {
				type_sym = constructor_sym.parent_symbol;

				expr.symbol_reference = constructor_sym;
			}

			if (type_sym is Class || type_sym is Struct) {
				type = (DataType) type_sym;
			} else if (type_sym is Enum && ((Enum) type_sym).error_domain) {
				type = (DataType) type_sym;
			} else {
				expr.error = true;
				Report.error (expr.source_reference, "`%s' is not a class, struct, or error domain".printf (type_sym.get_full_name ()));
				return;
			}

			expr.type_reference = new TypeReference ();
			expr.type_reference.data_type = type;
			foreach (TypeReference type_arg in type_args) {
				expr.type_reference.add_type_argument (type_arg);
			}
		} else {
			type = expr.type_reference.data_type;
		}

		if (!type.is_reference_type () && !(type is Enum)) {
			expr.error = true;
			Report.error (expr.source_reference, "Can't create instance of value type `%s'".printf (expr.type_reference.to_string ()));
			return;
		}

		current_source_file.add_symbol_dependency (type, SourceFileDependencyType.SOURCE);

		expr.static_type = expr.type_reference.copy ();
		expr.static_type.transfers_ownership = true;

		if (type is Class) {
			var cl = (Class) type;

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
			check_arguments (expr, m, m.get_parameters (), expr.get_argument_list ());

			expr.tree_can_fail = expr.can_fail = (m.get_error_domains ().size > 0);
		} else if (type is Enum) {
			if (expr.get_argument_list ().size == 0) {
				expr.error = true;
				Report.error (expr.source_reference, "Too few arguments, errors need at least 1 argument");
			} else {
				Iterator<Expression> arg_it = expr.get_argument_list ().iterator ();
				arg_it.next ();
				var ex = arg_it.get ();
				if (ex.static_type == null || !is_type_compatible (ex.static_type, string_type)) {
					expr.error = true;
					Report.error (expr.source_reference, "Invalid type for argument 1");
				}
			}
			expr.static_type = new TypeReference ();
		}
	}

	public override void visit_sizeof_expression (SizeofExpression! expr) {
		expr.static_type = ulong_type;
	}

	public override void visit_typeof_expression (TypeofExpression! expr) {
		expr.static_type = type_type;
	}

	private bool is_numeric_type (TypeReference! type) {
		if (!(type.data_type is Struct)) {
			return false;
		}

		var st = (Struct) type.data_type;
		return st.is_integer_type () || st.is_floating_type ();
	}

	private bool is_integer_type (TypeReference! type) {
		if (!(type.data_type is Struct)) {
			return false;
		}

		var st = (Struct) type.data_type;
		return st.is_integer_type ();
	}

	public override void visit_unary_expression (UnaryExpression! expr) {
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
			if (expr.inner.static_type.data_type != bool_type.data_type) {
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
			var bin = new BinaryExpression (expr.operator == UnaryOperator.INCREMENT ? BinaryOperator.PLUS : BinaryOperator.MINUS, old_value, new LiteralExpression (new IntegerLiteral ("1")), expr.source_reference);

			var assignment = new Assignment (ma, bin, AssignmentOperator.SIMPLE, expr.source_reference);
			var parenthexp = new ParenthesizedExpression (assignment, expr.source_reference);
			expr.parent_node.replace (expr, parenthexp);
			parenthexp.accept (this);
			return;
		} else if (expr.operator == UnaryOperator.REF) {
			// value type

			expr.static_type = expr.inner.static_type;
		} else if (expr.operator == UnaryOperator.OUT) {
			// reference type

			expr.static_type = expr.inner.static_type;
		} else {
			expr.error = true;
			Report.error (expr.source_reference, "internal error: unsupported unary operator");
			return;
		}
	}

	private MemberAccess find_member_access (Expression! expr) {
		if (expr is ParenthesizedExpression) {
			var pe = (ParenthesizedExpression) expr;
			return find_member_access (pe.inner);
		}

		if (expr is MemberAccess) {
			return (MemberAccess) expr;
		}

		return null;
	}

	public override void visit_cast_expression (CastExpression! expr) {
		if (expr.type_reference.data_type == null && expr.type_reference.type_parameter == null) {
			/* if type resolving didn't succeed, skip this check */
			return;
		}
		if (expr.inner.error) {
			return;
		}

		// FIXME: check whether cast is allowed

		if (expr.type_reference.data_type != null) {
			current_source_file.add_symbol_dependency (expr.type_reference.data_type, SourceFileDependencyType.SOURCE);
		}

		expr.static_type = expr.type_reference;
		expr.static_type.transfers_ownership = expr.inner.static_type.transfers_ownership;
	}

	public override void visit_pointer_indirection (PointerIndirection! expr) {
		if (expr.inner.error) {
			return;
		}
		if (expr.inner.static_type == null) {
			expr.error = true;
			Report.error (expr.source_reference, "internal error: unknown type of inner expression");
			return;
		}
		if (!(expr.inner.static_type.data_type is Pointer)) {
			expr.error = true;
			Report.error (expr.source_reference, "Pointer indirection not supported for this expression");
			return;
		}

		var pointer = (Pointer) expr.inner.static_type.data_type;

		expr.static_type = new TypeReference ();
		expr.static_type.data_type = pointer.referent_type;
		expr.static_type.takes_ownership = expr.inner.static_type.takes_ownership;
	}

	public override void visit_addressof_expression (AddressofExpression! expr) {
		if (expr.inner.error) {
			return;
		}
		if (expr.inner.static_type == null) {
			expr.error = true;
			Report.error (expr.source_reference, "internal error: unknown type of inner expression");
			return;
		}
		if (expr.inner.static_type.data_type == null) {
			expr.error = true;
			Report.error (expr.source_reference, "Address-of operator not supported for this expression");
			return;
		}

		expr.static_type = new TypeReference ();
		expr.static_type.data_type = expr.inner.static_type.data_type.get_pointer ();
		expr.static_type.takes_ownership = expr.inner.static_type.takes_ownership;
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression! expr) {
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

		if (!expr.inner.static_type.takes_ownership) {
			expr.error = true;
			Report.error (expr.source_reference, "No reference to be transferred");
			return;
		}

		expr.static_type = expr.inner.static_type.copy ();
		expr.static_type.transfers_ownership = true;
		expr.static_type.takes_ownership = false;
	}

	private TypeReference get_arithmetic_result_type (TypeReference! left_type, TypeReference! right_type) {
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

	public override void visit_binary_expression (BinaryExpression! expr) {
		if (expr.left.error || expr.right.error) {
			/* if there were any errors in inner expressions, skip type check */
			expr.error = true;
			return;
		}

		if (expr.left.static_type.data_type == string_type.data_type
		    && expr.operator == BinaryOperator.PLUS) {
			if (expr.right.static_type.data_type != string_type.data_type) {
				expr.error = true;
				Report.error (expr.source_reference, "Operands must be strings");
				return;
			}

			/* string concatenation: convert to a.concat (b) */

			var concat_call = new InvocationExpression (new MemberAccess (expr.left, "concat"));
			concat_call.add_argument (expr.right);

			expr.parent_node.replace (expr, concat_call);

			concat_call.accept (this);
		} else if (expr.operator == BinaryOperator.PLUS
			   || expr.operator == BinaryOperator.MINUS
			   || expr.operator == BinaryOperator.MUL
			   || expr.operator == BinaryOperator.DIV) {
			expr.static_type = get_arithmetic_result_type (expr.left.static_type, expr.right.static_type);

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
			if (expr.left.static_type.data_type == string_type.data_type
			    && expr.right.static_type.data_type == string_type.data_type) {
				/* string comparison: convert to a.collate (b) OP 0 */

				var cmp_call = new InvocationExpression (new MemberAccess (expr.left, "collate"));
				cmp_call.add_argument (expr.right);
				expr.left = cmp_call;

				expr.right = new LiteralExpression (new IntegerLiteral ("0"));

				expr.left.accept (this);
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

			if (!is_type_compatible (expr.right.static_type, expr.left.static_type)
			    && !is_type_compatible (expr.left.static_type, expr.right.static_type)) {
				Report.error (expr.source_reference, "Equality operation: `%s' and `%s' are incompatible, comparison would always evaluate to false".printf (expr.right.static_type.to_string (), expr.left.static_type.to_string ()));
				expr.error = true;
				return;
			}

			if (expr.left.static_type.data_type == string_type.data_type
			    && expr.right.static_type.data_type == string_type.data_type) {
				/* string comparison: convert to a.collate (b) OP 0 */

				var cmp_call = new InvocationExpression (new MemberAccess (expr.left, "collate"));
				cmp_call.add_argument (expr.right);
				expr.left = cmp_call;

				expr.right = new LiteralExpression (new IntegerLiteral ("0"));

				expr.left.accept (this);
			}

			expr.static_type = bool_type;
		} else if (expr.operator == BinaryOperator.BITWISE_AND
			   || expr.operator == BinaryOperator.BITWISE_OR) {
			// integer type or flags type

			expr.static_type = expr.left.static_type;
		} else if (expr.operator == BinaryOperator.AND
			   || expr.operator == BinaryOperator.OR) {
			if (expr.left.static_type.data_type != bool_type.data_type || expr.right.static_type.data_type != bool_type.data_type) {
				expr.error = true;
				Report.error (expr.source_reference, "Operands must be boolean");
			}

			expr.static_type = bool_type;
		} else {
			assert_not_reached ();
		}
	}

	public override void visit_type_check (TypeCheck! expr) {
		if (expr.type_reference.data_type == null) {
			/* if type resolving didn't succeed, skip this check */
			expr.error = true;
			return;
		}

		current_source_file.add_symbol_dependency (expr.type_reference.data_type, SourceFileDependencyType.SOURCE);

		expr.static_type = bool_type;
	}

	private TypeReference compute_common_base_type (Collection<TypeReference> types) {
		bool null_found = false;
		bool class_or_iface_found = false;
		bool type_param_found = false;
		bool ref_struct_found = false;
		bool val_struct_found = false;
		bool enum_found = false;
		bool callback_found = false;
		TypeReference base_type = null;
		TypeReference last_type = null;
		foreach (TypeReference type in types) {
			last_type = type;
			if (type.error) {
				base_type = new TypeReference ();
				base_type.error = true;
				return base_type;
			}
			if (type.data_type == null && type.type_parameter == null) {
				if (!null_found) {
					null_found = true;
					if (val_struct_found || enum_found) {
						base_type.error = true;
						break;
					}
				}
			} else if (type.data_type is Class || type.data_type is Interface) {
				if (!class_or_iface_found) {
					class_or_iface_found = true;
					if (type_param_found || ref_struct_found || val_struct_found || enum_found || callback_found) {
						base_type.error = true;
						break;
					}
				}
			} else if (type.type_parameter != null) {
				if (!type_param_found) {
					type_param_found = true;
					if (class_or_iface_found || ref_struct_found || val_struct_found || enum_found || callback_found) {
						base_type.error = true;
						break;
					}
				}
			} else if (type.data_type is Struct) {
				var st = (Struct) type.data_type;
				if (st.is_reference_type ()) {
					if (!ref_struct_found) {
						ref_struct_found = true;
						if (class_or_iface_found || type_param_found || val_struct_found || enum_found || callback_found) {
							base_type.error = true;
							break;
						}
					}
				} else {
					if (!val_struct_found) {
						val_struct_found = true;
						if (class_or_iface_found || type_param_found || ref_struct_found || enum_found || callback_found) {
							base_type.error = true;
							break;
						}
					}
				}
			} else if (type.data_type is Enum) {
				if (!enum_found) {
					enum_found = true;
					if (class_or_iface_found || type_param_found || ref_struct_found || val_struct_found) {
						base_type.error = true;
						break;
					}
				}
			} else if (type.data_type is Callback) {
				if (!callback_found) {
					callback_found = true;
					if (class_or_iface_found || type_param_found || ref_struct_found || val_struct_found || enum_found) {
						base_type.error = true;
						break;
					}
				}
			} else {
				base_type = new TypeReference ();
				base_type.error = true;
				Report.error (type.source_reference, "internal error: unsupported type `%s'".printf (type.to_string ()));
				return base_type;
			}
			if (base_type == null) {
				base_type = new TypeReference ();
				base_type.data_type = type.data_type;
				base_type.type_parameter = type.type_parameter;
				base_type.non_null = type.non_null;
				base_type.is_null = type.is_null;
				base_type.transfers_ownership = type.transfers_ownership;
			} else {
				if (base_type.data_type != type.data_type) {
					if (is_type_compatible (type, base_type)) {
					} else if (is_type_compatible (base_type, type)) {
						base_type.data_type = type.data_type;
					} else {
						base_type.error = true;
						break;
					}
				}
				base_type.non_null = base_type.non_null && type.non_null;
				base_type.is_null = base_type.is_null && type.is_null;
				// if one subexpression transfers ownership, all subexpressions must transfer ownership
				// FIXME add ref calls to subexpressions that don't transfer ownership
				base_type.transfers_ownership = base_type.transfers_ownership || type.transfers_ownership;
			}
		}
		if (base_type != null && base_type.error) {
			Report.error (last_type.source_reference, "`%s' is incompatible with `%s'".printf (last_type.to_string (), base_type.to_string ()));
		}
		return base_type;
	}

	public override void visit_conditional_expression (ConditionalExpression! expr) {
		if (expr.condition.static_type.data_type != bool_type.data_type) {
			expr.error = true;
			Report.error (expr.condition.source_reference, "Condition must be boolean");
			return;
		}

		/* FIXME: support memory management */
		Gee.List<TypeReference> types = new ArrayList<TypeReference> ();
		types.add (expr.true_expression.static_type);
		types.add (expr.false_expression.static_type);
		expr.static_type = compute_common_base_type (types);
	}

	private string get_lambda_name () {
		var result = "__lambda%d".printf (next_lambda_id);

		next_lambda_id++;

		return result;
	}

	private Method find_current_method () {
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

	public override void visit_begin_lambda_expression (LambdaExpression! l) {
		if (l.expected_type == null || !(l.expected_type.data_type is Callback)) {
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

		var cb = (Callback) l.expected_type.data_type;
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
	}

	public override void visit_begin_assignment (Assignment! a) {
		if (a.left is MemberAccess) {
			var ma = (MemberAccess) a.left;

			if (ma.error || ma.symbol_reference == null) {
				a.error = true;
				/* if no symbol found, skip this check */
				return;
			}

			if (ma.symbol_reference is Signal) {
				var sig = (Signal) ma.symbol_reference;

				a.right.expected_type = new TypeReference ();
				a.right.expected_type.data_type = sig.get_callback ();
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
		}
	}

	public override void visit_end_assignment (Assignment! a) {
		if (a.error || a.left.error || a.right.error) {
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

				var m = (Method) a.right.symbol_reference;

				if (m.instance && m.access != SymbolAccessibility.PRIVATE) {
					/* TODO: generate wrapper function */

					ma.error = true;
					Report.error (a.right.source_reference, "public instance methods not yet supported as signal handlers");
					return;
				}

				if (m.instance) {
					/* instance signal handlers must have the self
					 * parameter at the end
					 * do not use G_CONNECT_SWAPPED as this would
					 * rearrange the parameters for instance
					 * methods and non-instance methods
					 */
					m.instance_last = true;
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

				var right_ma = (MemberAccess) a.right;
				if (right_ma.symbol_reference is Method &&
				    decl.type_reference.data_type is Callback) {
					var m = (Method) right_ma.symbol_reference;
					var cb = (Callback) decl.type_reference.data_type;

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

				var right_ma = (MemberAccess) a.right;
				if (right_ma.symbol_reference is Method &&
				    f.type_reference.data_type is Callback) {
					var m = (Method) right_ma.symbol_reference;
					var cb = (Callback) f.type_reference.data_type;

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
				if (!is_type_compatible (a.right.static_type, a.left.static_type)) {
					/* if there was an error on either side,
					 * i.e. a.{left|right}.static_type == null, skip type check */
					a.error = true;
					Report.error (a.source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (a.right.static_type.to_string (), a.left.static_type.to_string ()));
					return;
				}

				if (memory_management) {
					if (a.right.static_type.transfers_ownership) {
						/* rhs transfers ownership of the expression */
						if (!a.left.static_type.takes_ownership) {
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
			}
		} else if (a.left is ElementAccess) {
			var ea = (ElementAccess) a.left;

			if (!is_type_compatible (a.right.static_type, a.left.static_type)) {
				/* if there was an error on either side,
				 * i.e. a.{left|right}.static_type == null, skip type check */
				a.error = true;
				Report.error (a.source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (a.right.static_type.to_string (), a.left.static_type.to_string ()));
				return;
			}

			if (memory_management) {
				if (a.right.static_type.transfers_ownership) {
					/* rhs transfers ownership of the expression */

					var args = ea.container.static_type.get_type_arguments ();
					if (args.size != 1) {
						a.error = true;
						Report.error (ea.source_reference, "internal error: array reference without type arguments");
						return;
					}
					var element_type = args.get (0);

					if (!element_type.takes_ownership) {
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
	}
}
