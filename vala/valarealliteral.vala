/* valarealliteral.vala
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
 * Represents a real literal in the source code.
 */
public class Vala.RealLiteral : Literal {
	/**
	 * The literal value.
	 */
	public string value { get; private set; }

	/**
	 * Creates a new real literal.
	 *
	 * @param r      literal value
	 * @param source reference to source code
	 * @return       newly created real literal
	 */
	public RealLiteral (string r, SourceReference? source = null) {
		value = r;
		source_reference = source;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_real_literal (this);

		visitor.visit_expression (this);
	}

	public override bool is_pure () {
		return true;
	}

	public override string to_string () {
		return value;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		string type_name;
		int suf_len = 0;

		switch (value[value.length - 1]) {
		case 'f':
		case 'F':
			suf_len = 1;
			type_name = "float";
			break;
		case 'd':
		case 'D':
			suf_len = 1;
			type_name = "double";
			break;
		default:
			type_name = "double";
			break;
		}

		switch (value[value.length - suf_len - 1]) {
		case 'e':
		case 'E':
		case 'p':
		case 'P':
		case '+':
		case '-':
			Report.error (source_reference, "exponent has no digits");
			error = true;
			break;
		}

		var st = (Struct) context.root.scope.lookup (type_name);
		// ensure attributes are already processed
		st.check (context);

		value_type = new FloatingType (st);

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_real_literal (this);

		codegen.visit_expression (this);
	}
}
