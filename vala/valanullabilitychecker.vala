


public class Vala.NullabilityChecker : CodeVisitor {
	private const bool debug = false;
	private CodeContext context;
	private BasicBlock root_block;
	private BasicBlock current_block;


	public NullabilityChecker (CodeContext context) {
		this.context = context;
	}

	public void check (BasicBlock root_block) {
		this.root_block = root_block;
		this.current_block = root_block;

		if (debug) {
		  message ("==========================================");
		  root_block.print ();
		  message ("==========================================");
		}
		this.visit_basic_block (root_block);
	}

	private void get_nullability_state (Symbol symbol, out bool is_null, out bool is_non_null) {
		is_null = false;
		is_non_null = false;
		BasicBlock? b = current_block;
		while (b != null) {
			if (b.null_vars.contains (symbol)) {
				is_null = true;
				break;
			} else if (b.non_null_vars.contains (symbol)) {
				is_non_null = true;
				break;
			}
			b = b.parent;
		}
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
		if (debug)
			message ("Checking Member Access %s", access.to_string ());
		if (access.inner != null && access.inner.symbol_reference != null) {
			if (debug)
				message ("Inner: %s", access.inner.to_string ());
			bool is_null = false;
			bool is_non_null = false;
			this.get_nullability_state (access.inner.symbol_reference, out is_null, out is_non_null);

			if (is_null) {
				Report.error (access.source_reference, "`%s' is null here".printf (access.to_string ()));
			} else {
				DataType? symbol_type = context.analyzer.get_value_type_for_symbol (access.inner.symbol_reference, false);
				if (symbol_type != null) {
					// If the referenced type is nullable, and the code didn't make sure the reference
					// is not null, we need to error out here.
					if (symbol_type.nullable && !is_non_null) {
						Report.error (access.source_reference, "Access to nullable reference `%s' denied".printf (access.inner.symbol_reference.get_full_name ()));
					}
				}
			}
		}

		access.accept_children (this);
	}

	public override void visit_declaration_statement (DeclarationStatement decl) {
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
		if (assign.left != null && assign.right != null &&
		    assign.left.symbol_reference != null && assign.right.symbol_reference != null) {
			DataType? left_type = context.analyzer.get_value_type_for_symbol (assign.left.symbol_reference, false);
			if (left_type != null && !left_type.nullable) {
				DataType? right_type = context.analyzer.get_value_type_for_symbol (assign.right.symbol_reference, false);
				if (right_type != null && right_type.nullable) {
					bool is_null = false;
					bool is_non_null = false;
					this.get_nullability_state (assign.right.symbol_reference, out is_null, out is_non_null);
					if (!is_non_null) {
						Report.error (assign.source_reference, "Cannot assign from nullable `%s' to non-nullable `%s'".printf (right_type.to_string (), left_type.to_string ()));
					}
				}
			}
			// Assignments from non-nullable to nullable are always fine
		}
	}

	public override void visit_expression_statement (ExpressionStatement stmt) {
		stmt.expression.accept (this);
	}
}
