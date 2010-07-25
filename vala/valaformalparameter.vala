/* valaformalparameter.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
public class Vala.FormalParameter : Variable {
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
	
	/**
	 * Specifies whether the array length should be passed implicitly
	 * if the parameter type is an array.
	 */
	public bool no_array_length { get; set; }

	/**
	 * Specifies whether the array is null terminated.
	 */
	public bool array_null_terminated { get; set; }

	/**
	 * Specifies a custom type for the array length.
	 */
	public string? array_length_type { get; set; default = null; }

	/**
	 * Specifies the position of the parameter in the C function.
	 */
	public double cparameter_position { get; set; }

	/**
	 * Specifies the position of the array length parameter in the C
	 * function.
	 */
	public double carray_length_parameter_position { get; set; }

	/**
	 * Specifies the position of the delegate target parameter in the C
	 * function.
	 */
	public double cdelegate_target_parameter_position { get; set; }

	public double cdestroy_notify_parameter_position { get; set; }

	/**
	 * Specifies the type of the parameter in the C function.
	 */
	public string? ctype { get; set; }

	public bool captured { get; set; }

	/**
	 * Creates a new formal parameter.
	 *
	 * @param name   parameter name
	 * @param type   parameter type
	 * @param source reference to source code
	 * @return       newly created formal parameter
	 */
	public FormalParameter (string name, DataType variable_type, SourceReference? source_reference = null) {
		base (variable_type, name, null, source_reference);

		access = SymbolAccessibility.PUBLIC;
	}
	
	/**
	 * Creates a new ellipsis parameter representing an indefinite number of
	 * parameters.
	 */
	public FormalParameter.with_ellipsis (SourceReference? source_reference = null) {
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

	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("type")) {
			ctype = a.get_string ("type");
		}
		if (a.has_argument ("pos")) {
			cparameter_position = a.get_double ("pos");
		}
		if (a.has_argument ("array_length")) {
			no_array_length = !a.get_bool ("array_length");
		}
		if (a.has_argument ("array_length_type")) {
			array_length_type = a.get_string ("array_length_type");
		}
		if (a.has_argument ("array_null_terminated")) {
			array_null_terminated = a.get_bool ("array_null_terminated");
		}
		if (a.has_argument ("array_length_pos")) {
			carray_length_parameter_position = a.get_double ("array_length_pos");
		}
		if (a.has_argument ("delegate_target_pos")) {
			cdelegate_target_parameter_position = a.get_double ("delegate_target_pos");
		}
		if (a.has_argument ("destroy_notify_pos")) {
			cdestroy_notify_parameter_position = a.get_double ("destroy_notify_pos");
		}
	}

	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			}
		}
	}

	public FormalParameter copy () {
		if (!ellipsis) {
			var result = new FormalParameter (name, variable_type, source_reference);
			result.params_array = params_array;
			result.direction = this.direction;
			result.initializer = this.initializer;
			return result;
		} else {
			return new FormalParameter.with_ellipsis ();
		}
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		process_attributes ();

		var old_source_file = analyzer.current_source_file;
		var old_symbol = analyzer.current_symbol;

		if (source_reference != null) {
			analyzer.current_source_file = source_reference.file;
		}
		analyzer.current_symbol = parent_symbol;

		if (variable_type != null) {
			variable_type.check (analyzer);
		}

		if (!ellipsis) {
			variable_type.check (analyzer);
			
			if (params_array && !(variable_type is ArrayType)) {
				error = true;
				Report.error (source_reference, "parameter array expected");
				return false;
			}

			if (initializer != null) {
				initializer.check (analyzer);
			}
		}

		if (initializer != null) {
			if (initializer is NullLiteral
			    && !variable_type.nullable
			    && direction != ParameterDirection.OUT) {
				Report.warning (source_reference, "`null' incompatible with parameter type `%s`".printf (variable_type.to_string ()));
			}
		}

		if (!ellipsis) {
			// check whether parameter type is at least as accessible as the method
			if (!analyzer.is_type_accessible (this, variable_type)) {
				error = true;
				Report.error (source_reference, "parameter type `%s` is less accessible than method `%s`".printf (variable_type.to_string (), parent_symbol.get_full_name ()));
			}
		}

		analyzer.current_source_file = old_source_file;
		analyzer.current_symbol = old_symbol;

		return !error;
	}
}

public enum Vala.ParameterDirection {
	IN,
	OUT,
	REF
}

