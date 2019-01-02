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
	 * Returns the list of catch clauses.
	 *
	 * @return list of catch clauses
	 */
	public unowned List<CatchClause> get_catch_clauses () {
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

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		var error_types = new ArrayList<DataType> ();
		body.get_error_types (error_types, source_reference);

		foreach (CatchClause clause in catch_clauses) {
			for (int i=0; i < error_types.size; i++) {
				var error_type = error_types[i];
				if (clause.error_type == null || error_type.compatible (clause.error_type)) {
					error_types.remove_at (i);
					i--;
				}
			}

			clause.body.get_error_types (collection, source_reference);
		}

		if (finally_body != null) {
			finally_body.get_error_types (collection, source_reference);
		}

		foreach (var error_type in error_types) {
			collection.add (error_type);
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (context.profile == Profile.POSIX) {
			Report.error (source_reference, "`try' is not supported in POSIX profile");
			error = true;
			return false;
		}

		body.check (context);

		foreach (CatchClause clause in catch_clauses) {
			clause.check (context);
		}

		if (finally_body != null) {
			finally_body.check (context);
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_try_statement (this);
	}
}
