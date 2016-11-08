


public class Vala.NullabilityChecker : CodeVisitor {
	private const bool debug = true;
	private CodeContext context;
	private unowned FlowAnalyzer analyzer;

	private BasicBlock current_block;

	public NullabilityChecker (CodeContext context, FlowAnalyzer analyzer) {
		this.context = context;
		this.analyzer = analyzer;
	}

	public void set_current_block (BasicBlock b) {
		this.current_block = b;
	}

	private NullabilityState get_nullability_state (Symbol symbol, out bool found) {
		BasicBlock? b = current_block;
		while (b != null) {
			if (b.null_vars.contains (symbol)) {
				found = true;
				return NullabilityState.NULL;
			} else if (b.non_null_vars.contains (symbol)) {
				found = true;
				return NullabilityState.NON_NULL;
			}
			b = b.parent;
		}

		found = false;
		return NullabilityState.NULLABLE;
	}

	private void visit_basic_block (BasicBlock block) {
		if (debug) {
			message ("Checking Basic Block %s (%d nulls, %d non-nulls)",
			         block.name, block.null_vars.size, block.non_null_vars.size);
			message ("Accept() for %d nodes", block.nodes.size);
		}

		this.current_block = block;

		foreach (var node in block.nodes) {
			node.accept (this);
		}

		foreach (var child in block.children) {
			visit_basic_block (child);
		}
		// TODO: reset current_block ???
	}

	public override void visit_member_access (MemberAccess access) {
		if (access.inner == null) {
			// We're checking whether `inner` can be NULL here, so we're not interested in these cases
			access.accept_children (this);
			return;
		}

		if (debug)
			message ("Member access: %s", access.to_string ());
		bool found = false;
		if (access.inner != null && access.inner.symbol_reference is Variable) {
			message ("checking NULL state for %s (%s)", access.inner.to_string (),
					 access.inner.source_reference.to_string ());
			var null_state = this.get_nullability_state (access.inner.symbol_reference, out found);

			if (null_state == NullabilityState.NULL) {
				Report.error (access.source_reference, "`%s' is null here".printf (access.to_string ()));
				return;
			} else {
				Variable inner_var = analyzer.get_visible_variable ((Variable)access.inner.symbol_reference);
				if (debug) {
					message ("inner referernec: %s", access.inner.symbol_reference.to_string ());
					message ("Inner var: %s", inner_var.to_string ());
					message ("Inner var: %p", inner_var);
					message ("inner var type: %s", inner_var.type_name);
					if (inner_var.initializer != null) {
						message ("Initializer: %s", inner_var.initializer.type_name);
					} else {
						message ("No initializer!");
					}
				}
				DataType? inner_type = inner_var.variable_type;

				if (inner_type != null) {
					if (debug)
						message ("Inner type: %s", inner_type.to_qualified_string ());
					 //If the referenced type is nullable, and the code didn't make sure the reference
					 //is not null, we need to error out here.
					if (inner_type.nullable && null_state != NullabilityState.NON_NULL) {
						Report.error (access.source_reference, "Access to nullable reference `%s' denied".printf (access.inner.symbol_reference.get_full_name ()));
						//return;
					}
				}
			}
		}

#if 0
		if (!found) {
			// The previous check did not result in access.inner being either definitely NULL or
			// non-NULL, so check the type of the versioned variable here.
			// TODO: Is this really sufficient?
			if (access.inner != null && access.inner.symbol_reference is Variable) {
				var versioned_inner = analyzer.get_visible_variable ((Variable)access.inner.symbol_reference);
				var versioned_inner_type = versioned_inner.variable_type;
				message ("Versioned inner type: %s", versioned_inner_type.to_qualified_string ());
				message ("Versioned innner nullable: %s", versioned_inner_type.nullable.to_string ());

				if (versioned_inner_type.nullable) {
					Report.error (access.source_reference, "Access to nullable reference `%s' denied".printf (access.inner.symbol_reference.get_full_name ()));
					return;
				}
			}
		}
#endif

		access.accept_children (this);
	}

	public override void visit_declaration_statement (DeclarationStatement decl) {
		message ("DeclarationStatement: %s", decl.to_string ());
		message ("Declaration: %s", decl.declaration.to_string ());
		message ("Declaration: %s", decl.declaration.type_name);
		message ("Declaration: %p", decl.declaration);
		decl.accept_children (this);
	}

	public override void visit_method (Method m) {
		m.accept_children (this);
	}

	public override void visit_local_variable (LocalVariable local) {
		if (local.initializer != null) {
			local.initializer.accept (this);
		}
	}

	public override void visit_assignment (Assignment assign) {
		if (assign.left == null || assign.right == null) {
			return;
		}

		message ("Assignment: %s", assign.to_string ());

		var left_symbol = assign.left.symbol_reference;
		if (left_symbol is LocalVariable) {
			var local = left_symbol as LocalVariable;
			var visible_var = analyzer.get_visible_variable (local);
			//message ("Visible var: %s", visible_var.to_string ());
			//var initializer = visible_var.initializer;
			//if (initializer != null) {
				//message ("Initializer: %s", initializer.type_name);
			//} else
			  //message ("No initializer");

			//message ("Right: %s", assign.right.type_name);
			//message ("Right: %s", assign.right.get_null_state ().to_string ());
			if (assign.right.get_null_state () != NullabilityState.NON_NULL)
				visible_var.variable_type.nullable = true;
			else
				visible_var.variable_type.nullable = false;
		}


		//message ("Right: %s", assign.right.type_name);
		//message ("Right nullable: %s", assign.right.get_null_state ().to_string ());
		if (assign.left.symbol_reference != null && assign.right.symbol_reference != null) {

			DataType? left_type = context.analyzer.get_value_type_for_symbol (assign.left.symbol_reference, false);
			if (left_type != null && !left_type.nullable) {
				DataType? right_type = context.analyzer.get_value_type_for_symbol (assign.right.symbol_reference, false);
				if (right_type != null && right_type.nullable) {

					//message ("Right: %s", assign.right.type_name);

					bool found;
					var null_state = this.get_nullability_state (assign.right.symbol_reference, out found);
					if (null_state != NullabilityState.NON_NULL) {
						Report.error (assign.source_reference, "Cannot assign from nullable `%s' to non-nullable `%s'".printf (right_type.to_string (), left_type.to_string ()));
					}
				}
			}
			// Assignments from non-nullable to nullable are always fine
		}

		assign.accept_children (this);
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		stmt.expression.accept (this);
	}
}
