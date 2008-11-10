/* valalambdaexpression.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
using Gee;

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

	private Gee.List<string> parameters = new ArrayList<string> ();

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
	public void add_parameter (string param) {
		parameters.add (param);
	}
	
	/**
	 * Returns copy of parameter list.
	 *
	 * @return parameter list
	 */
	public Gee.List<string> get_parameters () {
		return new ReadOnlyList<string> (parameters);
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

	string get_lambda_name (SemanticAnalyzer analyzer) {
		var result = "__lambda%d".printf (analyzer.next_lambda_id);

		analyzer.next_lambda_id++;

		return result;
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!(target_type is DelegateType)) {
			error = true;
			Report.error (source_reference, "lambda expression not allowed in this context");
			return false;
		}

		bool in_instance_method = false;
		var current_method = analyzer.find_current_method ();
		if (current_method != null) {
			in_instance_method = (current_method.binding == MemberBinding.INSTANCE);
		} else {
			in_instance_method = analyzer.is_in_constructor ();
		}

		var cb = (Delegate) ((DelegateType) target_type).delegate_symbol;
		method = new Method (get_lambda_name (analyzer), cb.return_type);
		if (!cb.has_target || !in_instance_method) {
			method.binding = MemberBinding.STATIC;
		}
		method.owner = analyzer.current_symbol.scope;

		var lambda_params = get_parameters ();
		Iterator<string> lambda_param_it = lambda_params.iterator ();
		foreach (FormalParameter cb_param in cb.get_parameters ()) {
			if (!lambda_param_it.next ()) {
				/* lambda expressions are allowed to have less parameters */
				break;
			}

			string lambda_param = lambda_param_it.get ();

			var param = new FormalParameter (lambda_param, cb_param.parameter_type);

			method.add_parameter (param);
		}

		if (lambda_param_it.next ()) {
			/* lambda expressions may not expect more parameters */
			error = true;
			Report.error (source_reference, "lambda expression: too many parameters");
			return false;
		}

		if (expression_body != null) {
			var block = new Block (source_reference);
			block.scope.parent_scope = method.scope;

			if (method.return_type.data_type != null) {
				block.add_statement (new ReturnStatement (expression_body, source_reference));
			} else {
				block.add_statement (new ExpressionStatement (expression_body, source_reference));
			}

			method.body = block;
		} else {
			method.body = statement_body;
		}
		method.body.owner = method.scope;

		/* lambda expressions should be usable like MemberAccess of a method */
		symbol_reference = method;

		accept_children (analyzer);

		value_type = new MethodType (method);

		return !error;
	}
}
