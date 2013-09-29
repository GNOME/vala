/* valaparameter.vala
 *
 * Copyright (C) 2006-2012  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

/**
 * Represents a formal parameter in method and callback signatures.
 */
public class Vala.Parameter : Variable {
	public ParameterDirection direction { get; set; default = ParameterDirection.IN; }

	/**
	 * Specifies whether the methods accepts an indefinite number of
	 * parameters.
	 */
	public bool ellipsis { get; set; }
	
	/**
	 * Specifies whether the methods accepts an indefinite number of
	 * parameters.
	 */
	public bool params_array { get; set; }
	
	public bool captured { get; set; }

	/**
	 * The base parameter of this parameter relative to the base method.
	 */
	public Parameter base_parameter { get; set; }

	/**
	 * Creates a new formal parameter.
	 *
	 * @param name   parameter name
	 * @param type   parameter type
	 * @param source reference to source code
	 * @return       newly created formal parameter
	 */
	public Parameter (string name, DataType? variable_type, SourceReference? source_reference = null) {
		base (variable_type, name, null, source_reference);

		access = SymbolAccessibility.PUBLIC;
	}
	
	/**
	 * Creates a new ellipsis parameter representing an indefinite number of
	 * parameters.
	 */
	public Parameter.with_ellipsis (SourceReference? source_reference = null) {
		base (null, null, null, source_reference);
		ellipsis = true;

		access = SymbolAccessibility.PUBLIC;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_formal_parameter (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (!ellipsis) {
			variable_type.accept (visitor);
			
			if (initializer != null) {
				initializer.accept (visitor);
			}
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (variable_type == old_type) {
			variable_type = new_type;
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (initializer == old_node) {
			initializer = new_node;
		}
	}

	public Parameter copy () {
		if (!ellipsis) {
			var result = new Parameter (name, variable_type, source_reference);
			result.params_array = params_array;
			result.direction = this.direction;
			result.initializer = this.initializer;

			// cannot use List.copy()
			// as it returns a list of unowned elements
			foreach (Attribute a in this.attributes) {
				result.attributes.append (a);
			}

			return result;
		} else {
			return new Parameter.with_ellipsis ();
		}
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
		context.analyzer.current_symbol = parent_symbol;

		if (variable_type != null) {
			if (variable_type is VoidType) {
				error = true;
				Report.error (source_reference, "'void' not supported as parameter type");
				return false;
			}
			variable_type.check (context);
		}

		if (!ellipsis) {
			variable_type.check (context);
			
			if (params_array && !(variable_type is ArrayType)) {
				error = true;
				Report.error (source_reference, "parameter array expected");
				return false;
			}

			if (has_attribute_argument ("CCode", "scope") && variable_type is DelegateType) {
				var delegate_type = (DelegateType) variable_type;
				delegate_type.is_called_once = get_attribute_string ("CCode", "scope") == "async";
			}

			if (initializer != null) {
				initializer.target_type = variable_type.copy ();
				initializer.check (context);
			}
		}

		if (initializer != null) {
			if (initializer is NullLiteral
			    && !variable_type.nullable
			    && direction != ParameterDirection.OUT) {
				Report.warning (source_reference, "`null' incompatible with parameter type `%s`".printf (variable_type.to_string ()));
			} else if (!(initializer is NullLiteral) && direction == ParameterDirection.OUT) {
				Report.error (source_reference, "only `null' is allowed as default value for out parameters");
			} else if (direction == ParameterDirection.IN && !initializer.value_type.compatible (variable_type)) {
				Report.error (initializer.source_reference, "Cannot convert from `%s' to `%s'".printf (initializer.value_type.to_string (), variable_type.to_string ()));
			} else if (direction == ParameterDirection.REF) {
				Report.error (source_reference, "default value not allowed for ref parameter");
			}
		}

		if (!ellipsis) {
			// check whether parameter type is at least as accessible as the method
			if (!context.analyzer.is_type_accessible (this, variable_type)) {
				error = true;
				Report.error (source_reference, "parameter type `%s` is less accessible than method `%s`".printf (variable_type.to_string (), parent_symbol.get_full_name ()));
			}
		}

		var m = parent_symbol as Method;
		if (m != null) {
			Method base_method = m.base_method != null ? m.base_method : m.base_interface_method;
			if (base_method != null && base_method != m) {
				int index = m.get_parameters ().index_of (this);
				if (index >= 0) {
					base_parameter = base_method.get_parameters ().get (index);
				}
			}
		}

		context.analyzer.current_source_file = old_source_file;
		context.analyzer.current_symbol = old_symbol;

		return !error;
	}
}

public enum Vala.ParameterDirection {
	IN,
	OUT,
	REF
}

