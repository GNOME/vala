/* valasignal.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

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
public class Vala.Signal : CodeNode, Invokable {
	/**
	 * The symbol name of this signal.
	 */
	public string! name { get; set construct; }
	
	/**
	 * The return type of handlers of this signal.
	 */
	public TypeReference! return_type { get; set construct; }
	
	/**
	 * Specifies the accessibility of the signal. Currently only public
	 * accessibility is supported for signals.
	 */
	public MemberAccessibility access { get; set; }
	
	/**
	 * Specifies whether this signal has an emitter wrapper function.
	 */
	public bool has_emitter { get; set; }

	private List<FormalParameter> parameters;
	private Callback generated_callback;

	private string cname;

	/**
	 * Creates a new signal.
	 *
	 * @param name        signal name
	 * @param return_type signal return type
	 * @param source      reference to source code
	 * @return            newly created signal
	 */
	public construct (string! _name, TypeReference! _return_type, SourceReference source) {
		name = _name;
		return_type = _return_type;
		source_reference = source;
	}
	
	/**
	 * Appends parameter to signal handler.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (FormalParameter! param) {
		parameters.append (param);
	}

	public override ref List<FormalParameter> get_parameters () {
		return parameters.copy ();
	}
	
	public override TypeReference get_return_type () {
		return return_type;
	}

	public override bool is_invokable () {
		return true;
	}
	
	/**
	 * Returns generated callback to be used for signal handlers.
	 *
	 * @return callback
	 */
	public Callback! get_callback () {
		if (generated_callback == null) {
			generated_callback = new Callback (null, return_type);
			generated_callback.instance = true;
			
			var sender_type = new TypeReference ();
			sender_type.data_type = (DataType) symbol.parent_symbol.node;
			var sender_param = new FormalParameter ("sender", sender_type);
			generated_callback.add_parameter (sender_param);
			
			foreach (FormalParameter! param in parameters) {
				generated_callback.add_parameter (param);
			}
		}
		
		return generated_callback;
	}

	/**
	 * Returns the name of this signal as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public string! get_cname () {
		if (cname == null) {
			cname = name;
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
	public ref CCodeConstant! get_canonical_cconstant () {
		var str = new String ("\"");
		
		string i = name;
		
		while (i.len () > 0) {
			unichar c = i.get_char ();
			if (c == '_') {
				str.append_c ('-');
			} else {
				str.append_unichar (c);
			}
			
			i = i.next_char ();
		}
		
		str.append_c ('"');
		
		return new CCodeConstant (str.str);
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_signal (this);
		
		return_type.accept (visitor);
		
		foreach (FormalParameter param in parameters) {
			param.accept (visitor);
		}

		visitor.visit_end_signal (this);
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
}
