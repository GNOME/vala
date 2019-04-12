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
public class Vala.Delegate : TypeSymbol, Callable {
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

	private List<DataType> error_types;

	/**
	 * Creates a new delegate.
	 *
	 * @param name              delegate type name
	 * @param return_type       return type
	 * @param source_reference  reference to source code
	 * @return                  newly created delegate
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

	public bool has_type_parameters () {
		return (type_parameters != null && type_parameters.size > 0);
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

		var method_error_types = new ArrayList<DataType> ();
		m.get_error_types (method_error_types);

		// method must throw error if the delegate does
		if (error_types != null && error_types.size > 0 && method_error_types.size == 0) {
			return false;
		}

		// method may throw less but not more errors than the delegate
		foreach (DataType method_error_type in method_error_types) {
			bool match = false;
			if (error_types != null) {
				foreach (DataType delegate_error_type in error_types) {
					if (method_error_type.compatible (delegate_error_type)) {
						match = true;
						break;
					}
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

		if (error_types != null) {
			foreach (DataType error_type in error_types) {
				error_type.accept (visitor);
			}
		}
	}

	public override bool is_reference_type () {
		return false;
	}

	/**
	 * Adds an error type to the exceptions that can be
	 * thrown by this delegate.
	 */
	public void add_error_type (DataType error_type) {
		if (error_types == null) {
			error_types = new ArrayList<DataType> ();
		}
		error_types.add (error_type);
		error_type.parent_node = this;
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		if (error_types != null) {
			foreach (var error_type in error_types) {
				if (source_reference != null) {
					var type = error_type.copy ();
					type.source_reference = source_reference;
					collection.add (type);
				} else {
					collection.add (error_type);
				}
			}
		}
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (return_type == old_type) {
			return_type = new_type;
			return;
		}
		if (error_types != null) {
			for (int i = 0; i < error_types.size; i++) {
				if (error_types[i] == old_type) {
					error_types[i] = new_type;
					return;
				}
			}
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		foreach (TypeParameter p in type_parameters) {
			p.check (context);
		}

		return_type.check (context);

		foreach (Parameter param in parameters) {
			param.check (context);
		}

		if (error_types != null) {
			foreach (DataType error_type in error_types) {
				error_type.check (context);
			}
		}

		return !error;
	}
}
