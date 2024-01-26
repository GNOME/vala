/* valaobjectcreationexpression.vala
 *
 * Copyright (C) 2006-2012  Jürg Billeter
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
 * Represents an object creation expression in the source code.
 */
public class Vala.ObjectCreationExpression : Expression, CallableExpression {
	/**
	 * The object type to create.
	 */
	public DataType type_reference {
		get { return _data_type; }
		private set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}

	/**
	 * The construction method to call.
	 */
	public Expression call {
		get { return member_name; }
	}

	/**
	 * The construction method to use or the data type to be created
	 * with the default construction method.
	 */
	public MemberAccess member_name {
		get { return _member_name; }
		private set {
			_member_name = value;
			_member_name.parent_node = this;
		}
	}

	public bool is_yield_expression { get; set; }

	public bool is_chainup { get; set; }

	public bool struct_creation { get; set; }

	private List<Expression> argument_list = new ArrayList<Expression> ();

	private List<MemberInitializer> object_initializer = new ArrayList<MemberInitializer> ();

	private DataType _data_type;
	private MemberAccess _member_name;

	/**
	 * Creates a new object creation expression.
	 *
	 * @param member_name      object type to create
	 * @param source_reference reference to source code
	 * @return                 newly created object creation expression
	 */
	public ObjectCreationExpression (MemberAccess member_name, SourceReference? source_reference = null) {
		this.source_reference = source_reference;
		this.member_name = member_name;
	}

	/**
	 * Appends the specified expression to the list of arguments.
	 *
	 * @param arg an argument
	 */
	public void add_argument (Expression arg) {
		argument_list.add (arg);
		arg.parent_node = this;
	}

	/**
	 * Returns the argument list.
	 *
	 * @return argument list
	 */
	public unowned List<Expression> get_argument_list () {
		return argument_list;
	}

	/**
	 * Appends the specified member initializer to the object initializer.
	 *
	 * @param init a member initializer
	 */
	public void add_member_initializer (MemberInitializer init) {
		object_initializer.add (init);
		init.parent_node = this;
	}

