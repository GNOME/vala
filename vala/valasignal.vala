/* valasignal.vala
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
 * Represents an object signal. Signals enable objects to provide notifications.
 */
public class Vala.Signal : Symbol, Lockable {
	/**
	 * The return type of handlers of this signal.
	 */
	public DataType return_type {
		get { return _return_type; }
		set {
			_return_type = value;
			_return_type.parent_node = this;
		}
	}

	public Block body {
		get { return _body; }
		set {
			_body = value;
			if (_body != null) {
				_body.owner = scope;
			}
		}
	}

	/**
	 * Specifies whether this signal has virtual method handler.
	 */
	public bool is_virtual { get; set; }

	private List<Parameter> parameters = new ArrayList<Parameter> ();
	/**
	 * Refers to the default signal handler, which is an anonymous
	 * function in the scope.
	 * */
	public Method default_handler { get; private set; }

	private bool lock_used = false;

	private DataType _return_type;

	private Block _body;

	/**
	 * Creates a new signal.
	 *
	 * @param name        signal name
	 * @param return_type signal return type
	 * @param source      reference to source code
	 * @return            newly created signal
	 */
	public Signal (string name, DataType return_type, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
		this.return_type = return_type;
	}
	
	/**
	 * Appends parameter to signal handler.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (Parameter param) {
		parameters.add (param);
		scope.add (param.name, param);
	}

	public List<Parameter> get_parameters () {
		return parameters;
	}

	/**
	 * Returns generated delegate to be used for signal handlers.
	 *
	 * @return delegate
	 */
	public Delegate get_delegate (DataType sender_type, CodeNode node_reference) {
		var actual_return_type = return_type.get_actual_type (sender_type, null, node_reference);

		var generated_delegate = new Delegate (null, actual_return_type);
		generated_delegate.access = SymbolAccessibility.PUBLIC;
		generated_delegate.owner = scope;

		// sender parameter is never null and doesn't own its value
		var sender_param_type = sender_type.copy ();
		sender_param_type.value_owned = false;
		sender_param_type.nullable = false;

		generated_delegate.sender_type = sender_param_type;

		bool is_generic = false;

		foreach (Parameter param in parameters) {
			var actual_param = param.copy ();
			actual_param.variable_type = actual_param.variable_type.get_actual_type (sender_type, null, node_reference);
			generated_delegate.add_parameter (actual_param);

			if (actual_param.variable_type is GenericType) {
				is_generic = true;
			}
		}

		if (is_generic) {
			var cl = (ObjectTypeSymbol) parent_symbol;
			foreach (var type_param in cl.get_type_parameters ()) {
				generated_delegate.add_type_parameter (new TypeParameter (type_param.name, type_param.source_reference));
			}

			// parameter types must refer to the delegate type parameters
			// instead of to the class type parameters
			foreach (var param in generated_delegate.get_parameters ()) {
				if (param.variable_type is GenericType) {
					param.variable_type.type_parameter = generated_delegate.get_type_parameters ().get (generated_delegate.get_type_parameter_index (param.variable_type.type_parameter.name));
				}
			}
		}

		scope.add (null, generated_delegate);

		return generated_delegate;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_signal (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		return_type.accept (visitor);
		
		foreach (Parameter param in parameters) {
			param.accept (visitor);
		}
		if (default_handler == null && body != null) {
			body.accept (visitor);
		} else if (default_handler != null) {
			default_handler.accept (visitor);
		}
	}

	public bool get_lock_used () {
		return lock_used;
	}
	
	public void set_lock_used (bool used) {
		lock_used = used;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (return_type == old_type) {
			return_type = new_type;
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		return_type.check (context);
		
		foreach (Parameter param in parameters) {
			param.check (context);
		}

		if (!is_virtual && body != null) {
			Report.error (source_reference, "Only virtual signals can have a default signal handler body");
		}


		if (is_virtual) {
			default_handler = new Method (name, return_type, source_reference);

			default_handler.owner = owner;
			default_handler.access = access;
			default_handler.external = external;
			default_handler.hides = hides;
			default_handler.is_virtual = true;
			default_handler.signal_reference = this;
			default_handler.body = body;


			foreach (Parameter param in parameters) {
				default_handler.add_parameter (param);
			}

			var cl = parent_symbol as ObjectTypeSymbol;

			cl.add_hidden_method (default_handler);
			default_handler.check (context);
		}


		if (!external_package && !hides && get_hidden_member () != null) {
			Report.warning (source_reference, "%s hides inherited signal `%s'. Use the `new' keyword if hiding was intentional".printf (get_full_name (), get_hidden_member ().get_full_name ()));
		}

		return !error;
	}
}

