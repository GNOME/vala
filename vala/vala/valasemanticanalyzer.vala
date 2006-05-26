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
		Symbol root_symbol;
		Symbol current_symbol;
		SourceFile current_source_file;
		
		List<NamespaceReference> current_using_directives;
	
		public void analyze (CodeContext context) {
			root_symbol = context.root;
			current_symbol = root_symbol;
			context.accept (this);
		}
		
		public override void visit_begin_source_file (SourceFile file) {
			current_source_file = file;
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
			
			if (cl.base_class != null) {
				current_source_file.add_symbol_dependency (cl.base_class.symbol, SourceFileDependencyType.HEADER_FULL);
			}
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

		public override void visit_field (Field f) {
			if (f.access == MemberAccessibility.PUBLIC) {
				if (f.type_reference.type != null) {
					/* is null if it references a type parameter */
					current_source_file.add_symbol_dependency (f.type_reference.type.symbol, SourceFileDependencyType.HEADER_SHALLOW);
				}
			} else {
				if (f.type_reference.type != null) {
					/* is null if it references a type parameter */
					current_source_file.add_symbol_dependency (f.type_reference.type.symbol, SourceFileDependencyType.SOURCE);
				}
			}
		}

		public override void visit_begin_method (Method m) {
			current_symbol = m.symbol;
			
			if (m.return_type.type != null) {
				/* is null if it is void or a reference to a type parameter */
				current_source_file.add_symbol_dependency (m.return_type.type.symbol, SourceFileDependencyType.HEADER_SHALLOW);
			}
		}

		public override void visit_end_method (Method m) {
			current_symbol = current_symbol.parent_symbol;
			
			if (m.is_virtual || m.is_override) {
				if (current_symbol.node is Class) {
					var cl = (Class) current_symbol.node;
					Class base_class;
					for (base_class = cl; base_class != null; base_class = base_class.base_class) {
						var sym = base_class.symbol.lookup (m.name);
						if (sym != null && sym.node is Method) {
							var base_method = (Method) sym.node;
							if (base_method.is_abstract || base_method.is_virtual) {
								m.base_method = base_method;
								//break;
							}
						}
					}
					if (m.base_method == null) {
						Report.error (m.source_reference, "%s: no suitable method found to override".printf (m.symbol.get_full_name ()));
					}
				} else if (current_symbol.node is Struct) {
					Report.error (m.source_reference, "A struct member `%s' cannot be marked as override, virtual, or abstract".printf (m.symbol.get_full_name ()));
					return;
				}
			}
		}

		public override void visit_formal_parameter (FormalParameter p) {
			if (!p.ellipsis) {
				if (p.type_reference.type != null) {
					/* is null if it references a type parameter */
					current_source_file.add_symbol_dependency (p.type_reference.type.symbol, SourceFileDependencyType.HEADER_SHALLOW);
				}
			}
		}

		public override void visit_end_property (Property prop) {
			if (prop.type_reference.type != null) {
				/* is null if it references a type parameter */
				current_source_file.add_symbol_dependency (prop.type_reference.type.symbol, SourceFileDependencyType.HEADER_SHALLOW);
			}
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
			
			if (decl.type_reference.type != null) {
				current_source_file.add_symbol_dependency (decl.type_reference.type.symbol, SourceFileDependencyType.SOURCE);
			}

			decl.symbol = new Symbol (node = decl);
			current_symbol.add (decl.name, decl.symbol);
		}

		public override void visit_begin_foreach_statement (ForeachStatement stmt) {
			if (stmt.type_reference.type != null) {
				current_source_file.add_symbol_dependency (stmt.type_reference.type.symbol, SourceFileDependencyType.SOURCE);
			}
		
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
			expr.static_type = new TypeReference ();
		}

		public override void visit_literal_expression (LiteralExpression expr) {
			expr.static_type = expr.literal.static_type;
		}
		
		TypeReference get_static_type_for_node (CodeNode node) {
			if (node is Field) {
				var f = (Field) node;
				return f.type_reference;
			} else if (node is Constant) {
				var c = (Constant) node;
				return c.type_reference;
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
			} else if (node is EnumValue) {
				var type = new TypeReference ();
				type.type = (Type_) node.symbol.parent_symbol.node;
				return type;
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
						Report.error (expr.source_reference, "`%s' is an ambiguous reference between `%s' and `%s'".printf (expr.name, expr.symbol_reference.get_full_name (), local_sym.get_full_name ()));
						return;
					}
					expr.symbol_reference = local_sym;
				}
			}

			if (expr.symbol_reference == null) {
				Report.error (expr.source_reference, "The name `%s' does not exist in the context of `%s'".printf (expr.name, current_symbol.get_full_name ()));
				return;
			}

			current_source_file.add_symbol_dependency (expr.symbol_reference, SourceFileDependencyType.SOURCE);

			expr.static_type = get_static_type_for_node (expr.symbol_reference.node);
		}

		public override void visit_parenthesized_expression (ParenthesizedExpression expr) {
			expr.static_type = expr.inner.static_type;
		}

		public override void visit_member_access (MemberAccess expr) {
			if (expr.inner.static_type == null) {
				if (expr.inner.symbol_reference.node is Namespace || expr.inner.symbol_reference.node is Type_) {
					expr.symbol_reference = expr.inner.symbol_reference.lookup (expr.member_name);
				}
			}
			
			if (expr.symbol_reference == null && expr.inner.static_type != null) {
				expr.symbol_reference = symbol_lookup_inherited (expr.inner.static_type.type.symbol, expr.member_name);
			}
			
			if (expr.symbol_reference == null) {
				if (expr.inner.static_type == null) {
					Report.error (expr.source_reference, "The name `%s' does not exist in the context of `%s'".printf (expr.member_name, expr.inner.symbol_reference.get_full_name ()));
				} else {
					Report.error (expr.source_reference, "The name `%s' does not exist in the context of `%s'".printf (expr.member_name, expr.inner.static_type.type.symbol.get_full_name ()));
				}
				return;
			}
			
			current_source_file.add_symbol_dependency (expr.symbol_reference, SourceFileDependencyType.SOURCE);

			expr.static_type = get_static_type_for_node (expr.symbol_reference.node);
		}
		
		private bool is_type_compatible (TypeReference expression_type, TypeReference expected_type) {
			/* null can be casted to any reference or array type */
			if (expression_type.type == null && (expected_type.type.is_reference_type () || expected_type.array)) {
				return true;
			}
			
			/* temporarily ignore type parameters */
			if (expected_type.type_parameter != null) {
				return true;
			}
			
			if (expression_type.array != expected_type.array) {
				return false;
			}
			
			if (expression_type.type == expected_type.type) {
				return true;
			}
			
			/* int may be implicitly casted to long */
			if (expression_type.type == root_symbol.lookup ("int").node && expected_type.type == root_symbol.lookup ("long").node) {
				return true;
			}
			
			/* int may be implicitly casted to long */
			if (expression_type.type == root_symbol.lookup ("char").node && expected_type.type == root_symbol.lookup ("unichar").node) {
				return true;
			}
			
			/* non-class types must match exactly */
			if (!(expression_type.type is Class)) {
				return false;
			}
			
			var cl = (Class) expression_type.type;
			
			var base_class = cl.base_class;
			for (; base_class != null; base_class = base_class.base_class) {
				if (base_class == expected_type) {
					return true;
				}
			}
			
			return true;
		}

		public override void visit_invocation_expression (InvocationExpression expr) {
			var m = (Method) expr.call.symbol_reference.node;
			expr.static_type = m.return_type;
			
			List arg_it = expr.argument_list;
			
			bool ellipsis = false;
			int i = 0;
			foreach (FormalParameter param in m.parameters) {
				if (param.ellipsis) {
					ellipsis = true;
					break;
				}

				if (arg_it == null) {
					/* if (param.default_argument) { } */
					Report.error (expr.source_reference, "Method `%s' does not take %d arguments".printf (m.symbol.get_full_name (), expr.argument_list.length ()));
					return;
				}
				
				var arg = (Expression) arg_it.data;
				if (!is_type_compatible (arg.static_type, param.type_reference)) {
					Report.warning (expr.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.static_type.type.symbol.get_full_name (), param.type_reference.type.symbol.get_full_name ()));
					return;
				}
				
				arg_it = arg_it.next;

				i++;
			}
			
			if (!ellipsis && arg_it != null) {
				Report.warning (expr.source_reference, "Method `%s' does not take %d arguments".printf (m.symbol.get_full_name (), expr.argument_list.length ()));
				return;
			}
		}

		public override void visit_object_creation_expression (ObjectCreationExpression expr) {
			current_source_file.add_symbol_dependency (expr.type_reference.type.symbol, SourceFileDependencyType.SOURCE);

			expr.static_type = expr.type_reference;
		}

		public override void visit_unary_expression (UnaryExpression expr) {
			expr.static_type = expr.inner.static_type;
		}

		public override void visit_cast_expression (CastExpression expr) {
			current_source_file.add_symbol_dependency (expr.type_reference.type.symbol, SourceFileDependencyType.SOURCE);

			expr.static_type = expr.type_reference;
		}

		public override void visit_binary_expression (BinaryExpression expr) {
			expr.static_type = expr.left.static_type;
		}

		public override void visit_type_check (TypeCheck expr) {
			current_source_file.add_symbol_dependency (expr.type_reference.type.symbol, SourceFileDependencyType.SOURCE);

			expr.static_type = new TypeReference ();
			expr.static_type.type = (Type_) root_symbol.lookup ("bool").node;
		}
	}
}