	/**
	 * Returns the object initializer.
	 *
	 * @return member initializer list
	 */
	public unowned List<MemberInitializer> get_object_initializer () {
		return object_initializer;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_object_creation_expression (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (type_reference != null) {
			type_reference.accept (visitor);
		}

		if (member_name != null) {
			member_name.accept (visitor);
		}

		foreach (Expression arg in argument_list) {
			arg.accept (visitor);
		}

		foreach (MemberInitializer init in object_initializer) {
			init.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		int index = argument_list.index_of (old_node);
		if (index >= 0) {
			argument_list[index] = new_node;
			new_node.parent_node = this;
		}
	}

	public override bool is_pure () {
		return false;
	}

	public override bool is_accessible (Symbol sym) {
		if (member_name != null && !member_name.is_accessible (sym)) {
			return false;
		}

		foreach (var arg in argument_list) {
			if (!arg.is_accessible (sym)) {
				return false;
			}
		}

		foreach (var init in object_initializer) {
			if (!init.initializer.is_accessible (sym)) {
				return false;
			}
		}

		return true;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!member_name.check (context)) {
			error = true;
			return false;
		}

		TypeSymbol type;

		if (member_name.symbol_reference == null) {
			error = true;
			return false;
		}

		var constructor_sym = member_name.symbol_reference;
		var type_sym = member_name.symbol_reference;

		var type_args = member_name.get_type_arguments ();

		if (constructor_sym is Method) {
			type_sym = constructor_sym.parent_symbol;

			var constructor = (Method) constructor_sym;
			if (!(constructor_sym is CreationMethod)) {
				error = true;
				Report.error (source_reference, "`%s' is not a creation method", constructor.get_full_name ());
				return false;
			}

			symbol_reference = constructor;

			// inner expression can also be base access when chaining constructors
			unowned MemberAccess? ma = member_name.inner as MemberAccess;
			if (ma != null) {
				type_args = ma.get_type_arguments ();
			}
		}

		if (type_sym is Class) {
			type = (TypeSymbol) type_sym;
			if (((Class) type).is_error_base) {
				type_reference = new ErrorType (null, null, source_reference);
			} else {
				type_reference = new ObjectType ((Class) type, source_reference);
			}
		} else if (type_sym is Struct) {
			type = (TypeSymbol) type_sym;
			type_reference = new StructValueType ((Struct) type, source_reference);
		} else if (type_sym is ErrorCode) {
			type = (TypeSymbol) type_sym;
			type_reference = new ErrorType ((ErrorDomain) type_sym.parent_symbol, (ErrorCode) type_sym, source_reference);
			symbol_reference = type_sym;
		} else {
			error = true;
			Report.error (source_reference, "`%s' is not a class, struct, or error code", type_sym.get_full_name ());
			return false;
		}

		foreach (DataType type_arg in type_args) {
			type_reference.add_type_argument (type_arg);
		}

		if (!type_reference.check (context)) {
			error = true;
			return false;
		}

		context.analyzer.check_type (type_reference);
		// check whether there is the expected amount of type-arguments
		if (!type_reference.check_type_arguments (context)) {
			error = true;
			return false;
		}

		value_type = type_reference.copy ();
		value_type.value_owned = true;

		if (type is Class) {
			var cl = (Class) type;

			if (struct_creation) {
				error = true;
				Report.error (source_reference, "syntax error, use `new' to create new objects");
				return false;
			}

			if (cl.is_abstract) {
				value_type = null;
				error = true;
				Report.error (source_reference, "Can't create instance of abstract class `%s'", cl.get_full_name ());
				return false;
			}

			if (symbol_reference == null) {
				symbol_reference = cl.default_construction_method;

				if (symbol_reference == null) {
					error = true;
					Report.error (source_reference, "`%s' does not have a default constructor", cl.get_full_name ());
					return false;
				}

				// track usage for flow analyzer
				symbol_reference.used = true;
				symbol_reference.version.check (context, source_reference);
			}

			if (symbol_reference != null
			    && (symbol_reference.access == SymbolAccessibility.PRIVATE || symbol_reference.access == SymbolAccessibility.PROTECTED)) {
				bool in_target_type = false;
				for (Symbol this_symbol = context.analyzer.current_symbol; this_symbol != null; this_symbol = this_symbol.parent_symbol) {
					if (this_symbol == cl) {
						in_target_type = true;
						break;
					}
				}

				if (!in_target_type) {
					error = true;
					Report.error (source_reference, "Access to non-public constructor `%s' denied", symbol_reference.get_full_name ());
					return false;
				}
			}

			while (cl != null) {
				// FIXME: use target values in the codegen
				if (cl.has_attribute_argument ("CCode", "ref_sink_function")) {
					value_type.floating_reference = true;
					break;
				}

				cl = cl.base_class;
			}
		} else if (type is Struct) {
			var st = (Struct) type;

			if (!struct_creation && !context.deprecated) {
				Report.warning (source_reference, "deprecated syntax, don't use `new' to initialize structs");
			}

			if (symbol_reference == null) {
				symbol_reference = st.default_construction_method;
			}

			if (context.profile == Profile.GOBJECT && st.is_simple_type () && symbol_reference == null && object_initializer.size == 0) {
				error = true;
				Report.error (source_reference, "`%s' does not have a default constructor", st.get_full_name ());
				return false;
			}
		}

		if (symbol_reference == null && argument_list.size != 0) {
			value_type = null;
			error = true;
			Report.error (source_reference, "No arguments allowed when constructing type `%s'", type.get_full_name ());
			return false;
		}

		if (symbol_reference is Method) {
			var m = (Method) symbol_reference;

			if (is_yield_expression) {
				if (!m.coroutine) {
					error = true;
					Report.error (source_reference, "yield expression requires async method");
				}
				if (context.analyzer.current_method == null || !context.analyzer.current_method.coroutine) {
					error = true;
					Report.error (source_reference, "yield expression not available outside async method");
				}
			} else if (m is CreationMethod) {
				if (m.coroutine) {
					error = true;
					Report.error (source_reference, "missing `yield' before async creation expression");
				}
			}

			// FIXME partial code duplication of MethodCall.check

			Expression last_arg = null;

			Iterator<Expression> arg_it = argument_list.iterator ();
			foreach (Parameter param in m.get_parameters ()) {
				if (!param.check (context)) {
					error = true;
				}

				if (param.ellipsis) {
					break;
				}

				if (param.params_array) {
					var array_type = (ArrayType) param.variable_type;
					while (arg_it.next ()) {
						Expression arg = arg_it.get ();

						/* store expected type for callback parameters */
						arg.target_type = array_type.element_type;
						arg.target_type.value_owned = array_type.value_owned;
					}
					break;
				}

				if (arg_it.next ()) {
					Expression arg = arg_it.get ();

					/* store expected type for callback parameters */
					arg.formal_target_type = param.variable_type;
					arg.target_type = arg.formal_target_type.get_actual_type (value_type, null, this);

					last_arg = arg;
				}
			}

			// printf arguments
			if (m.printf_format) {
				StringLiteral format_literal = null;
				if (last_arg is NullLiteral) {
					// do not replace explicit null
				} else if (last_arg != null) {
					// use last argument as format string
					format_literal = StringLiteral.get_format_literal (last_arg);
					if (format_literal == null && argument_list.size == m.get_parameters ().size - 1) {
						// insert "%s" to avoid issues with embedded %
						format_literal = new StringLiteral ("\"%s\"");
						format_literal.target_type = context.analyzer.string_type.copy ();
						argument_list.insert (argument_list.size - 1, format_literal);

						// recreate iterator and skip to right position
						arg_it = argument_list.iterator ();
						foreach (Parameter param in m.get_parameters ()) {
							if (param.ellipsis || param.params_array) {
								break;
							}
							arg_it.next ();
						}
					}
				}
				if (format_literal != null) {
					string format = format_literal.eval ();
					if (!context.analyzer.check_print_format (format, arg_it, source_reference)) {
						return false;
					}
				}
			}

			foreach (Expression arg in argument_list) {
				arg.check (context);
			}

			context.analyzer.check_arguments (this, new MethodType (m), m.get_parameters (), argument_list);
		} else if (type_reference is ErrorType) {
			if (member_name != null) {
				member_name.check (context);
			}

			foreach (Expression arg in argument_list) {
				arg.check (context);
			}

			foreach (MemberInitializer init in object_initializer) {
				init.check (context);
			}

			if (argument_list.size == 0) {
				error = true;
				Report.error (source_reference, "Too few arguments, errors need at least 1 argument");
			} else {
				Iterator<Expression> arg_it = argument_list.iterator ();
				arg_it.next ();
				var ex = arg_it.get ();
				if (ex.value_type == null || !ex.value_type.compatible (context.analyzer.string_type)) {
					error = true;
					Report.error (source_reference, "Invalid type for argument 1");
				}

				var format_literal = StringLiteral.get_format_literal (ex);
				if (format_literal != null) {
					var format = format_literal.eval ();
					if (!context.analyzer.check_print_format (format, arg_it, source_reference)) {
						error = true;
						return false;
					}
				}

				arg_it = argument_list.iterator ();
				arg_it.next ();
				if (!context.analyzer.check_variadic_arguments (arg_it, 1, source_reference)) {
					error = true;
					return false;
				}
			}
		}

		//Resolve possible generic-type in SizeofExpression used as parameter default-value
		foreach (Expression arg in argument_list) {
			unowned SizeofExpression sizeof_expr = arg as SizeofExpression;
			if (sizeof_expr != null && sizeof_expr.type_reference is GenericType) {
				var sizeof_type = sizeof_expr.type_reference.get_actual_type (type_reference, type_reference.get_type_arguments (), this);
				replace_expression (arg, new SizeofExpression (sizeof_type, source_reference));
			}
		}

		// Unwrap chained member initializers
		foreach (MemberInitializer init in get_object_initializer ()) {
			if (!(init.initializer is MemberInitializer)) {
				continue;
			}

			int index = object_initializer.index_of (init);
			object_initializer.remove_at (index);
			assert (index >= 0);

			unowned MemberInitializer? inner_mi = (MemberInitializer) init.initializer;
			while (inner_mi.initializer is MemberInitializer) {
				inner_mi = (MemberInitializer) inner_mi.initializer;
			}

			var local = new LocalVariable (null, get_temp_name (), inner_mi.initializer, inner_mi.initializer.source_reference);
			var decl = new DeclarationStatement (local, inner_mi.initializer.source_reference);
			decl.check (context);
			insert_statement (context.analyzer.insert_block, decl);

			do {
				var member_init = new MemberInitializer (inner_mi.name, new MemberAccess (null, local.name, inner_mi.source_reference), inner_mi.source_reference);
				object_initializer.insert (index++, member_init);
				inner_mi = inner_mi.parent_node as MemberInitializer;
			} while (inner_mi != null);
		}
		foreach (MemberInitializer init in get_object_initializer ()) {
			init.parent_node = this;
			init.check (context);
		}

		// FIXME code duplication in MethodCall.check
		if (tree_can_fail) {
			if (parent_node is LocalVariable || parent_node is ExpressionStatement) {
				// simple statements, no side effects after method call
			} else if (!(context.analyzer.current_symbol is Block)) {
				// can't handle errors in field initializers
				Report.error (source_reference, "Field initializers must not throw errors");
			} else {
				// store parent_node as we need to replace the expression in the old parent node later on
				var old_parent_node = parent_node;

				var local = new LocalVariable (value_type.copy (), get_temp_name (), null, source_reference);
				var decl = new DeclarationStatement (local, source_reference);

				insert_statement (context.analyzer.insert_block, decl);

				var temp_access = SemanticAnalyzer.create_temp_access (local, target_type);
				temp_access.formal_target_type = formal_target_type;
				formal_target_type = null;

				// don't set initializer earlier as this changes parent_node and parent_statement
				local.initializer = this;
				decl.check (context);

				// move temp variable to insert block to ensure the
				// variable is in the same block as the declaration
				// otherwise there will be scoping issues in the generated code
				var block = (Block) context.analyzer.current_symbol;
				block.remove_local_variable (local);
				context.analyzer.insert_block.add_local_variable (local);

				old_parent_node.replace_expression (this, temp_access);
				temp_access.check (context);
			}
		}

		return !error;
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		if (symbol_reference is Method) {
			if (source_reference == null) {
				source_reference = this.source_reference;
			}
			var m = (Method) symbol_reference;
			m.get_error_types (collection, source_reference);
		}
	}

	public override void emit (CodeGenerator codegen) {
		foreach (Expression arg in argument_list) {
			arg.emit (codegen);
		}

		foreach (MemberInitializer init in object_initializer) {
			init.emit (codegen);
		}

		codegen.visit_object_creation_expression (this);

		codegen.visit_expression (this);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		foreach (Expression arg in argument_list) {
			arg.get_defined_variables (collection);
		}
	}

	public override void get_used_variables (Collection<Variable> collection) {
		foreach (Expression arg in argument_list) {
			arg.get_used_variables (collection);
		}

		foreach (MemberInitializer init in object_initializer) {
			init.get_used_variables (collection);
		}
	}

	public override string to_string () {
		var b = new StringBuilder ();
		if (is_yield_expression) {
			b.append ("yield ");
		}
		if (!struct_creation) {
			b.append ("new ");
		}
		if (member_name != null) {
			b.append (member_name.to_string ());
		}
		b.append_c ('(');

		bool first = true;
		foreach (var expr in argument_list) {
			if (!first) {
				b.append (", ");
			}
			b.append (expr.to_string ());
			first = false;
		}
		b.append_c (')');

		return b.str;
	}
}
