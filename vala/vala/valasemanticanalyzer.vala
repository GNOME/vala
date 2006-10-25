/* valasemanticanalyzer.vala
 *
 * Copyright (C) 2006  Jürg Billeter, Raffaele Sandrini
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
 *	Raffaele Sandrini <rasa@gmx.ch>
 */

using GLib;

/**
 * Code visitor analyzing and checking code.
 */
public class Vala.SemanticAnalyzer : CodeVisitor {
	/**
	 * Specifies whether automatic memory management is active.
	 */
	public bool memory_management { get; set; }
	
	Symbol root_symbol;
	Symbol current_symbol;
	SourceFile current_source_file;
	TypeReference current_return_type;
	Class current_class;
	
	List<weak NamespaceReference> current_using_directives;
	
	TypeReference bool_type;
	TypeReference string_type;
	TypeReference int_type;
	TypeReference type_type;
	DataType pointer_type;
	DataType initially_unowned_type;

	private int next_lambda_id = 0;
	
	public construct (bool manage_memory = true) {
		memory_management = manage_memory;
	}
	
	/**
	 * Analyze and check code in the specified context.
	 *
	 * @param context a code context
	 */
	public void analyze (CodeContext! context) {
		root_symbol = context.get_root ();

		bool_type = new TypeReference ();
		bool_type.data_type = (DataType) root_symbol.lookup ("bool").node;

		string_type = new TypeReference ();
		string_type.data_type = (DataType) root_symbol.lookup ("string").node;

		pointer_type = (DataType) root_symbol.lookup ("pointer").node;
		
		int_type = new TypeReference ();
		int_type.data_type = (DataType) root_symbol.lookup ("int").node;
		
		var glib_ns = root_symbol.lookup ("GLib");
		
		initially_unowned_type = (DataType) glib_ns.lookup ("InitiallyUnowned").node;
		
		type_type = new TypeReference ();
		type_type.data_type = (DataType) glib_ns.lookup ("Type").node;

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
		current_class = cl;
		
		if (cl.base_class != null) {
			current_source_file.add_symbol_dependency (cl.base_class.symbol, SourceFileDependencyType.HEADER_FULL);
		}
		
		foreach (TypeReference base_type_reference in cl.get_base_types ()) {
			current_source_file.add_symbol_dependency (base_type_reference.data_type.symbol, SourceFileDependencyType.HEADER_FULL);
		}
	}

	public override void visit_end_class (Class! cl) {
		current_symbol = current_symbol.parent_symbol;
	}

	public override void visit_begin_struct (Struct! st) {
		current_symbol = st.symbol;
		current_class = null;
	}

	public override void visit_end_struct (Struct! st) {
		current_symbol = current_symbol.parent_symbol;
	}
	
	public override void visit_constant (Constant! c) {
		if (!current_source_file.pkg) {
			if (c.initializer == null) {
				c.error = true;
				Report.error (c.source_reference, "A const field requires a initializer to be provided");
			}
		}
	}

	public override void visit_field (Field! f) {
		if (f.access != MemberAccessibility.PRIVATE) {
			if (f.type_reference.data_type != null) {
				/* is null if it references a type parameter */
				current_source_file.add_symbol_dependency (f.type_reference.data_type.symbol, SourceFileDependencyType.HEADER_SHALLOW);
			}
		} else {
			if (f.type_reference.data_type != null) {
				/* is null if it references a type parameter */
				current_source_file.add_symbol_dependency (f.type_reference.data_type.symbol, SourceFileDependencyType.SOURCE);
			}
		}
	}

	public override void visit_begin_method (Method! m) {
		if (m.construction) {
			m.return_type = new TypeReference ();
			m.return_type.data_type = (DataType) current_symbol.node;
			m.return_type.transfers_ownership = true;
			
			if (current_symbol.node is Class) {
				// check for floating reference
				var cl = (Class) current_symbol.node;
				while (cl != null) {
					if (cl == initially_unowned_type) {
						m.return_type.floating_reference = true;
						break;
					}
				
					cl = cl.base_class;
				}
			}
			
			if (m.body != null) {
				m.body.construction = true;
			}
		}
	
		current_symbol = m.symbol;
		current_return_type = m.return_type;
		
		if (m.return_type.data_type != null) {
			/* is null if it is void or a reference to a type parameter */
			current_source_file.add_symbol_dependency (m.return_type.data_type.symbol, SourceFileDependencyType.HEADER_SHALLOW);
		}
	}

