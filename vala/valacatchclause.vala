/* valacatchclause.vala
 *
 * Copyright (C) 2007-2010  Jürg Billeter
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


/**
 * Represents a catch clause in a try statement in the source code.
 */
public class Vala.CatchClause : CodeNode {
	/**
	 * Specifies the error type.
	 */
	public DataType? error_type {
		get { return _data_type; }
		set {
			_data_type = value;
			if (_data_type != null) {
				_data_type.parent_node = this;
			}
		}
	}
	
	/**
	 * Specifies the error variable name.
	 */
	public string? variable_name { get; set; }
	
	/**
	 * Specifies the error handler body.
	 */
	public Block body {
		get { return _body; }
		set {
			_body = value;
			_body.parent_node = this;
		}
	}
	
	/**
	 * Specifies the declarator for the generated error variable.
	 */
	public LocalVariable error_variable {
		get { return _error_variable; }
		set {
			_error_variable = value;
			_error_variable.parent_node = this;
		}
	}

	/**
	 * Specifies the label used for this catch clause in the C code.
	 */
	public string? clabel_name { get; set; }

	private DataType _data_type;

	private Block _body;
	private LocalVariable _error_variable;

	/**
	 * Creates a new catch 
	 *
	 * @param type_reference   error type
	 * @param variable_name    error variable name
	 * @param body             error handler body
	 * @param source_reference reference to source code
	 * @return                 newly created catch clause
	 */
	public CatchClause (DataType? error_type, string? variable_name, Block body, SourceReference? source_reference = null) {
		this.error_type = error_type;
		this.variable_name = variable_name;
		this.body = body;
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_catch_clause (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (error_type != null) {
			error_type.accept (visitor);
		}

		body.accept (visitor);
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (error_type == old_type) {
			error_type = new_type;
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (error_type != null) {
			if (variable_name != null) {
				error_variable = new LocalVariable (error_type.copy (), variable_name);

				body.scope.add (variable_name, error_variable);
				body.add_local_variable (error_variable);

				error_variable.checked = true;
			}
		} else {
			// generic catch clause
			if (context.profile == Profile.GOBJECT) {
				error_type = new ErrorType (null, null, source_reference);
			} else {
				error_type = context.analyzer.error_type;
			}
		}

		error_type.check (context);

		body.check (context);

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		if (error_variable != null) {
			error_variable.active = true;
		}

		codegen.visit_catch_clause (this);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		if (error_variable != null) {
			collection.add (error_variable);
		}
	}
}
