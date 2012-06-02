/* valasemanticanalyzer.vala
 *
 * Copyright (C) 2006-2010  Jürg Billeter
 * Copyright (C) 2006-2008  Raffaele Sandrini
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
 *	Raffaele Sandrini <raffaele@sandrini.ch>
 */

using GLib;

/**
 * Code visitor analyzing and checking code.
 */
public class Vala.SemanticAnalyzer : CodeVisitor {
	public CodeContext context { get; set; }

	public Symbol root_symbol;
	public Symbol current_symbol { get; set; }
	public SourceFile current_source_file { get; set; }

	public TypeSymbol? current_type_symbol {
		get {
			var sym = current_symbol;
			while (sym != null) {
				if (sym is TypeSymbol) {
					return (TypeSymbol) sym;
				}
				sym = sym.parent_symbol;
			}
			return null;
		}
	}

	public Class? current_class {
		get { return current_type_symbol as Class; }
	}


	public Struct? current_struct {
		get { return current_type_symbol as Struct; }
	}

	public Method? current_method {
		get {
			unowned Symbol sym = current_symbol;
			while (sym is Block) {
				sym = sym.parent_symbol;
			}
			return sym as Method;
		}
	}

	public Method? current_async_method {
		get {
			unowned Symbol sym = current_symbol;
			while (sym is Block || sym is Method) {
				var m = sym as Method;
				if (m != null && m.coroutine) {
					break;
				}

				sym = sym.parent_symbol;
			}
			return sym as Method;
		}
	}

	public PropertyAccessor? current_property_accessor {
		get {
			unowned Symbol sym = current_symbol;
			while (sym is Block) {
				sym = sym.parent_symbol;
			}
			return sym as PropertyAccessor;
		}
	}

	public Symbol? current_method_or_property_accessor {
		get {
			unowned Symbol sym = current_symbol;
			while (sym is Block) {
				sym = sym.parent_symbol;
			}
			if (sym is Method) {
				return sym;
			} else if (sym is PropertyAccessor) {
				return sym;
			} else {
				return null;
			}
		}
	}

	public DataType? current_return_type {
		get {
			var m = current_method;
			if (m != null) {
				return m.return_type;
			}

			var acc = current_property_accessor;
			if (acc != null) {
				if (acc.readable) {
					return acc.value_type;
				} else {
					return void_type;
				}
			}

			if (is_in_constructor () || is_in_destructor ()) {
				return void_type;
			}

			return null;
		}
	}

	public Block insert_block;

	public DataType void_type = new VoidType ();
	public DataType bool_type;
	public DataType string_type;
	public DataType regex_type;
	public DataType uchar_type;
	public DataType short_type;
	public DataType ushort_type;
	public DataType int_type;
	public DataType uint_type;
	public DataType long_type;
	public DataType ulong_type;
	public DataType size_t_type;
	public DataType ssize_t_type;
	public DataType int8_type;
	public DataType unichar_type;
	public DataType double_type;
	public DataType type_type;
	public Class object_type;
	public StructValueType gvalue_type;
	public ObjectType gvariant_type;
	public DataType glist_type;
	public DataType gslist_type;
	public DataType garray_type;
	public DataType gvaluearray_type;
	public Class gerror_type;
	public DataType list_type;
	public DataType tuple_type;
	public DataType error_type;

	public int next_lambda_id = 0;

	// keep replaced alive to make sure they remain valid
	// for the whole execution of CodeNode.accept
	public List<CodeNode> replaced_nodes = new ArrayList<CodeNode> ();

	public SemanticAnalyzer () {
	}

