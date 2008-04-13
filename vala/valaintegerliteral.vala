/* valaintegerliteral.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
 * Represents an integer literal in the source code.
 */
public class Vala.IntegerLiteral : Literal {
	/**
	 * The literal value.
	 */
	public string value { get; set; }

	/**
	 * Creates a new integer literal.
	 *
	 * @param i      literal value
	 * @param source reference to source code
	 * @return       newly created integer literal
	 */
	public IntegerLiteral (string i, SourceReference? source = null) {
		value = i;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor visitor) {
		visitor.visit_integer_literal (this);
	}

	public override string to_string () {
		return value;
	}
	
	/**
	 * Returns the type name of the value this literal represents.
	 *
	 * @return the name of literal type
	 */
	public string get_type_name () {
		string number = value;
	
		int l = 0;
		while (number.has_suffix ("L")) {
			l++;
			number = number.ndup (number.size () - 1);
		}

		bool u = false;
		if (number.has_suffix ("U")) {
			u = true;
			number = number.ndup (number.size () - 1);
		}
		
		int64 n = number.to_int64 ();
		if (!u && n > 0x7fffffff) {
			// value doesn't fit into signed 32-bit
			l = 2;
		} else if (u && n > 0xffffffff) {
			// value doesn't fit into unsigned 32-bit
			l = 2;
		}

		if (l == 0) {
			if (u) {
				return "uint";
			} else {
				return "int";
			}
		} else if (l == 1) {
			if (u) {
				return "ulong";
			} else {
				return "long";
			}
		} else {
			if (u) {
				return "uint64";
			} else {
				return "int64";
			}
		}
	}

	public override bool is_pure () {
		return true;
	}
}