	public override void visit_end_method (Method! m) {
		current_symbol = current_symbol.parent_symbol;
		current_return_type = null;

		if (current_symbol.parent_symbol != null &&
		    current_symbol.parent_symbol.node is Method) {
			/* lambda expressions produce nested methods */
			var up_method = (Method) current_symbol.parent_symbol.node;
			current_return_type = up_method.return_type;
		}
		
		if (m.is_virtual || m.overrides) {
			if (current_symbol.node is Class) {
				var cl = (Class) current_symbol.node;
				Class base_class;
				for (base_class = cl; base_class != null; base_class = base_class.base_class) {
					var sym = base_class.symbol.lookup (m.name);
					if (sym != null && sym.node is Method) {
						var base_method = (Method) sym.node;
						if (base_method.is_abstract || base_method.is_virtual) {
							if (!m.equals (base_method)) {
								m.error = true;
								Report.error (m.source_reference, "Return type and or parameters of overriding method `%s' do not match overridden method `%s'.".printf (m.symbol.get_full_name (), base_method.symbol.get_full_name ()));
								return;
							}
							
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
						if (type.data_type is Interface) {
							var iface = (Interface) type.data_type;
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
		
		if (m.construction && m.body != null) {
			int n_params = 0;
			foreach (Statement stmt in m.body.get_statements ()) {
				int params = stmt.get_number_of_set_construction_parameters ();
				if (params == -1) {
					break;
				}
				n_params += params;
				stmt.construction = true;
			}
			m.n_construction_params = n_params;
		}
	}

	public override void visit_formal_parameter (FormalParameter! p) {
		if (!p.ellipsis) {
			if (p.type_reference.data_type != null) {
				/* is null if it references a type parameter */
				current_source_file.add_symbol_dependency (p.type_reference.data_type.symbol, SourceFileDependencyType.HEADER_SHALLOW);
				current_source_file.add_symbol_dependency (p.type_reference.data_type.symbol, SourceFileDependencyType.SOURCE);
			}
		}
	}

	public override void visit_end_property (Property! prop) {
		if (prop.type_reference.data_type != null) {
			/* is null if it references a type parameter */
			current_source_file.add_symbol_dependency (prop.type_reference.data_type.symbol, SourceFileDependencyType.HEADER_SHALLOW);
			current_source_file.add_symbol_dependency (prop.type_reference.data_type.symbol, SourceFileDependencyType.SOURCE);
		}
	}

	public override void visit_begin_property_accessor (PropertyAccessor! acc) {
		var prop = (Property) acc.symbol.parent_symbol.node;
		
		if (acc.readable) {
			current_return_type = prop.type_reference;
		} else {
			// void
			current_return_type = new TypeReference ();
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
			decl.type_reference.takes_ownership = decl.type_reference.transfers_ownership;
			decl.type_reference.transfers_ownership = false;
		}
		
		if (decl.initializer != null) {
			if (decl.initializer.static_type == null) {
				if (!(decl.initializer is MemberAccess)) {
					decl.error = true;
					Report.error (decl.source_reference, "expression type not allowed as initializer");
					return;
				}
				
				if (decl.initializer.symbol_reference.node is Method &&
				    decl.type_reference.data_type is Callback) {
					var m = (Method) decl.initializer.symbol_reference.node;
					var cb = (Callback) decl.type_reference.data_type;
					
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
				if (decl.initializer.static_type.transfers_ownership) {
					/* rhs transfers ownership of the expression */
					if (!decl.type_reference.takes_ownership) {
						/* lhs doesn't own the value
						 * promote lhs type */
						
						decl.type_reference.takes_ownership = true;
					}
				}
			}
		}
		
		if (decl.type_reference.data_type != null) {
			current_source_file.add_symbol_dependency (decl.type_reference.data_type.symbol, SourceFileDependencyType.SOURCE);
		}

		decl.symbol = new Symbol (decl);
		current_symbol.add (decl.name, decl.symbol);
		
		var block = (Block) current_symbol.node;
		block.add_local_variable (decl);
		
		decl.symbol.active = true;
	}
	
	/**
	 * Visit operation called for initializer lists
	 *
	 * @param list an initializer list
	 */
	public override void visit_begin_initializer_list (InitializerList! list) {
		if (list.expected_type != null && list.expected_type.data_type is Array) {
			/* initializer is used as array initializer */
			Array edt = (Array)list.expected_type.data_type;
			var inits = list.get_initializers ();
			int rank = ((Array)list.expected_type.data_type).rank;
			var child_type = list.expected_type.copy ();
			
			if (rank > 1) {
				child_type.data_type = edt.element_type.get_array (rank - 1);
			} else {
				child_type.data_type = edt.element_type;
			}
				
			foreach (Expression e in inits) {
				e.expected_type = child_type.copy ();
			}
		}
	}
	
	/**
	 * Visit operation called for initializer lists
	 *
	 * @param list an initializer list
	 */
	public override void visit_end_initializer_list (InitializerList! list) {
		if (list.expected_type != null && list.expected_type.data_type is Array) {
			Array edt = (Array)list.expected_type.data_type;
			var inits = list.get_initializers ();
			int rank = edt.rank;
			var child_type = list.expected_type.copy ();
			bool error = false;
			
			if (rank > 1) {
				child_type.data_type = edt.element_type.get_array (rank - 1);
				foreach (Expression e in inits) {
					if (e.static_type == null) {
						error = true;
						continue;
					}
					if (!(e is InitializerList)) {
						error = true;
						e.error = true;
						Report.error (e.source_reference, "Initializer list expected");
						continue;
					}
					if (!e.static_type.equals (child_type)) {
						error = true;
						e.error = true;
						Report.error (e.source_reference, "Expected initializer list of type `%s' but got `%s'".printf (child_type.data_type.name, e.static_type.data_type.name));
					}
				}
			} else {
				child_type.data_type = edt.element_type;
				foreach (Expression e in inits) {
					if (e.static_type == null) {
						error = true;
						continue;
					}
					if (!is_type_compatible (e.static_type, child_type)) {
						error = true;
						e.error = true;
						Report.error (e.source_reference, "Expected initializer of type `%s' but got `%s'".printf (child_type.data_type.name, e.static_type.data_type.name));
					}
				}
			}
			
			if (!error) {
				/* everything seems to be correct */
				list.static_type = list.expected_type;
			}
		}
	}

	public override void visit_expression_statement (ExpressionStatement! stmt) {
		if (stmt.expression.static_type != null &&
		    stmt.expression.static_type.transfers_ownership) {
			Report.warning (stmt.source_reference, "Short-living reference");
			return;
		}
	}

	public override void visit_if_statement (IfStatement! stmt) {
		if (stmt.condition.error) {
			/* if there was an error in the condition, skip this check */
			stmt.error = true;
			return;
		}
		
		if (stmt.condition.static_type.data_type != bool_type.data_type) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}
	}

	public override void visit_while_statement (WhileStatement! stmt) {
		if (stmt.condition.static_type.data_type != bool_type.data_type) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}
	}

	public override void visit_for_statement (ForStatement! stmt) {
		if (stmt.condition.static_type.data_type != bool_type.data_type) {
			stmt.error = true;
			Report.error (stmt.condition.source_reference, "Condition must be boolean");
			return;
		}
	}

	public override void visit_begin_foreach_statement (ForeachStatement! stmt) {
		if (stmt.type_reference.data_type != null) {
			current_source_file.add_symbol_dependency (stmt.type_reference.data_type.symbol, SourceFileDependencyType.SOURCE);
		}
		
		stmt.variable_declarator = new VariableDeclarator (stmt.variable_name);
		stmt.variable_declarator.type_reference = stmt.type_reference;
	
		stmt.variable_declarator.symbol = new Symbol (stmt.variable_declarator);
		current_symbol.add (stmt.variable_name, stmt.variable_declarator.symbol);
	}

	public override void visit_end_return_statement (ReturnStatement! stmt) {
		if (current_return_type == null) {
			Report.error (stmt.source_reference, "Return not allowed in this context");
			return;
		}
		
		if (stmt.return_expression == null && current_return_type.data_type != null) {
			Report.error (stmt.source_reference, "Return without value in non-void function");
			return;
		}
		
		if (stmt.return_expression != null &&
		    current_return_type.data_type == null &&
		    current_return_type.type_parameter == null) {
			Report.error (stmt.source_reference, "Return with value in void function");
			return;
		}
		
		if (stmt.return_expression != null &&
		     !is_type_compatible (stmt.return_expression.static_type, current_return_type)) {
			Report.error (stmt.source_reference, "Return: Cannot convert from `%s' to `%s'".printf (stmt.return_expression.static_type.to_string (), current_return_type.to_string ()));
			return;
		}
		
		if (stmt.return_expression != null &&
		    stmt.return_expression.static_type.transfers_ownership &&
		    !current_return_type.transfers_ownership) {
			stmt.error = true;
			Report.error (stmt.source_reference, "Return value transfers ownership but method return type hasn't been declared to transfer ownership");
			return;
		}
		
		if (stmt.return_expression != null &&
		    stmt.return_expression.symbol_reference != null &&
		    stmt.return_expression.symbol_reference.node is VariableDeclarator &&
		    stmt.return_expression.static_type.takes_ownership &&
		    !current_return_type.transfers_ownership) {
			Report.warning (stmt.source_reference, "Local variable with strong reference used as return value and method return type hasn't been declared to transfer ownership");
		}
	}
	
	/**
	 * Visit operation called for lock statements.
	 *
	 * @param stmt a lock statement
	 */
	public override void visit_lock_statement (LockStatement! stmt) {
		/* resource must be a member access and denote a Lockable */
		if (!(stmt.resource is MemberAccess && stmt.resource.symbol_reference.node is Lockable)) {
		    	stmt.error = true;
			stmt.resource.error = true;
			Report.error (stmt.resource.source_reference, "Expression is either not a member access or does not denote a lockable member");
			return;
		}
		
		/* parent symbol must be the current class */
		if (stmt.resource.symbol_reference.parent_symbol.node != current_class) {
		    	stmt.error = true;
			stmt.resource.error = true;
			Report.error (stmt.resource.source_reference, "Only members of the current class are lockable");
		}
		
		((Lockable)stmt.resource.symbol_reference.node).set_lock_used (true);
	}
	
	public override void visit_begin_array_creation_expression (ArrayCreationExpression! expr) {
		if (expr.initializer_list != null) {
			expr.initializer_list.expected_type = expr.element_type.copy ();
			expr.initializer_list.expected_type.data_type = expr.initializer_list.expected_type.data_type.get_array (expr.rank);
			// FIXME: add element type to type_argument
		}
	}
	
	/**
	 * Visit operations called for array creation expresions.
	 *
	 * @param expr an array creation expression
	 */
	public override void visit_end_array_creation_expression (ArrayCreationExpression! expr) {
		int i;
		List<weak Expression> size = expr.get_sizes ();
		
		/* check for errors in the size list */
		if (size != null) {
			foreach (Expression e in size) {
				if (e.static_type == null) {
					/* return on previous error */
					return;
				} else if (e.static_type.data_type != int_type.data_type) {
					expr.error = true;
					Report.error (e.source_reference, "Expected expression of type ´int'");
				}
			}
			
			if (expr.error) {
				return;
			}
		}
		
		/* check for wrong elements inside the initializer */
		if (expr.initializer_list != null && expr.initializer_list.static_type == null) {
			return;
		}
		
		/* try to construct the type of the array */
		if (expr.element_type == null) {
			expr.error = true;
			Report.error (expr.source_reference, "Cannot determine the element type of the created array");
			return;
		}

		expr.static_type = expr.element_type.copy ();
		expr.static_type.data_type = expr.element_type.data_type.get_array (expr.rank);
		expr.static_type.transfers_ownership = true;
		expr.static_type.takes_ownership = true;
		
		expr.static_type.add_type_argument (expr.element_type);
	}	

	public override void visit_boolean_literal (BooleanLiteral! expr) {
		expr.static_type = bool_type;
	}

	public override void visit_character_literal (CharacterLiteral! expr) {
		expr.static_type = new TypeReference ();
		expr.static_type.data_type = (DataType) root_symbol.lookup ("char").node;
	}

	public override void visit_integer_literal (IntegerLiteral! expr) {
		expr.static_type = new TypeReference ();
		expr.static_type.data_type = (DataType) root_symbol.lookup (expr.get_type_name ()).node;
	}

	public override void visit_real_literal (RealLiteral! expr) {
		expr.static_type = new TypeReference ();
		expr.static_type.data_type = (DataType) root_symbol.lookup (expr.get_type_name ()).node;
	}

	public override void visit_string_literal (StringLiteral! expr) {
		expr.static_type = string_type.copy ();
		expr.static_type.non_null = true;
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
			type.takes_ownership = false;
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
			type.data_type = (DataType) node.symbol.parent_symbol.node;
			return type;
		}
		return null;
	}
	
	Symbol symbol_lookup_inherited (Symbol! sym, string! name) {
		var result = sym.lookup (name);
		if (result != null) {
			return result;
		}

		if (sym.node is Class) {
			var cl = (Class) sym.node;
			foreach (TypeReference base_type in cl.get_base_types ()) {
				result = symbol_lookup_inherited (base_type.data_type.symbol, name);
				if (result != null) {
					return result;
				}
			}
		} else if (sym.node is Interface) {
			var iface = (Interface) sym.node;
			foreach (TypeReference base_type in iface.get_base_types ()) {
				result = symbol_lookup_inherited (base_type.data_type.symbol, name);
				if (result != null) {
					return result;
				}
			}
		}

		return null;
	}

	public override void visit_parenthesized_expression (ParenthesizedExpression! expr) {
		expr.static_type = expr.inner.static_type;
	}

	private DataType find_parent_type (Symbol sym) {
		while (sym != null) {
			if (sym.node is DataType) {
				return (DataType) sym.node;
			}
			sym = sym.parent_symbol;
		}
		return null;
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
							expr.error = true;
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
				expr.error = true;
				return;
			}
		
			if (expr.inner is MemberAccess || expr.inner is BaseAccess) {
				base_symbol = expr.inner.symbol_reference;
				if (base_symbol.node is Namespace ||
				    base_symbol.node is DataType) {
					expr.symbol_reference = base_symbol.lookup (expr.member_name);
				}
			}
			
			if (expr.symbol_reference == null && expr.inner.static_type != null) {
				base_symbol = expr.inner.static_type.data_type.symbol;
				expr.symbol_reference = symbol_lookup_inherited (base_symbol, expr.member_name);
			}
		}
			
		if (expr.symbol_reference == null) {
			expr.error = true;
			Report.error (expr.source_reference, "The name `%s' does not exist in the context of `%s'".printf (expr.member_name, base_symbol.get_full_name ()));
			return;
		}
		
		var member = expr.symbol_reference.node;
		MemberAccessibility access = MemberAccessibility.PUBLIC;
		if (member is Field) {
			access = ((Field) member).access;
		} else if (member is Method) {
			access = ((Method) member).access;
		}
		
		if (access == MemberAccessibility.PRIVATE) {
			var target_type = (DataType) member.symbol.parent_symbol.node;
			var this_type = find_parent_type (current_symbol);
			
			if (target_type != this_type) {
				expr.error = true;
				Report.error (expr.source_reference, "Access to private member `%s' denied".printf (member.symbol.get_full_name ()));
				return;
			}
		}
		
		current_source_file.add_symbol_dependency (expr.symbol_reference, SourceFileDependencyType.SOURCE);

		expr.static_type = get_static_type_for_node (expr.symbol_reference.node);
	}
	
	private bool is_type_compatible (TypeReference! expression_type, TypeReference! expected_type) {
		/* only null is compatible to null */
		if (expected_type.data_type == null && expected_type.type_parameter == null) {
			return (expression_type.data_type == null && expected_type.type_parameter == null);
		}

		if (expression_type.data_type == null) {
			/* null can be cast to any reference or array type */
			if (expected_type.type_parameter != null ||
			    expected_type.data_type.is_reference_type () ||
			    expected_type.reference_to_value_type ||
			    expected_type.data_type is Array ||
			    expected_type.data_type is Callback ||
			    expected_type.data_type == pointer_type) {
				return true;
			}
			
			/* null is not compatible with any other type (i.e. value types) */
			return false;
		}
	
		/* temporarily ignore type parameters */
		if (expected_type.type_parameter != null) {
			return true;
		}
		
		if (expression_type.data_type is Array != expected_type.data_type is Array) {
			return false;
		}
		
		if (expression_type.data_type == expected_type.data_type) {
			return true;
		}
		
		if (expression_type.data_type is Struct && expected_type.data_type is Struct) {
			var expr_struct = (Struct) expression_type.data_type;
			var expect_struct = (Struct) expected_type.data_type;

			/* integer types may be implicitly cast to floating point types */
			if (expr_struct.is_integer_type () && expect_struct.is_floating_type ()) {
				return true;
			}

			if ((expr_struct.is_integer_type () && expect_struct.is_integer_type ()) ||
			    (expr_struct.is_floating_type () && expect_struct.is_floating_type ())) {
				if (expr_struct.get_rank () <= expect_struct.get_rank ()) {
					return true;
				}
			}
		}
		
		return expression_type.data_type.is_subtype_of (expected_type.data_type);
	}

	public override void visit_begin_invocation_expression (InvocationExpression! expr) {
		if (expr.call.error) {
			/* if method resolving didn't succeed, skip this check */
			expr.error = true;
			return;
		}
		
		var msym = expr.call.symbol_reference;
		
		if (msym == null) {
			/* if no symbol found, skip this check */
			expr.error = true;
			return;
		}
		
		List<weak FormalParameter> params;
		
		if (msym.node is Invokable) {
			var m = (Invokable) msym.node;
			if (m.is_invokable ()) {
				params = m.get_parameters ();
			} else {
				expr.error = true;
				Report.error (expr.source_reference, "invocation not supported in this context");
				return;
			}
		} else {
			expr.error = true;
			Report.error (expr.source_reference, "invocation not supported in this context");
			return;
		}
	
		var args = expr.get_argument_list ();
		List arg_it = args;
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
	
	private bool check_arguments (Expression! expr, Symbol! msym, List<FormalParameter> params, List<Expression> args) {
		List arg_it = args;
		
		bool ellipsis = false;
		int i = 0;
		foreach (FormalParameter param in params) {
			if (param.ellipsis) {
				ellipsis = true;
				break;
			}

			/* header file necessary if we need to cast argument */
			if (param.type_reference.data_type != null) {
				current_source_file.add_symbol_dependency (param.type_reference.data_type.symbol, SourceFileDependencyType.SOURCE);
			}

			if (arg_it == null) {
				if (param.default_expression == null) {
					expr.error = true;
					Report.error (expr.source_reference, "Too few arguments, method `%s' does not take %d arguments".printf (msym.get_full_name (), args.length ()));
					return false;
				}
			} else {
				var arg = (Expression) arg_it.data;
				if (arg.static_type != null && !is_type_compatible (arg.static_type, param.type_reference)) {
					/* if there was an error in the argument,
					 * i.e. arg.static_type == null, skip type check */
					expr.error = true;
					Report.error (expr.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.static_type.to_string (), param.type_reference.to_string ()));
					return false;
				}
				
				arg_it = arg_it.next;

				i++;
			}
		}
		
		if (!ellipsis && arg_it != null) {
			expr.error = true;
			Report.error (expr.source_reference, "Too many arguments, method `%s' does not take %d arguments".printf (msym.get_full_name (), args.length ()));
			return false;
		}
		
		return true;
	}

	public override void visit_end_invocation_expression (InvocationExpression! expr) {
		if (expr.error) {
			return;
		}
		
		var msym = expr.call.symbol_reference;
		
		TypeReference ret_type;
		List<weak FormalParameter> params;
		
		if (msym.node is Invokable) {
			var m = (Invokable) msym.node;
			ret_type = m.get_return_type ();
			params = m.get_parameters ();
		}
	
		expr.static_type = ret_type;
		
		check_arguments (expr, msym, params, expr.get_argument_list ());
	}	
	
	public override void visit_element_access (ElementAccess! expr) {		
		if (expr.container.static_type == null) {
			/* don't proceed if a child expression failed */
			expr.error = true;
			return;
		}
		
		/* assign a static_type when possible */
		if (expr.container.static_type.data_type is Array) {
			var args = expr.container.static_type.get_type_arguments ();
			
			if (args.length () != 1) {
				expr.error = true;
				Report.error (expr.source_reference, "internal error: array reference without type arguments");
				return;
			}
			
			expr.static_type = (TypeReference) args.data;
		} else {
			expr.error = true;
			Report.error (expr.source_reference, "The expression `%s' does not denote an Array".printf (expr.container.static_type.to_string ()));
		}
		
		/* check if the index is of type integer */		
		foreach (Expression e in expr.get_indices ()) {
			/* don't proceed if a child expression failed */
			if (e.static_type == null) {
				return;
			}
			
			/* check if the index is of type integer */
			if (e.static_type.data_type != int_type.data_type) {
				expr.error = true;
				Report.error (e.source_reference, "Expression of type `int' expected");
			}
		}
	}

	public override void visit_base_access (BaseAccess! expr) {
		if (current_class == null) {
			expr.error = true;
			Report.error (expr.source_reference, "Base access invalid outside of a class");
			return;
		}

		expr.symbol_reference = current_class.symbol;
		expr.static_type = new TypeReference ();
		expr.static_type.data_type = current_class.base_class;
	}
	
	public override void visit_postfix_expression (PostfixExpression! expr) {
		expr.static_type = expr.inner.static_type;
	}

	public override void visit_end_object_creation_expression (ObjectCreationExpression! expr) {
		DataType type = null;
		
		if (expr.type_reference == null) {
			if (expr.member_name == null) {
				expr.error = true;
				Report.error (expr.source_reference, "Incomplete object creation expression");
				return;
			}
			
			if (expr.member_name.symbol_reference == null) {
				expr.error = true;
				return;
			}
			
			var constructor_node = expr.member_name.symbol_reference.node;
			var type_node = expr.member_name.symbol_reference.node;
			
			var type_args = expr.member_name.get_type_arguments ();
			
			if (constructor_node is Method) {
				type_node = constructor_node.symbol.parent_symbol.node;
				
				var constructor = (Method) constructor_node;
				if (!constructor.construction) {
					expr.error = true;
					Report.error (expr.source_reference, "`%s' is not a construction method".printf (constructor.symbol.get_full_name ()));
					return;
				}
				
				expr.symbol_reference = constructor.symbol;
			
				type_args = ((MemberAccess) expr.member_name.inner).get_type_arguments ();
			}
			
			if (type_node is Class || type_node is Struct) {
				type = (DataType) type_node;
			} else {
				expr.error = true;
				Report.error (expr.source_reference, "`%s' is not a class or struct".printf (type.symbol.get_full_name ()));
				return;
			}

			expr.type_reference = new TypeReference ();
			expr.type_reference.data_type = type;
			foreach (TypeReference type_arg in type_args) {
				expr.type_reference.add_type_argument (type_arg);
			}
		}
	
		if (!type.is_reference_type ()) {
			expr.error = true;
			Report.error (expr.source_reference, "Can't create instance of value type `%s'".printf (expr.type_reference.to_string ()));
			return;
		}
	
		current_source_file.add_symbol_dependency (type.symbol, SourceFileDependencyType.SOURCE);

		expr.static_type = expr.type_reference.copy ();
		expr.static_type.transfers_ownership = true;
		
		if (type is Class) {
			var cl = (Class) type;
			
			if (cl.is_abstract) {
				expr.static_type = null;
				expr.error = true;
				Report.error (expr.source_reference, "Can't create instance of abstract class `%s'".printf (cl.symbol.get_full_name ()));
				return;
			}
			
			if (expr.symbol_reference == null && cl.default_construction_method != null) {
				expr.symbol_reference = cl.default_construction_method.symbol;
			}
			
			while (cl != null) {
				if (cl == initially_unowned_type) {
					expr.static_type.floating_reference = true;
					break;
				}
			
				cl = cl.base_class;
			}
		} else if (type is Struct) {
			var st = (Struct) type;
		
			if (expr.symbol_reference == null && st.default_construction_method != null) {
				expr.symbol_reference = st.default_construction_method.symbol;
			}
		}

		if (expr.symbol_reference == null && expr.get_argument_list ().length () != 0) {
			expr.static_type = null;
			expr.error = true;
			Report.error (expr.source_reference, "No arguments allowed when constructing type `%s'".printf (type.symbol.get_full_name ()));
			return;
		}

		if (expr.symbol_reference != null) {
			var m = (Method) expr.symbol_reference.node;
			check_arguments (expr, m.symbol, m.get_parameters (), expr.get_argument_list ());
		}
	}

	public override void visit_typeof_expression (TypeofExpression! expr) {
		expr.static_type = type_type;
	}
	
	private bool is_numeric_type (TypeReference! type) {
		if (!(type.data_type is Struct)) {
			return false;
		}
		
		var st = (Struct) type.data_type;
		return st.is_integer_type () || st.is_floating_type ();
	}
	
	private bool is_integer_type (TypeReference! type) {
		if (!(type.data_type is Struct)) {
			return false;
		}
		
		var st = (Struct) type.data_type;
		return st.is_integer_type ();
	}

	public override void visit_unary_expression (UnaryExpression! expr) {
		if (expr.inner.error) {
			/* if there was an error in the inner expression, skip type check */
			expr.error = true;
			return;
		}
	
		if (expr.operator == UnaryOperator.PLUS || expr.operator == UnaryOperator.MINUS) {
			// integer or floating point type
			if (!is_numeric_type (expr.inner.static_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "Operator not supported for `%s'".printf (expr.inner.static_type.to_string ()));
				return;
			}

			expr.static_type = expr.inner.static_type;
		} else if (expr.operator == UnaryOperator.LOGICAL_NEGATION) {
			// boolean type
			if (expr.inner.static_type.data_type != bool_type.data_type) {
				expr.error = true;
				Report.error (expr.source_reference, "Operator not supported for `%s'".printf (expr.inner.static_type.to_string ()));
				return;
			}

			expr.static_type = expr.inner.static_type;
		} else if (expr.operator == UnaryOperator.BITWISE_COMPLEMENT) {
			// integer type
			if (!is_integer_type (expr.inner.static_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "Operator not supported for `%s'".printf (expr.inner.static_type.to_string ()));
				return;
			}

			expr.static_type = expr.inner.static_type;
		} else if (expr.operator == UnaryOperator.INCREMENT ||
		           expr.operator == UnaryOperator.DECREMENT) {
			// integer type
			if (!is_integer_type (expr.inner.static_type)) {
				expr.error = true;
				Report.error (expr.source_reference, "Operator not supported for `%s'".printf (expr.inner.static_type.to_string ()));
				return;
			}
			
			if (!(expr.inner is MemberAccess)) {
				expr.error = true;
				Report.error (expr.source_reference, "Prefix operators currently not supported for this expression");
				return;
			}
			
			var ma = (MemberAccess) expr.inner;
			
			var old_value = new MemberAccess (ma.inner, ma.member_name);
			var bin = new BinaryExpression (expr.operator == UnaryOperator.INCREMENT ? BinaryOperator.PLUS : BinaryOperator.MINUS, old_value, new LiteralExpression (new IntegerLiteral ("1")));
			
			var assignment = new Assignment (expr.inner, bin);
			expr.parent_node.replace (expr, assignment);
			assignment.accept (this);
			return;
		} else if (expr.operator == UnaryOperator.REF) {
			// value type

			expr.static_type = expr.inner.static_type;
		} else if (expr.operator == UnaryOperator.OUT) {
			// reference type

			expr.static_type = expr.inner.static_type;
		} else {
			expr.error = true;
			Report.error (expr.source_reference, "internal error: unsupported unary operator");
			return;
		}
	}

	public override void visit_cast_expression (CastExpression! expr) {
		if (expr.type_reference.data_type == null) {
			/* if type resolving didn't succeed, skip this check */
			return;
		}
		
		// FIXME: check whether cast is allowed
	
		current_source_file.add_symbol_dependency (expr.type_reference.data_type.symbol, SourceFileDependencyType.SOURCE);

		expr.static_type = expr.type_reference;
	}
	
	private bool check_binary_type (BinaryExpression! expr, string! operation) {
		if (!is_type_compatible (expr.right.static_type, expr.left.static_type)) {
			Report.error (expr.source_reference, "%s: Cannot convert from `%s' to `%s'".printf (operation, expr.right.static_type.to_string (), expr.left.static_type.to_string ()));
			return false;
		}
		
		return true;
	}
	
	private ref TypeReference get_arithmetic_result_type (TypeReference! left_type, TypeReference! right_type) {
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
	
	public override void visit_binary_expression (BinaryExpression! expr) {
		if (expr.left.error || expr.right.error) {
			/* if there were any errors in inner expressions, skip type check */
			expr.error = true;
			return;
		}
	
		if (expr.left.static_type.data_type == string_type.data_type
		    && expr.operator == BinaryOperator.PLUS) {
			if (expr.right.static_type.data_type != string_type.data_type) {
				expr.error = true;
				Report.error (expr.source_reference, "Operands must be strings");
				return;
			}

			/* string concatenation: convert to a.concat (b) */
			
			var concat_call = new InvocationExpression (new MemberAccess (expr.left, "concat"));
			concat_call.add_argument (expr.right);
			
			expr.parent_node.replace (expr, concat_call);
			
			concat_call.accept (this);
		} else if (expr.operator == BinaryOperator.PLUS
			   || expr.operator == BinaryOperator.MINUS
			   || expr.operator == BinaryOperator.MUL
			   || expr.operator == BinaryOperator.DIV) {
			expr.static_type = get_arithmetic_result_type (expr.left.static_type, expr.right.static_type);

			if (expr.static_type == null) {
				expr.error = true;
				Report.error (expr.source_reference, "Arithmetic operation not supported for types `%s' and `%s'".printf (expr.left.static_type.to_string (), expr.right.static_type.to_string ()));
				return;
			}
		} else if (expr.operator == BinaryOperator.MOD
			   || expr.operator == BinaryOperator.SHIFT_LEFT
			   || expr.operator == BinaryOperator.SHIFT_RIGHT
			   || expr.operator == BinaryOperator.BITWISE_XOR) {
			expr.static_type = get_arithmetic_result_type (expr.left.static_type, expr.right.static_type);

			if (expr.static_type == null) {
				expr.error = true;
				Report.error (expr.source_reference, "Arithmetic operation not supported for types `%s' and `%s'".printf (expr.left.static_type.to_string (), expr.right.static_type.to_string ()));
				return;
			}
		} else if (expr.operator == BinaryOperator.LESS_THAN
			   || expr.operator == BinaryOperator.GREATER_THAN
			   || expr.operator == BinaryOperator.LESS_THAN_OR_EQUAL
			   || expr.operator == BinaryOperator.GREATER_THAN_OR_EQUAL) {
			if (expr.left.static_type.data_type == string_type.data_type
			    && expr.right.static_type.data_type == string_type.data_type) {
				/* string comparison: convert to a.collate (b) OP 0 */
				
				var cmp_call = new InvocationExpression (new MemberAccess (expr.left, "collate"));
				cmp_call.add_argument (expr.right);
				expr.left = cmp_call;
				
				expr.right = new LiteralExpression (new IntegerLiteral ("0"));
				
				expr.left.accept (this);
			} else {
				/* TODO: check for integer or floating point type in expr.left */

				if (!check_binary_type (expr, "Relational operation")) {
					expr.error = true;
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
				expr.error = true;
				return;
			}
			
			if (expr.left.static_type.data_type == string_type.data_type
			    && expr.right.static_type.data_type == string_type.data_type) {
				/* string comparison: convert to a.collate (b) OP 0 */
				
				var cmp_call = new InvocationExpression (new MemberAccess (expr.left, "collate"));
				cmp_call.add_argument (expr.right);
				expr.left = cmp_call;
				
				expr.right = new LiteralExpression (new IntegerLiteral ("0"));
				
				expr.left.accept (this);
			}

			expr.static_type = bool_type;
		} else if (expr.operator == BinaryOperator.BITWISE_AND
			   || expr.operator == BinaryOperator.BITWISE_OR) {
			// integer type or flags type

			expr.static_type = expr.left.static_type;
		} else if (expr.operator == BinaryOperator.AND
			   || expr.operator == BinaryOperator.OR) {
			if (expr.left.static_type.data_type != bool_type.data_type || expr.right.static_type.data_type != bool_type.data_type) {
				expr.error = true;
				Report.error (expr.source_reference, "Operands must be boolean");
			}

			expr.static_type = bool_type;
		} else {
			assert_not_reached ();
		}
	}

	public override void visit_type_check (TypeCheck! expr) {
		if (expr.type_reference.data_type == null) {
			/* if type resolving didn't succeed, skip this check */
			expr.error = true;
			return;
		}
	
		current_source_file.add_symbol_dependency (expr.type_reference.data_type.symbol, SourceFileDependencyType.SOURCE);

		expr.static_type = bool_type;
	}

	public override void visit_conditional_expression (ConditionalExpression! expr) {
		if (expr.condition.static_type.data_type != bool_type.data_type) {
			expr.error = true;
			Report.error (expr.condition.source_reference, "Condition must be boolean");
			return;
		}
		
		/* FIXME: use greatest lower bound in the type hierarchy */
		/* FIXME: support memory management */
		expr.static_type = expr.true_expression.static_type;
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
		if (l.expected_type == null || !(l.expected_type.data_type is Callback)) {
			l.error = true;
			Report.error (l.source_reference, "lambda expression not allowed in this context");
			return;
		}
		
		var current_method = find_current_method ();
		
		var cb = (Callback) l.expected_type.data_type;
		l.method = new Method (get_lambda_name (), cb.return_type);
		l.method.instance = cb.instance && current_method.instance;
		l.method.symbol = new Symbol (l.method);
		l.method.symbol.parent_symbol = current_symbol;
		
		var lambda_params = l.get_parameters ();
		var lambda_param_it = lambda_params;
		foreach (FormalParameter cb_param in cb.get_parameters ()) {
			if (lambda_param_it == null) {
				/* lambda expressions are allowed to have less parameters */
				break;
			}
			
			var lambda_param = (string) lambda_param_it.data;
			
			var param = new FormalParameter (lambda_param, cb_param.type_reference);
			param.symbol = new Symbol (param);
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
		
		if (l.expression_body != null) {
			var block = new Block ();
			block.symbol = new Symbol (block);
			block.symbol.parent_symbol = l.method.symbol;

			if (l.method.return_type.data_type != null) {
				block.add_statement (new ReturnStatement (l.expression_body));
			} else {
				block.add_statement (new ExpressionStatement (l.expression_body));
			}
		
			l.method.body = block;
		} else {
			l.method.body = l.statement_body;
			l.method.body.symbol.parent_symbol = l.method.symbol;
		}
		
		/* lambda expressions should be usable like MemberAccess of a method */
		l.symbol_reference = l.method.symbol;
	}

	public override void visit_begin_assignment (Assignment! a) {
		if (a.left is MemberAccess) {
			var ma = (MemberAccess) a.left;

			if (ma.error || ma.symbol_reference == null) {
				a.error = true;
				/* if no symbol found, skip this check */
				return;
			}
			
			if (ma.symbol_reference.node is Signal) {
				var sig = (Signal) ma.symbol_reference.node;

				a.right.expected_type = new TypeReference ();
				a.right.expected_type.data_type = sig.get_callback ();
			}
		} else if (a.left is ElementAccess) {
			// do nothing
		} else {
			a.error = true;
			Report.error (a.source_reference, "unsupported lvalue in assignment");
		}
	}

	public override void visit_end_assignment (Assignment! a) {
		if (a.error || a.left.error || a.right.error) {
			a.error = true;
			return;
		}
		
		if (a.operator != AssignmentOperator.SIMPLE && a.left is MemberAccess) {
			// transform into simple assignment
			// FIXME: only do this if the backend doesn't support
			// the assignment natively
		
			var ma = (MemberAccess) a.left;
			
			if (!(ma.symbol_reference.node is Signal)) {
				var old_value = new MemberAccess (ma.inner, ma.member_name);
			
				var bin = new BinaryExpression (BinaryOperator.PLUS, old_value, a.right);
				
				if (a.operator == AssignmentOperator.BITWISE_OR) {
					bin.operator = BinaryOperator.BITWISE_OR;
				} else if (a.operator == AssignmentOperator.BITWISE_AND) {
					bin.operator = BinaryOperator.BITWISE_AND;
				} else if (a.operator == AssignmentOperator.BITWISE_XOR) {
					bin.operator = BinaryOperator.BITWISE_XOR;
				} else if (a.operator == AssignmentOperator.ADD) {
					bin.operator = BinaryOperator.PLUS;
				} else if (a.operator == AssignmentOperator.SUB) {
					bin.operator = BinaryOperator.MINUS;
				} else if (a.operator == AssignmentOperator.MUL) {
					bin.operator = BinaryOperator.MUL;
				} else if (a.operator == AssignmentOperator.DIV) {
					bin.operator = BinaryOperator.DIV;
				} else if (a.operator == AssignmentOperator.PERCENT) {
					bin.operator = BinaryOperator.MOD;
				} else if (a.operator == AssignmentOperator.SHIFT_LEFT) {
					bin.operator = BinaryOperator.SHIFT_LEFT;
				} else if (a.operator == AssignmentOperator.SHIFT_RIGHT) {
					bin.operator = BinaryOperator.SHIFT_RIGHT;
				}

				a.right = bin;
				a.right.accept (this);
		
				a.operator = AssignmentOperator.SIMPLE;
			}
		}
	
		if (a.left is MemberAccess) {
			var ma = (MemberAccess) a.left;
			
			if (ma.symbol_reference.node is Signal) {
				var sig = (Signal) ma.symbol_reference.node;

				if (a.right.symbol_reference == null) {
					a.error = true;
					Report.error (a.right.source_reference, "unsupported expression for signal handler");
					return;
				}
				
				var m = (Method) a.right.symbol_reference.node;
				
				if (m.instance && m.access != MemberAccessibility.PRIVATE) {
					/* TODO: generate wrapper function */
					
					ma.error = true;
					Report.error (a.right.source_reference, "public instance methods not yet supported as signal handlers");
					return;
				}
				
				if (m.instance) {
					/* instance signal handlers must have the self
					 * parameter at the end
					 * do not use G_CONNECT_SWAPPED as this would
					 * rearrange the parameters for instance
					 * methods and non-instance methods
					 */
					m.instance_last = true;
				}
			} else if (ma.symbol_reference.node is Property) {
				var prop = (Property) ma.symbol_reference.node;
				
				if (prop.set_accessor == null) {
					ma.error = true;
					Report.error (ma.source_reference, "Property `%s' is read-only".printf (prop.symbol.get_full_name ()));
					return;
				}
			} else if (ma.symbol_reference.node is VariableDeclarator && a.right.static_type == null) {
				var decl = (VariableDeclarator) ma.symbol_reference.node;
				
				var right_ma = (MemberAccess) a.right;
				if (right_ma.symbol_reference.node is Method &&
				    decl.type_reference.data_type is Callback) {
					var m = (Method) right_ma.symbol_reference.node;
					var cb = (Callback) decl.type_reference.data_type;
					
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
			} else if (ma.symbol_reference.node is Field && a.right.static_type == null) {
				var f = (Field) ma.symbol_reference.node;
				
				var right_ma = (MemberAccess) a.right;
				if (right_ma.symbol_reference.node is Method &&
				    f.type_reference.data_type is Callback) {
					var m = (Method) right_ma.symbol_reference.node;
					var cb = (Callback) f.type_reference.data_type;
					
					/* check whether method matches callback type */
					if (!cb.matches_method (m)) {
						f.error = true;
						Report.error (a.source_reference, "declaration of method `%s' doesn't match declaration of callback `%s'".printf (m.symbol.get_full_name (), cb.symbol.get_full_name ()));
						return;
					}
					
					a.right.static_type = f.type_reference;
				} else {
					a.error = true;
					Report.error (a.source_reference, "Assignment: Invalid callback assignment attempt");
					return;
				}
			} else if (a.left.static_type != null && a.right.static_type != null) {
				if (!is_type_compatible (a.right.static_type, a.left.static_type)) {
					/* if there was an error on either side,
					 * i.e. a.{left|right}.static_type == null, skip type check */
					a.error = true;
					Report.error (a.source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (a.right.static_type.to_string (), a.left.static_type.to_string ()));
					return;
				}
				
				if (memory_management) {
					if (a.right.static_type.transfers_ownership) {
						/* rhs transfers ownership of the expression */
						if (!a.left.static_type.takes_ownership) {
							/* lhs doesn't own the value
							 * promote lhs type if it is a local variable
							 * error if it's not a local variable */
							if (!(ma.symbol_reference.node is VariableDeclarator)) {
								Report.error (a.source_reference, "Invalid assignment from owned expression to unowned variable");
							}
							
							a.left.static_type.takes_ownership = true;
						}
					} else if (a.left.static_type.takes_ownership) {
						/* lhs wants to own the value
						 * rhs doesn't transfer the ownership
						 * code generator needs to add reference
						 * increment calls */
					}
				}
			}
		} else if (a.left is ElementAccess) {
			var ea = (ElementAccess) a.left;
		
			if (!is_type_compatible (a.right.static_type, a.left.static_type)) {
				/* if there was an error on either side,
				 * i.e. a.{left|right}.static_type == null, skip type check */
				a.error = true;
				Report.error (a.source_reference, "Assignment: Cannot convert from `%s' to `%s'".printf (a.right.static_type.to_string (), a.left.static_type.to_string ()));
				return;
			}
			
			if (memory_management) {
				if (a.right.static_type.transfers_ownership) {
					/* rhs transfers ownership of the expression */

					var args = ea.container.static_type.get_type_arguments ();
					if (args.length () != 1) {
						a.error = true;
						Report.error (ea.source_reference, "internal error: array reference without type arguments");
						return;
					}
					var element_type = (TypeReference) args.data;

					if (!element_type.takes_ownership) {
						/* lhs doesn't own the value
						 * promote lhs type if it is a local variable
						 * error if it's not a local variable */
						if (!(ea.container.symbol_reference.node is VariableDeclarator)) {
							a.error = true;
							Report.error (a.source_reference, "Invalid assignment from owned expression to unowned variable");
							return;
						}
						
						element_type.takes_ownership = true;
					}
				} else if (a.left.static_type.takes_ownership) {
					/* lhs wants to own the value
					 * rhs doesn't transfer the ownership
					 * code generator needs to add reference
					 * increment calls */
				}
			}
		} else {
			return;
		}
		
		a.static_type = a.left.static_type;
	}
}