	/**
	 * Analyze and check code in the specified context.
	 *
	 * @param context a code context
	 */
	public void analyze (CodeContext context) {
		this.context = context;

		root_symbol = context.root;

		bool_type = new BooleanType ((Struct) root_symbol.scope.lookup ("bool"));
		string_type = new ObjectType ((Class) root_symbol.scope.lookup ("string"));
		int_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int"));
		uint_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint"));

		if (context.profile != Profile.DOVA) {
			uchar_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uchar"));
			int8_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int8"));
			short_type = new IntegerType ((Struct) root_symbol.scope.lookup ("short"));
			ushort_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ushort"));
			long_type = new IntegerType ((Struct) root_symbol.scope.lookup ("long"));
			ulong_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ulong"));
			size_t_type = new IntegerType ((Struct) root_symbol.scope.lookup ("size_t"));
			ssize_t_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ssize_t"));
			double_type = new FloatingType ((Struct) root_symbol.scope.lookup ("double"));
		} else {
			long_type = int_type;
			ulong_type = uint_type;
			size_t_type = uint_type;
			ssize_t_type = int_type;
		}

		var unichar_struct = (Struct) root_symbol.scope.lookup ("unichar");
		if (unichar_struct != null) {
			unichar_type = new IntegerType (unichar_struct);
		}

		if (context.profile == Profile.GOBJECT) {
			var glib_ns = root_symbol.scope.lookup ("GLib");

			object_type = (Class) glib_ns.scope.lookup ("Object");
			type_type = new IntegerType ((Struct) glib_ns.scope.lookup ("Type"));
			gvalue_type = new StructValueType ((Struct) glib_ns.scope.lookup ("Value"));
			gvariant_type = new ObjectType ((Class) glib_ns.scope.lookup ("Variant"));

			glist_type = new ObjectType ((Class) glib_ns.scope.lookup ("List"));
			gslist_type = new ObjectType ((Class) glib_ns.scope.lookup ("SList"));
			garray_type = new ObjectType ((Class) glib_ns.scope.lookup ("Array"));
			gvaluearray_type = new ObjectType ((Class) glib_ns.scope.lookup ("ValueArray"));

			gerror_type = (Class) glib_ns.scope.lookup ("Error");
			regex_type = new ObjectType ((Class) root_symbol.scope.lookup ("GLib").scope.lookup ("Regex"));
		} else if (context.profile == Profile.DOVA) {
			var dova_ns = root_symbol.scope.lookup ("Dova");

			object_type = (Class) dova_ns.scope.lookup ("Object");
			type_type = new ObjectType ((Class) dova_ns.scope.lookup ("Type"));
			list_type = new ObjectType ((Class) dova_ns.scope.lookup ("List"));
			tuple_type = new ObjectType ((Class) dova_ns.scope.lookup ("Tuple"));
			error_type = new ObjectType ((Class) dova_ns.scope.lookup ("Error"));
		}

		current_symbol = root_symbol;
		context.root.check (context);
		context.accept (this);
	}

	public override void visit_source_file (SourceFile file) {
		current_source_file = file;

		file.check (context);
	}

	// check whether type is at least as accessible as the specified symbol
	public bool is_type_accessible (Symbol sym, DataType type) {
		return type.is_accessible (sym);
	}

	public DataType? get_value_type_for_symbol (Symbol sym, bool lvalue) {
		if (sym is Field) {
			var f = (Field) sym;
			var type = f.variable_type.copy ();
			if (!lvalue) {
				type.value_owned = false;
			}
			return type;
		} else if (sym is EnumValue) {
			return new EnumValueType ((Enum) sym.parent_symbol);
		} else if (sym is Constant) {
			var c = (Constant) sym;
			return c.type_reference;
		} else if (sym is Property) {
			var prop = (Property) sym;
			if (lvalue) {
				if (prop.set_accessor != null && prop.set_accessor.value_type != null) {
					return prop.set_accessor.value_type.copy ();
				}
			} else {
				if (prop.get_accessor != null && prop.get_accessor.value_type != null) {
					return prop.get_accessor.value_type.copy ();
				}
			}
		} else if (sym is Parameter) {
			var p = (Parameter) sym;
			var type = p.variable_type.copy ();
			if (!lvalue) {
				type.value_owned = false;
			}
			return type;
		} else if (sym is LocalVariable) {
			var local = (LocalVariable) sym;
			var type = local.variable_type.copy ();
			if (!lvalue && !local.floating) {
				type.value_owned = false;
			}
			return type;
		} else if (sym is Method) {
			return new MethodType ((Method) sym);
		} else if (sym is Signal) {
			return new SignalType ((Signal) sym);
		}
		return null;
	}

