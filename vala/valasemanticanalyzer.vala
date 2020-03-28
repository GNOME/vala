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
	CodeContext context;

	public Symbol? current_symbol { get; set; }
	public SourceFile current_source_file { get; set; }

	public TypeSymbol? current_type_symbol {
		get {
			unowned Symbol? sym = current_symbol;
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
			unowned Symbol? sym = current_symbol;
			while (sym is Block) {
				sym = sym.parent_symbol;
			}
			return sym as Method;
		}
	}

	public Method? current_async_method {
		get {
			unowned Symbol? sym = current_symbol;
			while (sym is Block || sym is Method) {
				unowned Method? m = sym as Method;
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
			unowned Symbol? sym = current_symbol;
			while (sym is Block) {
				sym = sym.parent_symbol;
			}
			return sym as PropertyAccessor;
		}
	}

	public Symbol? current_method_or_property_accessor {
		get {
			unowned Symbol? sym = current_symbol;
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
			unowned Method? m = current_method;
			if (m != null) {
				return m.return_type;
			}

			unowned PropertyAccessor? acc = current_property_accessor;
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
	public DataType char_type;
	public DataType uchar_type;
	public DataType short_type;
	public DataType ushort_type;
	public DataType int_type;
	public DataType uint_type;
	public DataType long_type;
	public DataType ulong_type;
	public DataType int8_type;
	public DataType uint8_type;
	public DataType int16_type;
	public DataType uint16_type;
	public DataType int32_type;
	public DataType uint32_type;
	public DataType size_t_type;
	public DataType ssize_t_type;
	public DataType unichar_type;
	public DataType double_type;
	public DataType string_type;
	public DataType regex_type;
	public DataType type_type;
	public DataType va_list_type;
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
	public Class gsource_type;
	public DataType delegate_target_type;
	public DelegateType delegate_target_destroy_type;
	public DelegateType generics_dup_func_type;

	Delegate destroy_notify;

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

		var root_symbol = context.root;

		bool_type = new BooleanType ((Struct) root_symbol.scope.lookup ("bool"));
		char_type = new IntegerType ((Struct) root_symbol.scope.lookup ("char"));
		uchar_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uchar"));
		short_type = new IntegerType ((Struct) root_symbol.scope.lookup ("short"));
		ushort_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ushort"));
		int_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int"));
		uint_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint"));
		long_type = new IntegerType ((Struct) root_symbol.scope.lookup ("long"));
		ulong_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ulong"));
		int8_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int8"));
		uint8_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint8"));
		int16_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int16"));
		uint16_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint16"));
		int32_type = new IntegerType ((Struct) root_symbol.scope.lookup ("int32"));
		uint32_type = new IntegerType ((Struct) root_symbol.scope.lookup ("uint32"));
		size_t_type = new IntegerType ((Struct) root_symbol.scope.lookup ("size_t"));
		ssize_t_type = new IntegerType ((Struct) root_symbol.scope.lookup ("ssize_t"));
		double_type = new FloatingType ((Struct) root_symbol.scope.lookup ("double"));
		string_type = new ObjectType ((Class) root_symbol.scope.lookup ("string"));
		va_list_type = new StructValueType ((Struct) root_symbol.scope.lookup ("va_list"));

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

			gsource_type = (Class) glib_ns.scope.lookup ("Source");

			delegate_target_type = new StructValueType ((Struct) glib_ns.scope.lookup ("pointer"));
			destroy_notify = (Delegate) glib_ns.scope.lookup ("DestroyNotify");
			delegate_target_destroy_type = new DelegateType (destroy_notify);

			generics_dup_func_type = new DelegateType ((Delegate) glib_ns.scope.lookup ("BoxedCopyFunc"));
		} else {
			delegate_target_type = new PointerType (new VoidType ());
			destroy_notify = new Delegate ("ValaDestroyNotify", new VoidType ());
			destroy_notify.add_parameter (new Parameter ("data", new PointerType (new VoidType ())));
			destroy_notify.has_target = false;
			destroy_notify.owner = context.root.scope;
			delegate_target_destroy_type = new DelegateType (destroy_notify);
		}

		current_symbol = root_symbol;
		context.root.check (context);
		context.accept (this);

		this.context = null;
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
			unowned Field f = (Field) sym;
			var type = f.variable_type.copy ();
			if (!lvalue) {
				type.value_owned = false;
			}
			return type;
		} else if (sym is EnumValue) {
			return new EnumValueType ((Enum) sym.parent_symbol);
		} else if (sym is Constant) {
			unowned Constant c = (Constant) sym;
			return c.type_reference;
		} else if (sym is Property) {
			unowned Property prop = (Property) sym;
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
			unowned Parameter p = (Parameter) sym;
			var type = p.variable_type.copy ();
			if (!lvalue) {
				type.value_owned = false;
			}
			return type;
		} else if (sym is LocalVariable) {
			unowned LocalVariable local = (LocalVariable) sym;
			var type = local.variable_type.copy ();
			if (!lvalue) {
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
			unowned Class cl = (Class) sym;
			// first check interfaces without prerequisites
			// (prerequisites can be assumed to be met already)
			foreach (DataType base_type in cl.get_base_types ()) {
				if (base_type.type_symbol is Interface) {
					result = base_type.type_symbol.scope.lookup (name);
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
			unowned Struct st = (Struct) sym;
			if (st.base_type != null) {
				result = symbol_lookup_inherited (st.base_type.type_symbol, name);
				if (result != null) {
					return result;
				}
			}
		} else if (sym is Interface) {
			unowned Interface iface = (Interface) sym;
			// first check interface prerequisites recursively
			foreach (DataType prerequisite in iface.get_prerequisites ()) {
				if (prerequisite.type_symbol is Interface) {
					result = symbol_lookup_inherited (prerequisite.type_symbol, name);
					if (result != null) {
						return result;
					}
				}
			}
			// then check class prerequisite recursively
			foreach (DataType prerequisite in iface.get_prerequisites ()) {
				if (prerequisite.type_symbol is Class) {
					result = symbol_lookup_inherited (prerequisite.type_symbol, name);
					if (result != null) {
						return result;
					}
				}
			}
		}

		return null;
	}

	public static DataType get_data_type_for_symbol (Symbol sym) {
		DataType type;

		List<TypeParameter> type_parameters = null;
		if (sym is ObjectTypeSymbol) {
			unowned Class cl = sym as Class;
			if (cl != null && cl.is_error_base) {
				type = new ErrorType (null, null);
			} else {
				type = new ObjectType ((ObjectTypeSymbol) sym);
				type_parameters = ((ObjectTypeSymbol) sym).get_type_parameters ();
			}
		} else if (sym is Struct) {
			unowned Struct st = (Struct) sym;
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

	public static unowned Symbol? get_symbol_for_data_type (DataType type) {
		unowned Symbol? sym = null;

		if (type is ObjectType) {
			sym = ((ObjectType) type).type_symbol;
		} else if (type is ClassType) {
			sym = ((ClassType) type).class_symbol;
		} else if (type is InterfaceType) {
			sym = ((InterfaceType) type).interface_symbol;
		} else if (type is MethodType) {
			sym = ((MethodType) type).method_symbol;
		} else if (type is SignalType) {
			sym = ((SignalType) type).signal_symbol;
		} else if (type is DelegateType) {
			sym = ((DelegateType) type).delegate_symbol;
		} else if (type is ValueType) {
			sym = ((ValueType) type).type_symbol;
		}

		return sym;
	}

	public bool is_gobject_property (Property prop) {
		unowned ObjectTypeSymbol? type_sym = prop.parent_symbol as ObjectTypeSymbol;
		if (type_sym == null || !type_sym.is_subtype_of (object_type)) {
			return false;
		}

		if (prop.binding != MemberBinding.INSTANCE) {
			return false;
		}

		if (prop.access == SymbolAccessibility.PRIVATE) {
			return false;
		}

		if (!is_gobject_property_type (prop.property_type)) {
			if (prop.property_type is ArrayType && (!prop.get_attribute_bool ("CCode", "array_length", true)
			    && prop.get_attribute_bool ("CCode", "array_null_terminated", false))) {
				// null-terminated arrays without length are allowed
			} else if (prop.property_type is DelegateType && !prop.get_attribute_bool ("CCode", "delegate_target", true)) {
				// delegates omitting their target are allowed
			} else {
				return false;
			}
		}

		if (type_sym is Class && prop.base_interface_property != null &&
		    !is_gobject_property (prop.base_interface_property)) {
			return false;
		}

		if (!prop.name[0].isalpha ()) {
			// GObject requires properties to start with a letter
			return false;
		}

		if (type_sym is Interface && !prop.is_abstract && !prop.external && !prop.external_package) {
			// GObject does not support non-abstract interface properties,
			// however we assume external properties always are GObject properties
			return false;
		}

		if (type_sym is Interface && type_sym.get_attribute ("DBus") != null) {
			// GObject properties not currently supported in D-Bus interfaces
			return false;
		}

		return true;
	}

	public bool is_gobject_property_type (DataType property_type) {
		unowned Struct? st = property_type.type_symbol as Struct;
		if (st != null) {
			if (!st.is_simple_type () && st.get_attribute_bool ("CCode", "has_type_id", true)) {
				// Allow GType-based struct types
			} else if (property_type.nullable) {
				return false;
			} else if (!st.get_attribute_bool ("CCode", "has_type_id", true)) {
				return false;
			}
		}

		if (property_type is ArrayType && ((ArrayType) property_type).element_type.type_symbol != string_type.type_symbol) {
			return false;
		}

		unowned DelegateType? d = property_type as DelegateType;
		if (d != null && d.delegate_symbol.has_target) {
			return false;
		}

		return true;
	}

	public bool check_arguments (Expression expr, DataType mtype, List<Parameter> params, List<Expression> args) {
		bool error = false;

		Expression prev_arg = null;
		Iterator<Expression> arg_it = args.iterator ();

		bool diag = (mtype is MethodType && ((MethodType) mtype).method_symbol.get_attribute ("Diagnostics") != null);

		bool ellipsis = false;
		int i = 0;
		foreach (Parameter param in params) {
			if (param.ellipsis) {
				ellipsis = true;
				break;
			}

			if (param.params_array) {
				while (arg_it.next ()) {
					var arg = arg_it.get ();
					if (!check_argument (arg, i, param.direction)) {
						expr.error = true;
						error = true;
					}

					i++;
				}

				break;
			}

			if (arg_it == null || !arg_it.next ()) {
				if (param.initializer == null) {
					expr.error = true;
					unowned MethodType? m = mtype as MethodType;
					if (m != null) {
						Report.error (expr.source_reference, "%d missing arguments for `%s'".printf (m.get_parameters ().size - args.size, m.to_prototype_string ()));
					} else {
						Report.error (expr.source_reference, "Too few arguments, method `%s' does not take %d arguments".printf (mtype.to_string (), args.size));
					}
					error = true;
				} else {
					unowned MethodCall? invocation_expr = expr as MethodCall;
					unowned ObjectCreationExpression? object_creation_expr = expr as ObjectCreationExpression;
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
					error = true;
				}

				prev_arg = arg;

				i++;
			}
		}

		if (ellipsis && !check_variadic_arguments (arg_it, i, expr.source_reference)) {
			expr.error = true;
			error = true;
		} else if (!ellipsis && arg_it != null && arg_it.next ()) {
			expr.error = true;
			unowned MethodType? m = mtype as MethodType;
			if (m != null) {
				Report.error (expr.source_reference, "%d extra arguments for `%s'".printf (args.size - m.get_parameters ().size, m.to_prototype_string ()));
			} else {
				Report.error (expr.source_reference, "Too many arguments, method `%s' does not take %d arguments".printf (mtype.to_string (), args.size));
			}
			error = true;
		}

		if (diag && prev_arg != null) {
			unowned StringLiteral? format_arg = prev_arg as StringLiteral;
			if (format_arg != null) {
				format_arg.value = "\"%s:%d: %s".printf (Path.get_basename (expr.source_reference.file.filename), expr.source_reference.begin.line, format_arg.value.substring (1));
			}
		}

		return !error;
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

		if (arg.target_type != null) {
			if ((direction == ParameterDirection.IN || direction == ParameterDirection.REF)
			    && !arg.value_type.compatible (arg.target_type)) {
				Report.error (arg.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.value_type.to_prototype_string (), arg.target_type.to_prototype_string ()));
				return false;
			} else if ((direction == ParameterDirection.REF || direction == ParameterDirection.OUT)
		                && !arg.target_type.compatible (arg.value_type)
		                && !(arg is NullLiteral)) {
				Report.error (arg.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.target_type.to_prototype_string (), arg.value_type.to_prototype_string ()));
				return false;
			}
		}

		unowned MemberAccess? ma = arg as MemberAccess;
		if (ma != null && ma.prototype_access) {
			// allow prototype access if target type is delegate without target
			unowned DelegateType? deleg_type = arg.target_type as DelegateType;
			if (deleg_type == null || deleg_type.delegate_symbol.has_target) {
				Report.error (arg.source_reference, "Access to instance member `%s' denied".printf (arg.symbol_reference.get_full_name ()));
				return false;
			}
		}
		return true;
	}

	public bool check_variadic_arguments (Iterator<Expression>? arg_it, int i, SourceReference source_reference) {
		while (arg_it != null && arg_it.next ()) {
			var arg = arg_it.get ();
			if (arg.error) {
				// ignore inner error
				return false;
			} else if (arg.value_type is SignalType) {
				arg.error = true;
				Report.error (arg.source_reference, "Cannot pass signals as arguments");
				return false;
			} else if (arg.value_type == null) {
				// disallow untyped arguments except for type inference of callbacks
				if (!(arg.symbol_reference is Method)) {
					Report.error (source_reference, "Invalid type for argument %d".printf (i + 1));
					return false;
				}
			} else if (arg.target_type != null && !arg.value_type.compatible (arg.target_type)) {
				// target_type known for printf arguments
				Report.error (arg.source_reference, "Argument %d: Cannot convert from `%s' to `%s'".printf (i + 1, arg.value_type.to_string (), arg.target_type.to_string ()));
				return false;
			}

			i++;
		}

		return true;
	}

	public bool check_print_format (string format, Iterator<Expression> arg_it, SourceReference source_reference) {
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
					param_type = int8_type;
				} else if (length == -1) {
					param_type = short_type;
				} else if (length == 0) {
					param_type = int_type;
				} else if (length == 1) {
					param_type = long_type;
				} else if (length == 2) {
					param_type = ssize_t_type;
				}
			} else if (c == 'o' || c == 'u' || c == 'x' || c == 'X') {
				// unsigned integer
				if (length == -2) {
					param_type = uchar_type;
				} else if (length == -1) {
					param_type = ushort_type;
				} else if (length == 0) {
					param_type = uint_type;
				} else if (length == 1) {
					param_type = ulong_type;
				} else if (length == 2) {
					param_type = size_t_type;
				}
			} else if (c == 'e' || c == 'E' || c == 'f' || c == 'F'
					   || c == 'g' || c == 'G' || c == 'a' || c == 'A') {
				// double
				param_type = double_type;
			} else if (c == 's') {
				// string
				param_type = string_type;
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

		return true;
	}

	private static DataType? get_instance_base_type (DataType instance_type, DataType base_type, CodeNode node_reference) {
		// construct a new type reference for the base type with correctly linked type arguments
		DataType instance_base_type;
		if (base_type.type_symbol is ObjectTypeSymbol) {
			instance_base_type = new ObjectType ((ObjectTypeSymbol) base_type.type_symbol);
		} else if (base_type.type_symbol is Struct) {
			instance_base_type = new StructValueType ((Struct) base_type.type_symbol);
		} else {
			assert_not_reached ();
		}
		foreach (DataType type_arg in base_type.get_type_arguments ()) {
			// resolve type argument specified in base type (possibly recursively for nested generic types)
			type_arg = type_arg.get_actual_type (instance_type, null, node_reference);
			instance_base_type.add_type_argument (type_arg);
		}
		return instance_base_type;
	}

	internal static DataType? get_instance_base_type_for_member (DataType derived_instance_type, TypeSymbol type_symbol, CodeNode? node_reference) {
		DataType instance_type = derived_instance_type;

		while (instance_type is PointerType) {
			unowned PointerType instance_pointer_type = (PointerType) instance_type;
			instance_type = instance_pointer_type.base_type;
		}

		if (instance_type is DelegateType && ((DelegateType) instance_type).delegate_symbol == type_symbol) {
			return instance_type;
		} else if (instance_type.type_symbol == type_symbol) {
			return instance_type;
		}

		DataType? instance_base_type = null;

		// use same algorithm as symbol_lookup_inherited
		if (instance_type.type_symbol is Class) {
			unowned Class cl = (Class) instance_type.type_symbol;
			// first check interfaces without prerequisites
			// (prerequisites can be assumed to be met already)
			foreach (DataType base_type in cl.get_base_types ()) {
				if (base_type.type_symbol is Interface) {
					instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, base_type, node_reference), type_symbol, node_reference);
					if (instance_base_type != null) {
						return instance_base_type;
					}
				}
			}
			// then check base class recursively
			if (instance_base_type == null) {
				foreach (DataType base_type in cl.get_base_types ()) {
					if (base_type.type_symbol is Class) {
						instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, base_type, node_reference), type_symbol, node_reference);
						if (instance_base_type != null) {
							return instance_base_type;
						}
					}
				}
			}
		} else if (instance_type.type_symbol is Struct) {
			unowned Struct st = (Struct) instance_type.type_symbol;
			if (st.base_type != null) {
				instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, st.base_type, node_reference), type_symbol, node_reference);
				if (instance_base_type != null) {
					return instance_base_type;
				}
			}
		} else if (instance_type.type_symbol is Interface) {
			unowned Interface iface = (Interface) instance_type.type_symbol;
			// first check interface prerequisites recursively
			foreach (DataType prerequisite in iface.get_prerequisites ()) {
				if (prerequisite.type_symbol is Interface) {
					instance_base_type = get_instance_base_type_for_member (get_instance_base_type (instance_type, prerequisite, node_reference), type_symbol, node_reference);
					if (instance_base_type != null) {
						return instance_base_type;
					}
				}
			}
			if (instance_base_type == null) {
				// then check class prerequisite recursively
				foreach (DataType prerequisite in iface.get_prerequisites ()) {
					if (prerequisite.type_symbol is Class) {
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

	public static DataType get_actual_type (DataType? derived_instance_type, List<DataType>? method_type_arguments, GenericType generic_type, CodeNode? node_reference) {
		DataType actual_type = null;
		if (generic_type.type_parameter.parent_symbol is TypeSymbol) {
			if (derived_instance_type != null) {
				// trace type arguments back to the datatype where the method has been declared
				var instance_type = get_instance_base_type_for_member (derived_instance_type, (TypeSymbol) generic_type.type_parameter.parent_symbol, node_reference);

				if (instance_type == null) {
					if (node_reference != null) {
						CodeNode? reference = get_symbol_for_data_type (derived_instance_type);
						Report.error ((reference ?? node_reference).source_reference, "The type-parameter `%s' is missing".printf (generic_type.to_string ()));
						node_reference.error = true;
					}
					return new InvalidType ();
				}

				int param_index;
				if (instance_type is DelegateType) {
					param_index = ((DelegateType) instance_type).delegate_symbol.get_type_parameter_index (generic_type.type_parameter.name);
				} else {
					param_index = instance_type.type_symbol.get_type_parameter_index (generic_type.type_parameter.name);
				}
				if (param_index == -1) {
					if (node_reference != null) {
						Report.error (node_reference.source_reference, "internal error: unknown type parameter %s".printf (generic_type.type_parameter.name));
						node_reference.error = true;
					}
					return new InvalidType ();
				}

				if (param_index < instance_type.get_type_arguments ().size) {
					actual_type = (DataType) instance_type.get_type_arguments ().get (param_index);
				}
			}
		} else {
			// generic method
			unowned Method m = (Method) generic_type.type_parameter.parent_symbol;

			int param_index = m.get_type_parameter_index (generic_type.type_parameter.name);
			if (param_index == -1) {
				if (node_reference != null) {
					Report.error (node_reference.source_reference, "internal error: unknown type parameter %s".printf (generic_type.type_parameter.name));
					node_reference.error = true;
				}
				return new InvalidType ();
			}

			if (method_type_arguments != null) {
				if (param_index < method_type_arguments.size) {
					actual_type = (DataType) method_type_arguments.get (param_index);
				}
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
		unowned Symbol? sym = current_symbol;
		while (sym != null) {
			if (sym is CreationMethod) {
				return true;
			} else if (sym is Method) {
				unowned Method m = (Method) sym;
				return m.binding == MemberBinding.INSTANCE;
			} else if (sym is Constructor) {
				unowned Constructor c = (Constructor) sym;
				return c.binding == MemberBinding.INSTANCE;
			} else if (sym is Destructor) {
				unowned Destructor d = (Destructor) sym;
				return d.binding == MemberBinding.INSTANCE;
			} else if (sym is Property) {
				unowned Property p = (Property) sym;
				return p.binding == MemberBinding.INSTANCE;
			}
			sym = sym.parent_symbol;
		}

		return false;
	}

	// Create an access to a temporary variable, with proper reference transfer if needed
	public static Expression create_temp_access (LocalVariable local, DataType? target_type) {
		Expression temp_access = new MemberAccess.simple (local.name, local.source_reference);

		var target_owned = target_type != null && target_type.value_owned;
		if (target_owned && local.variable_type.is_disposable ()) {
			temp_access = new ReferenceTransferExpression (temp_access, local.source_reference);
			temp_access.target_type = target_type != null ? target_type.copy () : local.variable_type.copy ();
			temp_access.target_type.value_owned = true;
		} else {
			temp_access.target_type = target_type != null ? target_type.copy () : null;
		}

		return temp_access;
	}

	public void visit_member_initializer (MemberInitializer init, DataType type) {
		init.symbol_reference = symbol_lookup_inherited (type.type_symbol, init.name);
		if (!(init.symbol_reference is Field || init.symbol_reference is Property)) {
			init.error = true;
			Report.error (init.source_reference, "Invalid member `%s' in `%s'".printf (init.name, type.type_symbol.get_full_name ()));
			return;
		}
		if (init.symbol_reference.access != SymbolAccessibility.PUBLIC) {
			init.error = true;
			Report.error (init.source_reference, "Access to private member `%s' denied".printf (init.symbol_reference.get_full_name ()));
			return;
		}
		DataType member_type = null;
		if (init.symbol_reference is Field) {
			unowned Field f = (Field) init.symbol_reference;
			member_type = f.variable_type;
		} else if (init.symbol_reference is Property) {
			unowned Property prop = (Property) init.symbol_reference;
			member_type = prop.property_type;
			if (prop.set_accessor == null || !prop.set_accessor.writable) {
				init.error = true;
				Report.error (init.source_reference, "Property `%s' is read-only".printf (prop.get_full_name ()));
				return;
			}
		}

		init.initializer.formal_target_type = member_type;
		init.initializer.target_type = init.initializer.formal_target_type.get_actual_type (type, null, init);

		if (!init.check (context)) {
			return;
		}

		if (init.initializer.value_type == null || !init.initializer.value_type.compatible (init.initializer.target_type)) {
			init.error = true;
			Report.error (init.source_reference, "Invalid type for member `%s'".printf (init.name));
			return;
		}
	}

	unowned Struct? get_arithmetic_struct (DataType type) {
		unowned Struct? result = type.type_symbol as Struct;
		if (result == null && type is EnumValueType) {
			return (Struct) int_type.type_symbol;
		}
		return result;
	}

	public unowned DataType? get_arithmetic_result_type (DataType left_type, DataType right_type) {
		unowned Struct? left = get_arithmetic_struct (left_type);
		unowned Struct? right = get_arithmetic_struct (right_type);

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
			if (left.rank >= right.rank) {
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

	public unowned Method? find_current_method () {
		unowned Symbol? sym = current_symbol;
		while (sym != null) {
			if (sym is Method) {
				return (Method) sym;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}

	public static unowned Method? find_parent_method (Symbol sym) {
		while (sym is Block) {
			sym = sym.parent_symbol;
		}
		return sym as Method;
	}

	public static unowned Symbol? find_parent_method_or_property_accessor (Symbol sym) {
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

	public static unowned TypeSymbol? find_parent_type_symbol (Symbol sym) {
		while (sym != null) {
			if (sym is TypeSymbol) {
				return (TypeSymbol) sym;
			}
			sym = sym.parent_symbol;
		}
		return null;
	}

	public static DataType? get_this_type (Symbol s, TypeSymbol? parent = null) {
		unowned TypeSymbol? parent_type = parent ?? find_parent_type_symbol (s);
		if (parent_type == null) {
			Report.error (parent_type.source_reference, "internal: Unsupported symbol type");
			return new InvalidType ();
		}

		MemberBinding binding;
		if (s is Method) {
			binding = ((Method) s).binding;
		} else if (s is Constructor) {
			binding = ((Constructor) s).binding;
		} else if (s is Destructor) {
			binding = ((Destructor) s).binding;
		} else if (s is Property) {
			binding = ((Property) s).binding;
		} else {
			Report.error (s.source_reference, "internal: Unsupported symbol type");
			return new InvalidType ();
		}

		DataType? this_type = null;
		List<TypeParameter>? type_parameters = null;
		switch (binding) {
		case MemberBinding.INSTANCE:
			if (parent_type is Class) {
				this_type = new ObjectType ((Class) parent_type);
				type_parameters = ((Class) parent_type).get_type_parameters ();
			} else if (parent_type is Interface) {
				this_type = new ObjectType ((Interface) parent_type);
				type_parameters = ((Interface) parent_type).get_type_parameters ();
			} else if (parent_type is Struct) {
				this_type = new StructValueType ((Struct) parent_type);
				type_parameters = ((Struct) parent_type).get_type_parameters ();
			} else if (parent_type is Enum) {
				this_type = new EnumValueType ((Enum) parent_type);
			} else {
				Report.error (parent_type.source_reference, "internal: Unsupported symbol type");
				this_type = new InvalidType ();
			}
			break;
		case MemberBinding.CLASS:
			if (parent_type is Class) {
				this_type = new ClassType ((Class) parent_type);
			} else if (parent_type is Interface) {
				this_type = new InterfaceType ((Interface) parent_type);
			} else {
				Report.error (parent_type.source_reference, "internal: Unsupported symbol type");
				this_type = new InvalidType ();
			}
			break;
		case MemberBinding.STATIC:
		default:
			Report.error (s.source_reference, "internal: Does not support a parent instance");
			this_type = new InvalidType ();
			break;
		}

		if (type_parameters != null) {
			foreach (var type_param in type_parameters) {
				var type_arg = new GenericType (type_param);
				type_arg.value_owned = true;
				this_type.add_type_argument (type_arg);
			}
		}

		return this_type;
	}

	public bool is_in_constructor () {
		unowned Symbol? sym = current_symbol;
		while (sym != null) {
			if (sym is Constructor) {
				return true;
			}
			sym = sym.parent_symbol;
		}
		return false;
	}

	public bool is_in_destructor () {
		unowned Symbol? sym = current_symbol;
		while (sym != null) {
			if (sym is Destructor) {
				return true;
			}
			sym = sym.parent_symbol;
		}
		return false;
	}

	public bool is_reference_type_argument (DataType type_arg) {
		if (type_arg is ErrorType || (type_arg.type_symbol != null && type_arg.type_symbol.is_reference_type ())) {
			return true;
		} else {
			return false;
		}
	}

	public bool is_nullable_value_type_argument (DataType type_arg) {
		if (type_arg is ValueType && type_arg.nullable) {
			return true;
		} else {
			return false;
		}
	}

	public bool is_signed_integer_type_argument (DataType type_arg) {
		unowned Struct? st = type_arg.type_symbol as Struct;
		if (type_arg is EnumValueType) {
			return true;
		} else if (type_arg.nullable) {
			return false;
		} else if (st == null) {
			return false;
		} else if (st.is_subtype_of (bool_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (char_type.type_symbol)) {
			return true;
		} else if (unichar_type != null && st.is_subtype_of (unichar_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (short_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (int_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (long_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (int8_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (int16_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (int32_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (type_type.type_symbol)) {
			return true;
		} else {
			return false;
		}
	}

	public bool is_unsigned_integer_type_argument (DataType type_arg) {
		unowned Struct? st = type_arg.type_symbol as Struct;
		if (st == null) {
			return false;
		} else if (type_arg.nullable) {
			return false;
		} else if (st.is_subtype_of (uchar_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (ushort_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (uint_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (ulong_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (uint8_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (uint16_type.type_symbol)) {
			return true;
		} else if (st.is_subtype_of (uint32_type.type_symbol)) {
			return true;
		} else {
			return false;
		}
	}

	public void check_type (DataType type) {
		foreach (var type_arg in type.get_type_arguments ()) {
			check_type (type_arg);
			check_type_argument (type_arg);
		}
	}

	public void check_type_arguments (MemberAccess access) {
		foreach (var type_arg in access.get_type_arguments ()) {
			check_type (type_arg);
			check_type_argument (type_arg);
		}
	}

	void check_type_argument (DataType type_arg) {
		if (type_arg is GenericType
		    || type_arg is PointerType
		    || type_arg is VoidType
		    || is_reference_type_argument (type_arg)
		    || is_nullable_value_type_argument (type_arg)
		    || is_signed_integer_type_argument (type_arg)
		    || is_unsigned_integer_type_argument (type_arg)) {
			// no error
		} else if (type_arg is DelegateType) {
			var delegate_type = (DelegateType) type_arg;
			if (delegate_type.delegate_symbol.has_target) {
				Report.error (type_arg.source_reference, "Delegates with target are not supported as generic type arguments");
			}
		} else if (type_arg is ArrayType) {
			Report.error (type_arg.source_reference, "Arrays are not supported as generic type arguments");
		} else {
			Report.error (type_arg.source_reference, "`%s' is not a supported generic type argument, use `?' to box value types".printf (type_arg.to_string ()));
		}
	}
}
