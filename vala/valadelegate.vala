/* valadelegate.vala
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

using GLib;
using Gee;

/**
 * Represents a function callback type.
 */
public class Vala.Delegate : Typesymbol {
	/**
	 * The return type of this callback.
	 */
	public DataType return_type {
		get { return _return_type; }
		set {
			_return_type = value;
			_return_type.parent_node = this;
		}
	}

	/**
	 * Specifies whether callback supports calling instance methods.
	 * The reference to the object instance will be appended to the end of
	 * the argument list in the generated C code.
	 */
	public bool has_target { get; set; }

	/**
	 * Specifies the position of the instance parameter in the C function.
	 */
	public double cinstance_parameter_position { get; set; }

	/**
	 * Specifies the position of the array length out parameter in the C
	 * function.
	 */
	public double carray_length_parameter_position { get; set; }

	/**
	 * Specifies the position of the delegate target out parameter in the C
	 * function.
	 */
	public double cdelegate_target_parameter_position { get; set; }

	/**
	 * Specifies whether the array length should implicitly be passed
	 * if the parameter type is an array.
	 */
	public bool no_array_length {
		get {
			return _no_array_length;
		}
		set {
			_no_array_length = value;
			foreach (FormalParameter param in parameters) {
				param.no_array_length = value;
			}
		}
	}

	private Gee.List<TypeParameter> type_parameters = new ArrayList<TypeParameter> ();

	private Gee.List<FormalParameter> parameters = new ArrayList<FormalParameter> ();
	private string cname;

	private DataType _return_type;
	private bool _no_array_length;

	/**
	 * Creates a new delegate.
	 *
	 * @param name        delegate type name
	 * @param return_type return type
	 * @param source      reference to source code
	 * @return            newly created delegate
	 */
	public Delegate (string? name, DataType return_type, SourceReference? source_reference = null) {
		this.name = name;
		this.return_type = return_type;
		this.source_reference = source_reference;
	}

	construct {
		cinstance_parameter_position = -1;
		carray_length_parameter_position = -3;
		cdelegate_target_parameter_position = -3;
	}

	/**
	 * Appends the specified parameter to the list of type parameters.
	 *
	 * @param p a type parameter
	 */
	public void add_type_parameter (TypeParameter p) {
		type_parameters.add (p);
		p.type = this;
		scope.add (p.name, p);
	}
	
	/**
	 * Appends paramater to this callback function.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (FormalParameter param) {
		if (no_array_length) {
			param.no_array_length = true;
		}
		// default C parameter position
		param.cparameter_position = parameters.size + 1;
		param.carray_length_parameter_position = param.cparameter_position + 0.1;
		param.cdelegate_target_parameter_position = param.cparameter_position + 0.1;

		parameters.add (param);
		scope.add (param.name, param);
	}

	/**
	 * Return copy of parameter list.
	 *
	 * @return parameter list
	 */
	public Gee.List<FormalParameter> get_parameters () {
		return new ReadOnlyList<FormalParameter> (parameters);
	}
	
	/**
	 * Checks whether the arguments and return type of the specified method
	 * matches this callback.
	 *
	 * @param m a method
	 * @return  true if the specified method is compatible to this callback
	 */
	public bool matches_method (Method m) {
		// method is allowed to ensure stricter return type (stronger postcondition)
		if (!m.return_type.stricter (return_type)) {
			return false;
		}
		
		var method_params = m.get_parameters ();
		Iterator<FormalParameter> method_params_it = method_params.iterator ();
		bool first = true;
		foreach (FormalParameter param in parameters) {
			/* use first callback parameter as instance parameter if
			 * an instance method is being compared to a static
			 * callback
			 */
			if (first && m.binding == MemberBinding.INSTANCE && !has_target) {
				first = false;
				continue;
			}

			/* method is allowed to accept less arguments */
			if (!method_params_it.next ()) {
				break;
			}

			// method is allowed to accept arguments of looser types (weaker precondition)
			var method_param = method_params_it.get ();
			if (!param.type_reference.stricter (method_param.type_reference)) {
				return false;
			}
		}
		
		/* method may not expect more arguments */
		if (method_params_it.next ()) {
			return false;
		}
		
		return true;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_delegate (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (TypeParameter p in type_parameters) {
			p.accept (visitor);
		}
		
		return_type.accept (visitor);
		
		foreach (FormalParameter param in parameters) {
			param.accept (visitor);
		}
	}

	public override string get_cname (bool const_type = false) {
		if (cname == null) {
			cname = "%s%s".printf (parent_symbol.get_cprefix (), name);
		}
		return cname;
	}

	/**
	 * Sets the name of this callback as it is used in C code.
	 *
	 * @param cname the name to be used in C code
	 */
	public void set_cname (string cname) {
		this.cname = cname;
	}

	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("cname")) {
			set_cname (a.get_string ("cname"));
		}
		if (a.has_argument ("instance_pos")) {
			cinstance_parameter_position = a.get_double ("instance_pos");
		}
		if (a.has_argument ("array_length_pos")) {
			carray_length_parameter_position = a.get_double ("array_length_pos");
		}
		if (a.has_argument ("delegate_target_pos")) {
			cdelegate_target_parameter_position = a.get_double ("delegate_target_pos");
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
			} else if (a.name == "NoArrayLength") {
				no_array_length = true;
			}
		}
	}

	public override bool is_reference_type () {
		return false;
	}

	public override string? get_type_id () {
		return "G_TYPE_POINTER";
	}

	public override string? get_marshaller_type_name () {
		return "POINTER";
	}

	public override string? get_get_value_function () {
		return "g_value_get_pointer";
	}
	
	public override string? get_set_value_function () {
		return "g_value_set_pointer";
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (return_type == old_type) {
			return_type = new_type;
		}
	}
}