	public static Symbol? symbol_lookup_inherited (Symbol sym, string name) {
		var result = sym.scope.lookup (name);
		if (result != null) {
			return result;
		}

		if (sym is Class) {
			var cl = (Class) sym;
			// first check interfaces without prerequisites
			// (prerequisites can be assumed to be met already)
			foreach (DataType base_type in cl.get_base_types ()) {
				if (base_type.data_type is Interface) {
					result = base_type.data_type.scope.lookup (name);
					if (result != null) {
						return result;
					}
				}
			}
			// then check base class recursively
			if (cl.base_class != null) {
				return symbol_lookup_inherited (cl.base_class, name);
			}
		} else if (sym is Struct) {
			var st = (Struct) sym;
			if (st.base_type != null) {
				result = symbol_lookup_inherited (st.base_type.data_type, name);
				if (result != null) {
					return result;
				}
			}
		} else if (sym is Interface) {
			var iface = (Interface) sym;
			// first check interface prerequisites recursively
			foreach (DataType prerequisite in iface.get_prerequisites ()) {
				if (prerequisite.data_type is Interface) {
					result = symbol_lookup_inherited (prerequisite.data_type, name);
					if (result != null) {
						return result;
					}
				}
			}
			// then check class prerequisite recursively
			foreach (DataType prerequisite in iface.get_prerequisites ()) {
				if (prerequisite.data_type is Class) {
					result = symbol_lookup_inherited (prerequisite.data_type, name);
					if (result != null) {
						return result;
					}
				}
			}
		}

		return null;
	}

	public static DataType get_data_type_for_symbol (TypeSymbol sym) {
		DataType type = null;

		List<TypeParameter> type_parameters = null;
		if (sym is ObjectTypeSymbol) {
			type = new ObjectType ((ObjectTypeSymbol) sym);
			type_parameters = ((ObjectTypeSymbol) sym).get_type_parameters ();
		} else if (sym is Struct) {
			var st = (Struct) sym;
			if (st.is_boolean_type ()) {
				type = new BooleanType (st);
			} else if (st.is_integer_type ()) {
				type = new IntegerType (st);
			} else if (st.is_floating_type ()) {
				type = new FloatingType (st);
			} else {
				type = new StructValueType (st);
			}
			type_parameters = st.get_type_parameters ();
		} else if (sym is Enum) {
			type = new EnumValueType ((Enum) sym);
		} else if (sym is ErrorDomain) {
			type = new ErrorType ((ErrorDomain) sym, null);
		} else if (sym is ErrorCode) {
			type = new ErrorType ((ErrorDomain) sym.parent_symbol, (ErrorCode) sym);
		} else {
			Report.error (null, "internal error: `%s' is not a supported type".printf (sym.get_full_name ()));
			return new InvalidType ();
		}

		if (type_parameters != null) {
			foreach (var type_param in type_parameters) {
				var type_arg = new GenericType (type_param);
				type_arg.value_owned = true;
				type.add_type_argument (type_arg);
			}
		}

		return type;
	}

