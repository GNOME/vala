/* initializerbuilder.vala
 *
 * Copyright (C) 2011  Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc.Content;

private class Valadoc.Api.InitializerBuilder : Vala.CodeVisitor {
	private Vala.HashMap<Vala.Symbol, Symbol> symbol_map;
	private SignatureBuilder signature;

	private Symbol? resolve (Vala.Symbol symbol) {
		return symbol_map.get (symbol);
	}

	private void write_node (Vala.Symbol vsymbol) {
		signature.append_symbol (resolve (vsymbol));
	}

	private void write_type (Vala.DataType vsymbol) {
		if (vsymbol.type_symbol != null) {
			write_node (vsymbol.type_symbol);
		} else {
			signature.append_literal ("null");
		}

		var type_args = vsymbol.get_type_arguments ();
		if (type_args.size > 0) {
			signature.append ("<");
			bool first = true;
			foreach (Vala.DataType type_arg in type_args) {
				if (!first) {
					signature.append (",");
				} else {
					first = false;
				}
				if (!type_arg.value_owned) {
					signature.append_keyword ("weak");
				}
				signature.append (type_arg.to_qualified_string (null));
			}
			signature.append (">");
		}

		if (vsymbol.nullable) {
			signature.append ("?");
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_array_creation_expression (Vala.ArrayCreationExpression expr) {
		signature.append_keyword ("new");
		write_type (expr.element_type);
		signature.append ("[", false);

		bool first = true;
		foreach (Vala.Expression size in expr.get_sizes ()) {
			if (!first) {
				signature.append (", ", false);
			}
			size.accept (this);
			first = false;
		}

		signature.append ("]", false);

		if (expr.initializer_list != null) {
			signature.append (" ", false);
			expr.initializer_list.accept (this);
		}
	}

	public InitializerBuilder (SignatureBuilder signature, Vala.HashMap<Vala.Symbol, Symbol> symbol_map) {
		this.symbol_map = symbol_map;
		this.signature = signature;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_binary_expression (Vala.BinaryExpression expr) {
		expr.left.accept (this);
		if (expr.operator == Vala.BinaryOperator.IN) {
			signature.append_keyword (Vala.BinaryOperator.IN.to_string ());
		} else {
			signature.append (expr.operator.to_string ());
		}
		signature.append (" ");
		expr.right.accept (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_unary_expression (Vala.UnaryExpression expr) {
		if (expr.operator == Vala.UnaryOperator.REF || expr.operator == Vala.UnaryOperator.OUT) {
			signature.append_keyword (expr.operator.to_string ());
		} else {
			signature.append (expr.operator.to_string ());
		}
		expr.inner.accept (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_assignment (Vala.Assignment a) {
		a.left.accept (this);
		signature.append (a.operator.to_string ());
		a.right.accept (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_cast_expression (Vala.CastExpression expr) {
		if (expr.is_non_null_cast) {
			signature.append ("(!)");
			expr.inner.accept (this);
			return;
		}

		if (!expr.is_silent_cast) {
			signature.append ("(", false);
			write_type (expr.type_reference);
			signature.append (")", false);
		}

		expr.inner.accept (this);

		if (expr.is_silent_cast) {
			signature.append_keyword ("as");
			write_type (expr.type_reference);
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_initializer_list (Vala.InitializerList list) {
		signature.append ("{", false);

		bool first = true;
		foreach (Vala.Expression initializer in list.get_initializers ()) {
			if (!first) {
				signature.append (", ", false);
			}
			first = false;
			initializer.accept (this);
		}

		signature.append ("}", false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_member_access (Vala.MemberAccess expr) {
		if (expr.symbol_reference != null) {
			expr.symbol_reference.accept (this);
		} else {
			signature.append (expr.member_name);
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_element_access (Vala.ElementAccess expr) {
		expr.container.accept (this);
		signature.append ("[", false);

		bool first = true;
		foreach (Vala.Expression index in expr.get_indices ()) {
			if (!first) {
				signature.append (", ", false);
			}
			first = false;

			index.accept (this);
		}

		signature.append ("]", false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_pointer_indirection (Vala.PointerIndirection expr) {
		signature.append ("*", false);
		expr.inner.accept (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_addressof_expression (Vala.AddressofExpression expr) {
		signature.append ("&", false);
		expr.inner.accept (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_reference_transfer_expression (Vala.ReferenceTransferExpression expr) {
		signature.append ("(", false).append_keyword ("owned", false).append (")", false);
		expr.inner.accept (this);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_type_check (Vala.TypeCheck expr) {
		expr.expression.accept (this);
		signature.append_keyword ("is");
		write_type (expr.type_reference);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_method_call (Vala.MethodCall expr) {
		// symbol-name:
		expr.call.symbol_reference.accept (this);

		// parameters:
		signature.append (" (", false);
		bool first = true;
		foreach (Vala.Expression literal in expr.get_argument_list ()) {
			if (!first) {
				signature.append (", ", false);
			}

			literal.accept (this);
			first = false;
		}
		signature.append (")", false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_slice_expression (Vala.SliceExpression expr) {
		expr.container.accept (this);
		signature.append ("[", false);
		expr.start.accept (this);
		signature.append (":", false);
		expr.stop.accept (this);
		signature.append ("]", false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_base_access (Vala.BaseAccess expr) {
		signature.append_keyword ("base", false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_postfix_expression (Vala.PostfixExpression expr) {
		expr.inner.accept (this);
		if (expr.increment) {
			signature.append ("++", false);
		} else {
			signature.append ("--", false);
		}
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_object_creation_expression (Vala.ObjectCreationExpression expr) {
		if (!expr.struct_creation) {
			signature.append_keyword ("new");
		}

		signature.append_symbol (resolve (expr.symbol_reference));

		signature.append (" (", false);

		//TODO: rm conditional space
		bool first = true;
		foreach (Vala.Expression arg in expr.get_argument_list ()) {
			if (!first) {
				signature.append (", ", false);
			}
			arg.accept (this);
			first = false;
		}

		signature.append (")", false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_sizeof_expression (Vala.SizeofExpression expr) {
		signature.append_keyword ("sizeof", false).append (" (", false);
		write_type (expr.type_reference);
		signature.append (")", false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_typeof_expression (Vala.TypeofExpression expr) {
		signature.append_keyword ("typeof", false).append (" (", false);
		write_type (expr.type_reference);
		signature.append (")", false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_lambda_expression (Vala.LambdaExpression expr) {
		signature.append ("(", false);

		bool first = true;
		foreach (Vala.Parameter param in expr.get_parameters ()) {
			if (!first) {
				signature.append (", ", false);
			}
			signature.append (param.name, false);
			first = false;
		}


		signature.append (") => {", false);
		signature.append_highlighted (" [...] ", false);
		signature.append ("}", false);
	}



	/**
	 * {@inheritDoc}
	 */
	public override void visit_boolean_literal (Vala.BooleanLiteral lit) {
		signature.append_literal (lit.to_string (), false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_character_literal (Vala.CharacterLiteral lit) {
		signature.append_literal (lit.to_string (), false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_integer_literal (Vala.IntegerLiteral lit) {
		signature.append_literal (lit.to_string (), false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_real_literal (Vala.RealLiteral lit) {
		signature.append_literal (lit.to_string (), false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_regex_literal (Vala.RegexLiteral lit) {
		signature.append_literal (lit.to_string (), false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_string_literal (Vala.StringLiteral lit) {
		signature.append_literal (lit.to_string (), false);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_null_literal (Vala.NullLiteral lit) {
		signature.append_literal (lit.to_string (), false);
	}



	/**
	 * {@inheritDoc}
	 */
	public override void visit_field (Vala.Field field) {
		write_node (field);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_constant (Vala.Constant constant) {
		write_node (constant);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_enum_value (Vala.EnumValue ev) {
		write_node (ev);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_error_code (Vala.ErrorCode ec) {
		write_node (ec);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_delegate (Vala.Delegate d) {
		write_node (d);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_method (Vala.Method m) {
		write_node (m);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_creation_method (Vala.CreationMethod m) {
		write_node (m);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_signal (Vala.Signal sig) {
		write_node (sig);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_class (Vala.Class c) {
		write_node (c);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_struct (Vala.Struct s) {
		write_node (s);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_interface (Vala.Interface i) {
		write_node (i);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_enum (Vala.Enum en) {
		write_node (en);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_error_domain (Vala.ErrorDomain ed) {
		write_node (ed);
	}

	/**
	 * {@inheritDoc}
	 */
	public override void visit_property (Vala.Property prop) {
		write_node (prop);
	}
}

