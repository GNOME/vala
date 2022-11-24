/* valaintegerliteral.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
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
	public string value { get; private set; }

	public string type_suffix { get; private set; }

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

		visitor.visit_expression (this);
	}

	public override string to_string () {
		return value;
	}

	public override bool is_pure () {
		return true;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		int l = 0;
		while (value.has_suffix ("l") || value.has_suffix ("L")) {
			l++;
			value = value.substring (0, value.length - 1);
		}

		bool u = false;
		if (value.has_suffix ("u") || value.has_suffix ("U")) {
			u = true;
			value = value.substring (0, value.length - 1);
		}

		bool negative = value.has_prefix ("-");
		if (negative && u) {
			Report.error (source_reference, "unsigned integer literal cannot be negative");
			error = true;
		}

		int64 n = 0LL;
		uint64 un = 0ULL;

		errno = 0;
		if (value.has_prefix ("0b") || value.has_prefix ("0B")
		    || value.has_prefix ("-0b") || value.has_prefix ("-0B")) {
			string v;
			if (negative) {
				v = "-" + value.substring (3);
			} else {
				v = value.substring (2);
			}
			string unparsed;
			if (negative) {
				int64.try_parse (v, out n, out unparsed, 2);
				value = n.to_string ();
			} else {
				uint64.try_parse (v, out un, out unparsed, 2);
				value = un.to_string ();
			}
			if (unparsed != "") {
				Report.error (source_reference, "invalid digit '%c' in binary literal", unparsed[0]);
				error = true;
			}
		} else if ((value[0] == '0' && value.length > 1
		    && (value[1] == 'o' || value[1] == 'O' || value[1].isdigit ()))
		    || (value.has_prefix ("-0") && value.length > 3
		    && (value[2] == 'o' || value[2] == 'O' || value[2].isdigit ()))) {
			if (negative) {
				if (!value[2].isdigit ()) {
					value = "-0" + value.substring (3);
				}
			} else {
				if (!value[1].isdigit ()) {
					value = "0" + value.substring (2);
				}
			}
			string unparsed;
			if (negative) {
				int64.try_parse (value, out n, out unparsed, 8);
			} else {
				uint64.try_parse (value, out un, out unparsed, 8);
			}
			if (unparsed != "") {
				Report.error (source_reference, "invalid digit '%c' in octal literal", unparsed[0]);
				error = true;
			}
		} else {
			// hexademical and decimal literal
			if (negative) {
				n = int64.parse (value);
			} else {
				un = uint64.parse (value);
			}
		}

		if (errno == ERANGE) {
			Report.error (source_reference, "integer literal is too large for its type");
			error = true;
		} else if (errno == EINVAL) {
			Report.error (source_reference, "invalid integer literal");
			error = true;
		}

		if (un > int64.MAX) {
			// value doesn't fit into signed 64-bit
			u = true;
			l = 2;
		} else if (!negative) {
			n = (int64) un;
		}
		if (!u && (n > int.MAX || n < int.MIN)) {
			// value doesn't fit into signed 32-bit
			l = 2;
		} else if (u && n > uint.MAX) {
			// value doesn't fit into unsigned 32-bit
			l = 2;
		}

		string type_name;
		if (l == 0) {
			if (u) {
				type_suffix = "U";
				type_name = "uint";
			} else {
				type_suffix = "";
				type_name = "int";
			}
		} else if (l == 1) {
			if (u) {
				type_suffix = "UL";
				type_name = "ulong";
			} else {
				type_suffix = "L";
				type_name = "long";
			}
		} else {
			if (u) {
				type_suffix = "ULL";
				type_name = "uint64";
			} else {
				type_suffix = "LL";
				type_name = "int64";
			}
		}

		var st = (Struct) context.root.scope.lookup (type_name);
		// ensure attributes are already processed
		st.check (context);

		value_type = new IntegerType (st, value, type_name);

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_integer_literal (this);

		codegen.visit_expression (this);
	}
}
