/* valasemanticanalyzer.vala
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
	public class SemanticAnalyzer : CodeVisitor {
		ref Symbol root_symbol;
		ref Symbol current_symbol;
		
		List<NamespaceReference> current_using_directives;
		TypeReference dummy; // required for broken dependency handlind
	
		public void analyze (CodeContext context) {
			root_symbol = context.root;
			current_symbol = root_symbol;
			context.accept (this);
		}
		
		public override void visit_begin_source_file (SourceFile file) {
			current_using_directives = file.get_using_directives ();
		}

		public override void visit_end_source_file (SourceFile file) {
			current_using_directives = null;
		}

		public override void visit_begin_namespace (Namespace ns) {
			current_symbol = ns.symbol;
		}

		public override void visit_end_namespace (Namespace ns) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_begin_class (Class cl) {
			current_symbol = cl.symbol;
		}

		public override void visit_end_class (Class cl) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_begin_struct (Struct st) {
			current_symbol = st.symbol;
		}

		public override void visit_end_struct (Struct st) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_begin_method (Method m) {
			current_symbol = m.symbol;
		}

		public override void visit_end_method (Method m) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_named_argument (NamedArgument n) {
		}

		public override void visit_begin_block (Block b) {
			current_symbol = b.symbol;
		}

		public override void visit_end_block (Block b) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_variable_declarator (VariableDeclarator decl) {
			if (decl.type_reference == null) {
				/* var type */
				decl.type_reference = decl.initializer.static_type;
			}

			decl.symbol = new Symbol (node = decl);
			current_symbol.add (decl.name, decl.symbol);
		}

		public override void visit_begin_foreach_statement (ForeachStatement stmt) {
			stmt.symbol = new Symbol (node = stmt.type_reference);
			current_symbol.add (stmt.variable_name, stmt.symbol);
		}

		public override void visit_boolean_literal (BooleanLiteral expr) {
			expr.static_type = new TypeReference ();
			expr.static_type.type = (Type_) root_symbol.lookup ("bool").node;
		}

		public override void visit_character_literal (CharacterLiteral expr) {
			expr.static_type = new TypeReference ();
			expr.static_type.type = (Type_) root_symbol.lookup ("char").node;
		}

		public override void visit_integer_literal (IntegerLiteral expr) {
			expr.static_type = new TypeReference ();
			expr.static_type.type = (Type_) root_symbol.lookup ("int").node;
		}

		public override void visit_string_literal (StringLiteral expr) {
			expr.static_type = new TypeReference ();
			expr.static_type.type = (Type_) root_symbol.lookup ("string").node;
		}

		public override void visit_null_literal (NullLiteral expr) {
		}

		public override void visit_literal_expression (LiteralExpression expr) {
			expr.static_type = expr.literal.static_type;
		}
		
		TypeReference get_static_type_for_node (CodeNode node) {
			if (node is Field) {
				var f = (Field) node;
				return f.type_reference;
			} else if (node is Property) {
				var prop = (Property) node;
				return prop.type_reference;
			} else if (node is FormalParameter) {
				var p = (FormalParameter) node;
				return p.type_reference;
			} else if (node is TypeReference) {
				return (TypeReference) node;
			} else if (node is VariableDeclarator) {
				var decl = (VariableDeclarator) node;
				return decl.type_reference;
			}
			return null;
		}
		
		Symbol symbol_lookup_inherited (Symbol sym, string name) {
			var result = sym.lookup (name);
			if (result == null && sym.node is Class) {
				var cl = (Class) sym.node;
				for (cl = cl.base_class; cl != null && result == null; cl = cl.base_class) {
					result = cl.symbol.lookup (name);
				}
			}
			return result;
		}

		public override void visit_simple_name (SimpleName expr) {
			var sym = current_symbol;
			while (sym != null && expr.symbol_reference == null) {
				expr.symbol_reference = symbol_lookup_inherited (sym, expr.name);
				sym = sym.parent_symbol;
			}

			if (expr.symbol_reference == null) {
				foreach (NamespaceReference ns in current_using_directives) {
					var local_sym = ns.namespace_symbol.lookup (expr.name);
					if (expr.symbol_reference != null && local_sym != null) {
						// raise error
						stderr.printf ("ambiguous symbol name %s\n", expr.name);
					}
					expr.symbol_reference = local_sym;
				}
			}

			if (expr.symbol_reference == null) {
				stderr.printf ("symbol ´%s´ not found\n", expr.name);
			}

			expr.static_type = get_static_type_for_node (expr.symbol_reference.node);
		}

		public override void visit_parenthesized_expression (ParenthesizedExpression expr) {
			expr.static_type = expr.inner.static_type;
		}

		public override void visit_member_access (MemberAccess expr) {
			if (expr.inner.static_type == null) {
				if (expr.inner.symbol_reference.node is Type_) {
					expr.symbol_reference = expr.inner.symbol_reference.lookup (expr.member_name);
				}
			}
			
			if (expr.symbol_reference == null) {
				expr.symbol_reference = symbol_lookup_inherited (expr.inner.static_type.type.symbol, expr.member_name);
			}
			
			if (expr.symbol_reference == null) {
				stderr.printf ("%s: member ´%s´ not found\n", expr.source_reference.to_string (), expr.member_name);
			}
			
			expr.static_type = get_static_type_for_node (expr.symbol_reference.node);
		}

		public override void visit_invocation_expression (InvocationExpression expr) {
			var m = (Method) expr.call.symbol_reference.node;
			expr.static_type = m.return_type;
		}

		public override void visit_object_creation_expression (ObjectCreationExpression expr) {
			expr.static_type = expr.type_reference;
		}

		public override void visit_cast_expression (CastExpression expr) {
			expr.static_type = expr.type_reference;
		}
	}
}