	public bool check_arguments (Expression expr, DataType mtype, List<Parameter> params, List<Expression> args) {
		Expression prev_arg = null;
		Iterator<Expression> arg_it = args.iterator ();

		bool diag = (mtype is MethodType && ((MethodType) mtype).method_symbol.get_attribute ("Diagnostics") != null);

		bool ellipsis = false;
		int i = 0;
		foreach (Parameter param in params) {
			if (!param.check (context)) {
				return false;
			}

			if (param.ellipsis) {
				ellipsis = true;
				break;
			}

			if (param.params_array) {
				while (arg_it.next ()) {
					var arg = arg_it.get ();
					if (!check_argument (arg, i, param.direction)) {
						expr.error = true;
						return false;
					}

					i++;
				}

				break;
			}

			if (arg_it == null || !arg_it.next ()) {
				if (param.initializer == null) {
					expr.error = true;
					var m = mtype as MethodType;
					if (m != null) {
						Report.error (expr.source_reference, "%d missing arguments for `%s'".printf (m.get_parameters ().size - args.size, m.to_prototype_string ()));
					} else {
						Report.error (expr.source_reference, "Too few arguments, method `%s' does not take %d arguments".printf (mtype.to_string (), args.size));
					}
					return false;
				} else {
					var invocation_expr = expr as MethodCall;
					var object_creation_expr = expr as ObjectCreationExpression;
					if (invocation_expr != null) {
						invocation_expr.add_argument (param.initializer);
					} else if (object_creation_expr != null) {
						object_creation_expr.add_argument (param.initializer);
					} else {
						assert_not_reached ();
					}
					arg_it = null;
				}
			} else {
				var arg = arg_it.get ();
				if (!check_argument (arg, i, param.direction)) {
					expr.error = true;
					return false;
				}

				prev_arg = arg;

				i++;
			}
		}

		if (ellipsis) {
			while (arg_it != null && arg_it.next ()) {
				var arg = arg_it.get ();
				if (arg.error) {
					// ignore inner error
					expr.error = true;
					return false;
				} else if (arg.value_type is SignalType) {
					arg.error = true;
					Report.error (arg.source_reference, "Cannot pass signals as arguments");
					return false;
				} else if (arg.value_type == null) {
					// disallow untyped arguments except for type inference of callbacks
					if (!(arg.symbol_reference is Method)) {
						expr.error = true;
						Report.error (expr.source_reference, "Invalid type for argument %d".printf (i + 1));
						return false;
					}
				} else if (arg.target_type != null && !arg.value_type.compatible (arg.target_type)) {
					// target_type known for printf arguments
					expr.error = true;
					Report.error (arg.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.value_type.to_string (), arg.target_type.to_string ()));
					return false;
				}

				i++;
			}
		} else if (!ellipsis && arg_it != null && arg_it.next ()) {
			expr.error = true;
			var m = mtype as MethodType;
			if (m != null) {
				Report.error (expr.source_reference, "%d extra arguments for `%s'".printf (args.size - m.get_parameters ().size, m.to_prototype_string ()));
			} else {
				Report.error (expr.source_reference, "Too many arguments, method `%s' does not take %d arguments".printf (mtype.to_string (), args.size));
			}
			return false;
		}

		if (diag && prev_arg != null) {
			var format_arg = prev_arg as StringLiteral;
			if (format_arg != null) {
				format_arg.value = "\"%s:%d: %s".printf (Path.get_basename (expr.source_reference.file.filename), expr.source_reference.begin.line, format_arg.value.substring (1));
			}
		}

