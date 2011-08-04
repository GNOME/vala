/* valalambdaexpression.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Represents a lambda expression in the source code. Lambda expressions are
 * anonymous methods with implicitly typed parameters.
 */
public class Vala.LambdaExpression : Expression {
	/**
	 * The expression body of this lambda expression. Only one of
	 * expression_body or statement_body may be set.
	 */
	public Expression expression_body { get; set; }
	
	/**
	 * The statement body of this lambda expression. Only one of
	 * expression_body or statement_body may be set.
	 */
	public Block statement_body { get; set; }
	
	/**
	 * The generated method.
	 */
	public Method method { get; set; }

	private List<Parameter> parameters = new ArrayList<Parameter> ();

	/**
	 * Creates a new lambda expression.
	 *
	 * @param expression_body  expression body
	 * @param source_reference reference to source code
	 * @return                 newly created lambda expression
	 */
	public LambdaExpression (Expression expression_body, SourceReference source_reference) {
		this.source_reference = source_reference;
		this.expression_body = expression_body;
	}
	
	/**
	 * Creates a new lambda expression with statement body.
	 *
	 * @param statement_body   statement body
	 * @param source_reference reference to source code
	 * @return                 newly created lambda expression
	 */
	public LambdaExpression.with_statement_body (Block statement_body, SourceReference source_reference) {
		this.statement_body = statement_body;
		this.source_reference = source_reference;
	}
	
	/**
	 * Appends implicitly typed parameter.
	 *
	 * @param param parameter name
	 */
	public void add_parameter (Parameter param) {
		parameters.add (param);
	}
	
	/**
	 * Returns copy of parameter list.
	 *
	 * @return parameter list
	 */
	public List<Parameter> get_parameters () {
		return parameters;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_lambda_expression (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (method == null) {
			if (expression_body != null) {
				expression_body.accept (visitor);
				visitor.visit_end_full_expression (expression_body);
			} else if (statement_body != null) {
				statement_body.accept (visitor);
			}
		} else {
			method.accept (visitor);
		}
	}

	public override bool is_pure () {
		return false;
	}

	string get_lambda_name (CodeContext context) {
		var result = "_lambda%d_".printf (context.analyzer.next_lambda_id);

		context.analyzer.next_lambda_id++;

		return result;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!(target_type is DelegateType)) {
			error = true;
			Report.error (source_reference, "lambda expression not allowed in this context");
			return false;
		}

		var cb = (Delegate) ((DelegateType) target_type).delegate_symbol;
		var return_type = cb.return_type.get_actual_type (target_type, null, this);
		method = new Method (get_lambda_name (context), return_type, source_reference);
		// track usage for flow analyzer
		method.used = true;
		method.check_deprecated (source_reference);
		method.check_experimental (source_reference);

		if (!cb.has_target || !context.analyzer.is_in_instance_method ()) {
			method.binding = MemberBinding.STATIC;
		} else {
			var sym = context.analyzer.current_symbol;
			while (method.this_parameter == null) {
				if (sym is Property) {
					var prop = (Property) sym;
					method.this_parameter = prop.this_parameter;
				} else if (sym is Constructor) {
					var c = (Constructor) sym;
					method.this_parameter = c.this_parameter;
				} else if (sym is Destructor) {
					var d = (Destructor) sym;
					method.this_parameter = d.this_parameter;
				} else if (sym is Method) {
					var m = (Method) sym;
					method.this_parameter = m.this_parameter;
				}

				sym = sym.parent_symbol;
			}
		}
		method.owner = context.analyzer.current_symbol.scope;

		if (!(method.return_type is VoidType) && CodeContext.get ().profile == Profile.DOVA) {
			method.result_var = new LocalVariable (method.return_type.copy (), "result", null, source_reference);
			method.result_var.is_result = true;
		}

		var lambda_params = get_parameters ();
		Iterator<Parameter> lambda_param_it = lambda_params.iterator ();

		if (cb.sender_type != null && lambda_params.size == cb.get_parameters ().size + 1) {
			// lambda expression has sender parameter
			lambda_param_it.next ();

			Parameter lambda_param = lambda_param_it.get ();
			lambda_param.variable_type = cb.sender_type;
			method.add_parameter (lambda_param);
		}

		foreach (Parameter cb_param in cb.get_parameters ()) {
			if (!lambda_param_it.next ()) {
				/* lambda expressions are allowed to have less parameters */
				break;
			}

			Parameter lambda_param = lambda_param_it.get ();
			lambda_param.variable_type = cb_param.variable_type.get_actual_type (target_type, null, this);
			method.add_parameter (lambda_param);
		}

		if (lambda_param_it.next ()) {
			/* lambda expressions may not expect more parameters */
			error = true;
			Report.error (source_reference, "lambda expression: too many parameters");
			return false;
		}

		foreach (var error_type in cb.get_error_types ()) {
			method.add_error_type (error_type.copy ());
		}

		if (expression_body != null) {
			var block = new Block (source_reference);
			block.scope.parent_scope = method.scope;

			if (method.return_type.data_type != null) {
				if (context.profile == Profile.DOVA) {
					block.add_statement (new ExpressionStatement (new Assignment (new MemberAccess.simple ("result", source_reference), expression_body, AssignmentOperator.SIMPLE, source_reference), source_reference));
					block.add_statement (new ReturnStatement (null, source_reference));
				} else {
					block.add_statement (new ReturnStatement (expression_body, source_reference));
				}
			} else {
				block.add_statement (new ExpressionStatement (expression_body, source_reference));
			}

			method.body = block;
		} else {
			method.body = statement_body;
		}
		method.body.owner = method.scope;

		// support use of generics in closures
		var m = context.analyzer.find_parent_method (context.analyzer.current_symbol);
		if (m != null) {
			foreach (var type_param in m.get_type_parameters ()) {
				method.add_type_parameter (new TypeParameter (type_param.name, type_param.source_reference));

				method.closure = true;
				m.body.captured = true;
			}
		}

		/* lambda expressions should be usable like MemberAccess of a method */
		symbol_reference = method;

		method.check (context);

		value_type = new MethodType (method);
		value_type.value_owned = target_type.value_owned;

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_lambda_expression (this);

		codegen.visit_expression (this);
	}

	public override void get_used_variables (Collection<Variable> collection) {
		// require captured variables to be initialized
		if (method.closure) {
			method.get_captured_variables ((Collection<LocalVariable>) collection);
		}
	}
}
