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
		public bool memory_management { get; construct; }
		
		Symbol root_symbol;
		Symbol current_symbol;
		SourceFile current_source_file;
		
		List<NamespaceReference> current_using_directives;
		
		TypeReference bool_type;
		TypeReference string_type;
		
		public void analyze (CodeContext context) {
			root_symbol = context.root;

			bool_type = new TypeReference ();
			bool_type.type = (Type_) root_symbol.lookup ("bool").node;

			string_type = new TypeReference ();
			string_type.type = (Type_) root_symbol.lookup ("string").node;

			current_symbol = root_symbol;
			context.accept (this);
		}
		
		public override void visit_begin_source_file (SourceFile! file) {
			current_source_file = file;
			current_using_directives = file.get_using_directives ();
		}

		public override void visit_end_source_file (SourceFile! file) {
			current_using_directives = null;
		}

		public override void visit_begin_namespace (Namespace! ns) {
			current_symbol = ns.symbol;
		}

		public override void visit_end_namespace (Namespace! ns) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_begin_class (Class! cl) {
			current_symbol = cl.symbol;
			
			if (cl.base_class != null) {
				current_source_file.add_symbol_dependency (cl.base_class.symbol, SourceFileDependencyType.HEADER_FULL);
			}
		}

		public override void visit_end_class (Class! cl) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_begin_struct (Struct! st) {
			current_symbol = st.symbol;
		}

		public override void visit_end_struct (Struct! st) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_field (Field! f) {
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

		public override void visit_begin_method (Method! m) {
			current_symbol = m.symbol;
			
			if (m.return_type.type != null) {
				/* is null if it is void or a reference to a type parameter */
				current_source_file.add_symbol_dependency (m.return_type.type.symbol, SourceFileDependencyType.HEADER_SHALLOW);
			}
		}

		public override void visit_end_method (Method! m) {
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
								break;
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

		public override void visit_formal_parameter (FormalParameter! p) {
			if (!p.ellipsis) {
				if (p.type_reference.type != null) {
					/* is null if it references a type parameter */
					current_source_file.add_symbol_dependency (p.type_reference.type.symbol, SourceFileDependencyType.HEADER_SHALLOW);
					current_source_file.add_symbol_dependency (p.type_reference.type.symbol, SourceFileDependencyType.SOURCE);
				}
			}
		}

		public override void visit_end_property (Property! prop) {
			if (prop.type_reference.type != null) {
				/* is null if it references a type parameter */
				current_source_file.add_symbol_dependency (prop.type_reference.type.symbol, SourceFileDependencyType.HEADER_SHALLOW);
				current_source_file.add_symbol_dependency (prop.type_reference.type.symbol, SourceFileDependencyType.SOURCE);
			}
		}

		public override void visit_begin_constructor (Constructor! c) {
			current_symbol = c.symbol;
		}

		public override void visit_end_constructor (Constructor! c) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_begin_destructor (Destructor! d) {
			current_symbol = d.symbol;
		}

		public override void visit_end_destructor (Destructor! d) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_named_argument (NamedArgument! n) {
		}

		public override void visit_begin_block (Block! b) {
			current_symbol = b.symbol;
		}

		public override void visit_end_block (Block! b) {
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_variable_declarator (VariableDeclarator! decl) {
			if (decl.type_reference == null) {
				/* var type */
				decl.type_reference = decl.initializer.static_type.copy ();
				decl.type_reference.is_lvalue_ref = decl.type_reference.is_ref;
				decl.type_reference.is_ref = false;
			}
			
			if (decl.type_reference.type != null) {
				current_source_file.add_symbol_dependency (decl.type_reference.type.symbol, SourceFileDependencyType.SOURCE);
			}

			decl.symbol = new Symbol (node = decl);
			current_symbol.add (decl.name, decl.symbol);
			
			var block = (Block) current_symbol.node;
			block.add_local_variable (decl);
		}

		public override void visit_expression_statement (ExpressionStatement! stmt) {
			if (stmt.expression.static_type != null &&
			    stmt.expression.static_type.is_ref) {
				Report.warning (stmt.source_reference, "Short-living reference");
				return;
			}
		}

		public override void visit_begin_foreach_statement (ForeachStatement! stmt) {
			if (stmt.type_reference.type != null) {
				current_source_file.add_symbol_dependency (stmt.type_reference.type.symbol, SourceFileDependencyType.SOURCE);
			}
			
			var decl = new VariableDeclarator (name = stmt.variable_name);
			decl.type_reference = stmt.type_reference;
		
			stmt.symbol = new Symbol (node = decl);
			current_symbol.add (stmt.variable_name, stmt.symbol);
		}

		public override void visit_boolean_literal (BooleanLiteral! expr) {
			expr.static_type = bool_type;
		}

		public override void visit_character_literal (CharacterLiteral! expr) {
			expr.static_type = new TypeReference ();
			expr.static_type.type = (Type_) root_symbol.lookup ("char").node;
		}

		public override void visit_integer_literal (IntegerLiteral! expr) {
			expr.static_type = new TypeReference ();
			expr.static_type.type = (Type_) root_symbol.lookup ("int").node;
		}

		public override void visit_real_literal (IntegerLiteral! expr) {
			expr.static_type = new TypeReference ();
			expr.static_type.type = (Type_) root_symbol.lookup ("double").node;
		}

		public override void visit_string_literal (StringLiteral! expr) {
			expr.static_type = string_type;
		}

		public override void visit_null_literal (NullLiteral! expr) {
			/* empty TypeReference represents null */
			
			expr.static_type = new TypeReference ();
		}

		public override void visit_literal_expression (LiteralExpression! expr) {
			expr.static_type = expr.literal.static_type;
		}
		
		TypeReference get_static_type_for_node (CodeNode! node) {
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
		
		Symbol symbol_lookup_inherited (Symbol! sym, string! name) {
			var result = sym.lookup (name);
			if (result == null && sym.node is Class) {
				var cl = (Class) sym.node;
				for (cl = cl.base_class; cl != null && result == null; cl = cl.base_class) {
					result = cl.symbol.lookup (name);
				}
			}
			return result;
		}

		public override void visit_simple_name (SimpleName! expr) {
			var sym = current_symbol;
			while (sym != null && expr.symbol_reference == null) {
				expr.symbol_reference = symbol_lookup_inherited (sym, expr.name);
				sym = sym.parent_symbol;
			}

			if (expr.symbol_reference == null) {
				foreach (NamespaceReference ns in current_using_directives) {
					var local_sym = ns.namespace_symbol.lookup (expr.name);
					if (local_sym != null) {
						if (expr.symbol_reference != null) {
							Report.error (expr.source_reference, "`%s' is an ambiguous reference between `%s' and `%s'".printf (expr.name, expr.symbol_reference.get_full_name (), local_sym.get_full_name ()));
							return;
						}
						expr.symbol_reference = local_sym;
					}
				}
			}

			if (expr.symbol_reference == null) {
				Report.error (expr.source_reference, "The name `%s' does not exist in the context of `%s'".printf (expr.name, current_symbol.get_full_name ()));
				return;
			}

			current_source_file.add_symbol_dependency (expr.symbol_reference, SourceFileDependencyType.SOURCE);

			expr.static_type = get_static_type_for_node (expr.symbol_reference.node);
		}

		public override void visit_parenthesized_expression (ParenthesizedExpression! expr) {
			expr.static_type = expr.inner.static_type;
		}

		public override void visit_member_access (MemberAccess! expr) {
			if (expr.inner.static_type == null
			    && expr.inner.symbol_reference == null) {
				/* if there was an error in the inner expression, skip this check */
				return;
			}
		
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
					Report.error (expr.source_reference, "The name `%s' does not exist in the context of `%s'".printf (expr.member_name, expr.inner.static_type.to_string ()));
				}
				return;
			}
			
			current_source_file.add_symbol_dependency (expr.symbol_reference, SourceFileDependencyType.SOURCE);

			expr.static_type = get_static_type_for_node (expr.symbol_reference.node);
		}
		
		private bool is_type_compatible (TypeReference! expression_type, TypeReference! expected_type) {
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
			
			/* int may be implicitly casted to double */
			if (expression_type.type == root_symbol.lookup ("int").node && expected_type.type == root_symbol.lookup ("double").node) {
				return true;
			}
			
			/* char may be implicitly casted to unichar */
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
				if (base_class == expected_type.type) {
					return true;
				}
			}
			
			return false;
		}

		public override void visit_invocation_expression (InvocationExpression! expr) {
			if (expr.call.symbol_reference == null) {
				/* if method resolving didn't succeed, skip this check */
				return;
			}
		
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

				/* header file necessary if we need to cast argument */
				if (param.type_reference.type != null) {
					current_source_file.add_symbol_dependency (param.type_reference.type.symbol, SourceFileDependencyType.SOURCE);
				}

				if (arg_it == null) {
					if (param.default_expression == null) {
						Report.error (expr.source_reference, "Method `%s' does not take %d arguments".printf (m.symbol.get_full_name (), expr.argument_list.length ()));
						return;
					}
				} else {
					var arg = (Expression) arg_it.data;
					if (arg.static_type != null && !is_type_compatible (arg.static_type, param.type_reference)) {
						/* if there was an error in the argument,
						 * i.e. arg.static_type == null, skip type check */
						Report.error (expr.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.static_type.type.symbol.get_full_name (), param.type_reference.to_string ()));
						return;
					}
					
					arg_it = arg_it.next;

					i++;
				}
			}
			
			if (!ellipsis && arg_it != null) {
				Report.error (expr.source_reference, "Method `%s' does not take %d arguments".printf (m.symbol.get_full_name (), expr.argument_list.length ()));
				return;
			}
		}

		public override void visit_object_creation_expression (ObjectCreationExpression! expr) {
			if (expr.type_reference.type == null) {
				/* if type resolving didn't succeed, skip this check */
				return;
			}
		
			current_source_file.add_symbol_dependency (expr.type_reference.type.symbol, SourceFileDependencyType.SOURCE);

			expr.static_type = expr.type_reference;
			expr.static_type.is_ref = true;
		}

		public override void visit_unary_expression (UnaryExpression! expr) {
			if (expr.inner.static_type == null) {
				/* if there was an error in the inner expression, skip type check */
				return;
			}
		
			if (expr.operator == UnaryOperator.PLUS || expr.operator == UnaryOperator.MINUS) {
				// integer or floating point type

				expr.static_type = expr.inner.static_type;
			} else if (expr.operator == UnaryOperator.LOGICAL_NEGATION) {
				// boolean type

				expr.static_type = expr.inner.static_type;
			} else if (expr.operator == UnaryOperator.BITWISE_COMPLEMENT) {
				// integer type

				expr.static_type = expr.inner.static_type;
			} else if (expr.operator == UnaryOperator.REF) {
				// value type

				expr.static_type = expr.inner.static_type;
			} else if (expr.operator == UnaryOperator.OUT) {
				// reference type

				expr.static_type = expr.inner.static_type;
			} else {
				assert_not_reached ();
			}
		}

		public override void visit_cast_expression (CastExpression! expr) {
			if (expr.type_reference.type == null) {
				/* if type resolving didn't succeed, skip this check */
				return;
			}
		
			current_source_file.add_symbol_dependency (expr.type_reference.type.symbol, SourceFileDependencyType.SOURCE);

			expr.static_type = expr.type_reference;
		}
		
		private bool check_binary_type (BinaryExpression! expr, string! operation) {
			if (!is_type_compatible (expr.right.static_type, expr.left.static_type)) {
				Report.error (expr.source_reference, "%s: Cannot convert from `%s' to `%s'".printf (operation, expr.right.static_type.to_string (), expr.left.static_type.to_string ()));
				return false;
			}
			
			return true;
		}
		
		public override void visit_binary_expression (BinaryExpression! expr) {
			if (expr.left.static_type == null
			    || expr.right.static_type == null) {
				/* if there were any errors in inner expressions, skip type check */
				return;
			}
		
			if (expr.left.static_type.type == string_type.type
			    && expr.operator == BinaryOperator.PLUS) {
				if (expr.right.static_type.type != string_type.type) {
					Report.error (expr.source_reference, "Operands must be strings");
				}

				expr.static_type = string_type;
			} else if (expr.operator == BinaryOperator.PLUS
				   || expr.operator == BinaryOperator.MINUS
				   || expr.operator == BinaryOperator.MUL
				   || expr.operator == BinaryOperator.DIV) {
				// TODO: check for integer or floating point type in expr.left

				if (!check_binary_type (expr, "Arithmetic operation")) {
					return;
				}

				expr.static_type = expr.left.static_type;
			} else if (expr.operator == BinaryOperator.MOD
				   || expr.operator == BinaryOperator.SHIFT_LEFT
				   || expr.operator == BinaryOperator.SHIFT_RIGHT
				   || expr.operator == BinaryOperator.BITWISE_XOR) {
				// TODO: check for integer type in expr.left

				if (!check_binary_type (expr, "Arithmetic operation")) {
					return;
				}

				expr.static_type = expr.left.static_type;
			} else if (expr.operator == BinaryOperator.LESS_THAN
				   || expr.operator == BinaryOperator.GREATER_THAN
				   || expr.operator == BinaryOperator.LESS_THAN_OR_EQUAL
				   || expr.operator == BinaryOperator.GREATER_THAN_OR_EQUAL) {
				if (expr.left.static_type.type == string_type.type
				    && expr.right.static_type.type == string_type.type) {
					/* string comparison: convert to a.collate (b) OP 0 */
					
					var cmp_call = new InvocationExpression (call = new MemberAccess (inner = expr.left, member_name = "collate"));
					cmp_call.add_argument (expr.right);
					expr.left = cmp_call;
					
					expr.right = new LiteralExpression (literal = new IntegerLiteral (value = "0"));
					
					expr.left.accept (this);
				} else {
					/* TODO: check for integer or floating point type in expr.left */

					if (!check_binary_type (expr, "Relational operation")) {
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
					return false;
				}
				
				if (expr.left.static_type.type == string_type.type
				    && expr.right.static_type.type == string_type.type) {
					/* string comparison: convert to a.collate (b) OP 0 */
					
					var cmp_call = new InvocationExpression (call = new MemberAccess (inner = expr.left, member_name = "collate"));
					cmp_call.add_argument (expr.right);
					expr.left = cmp_call;
					
					expr.right = new LiteralExpression (literal = new IntegerLiteral (value = "0"));
					
					expr.left.accept (this);
				}

				expr.static_type = bool_type;
			} else if (expr.operator == BinaryOperator.BITWISE_AND
				   || expr.operator == BinaryOperator.BITWISE_OR) {
				// integer type or flags type

				expr.static_type = expr.left.static_type;
			} else if (expr.operator == BinaryOperator.AND
				   || expr.operator == BinaryOperator.OR) {
				if (expr.left.static_type.type != bool_type.type || expr.right.static_type.type != bool_type.type) {
					Report.error (expr.source_reference, "Operands must be boolean");
				}

				expr.static_type = bool_type;
			} else {
				assert_not_reached ();
			}
		}

		public override void visit_type_check (TypeCheck! expr) {
			if (expr.type_reference.type == null) {
				/* if type resolving didn't succeed, skip this check */
				return;
			}
		
			current_source_file.add_symbol_dependency (expr.type_reference.type.symbol, SourceFileDependencyType.SOURCE);

			expr.static_type = bool_type;
		}

		public override void visit_assignment (Assignment! a) {
			if (a.left.symbol_reference.node is Signal) {
				var sig = (Signal) a.left.symbol_reference.node;
			} else if (a.left.symbol_reference.node is Property) {
				var prop = (Property) a.left.symbol_reference.node;
			} else if (a.left.static_type != null && a.right.static_type != null) {
				 if (!is_type_compatible (a.right.static_type, a.left.static_type)) {
					/* if there was an error on either side,
					 * i.e. a.{left|right}.static_type == null, skip type check */
					Report.error (a.source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (a.right.static_type.to_string (), a.left.static_type.to_string ()));
					return;
				}
				
				if (memory_management) {
					if (a.right.static_type.is_ref) {
						/* rhs transfers ownership of the expression */
						if (!a.left.static_type.is_lvalue_ref) {
							/* lhs doesn't own the value
							 * promote lhs type if it is a local variable
							 * error if it's not a local variable */
							if (!(a.left.symbol_reference.node is VariableDeclarator)) {
								Report.error (a.source_reference, "Invalid assignment from owned expression to unowned variable");
							}
							
							a.left.static_type.is_lvalue_ref = true;
						}
					} else if (a.left.static_type.is_lvalue_ref) {
						/* lhs wants to own the value
						 * rhs doesn't transfer the ownership
						 * code generator needs to add reference
						 * increment calls */
					}
				}
			}
			
			a.static_type = a.left.static_type;
		}
	}
}
