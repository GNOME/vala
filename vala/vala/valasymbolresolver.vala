/* valasymbolresolver.vala
 *
 * Copyright (C) 2006  Jürg Billeter
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

namespace Vala {
	public class SymbolResolver : CodeVisitor {
		Symbol root_symbol;
		Symbol current_scope;
		List<NamespaceReference> current_using_directives;
		
		public void resolve (CodeContext context) {
			root_symbol = context.root;
			current_scope = root_symbol;
			context.accept (this);
		}
		
		public override void visit_begin_source_file (SourceFile file) {
			current_using_directives = file.get_using_directives ();
		}

		public override void visit_end_source_file (SourceFile file) {
			current_using_directives = null;
		}
		
		public override void visit_begin_namespace (Namespace ns) {
			current_scope = ns.symbol;
		}

		public override void visit_end_namespace (Namespace ns) {
			current_scope = current_scope.parent_symbol;
		}

		public override void visit_begin_class (Class cl) {
			current_scope = cl.symbol;
		}

		public override void visit_end_class (Class cl) {
			foreach (TypeReference type in cl.base_types) {
				if (type.type is Class) {
					if (cl.base_class != null) {
						stderr.printf ("error: multiple base classes specified\n");
					}
					cl.base_class = type.type;
				}
			}
		
			current_scope = current_scope.parent_symbol;
		}

		public override void visit_begin_struct (Struct st) {
			current_scope = st.symbol;
		}

		public override void visit_end_struct (Struct st) {
			current_scope = current_scope.parent_symbol;
		}

		public override void visit_namespace_reference (NamespaceReference ns) {
			ns.namespace_symbol = current_scope.lookup (ns.name);
			if (ns.namespace_symbol == null) {
				// raise error, namespace not found
				stderr.printf ("namespace %s not found\n", ns.name);
			}
		}

		public override void visit_type_reference (TypeReference type) {
			if (type.type_name.cmp ("void") == 0) {
				return;
			}
			
			if (type.namespace_name == null) {
				Symbol sym = null;
				Symbol scope = current_scope;
				while (sym == null && scope != null) {
					sym = scope.lookup (type.type_name);
					scope = scope.parent_symbol;
				}
				if (sym == null) {
					foreach (NamespaceReference ns in current_using_directives) {
						var local_sym = ns.namespace_symbol.lookup (type.type_name);
						if (sym != null && local_sym != null) {
							// raise error
							stderr.printf ("error: ambiguous type name %s\n", type.type_name);
						}
						sym = local_sym;
					}
				}
				if (sym == null) {
					// raise error, type not found
					stderr.printf ("error: type %s not found\n", type.type_name);
				}
				if (sym.node is TypeParameter) {
					type.type_parameter = sym.node;
				} else {
					type.type = (Type_) sym.node;
				}
			} else {
				var ns_symbol = root_symbol.lookup (type.namespace_name);
				if (ns_symbol == null) {
					// raise error
					stderr.printf ("error: namespace ´%s´ not found\n", type.namespace_name);
				}
				
				var sym = ns_symbol.lookup (type.type_name);
				if (sym == null) {
					// raise error
					stderr.printf ("error: symbol ´%s´ not found in namespace ´%s´\n", type.type_name, type.namespace_name);
				}
				type.type = (Type_) sym.node;
			}
		}
	}
}
