/* valatrystatement.vala
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

using GLib;

/**
 * Represents a try statement in the source code.
 */
public class Vala.TryStatement : CodeNode, Statement {
	/**
	 * Specifies the body of the try statement.
	 */
	public Block body {
		get { return _body; }
		set {
			_body = value;
			_body.parent_node = this;
		}
	}

	/**
	 * Specifies the body of the optional finally clause.
	 */
	public Block? finally_body {
		get { return _finally_body; }
		set {
			_finally_body = value;
			if (_finally_body != null)
				_finally_body.parent_node = this;
		}
	}

	public bool after_try_block_reachable { get; set; default = true; }

	private Block _body;
	private Block _finally_body;
	private List<CatchClause> catch_clauses = new ArrayList<CatchClause> ();

	/**
	 * Creates a new try statement.
	 *
	 * @param body             body of the try statement
	 * @param finally_body     body of the optional finally clause
	 * @param source_reference reference to source code
	 * @return                 newly created try statement
	 */
	public TryStatement (Block body, Block? finally_body, SourceReference? source_reference = null) {
		this.body = body;
		this.finally_body = finally_body;
		this.source_reference = source_reference;
	}

	/**
	 * Appends the specified clause to the list of catch clauses.
	 *
	 * @param clause a catch clause
	 */
	public void add_catch_clause (CatchClause clause) {
		clause.parent_node = this;
		catch_clauses.add (clause);
	}

	/**
	 * Returns a copy of the list of catch clauses.
	 *
	 * @return list of catch clauses
	 */
	public List<CatchClause> get_catch_clauses () {
		return catch_clauses;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_try_statement (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		body.accept (visitor);

		foreach (CatchClause clause in catch_clauses) {
			clause.accept (visitor);
		}

		if (finally_body != null) {
			finally_body.accept (visitor);
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		body.check (context);

		var error_types = new ArrayList<DataType> ();
		foreach (DataType body_error_type in body.get_error_types ()) {
			error_types.add (body_error_type);
		}

		var handled_error_types = new ArrayList<DataType> ();
		foreach (CatchClause clause in catch_clauses) {
			foreach (DataType body_error_type in error_types) {
				if (clause.error_type == null || body_error_type.compatible (clause.error_type)) {
					handled_error_types.add (body_error_type);
				}
			}
			foreach (DataType handled_error_type in handled_error_types) {
				error_types.remove (handled_error_type);
			}
			handled_error_types.clear ();

			clause.check (context);
			foreach (DataType body_error_type in clause.body.get_error_types ()) {
				error_types.add (body_error_type);
			}
		}

		if (finally_body != null) {
			finally_body.check (context);
			foreach (DataType body_error_type in finally_body.get_error_types ()) {
				error_types.add (body_error_type);
			}
		}

		add_error_types (error_types);

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_try_statement (this);
	}
}
