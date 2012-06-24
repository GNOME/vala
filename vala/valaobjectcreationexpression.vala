/* valaobjectcreationexpression.vala
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
 * Represents an object creation expression in the source code.
 */
public class Vala.ObjectCreationExpression : Expression {
	/**
	 * The object type to create.
	 */
	public DataType type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}

	/**
	 * The construction method to use or the data type to be created
	 * with the default construction method.
	 */
	public MemberAccess member_name { get; set; }

	public bool is_yield_expression { get; set; }

	public bool struct_creation { get; set; }

	private List<Expression> argument_list = new ArrayList<Expression> ();

	private List<MemberInitializer> object_initializer = new ArrayList<MemberInitializer> ();

	private DataType _data_type;

	/**
	 * Creates a new object creation expression.
	 *
	 * @param member_name      object type to create
	 * @param source_reference reference to source code
	 * @return                 newly created object creation expression
	 */
	public ObjectCreationExpression (MemberAccess member_name, SourceReference source_reference) {
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
	 * Returns a copy of the argument list.
	 *
	 * @return argument list
	 */
	public List<Expression> get_argument_list () {
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
	public List<MemberInitializer> get_object_initializer () {
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
		if (index >= 0 && new_node.parent_node == null) {
			argument_list[index] = new_node;
			new_node.parent_node = this;
		}
	}

	public override bool is_pure () {
		return false;
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

		if (member_name != null) {
			member_name.check (context);
		}

		TypeSymbol type = null;

		if (type_reference == null) {
			if (member_name == null) {
				error = true;
				Report.error (source_reference, "Incomplete object creation expression");
				return false;
			}

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
					Report.error (source_reference, "`%s' is not a creation method".printf (constructor.get_full_name ()));
					return false;
				}

				symbol_reference = constructor;

				// inner expression can also be base access when chaining constructors
				var ma = member_name.inner as MemberAccess;
				if (ma != null) {
					type_args = ma.get_type_arguments ();
				}
			}

			if (type_sym is Class) {
				type = (TypeSymbol) type_sym;
				if (((Class) type).is_error_base) {
					type_reference = new ErrorType (null, null, source_reference);
				} else {
					type_reference = new ObjectType ((Class) type);
				}
			} else if (type_sym is Struct) {
				type = (TypeSymbol) type_sym;
				type_reference = new StructValueType ((Struct) type);
			} else if (type_sym is ErrorCode) {
				type_reference = new ErrorType ((ErrorDomain) type_sym.parent_symbol, (ErrorCode) type_sym, source_reference);
				symbol_reference = type_sym;
			} else {
				error = true;
				Report.error (source_reference, "`%s' is not a class, struct, or error code".printf (type_sym.get_full_name ()));
				return false;
			}

			foreach (DataType type_arg in type_args) {
				type_reference.add_type_argument (type_arg);
			}
		} else {
			type = type_reference.data_type;
		}

		value_type = type_reference.copy ();
		value_type.value_owned = true;

		bool may_throw = false;

		int given_num_type_args = type_reference.get_type_arguments ().size;
		int expected_num_type_args = 0;

		if (type is Class) {
			var cl = (Class) type;

			expected_num_type_args = cl.get_type_parameters ().size;

			if (struct_creation) {
				error = true;
				Report.error (source_reference, "syntax error, use `new' to create new objects");
				return false;
			}

			if (cl.is_abstract) {
				value_type = null;
				error = true;
				Report.error (source_reference, "Can't create instance of abstract class `%s'".printf (cl.get_full_name ()));
				return false;
			}

			if (symbol_reference == null) {
				symbol_reference = cl.default_construction_method;

				if (symbol_reference == null) {
					error = true;
					Report.error (source_reference, "`%s' does not have a default constructor".printf (cl.get_full_name ()));
					return false;
				}

				// track usage for flow analyzer
				symbol_reference.used = true;
				symbol_reference.check_deprecated (source_reference);
			}

			if (symbol_reference != null && symbol_reference.access == SymbolAccessibility.PRIVATE) {
				bool in_target_type = false;
				for (Symbol this_symbol = context.analyzer.current_symbol; this_symbol != null; this_symbol = this_symbol.parent_symbol) {
					if (this_symbol == cl) {
						in_target_type = true;
						break;
					}
				}

				if (!in_target_type) {
					error = true;
					Report.error (source_reference, "Access to private member `%s' denied".printf (symbol_reference.get_full_name ()));
					return false;
				}
			}

			while (cl != null) {
				// FIXME: use target values in the codegen
				if (cl.get_attribute_string ("CCode", "ref_sink_function") != null) {
					value_type.floating_reference = true;
					break;
				}

				cl = cl.base_class;
			}
		} else if (type is Struct) {
			var st = (Struct) type;

			expected_num_type_args = st.get_type_parameters ().size;

			if (!struct_creation && !context.deprecated) {
				Report.warning (source_reference, "deprecated syntax, don't use `new' to initialize structs");
			}

			if (symbol_reference == null) {
				symbol_reference = st.default_construction_method;
			}

			if (context.profile == Profile.GOBJECT && st.is_simple_type () && symbol_reference == null) {
				error = true;
				Report.error (source_reference, "`%s' does not have a default constructor".printf (st.get_full_name ()));
				return false;
			}
		}

		if (expected_num_type_args > given_num_type_args) {
			error = true;
			Report.error (source_reference, "too few type arguments");
			return false;
		} else if (expected_num_type_args < given_num_type_args) {
			error = true;
			Report.error (source_reference, "too many type arguments");
			return false;
		}

		if (symbol_reference == null && get_argument_list ().size != 0) {
			value_type = null;
			error = true;
			Report.error (source_reference, "No arguments allowed when constructing type `%s'".printf (type.get_full_name ()));
			return false;
		}

		if (symbol_reference is Method) {
			var m = (Method) symbol_reference;

			var args = get_argument_list ();
			Iterator<Expression> arg_it = args.iterator ();
			foreach (Parameter param in m.get_parameters ()) {
				if (param.ellipsis) {
					break;
				}

				if (arg_it.next ()) {
					Expression arg = arg_it.get ();

					/* store expected type for callback parameters */
					arg.formal_target_type = param.variable_type;
					arg.target_type = arg.formal_target_type.get_actual_type (value_type, null, this);
				}
			}

			foreach (Expression arg in args) {
				arg.check (context);
			}

			context.analyzer.check_arguments (this, new MethodType (m), m.get_parameters (), args);

			foreach (DataType error_type in m.get_error_types ()) {
				may_throw = true;

				// ensure we can trace back which expression may throw errors of this type
				var call_error_type = error_type.copy ();
				call_error_type.source_reference = source_reference;

				add_error_type (call_error_type);
			}
		} else if (type_reference is ErrorType) {
			if (type_reference != null) {
				type_reference.check (context);
			}

			if (member_name != null) {
				member_name.check (context);
			}
		
			foreach (Expression arg in argument_list) {
				arg.check (context);
			}

			foreach (MemberInitializer init in object_initializer) {
				init.check (context);
			}

			if (get_argument_list ().size == 0) {
				error = true;
				Report.error (source_reference, "Too few arguments, errors need at least 1 argument");
			} else {
				Iterator<Expression> arg_it = get_argument_list ().iterator ();
				arg_it.next ();
				var ex = arg_it.get ();
				if (ex.value_type == null || !ex.value_type.compatible (context.analyzer.string_type)) {
					error = true;
					Report.error (source_reference, "Invalid type for argument 1");
				}
			}
		}

		foreach (MemberInitializer init in get_object_initializer ()) {
			context.analyzer.visit_member_initializer (init, type_reference);
		}

		if (may_throw) {
			if (parent_node is LocalVariable || parent_node is ExpressionStatement) {
				// simple statements, no side effects after method call
			} else if (!(context.analyzer.current_symbol is Block)) {
				if (context.profile != Profile.DOVA) {
					// can't handle errors in field initializers
					Report.error (source_reference, "Field initializers must not throw errors");
				}
			} else {
				// store parent_node as we need to replace the expression in the old parent node later on
				var old_parent_node = parent_node;

				var local = new LocalVariable (value_type, get_temp_name (), null, source_reference);
				// use floating variable to avoid unnecessary (and sometimes impossible) copies
				local.floating = true;
				var decl = new DeclarationStatement (local, source_reference);

				insert_statement (context.analyzer.insert_block, decl);

				Expression temp_access = new MemberAccess.simple (local.name, source_reference);
				temp_access.target_type = target_type;

				// don't set initializer earlier as this changes parent_node and parent_statement
				local.initializer = this;
				decl.check (context);
				temp_access.check (context);

				// move temp variable to insert block to ensure the
				// variable is in the same block as the declaration
				// otherwise there will be scoping issues in the generated code
				var block = (Block) context.analyzer.current_symbol;
				block.remove_local_variable (local);
				context.analyzer.insert_block.add_local_variable (local);

				old_parent_node.replace_expression (this, temp_access);
			}
		}

		return !error;
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
	}
}
