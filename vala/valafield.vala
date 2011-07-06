/* valafield.vala
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
 * Represents a type or namespace field.
 */
public class Vala.Field : Variable, Lockable {
	/**
	 * Specifies whether this field may only be accessed with an instance of
	 * the contained type.
	 */
	public MemberBinding binding { get; set; default = MemberBinding.INSTANCE; }

	/**
	 * Specifies whether the field is volatile. Volatile fields are
	 * necessary to allow multi-threaded access.
	 */
	public bool is_volatile { get; set; }

	private bool lock_used = false;

	/**
	 * Creates a new field.
	 *
	 * @param name   field name
	 * @param type   field type
	 * @param init   initializer expression
	 * @param source reference to source code
	 * @return       newly created field
	 */
	public Field (string name, DataType variable_type, Expression? initializer, SourceReference? source_reference = null, Comment? comment = null) {
		base (variable_type, name, initializer, source_reference, comment);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_field (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		variable_type.accept (visitor);
		
		if (initializer != null) {
			initializer.accept (visitor);
		}
	}

	public bool get_lock_used () {
		return lock_used;
	}
	
	public void set_lock_used (bool used) {
		lock_used = used;
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (initializer == old_node) {
			initializer = new_node;
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (variable_type == old_type) {
			variable_type = new_type;
		}
	}

	public string? get_ctype () {
		return get_attribute_string ("CCode", "type");
	}

	public void set_ctype (string ctype) {
		set_attribute_string ("CCode", "type", ctype);
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		var old_source_file = context.analyzer.current_source_file;
		var old_symbol = context.analyzer.current_symbol;

		if (source_reference != null) {
			context.analyzer.current_source_file = source_reference.file;
		}
		context.analyzer.current_symbol = this;

		if (variable_type is VoidType) {
			error = true;
			Report.error (source_reference, "'void' not supported as field type");
			return false;
		}

		variable_type.check (context);

		// check whether field type is at least as accessible as the field
		if (!context.analyzer.is_type_accessible (this, variable_type)) {
			error = true;
			Report.error (source_reference, "field type `%s` is less accessible than field `%s`".printf (variable_type.to_string (), get_full_name ()));
			return false;
		}

		if (initializer != null) {
			initializer.target_type = variable_type;

			if (!initializer.check (context)) {
				error = true;
				return false;
			}

			if (initializer.value_type == null) {
				error = true;
				Report.error (source_reference, "expression type not allowed as initializer");
				return false;
			}

			if (!initializer.value_type.compatible (variable_type)) {
				error = true;
				Report.error (source_reference, "Cannot convert from `%s' to `%s'".printf (initializer.value_type.to_string (), variable_type.to_string ()));
				return false;
			}

			if (external) {
				error = true;
				Report.error (source_reference, "External fields cannot use initializers");
			}
		}

		if (binding == MemberBinding.INSTANCE && parent_symbol is Interface) {
			error = true;
			Report.error (source_reference, "Interfaces may not have instance fields");
			return false;
		}

		bool field_in_header = !is_internal_symbol ();
		if (parent_symbol is Class) {
			var cl = (Class) parent_symbol;
			if (cl.is_compact && !cl.is_internal_symbol ()) {
				// compact classes don't have priv structs
				field_in_header = true;
			}
		}

		if (!external_package && !hides && get_hidden_member () != null) {
			Report.warning (source_reference, "%s hides inherited field `%s'. Use the `new' keyword if hiding was intentional".printf (get_full_name (), get_hidden_member ().get_full_name ()));
		}

		context.analyzer.current_source_file = old_source_file;
		context.analyzer.current_symbol = old_symbol;

		return !error;
	}
}
