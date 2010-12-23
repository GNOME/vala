/* valavariable.vala
 *
 * Copyright (C) 2010  Jürg Billeter
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

public class Vala.Variable : Symbol {
	/**
	 * The optional initializer expression.
	 */
	public Expression? initializer {
		get {
			return _initializer;
		}
		set {
			_initializer = value;
			if (_initializer != null) {
				_initializer.parent_node = this;
			}
		}
	}
	
	/**
	 * The variable type.
	 */
	public DataType? variable_type {
		get { return _variable_type; }
		set {
			_variable_type = value;
			if (_variable_type != null) {
				_variable_type.parent_node = this;
			}
		}
	}

	/**
	 * Specifies whether an array length field should implicitly be created
	 * if the field type is an array.
	 */
	public bool no_array_length { get; set; }

	/**
	 * Specifies whether a delegate target field should implicitly be created
	 * if the field type is a delegate.
	 */
	public bool no_delegate_target { get; set; }

	/**
	 * Specifies whether the array is null terminated.
	 */
	public bool array_null_terminated { get; set; }

	/**
	 * Specifies whether the array length field uses a custom name in C.
	 */
	public bool has_array_length_cname {
		get { return (array_length_cname != null); }
	}

	/**
	 * Specifies whether the array uses a custom C expression as length.
	 */
	public bool has_array_length_cexpr {
		get { return (array_length_cexpr != null); }
	}

	/**
	 * Specifies a custom type for the array length.
	 */
	public string? array_length_type { get; set; default = null; }

	Expression? _initializer;
	DataType? _variable_type;

	private string? array_length_cname;

	private string? array_length_cexpr;

	public Variable (DataType? variable_type, string? name, Expression? initializer = null, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
		this.variable_type = variable_type;
		this.initializer = initializer;
	}

	/**
	 * Returns the name of the array length variable as it is used in C code
	 *
	 * @return the name of the array length variable to be used in C code
	 */
	public string? get_array_length_cname () {
		return this.array_length_cname;
	}

	/**
	 * Sets the name of the array length variable as it is used in C code
	 *
	 * @param array_length_cname the name of the array length variable to be
	 * used in C code
	 */
	public void set_array_length_cname (string? array_length_cname) {
		this.array_length_cname = array_length_cname;
	}

	/**
	 * Returns the array length expression as it is used in C code
	 *
	 * @return the array length expression to be used in C code
	 */
	public string? get_array_length_cexpr () {
		return this.array_length_cexpr;
	}


	/**
	 * Sets the array length expression as it is used in C code
	 *
	 * @param array_length_cexpr the array length expression to be used in C
	 * code
	 */
	public void set_array_length_cexpr (string? array_length_cexpr) {
		this.array_length_cexpr = array_length_cexpr;
	}

	void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("array_length")) {
			no_array_length = !a.get_bool ("array_length");
		}
		if (a.has_argument ("array_null_terminated")) {
			array_null_terminated = a.get_bool ("array_null_terminated");
		}
		if (a.has_argument ("array_length_cname")) {
			set_array_length_cname (a.get_string ("array_length_cname"));
		}
		if (a.has_argument ("array_length_cexpr")) {
			set_array_length_cexpr (a.get_string ("array_length_cexpr"));
		}
		if (a.has_argument ("array_length_type")) {
			array_length_type = a.get_string ("array_length_type");
		}
		if (a.has_argument ("delegate_target")) {
			no_delegate_target = !a.get_bool ("delegate_target");
		}
	}

	/**
	 * Process all associated attributes.
	 */
	public virtual void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			}
		}
	}
}
