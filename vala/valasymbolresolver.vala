/* valasymbolresolver.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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
 * 	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

/**
 * Code visitor resolving symbol names.
 */
public class Vala.SymbolResolver : CodeVisitor {
	CodeContext context;
	Symbol root_symbol;
	Scope current_scope;
	
	/**
	 * Resolve symbol names in the specified code context.
	 *
	 * @param context a code context
	 */
	public void resolve (CodeContext context) {
		this.context = context;
		root_symbol = context.root;

		context.root.accept (this);
	}
	
	public override void visit_namespace (Namespace ns) {
		var old_scope = current_scope;
		current_scope = ns.scope;

		ns.accept_children (this);

		current_scope = old_scope;
	}
	
	public override void visit_class (Class cl) {
		current_scope = cl.scope;

		cl.accept_children (this);

		cl.base_class = null;
		foreach (DataType type in cl.get_base_types ()) {
			if (type.data_type is Class) {
				if (cl.base_class != null) {
					cl.error = true;
					Report.error (type.source_reference, "%s: Classes cannot have multiple base classes (`%s' and `%s')".printf (cl.get_full_name (), cl.base_class.get_full_name (), type.data_type.get_full_name ()));
					return;
				}
				cl.base_class = (Class) type.data_type;
				if (cl.base_class.is_subtype_of (cl)) {
					cl.error = true;
					Report.error (type.source_reference, "Base class cycle (`%s' and `%s')".printf (cl.get_full_name (), cl.base_class.get_full_name ()));
					return;
				}
			}
		}

		if (context.profile == Profile.DOVA) {
			// classes derive from Object by default
			if (cl.base_class == null) {
				var any_class = (Class) root_symbol.scope.lookup ("any");
				if (cl != any_class) {
					var object_class = (Class) root_symbol.scope.lookup ("Dova").scope.lookup ("Object");
					cl.add_base_type (new ObjectType (object_class));
					cl.base_class = object_class;
				}
			}
		}

		current_scope = current_scope.parent_scope;
	}

	public override void visit_struct (Struct st) {
		current_scope = st.scope;

		st.accept_children (this);

		if (st.base_type != null) {
			var base_type = st.base_struct;
			if (base_type != null) {
				if (base_type.is_subtype_of (st)) {
					st.error = true;
					Report.error (base_type.source_reference, "Base struct cycle (`%s' and `%s')".printf (st.get_full_name (), base_type.get_full_name ()));
					return;
				}
			}
		}

		current_scope = current_scope.parent_scope;
	}

	public override void visit_interface (Interface iface) {
		current_scope = iface.scope;

		iface.accept_children (this);

		foreach (DataType type in iface.get_prerequisites ()) {
			if (type.data_type != null && type.data_type.is_subtype_of (iface)) {
				iface.error = true;
				Report.error (type.source_reference, "Prerequisite cycle (`%s' and `%s')".printf (iface.get_full_name (), type.data_type.get_full_name ()));
				return;
			}
		}

		if (context.profile == Profile.DOVA) {
			// all interfaces require Object
			if (iface.get_prerequisites ().size == 0) {
				var object_class = (Class) root_symbol.scope.lookup ("Dova").scope.lookup ("Object");
				iface.add_prerequisite (new ObjectType (object_class));
			}
		}

		current_scope = current_scope.parent_scope;
	}

	public override void visit_enum (Enum en) {
		current_scope = en.scope;

		en.accept_children (this);

		current_scope = current_scope.parent_scope;
	}

	public override void visit_error_domain (ErrorDomain ed) {
		current_scope = ed.scope;

		ed.accept_children (this);

		current_scope = current_scope.parent_scope;
	}

	public override void visit_delegate (Delegate cb) {
		current_scope = cb.scope;

		cb.accept_children (this);

		current_scope = current_scope.parent_scope;
	}

	public override void visit_constant (Constant c) {
		var old_scope = current_scope;
		if (!(c.parent_symbol is Block)) {
			// non-local constant
			current_scope = c.scope;
		}

		c.accept_children (this);

		current_scope = old_scope;
	}

	public override void visit_field (Field f) {
		current_scope = f.scope;

		f.accept_children (this);

		current_scope = current_scope.parent_scope;
	}

	public override void visit_method (Method m) {
		current_scope = m.scope;

		m.accept_children (this);

		current_scope = current_scope.parent_scope;
	}

	public override void visit_creation_method (CreationMethod m) {
		m.accept_children (this);
	}

	public override void visit_formal_parameter (Parameter p) {
		p.accept_children (this);
	}

	public override void visit_property (Property prop) {
		prop.accept_children (this);
	}

