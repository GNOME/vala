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
	public string value { get; set; }

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
	
	/**
	 * Returns the type name of the value this literal represents.
	 *
	 * @return the name of literal type
	 */
	public string get_type_name () {
		if (value.has_suffix ("f") || value.has_suffix ("F")) {
			return "float";
		}
		
		return "double";
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

		var st = (Struct) context.analyzer.root_symbol.scope.lookup (get_type_name ());
		// ensure attributes are already processed in case of bootstrapping dova-core
		st.check (context);

		value_type = new FloatingType (st);

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		codegen.visit_real_literal (this);

		codegen.visit_expression (this);
	}
}
