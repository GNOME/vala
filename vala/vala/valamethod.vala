/* valamethod.vala
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
 * Represents a type or namespace method.
 */
public class Vala.Method : CodeNode {
	/**
	 * The symbol name of this method.
	 */
	public string! name { get; set construct; }

	/**
	 * The return type of this method.
	 */
	public TypeReference! return_type { get; set construct; }
	
	public Statement body { get; set; }
	
	/**
	 * Specifies the accessibility of this method. Public accessibility
	 * doesn't limit access. Default accessibility limits access to this
	 * program or library. Private accessibility limits access to instances
	 * of the contained type.
	 */
	public MemberAccessibility access;
	
	/**
	 * Specifies whether this method may only be called with an instance of
	 * the contained type.
	 */
	public bool instance {
		get {
			return _instance;
		}
		set {
			_instance = value;
		}
	}
	
	/**
	 * Specifies whether this method is abstract. Abstract methods have no
	 * body, may only be specified within abstract classes, and must be
	 * overriden by derived non-abstract classes.
	 */
	public bool is_abstract { get; set; }
	
	/**
	 * Specifies whether this method is virtual. Virtual methods may be
	 * overridden by derived classes.
	 */
	public bool is_virtual { get; set; }
	
	/**
	 * Specifies whether this method overrides a virtual or abstract method
	 * of a base type.
	 */
	public bool overrides { get; set; }

	/**
	 * Specifies whether the C method returns a new instance pointer which
	 * may be different from the previous instance pointer. Only valid for
	 * imported methods.
	 */
	public bool returns_modified_pointer { get; set; }
	
	/**
	 * Specifies whether the instance pointer should be passed as the first
	 * or as the last argument in C code. Defaults to first.
	 */
	public bool instance_last { get; set; }
	
	/**
	 * Specifies the virtual or abstract method this method overrides.
	 * Reference must be weak as virtual methods set base_method to
	 * themselves.
	 */
	public weak Method base_method { get; set; }
	
	/**
	 * Specifies the generated `this' parameter for instance methods.
	 */
	public FormalParameter this_parameter { get; set; }

	private bool _instance = true;
	private List<FormalParameter> parameters;
	private string cname;
	
	/**
	 * Creates a new method.
	 *
	 * @param name        method name
	 * @param return_type method return type
	 * @param source      reference to source code
	 * @return            newly created method
	 */
	public static ref Method! new (string! name, TypeReference! return_type, SourceReference source) {
		return (new Method (name = name, return_type = return_type, source_reference = source));
	}
	
	/**
	 * Appends parameter to this method.
	 *
	 * @param param a formal parameter
	 */
	public void add_parameter (FormalParameter! param) {
		parameters.append (param);
	}
	
	/**
	 * Returns copy of the list of method parameters.
	 *
	 * @return parameter list
	 */
	public ref List<FormalParameter> get_parameters () {
		return parameters.copy ();
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_begin_method (this);
		
		return_type.accept (visitor);
		
		foreach (FormalParameter param in parameters) {
			param.accept (visitor);
		}
		
		if (body != null) {
			body.accept (visitor);
		}

		visitor.visit_end_method (this);
	}

	/**
	 * Returns the interface name of this method as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public string! get_cname () {
		if (cname == null) {
			var parent = symbol.parent_symbol.node;
			if (parent is DataType) {
				cname = "%s_%s".printf (((DataType) parent).get_lower_case_cname (null), name);
			} else if (parent is Namespace) {
				cname = "%s%s".printf (((Namespace) parent).get_lower_case_cprefix (), name);
			} else {
				cname = name;
			}
		}
		return cname;
	}

	/**
	 * Returns the implementation name of this data type as it is used in C
	 * code.
	 *
	 * @return the name to be used in C code
	 */
	public ref string! get_real_cname () {
		if (is_virtual || overrides) {
			var parent = (Class) symbol.parent_symbol.node;
			return "%s_real_%s".printf (parent.get_lower_case_cname (null), name);
		} else {
			return get_cname ();
		}
	}
	
	private void set_cname (string cname) {
		this.cname = cname;
	}
	
	private void process_ccode_attribute (Attribute a) {
		foreach (NamedArgument arg in a.args) {
			if (arg.name == "cname") {
				/* this will already be checked during semantic analysis */
				if (arg.argument is LiteralExpression) {
					var lit = ((LiteralExpression) arg.argument).literal;
					if (lit is StringLiteral) {
						set_cname (((StringLiteral) lit).eval ());
					}
				}
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
			} else if (a.name == "ReturnsModifiedPointer") {
				returns_modified_pointer = true;
			} else if (a.name == "InstanceLast") {
				instance_last = true;
			} else if (a.name == "FloatingReference") {
				return_type.floating_reference = true;
			}
		}
	}
}