	public override void visit_property_accessor (PropertyAccessor acc) {
		acc.accept_children (this);
	}

	public override void visit_signal (Signal sig) {
		sig.accept_children (this);
	}

	public override void visit_constructor (Constructor c) {
		c.accept_children (this);
	}

	public override void visit_destructor (Destructor d) {
		d.accept_children (this);
	}

	public override void visit_block (Block b) {
		b.accept_children (this);
	}

	public override void visit_using_directive (UsingDirective ns) {
		var unresolved_symbol = ns.namespace_symbol as UnresolvedSymbol;
		if (unresolved_symbol != null) {
			ns.namespace_symbol = resolve_symbol (unresolved_symbol);
			if (!(ns.namespace_symbol is Namespace)) {
				ns.error = true;
				Report.error (ns.source_reference, "The namespace name `%s' could not be found".printf (unresolved_symbol.to_string ()));
				return;
			}
		}
	}

	private Symbol? resolve_symbol (UnresolvedSymbol unresolved_symbol) {
		if (unresolved_symbol.qualified) {
			// qualified access to global symbol
			return root_symbol.scope.lookup (unresolved_symbol.name);
		} else if (unresolved_symbol.inner == null) {
			Symbol sym = null;
			Scope scope = current_scope;
			while (sym == null && scope != null) {
				sym = scope.lookup (unresolved_symbol.name);

				// only look for types and type containers
				if (!(sym is Namespace || sym is TypeSymbol || sym is TypeParameter)) {
					sym = null;
				}

				scope = scope.parent_scope;
			}
			if (sym == null && unresolved_symbol.source_reference != null) {
				foreach (UsingDirective ns in unresolved_symbol.source_reference.using_directives) {
					if (ns.error || ns.namespace_symbol is UnresolvedSymbol) {
						continue;
					}

					var local_sym = ns.namespace_symbol.scope.lookup (unresolved_symbol.name);

					// only look for types and type containers
					if (!(local_sym is Namespace || local_sym is TypeSymbol || sym is TypeParameter)) {
						local_sym = null;
					}

					if (local_sym != null) {
						if (sym != null && sym != local_sym) {
							unresolved_symbol.error = true;
							Report.error (unresolved_symbol.source_reference, "`%s' is an ambiguous reference between `%s' and `%s'".printf (unresolved_symbol.name, sym.get_full_name (), local_sym.get_full_name ()));
							return null;
						}
						sym = local_sym;
					}
				}
			}
			return sym;
		} else {
			var parent_symbol = resolve_symbol (unresolved_symbol.inner);
			if (parent_symbol == null) {
				unresolved_symbol.error = true;
				Report.error (unresolved_symbol.inner.source_reference, "The symbol `%s' could not be found".printf (unresolved_symbol.inner.name));
				return null;
			}
			parent_symbol.used = true;

			return parent_symbol.scope.lookup (unresolved_symbol.name);
		}
	}

	DataType get_type_for_struct (Struct st, Struct base_struct) {
		if (st.base_type != null) {
			// make sure that base type is resolved

			var old_scope = current_scope;
			current_scope = st.scope;

			st.base_type.accept (this);

			current_scope = old_scope;
		}

		if (base_struct.base_struct != null) {
			return get_type_for_struct (st, base_struct.base_struct);
		}

		// attributes are not processed yet, access them directly
		if (base_struct.get_attribute ("BooleanType") != null) {
			return new BooleanType (st);
		} else if (base_struct.get_attribute ("IntegerType") != null) {
			return new IntegerType (st);
		} else if (base_struct.get_attribute ("FloatingType") != null) {
			return new FloatingType (st);
		} else {
			return new StructValueType (st);
		}
	}

