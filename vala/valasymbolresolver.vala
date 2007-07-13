/* valasymbolresolver.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
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
 */

using GLib;

/**
 * Code visitor resolving symbol names.
 */
public class Vala.SymbolResolver : CodeVisitor {
	Symbol root_symbol;
	Symbol current_scope;
	List<weak NamespaceReference> current_using_directives;
	
	Class object_class;
	
	/**
	 * Resolve symbol names in the specified code context.
	 *
	 * @param context a code context
	 */
	public void resolve (CodeContext! context) {
		root_symbol = context.get_root ();
		current_scope = root_symbol;
		
		// TODO: don't require GLib namespace in symbol resolver
		var glib_ns = root_symbol.lookup ("GLib");
		if (glib_ns != null) {
			object_class = (Class) glib_ns.lookup ("Object").node;
		}
		
		context.accept (this);
	}
	
	public override void visit_source_file (SourceFile! file) {
		current_using_directives = file.get_using_directives ();

		file.accept_children (this);

		current_using_directives = null;
	}
	
	public override void visit_namespace (Namespace! ns) {
		current_scope = ns.symbol;

		ns.accept_children (this);

		// don't use current_scope.parent_symbol as that would be null
		// if the current namespace is SourceFile.global_namespace
		current_scope = root_symbol;
	}

	public override void visit_class (Class! cl) {
		current_scope = cl.symbol;

		cl.accept_children (this);

		foreach (TypeReference type in cl.get_base_types ()) {
			if (type.data_type is Class) {
				if (cl.base_class != null) {
					Report.error (type.source_reference, "%s: Classes cannot have multiple base classes (`%s' and `%s')".printf (cl.symbol.get_full_name (), cl.base_class.symbol.get_full_name (), type.data_type.symbol.get_full_name ()));
					return;
				}
				cl.base_class = (Class) type.data_type;
			}
		}
		if (cl.base_class == null && cl != object_class) {
			var object_type = new TypeReference ();
			object_type.data_type = object_class;
			cl.add_base_type (object_type);
			cl.base_class = object_class;
		}
	
		current_scope = current_scope.parent_symbol;
	}

	public override void visit_struct (Struct! st) {
		current_scope = st.symbol;

		st.accept_children (this);

		current_scope = current_scope.parent_symbol;
	}

	public override void visit_interface (Interface! iface) {
		current_scope = iface.symbol;

		iface.accept_children (this);

		current_scope = current_scope.parent_symbol;
	}

	public override void visit_enum (Enum! en) {
		current_scope = en.symbol;

		en.accept_children (this);

		current_scope = current_scope.parent_symbol;
	}

	public override void visit_callback (Callback! cb) {
		current_scope = cb.symbol;

		cb.accept_children (this);

		current_scope = current_scope.parent_symbol;
	}

	public override void visit_constant (Constant! c) {
		c.accept_children (this);
	}

	public override void visit_field (Field! f) {
		f.accept_children (this);
	}

	public override void visit_method (Method! m) {
		m.accept_children (this);
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

	public override void visit_namespace_reference (NamespaceReference! ns) {
		ns.namespace_symbol = current_scope.lookup (ns.name);
		if (ns.namespace_symbol == null) {
			ns.error = true;
			Report.error (ns.source_reference, "The namespace name `%s' could not be found".printf (ns.name));
			return;
		}
	}

	public override void visit_type_reference (TypeReference! type) {
		if (type.type_name == null || type.type_name == "void") {
			// reset transfers_ownership
			type.transfers_ownership = false;
			return;
		}
		
		if (type.namespace_name == null) {
			Symbol sym = null;
			Symbol scope = current_scope;
			while (sym == null && scope != null) {
				sym = scope.lookup (type.type_name);
				scope = scope.parent_symbol;
				if (sym != null && !(sym.node is DataType) && !(sym.node is TypeParameter)) {
					// ignore non-type symbols
					sym = null;
				}
			}
			if (sym == null) {
				foreach (NamespaceReference ns in current_using_directives) {
					if (ns.error) {
						continue;
					}

					var local_sym = ns.namespace_symbol.lookup (type.type_name);
					if (local_sym != null) {
						if (sym != null) {
							Report.error (type.source_reference, "`%s' is an ambiguous reference between `%s' and `%s'".printf (type.type_name, sym.get_full_name (), local_sym.get_full_name ()));
							return;
						}
						sym = local_sym;
					}
				}
			}
			if (sym == null) {
				Report.error (type.source_reference, "The type name `%s' could not be found".printf (type.type_name));
				return;
			}
			if (sym.node is TypeParameter) {
				type.type_parameter = (TypeParameter) sym.node;
			} else {
				type.data_type = (DataType) sym.node;
			}
		} else {
			var ns_symbol = root_symbol.lookup (type.namespace_name);
			if (ns_symbol == null) {
				type.error = true;
				Report.error (type.source_reference, "The namespace name `%s' could not be found".printf (type.namespace_name));
				return;
			}
			
			var sym = ns_symbol.lookup (type.type_name);
			if (sym == null) {
				Report.error (type.source_reference, "The type name `%s' does not exist in the namespace `%s'".printf (type.type_name, type.namespace_name));
				return;
			}
			type.data_type = (DataType) sym.node;
		}

		if (type.pointer_level > 0) {
			if (type.data_type == null) {
				type.error = true;
				Report.error (type.source_reference, "Pointer to `%s' not supported".printf (type.type_name));
				return;
			}
			var referent_type = new TypeReference ();
			referent_type.data_type = type.data_type;
			referent_type.pointer_level = type.pointer_level - 1;

			if (type.data_type.is_reference_type ()) {
				referent_type.takes_ownership = type.takes_ownership;
			}
			type.data_type = referent_type.data_type.get_pointer ();
			type.add_type_argument (referent_type);
			
			visit_type_reference (referent_type);
		}

		/* check for array */
		if (type.array_rank > 0) {
			var element_type = new TypeReference ();
			element_type.data_type = type.data_type;
			element_type.type_parameter = type.type_parameter;
			foreach (TypeReference type_arg in type.get_type_arguments ()) {
				element_type.add_type_argument (type_arg);
			}
			type.remove_all_type_arguments ();
			
			if (type.data_type != null) {
				if (type.data_type.is_reference_type ()) {
					element_type.takes_ownership = type.takes_ownership;
				}
				type.data_type = element_type.data_type.get_array (type.array_rank);
			} else {
				type.data_type = element_type.type_parameter.get_array (type.array_rank);
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
}
