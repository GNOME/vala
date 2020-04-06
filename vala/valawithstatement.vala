/* valawithtatement.vala
 *
 * Copyright (C) 2020 Nick Schrader
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
 * Authors:
 * 	Nick Schrader <nick.schrader@mailbox.org>
 */

using GLib;

public class Vala.WithStatement : Block {
	private static int next_with_id = 0;

	/**
	 * Expression representing the type of body's dominant scope.
	 */
	public Expression expression {
		get { return _expression; }
		private set {
			_expression = value;
			_expression.parent_node = this;
		}
	}

	/**
	 * Specifies the with-variable type.
	 */
	public DataType? type_reference {
		get { return _data_type; }
		private set {
			_data_type = value;
			if (_data_type != null) {
				_data_type.parent_node = this;
			}
		}
	}

	/**
	 * Specifies the with-variable name.
	 */
	public string? with_variable_name { get; private set; }

	/**
	 * Specifies the with-variable.
	 */
	public LocalVariable with_variable { get; private set; }

	/**
	 * The block which dominant scope is type of expression.
	 */
	public Block body {
		get { return _body; }
		private set {
			_body = value;
			if (_body != null) {
				_body.parent_node = this;
			}
		}
	}

	private Expression _expression;
	private Block _body;
	private DataType? _data_type;

	public WithStatement (DataType? type_reference, string? variable_name, Expression expression,
			Block body, SourceReference? source_reference = null) {
		base (source_reference);
		this.expression = expression;
		this.body = body;
		this.type_reference = type_reference;
		this.with_variable_name = variable_name;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_with_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (expression.symbol_reference == with_variable) {
			expression.accept (visitor);
		}

		if (type_reference != null) {
			type_reference.accept (visitor);
		}

		if (body != null) {
			body.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (expression == old_node) {
			expression = new_node;
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}

	bool is_object_or_value_type (DataType? type) {
		if (type == null) {
			return false;
		} else if (type is PointerType) {
			var pointer_type = (PointerType) type;
			return is_object_or_value_type (pointer_type.base_type) && expression is PointerIndirection;
		} else {
			return type is ObjectType || type is ValueType;
		}
	}

	void insert_local_variable_if_necessary () {
		var local_var = expression.symbol_reference as LocalVariable;
		if (with_variable_name != null || local_var == null) {
			var n = with_variable_name ?? "_with_local%d_".printf (next_with_id++);
			local_var = new LocalVariable (type_reference, n, expression, source_reference);
			body.insert_statement (0, new DeclarationStatement (local_var, source_reference));
		}
		with_variable = local_var;
	}

	void change_scope_and_check_body (CodeContext context) {
		var old_symbol = context.analyzer.current_symbol;
		owner = context.analyzer.current_symbol.scope;
		context.analyzer.current_symbol = this;
		body.check (context);
		context.analyzer.current_symbol = old_symbol;
	}

	bool is_type_reference_compatible () {
		if (type_reference == null) {
			type_reference = expression.value_type.copy ();
		}

		return expression.value_type.compatible (type_reference);
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;
		if (expression.check (context)) {
			if (!is_object_or_value_type (expression.value_type)) {
				error = true;
				Report.error (expression.source_reference, "With: Expression must be of an object or basic type");
			} else if (!is_type_reference_compatible ()) {
				error = true;
				Report.error (type_reference.source_reference, @"With: Cannot convert from `$(expression.value_type)' to `$(type_reference)'");
			} else {
				insert_local_variable_if_necessary ();
				change_scope_and_check_body (context);
			}
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		if (expression.symbol_reference == with_variable) {
			expression.emit (codegen);
		}
		body.emit (codegen);
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		if (source_reference == null) {
			source_reference = this.source_reference;
		}
		expression.get_error_types (collection, source_reference);
		body.get_error_types (collection, source_reference);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		if (expression.symbol_reference != with_variable) {
			collection.add (with_variable);
		}
	}
}