	private DataType resolve_type (UnresolvedType unresolved_type) {
		DataType type = null;

		// still required for vapigen
		if (unresolved_type.unresolved_symbol.name == "void") {
			return new VoidType ();
		}

		var sym = resolve_symbol (unresolved_type.unresolved_symbol);
		if (sym == null) {
			// don't report same error twice
			if (!unresolved_type.unresolved_symbol.error) {
				Report.error (unresolved_type.source_reference, "The type name `%s' could not be found".printf (unresolved_type.unresolved_symbol.to_string ()));
			}
			return new InvalidType ();
		}

		if (sym is TypeParameter) {
			type = new GenericType ((TypeParameter) sym);
		} else if (sym is TypeSymbol) {
			if (sym is Delegate) {
				type = new DelegateType ((Delegate) sym);
			} else if (sym is Class) {
				var cl = (Class) sym;
				if (cl.is_error_base) {
					type = new ErrorType (null, null, unresolved_type.source_reference);
				} else {
					type = new ObjectType (cl);
				}
			} else if (sym is Interface) {
				type = new ObjectType ((Interface) sym);
			} else if (sym is Struct) {
				type = get_type_for_struct ((Struct) sym, (Struct) sym);
			} else if (sym is Enum) {
				type = new EnumValueType ((Enum) sym);
			} else if (sym is ErrorDomain) {
				type = new ErrorType ((ErrorDomain) sym, null, unresolved_type.source_reference);
			} else if (sym is ErrorCode) {
				type = new ErrorType ((ErrorDomain) sym.parent_symbol, (ErrorCode) sym, unresolved_type.source_reference);
			} else {
				Report.error (unresolved_type.source_reference, "internal error: `%s' is not a supported type".printf (sym.get_full_name ()));
				return new InvalidType ();
			}
		} else {
			Report.error (unresolved_type.source_reference, "`%s' is not a type".printf (sym.get_full_name ()));
			return new InvalidType ();
		}

		type.source_reference = unresolved_type.source_reference;
		type.value_owned = unresolved_type.value_owned;
		sym.used = true;

		if (type is GenericType) {
			// type parameters are always considered nullable
			// actual type argument may or may not be nullable
			type.nullable = true;
		} else {
			type.nullable = unresolved_type.nullable;
		}

		type.is_dynamic = unresolved_type.is_dynamic;
		foreach (DataType type_arg in unresolved_type.get_type_arguments ()) {
			type.add_type_argument (type_arg);
		}

		return type;
	}

	public override void visit_data_type (DataType data_type) {
		data_type.accept_children (this);

		if (!(data_type is UnresolvedType)) {
			return;
		}

		var unresolved_type = (UnresolvedType) data_type;

		unresolved_type.parent_node.replace_type (unresolved_type, resolve_type (unresolved_type));
	}

	public override void visit_declaration_statement (DeclarationStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_local_variable (LocalVariable local) {
		local.accept_children (this);
		if (!context.experimental_non_null) {
			// local reference variables are considered nullable
			// except when using experimental non-null enhancements
			if (local.variable_type is ReferenceType) {
				var array_type = local.variable_type as ArrayType;
				if (array_type != null && array_type.fixed_length) {
					// local fixed length arrays are not nullable
				} else {
					local.variable_type.nullable = true;
				}
			}
		}
	}

	public override void visit_initializer_list (InitializerList list) {
		list.accept_children (this);
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_if_statement (IfStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_switch_statement (SwitchStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_switch_section (SwitchSection section) {
		section.accept_children (this);
	}

	public override void visit_switch_label (SwitchLabel label) {
		label.accept_children (this);
	}

	public override void visit_loop (Loop stmt) {
		stmt.accept_children (this);
	}

	public override void visit_while_statement (WhileStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_do_statement (DoStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_for_statement (ForStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_foreach_statement (ForeachStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_return_statement (ReturnStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_yield_statement (YieldStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_throw_statement (ThrowStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_try_statement (TryStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_catch_clause (CatchClause clause) {
		clause.accept_children (this);
	}

	public override void visit_array_creation_expression (ArrayCreationExpression e) {
		e.accept_children (this);
	}

	public override void visit_template (Template tmpl) {
		tmpl.accept_children (this);
	}

	public override void visit_list_literal (ListLiteral lit) {
		lit.accept_children (this);
	}

	public override void visit_set_literal (SetLiteral lit) {
		lit.accept_children (this);
	}

	public override void visit_map_literal (MapLiteral lit) {
		lit.accept_children (this);
	}

	public override void visit_tuple (Tuple tuple) {
		tuple.accept_children (this);
	}

	public override void visit_member_access (MemberAccess expr) {
		expr.accept_children (this);
	}

	public override void visit_method_call (MethodCall expr) {
		expr.accept_children (this);
	}

	public override void visit_element_access (ElementAccess expr) {
		expr.accept_children (this);
	}

	public override void visit_slice_expression (SliceExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_postfix_expression (PostfixExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_sizeof_expression (SizeofExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_typeof_expression (TypeofExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_unary_expression (UnaryExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_cast_expression (CastExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_addressof_expression (AddressofExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_binary_expression (BinaryExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_type_check (TypeCheck expr) {
		expr.accept_children (this);
	}

	public override void visit_conditional_expression (ConditionalExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_lambda_expression (LambdaExpression l) {
		l.accept_children (this);
	}

	public override void visit_assignment (Assignment a) {
		a.accept_children (this);
	}
}
