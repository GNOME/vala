/* valadelegate.vala
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
 * Represents a function callback type.
 */
public class Vala.Delegate : TypeSymbol {
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
	public bool has_target {
		get {
			if (_has_target == null) {
				_has_target = get_attribute_bool ("CCode", "has_target", true);
			}
			return _has_target;
		}
		set {
			_has_target = value;
			if (value) {
				remove_attribute_argument ("CCode", "has_target");
			} else {
				set_attribute_bool ("CCode", "has_target", false);
			}
		}
	}

	public DataType? sender_type { get; set; }

	private List<TypeParameter> type_parameters = new ArrayList<TypeParameter> ();

	private List<Parameter> parameters = new ArrayList<Parameter> ();

	private DataType _return_type;
	private bool? _has_target;

	/**
	 * Creates a new delegate.
	 *
	 * @param name        delegate type name
	 * @param return_type return type
	 * @param source      reference to source code
	 * @return            newly created delegate
	 */
	public Delegate (string? name, DataType return_type, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
		this.return_type = return_type;
	}

	/**
	 * Appends the specified parameter to the list of type parameters.
	 *
	 * @param p a type parameter
	 */
	public void add_type_parameter (TypeParameter p) {
		type_parameters.add (p);
		scope.add (p.name, p);
	}

	public List<TypeParameter> get_type_parameters () {
		return type_parameters;
	}

	public override int get_type_parameter_index (string name) {
		int i = 0;
		foreach (TypeParameter parameter in type_parameters) {
			if (parameter.name == name) {
				return i;
			}
			i++;
		}
		return -1;
	}

	/**
	 * Appends paramater to this callback function.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (Parameter param) {
		parameters.add (param);
		scope.add (param.name, param);
	}

	/**
	 * Return copy of parameter list.
	 *
	 * @return parameter list
	 */
	public List<Parameter> get_parameters () {
		return parameters;
	}
	
	/**
	 * Checks whether the arguments and return type of the specified method
	 * matches this callback.
	 *
	 * @param m a method
	 * @return  true if the specified method is compatible to this callback
	 */
	public bool matches_method (Method m, DataType dt) {
		if (m.coroutine && !(parent_symbol is Signal)) {
			// async delegates are not yet supported
			return false;
		}

		// method is allowed to ensure stricter return type (stronger postcondition)
		if (!m.return_type.stricter (return_type.get_actual_type (dt, null, this))) {
			return false;
		}
		
		var method_params = m.get_parameters ();
		Iterator<Parameter> method_params_it = method_params.iterator ();

		if (sender_type != null && method_params.size == parameters.size + 1) {
			// method has sender parameter
			method_params_it.next ();

			// method is allowed to accept arguments of looser types (weaker precondition)
			var method_param = method_params_it.get ();
			if (!sender_type.stricter (method_param.variable_type)) {
				return false;
			}
		}

		bool first = true;
		foreach (Parameter param in parameters) {
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
			if (!param.variable_type.get_actual_type (dt, null, this).stricter (method_param.variable_type)) {
				return false;
			}
		}
		
		/* method may not expect more arguments */
		if (method_params_it.next ()) {
			return false;
		}

		// method may throw less but not more errors than the delegate
		foreach (DataType method_error_type in m.get_error_types ()) {
			bool match = false;
			foreach (DataType delegate_error_type in get_error_types ()) {
				if (method_error_type.compatible (delegate_error_type)) {
					match = true;
					break;
				}
			}

			if (!match) {
				return false;
			}
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
		
		foreach (Parameter param in parameters) {
			param.accept (visitor);
		}

		foreach (DataType error_type in get_error_types ()) {
			error_type.accept (visitor);
		}
	}

	public override bool is_reference_type () {
		return false;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (return_type == old_type) {
			return_type = new_type;
			return;
		}
		var error_types = get_error_types ();
		for (int i = 0; i < error_types.size; i++) {
			if (error_types[i] == old_type) {
				error_types[i] = new_type;
				return;
			}
		}
	}

	public string get_prototype_string (string name) {
		return "%s %s %s".printf (get_return_type_string (), name, get_parameters_string ());
	}

	string get_return_type_string () {
		string str = "";
		if (!return_type.value_owned && return_type is ReferenceType) {
			str = "weak ";
		}
		str += return_type.to_string ();

		return str;
	}

	string get_parameters_string () {
		string str = "(";

		int i = 1;
		foreach (Parameter param in parameters) {
			if (i > 1) {
				str += ", ";
			}

			if (param.direction == ParameterDirection.IN) {
				if (param.variable_type.value_owned) {
					str += "owned ";
				}
			} else {
				if (param.direction == ParameterDirection.REF) {
					str += "ref ";
				} else if (param.direction == ParameterDirection.OUT) {
					str += "out ";
				}
				if (!param.variable_type.value_owned && param.variable_type is ReferenceType) {
					str += "weak ";
				}
			}

			str += param.variable_type.to_string ();

			i++;
		}

		str += ")";

		return str;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		var old_source_file = context.analyzer.current_source_file;

		if (source_reference != null) {
			context.analyzer.current_source_file = source_reference.file;
		}

		foreach (TypeParameter p in type_parameters) {
			p.check (context);
		}
		
		return_type.check (context);
		
		foreach (Parameter param in parameters) {
			param.check (context);
		}

		foreach (DataType error_type in get_error_types ()) {
			error_type.check (context);
		}

		context.analyzer.current_source_file = old_source_file;

		return !error;
	}
}
