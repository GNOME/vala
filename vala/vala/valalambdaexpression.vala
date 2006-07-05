/* valalambdaexpression.vala
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

/**
 * Represents a lambda expression in the source code. Lambda expressions are
 * anonymous methods with implicitly typed parameters.
 */
public class Vala.LambdaExpression : Expression {
	/**
	 * The body of this lambda expression.
	 */
	public Expression! inner { get; set construct; }
	
	/**
	 * The generated method.
	 */
	public Method method { get; set; }

	private List<string> parameters;

	/**
	 * Creates a new lambda expression.
	 *
	 * @param inner	 expression body
	 * @param source reference to source code
	 * @return       newly created lambda expression
	 */
	public static ref LambdaExpression new (Expression! inner, SourceReference source) {
		return new LambdaExpression (inner = inner, source_reference = source);
	}
	
	/**
	 * Appends implicitly typed parameter.
	 *
	 * @param param parameter name
	 */
	public void add_parameter (string! param) {
		parameters.append (param);
	}
	
	/**
	 * Returns copy of parameter list.
	 *
	 * @return parameter list
	 */
	public ref List<string> get_parameters () {
		return parameters.copy ();
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_lambda_expression (this);

		if (method == null) {
			inner.accept (visitor);
			visitor.visit_end_full_expression (inner);
		}

		visitor.visit_end_lambda_expression (this);
		
		if (method != null) {
			method.accept (visitor);
		}
	}
}
