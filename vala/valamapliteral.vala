/* valamapliteral.vala
 *
 * Copyright (C) 2009-2010  Jürg Billeter
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

public class Vala.MapLiteral : Literal {
	private List<Expression> keys = new ArrayList<Expression> ();
	private List<Expression> values = new ArrayList<Expression> ();

	public DataType map_key_type { get; private set; }
	public DataType map_value_type { get; private set; }

	public MapLiteral (SourceReference? source_reference = null) {
		this.source_reference = source_reference;
	}

	public override void accept_children (CodeVisitor visitor) {
		for (int i = 0; i < keys.size; i++) {
			keys[i].accept (visitor);
			values[i].accept (visitor);
		}
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_map_literal (this);

		visitor.visit_expression (this);
	}

	public void add_key (Expression expr) {
		keys.add (expr);
		expr.parent_node = this;
	}

	public void add_value (Expression expr) {
		values.add (expr);
		expr.parent_node = this;
	}

	public List<Expression> get_keys () {
		return keys;
	}

	public List<Expression> get_values () {
		return values;
	}

	public override bool is_pure () {
		return false;
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		for (int i = 0; i < keys.size; i++) {
			if (keys[i] == old_node) {
				keys[i] = new_node;
			}
			if (values[i] == old_node) {
				values[i] = new_node;
			}
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		var map_type = new ObjectType ((Class) context.root.scope.lookup ("Dova").scope.lookup ("Map"));
		map_type.value_owned = true;

		bool fixed_element_type = false;
		if (target_type != null && target_type.data_type == map_type.data_type && target_type.get_type_arguments ().size == 2) {
			map_key_type = target_type.get_type_arguments ().get (0).copy ();
			map_key_type.value_owned = false;
			map_value_type = target_type.get_type_arguments ().get (1).copy ();
			map_value_type.value_owned = false;
			fixed_element_type = true;
		}

		for (int i = 0; i < keys.size; i++) {
			if (fixed_element_type) {
				keys[i].target_type = map_key_type;
				values[i].target_type = map_value_type;
			}
			if (!keys[i].check (context)) {
				return false;
			}
			if (!values[i].check (context)) {
				return false;
			}
			if (map_key_type == null) {
				map_key_type = keys[i].value_type.copy ();
				map_key_type.value_owned = false;
				map_value_type = values[i].value_type.copy ();
				map_value_type.value_owned = false;
			}
		}

		if (map_key_type == null) {
			error = true;
			Report.error (source_reference, "cannot infer key type for map literal");
			return false;
		}

		if (map_value_type == null) {
			error = true;
			Report.error (source_reference, "cannot infer value type for map literal");
			return false;
		}

		map_key_type = map_key_type.copy ();
		map_key_type.value_owned = true;
		map_value_type = map_value_type.copy ();
		map_value_type.value_owned = true;
		map_type.add_type_argument (map_key_type);
		map_type.add_type_argument (map_value_type);
		value_type = map_type;

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		for (int i = 0; i < keys.size; i++) {
			keys[i].emit (codegen);
			values[i].emit (codegen);
		}

		codegen.visit_map_literal (this);

		codegen.visit_expression (this);
	}
}
