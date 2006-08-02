/* valaflags.vala
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
 * Represents a flags declaration in the source code.
 */
public class Vala.Flags : DataType {
	List<FlagsValue> values;
	string cname;

	/**
	 * Creates a new flags.
	 *
	 * @param name   type name
	 * @param source reference to source code
	 * @return       newly created flags
	 */
	public construct (string! _name, SourceReference source) {
		name = _name;
		source_reference = source;
	}
	
	/**
	 * Appends the specified flags value to the list of values.
	 *
	 * @param value a flags value
	 */
	public void add_value (FlagsValue! value) {
		values.append (value);
	}
	
	public override void accept (CodeVisitor! visitor) {
		visitor.visit_begin_flags (this);
		
		foreach (FlagsValue value in values) {
			value.accept (visitor);
		}

		visitor.visit_end_flags (this);
	}

	public override string get_cname () {
		if (cname == null) {
			cname = "%s%s".printf (@namespace.get_cprefix (), name);
		}
		return cname;
	}
	
	public override ref string get_upper_case_cname (string infix) {
		return "%s%s".printf (@namespace.get_lower_case_cprefix (), Namespace.camel_case_to_lower_case (name)).up ();
	}

	public override bool is_reference_type () {
		return false;
	}
}
