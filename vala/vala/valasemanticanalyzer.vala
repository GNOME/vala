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
		TypeReference current_return_type;
		
		List<weak NamespaceReference> current_using_directives;
		
		TypeReference bool_type;
		TypeReference string_type;
		DataType initially_unowned_type;

		private int next_lambda_id = 0;
		
		public void analyze (CodeContext context) {
			root_symbol = context.get_root ();

			bool_type = new TypeReference ();
			bool_type.type = (DataType) root_symbol.lookup ("bool").node;

			string_type = new TypeReference ();
			string_type.type = (DataType) root_symbol.lookup ("string").node;
			
			var glib_ns = root_symbol.lookup ("GLib");
			
			initially_unowned_type = (DataType) glib_ns.lookup ("InitiallyUnowned").node;

			current_symbol = root_symbol;
			context.accept (this);
		}
		
		public override void visit_begin_source_file (SourceFile! file) {
			current_source_file = file;
			current_using_directives = file.get_using_directives ();
			
			next_lambda_id = 0;
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
			current_return_type = m.return_type;
			
			if (m.return_type.type != null) {
				/* is null if it is void or a reference to a type parameter */
				current_source_file.add_symbol_dependency (m.return_type.type.symbol, SourceFileDependencyType.HEADER_SHALLOW);
			}
		}

		public override void visit_end_method (Method! m) {
			current_symbol = current_symbol.parent_symbol;
			current_return_type = null;

			if (current_symbol.parent_symbol.node is Method) {
				/* lambda expressions produce nested methods */
				var up_method = (Method) current_symbol.parent_symbol.node;
				current_return_type = up_method.return_type;
			}
			
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
						/* FIXME: also look at interfaces implemented
						 * by one of the base types
						 */
						foreach (TypeReference type in cl.get_base_types ()) {
							if (type.type is Interface) {
								var iface = (Interface) type.type;
								var sym = iface.symbol.lookup (m.name);
								if (sym != null && sym.node is Method) {
									var base_method = (Method) sym.node;
									if (base_method.is_abstract || base_method.is_virtual) {
										m.base_method = base_method;
										break;
									}
								}
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

		public override void visit_begin_property_accessor (PropertyAccessor! acc) {
			var prop = (Property) acc.symbol.parent_symbol.node;
			
			if (acc.readable) {
				current_return_type = prop.type_reference;
			}
		}

		public override void visit_end_property_accessor (PropertyAccessor! acc) {
			current_return_type = null;
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
			foreach (VariableDeclarator decl in b.get_local_variables ()) {
				decl.symbol.active = false;
			}
		
			current_symbol = current_symbol.parent_symbol;
		}

		public override void visit_variable_declarator (VariableDeclarator! decl) {
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
				decl.type_reference.is_lvalue_ref = decl.type_reference.is_ref;
				decl.type_reference.is_ref = false;
			}
			
			if (decl.initializer != null) {
				if (decl.initializer.static_type == null) {
					if (!(decl.initializer is MemberAccess)) {
						decl.error = true;
						Report.error (decl.source_reference, "expression type not allowed as initializer");
						return;
					}
					
					if (decl.initializer.symbol_reference.node is Method &&
					    decl.type_reference.type is Callback) {
						var m = (Method) decl.initializer.symbol_reference.node;
						var cb = (Callback) decl.type_reference.type;
						
						/* check whether method matches callback type */
						if (!cb.matches_method (m)) {
							decl.error = true;
							Report.error (decl.source_reference, "declaration of method `%s' doesn't match declaration of callback `%s'".printf (m.symbol.get_full_name (), cb.symbol.get_full_name ()));
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
					if (decl.initializer.static_type.is_ref) {
						/* rhs transfers ownership of the expression */
						if (!decl.type_reference.is_lvalue_ref) {
							/* lhs doesn't own the value
							 * promote lhs type */
							
							decl.type_reference.is_lvalue_ref = true;
						}
					}
				}
			}
			
			if (decl.type_reference.type != null) {
				current_source_file.add_symbol_dependency (decl.type_reference.type.symbol, SourceFileDependencyType.SOURCE);
			}

			decl.symbol = new Symbol (node = decl);
			current_symbol.add (decl.name, decl.symbol);
			
			var block = (Block) current_symbol.node;
			block.add_local_variable (decl);
			
			decl.symbol.active = true;
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
			
			stmt.variable_declarator = new VariableDeclarator (name = stmt.variable_name);
			stmt.variable_declarator.type_reference = stmt.type_reference;
		
			stmt.variable_declarator.symbol = new Symbol (node = stmt.variable_declarator);
			current_symbol.add (stmt.variable_name, stmt.variable_declarator.symbol);
		}

		public override void visit_return_statement (ReturnStatement! stmt) {
			if (current_return_type == null) {
				Report.error (stmt.source_reference, "Return not allowed in this context");
				return;
			}
			
			if (stmt.return_expression == null && current_return_type.type != null) {
				Report.error (stmt.source_reference, "Return with value in void function");
				return;
			}
			
			if (stmt.return_expression != null && current_return_type.type == null) {
				Report.error (stmt.source_reference, "Return without value in non-void function");
				return;
			}
			
			if (stmt.return_expression != null &&
			     !is_type_compatible (stmt.return_expression.static_type, current_return_type)) {
				Report.error (stmt.source_reference, "Return: Cannot convert from `%s' to `%s'".printf (stmt.return_expression.static_type.to_string (), current_return_type.to_string ()));
				return;
			}
			
		}

		public override void visit_boolean_literal (BooleanLiteral! expr) {
			expr.static_type = bool_type;
		}

		public override void visit_character_literal (CharacterLiteral! expr) {
			expr.static_type = new TypeReference ();
			expr.static_type.type = (DataType) root_symbol.lookup ("char").node;
		}

		public override void visit_integer_literal (IntegerLiteral! expr) {
			expr.static_type = new TypeReference ();
			expr.static_type.type = (DataType) root_symbol.lookup ("int").node;
		}

		public override void visit_real_literal (IntegerLiteral! expr) {
			expr.static_type = new TypeReference ();
			expr.static_type.type = (DataType) root_symbol.lookup ("double").node;
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
		
		ref TypeReference get_static_type_for_node (CodeNode! node) {
			if (node is Field) {
				var f = (Field) node;
				return f.type_reference;
			} else if (node is Constant) {
				var c = (Constant) node;
				return c.type_reference;
			} else if (node is Property) {
				var prop = (Property) node;
				var type = prop.type_reference.copy ();
				type.is_lvalue_ref = false;
				return type;
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
				type.type = (DataType) node.symbol.parent_symbol.node;
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

		public override void visit_parenthesized_expression (ParenthesizedExpression! expr) {
			expr.static_type = expr.inner.static_type;
		}

		public override void visit_member_access (MemberAccess! expr) {
			Symbol base_symbol = null;

			if (expr.inner == null) {
				base_symbol = current_symbol;
			
				var sym = current_symbol;
				while (sym != null && expr.symbol_reference == null) {
					expr.symbol_reference = symbol_lookup_inherited (sym, expr.member_name);
					sym = sym.parent_symbol;
				}

				if (expr.symbol_reference == null) {
					foreach (NamespaceReference ns in current_using_directives) {
						var local_sym = ns.namespace_symbol.lookup (expr.member_name);
						if (local_sym != null) {
							if (expr.symbol_reference != null) {
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
					return;
				}
			
				if (expr.inner is MemberAccess) {
					var base = (MemberAccess) expr.inner;
					base_symbol = base.symbol_reference;
					if (base_symbol.node is Namespace ||
					    base_symbol.node is DataType) {
						expr.symbol_reference = base_symbol.lookup (expr.member_name);
					}
				}
				
				if (expr.symbol_reference == null && expr.inner.static_type != null) {
					base_symbol = expr.inner.static_type.type.symbol;
					expr.symbol_reference = symbol_lookup_inherited (base_symbol, expr.member_name);
				}
			}
				
			if (expr.symbol_reference == null) {
				expr.error = true;
				Report.error (expr.source_reference, "The name `%s' does not exist in the context of `%s'".printf (expr.member_name, base_symbol.get_full_name ()));
				return;
			}
			
			current_source_file.add_symbol_dependency (expr.symbol_reference, SourceFileDependencyType.SOURCE);

			expr.static_type = get_static_type_for_node (expr.symbol_reference.node);
		}
		
		private bool is_type_compatible (TypeReference! expression_type, TypeReference! expected_type) {
			/* only null is compatible to null */
			if (expected_type.type == null && expected_type.type_parameter == null) {
				return (expression_type.type == null && expected_type.type_parameter == null);
			}

			/* null can be casted to any reference or array type */
			if (expression_type.type == null &&
			    (expected_type.type_parameter != null ||
			     expected_type.type.is_reference_type () ||
			     expected_type.is_ref ||
			     expected_type.array)) {
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
			
			/* int may be implicitly casted to uint */
			if (expression_type.type == root_symbol.lookup ("int").node && expected_type.type == root_symbol.lookup ("uint").node) {
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

		public override void visit_begin_invocation_expression (InvocationExpression! expr) {
			if (expr.call.error) {
				/* if method resolving didn't succeed, skip this check */
				expr.error = true;
				return;
			}
			
			var msym = expr.call.symbol_reference;
			
			List<FormalParameter> params;
			
			if (msym.node is VariableDeclarator) {
				var decl = (VariableDeclarator) msym.node;
				if (decl.type_reference.type is Callback) {
					var cb = (Callback) decl.type_reference.type;
					params = cb.get_parameters ();
				} else {
					expr.error = true;
					Report.error (expr.source_reference, "invocation not supported in this context");
					return;
				}
			} else if (msym.node is FormalParameter) {
				var param = (FormalParameter) msym.node;
				if (param.type_reference.type is Callback) {
					var cb = (Callback) param.type_reference.type;
					params = cb.get_parameters ();
				} else {
					expr.error = true;
					Report.error (expr.source_reference, "invocation not supported in this context");
					return;
				}
			} else if (msym.node is Method) {
				var m = (Method) msym.node;
				params = m.parameters;
			} else {
				expr.error = true;
				Report.error (expr.source_reference, "invocation not supported in this context");
				return;
			}
		
			List arg_it = expr.argument_list;
			foreach (FormalParameter param in params) {
				if (param.ellipsis) {
					break;
				}
				
				if (arg_it != null) {
					var arg = (Expression) arg_it.data;

					/* store expected type for callback parameters */
					arg.expected_type = param.type_reference;
					
					arg_it = arg_it.next;
				}
			}
		}

		public override void visit_end_invocation_expression (InvocationExpression! expr) {
			if (expr.error) {
				return;
			}
			
			var msym = expr.call.symbol_reference;
			
			TypeReference ret_type;
			List<FormalParameter> params;
			
			if (msym.node is VariableDeclarator) {
				var decl = (VariableDeclarator) msym.node;
				var cb = (Callback) decl.type_reference.type;
				ret_type = cb.return_type;
				params = cb.get_parameters ();
			} else if (msym.node is FormalParameter) {
				var param = (FormalParameter) msym.node;
				var cb = (Callback) param.type_reference.type;
				ret_type = cb.return_type;
				params = cb.get_parameters ();
			} else if (msym.node is Method) {
				var m = (Method) msym.node;
				ret_type = m.return_type;
				params = m.parameters;
			}
		
			expr.static_type = ret_type;
			
			List arg_it = expr.argument_list;
			
			bool ellipsis = false;
			int i = 0;
			foreach (FormalParameter param in params) {
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
						Report.error (expr.source_reference, "Method `%s' does not take %d arguments".printf (msym.get_full_name (), expr.argument_list.length ()));
						return;
					}
				} else {
					var arg = (Expression) arg_it.data;
					if (arg.static_type != null && !is_type_compatible (arg.static_type, param.type_reference)) {
						/* if there was an error in the argument,
						 * i.e. arg.static_type == null, skip type check */
						Report.error (expr.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.static_type.to_string (), param.type_reference.to_string ()));
						return;
					}
					
					arg_it = arg_it.next;

					i++;
				}
			}
			
			if (!ellipsis && arg_it != null) {
				Report.error (expr.source_reference, "Method `%s' does not take %d arguments".printf (msym.get_full_name (), expr.argument_list.length ()));
				return;
			}
		}

		public override void visit_object_creation_expression (ObjectCreationExpression! expr) {
			if (expr.type_reference.type == null) {
				/* if type resolving didn't succeed, skip this check */
				return;
			}
		
			current_source_file.add_symbol_dependency (expr.type_reference.type.symbol, SourceFileDependencyType.SOURCE);

			expr.static_type = expr.type_reference.copy ();
			expr.static_type.is_ref = true;
			
			var cl = (Class) expr.type_reference.type;
			while (cl != null) {
				if (cl == initially_unowned_type) {
					expr.static_type.floating_reference = true;
					break;
				}
			
				cl = cl.base_class;
			}
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
					return;
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
		
		private ref string get_lambda_name () {
			var result = "__lambda%d".printf (next_lambda_id);

			next_lambda_id++;
			
			return result;
		}
		
		private Method find_current_method () {
			var sym = current_symbol;
			while (sym != null) {
				if (sym.node is Method) {
					return (Method) sym.node;
				}
				sym = sym.parent_symbol;
			}
			return null;
		}

		public override void visit_begin_lambda_expression (LambdaExpression! l) {
			if (l.expected_type == null || !(l.expected_type.type is Callback)) {
				l.error = true;
				Report.error (l.source_reference, "lambda expression not allowed in this context");
				return;
			}
			
			var current_method = find_current_method ();
			
			var cb = (Callback) l.expected_type.type;
			l.method = new Method (name = get_lambda_name (), return_type = cb.return_type);
			l.method.instance = cb.instance && current_method.instance;
			l.method.symbol = new Symbol (node = l.method);
			l.method.symbol.parent_symbol = current_symbol;
			
			var lambda_params = l.get_parameters ();
			var lambda_param_it = lambda_params;
			foreach (FormalParameter cb_param in cb.get_parameters ()) {
				if (lambda_param_it == null) {
					/* lambda expressions are allowed to have less parameters */
					break;
				}
				
				var lambda_param = (string) lambda_param_it.data;
				
				var param = new FormalParameter (name = lambda_param);
				param.type_reference = cb_param.type_reference;
				param.symbol = new Symbol (node = param);
				l.method.symbol.add (param.name, param.symbol);
				
				l.method.add_parameter (param);
				
				lambda_param_it = lambda_param_it.next;
			}
			
			if (lambda_param_it != null) {
				/* lambda expressions may not expect more parameters */
				l.error = true;
				Report.error (l.source_reference, "lambda expression: too many parameters");
				return;
			}
			
			var block = new Block ();
			block.symbol = new Symbol (node = block);
			block.symbol.parent_symbol = l.method.symbol;
			if (l.method.return_type.type != null) {
				block.add_statement (new ReturnStatement (return_expression = l.inner));
			} else {
				block.add_statement (new ExpressionStatement (expression = l.inner));
			}
			
			l.method.body = block;
			
			/* lambda expressions should be usable like MemberAccess of a method */
			l.symbol_reference = l.method.symbol;
		}

		public override void visit_begin_assignment (Assignment! a) {
			var ma = (MemberAccess) a.left;
			
			if (ma.symbol_reference.node is Signal) {
				var sig = (Signal) ma.symbol_reference.node;

				a.right.expected_type = new TypeReference ();
				a.right.expected_type.type = sig.get_callback ();
			}
		}

		public override void visit_end_assignment (Assignment! a) {
			if (!(a.left is MemberAccess)) {
				a.error = true;
				Report.error (a.source_reference, "unsupported lvalue in assignment");
				return;
			}
		
			var ma = (MemberAccess) a.left;
			
			if (ma.symbol_reference.node is Signal) {
				var sig = (Signal) ma.symbol_reference.node;
			} else if (ma.symbol_reference.node is Property) {
				var prop = (Property) ma.symbol_reference.node;
			} else if (ma.symbol_reference.node is VariableDeclarator && a.right.static_type == null) {
				var decl = (VariableDeclarator) ma.symbol_reference.node;
				
				var right_ma = (MemberAccess) a.right;
				if (right_ma.symbol_reference.node is Method &&
				    decl.type_reference.type is Callback) {
					var m = (Method) right_ma.symbol_reference.node;
					var cb = (Callback) decl.type_reference.type;
					
					/* check whether method matches callback type */
					if (!cb.matches_method (m)) {
						decl.error = true;
						Report.error (a.source_reference, "declaration of method `%s' doesn't match declaration of callback `%s'".printf (m.symbol.get_full_name (), cb.symbol.get_full_name ()));
						return;
					}
					
					a.right.static_type = decl.type_reference;
				} else {
					a.error = true;
					Report.error (a.source_reference, "Assignment: Invalid callback assignment attempt");
					return;
				}
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
							if (!(ma.symbol_reference.node is VariableDeclarator)) {
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