		return true;
	}

	bool check_argument (Expression arg, int i, ParameterDirection direction) {
		if (arg.error) {
			// ignore inner error
			return false;
		} else if (arg is NamedArgument) {
			Report.error (arg.source_reference, "Named arguments are not supported yet");
			return false;
		} else if (arg.value_type == null) {
			// disallow untyped arguments except for type inference of callbacks
			if (!(arg.target_type is DelegateType) || !(arg.symbol_reference is Method)) {
				Report.error (arg.source_reference, "Invalid type for argument %d".printf (i + 1));
				return false;
			}
		} else if (arg.target_type != null
		           && (direction == ParameterDirection.IN || direction == ParameterDirection.REF)
		           && !arg.value_type.compatible (arg.target_type)) {
			Report.error (arg.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.value_type.to_string (), arg.target_type.to_string ()));
			return false;
		} else if (arg.target_type != null
		           && (direction == ParameterDirection.REF || direction == ParameterDirection.OUT)
		           && !arg.target_type.compatible (arg.value_type)
		           && !(arg is NullLiteral)) {
			Report.error (arg.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.target_type.to_string (), arg.value_type.to_string ()));
			return false;
		} else {
			// 0 => null, 1 => in, 2 => ref, 3 => out
			int arg_type = 1;
			if (arg.value_type is NullType) {
				arg_type = 0;
			} else if (arg is UnaryExpression) {
				var unary = (UnaryExpression) arg;
				if (unary.operator == UnaryOperator.REF) {
					arg_type = 2;
				} else if (unary.operator == UnaryOperator.OUT) {
					arg_type = 3;
				}
			}

			if (arg_type == 0) {
				if (direction == ParameterDirection.REF) {
					Report.error (arg.source_reference, "Argument %d: Cannot pass null to reference parameter".printf (i + 1));
					return false;
				} else if (direction != ParameterDirection.OUT && !arg.target_type.nullable) {
					Report.warning (arg.source_reference, "Argument %d: Cannot pass null to non-null parameter type".printf (i + 1));
				}
			} else if (arg_type == 1) {
				if (direction != ParameterDirection.IN) {
					Report.error (arg.source_reference, "Argument %d: Cannot pass value to reference or output parameter".printf (i + 1));
					return false;
				}
			} else if (arg_type == 2) {
				if (direction != ParameterDirection.REF) {
					Report.error (arg.source_reference, "Argument %d: Cannot pass ref argument to non-reference parameter".printf (i + 1));
					return false;
				}

				// weak variables can only be used with weak ref parameters
				if (arg.target_type.is_disposable ()) {
					if (!(arg.value_type is PointerType) && !arg.value_type.value_owned) {
						/* variable doesn't own the value */
						Report.error (arg.source_reference, "Argument %d: Cannot pass unowned ref argument to owned reference parameter".printf (i + 1));
						return false;
					}
				}

				// owned variables can only be used with owned ref parameters
				if (arg.value_type.is_disposable ()) {
					if (!arg.target_type.value_owned) {
						/* parameter doesn't own the value */
						Report.error (arg.source_reference, "Argument %d: Cannot pass owned ref argument to unowned reference parameter".printf (i + 1));
						return false;
					}
				}
			} else if (arg_type == 3) {
				if (direction != ParameterDirection.OUT) {
					Report.error (arg.source_reference, "Argument %d: Cannot pass out argument to non-output parameter".printf (i + 1));
					return false;
				}

				// weak variables can only be used with weak out parameters
				if (arg.target_type.is_disposable ()) {
					if (!(arg.value_type is PointerType) && !arg.value_type.value_owned) {
						/* variable doesn't own the value */
						Report.error (arg.source_reference, "Invalid assignment from owned expression to unowned variable");
						return false;
					}
				}
			}
		}
		var ma = arg as MemberAccess;
		if (ma != null && ma.prototype_access) {
			// allow prototype access if target type is delegate without target
			var deleg_type = arg.target_type as DelegateType;
			if (deleg_type == null || deleg_type.delegate_symbol.has_target) {
				Report.error (arg.source_reference, "Access to instance member `%s' denied".printf (arg.symbol_reference.get_full_name ()));
				return false;
			}
		}
		return true;
	}

	private static DataType? get_instance_base_type (DataType instance_type, DataType base_type, CodeNode node_reference) {
		// construct a new type reference for the base type with correctly linked type arguments
		ReferenceType instance_base_type;
		if (base_type.data_type is Class) {
			instance_base_type = new ObjectType ((Class) base_type.data_type);
		} else {
			instance_base_type = new ObjectType ((Interface) base_type.data_type);
		}
		foreach (DataType type_arg in base_type.get_type_arguments ()) {
			// resolve type argument specified in base type (possibly recursively for nested generic types)
			type_arg = type_arg.get_actual_type (instance_type, null, node_reference);
			instance_base_type.add_type_argument (type_arg);
		}
		return instance_base_type;
	}

	static DataType? get_instance_base_type_for_member (DataType derived_instance_type, TypeSymbol type_symbol, CodeNode node_reference) {
		DataType instance_type = derived_instance_type;

		while (instance_type is PointerType) {
			var instance_pointer_type = (PointerType) instance_type;
			instance_type = instance_pointer_type.base_type;
		}

		if (CodeContext.get ().profile == Profile.DOVA) {
			while (instance_type is ArrayType) {
				var instance_array_type = (ArrayType) instance_type;
				instance_type = new ObjectType ((Class) CodeContext.get ().root.scope.lookup ("Dova").scope.lookup ("Array"));
				instance_type.add_type_argument (instance_array_type.element_type);
			}
		}

		if (instance_type is DelegateType && ((DelegateType) instance_type).delegate_symbol == type_symbol) {
			return instance_type;
		} else if (instance_type.data_type == type_symbol) {
			return instance_type;
		}

		DataType instance_base_type = null;

		// use same algorithm as symbol_lookup_inherited
		if (instance_type.data_type is Class) {
			var cl = (Class) instance_type.data_type;
			// first check interfaces without prerequisites
			// (prerequisites can be assumed to be met already)
			foreach (DataType base_type in cl.get_base_types ()) {
				if (base_type.data_type is Interface) {
					instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, base_type, node_reference), type_symbol, node_reference);
					if (instance_base_type != null) {
						return instance_base_type;
					}
				}
			}
			// then check base class recursively
			if (instance_base_type == null) {
				foreach (DataType base_type in cl.get_base_types ()) {
					if (base_type.data_type is Class) {
						instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, base_type, node_reference), type_symbol, node_reference);
						if (instance_base_type != null) {
							return instance_base_type;
						}
					}
				}
			}
		} else if (instance_type.data_type is Struct) {
			var st = (Struct) instance_type.data_type;
			if (st.base_type != null) {
				instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, st.base_type, node_reference), type_symbol, node_reference);
				if (instance_base_type != null) {
					return instance_base_type;
				}
			}
		} else if (instance_type.data_type is Interface) {
			var iface = (Interface) instance_type.data_type;
			// first check interface prerequisites recursively
			foreach (DataType prerequisite in iface.get_prerequisites ()) {
				if (prerequisite.data_type is Interface) {
					instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, prerequisite, node_reference), type_symbol, node_reference);
					if (instance_base_type != null) {
						return instance_base_type;
					}
				}
			}
			if (instance_base_type == null) {
				// then check class prerequisite recursively
				foreach (DataType prerequisite in iface.get_prerequisites ()) {
					if (prerequisite.data_type is Class) {
						instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, prerequisite, node_reference), type_symbol, node_reference);
						if (instance_base_type != null) {
							return instance_base_type;
						}
					}
				}
			}
		}

		return null;
	}

	public static DataType? get_actual_type (DataType? derived_instance_type, MemberAccess? method_access, GenericType generic_type, CodeNode node_reference) {
		DataType actual_type = null;
		if (generic_type.type_parameter.parent_symbol is TypeSymbol) {
			if (derived_instance_type != null) {
				// trace type arguments back to the datatype where the method has been declared
				var instance_type = get_instance_base_type_for_member (derived_instance_type, (TypeSymbol) generic_type.type_parameter.parent_symbol, node_reference);

				assert (instance_type != null);

				int param_index;
				if (instance_type is DelegateType) {
					param_index = ((DelegateType) instance_type).delegate_symbol.get_type_parameter_index (generic_type.type_parameter.name);
				} else {
					param_index = instance_type.data_type.get_type_parameter_index (generic_type.type_parameter.name);
				}
				if (param_index == -1) {
					Report.error (node_reference.source_reference, "internal error: unknown type parameter %s".printf (generic_type.type_parameter.name));
					node_reference.error = true;
					return null;
				}

				if (param_index < instance_type.get_type_arguments ().size) {
					actual_type = (DataType) instance_type.get_type_arguments ().get (param_index);
				}
			}
		} else {
			// generic method
			var m = (Method) generic_type.type_parameter.parent_symbol;

			if (method_access == null) {
				return generic_type;
			}

			int param_index = m.get_type_parameter_index (generic_type.type_parameter.name);
			if (param_index == -1) {
				Report.error (node_reference.source_reference, "internal error: unknown type parameter %s".printf (generic_type.type_parameter.name));
				node_reference.error = true;
				return null;
			}

			if (param_index < method_access.get_type_arguments ().size) {
				actual_type = (DataType) method_access.get_type_arguments ().get (param_index);
			}
		}

		if (actual_type == null) {
			// no actual type available
			return generic_type;
		}
		actual_type = actual_type.copy ();
		actual_type.value_owned = actual_type.value_owned && generic_type.value_owned;
		return actual_type;
	}

	public bool is_in_instance_method () {
		var sym = current_symbol;
		while (sym != null) {
			if (sym is CreationMethod) {
				return true;
			} else if (sym is Method) {
				var m = (Method) sym;
				return m.binding == MemberBinding.INSTANCE;
			} else if (sym is Constructor) {
				var c = (Constructor) sym;
				return c.binding == MemberBinding.INSTANCE;
			} else if (sym is Destructor) {
				var d = (Destructor) sym;
				return d.binding == MemberBinding.INSTANCE;
			} else if (sym is Property) {
				var p = (Property) sym;
				return p.binding == MemberBinding.INSTANCE;
			}
			sym = sym.parent_symbol;
		}

		return false;
	}

	public void visit_member_initializer (MemberInitializer init, DataType type) {
		init.symbol_reference = symbol_lookup_inherited (type.data_type, init.name);
		if (!(init.symbol_reference is Field || init.symbol_reference is Property)) {
			init.error = true;
			Report.error (init.source_reference, "Invalid member `%s' in `%s'".printf (init.name, type.data_type.get_full_name ()));
			return;
		}
		if (init.symbol_reference.access != SymbolAccessibility.PUBLIC) {
			init.error = true;
			Report.error (init.source_reference, "Access to private member `%s' denied".printf (init.symbol_reference.get_full_name ()));
			return;
		}
		DataType member_type = null;
		if (init.symbol_reference is Field) {
			var f = (Field) init.symbol_reference;
			member_type = f.variable_type;
		} else if (init.symbol_reference is Property) {
			var prop = (Property) init.symbol_reference;
			member_type = prop.property_type;
			if (prop.set_accessor == null || !prop.set_accessor.writable) {
				init.error = true;
				Report.error (init.source_reference, "Property `%s' is read-only".printf (prop.get_full_name ()));
				return;
			}
		}

		init.initializer.formal_target_type = member_type;
		init.initializer.target_type = init.initializer.formal_target_type.get_actual_type (type, null, init);;

		init.check (context);

		if (init.initializer.value_type == null || !init.initializer.value_type.compatible (init.initializer.target_type)) {
			init.error = true;
			Report.error (init.source_reference, "Invalid type for member `%s'".printf (init.name));
			return;
		}
	}

	Struct? get_arithmetic_struct (DataType type) {
		var result = type.data_type as Struct;
		if (result == null && type is EnumValueType) {
			return (Struct) int_type.data_type;
		}
		return result;
	}

	public DataType? get_arithmetic_result_type (DataType left_type, DataType right_type) {
		var left = get_arithmetic_struct (left_type);
		var right = get_arithmetic_struct (right_type);

		if (left == null || right == null) {
			// at least one operand not struct
			return null;
		}

		if ((!left.is_floating_type () && !left.is_integer_type ()) ||
		    (!right.is_floating_type () && !right.is_integer_type ())) {
			// at least one operand not numeric
			return null;
		}

		if (left.is_floating_type () == right.is_floating_type ()) {
			// both operands integer or floating type
			if (left.get_rank () >= right.get_rank ()) {
				return left_type;
			} else {
				return right_type;
			}
		} else {
			// one integer and one floating type operand
			if (left.is_floating_type ()) {
				return left_type;
			} else {
				return right_type;
			}
		}
	}

	public Method? find_current_method () {
		var sym = current_symbol;
		while (sym != null) {
			if (sym is Method) {
				return (Method) sym;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}

	public Method? find_parent_method (Symbol sym) {
		while (sym is Block) {
			sym = sym.parent_symbol;
		}
		return sym as Method;
	}

	public Symbol? find_parent_method_or_property_accessor (Symbol sym) {
		while (sym is Block) {
			sym = sym.parent_symbol;
		}
		if (sym is Method) {
			return sym;
		} else if (sym is PropertyAccessor) {
			return sym;
		} else {
			return null;
		}
	}

	public bool is_in_constructor () {
		var sym = current_symbol;
		while (sym != null) {
			if (sym is Constructor) {
				return true;
			}
			sym = sym.parent_symbol;
		}
		return false;
	}

	public bool is_in_destructor () {
		var sym = current_symbol;
		while (sym != null) {
			if (sym is Destructor) {
				return true;
			}
			sym = sym.parent_symbol;
		}
		return false;
	}
}
