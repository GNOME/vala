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
	public CodeContext context { get; set; }

	public Symbol root_symbol;
	public Symbol current_symbol { get; set; }
	public SourceFile current_source_file { get; set; }
	public DataType current_return_type;
	public Class current_class;
	public Struct current_struct;

	public Gee.List<UsingDirective> current_using_directives;

	public DataType bool_type;
	public DataType string_type;
	public DataType uchar_type;
	public DataType short_type;
	public DataType ushort_type;
	public DataType int_type;
	public DataType uint_type;
	public DataType long_type;
	public DataType ulong_type;
	public DataType size_t_type;
	public DataType ssize_t_type;
	public DataType int8_type;
	public DataType unichar_type;
	public DataType double_type;
	public DataType type_type;
	public Class object_type;
	public TypeSymbol initially_unowned_type;
	DataType glist_type;
	DataType gslist_type;
	Class gerror_type;
	DataType iterable_type;
	Interface iterator_type;
	Interface list_type;
	public Interface collection_type;
	public Interface map_type;

	private int next_lambda_id = 0;

	// keep replaced alive to make sure they remain valid
	// for the whole execution of CodeNode.accept
	public Gee.List<CodeNode> replaced_nodes = new ArrayList<CodeNode> ();

	public SemanticAnalyzer () {
	}

	/**
	 * Analyze and check code in the specified context.
	 *
	 * @param context a code context
	 */
	public void analyze (CodeContext context) {
		this.context = context;

		root_symbol = context.root;

		bool_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("bool"));
		string_type = new ObjectType ((Class) root_symbol.scope.lookup ("string"));

		uchar_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("uchar"));
		short_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("short"));
		ushort_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("ushort"));
		int_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("int"));
		uint_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("uint"));
		long_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("long"));
		ulong_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("ulong"));
		size_t_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("size_t"));
		ssize_t_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("ssize_t"));
		int8_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("int8"));
		unichar_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("unichar"));
		double_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("double"));

		// TODO: don't require GLib namespace in semantic analyzer
		var glib_ns = root_symbol.scope.lookup ("GLib");
		if (glib_ns != null) {
			object_type = (Class) glib_ns.scope.lookup ("Object");
			initially_unowned_type = (TypeSymbol) glib_ns.scope.lookup ("InitiallyUnowned");

			type_type = new ValueType ((TypeSymbol) glib_ns.scope.lookup ("Type"));

			glist_type = new ObjectType ((Class) glib_ns.scope.lookup ("List"));
			gslist_type = new ObjectType ((Class) glib_ns.scope.lookup ("SList"));

			gerror_type = (Class) glib_ns.scope.lookup ("Error");
		}

		var gee_ns = root_symbol.scope.lookup ("Gee");
		if (gee_ns != null) {
			iterable_type = new ObjectType ((Interface) gee_ns.scope.lookup ("Iterable"));
			iterator_type = (Interface) gee_ns.scope.lookup ("Iterator");
			list_type = (Interface) gee_ns.scope.lookup ("List");
			collection_type = (Interface) gee_ns.scope.lookup ("Collection");
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

	public override void visit_namespace (Namespace ns) {
		ns.process_attributes ();
	}

	public override void visit_class (Class cl) {
		cl.check (this);
	}

	public override void visit_struct (Struct st) {
		st.process_attributes ();

		current_symbol = st;
		current_struct = st;

		st.accept_children (this);

		if (!st.external && !st.external_package && st.get_base_types ().size == 0 && st.get_fields ().size == 0) {
			Report.error (st.source_reference, "structs cannot be empty");
		}

		current_symbol = current_symbol.parent_symbol;
		current_struct = null;
	}

	public override void visit_interface (Interface iface) {
		iface.process_attributes ();

		current_symbol = iface;

		foreach (DataType prerequisite_reference in iface.get_prerequisites ()) {
			// check whether prerequisite is at least as accessible as the interface
			if (!is_type_accessible (iface, prerequisite_reference)) {
				iface.error = true;
				Report.error (iface.source_reference, "prerequisite `%s` is less accessible than interface `%s`".printf (prerequisite_reference.to_string (), iface.get_full_name ()));
				return;
			}

			current_source_file.add_type_dependency (prerequisite_reference, SourceFileDependencyType.HEADER_FULL);
		}

		/* check prerequisites */
		Class prereq_class;
		foreach (DataType prereq in iface.get_prerequisites ()) {
			TypeSymbol class_or_interface = prereq.data_type;
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
		en.process_attributes ();

		en.accept_children (this);
	}

	public override void visit_enum_value (EnumValue ev) {
		ev.process_attributes ();

		ev.accept_children (this);
	}

	public override void visit_error_domain (ErrorDomain ed) {
		ed.process_attributes ();

		ed.accept_children (this);
	}

	public override void visit_delegate (Delegate d) {
		d.process_attributes ();

		d.accept_children (this);
	}

	public override void visit_constant (Constant c) {
		c.process_attributes ();

		c.type_reference.accept (this);

		if (!c.external_package) {
			if (c.initializer == null) {
				c.error = true;
				Report.error (c.source_reference, "A const field requires a initializer to be provided");
			} else {
				c.initializer.target_type = c.type_reference;

				c.initializer.accept (this);
			}
		}
	}

	public override void visit_field (Field f) {
		f.process_attributes ();

		if (f.initializer != null) {
			f.initializer.target_type = f.field_type;
		}

		f.accept_children (this);

		if (f.binding == MemberBinding.INSTANCE && f.parent_symbol is Interface) {
			f.error = true;
			Report.error (f.source_reference, "Interfaces may not have instance fields");
			return;
		}

		if (!f.is_internal_symbol ()) {
			if (f.field_type is ValueType) {
				current_source_file.add_type_dependency (f.field_type, SourceFileDependencyType.HEADER_FULL);
			} else {
				current_source_file.add_type_dependency (f.field_type, SourceFileDependencyType.HEADER_SHALLOW);
			}
		} else {
			if (f.parent_symbol is Namespace) {
				f.error = true;
				Report.error (f.source_reference, "Namespaces may not have private members");
				return;
			}

			current_source_file.add_type_dependency (f.field_type, SourceFileDependencyType.SOURCE);
		}
	}

	public override void visit_method (Method m) {
		m.process_attributes ();

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
			if (!(m.parent_symbol is Class) && !(m.parent_symbol is Interface)) {
				m.error = true;
				Report.error (m.source_reference, "Virtual methods may not be declared outside of classes and interfaces");
				return;
			}

			if (m.parent_symbol is Class) {
				var cl = (Class) m.parent_symbol;
				if (cl.is_compact) {
					Report.error (m.source_reference, "Virtual methods may not be declared in compact classes");
					return;
				}
			}
		} else if (m.overrides) {
			if (!(m.parent_symbol is Class)) {
				m.error = true;
				Report.error (m.source_reference, "Methods may not be overridden outside of classes");
				return;
			}
		}

		if (m.is_abstract && m.body != null) {
			Report.error (m.source_reference, "Abstract methods cannot have bodies");
		} else if (m.external && m.body != null) {
			Report.error (m.source_reference, "Extern methods cannot have bodies");
		} else if (!m.is_abstract && !m.external && !m.external_package && m.body == null) {
			Report.error (m.source_reference, "Non-abstract, non-extern methods must have bodies");
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
			if (m.return_type is ValueType) {
				current_source_file.add_type_dependency (m.return_type, SourceFileDependencyType.HEADER_FULL);
			} else {
				current_source_file.add_type_dependency (m.return_type, SourceFileDependencyType.HEADER_SHALLOW);
			}
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

		if (current_symbol is Struct) {
			if (m.is_abstract || m.is_virtual || m.overrides) {
				Report.error (m.source_reference, "A struct member `%s' cannot be marked as override, virtual, or abstract".printf (m.get_full_name ()));
				return;
			}
		} else if (m.overrides && m.base_method == null) {
			Report.error (m.source_reference, "%s: no suitable method found to override".printf (m.get_full_name ()));
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

			if (!precondition.value_type.compatible (bool_type)) {
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

			if (!postcondition.value_type.compatible (bool_type)) {
				m.error = true;
				Report.error (postcondition.source_reference, "Postcondition must be boolean");
				return;
			}
		}

		if (m.tree_can_fail && m.name == "main") {
			Report.error (m.source_reference, "\"main\" method cannot throw errors");
		}

		// check that all errors that can be thrown in the method body are declared
		if (m.body != null) { 
			foreach (DataType body_error_type in m.body.get_error_types ()) {
				bool can_propagate_error = false;
				foreach (DataType method_error_type in m.get_error_types ()) {
					if (body_error_type.compatible (method_error_type)) {
						can_propagate_error = true;
					}
				}
				if (!can_propagate_error) {
					Report.warning (body_error_type.source_reference, "unhandled error `%s'".printf (body_error_type.to_string()));
				}
			}
		}
	}

	public override void visit_creation_method (CreationMethod m) {
		m.process_attributes ();

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
		p.process_attributes ();

		p.check (this);
	}

	// check whether type is at least as accessible as the specified symbol
	public bool is_type_accessible (Symbol sym, DataType type) {
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

	public override void visit_property (Property prop) {
		prop.process_attributes ();

		prop.check (this);
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		acc.process_attributes ();

		var old_return_type = current_return_type;
		if (acc.readable) {
			current_return_type = acc.prop.property_type;
		} else {
			// void
			current_return_type = new VoidType ();
		}

		if (!acc.prop.external_package) {
			if (acc.body == null && !acc.prop.interface_only && !acc.prop.is_abstract) {
				/* no accessor body specified, insert default body */

				if (acc.prop.parent_symbol is Interface) {
					acc.error = true;
					Report.error (acc.source_reference, "Automatic properties can't be used in interfaces");
					return;
				}
				acc.automatic_body = true;
				acc.body = new Block (acc.source_reference);
				var ma = new MemberAccess.simple ("_%s".printf (acc.prop.name), acc.source_reference);
				if (acc.readable) {
					acc.body.add_statement (new ReturnStatement (ma, acc.source_reference));
				} else {
					var assignment = new Assignment (ma, new MemberAccess.simple ("value", acc.source_reference), AssignmentOperator.SIMPLE, acc.source_reference);
					acc.body.add_statement (new ExpressionStatement (assignment));
				}
			}

			if (acc.body != null && (acc.writable || acc.construction)) {
				var value_type = acc.prop.property_type.copy ();
				acc.value_parameter = new FormalParameter ("value", value_type, acc.source_reference);
				acc.body.scope.add (acc.value_parameter.name, acc.value_parameter);
			}
		}

		acc.accept_children (this);

		current_return_type = old_return_type;
	}

	public override void visit_signal (Signal sig) {
		sig.process_attributes ();

		sig.accept_children (this);
	}

	public override void visit_constructor (Constructor c) {
		c.this_parameter = new FormalParameter ("this", new ObjectType (current_class));
		c.scope.add (c.this_parameter.name, c.this_parameter);

		c.owner = current_symbol.scope;
		current_symbol = c;

		c.accept_children (this);

		foreach (DataType body_error_type in c.body.get_error_types ()) {
			Report.warning (body_error_type.source_reference, "unhandled error `%s'".printf (body_error_type.to_string()));
		}

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_destructor (Destructor d) {
		d.owner = current_symbol.scope;
		current_symbol = d;

		d.accept_children (this);

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_block (Block b) {
		b.owner = current_symbol.scope;
		current_symbol = b;

		b.accept_children (this);

		foreach (LocalVariable local in b.get_local_variables ()) {
			local.active = false;
		}

		foreach (Statement stmt in b.get_statements()) {
			b.add_error_types (stmt.get_error_types ());
		}

		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		var local = stmt.declaration as LocalVariable;
		if (local != null && local.initializer != null) {
			foreach (DataType error_type in local.initializer.get_error_types ()) {
				// ensure we can trace back which expression may throw errors of this type
				var initializer_error_type = error_type.copy ();
				initializer_error_type.source_reference = local.initializer.source_reference;

				stmt.add_error_type (initializer_error_type);
			}
		}
	}

	public override void visit_local_variable (LocalVariable local) {
		if (local.initializer != null) {
			local.initializer.target_type = local.variable_type;
		}

		local.accept_children (this);

		if (local.variable_type == null) {
			/* var type */

			if (local.initializer == null) {
				local.error = true;
				Report.error (local.source_reference, "var declaration not allowed without initializer");
				return;
			}
			if (local.initializer.value_type == null) {
				local.error = true;
				Report.error (local.source_reference, "var declaration not allowed with non-typed initializer");
				return;
			}

			local.variable_type = local.initializer.value_type.copy ();
			local.variable_type.value_owned = true;
			local.variable_type.floating_reference = false;

			local.initializer.target_type = local.variable_type;
		}

		if (local.initializer != null) {
			if (local.initializer.value_type == null) {
				if (!(local.initializer is MemberAccess) && !(local.initializer is LambdaExpression)) {
					local.error = true;
					Report.error (local.source_reference, "expression type not allowed as initializer");
					return;
				}

				if (local.initializer.symbol_reference is Method &&
				    local.variable_type is DelegateType) {
					var m = (Method) local.initializer.symbol_reference;
					var dt = (DelegateType) local.variable_type;
					var cb = dt.delegate_symbol;

					/* check whether method matches callback type */
					if (!cb.matches_method (m)) {
						local.error = true;
						Report.error (local.source_reference, "declaration of method `%s' doesn't match declaration of callback `%s'".printf (m.get_full_name (), cb.get_full_name ()));
						return;
					}

					local.initializer.value_type = local.variable_type;
				} else {
					local.error = true;
					Report.error (local.source_reference, "expression type not allowed as initializer");
					return;
				}
			}

			if (!local.initializer.value_type.compatible (local.variable_type)) {
				local.error = true;
				Report.error (local.source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (local.initializer.value_type.to_string (), local.variable_type.to_string ()));
				return;
			}

			if (local.initializer.value_type.is_disposable ()) {
				/* rhs transfers ownership of the expression */
				if (!(local.variable_type is PointerType) && !local.variable_type.value_owned) {
					/* lhs doesn't own the value */
					local.error = true;
					Report.error (local.source_reference, "Invalid assignment from owned expression to unowned variable");
					return;
				}
			}
		}

		current_source_file.add_type_dependency (local.variable_type, SourceFileDependencyType.SOURCE);

		current_symbol.scope.add (local.name, local);

		var block = (Block) current_symbol;
		block.add_local_variable (local);

		local.active = true;
	}

	/**
	 * Visit operation called for initializer lists
	 *
	 * @param list an initializer list
	 */
	public override void visit_initializer_list (InitializerList list) {
		if (list.target_type == null) {
			list.error = true;
			Report.error (list.source_reference, "initializer list used for unknown type");
			return;
		} else if (list.target_type is ArrayType) {
			/* initializer is used as array initializer */
			var array_type = (ArrayType) list.target_type;

			foreach (Expression e in list.get_initializers ()) {
				e.target_type = array_type.element_type.copy ();
			}
		} else if (list.target_type.data_type is Struct) {
			/* initializer is used as struct initializer */
			var st = (Struct) list.target_type.data_type;

			var field_it = st.get_fields ().iterator ();
			foreach (Expression e in list.get_initializers ()) {
				Field field = null;
				while (field == null) {
					if (!field_it.next ()) {
						list.error = true;
						Report.error (e.source_reference, "too many expressions in initializer list for `%s'".printf (list.target_type.to_string ()));
						return;
					}
					field = field_it.get ();
					if (field.binding != MemberBinding.INSTANCE) {
						// we only initialize instance fields
						field = null;
					}
				}

				e.target_type = field.field_type.copy ();
				if (!list.target_type.value_owned) {
					e.target_type.value_owned = false;
				}
			}
		} else {
			list.error = true;
			Report.error (list.source_reference, "initializer list used for `%s', which is neither array nor struct".printf (list.target_type.to_string ()));
			return;
		}

		list.accept_children (this);

		bool error = false;
		foreach (Expression e in list.get_initializers ()) {
			if (e.value_type == null) {
				error = true;
				continue;
			}

			var unary = e as UnaryExpression;
			if (unary != null && (unary.operator == UnaryOperator.REF || unary.operator == UnaryOperator.OUT)) {
				// TODO check type for ref and out expressions
			} else if (!e.value_type.compatible (e.target_type)) {
				error = true;
				e.error = true;
				Report.error (e.source_reference, "Expected initializer of type `%s' but got `%s'".printf (e.target_type.to_string (), e.value_type.to_string ()));
			}
		}

		if (!error) {
			/* everything seems to be correct */
			list.value_type = list.target_type;
		}
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		if (stmt.expression.error) {
			// ignore inner error
			stmt.error = true;
			return;
		}

		stmt.add_error_types (stmt.expression.get_error_types ());
	}

	public override void visit_if_statement (IfStatement stmt) {
		stmt.accept_children (this);

		if (stmt.condition.error) {
			/* if there was an error in the condition, skip this check */
			stmt.error = true;
			return;
		}

		if (!stmt.condition.value_type.compatible (bool_type)) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}

		stmt.add_error_types (stmt.condition.get_error_types ());
		stmt.add_error_types (stmt.true_statement.get_error_types ());

		if (stmt.false_statement != null) {
			stmt.add_error_types (stmt.false_statement.get_error_types ());
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

		foreach (LocalVariable local in section.get_local_variables ()) {
			local.active = false;
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

		if (!stmt.condition.value_type.compatible (bool_type)) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}

		stmt.add_error_types (stmt.condition.get_error_types ());
		stmt.add_error_types (stmt.body.get_error_types ());
	}

	public override void visit_do_statement (DoStatement stmt) {
		stmt.accept_children (this);

		if (stmt.condition.error) {
			/* if there was an error in the condition, skip this check */
			stmt.error = true;
			return;
		}

		if (!stmt.condition.value_type.compatible (bool_type)) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}

		stmt.add_error_types (stmt.condition.get_error_types ());
		stmt.add_error_types (stmt.body.get_error_types ());
	}

	public override void visit_for_statement (ForStatement stmt) {
		stmt.accept_children (this);

		if (stmt.condition != null && stmt.condition.error) {
			/* if there was an error in the condition, skip this check */
			stmt.error = true;
			return;
		}

		if (stmt.condition != null && !stmt.condition.value_type.compatible (bool_type)) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}

		if (stmt.condition != null) {
			stmt.add_error_types (stmt.condition.get_error_types ());
		}

		stmt.add_error_types (stmt.body.get_error_types ());
		foreach (Expression exp in stmt.get_initializer ()) {
			stmt.add_error_types (exp.get_error_types ());
		}
		foreach (Expression exp in stmt.get_iterator ()) {
			stmt.add_error_types (exp.get_error_types ());
		}
	}

	public override void visit_foreach_statement (ForeachStatement stmt) {
		// analyze collection expression first, used for type inference
		stmt.collection.accept (this);

		if (stmt.collection.error) {
			// ignore inner error
			stmt.error = true;
			return;
		} else if (stmt.collection.value_type == null) {
			Report.error (stmt.collection.source_reference, "invalid collection expression");
			stmt.error = true;
			return;
		}

		var collection_type = stmt.collection.value_type.copy ();
		stmt.collection.target_type = collection_type.copy ();
		
		DataType element_data_type = null;
		bool element_owned = false;

		if (collection_type.is_array ()) {
			var array_type = (ArrayType) collection_type;
			element_data_type = array_type.element_type;
		} else if (collection_type.compatible (glist_type) || collection_type.compatible (gslist_type)) {
			if (collection_type.get_type_arguments ().size > 0) {
				element_data_type = (DataType) collection_type.get_type_arguments ().get (0);
			}
		} else if (iterable_type != null && collection_type.compatible (iterable_type)) {
			element_owned = true;

			if (list_type == null || !collection_type.compatible (new ObjectType (list_type))) {
				// don't use iterator objects for lists for performance reasons
				var foreach_iterator_type = new ObjectType (iterator_type);
				foreach_iterator_type.value_owned = true;
				foreach_iterator_type.add_type_argument (stmt.type_reference);
				stmt.iterator_variable = new LocalVariable (foreach_iterator_type, "%s_it".printf (stmt.variable_name));

				stmt.add_local_variable (stmt.iterator_variable);
				stmt.iterator_variable.active = true;
			}

			var it_method = (Method) iterable_type.data_type.scope.lookup ("iterator");
			if (it_method.return_type.get_type_arguments ().size > 0) {
				var type_arg = it_method.return_type.get_type_arguments ().get (0);
				if (type_arg.type_parameter != null) {
					element_data_type = SemanticAnalyzer.get_actual_type (collection_type, it_method, type_arg, stmt);
				} else {
					element_data_type = type_arg;
				}
			}
		} else {
			stmt.error = true;
			Report.error (stmt.source_reference, "Gee.List not iterable");
			return;
		}

		if (element_data_type == null) {
			stmt.error = true;
			Report.error (stmt.collection.source_reference, "missing type argument for collection");
			return;
		}

		// analyze element type
		if (stmt.type_reference == null) {
			// var type
			stmt.type_reference = element_data_type.copy ();
		} else if (!element_data_type.compatible (stmt.type_reference)) {
			stmt.error = true;
			Report.error (stmt.source_reference, "Foreach: Cannot convert from `%s' to `%s'".printf (element_data_type.to_string (), stmt.type_reference.to_string ()));
			return;
		} else if (element_data_type.is_disposable () && element_owned && !stmt.type_reference.value_owned) {
			stmt.error = true;
			Report.error (stmt.source_reference, "Foreach: Invalid assignment from owned expression to unowned variable");
			return;
		}
		
		current_source_file.add_type_dependency (stmt.type_reference, SourceFileDependencyType.SOURCE);

		stmt.element_variable = new LocalVariable (stmt.type_reference, stmt.variable_name);

		stmt.body.scope.add (stmt.variable_name, stmt.element_variable);

		stmt.body.add_local_variable (stmt.element_variable);
		stmt.element_variable.active = true;

		// analyze body
		stmt.owner = current_symbol.scope;
		current_symbol = stmt;

		stmt.body.accept (this);

		foreach (LocalVariable local in stmt.get_local_variables ()) {
			local.active = false;
		}

		current_symbol = current_symbol.parent_symbol;

		stmt.collection_variable = new LocalVariable (collection_type, "%s_collection".printf (stmt.variable_name));

		stmt.add_local_variable (stmt.collection_variable);
		stmt.collection_variable.active = true;


		stmt.add_error_types (stmt.collection.get_error_types ());
		stmt.add_error_types (stmt.body.get_error_types ());
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		if (stmt.return_expression != null) {
			stmt.return_expression.target_type = current_return_type;
		}

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

		if (stmt.return_expression == null) {
			if (current_return_type is VoidType) {
				return;
			} else {
				stmt.error = true;
				Report.error (stmt.source_reference, "Return without value in non-void function");
				return;
			}
		}

		if (current_return_type is VoidType) {
			Report.error (stmt.source_reference, "Return with value in void function");
			return;
		}

		if (stmt.return_expression.value_type == null) {
			stmt.error = true;
			Report.error (stmt.source_reference, "Invalid expression in return value");
			return;
		}

		if (!stmt.return_expression.value_type.compatible (current_return_type)) {
			stmt.error = true;
			Report.error (stmt.source_reference, "Return: Cannot convert from `%s' to `%s'".printf (stmt.return_expression.value_type.to_string (), current_return_type.to_string ()));
			return;
		}

		if (stmt.return_expression.value_type.is_disposable () &&
		    !current_return_type.value_owned) {
			stmt.error = true;
			Report.error (stmt.source_reference, "Return value transfers ownership but method return type hasn't been declared to transfer ownership");
			return;
		}

		if (stmt.return_expression.symbol_reference is LocalVariable &&
		    stmt.return_expression.value_type.is_disposable () &&
		    !current_return_type.value_owned) {
			Report.warning (stmt.source_reference, "Local variable with strong reference used as return value and method return type hasn't been declared to transfer ownership");
		}

		if (context.non_null && stmt.return_expression is NullLiteral
		    && !current_return_type.nullable) {
			Report.warning (stmt.source_reference, "`null' incompatible with return type `%s`".printf (current_return_type.to_string ()));
		}

		stmt.add_error_types (stmt.return_expression.get_error_types ());
	}

	public override void visit_yield_statement (YieldStatement stmt) {
		stmt.check (this);
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		stmt.error_expression.target_type = new ErrorType (null, null, stmt.source_reference);
		stmt.error_expression.target_type.value_owned = true;

		stmt.accept_children (this);

		var error_type = stmt.error_expression.value_type.copy ();
		error_type.source_reference = stmt.source_reference;

		stmt.add_error_type (error_type);
	}

	public override void visit_try_statement (TryStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_catch_clause (CatchClause clause) {
		if (clause.error_type != null) {
			current_source_file.add_type_dependency (clause.error_type, SourceFileDependencyType.SOURCE);

			clause.error_variable = new LocalVariable (clause.error_type.copy (), clause.variable_name);

			clause.body.scope.add (clause.variable_name, clause.error_variable);
			clause.body.add_local_variable (clause.error_variable);
		} else {
			clause.error_type = new ErrorType (null, null, clause.source_reference);
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

		if (!(stmt.expression.value_type is PointerType)) {
			stmt.error = true;
			Report.error (stmt.source_reference, "delete operator not supported for `%s'".printf (stmt.expression.value_type.to_string ()));
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
		Gee.List<Expression> size = expr.get_sizes ();
		var initlist = expr.initializer_list;

		if (expr.element_type != null) {
			expr.element_type.accept (this);
		}

		foreach (Expression e in size) {
			e.accept (this);
		}

		var calc_sizes = new ArrayList<Literal> ();
		if (initlist != null) {
			initlist.target_type = new ArrayType (expr.element_type, expr.rank, expr.source_reference);

			initlist.accept (this);

			var ret = create_sizes_from_initializer_list (initlist, expr.rank, calc_sizes);
			if (ret == -1) {
				expr.error = true;
			}
		}

		if (size.size > 0) {
			/* check for errors in the size list */
			foreach (Expression e in size) {
				if (e.value_type == null) {
					/* return on previous error */
					return;
				} else if (!(e.value_type.data_type is Struct) || !((Struct) e.value_type.data_type).is_integer_type ()) {
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
		if (expr.initializer_list != null && expr.initializer_list.value_type == null) {
			return;
		}

		/* try to construct the type of the array */
		if (expr.element_type == null) {
			expr.error = true;
			Report.error (expr.source_reference, "Cannot determine the element type of the created array");
			return;
		}

		expr.element_type.value_owned = true;

		expr.value_type = new ArrayType (expr.element_type, expr.rank, expr.source_reference);
		expr.value_type.value_owned = true;
	}

	public override void visit_boolean_literal (BooleanLiteral expr) {
		expr.value_type = bool_type;
	}

	public override void visit_character_literal (CharacterLiteral expr) {
		expr.value_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup ("char"));
	}

	public override void visit_integer_literal (IntegerLiteral expr) {
		expr.value_type = new IntegerType ((TypeSymbol) root_symbol.scope.lookup (expr.get_type_name ()), expr.value, expr.get_type_name ());
	}

	public override void visit_real_literal (RealLiteral expr) {
		expr.value_type = new ValueType ((TypeSymbol) root_symbol.scope.lookup (expr.get_type_name ()));
	}

	public override void visit_string_literal (StringLiteral expr) {
		expr.value_type = string_type.copy ();
	}

	public override void visit_null_literal (NullLiteral expr) {
		expr.value_type = new NullType (expr.source_reference);
	}

	public DataType? get_value_type_for_symbol (Symbol sym, bool lvalue) {
		if (sym is Field) {
			var f = (Field) sym;
			var type = f.field_type.copy ();
			if (!lvalue) {
				type.value_owned = false;
			}
			return type;
		} else if (sym is Constant) {
			var c = (Constant) sym;
			return c.type_reference;
		} else if (sym is Property) {
			var prop = (Property) sym;
			if (prop.property_type != null) {
				var type = prop.property_type.copy ();
				type.value_owned = false;
				return type;
			}
		} else if (sym is FormalParameter) {
			var p = (FormalParameter) sym;
			var type = p.parameter_type.copy ();
			if (!lvalue) {
				type.value_owned = false;
			}
			return type;
		} else if (sym is LocalVariable) {
			var local = (LocalVariable) sym;
			var type = local.variable_type.copy ();
			if (!lvalue) {
				type.value_owned = false;
			}
			return type;
		} else if (sym is EnumValue) {
			return new ValueType ((TypeSymbol) sym.parent_symbol);
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
		expr.inner.target_type = expr.target_type;

		expr.accept_children (this);

		if (expr.inner.error) {
			// ignore inner error
			expr.error = true;
			return;
		}

		if (expr.inner.value_type == null) {
			// static type may be null for method references
			expr.error = true;
			Report.error (expr.inner.source_reference, "Invalid expression type");
			return;
		}

		expr.value_type = expr.inner.value_type.copy ();
		// don't call g_object_ref_sink on inner and outer expression
		expr.value_type.floating_reference = false;

		// don't transform expression twice
		expr.inner.target_type = expr.inner.value_type.copy ();
	}
	
	public override void visit_member_access (MemberAccess expr) {
		expr.check (this);
	}

	public static DataType get_data_type_for_symbol (TypeSymbol sym) {
		DataType type = null;

		if (sym is ObjectTypeSymbol) {
			type = new ObjectType ((ObjectTypeSymbol) sym);
		} else if (sym is Struct) {
			type = new ValueType ((Struct) sym);
		} else if (sym is Enum) {
			type = new ValueType ((Enum) sym);
		} else if (sym is ErrorDomain) {
			type = new ErrorType ((ErrorDomain) sym, null);
		} else if (sym is ErrorCode) {
			type = new ErrorType ((ErrorDomain) sym.parent_symbol, (ErrorCode) sym);
		} else {
			Report.error (null, "internal error: `%s' is not a supported type".printf (sym.get_full_name ()));
			return new InvalidType ();
		}

		return type;
	}

	public override void visit_invocation_expression (InvocationExpression expr) {
		expr.check (this);
	}

	public bool check_arguments (Expression expr, DataType mtype, Gee.List<FormalParameter> params, Gee.List<Expression> args) {
		Expression prev_arg = null;
		Iterator<Expression> arg_it = args.iterator ();

		bool diag = (mtype is MethodType && ((MethodType) mtype).method_symbol.get_attribute ("Diagnostics") != null);

		bool ellipsis = false;
		int i = 0;
		foreach (FormalParameter param in params) {
			if (!param.check (this)) {
				return false;
			}

			if (param.ellipsis) {
				ellipsis = true;
				break;
			}

			/* header file necessary if we need to cast argument */
			current_source_file.add_type_dependency (param.parameter_type, SourceFileDependencyType.SOURCE);

			if (arg_it == null || !arg_it.next ()) {
				if (param.default_expression == null) {
					expr.error = true;
					Report.error (expr.source_reference, "Too few arguments, method `%s' does not take %d arguments".printf (mtype.to_string (), args.size));
					return false;
				} else {
					var invocation_expr = expr as InvocationExpression;
					var object_creation_expr = expr as ObjectCreationExpression;
					if (invocation_expr != null) {
						invocation_expr.add_argument (param.default_expression);
					} else if (object_creation_expr != null) {
						object_creation_expr.add_argument (param.default_expression);
					} else {
						assert_not_reached ();
					}
					arg_it = null;
				}
			} else {
				var arg = arg_it.get ();
				if (arg.error) {
					// ignore inner error
					expr.error = true;
					return false;
				} else if (arg.value_type == null) {
					// disallow untyped arguments except for type inference of callbacks
					if (!(param.parameter_type is DelegateType) || !(arg.symbol_reference is Method)) {
						expr.error = true;
						Report.error (arg.source_reference, "Invalid type for argument %d".printf (i + 1));
						return false;
					}
				} else if (arg.target_type != null && !arg.value_type.compatible (arg.target_type)
				           && !(arg is NullLiteral && param.direction == ParameterDirection.OUT)) {
					expr.error = true;
					Report.error (arg.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.value_type.to_string (), arg.target_type.to_string ()));
					return false;
				} else {
					// 0 => null, 1 => in, 2 => ref, 3 => out
					int arg_type = 1;
					if (arg.value_type is NullType) {
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
						if (param.direction == ParameterDirection.REF) {
							expr.error = true;
							Report.error (arg.source_reference, "Argument %d: Cannot pass null to reference parameter".printf (i + 1));
							return false;
						} else if (context.non_null && param.direction != ParameterDirection.OUT && !param.parameter_type.nullable) {
							Report.warning (arg.source_reference, "Argument %d: Cannot pass null to non-null parameter type".printf (i + 1));
						}
					} else if (arg_type == 1) {
						if (param.direction != ParameterDirection.IN) {
							expr.error = true;
							Report.error (arg.source_reference, "Argument %d: Cannot pass value to reference or output parameter".printf (i + 1));
							return false;
						}
					} else if (arg_type == 2) {
						if (param.direction != ParameterDirection.REF) {
							expr.error = true;
							Report.error (arg.source_reference, "Argument %d: Cannot pass ref argument to non-reference parameter".printf (i + 1));
							return false;
						}

						// weak variables can only be used with weak ref parameters
						if (param.parameter_type.is_disposable ()) {
							if (!(arg.value_type is PointerType) && !arg.value_type.value_owned) {
								/* variable doesn't own the value */
								expr.error = true;
								Report.error (arg.source_reference, "Invalid assignment from owned expression to unowned variable");
								return false;
							}
						}
					} else if (arg_type == 3) {
						if (param.direction != ParameterDirection.OUT) {
							expr.error = true;
							Report.error (arg.source_reference, "Argument %d: Cannot pass out argument to non-output parameter".printf (i + 1));
							return false;
						}

						// weak variables can only be used with weak out parameters
						if (param.parameter_type.is_disposable ()) {
							if (!(arg.value_type is PointerType) && !arg.value_type.value_owned) {
								/* variable doesn't own the value */
								expr.error = true;
								Report.error (arg.source_reference, "Invalid assignment from owned expression to unowned variable");
								return false;
							}
						}
					}
				}

				prev_arg = arg;

				i++;
			}
		}

		if (ellipsis) {
			while (arg_it != null && arg_it.next ()) {
				var arg = arg_it.get ();
				if (arg.error) {
					// ignore inner error
					expr.error = true;
					return false;
				} else if (arg.value_type == null) {
					// disallow untyped arguments except for type inference of callbacks
					if (!(arg.symbol_reference is Method)) {
						expr.error = true;
						Report.error (expr.source_reference, "Invalid type for argument %d".printf (i + 1));
						return false;
					}
				} else if (arg.target_type != null && !arg.value_type.compatible (arg.target_type)) {
					// target_type known for printf arguments
					expr.error = true;
					Report.error (arg.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.value_type.to_string (), arg.target_type.to_string ()));
					return false;
				}

				i++;
			}
		} else if (!ellipsis && arg_it != null && arg_it.next ()) {
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
			instance_base_type = new ObjectType ((Class) base_type.data_type);
		} else {
			instance_base_type = new ObjectType ((Interface) base_type.data_type);
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
				if (instance_type.get_type_arguments ().size <= param_index) {
					Report.error (node_reference.source_reference, "internal error: missing type argument for type parameter `%s' in `%s'".printf (type_arg.type_parameter.get_full_name (), instance_type.to_string ()));
					node_reference.error = true;
					return null;
				}
				type_arg = instance_type.get_type_arguments ().get (param_index);
			}
			instance_base_type.add_type_argument (type_arg);
		}
		return instance_base_type;
	}

	static DataType? get_instance_base_type_for_member (DataType derived_instance_type, Symbol member, CodeNode node_reference) {
		DataType instance_type = derived_instance_type;

		while (instance_type is PointerType) {
			var instance_pointer_type = (PointerType) instance_type;
			instance_type = instance_pointer_type.base_type;
		}

		if (instance_type.data_type == member.parent_symbol) {
			return instance_type;
		}

		DataType instance_base_type = null;

		// use same algorithm as symbol_lookup_inherited
		if (instance_type.data_type is Class) {
			var cl = (Class) instance_type.data_type;
			// first check interfaces without prerequisites
			// (prerequisites can be assumed to be met already)
			foreach (DataType base_type in cl.get_base_types ()) {
				if (base_type.data_type is Interface) {
					instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, base_type, node_reference), member, node_reference);
					if (instance_base_type != null) {
						return instance_base_type;
					}
				}
			}
			// then check base class recursively
			if (instance_base_type == null) {
				foreach (DataType base_type in cl.get_base_types ()) {
					if (base_type.data_type is Class) {
						instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, base_type, node_reference), member, node_reference);
						if (instance_base_type != null) {
							return instance_base_type;
						}
					}
				}
			}
		} else if (instance_type.data_type is Struct) {
			var st = (Struct) instance_type.data_type;
			foreach (DataType base_type in st.get_base_types ()) {
				instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, base_type, node_reference), member, node_reference);
				if (instance_base_type != null) {
					return instance_base_type;
				}
			}
		} else if (instance_type.data_type is Interface) {
			var iface = (Interface) instance_type.data_type;
			// first check interface prerequisites recursively
			foreach (DataType prerequisite in iface.get_prerequisites ()) {
				if (prerequisite.data_type is Interface) {
					instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, prerequisite, node_reference), member, node_reference);
					if (instance_base_type != null) {
						return instance_base_type;
					}
				}
			}
			if (instance_base_type == null) {
				// then check class prerequisite recursively
				foreach (DataType prerequisite in iface.get_prerequisites ()) {
					if (prerequisite.data_type is Class) {
						instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, prerequisite, node_reference), member, node_reference);
						if (instance_base_type != null) {
							return instance_base_type;
						}
					}
				}
			}
		}

		return null;
	}

	public static DataType? get_actual_type (DataType derived_instance_type, Symbol generic_member, DataType generic_type, CodeNode node_reference) {
		// trace type arguments back to the datatype where the method has been declared
		var instance_type = get_instance_base_type_for_member (derived_instance_type, generic_member, node_reference);

		if (instance_type == null) {
			Report.error (node_reference.source_reference, "internal error: unable to find generic member `%s'".printf (generic_member.name));
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
		actual_type.is_type_argument = true;
		actual_type.value_owned = actual_type.value_owned && generic_type.value_owned;
		return actual_type;
	}

	public override void visit_element_access (ElementAccess expr) {
		expr.container.accept (this);

		if (expr.container.value_type == null) {
			/* don't proceed if a child expression failed */
			expr.error = true;
			return;
		}

		var container_type = expr.container.value_type.data_type;

		if (expr.container is MemberAccess && expr.container.symbol_reference is Signal) {
			// signal detail access
			if (expr.get_indices ().size != 1) {
				expr.error = true;
				Report.error (expr.source_reference, "Element access with more than one dimension is not supported for signals");
				return;
			}
			expr.get_indices ().get (0).target_type = string_type.copy ();
		}

		foreach (Expression index in expr.get_indices ()) {
			index.accept (this);
		}

		bool index_int_type_check = true;

		var pointer_type = expr.container.value_type as PointerType;

		/* assign a value_type when possible */
		if (expr.container.value_type is ArrayType) {
			var array_type = (ArrayType) expr.container.value_type;
			expr.value_type = array_type.element_type.copy ();
			if (!expr.lvalue) {
				expr.value_type.value_owned = false;
			}
		} else if (pointer_type != null && !pointer_type.base_type.is_reference_type_or_type_parameter ()) {
			expr.value_type = pointer_type.base_type.copy ();
		} else if (container_type == string_type.data_type) {
			if (expr.get_indices ().size != 1) {
				expr.error = true;
				Report.error (expr.source_reference, "Element access with more than one dimension is not supported for strings");
				return;
			}

			expr.value_type = unichar_type;
		} else if (container_type != null && list_type != null && map_type != null &&
		           (container_type.is_subtype_of (list_type) || container_type.is_subtype_of (map_type))) {
			Gee.List<Expression> indices = expr.get_indices ();
			if (indices.size != 1) {
				expr.error = true;
				Report.error (expr.source_reference, "Element access with more than one dimension is not supported for the specified type");
				return;
			}
			Iterator<Expression> indices_it = indices.iterator ();
			indices_it.next ();
			var index = indices_it.get ();
			index_int_type_check = false;

			// lookup symbol in interface instead of class as implemented interface methods are not in VAPI files
			Symbol get_sym = null;
			if (container_type.is_subtype_of (list_type)) {
				get_sym = list_type.scope.lookup ("get");
			} else if (container_type.is_subtype_of (map_type)) {
				get_sym = map_type.scope.lookup ("get");
			}
			var get_method = (Method) get_sym;
			Gee.List<FormalParameter> get_params = get_method.get_parameters ();
			Iterator<FormalParameter> get_params_it = get_params.iterator ();
			get_params_it.next ();
			var get_param = get_params_it.get ();

			var index_type = get_param.parameter_type;
			if (index_type.type_parameter != null) {
				index_type = get_actual_type (expr.container.value_type, get_method, get_param.parameter_type, expr);
			}

			if (!index.value_type.compatible (index_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "index expression: Cannot convert from `%s' to `%s'".printf (index.value_type.to_string (), index_type.to_string ()));
				return;
			}

			expr.value_type = get_actual_type (expr.container.value_type, get_method, get_method.return_type, expr).copy ();
			if (expr.lvalue) {
				// get () returns owned value, set () accepts unowned value
				expr.value_type.value_owned = false;
			}
		} else if (expr.container is MemberAccess && expr.container.symbol_reference is Signal) {
			index_int_type_check = false;

			expr.symbol_reference = expr.container.symbol_reference;
			expr.value_type = expr.container.value_type;
		} else {
			expr.error = true;
			Report.error (expr.source_reference, "The expression `%s' does not denote an Array".printf (expr.container.value_type.to_string ()));
		}

		if (index_int_type_check) {
			/* check if the index is of type integer */
			foreach (Expression e in expr.get_indices ()) {
				/* don't proceed if a child expression failed */
				if (e.value_type == null) {
					return;
				}

				/* check if the index is of type integer */
				if (!(e.value_type.data_type is Struct) || !((Struct) e.value_type.data_type).is_integer_type ()) {
					expr.error = true;
					Report.error (e.source_reference, "Expression of integer type expected");
				}
			}
		}
	}

	public bool is_in_instance_method () {
		var sym = current_symbol;
		while (sym != null) {
			if (sym is CreationMethod) {
				return true;
			} else if (sym is Method) {
				var m = (Method) sym;
				return m.binding == MemberBinding.INSTANCE;
			} else if (sym is Constructor) {
				var c = (Constructor) sym;
				return c.binding == MemberBinding.INSTANCE;
			} else if (sym is Destructor) {
				return true;
			} else if (sym is Property) {
				return true;
			}
			sym = sym.parent_symbol;
		}

		return false;
	}

	public override void visit_base_access (BaseAccess expr) {
		if (!is_in_instance_method ()) {
			expr.error = true;
			Report.error (expr.source_reference, "Base access invalid outside of instance methods");
			return;
		}

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
			expr.value_type = base_type_it.get ();
		} else if (current_class.base_class == null) {
			expr.error = true;
			Report.error (expr.source_reference, "Base access invalid without base class");
			return;
		} else {
			expr.value_type = new ObjectType (current_class.base_class);
		}

		expr.symbol_reference = expr.value_type.data_type;
	}

	public override void visit_postfix_expression (PostfixExpression expr) {
		expr.value_type = expr.inner.value_type;
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		expr.check (this);
	}

	public void visit_member_initializer (MemberInitializer init, DataType type) {
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
			member_type = f.field_type;
		} else if (init.symbol_reference is Property) {
			var prop = (Property) init.symbol_reference;
			member_type = prop.property_type;
			if (prop.set_accessor == null || !prop.set_accessor.writable) {
				init.error = true;
				Report.error (init.source_reference, "Property `%s' is read-only".printf (prop.get_full_name ()));
				return;
			}
		}
		if (init.initializer.value_type == null || !init.initializer.value_type.compatible (member_type)) {
			init.error = true;
			Report.error (init.source_reference, "Invalid type for member `%s'".printf (init.name));
			return;
		}
	}

	public override void visit_sizeof_expression (SizeofExpression expr) {
		expr.value_type = ulong_type;
	}

	public override void visit_typeof_expression (TypeofExpression expr) {
		expr.value_type = type_type;
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
		if (expr.operator == UnaryOperator.REF || expr.operator == UnaryOperator.OUT) {
			expr.inner.lvalue = true;
			expr.inner.target_type = expr.target_type;
		}

		expr.accept_children (this);

		if (expr.inner.error) {
			/* if there was an error in the inner expression, skip type check */
			expr.error = true;
			return;
		}

		if (expr.operator == UnaryOperator.PLUS || expr.operator == UnaryOperator.MINUS) {
			// integer or floating point type
			if (!is_numeric_type (expr.inner.value_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "Operator not supported for `%s'".printf (expr.inner.value_type.to_string ()));
				return;
			}

			expr.value_type = expr.inner.value_type;
		} else if (expr.operator == UnaryOperator.LOGICAL_NEGATION) {
			// boolean type
			if (!expr.inner.value_type.compatible (bool_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "Operator not supported for `%s'".printf (expr.inner.value_type.to_string ()));
				return;
			}

			expr.value_type = expr.inner.value_type;
		} else if (expr.operator == UnaryOperator.BITWISE_COMPLEMENT) {
			// integer type
			if (!is_integer_type (expr.inner.value_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "Operator not supported for `%s'".printf (expr.inner.value_type.to_string ()));
				return;
			}

			expr.value_type = expr.inner.value_type;
		} else if (expr.operator == UnaryOperator.INCREMENT ||
		           expr.operator == UnaryOperator.DECREMENT) {
			// integer type
			if (!is_integer_type (expr.inner.value_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "Operator not supported for `%s'".printf (expr.inner.value_type.to_string ()));
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

			var assignment = new Assignment (ma, bin, AssignmentOperator.SIMPLE, expr.source_reference);
			var parenthexp = new ParenthesizedExpression (assignment, expr.source_reference);
			parenthexp.target_type = expr.target_type;
			replaced_nodes.add (expr);
			expr.parent_node.replace_expression (expr, parenthexp);
			parenthexp.accept (this);
			return;
		} else if (expr.operator == UnaryOperator.REF || expr.operator == UnaryOperator.OUT) {
			if (expr.inner.symbol_reference is Field || expr.inner.symbol_reference is FormalParameter || expr.inner.symbol_reference is LocalVariable) {
				// ref and out can only be used with fields, parameters, and local variables
				expr.lvalue = true;
				expr.value_type = expr.inner.value_type;
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

		expr.value_type = expr.type_reference;
		expr.value_type.value_owned = expr.inner.value_type.value_owned;

		expr.inner.target_type = expr.inner.value_type.copy ();
	}

	public override void visit_pointer_indirection (PointerIndirection expr) {
		if (expr.inner.error) {
			return;
		}
		if (expr.inner.value_type == null) {
			expr.error = true;
			Report.error (expr.source_reference, "internal error: unknown type of inner expression");
			return;
		}
		if (expr.inner.value_type is PointerType) {
			var pointer_type = (PointerType) expr.inner.value_type;
			if (pointer_type.base_type is ReferenceType) {
				expr.error = true;
				Report.error (expr.source_reference, "Pointer indirection not supported for this expression");
				return;
			}
			expr.value_type = pointer_type.base_type;
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
		if (!(expr.inner.value_type is ValueType
		      || expr.inner.value_type is ObjectType
		      || expr.inner.value_type is PointerType)) {
			expr.error = true;
			Report.error (expr.source_reference, "Address-of operator not supported for this expression");
			return;
		}

		if (expr.inner.value_type.is_reference_type_or_type_parameter ()) {
			expr.value_type = new PointerType (new PointerType (expr.inner.value_type));
		} else {
			expr.value_type = new PointerType (expr.inner.value_type);
		}
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		expr.inner.lvalue = true;

		expr.accept_children (this);

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

		if (!expr.inner.value_type.is_disposable ()
		    && !(expr.inner.value_type is PointerType)) {
			expr.error = true;
			Report.error (expr.source_reference, "No reference to be transferred");
			return;
		}

		expr.value_type = expr.inner.value_type.copy ();
		expr.value_type.value_owned = true;
	}

	public DataType? get_arithmetic_result_type (DataType left_type, DataType right_type) {
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
		expr.check (this);
	}

	public override void visit_type_check (TypeCheck expr) {
		if (expr.type_reference.data_type == null) {
			/* if type resolving didn't succeed, skip this check */
			expr.error = true;
			return;
		}

		current_source_file.add_type_dependency (expr.type_reference, SourceFileDependencyType.SOURCE);

		expr.value_type = bool_type;
	}

	public override void visit_conditional_expression (ConditionalExpression expr) {
		if (expr.condition.error || expr.false_expression.error || expr.true_expression.error) {
			return;
		}

		if (!expr.condition.value_type.compatible (bool_type)) {
			expr.error = true;
			Report.error (expr.condition.source_reference, "Condition must be boolean");
			return;
		}

		/* FIXME: support memory management */
		if (expr.false_expression.value_type.compatible (expr.true_expression.value_type)) {
			expr.value_type = expr.true_expression.value_type.copy ();
		} else if (expr.true_expression.value_type.compatible (expr.false_expression.value_type)) {
			expr.value_type = expr.false_expression.value_type.copy ();
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

	public Method? find_current_method () {
		var sym = current_symbol;
		while (sym != null) {
			if (sym is Method) {
				return (Method) sym;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}

	public bool is_in_constructor () {
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
		if (!(l.target_type is DelegateType)) {
			l.error = true;
			Report.error (l.source_reference, "lambda expression not allowed in this context");
			return;
		}

		bool in_instance_method = false;
		var current_method = find_current_method ();
		if (current_method != null) {
			in_instance_method = (current_method.binding == MemberBinding.INSTANCE);
		} else {
			in_instance_method = is_in_constructor ();
		}

		var cb = (Delegate) ((DelegateType) l.target_type).delegate_symbol;
		l.method = new Method (get_lambda_name (), cb.return_type);
		if (!cb.has_target || !in_instance_method) {
			l.method.binding = MemberBinding.STATIC;
		}
		l.method.owner = current_symbol.scope;

		var lambda_params = l.get_parameters ();
		Iterator<string> lambda_param_it = lambda_params.iterator ();
		foreach (FormalParameter cb_param in cb.get_parameters ()) {
			if (!lambda_param_it.next ()) {
				/* lambda expressions are allowed to have less parameters */
				break;
			}

			string lambda_param = lambda_param_it.get ();

			var param = new FormalParameter (lambda_param, cb_param.parameter_type);

			l.method.add_parameter (param);
		}

		if (lambda_param_it.next ()) {
			/* lambda expressions may not expect more parameters */
			l.error = true;
			Report.error (l.source_reference, "lambda expression: too many parameters");
			return;
		}

		if (l.expression_body != null) {
			var block = new Block (l.source_reference);
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

		l.value_type = new MethodType (l.method);
	}

	public override void visit_assignment (Assignment a) {
		a.check (this);
	}
}
