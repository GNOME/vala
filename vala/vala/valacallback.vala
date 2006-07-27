/* valacallback.vala
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
 * Represents a function callback type.
 */
public class Vala.Callback : DataType {
	/**
	 * The return type of this callback.
	 */
	public TypeReference return_type { get; set; }
	
	/**
	 * Specifies whether callback supports calling instance methods.
	 * The reference to the object instance will be appended to the end of
	 * the argument list in the generated C code.
	 */
	public bool instance { get; set; }
	
	private List<TypeParameter> type_parameters;

	private List<FormalParameter> parameters;
	private string cname;
	
	/**
	 * Creates a new callback.
	 *
	 * @param name        callback type name
	 * @param return_type return type
	 * @param source      reference to source code
	 * @return            newly created callback
	 */
	public static ref Callback new (string! name, TypeReference return_type, SourceReference source) {
		return (new Callback (name = name, return_type = return_type, source_reference = source));
	}

	/**
	 * Appends the specified parameter to the list of type parameters.
	 *
	 * @param p a type parameter
	 */
	public void add_type_parameter (TypeParameter! p) {
		type_parameters.append (p);
		p.type = this;
	}
	
	/**
	 * Appends paramater to this callback function.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (FormalParameter! param) {
		parameters.append (param);
	}

	/**
	 * Return copy of parameter list.
	 *
	 * @return parameter list
	 */
	public ref List<FormalParameter> get_parameters () {
		return parameters.copy ();
	}
	
	/**
	 * Checks whether the arguments and return type of the specified method
	 * matches this callback.
	 *
	 * @param m a method
	 * @return  true if the specified method is compatible to this callback
	 */
	public bool matches_method (Method! m) {
		if (!m.return_type.stricter (return_type)) {
			return false;
		}
		
		var method_params = m.get_parameters ();
		var method_params_it = method_params;
		foreach (FormalParameter param in parameters) {
			/* method is allowed to accept less arguments */
			if (method_params_it == null) {
				break;
			}
			
			var method_param = (FormalParameter) method_params_it.data;
			if (!param.type_reference.stricter (method_param.type_reference)) {
				return false;
			}
			
			method_params_it = method_params_it.next;
		}
		
		/* method may not expect more arguments */
		if (method_params_it != null) {
			return false;
		}
		
		return true;
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_callback (this);

		foreach (TypeParameter p in type_parameters) {
			p.accept (visitor);
		}
		
		return_type.accept (visitor);
		
		foreach (FormalParameter! param in parameters) {
			param.accept (visitor);
		}

		visitor.visit_end_callback (this);
	}

	public override string get_cname () {
		if (cname == null) {
			cname = "%s%s".printf (@namespace.get_cprefix (), name);
		}
		return cname;
	}

	public override bool is_reference_type () {
		return false;
	}
}
