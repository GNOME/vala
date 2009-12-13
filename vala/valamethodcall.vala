/* valamethodcall.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Represents an invocation expression in the source code.
 */
public class Vala.MethodCall : Expression {
	/**
	 * The method to call.
	 */
	public Expression call {
		get { return _call; }
		set {
			_call = value;
			_call.parent_node = this;
		}
	}

	public bool is_yield_expression { get; set; }

	public bool is_assert { get; private set; }

	public Expression _call;
	
	private List<Expression> argument_list = new ArrayList<Expression> ();

	/**
	 * Creates a new invocation expression.
	 *
	 * @param call             method to call
	 * @param source_reference reference to source code
	 * @return                 newly created invocation expression
	 */
	public MethodCall (Expression call, SourceReference? source_reference = null) {
		this.source_reference = source_reference;
		this.call = call;
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
		return new ReadOnlyList<Expression> (argument_list);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_method_call (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		call.accept (visitor);

		foreach (Expression expr in argument_list) {
			expr.accept (visitor);
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (call == old_node) {
			call = new_node;
		}
		
		int index = argument_list.index_of (old_node);
		if (index >= 0 && new_node.parent_node == null) {
			argument_list[index] = new_node;
			new_node.parent_node = this;
		}
	}

	public override bool is_pure () {
		return false;
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!call.check (analyzer)) {
			/* if method resolving didn't succeed, skip this check */
			error = true;
			return false;
		}

		// type of target object
		DataType target_object_type = null;

		if (call is MemberAccess) {
			var ma = (MemberAccess) call;
			if (ma.prototype_access) {
				error = true;
				Report.error (source_reference, "Access to instance member `%s' denied".printf (call.symbol_reference.get_full_name ()));
				return false;
			}

			if (ma.inner != null) {
				target_object_type = ma.inner.value_type;
			}

			if (ma.symbol_reference != null && ma.symbol_reference.get_attribute ("Assert") != null) {
				this.is_assert = true;
			}
		}

		var mtype = call.value_type;

		if (mtype is ObjectType || (analyzer.context.profile == Profile.GOBJECT && call.symbol_reference == analyzer.object_type)) {
			// constructor chain-up
			var cm = analyzer.find_current_method () as CreationMethod;
			if (cm == null) {
				error = true;
				Report.error (source_reference, "invocation not supported in this context");
				return false;
			} else if (cm.chain_up) {
				error = true;
				Report.error (source_reference, "Multiple constructor calls in the same constructor are not permitted");
				return false;
			}
			cm.chain_up = true;

			if (mtype is ObjectType) {
				var otype = (ObjectType) mtype;
				var cl = (Class) otype.type_symbol;
				var base_cm = cl.default_construction_method;
				if (base_cm == null) {
					error = true;
					Report.error (source_reference, "chain up to `%s' not supported".printf (cl.get_full_name ()));
					return false;
				} else if (!base_cm.has_construct_function) {
					error = true;
					Report.error (source_reference, "chain up to `%s' not supported".printf (base_cm.get_full_name ()));
					return false;
				}
			} else {
				// GObject chain up
				var cl = cm.parent_symbol as Class;
				if (cl == null || !cl.is_subtype_of (analyzer.object_type)) {
					error = true;
					Report.error (source_reference, "chain up to `GLib.Object' not supported");
					return false;
				}
				call.value_type = new ObjectType (analyzer.object_type);
				mtype = call.value_type;
			}
		}

		// check for struct construction
		if (call is MemberAccess &&
		    ((call.symbol_reference is CreationMethod
		      && call.symbol_reference.parent_symbol is Struct)
		     || call.symbol_reference is Struct)) {
			var struct_creation_expression = new ObjectCreationExpression ((MemberAccess) call, source_reference);
			struct_creation_expression.struct_creation = true;
			foreach (Expression arg in get_argument_list ()) {
				struct_creation_expression.add_argument (arg);
			}
			struct_creation_expression.target_type = target_type;
			analyzer.replaced_nodes.add (this);
			parent_node.replace_expression (this, struct_creation_expression);
			struct_creation_expression.check (analyzer);
			return true;
		} else if (call is MemberAccess
		           && call.symbol_reference is CreationMethod) {
			// constructor chain-up
			var cm = analyzer.find_current_method () as CreationMethod;
			if (cm == null) {
				error = true;
				Report.error (source_reference, "use `new' operator to create new objects");
				return false;
			} else if (cm.chain_up) {
				error = true;
				Report.error (source_reference, "Multiple constructor calls in the same constructor are not permitted");
				return false;
			}
			cm.chain_up = true;

			var base_cm = (CreationMethod) call.symbol_reference;
			if (!base_cm.has_construct_function) {
				error = true;
				Report.error (source_reference, "chain up to `%s' not supported".printf (base_cm.get_full_name ()));
				return false;
			}
		}

		if (mtype != null && mtype.is_invokable ()) {
			// call ok, expression is invokable
		} else if (call.symbol_reference is Class) {
			error = true;
			Report.error (source_reference, "use `new' operator to create new objects");
			return false;
		} else {
			error = true;
			Report.error (source_reference, "invocation not supported in this context");
			return false;
		}

		var ret_type = mtype.get_return_type ();
		var params = mtype.get_parameters ();

		if (mtype is MethodType) {
			var m = ((MethodType) mtype).method_symbol;
			if (m != null && m.coroutine && !is_yield_expression) {
				// begin or end call of async method
				var ma = (MemberAccess) call;
				if (ma.member_name != "end") {
					// begin (possibly implicit)
					params = m.get_async_begin_parameters ();
					ret_type = new VoidType ();
				} else {
					// end
					params = m.get_async_end_parameters ();
				}
			}
		}

		Expression last_arg = null;

		var args = get_argument_list ();
		Iterator<Expression> arg_it = args.iterator ();
		foreach (FormalParameter param in params) {
			if (param.ellipsis) {
				break;
			}

			if (param.params_array) {
				var array_type = (ArrayType) param.parameter_type;
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
				arg.formal_target_type = param.parameter_type;
				arg.target_type = arg.formal_target_type.get_actual_type (target_object_type, call as MemberAccess, this);

				last_arg = arg;
			}
		}

		// printf arguments
		if (mtype is MethodType && ((MethodType) mtype).method_symbol.printf_format) {
			StringLiteral format_literal = null;
			if (last_arg != null) {
				// use last argument as format string
				format_literal = last_arg as StringLiteral;
				if (format_literal == null && args.size == params.size - 1) {
					// insert "%s" to avoid issues with embedded %
					format_literal = new StringLiteral ("\"%s\"");
					format_literal.target_type = analyzer.string_type.copy ();
					argument_list.insert (args.size - 1, format_literal);

					// recreate iterator and skip to right position
					arg_it = argument_list.iterator ();
					foreach (FormalParameter param in params) {
						if (param.ellipsis) {
							break;
						}
						arg_it.next ();
					}
				}
			} else {
				// use instance as format string for string.printf (...)
				var ma = call as MemberAccess;
				if (ma != null) {
					format_literal = ma.inner as StringLiteral;
				}
			}
			if (format_literal != null) {
				string format = format_literal.eval ();

				bool unsupported_format = false;

				weak string format_it = format;
				unichar c = format_it.get_char ();
				while (c != '\0') {
					if (c != '%') {
						format_it = format_it.next_char ();
						c = format_it.get_char ();
						continue;
					}

					format_it = format_it.next_char ();
					c = format_it.get_char ();
					// flags
					while (c == '#' || c == '0' || c == '-' || c == ' ' || c == '+') {
						format_it = format_it.next_char ();
						c = format_it.get_char ();
					}
					// field width
					while (c >= '0' && c <= '9') {
						format_it = format_it.next_char ();
						c = format_it.get_char ();
					}
					// precision
					if (c == '.') {
						format_it = format_it.next_char ();
						c = format_it.get_char ();
						while (c >= '0' && c <= '9') {
							format_it = format_it.next_char ();
							c = format_it.get_char ();
						}
					}
					// length modifier
					int length = 0;
					if (c == 'h') {
						length = -1;
						format_it = format_it.next_char ();
						c = format_it.get_char ();
						if (c == 'h') {
							length = -2;
							format_it = format_it.next_char ();
							c = format_it.get_char ();
						}
					} else if (c == 'l') {
						length = 1;
						format_it = format_it.next_char ();
						c = format_it.get_char ();
					} else if (c == 'z') {
						length = 2;
						format_it = format_it.next_char ();
						c = format_it.get_char ();
					}
					// conversion specifier
					DataType param_type = null;
					if (c == 'd' || c == 'i' || c == 'c') {
						// integer
						if (length == -2) {
							param_type = analyzer.int8_type;
						} else if (length == -1) {
							param_type = analyzer.short_type;
						} else if (length == 0) {
							param_type = analyzer.int_type;
						} else if (length == 1) {
							param_type = analyzer.long_type;
						} else if (length == 2) {
							param_type = analyzer.ssize_t_type;
						}
					} else if (c == 'o' || c == 'u' || c == 'x' || c == 'X') {
						// unsigned integer
						if (length == -2) {
							param_type = analyzer.uchar_type;
						} else if (length == -1) {
							param_type = analyzer.ushort_type;
						} else if (length == 0) {
							param_type = analyzer.uint_type;
						} else if (length == 1) {
							param_type = analyzer.ulong_type;
						} else if (length == 2) {
							param_type = analyzer.size_t_type;
						}
					} else if (c == 'e' || c == 'E' || c == 'f' || c == 'F'
					           || c == 'g' || c == 'G' || c == 'a' || c == 'A') {
						// double
						param_type = analyzer.double_type;
					} else if (c == 's') {
						// string
						param_type = analyzer.string_type;
					} else if (c == 'p') {
						// pointer
						param_type = new PointerType (new VoidType ());
					} else if (c == '%') {
						// literal %
					} else {
						unsupported_format = true;
						break;
					}
					if (c != '\0') {
						format_it = format_it.next_char ();
						c = format_it.get_char ();
					}
					if (param_type != null) {
						if (arg_it.next ()) {
							Expression arg = arg_it.get ();

							arg.target_type = param_type;
						} else {
							Report.error (source_reference, "Too few arguments for specified format");
							return false;
						}
					}
				}
				if (!unsupported_format && arg_it.next ()) {
					Report.error (source_reference, "Too many arguments for specified format");
					return false;
				}
			}
		}

		foreach (Expression arg in get_argument_list ()) {
			arg.check (analyzer);
		}

		if (ret_type is VoidType) {
			// void return type
			if (!(parent_node is ExpressionStatement)
			    && !(parent_node is ForStatement)
			    && !(parent_node is YieldStatement)) {
				// A void method invocation can be in the initializer or
				// iterator of a for statement
				error = true;
				Report.error (source_reference, "invocation of void method not allowed as expression");
				return false;
			}
		}

		formal_value_type = ret_type;
		value_type = formal_value_type.get_actual_type (target_object_type, call as MemberAccess, this);

		bool may_throw = false;

		if (mtype is MethodType) {
			var m = ((MethodType) mtype).method_symbol;
			if (is_yield_expression) {
				if (!m.coroutine) {
					error = true;
					Report.error (source_reference, "yield expression requires async method");
				}
				if (analyzer.current_method == null || !analyzer.current_method.coroutine) {
					error = true;
					Report.error (source_reference, "yield expression not available outside async method");
				}
			}
			if (m != null && m.coroutine && !is_yield_expression && ((MemberAccess) call).member_name != "end") {
				// .begin call of async method, no error can happen here
			} else {
				foreach (DataType error_type in m.get_error_types ()) {
					may_throw = true;

					// ensure we can trace back which expression may throw errors of this type
					var call_error_type = error_type.copy ();
					call_error_type.source_reference = source_reference;

					add_error_type (call_error_type);
				}
			}
		} else if (mtype is DelegateType) {
			var d = ((DelegateType) mtype).delegate_symbol;
			foreach (DataType error_type in d.get_error_types ()) {
				may_throw = true;

				// ensure we can trace back which expression may throw errors of this type
				var call_error_type = error_type.copy ();
				call_error_type.source_reference = source_reference;

				add_error_type (call_error_type);
			}
		}

		if (!analyzer.check_arguments (this, mtype, params, get_argument_list ())) {
			error = true;
			return false;
		}

		if (may_throw) {
			if (parent_node is LocalVariable || parent_node is ExpressionStatement) {
				// simple statements, no side effects after method call
			} else if (!(analyzer.current_symbol is Block)) {
				// can't handle errors in field initializers
				Report.error (source_reference, "Field initializers must not throw errors");
			} else {
				// store parent_node as we need to replace the expression in the old parent node later on
				var old_parent_node = parent_node;

				var local = new LocalVariable (value_type, get_temp_name (), null, source_reference);
				// use floating variable to avoid unnecessary (and sometimes impossible) copies
				local.floating = true;
				var decl = new DeclarationStatement (local, source_reference);

				insert_statement (analyzer.insert_block, decl);

				Expression temp_access = new MemberAccess.simple (local.name, source_reference);
				temp_access.target_type = target_type;

				// don't set initializer earlier as this changes parent_node and parent_statement
				local.initializer = this;
				decl.check (analyzer);
				temp_access.check (analyzer);

				// move temp variable to insert block to ensure the
				// variable is in the same block as the declaration
				// otherwise there will be scoping issues in the generated code
				var block = (Block) analyzer.current_symbol;
				block.remove_local_variable (local);
				analyzer.insert_block.add_local_variable (local);

				old_parent_node.replace_expression (this, temp_access);
			}
		}

		return !error;
	}

	public override void get_defined_variables (Collection<LocalVariable> collection) {
		call.get_defined_variables (collection);

		foreach (Expression arg in argument_list) {
			arg.get_defined_variables (collection);
		}
	}

	public override void get_used_variables (Collection<LocalVariable> collection) {
		call.get_used_variables (collection);

		foreach (Expression arg in argument_list) {
			arg.get_used_variables (collection);
		}
	}
}
