/* valatype.vala
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
 * Represents a runtime data type. This data type may be defined in Vala source
 * code or imported from an external library with a Vala API file.
 */
public abstract class Vala.DataType : CodeNode {
	/**
	 * The symbol name of this data type.
	 */
	public string! name { get; set construct; }
	
	/**
	 * Specifies the accessibility of the class. Public accessibility
	 * doesn't limit access. Default accessibility limits access to this
	 * program or library. Protected and private accessibility is not
	 * supported for types.
	 */
	public MemberAccessibility access;
	
	/**
	 * The namespace containing this data type.
	 */
	public weak Namespace @namespace;

	/**
	 * Returns the name of this data type as it is used in C code.
	 *
	 * @return the name to be used in C code
	 */
	public abstract string get_cname ();
	
	/**
	 * Checks whether this data type has value or reference type semantics.
	 *
	 * @return true if this data type has reference type semantics
	 */
	public virtual bool is_reference_type () {
		return false;
	}
	
	/**
	 * Returns the C function name that duplicates instances of this data
	 * type. The specified C function must accept one argument referencing
	 * the instance of this data type and return a reference to the
	 * duplicate.
	 *
	 * @return the name of the C function if supported or null otherwise
	 */
	public virtual string get_dup_function () {
		return null;
	}
	
	/**
	 * Returns the C function name that frees instances of this data type.
	 * This is only valid for data types with reference type semantics that
	 * do not support reference counting. The specified C function must
	 * accept one argument pointing to the instance to be freed.
	 *
	 * @return the name of the C function or null if this data type is not a
	 *         reference type or if it supports reference counting
	 */
	public virtual string get_free_function () {
		return null;
	}
	
	/**
	 * Checks whether this data type supports reference counting. This is
	 * only valid for reference types.
	 *
	 * @return true if this data type supports reference counting
	 */
	public virtual bool is_reference_counting () {
		return false;
	}
	
	/**
	 * Returns the C function name that increments the reference count of
	 * instances of this data type. This is only valid for data types
	 * supporting reference counting. The specified C function must accept
	 * one argument referencing the instance of this data type and return
	 * the reference.
	 *
	 * @return the name of the C function or null if this data type does not
	 *         support reference counting
	 */
	public virtual string get_ref_function () {
		return null;
	}
	
	/**
	 * Returns the C function name that decrements the reference count of
	 * instances of this data type. This is only valid for data types
	 * supporting reference counting. The specified C function must accept
	 * one argument referencing the instance of this data type.
	 *
	 * @return the name of the C function or null if this data type does not
	 *         support reference counting
	 */
	public virtual string get_unref_function () {
		return null;
	}
	
	/**
	 * Returns the C symbol representing the runtime type id for this data
	 * type. The specified symbol must express a registered GType.
	 *
	 * @return the name of the GType name in C code or null if this data
	 *         type is not registered with GType
	 */
	public virtual string get_type_id () {
		return null;
	}
	
	/**
	 * Returns the name of this data type as used in C code marshallers
	 *
	 * @return type name for marshallers
	 */
	public virtual string get_marshaller_type_name () {
		return null;
	}
	
	/**
	 * Returns the C name of this data type in upper case. Words are
	 * separated by underscores. The upper case C name of the namespace is
	 * prefix of the result.
	 *
	 * @param infix a string to be placed between namespace and data type
	 *              name or null
	 * @return      the upper case name to be used in C code
	 */
	public abstract ref string get_upper_case_cname (string infix);
	
	/**
	 * Returns the C name of this data type in lower case. Words are
	 * separated by underscores. The lower case C name of the namespace is
	 * prefix of the result.
	 *
	 * @param infix a string to be placed between namespace and data type
	 *              name or null
	 * @return      the lower case name to be used in C code
	 */
	public abstract ref string get_lower_case_cname (string infix);
	
	/**
	 * Returns a list of C header filenames users of this data type must
	 * include.
	 *
	 * @return list of C header filenames for this data type
	 */
	public ref List<string> get_cheader_filenames () {
		if (cheader_filenames == null) {
			/* default to header filenames of the namespace */
			foreach (string filename in @namespace.get_cheader_filenames ()) {
				add_cheader_filename (filename);
			}
		}
		return cheader_filenames.copy ();
	}

	/**
	 * Adds a filename to the list of C header filenames users of this data
	 * type must include.
	 *
	 * @param filename a C header filename
	 */
	public void add_cheader_filename (string! filename) {
		cheader_filenames.append (filename);
	}

	private List<string> cheader_filenames;
}
