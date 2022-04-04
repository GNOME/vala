/* valamemberinitializer.vala
 *
 * Copyright (C) 2007-2010  Jürg Billeter
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
 * Represents a member initializer, i.e. an element of an object initializer, in
 * the source code.
 */
public class Vala.MemberInitializer : Expression {
	/**
	 * Member name.
	 */
	public string name { get; private set; }

	/**
	 * Initializer expression.
	 */
	public Expression initializer {
		get { return _initializer; }
		private set {
			_initializer = value;
			_initializer.parent_node = this;
		}
	}

	Expression _initializer;

	/**
	 * Creates a new member initializer.
	 *
	 * @param name             member name
	 * @param initializer      initializer expression
	 * @param source_reference reference to source code
	 * @return                 newly created member initializer
	 */
	public MemberInitializer (string name, Expression initializer, SourceReference? source_reference = null) {
		this.initializer = initializer;
		this.source_reference = source_reference;
		this.name = name;
	}

	public override bool is_pure () {
		return false;
	}

	public override void accept (CodeVisitor visitor) {
		initializer.accept (visitor);
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		unowned ObjectCreationExpression? oce = parent_node as ObjectCreationExpression;
		if (oce == null) {
			error = true;
			Report.error (source_reference, "internal: Invalid member initializer");
			return false;
		}

		unowned DataType type = oce.type_reference;

		symbol_reference = SemanticAnalyzer.symbol_lookup_inherited (type.type_symbol, name);
		if (!(symbol_reference is Field || symbol_reference is Property)) {
			error = true;
			Report.error (source_reference, "Invalid member `%s' in `%s'", name, type.type_symbol.get_full_name ());
			return false;
		}

		// FIXME Code duplication with MemberAccess.check()
		if (symbol_reference.access == SymbolAccessibility.PROTECTED && symbol_reference.parent_symbol is TypeSymbol) {
			unowned TypeSymbol target_type = (TypeSymbol) symbol_reference.parent_symbol;

			bool in_subtype = false;
			for (Symbol this_symbol = context.analyzer.current_symbol; this_symbol != null; this_symbol = this_symbol.parent_symbol) {
				if (this_symbol == target_type) {
					// required for interfaces with non-abstract methods
					// accessing protected interface members
					in_subtype = true;
					break;
				}

				unowned Class? cl = this_symbol as Class;
				if (cl != null && cl.is_subtype_of (target_type)) {
					in_subtype = true;
					break;
				}
			}

			if (!in_subtype) {
				error = true;
				Report.error (source_reference, "Access to protected member `%s' denied", symbol_reference.get_full_name ());
				return false;
			}
		} else if (symbol_reference.access == SymbolAccessibility.PRIVATE) {
			unowned Symbol? target_type = symbol_reference.parent_symbol;

			bool in_target_type = false;
			for (Symbol this_symbol = context.analyzer.current_symbol; this_symbol != null; this_symbol = this_symbol.parent_symbol) {
				if (target_type == this_symbol) {
					in_target_type = true;
					break;
				}
			}

			if (!in_target_type) {
				error = true;
				Report.error (source_reference, "Access to private member `%s' denied", symbol_reference.get_full_name ());
				return false;
			}
		}

		DataType member_type = null;
		if (symbol_reference is Field) {
			unowned Field f = (Field) symbol_reference;
			member_type = f.variable_type;
		} else if (symbol_reference is Property) {
			unowned Property prop = (Property) symbol_reference;
			member_type = prop.property_type;
			if (prop.set_accessor == null || !prop.set_accessor.writable) {
				error = true;
				Report.error (source_reference, "Property `%s' is read-only", prop.get_full_name ());
				return false;
			}
		}

		initializer.formal_target_type = member_type;
		initializer.target_type = initializer.formal_target_type.get_actual_type (type, null, this);

		if (!initializer.check (context)) {
			return false;
		}

		if (initializer.value_type == null || !initializer.value_type.compatible (initializer.target_type)) {
			error = true;
			Report.error (source_reference, "Invalid type for member `%s'", name);
			return false;
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		initializer.emit (codegen);
	}

	public override void get_used_variables (Collection<Variable> collection) {
		initializer.get_used_variables (collection);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (initializer == old_node) {
			initializer = new_node;
		}
	}
}

