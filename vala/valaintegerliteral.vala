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
	public string value { get; set; }

	public string type_suffix { get; set; }

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
		
		int64 n = int64.parse (value);
		if (!u && n > 0x7fffffff) {
			// value doesn't fit into signed 32-bit
			l = 2;
		} else if (u && n > 0xffffffff) {
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
		} else if (CodeContext.get ().profile == Profile.DOVA) {
			if (u) {
				type_suffix = "UL";
				type_name = "uint64";
			} else {
				type_suffix = "L";
				type_name = "int64";
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

		var st = (Struct) context.analyzer.root_symbol.scope.lookup (type_name);
		// ensure attributes are already processed in case of bootstrapping dova-core
		st.check (context);

		value_type = new IntegerType (st, value, type_name);

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_integer_literal (this);

		codegen.visit_expression (this);
	}
}
