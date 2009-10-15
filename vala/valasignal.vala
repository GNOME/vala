/* valasignal.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
public class Vala.Signal : Member, Lockable {
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
	 * Specifies whether this signal has an emitter wrapper function.
	 */
	public bool has_emitter { get; set; }
	
	/**
	 * Specifies whether this signal has virtual method handler.
	 */
	public bool is_virtual { get; set; }

	private List<FormalParameter> parameters = new ArrayList<FormalParameter> ();
	/**
	 * Refers to the default signal handler, which is an anonymous
	 * function in the scope.
	 * */
	public Method default_handler { get; private set; }

	private string cname;
	
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
	public void add_parameter (FormalParameter param) {
		// default C parameter position
		param.cparameter_position = parameters.size + 1;
		param.carray_length_parameter_position = param.cparameter_position + 0.1;
		param.cdelegate_target_parameter_position = param.cparameter_position + 0.1;

		parameters.add (param);
		scope.add (param.name, param);
	}

	public List<FormalParameter> get_parameters () {
		return new ReadOnlyList<FormalParameter> (parameters);
	}

	/**
	 * Returns generated delegate to be used for signal handlers.
	 *
	 * @return delegate
	 */
	public Delegate get_delegate (DataType sender_type, CodeNode node_reference) {
		var actual_return_type = return_type.get_actual_type (sender_type, null, node_reference);

		var generated_delegate = new Delegate (null, actual_return_type);
		generated_delegate.has_target = true;
		generated_delegate.access = SymbolAccessibility.PUBLIC;
		generated_delegate.owner = scope;

		// sender parameter is never null and doesn't own its value
		var sender_param_type = sender_type.copy ();
		sender_param_type.value_owned = false;
		sender_param_type.nullable = false;

		generated_delegate.sender_type = sender_param_type;

		foreach (FormalParameter param in parameters) {
			var actual_param = param.copy ();
			actual_param.parameter_type = actual_param.parameter_type.get_actual_type (sender_type, null, node_reference);
			generated_delegate.add_parameter (actual_param);
		}

		scope.add (null, generated_delegate);

		return generated_delegate;
	}

	/**
	 * Returns the name of this signal as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public string get_cname () {
		if (cname == null) {
			cname = camel_case_to_lower_case (name);
		}
		return cname;
	}
	
	public void set_cname (string cname) {
		this.cname = cname;
	}
	
	/**
	 * Returns the string literal of this signal to be used in C code.
	 *
	 * @return string literal to be used in C code
	 */
	public CCodeConstant get_canonical_cconstant (string? detail = null) {
		var str = new StringBuilder ("\"");
		
		string i = get_cname ();
		
		while (i.len () > 0) {
			unichar c = i.get_char ();
			if (c == '_') {
				str.append_c ('-');
			} else {
				str.append_unichar (c);
			}
			
			i = i.next_char ();
		}

		if (detail != null) {
			str.append ("::");
			str.append (detail);
		}

		str.append_c ('"');
		
		return new CCodeConstant (str.str);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_member (this);
		
		visitor.visit_signal (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		return_type.accept (visitor);
		
		foreach (FormalParameter param in parameters) {
			param.accept (visitor);
		}
		if (default_handler != null) {
			default_handler.accept (visitor);
		}
	}

	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "HasEmitter") {
				has_emitter = true;
			}
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

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		process_attributes ();

		return_type.check (analyzer);
		
		foreach (FormalParameter param in parameters) {
			param.check (analyzer);
		}

		if (!is_virtual && body != null) {
			Report.error (source_reference, "Only virtual signals can have a default signal handler body");
		}


		if (is_virtual) {
			default_handler = new Method (name, return_type, source_reference);

			default_handler.owner = owner;
			default_handler.access = access;
			default_handler.external = external;
			default_handler.is_virtual = true;
			default_handler.vfunc_name = name;
			default_handler.signal_reference = this;
			default_handler.body = body;


			foreach (FormalParameter param in parameters) {
				default_handler.add_parameter (param);
			}

			var cl = parent_symbol as Class;

			cl.add_hidden_method (default_handler);
			default_handler.check (analyzer);
		}


		if (!external_package && !hides && get_hidden_member () != null) {
			Report.warning (source_reference, "%s hides inherited signal `%s'. Use the `new' keyword if hiding was intentional".printf (get_full_name (), get_hidden_member ().get_full_name ()));
		}

		return !error;
	}
}

