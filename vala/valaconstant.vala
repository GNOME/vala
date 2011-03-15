/* valaconstant.vala
 *
 * Copyright (C) 2006-2011  Jürg Billeter
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
 * Represents a type member with a constant value.
 */
public class Vala.Constant : Symbol, Lockable {
	/**
	 * The data type of this constant.
	 */
	public DataType type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}

	/**
	 * The value of this constant.
	 */
	public Expression? value {
		get { return _value; }
		set {
			_value = value;
			if (_value != null) {
				_value.parent_node = this;
			}
		}
	}

	private string cname;
	
	private bool lock_used = false;

	private DataType _data_type;

	private Expression _value;

	/**
	 * Creates a new constant.
	 *
	 * @param name             constant name
	 * @param type_reference   constant type
	 * @param value            constant value
	 * @param source_reference reference to source code
	 * @return                 newly created constant
	 */
	public Constant (string name, DataType? type_reference, Expression? value, SourceReference? source_reference, Comment? comment = null) {
		base (name, source_reference, comment);
		if (type_reference != null) {
			this.type_reference = type_reference;
		}
		this.value = value;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_constant (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		type_reference.accept (visitor);

		if (value != null) {
			value.accept (visitor);
		}
	}

	/**
	 * Returns the name of this constant as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public string get_cname () {
		if (cname == null) {
			cname = get_default_cname ();
		}
		return cname;
	}

	/**
	 * Returns the default name of this constant as it is used in C
	 * code.
	 *
	 * @return the name to be used in C code by default
	 */
	public virtual string get_default_cname () {
		if (parent_symbol == null) {
			// global constant
			return name;
		} else {
			return "%s%s".printf (parent_symbol.get_lower_case_cprefix ().up (), name);
		}
	}

	public void set_cname (string value) {
		this.cname = value;
	}

	public bool get_lock_used () {
		return lock_used;
	}
	
	public void set_lock_used (bool used) {
		lock_used = used;
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (value == old_node) {
			value = new_node;
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}

	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("cname")) {
			cname = a.get_string ("cname");
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				add_cheader_filename (filename);
			}
		}
	}

	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			} else if (a.name == "Deprecated") {
				process_deprecated_attribute (a);
			} else if (a.name == "Experimental") {
				process_experimental_attribute (a);
			}
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		process_attributes ();

		var old_source_file = context.analyzer.current_source_file;
		var old_symbol = context.analyzer.current_symbol;

		if (source_reference != null) {
			context.analyzer.current_source_file = source_reference.file;
		}
		context.analyzer.current_symbol = this;

		type_reference.check (context);

		if (!check_const_type (type_reference, context)) {
			error = true;
			Report.error (source_reference, "`%s' not supported as type for constants".printf (type_reference.to_string ()));
			return false;
		}

		if (!external) {
			if (value == null) {
				error = true;
				Report.error (source_reference, "A const field requires a value to be provided");
			} else {
				value.target_type = type_reference;

				value.check (context);

				if (!value.value_type.compatible (type_reference)) {
					error = true;
					Report.error (source_reference, "Cannot convert from `%s' to `%s'".printf (value.value_type.to_string (), type_reference.to_string ()));
					return false;
				}

				// support translated string constants for efficiency / convenience
				// even though the expression is not a compile-time constant
				var call = value as MethodCall;
				if (call != null) {
					var method_type = call.call.value_type as MethodType;
					if (method_type != null && method_type.method_symbol.get_full_name () == "GLib._") {
						// first argument is string
						var literal = call.get_argument_list ().get (0) as StringLiteral;
						if (literal != null) {
							value = literal;
							literal.translate = true;
						}
					}
				}

				if (!value.is_constant ()) {
					error = true;
					Report.error (value.source_reference, "Value must be constant");
					return false;
				}
			}
		} else {
			if (value != null) {
				error = true;
				Report.error (source_reference, "External constants cannot use values");
			}
		}

		if (!external_package && !hides && get_hidden_member () != null) {
			Report.warning (source_reference, "%s hides inherited constant `%s'. Use the `new' keyword if hiding was intentional".printf (get_full_name (), get_hidden_member ().get_full_name ()));
		}

		context.analyzer.current_source_file = old_source_file;
		context.analyzer.current_symbol = old_symbol;

		active = true;

		return !error;
	}

	bool check_const_type (DataType type, CodeContext context) {
		if (type is ValueType) {
			return true;
		} else if (type is ArrayType) {
			var array_type = type as ArrayType;
			return check_const_type (array_type.element_type, context);
		} else if (type.data_type == context.analyzer.string_type.data_type) {
			return true;
		} else {
			return false;
		}
	}
}
