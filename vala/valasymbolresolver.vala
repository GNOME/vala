/* valasymbolresolver.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter, Raffaele Sandrini
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
	public void resolve (CodeContext! context) {
		root_symbol = context.root;
		current_scope = root_symbol.scope;

		context.accept (this);
	}
	
	public override void visit_source_file (SourceFile! file) {
		current_using_directives = file.get_using_directives ();
		current_scope = root_symbol.scope;

		file.accept_children (this);

		current_using_directives = null;
	}
	
	public override void visit_class (Class! cl) {
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

	public override void visit_struct (Struct! st) {
		current_scope = st.scope;

		st.accept_children (this);

		current_scope = current_scope.parent_scope;
	}

	public override void visit_interface (Interface! iface) {
		current_scope = iface.scope;

		iface.accept_children (this);

		foreach (DataType type in iface.get_prerequisites ()) {
			if (type.data_type.is_subtype_of (iface)) {
				iface.error = true;
				Report.error (type.source_reference, "Prerequisite cycle (`%s' and `%s')".printf (iface.get_full_name (), type.data_type.get_full_name ()));
				return;
			}
		}

		current_scope = current_scope.parent_scope;
	}

	public override void visit_enum (Enum! en) {
		current_scope = en.scope;

		en.accept_children (this);

		current_scope = current_scope.parent_scope;
	}

	public override void visit_callback (Callback! cb) {
		current_scope = cb.scope;

		cb.accept_children (this);

		current_scope = current_scope.parent_scope;
	}

	public override void visit_constant (Constant! c) {
		current_scope = c.scope;

		c.accept_children (this);
	}

	public override void visit_field (Field! f) {
		current_scope = f.scope;

		f.accept_children (this);

		current_scope = current_scope.parent_scope;
	}

	public override void visit_method (Method! m) {
		current_scope = m.scope;

		m.accept_children (this);

		current_scope = current_scope.parent_scope;
	}

	public override void visit_creation_method (CreationMethod! m) {
		m.accept_children (this);
	}

	public override void visit_formal_parameter (FormalParameter! p) {
		p.accept_children (this);
	}

	public override void visit_property (Property! prop) {
		prop.accept_children (this);
	}

	public override void visit_property_accessor (PropertyAccessor! acc) {
		acc.accept_children (this);
	}

	public override void visit_signal (Signal! sig) {
		sig.accept_children (this);
	}

	public override void visit_constructor (Constructor! c) {
		c.accept_children (this);
	}

	public override void visit_destructor (Destructor! d) {
		d.accept_children (this);
	}

	public override void visit_block (Block! b) {
		b.accept_children (this);
	}

	public override void visit_namespace_reference (NamespaceReference! ns) {
		ns.namespace_symbol = current_scope.lookup (ns.name);
		if (ns.namespace_symbol == null) {
			ns.error = true;
			Report.error (ns.source_reference, "The namespace name `%s' could not be found".printf (ns.name));
			return;
		}
	}

	private DataType resolve_type (UnresolvedType! unresolved_type) {
		var type = new DataType ();
		type.source_reference = unresolved_type.source_reference;
		type.takes_ownership = unresolved_type.takes_ownership;
		type.transfers_ownership = unresolved_type.transfers_ownership;
		type.is_ref = unresolved_type.is_ref;
		type.is_out = unresolved_type.is_out;
		type.non_null = unresolved_type.non_null;
		foreach (DataType type_arg in unresolved_type.get_type_arguments ()) {
			type.add_type_argument (type_arg);
		}

		if (unresolved_type.type_name == null || unresolved_type.type_name == "void") {
			return type;
		}
		
		if (unresolved_type.namespace_name == null) {
			Symbol sym = null;
			Scope scope = current_scope;
			while (sym == null && scope != null) {
				sym = scope.lookup (unresolved_type.type_name);
				scope = scope.parent_scope;
				if (sym != null && !(sym is Typesymbol) && !(sym is TypeParameter)) {
					// ignore non-type symbols
					sym = null;
				}
			}
			if (sym == null) {
				foreach (NamespaceReference ns in current_using_directives) {
					if (ns.error) {
						continue;
					}

					var local_sym = ns.namespace_symbol.scope.lookup (unresolved_type.type_name);
					if (local_sym != null) {
						if (sym != null) {
							Report.error (type.source_reference, "`%s' is an ambiguous reference between `%s' and `%s'".printf (unresolved_type.type_name, sym.get_full_name (), local_sym.get_full_name ()));
							return null;
						}
						sym = local_sym;
					}
				}
			}
			if (sym == null) {
				Report.error (type.source_reference, "The type name `%s' could not be found".printf (unresolved_type.type_name));
				return null;
			}
			if (sym is TypeParameter) {
				type.type_parameter = (TypeParameter) sym;
			} else if (sym is Typesymbol) {
				type.data_type = (Typesymbol) sym;
			} else {
				Report.error (type.source_reference, "`%s' is not a type".printf (sym.get_full_name ()));
				return null;
			}
		} else {
			var ns_symbol = root_symbol.scope.lookup (unresolved_type.namespace_name);
			if (ns_symbol == null) {
				type.error = true;
				Report.error (type.source_reference, "The namespace name `%s' could not be found".printf (unresolved_type.namespace_name));
				return null;
			}
			
			var sym = ns_symbol.scope.lookup (unresolved_type.type_name);
			if (sym == null) {
				Report.error (type.source_reference, "The type name `%s' does not exist in the namespace `%s'".printf (unresolved_type.type_name, unresolved_type.namespace_name));
				return null;
			}
			if (sym is Typesymbol) {
				type.data_type = (Typesymbol) sym;
			} else {
				Report.error (type.source_reference, "`%s' is not a type".printf (sym.get_full_name ()));
				return null;
			}
		}

		if (unresolved_type.pointer_level > 0) {
			if (type.data_type == null) {
				type.error = true;
				Report.error (type.source_reference, "Pointer to `%s' not supported".printf (unresolved_type.type_name));
				return null;
			}
			var referent_type = new DataType ();
			referent_type.data_type = type.data_type;

			if (type.data_type.is_reference_type ()) {
				referent_type.takes_ownership = type.takes_ownership;
			}
			type.data_type = referent_type.data_type.get_pointer ();
			type.add_type_argument (referent_type);
		}

		/* check for array */
		if (unresolved_type.array_rank > 0) {
			var element_type = new DataType ();
			element_type.data_type = type.data_type;
			element_type.type_parameter = type.type_parameter;
			foreach (DataType type_arg in type.get_type_arguments ()) {
				element_type.add_type_argument (type_arg);
			}
			type.remove_all_type_arguments ();
			
			if (type.data_type != null) {
				if (type.data_type.is_reference_type ()) {
					element_type.takes_ownership = type.takes_ownership;
				}
				type.data_type = element_type.data_type.get_array (unresolved_type.array_rank);
			} else {
				element_type.takes_ownership = type.takes_ownership;
				type.data_type = element_type.type_parameter.get_array (unresolved_type.array_rank);
				type.type_parameter = null;
			}
			type.add_type_argument (element_type);
		}
		
		if (type.data_type != null && !type.data_type.is_reference_type ()) {
			/* reset takes_ownership and transfers_ownership of
			 * value-types for contexts where types are ref by
			 * default (field declarations and method return types)
			 */
			type.takes_ownership = false;
			type.transfers_ownership = false;
		}

		return type;
	}

	public override void visit_data_type (DataType! data_type) {
		if (!(data_type is UnresolvedType)) {
			return;
		}

		var unresolved_type = (UnresolvedType) data_type;

		var type = resolve_type (unresolved_type);
		if (type != null) {
			unresolved_type.parent_node.replace_type (unresolved_type, type);
		}
	}

	public override void visit_variable_declarator (VariableDeclarator! decl) {
		decl.accept_children (this);
	}

	public override void visit_initializer_list (InitializerList! list) {
		list.accept_children (this);
	}

	public override void visit_switch_section (SwitchSection! section) {
		section.accept_children (this);
	}

	public override void visit_foreach_statement (ForeachStatement! stmt) {
		stmt.accept_children (this);
	}

	public override void visit_return_statement (ReturnStatement! stmt) {
		stmt.accept_children (this);
	}

	public override void visit_throw_statement (ThrowStatement! stmt) {
		stmt.accept_children (this);
	}

	public override void visit_try_statement (TryStatement! stmt) {
		stmt.accept_children (this);
	}

	public override void visit_catch_clause (CatchClause! clause) {
		clause.accept_children (this);
	}

	public override void visit_array_creation_expression (ArrayCreationExpression! e) {
		e.accept_children (this);
	}

	public override void visit_invocation_expression (InvocationExpression! expr) {
		expr.accept_children (this);
	}

	public override void visit_object_creation_expression (ObjectCreationExpression! expr) {
		expr.accept_children (this);
	}

	public override void visit_lambda_expression (LambdaExpression! l) {
		l.accept_children (this);
	}

	public override void visit_assignment (Assignment! a) {
		a.accept_children (this);
	}
}
