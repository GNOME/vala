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
public class Vala.Signal : CodeNode {
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
	public MemberAccessibility access;

	private List<FormalParameter> parameters;
	private Callback generated_callback;

	/**
	 * Creates a new signal.
	 *
	 * @param name        signal name
	 * @param return_type signal return type
	 * @param source      reference to source code
	 * @return            newly created signal
	 */
	public static ref Signal! new (string! name, TypeReference! return_type, SourceReference source) {
		return (new Signal (name = name, return_type = return_type, source_reference = source));
	}
	
	/**
	 * Appends parameter to signal handler.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (FormalParameter! param) {
		parameters.append (param);
	}

	/**
	 * Returns copy of list of signal handler parameters.
	 *
	 * @return parameter list
	 */
	public ref List<FormalParameter> get_parameters () {
		return parameters.copy ();
	}
	
	/**
	 * Returns generated callback to be used for signal handlers.
	 *
	 * @return callback
	 */
	public Callback! get_callback () {
		if (generated_callback == null) {
			generated_callback = new Callback (return_type = return_type, instance = true);
			
			var sender_param = new FormalParameter (name = "sender");
			sender_param.type_reference = new TypeReference ();
			sender_param.type_reference.data_type = (DataType) symbol.parent_symbol.node;
			generated_callback.add_parameter (sender_param);
			
			foreach (FormalParameter! param in parameters) {
				generated_callback.add_parameter (param);
			}
		}
		
		return generated_callback;
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_signal (this);
		
		return_type.accept (visitor);
		
		foreach (FormalParameter param in parameters) {
			param.accept (visitor);
		}

		visitor.visit_end_signal (this);
	}
}
