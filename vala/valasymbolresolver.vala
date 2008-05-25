/* valasymbolresolver.vala
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
 * 	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;
using Gee;

/**
 * Code visitor resolving symbol names.
 */
public class Vala.SymbolResolver : CodeVisitor {
	Symbol root_symbol;
	Scope current_scope;
	Collection<NamespaceReference> current_using_directives;
	
	/**
	 * Resolve symbol names in the specified code context.
	 *
	 * @param context a code context
	 */
	public void resolve (CodeContext context) {
		root_symbol = context.root;
		current_scope = root_symbol.scope;

		context.accept (this);
	}
	
	public override void visit_source_file (SourceFile file) {
		current_using_directives = file.get_using_directives ();
		current_scope = root_symbol.scope;

		file.accept_children (this);

		current_using_directives = null;
	}
	
	public override void visit_class (Class cl) {
		current_scope = cl.scope;

		cl.accept_children (this);

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

		current_scope = current_scope.parent_scope;
	}

	public override void visit_struct (Struct st) {
		current_scope = st.scope;

		st.accept_children (this);

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
		current_scope = c.scope;

		c.accept_children (this);
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

	public override void visit_formal_parameter (FormalParameter p) {
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

	public override void visit_namespace_reference (NamespaceReference ns) {
		ns.namespace_symbol = current_scope.lookup (ns.name);
		if (ns.namespace_symbol == null) {
			ns.error = true;
			Report.error (ns.source_reference, "The namespace name `%s' could not be found".printf (ns.name));
			return;
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
				scope = scope.parent_scope;
			}
			if (sym == null) {
				foreach (NamespaceReference ns in current_using_directives) {
					if (ns.error) {
						continue;
					}

					var local_sym = ns.namespace_symbol.scope.lookup (unresolved_symbol.name);
					if (local_sym != null) {
						if (sym != null) {
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

			return parent_symbol.scope.lookup (unresolved_symbol.name);
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
			type = new TypeParameterType ((TypeParameter) sym);
		} else if (sym is Typesymbol) {
			if (sym is Delegate) {
				type = new DelegateType ((Delegate) sym);
			} else if (sym is Class) {
				var cl = (Class) sym;
				if (cl.is_error_base) {
					type = new ErrorType (null, unresolved_type.source_reference);
				} else {
					type = new ClassInstanceType (cl);
				}
			} else if (sym is Interface) {
				type = new InterfaceInstanceType ((Interface) sym);
			} else if (sym is Struct) {
				type = new ValueType ((Struct) sym);
			} else if (sym is Enum) {
				type = new ValueType ((Enum) sym);
			} else if (sym is ErrorDomain) {
				type = new ErrorType ((ErrorDomain) sym, unresolved_type.source_reference);
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
		type.nullable = unresolved_type.nullable;
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

	public override void visit_local_variable (LocalVariable local) {
		local.accept_children (this);
		if (local.variable_type is ReferenceType) {
			local.variable_type.nullable = true;
		}
	}

	public override void visit_initializer_list (InitializerList list) {
		list.accept_children (this);
	}

	public override void visit_if_statement (IfStatement stmt) {
		stmt.accept_children (this);
	}

	public override void visit_switch_section (SwitchSection section) {
		section.accept_children (this);
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

	public override void visit_parenthesized_expression (ParenthesizedExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_invocation_expression (InvocationExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_object_creation_expression (ObjectCreationExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_reference_transfer_expression (ReferenceTransferExpression expr) {
		expr.accept_children (this);
	}

	public override void visit_lambda_expression (LambdaExpression l) {
		l.accept_children (this);
	}

	public override void visit_assignment (Assignment a) {
		a.accept_children (this);
	}
}
