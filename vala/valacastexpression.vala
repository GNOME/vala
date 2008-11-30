/* valacastexpression.vala
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

using Gee;

/**
 * Represents a type cast in the source code.
 */
public class Vala.CastExpression : Expression {
	/**
	 * The expression to be cast.
	 */
	public Expression inner {
		get {
			return _inner;
		}
		set {
			_inner = value;
			_inner.parent_node = this;
		}
	}
	
	/**
	 * The target type.
	 */
	public DataType type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}

	/**
	 * Checked casts return NULL instead of raising an error.
	 */
	public bool is_silent_cast { get; set; }

	private Expression _inner;

	private DataType _data_type;

	/**
	 * Creates a new cast expression.
	 *
	 * @param inner expression to be cast
	 * @param type  target type
	 * @return      newly created cast expression
	 */
	public CastExpression (Expression inner, DataType type_reference, SourceReference source_reference, bool is_silent_cast) {
		this.type_reference = type_reference;
		this.source_reference = source_reference;
		this.is_silent_cast = is_silent_cast;
		this.inner = inner;
	}
	
	public override void accept (CodeVisitor visitor) {
		inner.accept (visitor);
		type_reference.accept (visitor);

		visitor.visit_cast_expression (this);

		visitor.visit_expression (this);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (inner == old_node) {
			inner = new_node;
		}
	}

	public override bool is_pure () {
		return inner.is_pure ();
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!inner.check (analyzer)) {
			error = true;
			return false;
		}

		type_reference.check (analyzer);

		// FIXME: check whether cast is allowed

		analyzer.current_source_file.add_type_dependency (type_reference, SourceFileDependencyType.SOURCE);

		value_type = type_reference;
		value_type.value_owned = inner.value_type.value_owned;

		inner.target_type = inner.value_type.copy ();

		return !error;
	}

	public override void get_defined_variables (Collection<LocalVariable> collection) {
		inner.get_defined_variables (collection);
	}

	public override void get_used_variables (Collection<LocalVariable> collection) {
		inner.get_used_variables (collection);
	}
}
