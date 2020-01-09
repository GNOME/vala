/* valamemberaccess.vala
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
 * Represents an access to a type member in the source code.
 */
public class Vala.MemberAccess : Expression {
	/**
	 * The parent of the member.
	 */
	public Expression? inner {
		get {
			return _inner;
		}
		set {
			_inner = value;
			if (_inner != null) {
				_inner.parent_node = this;
			}
		}
	}

	/**
	 * The name of the member.
	 */
	public string member_name { get; set; }

	/**
	 * Pointer member access.
	 */
	public bool pointer_member_access { get; set; }

	/**
	 * Represents access to an instance member without an actual instance,
	 * e.g. `MyClass.an_instance_method`.
	 */
	public bool prototype_access { get; set; }

	/**
	 * Specifies whether the member is used for object creation.
	 */
	public bool creation_member { get; set; }

	/**
	 * Qualified access to global symbol.
	 */
	public bool qualified { get; set; }

	private Expression? _inner;
	private List<DataType> type_argument_list = new ArrayList<DataType> ();

	/**
	 * Creates a new member access expression.
	 *
	 * @param inner            parent of the member
	 * @param member_name      member name
	 * @param source_reference reference to source code
	 * @return                 newly created member access expression
	 */
	public MemberAccess (Expression? inner, string member_name, SourceReference? source_reference = null) {
		this.inner = inner;
		this.member_name = member_name;
		this.source_reference = source_reference;
	}

	public MemberAccess.simple (string member_name, SourceReference? source_reference = null) {
		this.inner = null;
		this.member_name = member_name;
		this.source_reference = source_reference;
	}

	public MemberAccess.pointer (Expression inner, string member_name, SourceReference? source_reference = null) {
		this.inner = inner;
		this.member_name = member_name;
		this.source_reference = source_reference;
		pointer_member_access = true;
	}

	/**
	 * Appends the specified type as generic type argument.
	 *
	 * @param arg a type reference
	 */
	public void add_type_argument (DataType arg) {
		type_argument_list.add (arg);
		arg.parent_node = this;
	}

	/**
	 * Returns the list of generic type arguments.
	 *
	 * @return type argument list
	 */
	public unowned List<DataType> get_type_arguments () {
		return type_argument_list;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_member_access (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (inner != null) {
			inner.accept (visitor);
		}

		foreach (DataType type_arg in type_argument_list) {
			type_arg.accept (visitor);
		}
	}

	public override string to_string () {
		if (symbol_reference == null || symbol_reference.is_instance_member ()) {
			if (inner == null) {
				return member_name;
			} else {
				return "%s%s%s".printf (inner.to_string (), pointer_member_access ? "->" : ".", member_name);
			}
		} else {
			// ensure to always use fully-qualified name
			// to refer to static members
			return symbol_reference.get_full_name ();
		}
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (inner == old_node) {
			inner = new_node;
		}
	}

	public override bool is_pure () {
		// accessing property could have side-effects
		return (inner == null || inner.is_pure ()) && !(symbol_reference is Property);
	}

	public override bool is_accessible (Symbol sym) {
		return (inner == null || inner.is_accessible (sym)) && symbol_reference.is_accessible (sym);
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		for (int i = 0; i < type_argument_list.size; i++) {
			if (type_argument_list[i] == old_type) {
				type_argument_list[i] = new_type;
				return;
			}
		}
	}

	public override bool is_constant () {
		unowned Method? method = symbol_reference as Method;
		if (symbol_reference is Constant) {
			return true;
		} else if (symbol_reference is ArrayLengthField && inner != null && inner.symbol_reference is Constant) {
			// length of constant array
			return true;
		} else if (method != null &&
		           (method.binding == MemberBinding.STATIC || prototype_access)) {
			return true;
		} else {
			return false;
		}
	}

	public override bool is_non_null () {
		unowned Constant? c = symbol_reference as Constant;
		if (c != null) {
			return (c is EnumValue || !c.type_reference.nullable);
		} else {
			return false;
		}
	}

	public override void get_error_types (Collection<DataType> collection, SourceReference? source_reference = null) {
		if (inner != null) {
			inner.get_error_types (collection, source_reference);
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (inner != null) {
			inner.check (context);
		}

		foreach (DataType type_arg in type_argument_list) {
			type_arg.check (context);
		}

		unowned Symbol? base_symbol = null;
		unowned Parameter? this_parameter = null;
		bool may_access_instance_members = false;
		bool may_access_klass_members = false;

		symbol_reference = null;

		if (qualified) {
			base_symbol = context.root;
			symbol_reference = base_symbol.scope.lookup (member_name);
		} else if (inner == null) {
			if (member_name == "this") {
				if (!context.analyzer.is_in_instance_method ()) {
					error = true;
					Report.error (source_reference, "This access invalid outside of instance methods");
					return false;
				}
			}

			base_symbol = context.analyzer.current_symbol;

			// track whether method has been found to make sure that access
			// to instance member is denied from within static lambda expressions
			bool method_found = false;

			unowned Symbol? sym = context.analyzer.current_symbol;
			while (sym != null && symbol_reference == null) {
				if (!method_found) {
					if (sym is CreationMethod) {
						unowned CreationMethod cm = (CreationMethod) sym;
						this_parameter = cm.this_parameter;
						may_access_instance_members = true;
						may_access_klass_members = true;
						method_found = true;
					} else if (sym is Property) {
						unowned Property prop = (Property) sym;
						this_parameter = prop.this_parameter;
						may_access_instance_members = (prop.binding == MemberBinding.INSTANCE);
						may_access_klass_members = (prop.binding != MemberBinding.STATIC);
						method_found = true;
					} else if (sym is Constructor) {
						unowned Constructor c = (Constructor) sym;
						this_parameter = c.this_parameter;
						may_access_instance_members = (c.binding == MemberBinding.INSTANCE);
						may_access_klass_members = true;
						method_found = true;
					} else if (sym is Destructor) {
						unowned Destructor d = (Destructor) sym;
						this_parameter = d.this_parameter;
						may_access_instance_members = (d.binding == MemberBinding.INSTANCE);
						may_access_klass_members = true;
						method_found = true;
					} else if (sym is Method) {
						unowned Method m = (Method) sym;
						this_parameter = m.this_parameter;
						may_access_instance_members = (m.binding == MemberBinding.INSTANCE);
						may_access_klass_members = (m.binding != MemberBinding.STATIC);
						method_found = true;
					}
				}

				symbol_reference = SemanticAnalyzer.symbol_lookup_inherited (sym, member_name);

				if (symbol_reference == null && sym is TypeSymbol && may_access_instance_members) {
					// used for generated to_string methods in enums
					symbol_reference = this_parameter.variable_type.get_member (member_name);

					if (symbol_reference != null && is_instance_symbol (symbol_reference)) {
						// implicit this
						inner = new MemberAccess (null, "this", source_reference);
						inner.value_type = this_parameter.variable_type.copy ();
						inner.value_type.value_owned = false;
						inner.symbol_reference = this_parameter;

						symbol_reference = inner.value_type.get_member (member_name);
					}
				}

				if (symbol_reference == null) {
					if (sym is TypeSymbol) {
						// do not allow instance access to outer classes
						this_parameter = null;
						may_access_instance_members = false;
						may_access_klass_members = false;
					}
				}

				sym = sym.parent_symbol;
			}

			if (symbol_reference == null && source_reference != null) {
				foreach (UsingDirective ns in source_reference.using_directives) {
					if (!(ns.namespace_symbol is Vala.Namespace)) {
						continue;
					}
					var local_sym = ns.namespace_symbol.scope.lookup (member_name);
					if (local_sym != null) {
						if (symbol_reference != null && symbol_reference != local_sym) {
							error = true;
							Report.error (source_reference, "`%s' is an ambiguous reference between `%s' and `%s'".printf (member_name, symbol_reference.get_full_name (), local_sym.get_full_name ()));
							return false;
						}
						symbol_reference = local_sym;
					}
				}
			}
		} else {
			if (inner.error) {
				/* if there was an error in the inner expression, skip this check */
				error = true;
				return false;
			}

			if (inner.value_type is PointerType) {
				unowned PointerType? pointer_type = inner.value_type as PointerType;
				if (pointer_type != null && pointer_type.base_type is ValueType) {
					// transform foo->bar to (*foo).bar
					inner = new PointerIndirection (inner, source_reference);
					inner.check (context);
					pointer_member_access = false;
				}
			}

			if (inner is MemberAccess) {
				unowned MemberAccess ma = (MemberAccess) inner;
				if (ma.prototype_access) {
					error = true;
					Report.error (source_reference, "Access to instance member `%s' denied".printf (inner.symbol_reference.get_full_name ()));
					return false;
				}
			}

			if (inner is CastExpression && ((CastExpression) inner).is_silent_cast) {
				Report.warning (source_reference, "Access to possible `null'. Perform a check or use an unsafe cast.");
			}

			if (inner is MemberAccess || inner is BaseAccess) {
				base_symbol = inner.symbol_reference;

				if (symbol_reference == null && (base_symbol is Namespace || base_symbol is TypeSymbol)) {
					symbol_reference = base_symbol.scope.lookup (member_name);
					if (inner is BaseAccess) {
						// inner expression is base access
						// access to instance members of the base type possible
						may_access_instance_members = true;
						may_access_klass_members = true;
					}
				}
			}

			if (inner is MemberAccess && inner.symbol_reference is TypeParameter) {
				inner.value_type = new GenericType ((TypeParameter) inner.symbol_reference);
				inner.value_type.source_reference = source_reference;
			}

			if (symbol_reference == null && inner.value_type != null) {
				if (pointer_member_access) {
					symbol_reference = inner.value_type.get_pointer_member (member_name);
				} else {
					if (inner.value_type.type_symbol != null) {
						base_symbol = inner.value_type.type_symbol;
					}
					symbol_reference = inner.value_type.get_member (member_name);
				}
				if (symbol_reference != null) {
					// inner expression is variable, field, or parameter
					// access to instance members of the corresponding type possible
					may_access_instance_members = true;
					may_access_klass_members = true;
				}
			}

			if (symbol_reference == null && inner.value_type != null && inner.value_type.is_dynamic) {
				// allow late bound members for dynamic types
				var dynamic_object_type = (ObjectType) inner.value_type;
				if (parent_node is MethodCall) {
					unowned MethodCall invoc = (MethodCall) parent_node;
					if (invoc.call == this) {
						// dynamic method
						DataType ret_type;
						if (invoc.target_type != null) {
							ret_type = invoc.target_type.copy ();
							ret_type.value_owned = true;
						} else if (invoc.parent_node is ExpressionStatement) {
							ret_type = new VoidType ();
						} else {
							// expect dynamic object of the same type
							ret_type = inner.value_type.copy ();
						}
						var m = new DynamicMethod (inner.value_type, member_name, ret_type, source_reference);
						m.invocation = invoc;
						var err = new ErrorType (null, null);
						err.dynamic_error = true;
						m.add_error_type (err);
						m.access = SymbolAccessibility.PUBLIC;
						m.add_parameter (new Parameter.with_ellipsis ());
						m.this_parameter = new Parameter ("this", dynamic_object_type.copy ());
						dynamic_object_type.type_symbol.scope.add (null, m);
						symbol_reference = m;
					}
				} else if (parent_node is Assignment) {
					unowned Assignment a = (Assignment) parent_node;
					if (a.left == this) {
						// dynamic property assignment
						var prop = new DynamicProperty (inner.value_type, member_name, source_reference);
						prop.access = SymbolAccessibility.PUBLIC;
						prop.set_accessor = new PropertyAccessor (false, true, false, null, null, prop.source_reference);
						prop.owner = inner.value_type.type_symbol.scope;
						dynamic_object_type.type_symbol.scope.add (null, prop);
						symbol_reference = prop;
					}
				} else if (parent_node is MemberAccess && inner is MemberAccess && parent_node.parent_node is MethodCall) {
					unowned MemberAccess ma = (MemberAccess) parent_node;
					if (ma.member_name == "connect" || ma.member_name == "connect_after") {
						// dynamic signal
						var s = new DynamicSignal (inner.value_type, member_name, new VoidType (), source_reference);
						var mcall = (MethodCall) parent_node.parent_node;
						// the first argument is the handler
						if (mcall.get_argument_list().size > 0) {
							s.handler = mcall.get_argument_list()[0];
						}
						s.access = SymbolAccessibility.PUBLIC;
						dynamic_object_type.type_symbol.scope.add (null, s);
						symbol_reference = s;
					}
				}
				if (symbol_reference == null) {
					// dynamic property read access
					var prop = new DynamicProperty (inner.value_type, member_name, source_reference);
					if (target_type != null) {
						prop.property_type = target_type;
					} else {
						// expect dynamic object of the same type
						prop.property_type = inner.value_type.copy ();
					}
					prop.access = SymbolAccessibility.PUBLIC;
					prop.get_accessor = new PropertyAccessor (true, false, false, prop.property_type.copy (), null, prop.source_reference);
					prop.owner = inner.value_type.type_symbol.scope;
					dynamic_object_type.type_symbol.scope.add (null, prop);
					symbol_reference = prop;
				}
				if (symbol_reference != null) {
					may_access_instance_members = true;
					may_access_klass_members = true;
				}
			}

			if (symbol_reference is ArrayResizeMethod && inner.value_type is ArrayType) {
				unowned ArrayType? value_array_type = inner.value_type as ArrayType;
				if (value_array_type != null && value_array_type.inline_allocated) {
					Report.error (source_reference, "`resize' is not supported for arrays with fixed length");
					error = true;
				}
			}
		}

		// enum-type inference
		if (inner == null && symbol_reference == null && target_type != null && target_type.type_symbol is Enum) {
			unowned Enum enum_type = (Enum) target_type.type_symbol;
			foreach (var val in enum_type.get_values ()) {
				if (member_name == val.name) {
					symbol_reference = val;
					break;
				}
			}
		}

		if (symbol_reference == null) {
			error = true;

			string base_type_name = "(null)";
			unowned Symbol? base_type = null;
			if (inner != null && inner.value_type != null) {
				base_type_name = inner.value_type.to_string ();
				base_type = inner.value_type.type_symbol;
			} else if (base_symbol != null) {
				base_type_name = base_symbol.get_full_name ();
				base_type = base_symbol;
			}

			string? base_type_package = "";
			if (base_type != null && base_type.external_package) {
				base_type_package = base_symbol.source_reference.file.package_name;
				if (base_type_package != null) {
					base_type_package = " (%s)".printf (base_type_package);
				}
			}

			Report.error (source_reference, "The name `%s' does not exist in the context of `%s'%s".printf (member_name, base_type_name, base_type_package));
			return false;
		}

		unowned Symbol? member = symbol_reference;
		var access = SymbolAccessibility.PUBLIC;
		bool instance = false;
		bool klass = false;
		bool generics = false;

		if (!member.check (context)) {
			return false;
		}

		if (member is LocalVariable) {
			unowned LocalVariable local = (LocalVariable) member;
			unowned Block? block = local.parent_symbol as Block;
			if (block != null && SemanticAnalyzer.find_parent_method_or_property_accessor (block) != context.analyzer.current_method_or_property_accessor) {
				// mark all methods between current method and the captured
				// block as closures (to support nested closures)
				unowned Symbol? sym = context.analyzer.current_method_or_property_accessor;
				while (sym != block) {
					unowned Method? method = sym as Method;
					if (method != null) {
						method.closure = true;
						// consider captured variables as used
						// as we require captured variables to be initialized
						method.add_captured_variable (local);
					}
					sym = sym.parent_symbol;
				}

				local.captured = true;
				block.captured = true;
			}
		} else if (member is Parameter) {
			unowned Parameter param = (Parameter) member;
			unowned Method? m = param.parent_symbol as Method;
			if (m != null && m != context.analyzer.current_method_or_property_accessor && param != m.this_parameter) {
				// mark all methods between current method and the captured
				// parameter as closures (to support nested closures)
				unowned Symbol? sym = context.analyzer.current_method_or_property_accessor;
				while (sym != m) {
					unowned Method? method = sym as Method;
					if (method != null) {
						method.closure = true;
					}
					sym = sym.parent_symbol;
				}

				param.captured = true;
				m.body.captured = true;

				if (param.direction != ParameterDirection.IN) {
					error = true;
					Report.error (source_reference, "Cannot capture reference or output parameter `%s'".printf (param.get_full_name ()));
				}
			} else {
				unowned PropertyAccessor? acc = param.parent_symbol.parent_symbol as PropertyAccessor;
				if (acc != null && acc != context.analyzer.current_method_or_property_accessor && param != acc.prop.this_parameter) {
					// mark all methods between current method and the captured
					// parameter as closures (to support nested closures)
					unowned Symbol? sym = context.analyzer.current_method_or_property_accessor;
					while (sym != m) {
						unowned Method? method = sym as Method;
						if (method != null) {
							method.closure = true;
						}
						sym = sym.parent_symbol;
					}

					param.captured = true;
					acc.body.captured = true;
				}
			}
		} else if (member is Field) {
			unowned Field f = (Field) member;
			access = f.access;
			instance = (f.binding == MemberBinding.INSTANCE);
			klass = (f.binding == MemberBinding.CLASS);

			// do not allow access to fields of generic types
			// if instance type does not specify type arguments
			if (f.variable_type is GenericType) {
				generics = true;
			}
		} else if (member is Constant) {
			unowned Constant c = (Constant) member;
			access = c.access;

			unowned Block? block = c.parent_symbol as Block;
			if (block != null && SemanticAnalyzer.find_parent_method_or_property_accessor (block) != context.analyzer.current_method_or_property_accessor) {
				error = true;
				Report.error (source_reference, "internal error: accessing local constants of outer methods is not supported yet");
				return false;
			}
		} else if (member is Method) {
			unowned Method m = (Method) member;
			if (m.is_async_callback) {
				// ensure to use right callback method for virtual/abstract async methods
				// and also for lambda expressions within async methods
				unowned Method? async_method = context.analyzer.current_async_method;

				bool is_valid_access = false;
				if (async_method != null) {
					if (m == async_method.get_callback_method ()) {
						is_valid_access = true;
					} else if (async_method.base_method != null && m == async_method.base_method.get_callback_method ()) {
						is_valid_access = true;
					} else if (async_method.base_interface_method != null && m == async_method.base_interface_method.get_callback_method ()) {
						is_valid_access = true;
					}
				}
				if (!is_valid_access) {
					error = true;
					Report.error (source_reference, "Access to async callback `%s' not allowed in this context".printf (m.get_full_name ()));
					return false;
				}

				if (async_method != context.analyzer.current_method) {
					unowned Symbol? sym = context.analyzer.current_method;
					while (sym != async_method) {
						unowned Method? method = sym as Method;
						if (method != null) {
							method.closure = true;
						}
						sym = sym.parent_symbol;
					}
					async_method.body.captured = true;
				}

				m = async_method.get_callback_method ();
				symbol_reference = m;
				member = symbol_reference;
			} else if (m.base_method != null) {
				// refer to base method to inherit default arguments
				m = m.base_method;

				if (m.signal_reference != null) {
					// method is class/default handler for a signal
					// let signal deal with member access
					symbol_reference = m.signal_reference;
				} else {
					symbol_reference = m;
				}

				member = symbol_reference;
			} else if (m.base_interface_method != null) {
				// refer to base method to inherit default arguments
				m = m.base_interface_method;

				if (m.signal_reference != null) {
					// method is class/default handler for a signal
					// let signal deal with member access
					symbol_reference = m.signal_reference;
				} else {
					symbol_reference = m;
				}

				member = symbol_reference;
			}
			access = m.access;
			if (!(m is CreationMethod)) {
				instance = (m.binding == MemberBinding.INSTANCE);
			}
			klass = (m.binding == MemberBinding.CLASS);

			// do not allow access to methods using generic type parameters
			// if instance type does not specify type arguments
			foreach (var param in m.get_parameters ()) {
				unowned GenericType? generic_type = param.variable_type as GenericType;
				if (generic_type != null && generic_type.type_parameter.parent_symbol is TypeSymbol) {
					generics = true;
					break;
				}
			}
			unowned GenericType? generic_type = m.return_type as GenericType;
			if (generic_type != null && generic_type.type_parameter.parent_symbol is TypeSymbol) {
				generics = true;
			}
		} else if (member is Property) {
			unowned Property prop = (Property) member;
			if (!prop.check (context)) {
				error = true;
				return false;
			}
			if (prop.base_property != null) {
				// refer to base property
				prop = prop.base_property;
				symbol_reference = prop;
				member = symbol_reference;
			} else if (prop.base_interface_property != null) {
				// refer to base property
				prop = prop.base_interface_property;
				symbol_reference = prop;
				member = symbol_reference;
			}
			access = prop.access;
			if (lvalue) {
				if (prop.set_accessor == null) {
					error = true;
					Report.error (source_reference, "Property `%s' is read-only".printf (prop.get_full_name ()));
					return false;
				}
				if (prop.access == SymbolAccessibility.PUBLIC) {
					access = prop.set_accessor.access;
				} else if (prop.access == SymbolAccessibility.PROTECTED
				           && prop.set_accessor.access != SymbolAccessibility.PUBLIC) {
					access = prop.set_accessor.access;
				}
			} else {
				if (prop.get_accessor == null) {
					error = true;
					Report.error (source_reference, "Property `%s' is write-only".printf (prop.get_full_name ()));
					return false;
				}
				if (prop.access == SymbolAccessibility.PUBLIC) {
					access = prop.get_accessor.access;
				} else if (prop.access == SymbolAccessibility.PROTECTED
				           && prop.get_accessor.access != SymbolAccessibility.PUBLIC) {
					access = prop.get_accessor.access;
				}
			}
			instance = (prop.binding == MemberBinding.INSTANCE);

			// do not allow access to properties of generic types
			// if instance type does not specify type arguments
			if (prop.property_type is GenericType) {
				generics = true;
			}
		} else if (member is Signal) {
			instance = true;
			access = member.access;
		} else if (!creation_member && member is ErrorCode) {
			symbol_reference = ((ErrorCode) member).code;
			member = symbol_reference;
		}

		// recursive usage of itself doesn't count as used
		unowned CodeNode? parent = this;
		while (parent != member) {
			parent = parent.parent_node;
			if (parent == null || parent == member) {
				break;
			}
		}
		if (parent != member) {
			member.used = true;
		}
		member.version.check (source_reference);

		if (access == SymbolAccessibility.PROTECTED && member.parent_symbol is TypeSymbol) {
			unowned TypeSymbol target_type = (TypeSymbol) member.parent_symbol;

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
				Report.error (source_reference, "Access to protected member `%s' denied".printf (member.get_full_name ()));
				return false;
			}
		} else if (access == SymbolAccessibility.PRIVATE) {
			unowned Symbol? target_type = member.parent_symbol;

			bool in_target_type = false;
			for (Symbol this_symbol = context.analyzer.current_symbol; this_symbol != null; this_symbol = this_symbol.parent_symbol) {
				if (target_type == this_symbol) {
					in_target_type = true;
					break;
				}
			}

			if (!in_target_type) {
				error = true;
				Report.error (source_reference, "Access to private member `%s' denied".printf (member.get_full_name ()));
				return false;
			}
		}

		if (generics && inner != null) {
			unowned DataType instance_type = inner.value_type;
			unowned PointerType? pointer_type = inner.value_type as PointerType;
			if (pointer_type != null) {
				instance_type = pointer_type.base_type;
			}

			// instance type might be a subtype of the parent symbol of the member
			// that subtype might not be generic, so do not report an error in that case
			unowned ObjectType? object_type = instance_type as ObjectType;
			if (object_type != null && object_type.object_type_symbol.has_type_parameters ()
			    && !instance_type.has_type_arguments ()) {
				error = true;
				Report.error (inner.source_reference, "missing generic type arguments");
				return false;
			}
		}

		if ((instance && !may_access_instance_members) ||
		    (klass && !may_access_klass_members)) {
			prototype_access = true;

			if (symbol_reference is Method) {
				// also set static type for prototype access
				// required when using instance methods as delegates in constants
				// TODO replace by MethodPrototype
				value_type = context.analyzer.get_value_type_for_symbol (symbol_reference, lvalue);
			} else if (symbol_reference is Field) {
				value_type = new FieldPrototype ((Field) symbol_reference);
			} else if (symbol_reference is Property) {
				value_type = new PropertyPrototype ((Property) symbol_reference);
			} else {
				value_type = new InvalidType ();
			}

			if (target_type != null) {
				value_type.value_owned = target_type.value_owned;
			}
		} else {
			// implicit this access
			if (instance && inner == null) {
				inner = new MemberAccess (null, "this", source_reference);
				inner.value_type = this_parameter.variable_type.copy ();
				inner.value_type.value_owned = false;
				inner.symbol_reference = this_parameter;
			} else {
				check_lvalue_access ();
			}

			if (!instance && !klass && !(symbol_reference is CreationMethod) && may_access_instance_members && inner != null) {
				if (inner.symbol_reference is Method) {
					// do not warn when calling .begin or .end on static async method
				} else {
					Report.warning (source_reference, "Access to static member `%s' with an instance reference".printf (symbol_reference.get_full_name ()));
				}
			}

			if (context.experimental_non_null && instance && inner.value_type.nullable &&
			    !(inner.value_type is PointerType) && !(inner.value_type is GenericType) &&
				!(inner.value_type is ArrayType)) {
				Report.error (source_reference, "Access to instance member `%s' from nullable reference denied".printf (symbol_reference.get_full_name ()));
			}

			unowned Method? m = symbol_reference as Method;
			unowned MemberAccess? inner_ma = inner as MemberAccess;
			if (m != null && m.binding == MemberBinding.STATIC && m.parent_symbol is ObjectTypeSymbol &&
			    inner != null && inner.value_type == null && inner_ma.type_argument_list.size > 0) {
				// support static methods in generic classes
				inner.value_type = new ObjectType ((ObjectTypeSymbol) m.parent_symbol);

				foreach (var type_argument in inner_ma.type_argument_list) {
					inner.value_type.add_type_argument (type_argument);
				}
			}

			formal_value_type = context.analyzer.get_value_type_for_symbol (symbol_reference, lvalue);
			if (inner != null && formal_value_type != null) {
				value_type = formal_value_type.get_actual_type (inner.value_type, null, this);
			} else {
				value_type = formal_value_type;
			}

			if (symbol_reference is Method) {
				unowned Method method = (Method) symbol_reference;
				if (target_type != null) {
					value_type.value_owned = target_type.value_owned;
				}
				if (instance && method.parent_symbol is TypeSymbol) {
					inner.target_type = SemanticAnalyzer.get_data_type_for_symbol (method.parent_symbol);
					inner.target_type.value_owned = method.this_parameter.variable_type.value_owned;
				}
			} else if (symbol_reference is Property
			    && instance && symbol_reference.parent_symbol != null) {
				inner.target_type = SemanticAnalyzer.get_data_type_for_symbol (symbol_reference.parent_symbol);
			} else if ((symbol_reference is Field || symbol_reference is Signal)
			    && instance && symbol_reference.parent_symbol != null) {
				var parent_type = SemanticAnalyzer.get_data_type_for_symbol (symbol_reference.parent_symbol);
				inner.target_type = parent_type.get_actual_type (inner.value_type, null, this);
			}
		}

		if (value_type != null) {
			value_type.check (context);
		}

		return !error;
	}

	static bool is_instance_symbol (Symbol symbol) {
		if (symbol is Field && ((Field) symbol).binding == MemberBinding.INSTANCE) {
			return true;
		} else if (symbol is Method && !(symbol is CreationMethod) && ((Method) symbol).binding == MemberBinding.INSTANCE) {
			return true;
		} else if (symbol is Property && ((Property) symbol).binding == MemberBinding.INSTANCE) {
			return true;
		} else if (symbol is Signal) {
			return true;
		} else {
			return false;
		}
	}

	public void check_lvalue_access () {
		if (inner == null) {
			return;
		}
		var instance = symbol_reference is Field && ((Field) symbol_reference).binding == MemberBinding.INSTANCE;
		if (!instance) {
			instance = symbol_reference is Method && ((Method) symbol_reference).binding == MemberBinding.INSTANCE;
		}
		if (!instance) {
			instance = symbol_reference is Property && ((Property) symbol_reference).binding == MemberBinding.INSTANCE;
		}

		var this_access = inner.symbol_reference is Parameter && inner.symbol_reference.name == "this";
		var struct_or_array = (inner.value_type is StructValueType && !inner.value_type.nullable) || inner.value_type is ArrayType;

		unowned MemberAccess? ma = inner as MemberAccess;
		if (ma == null && struct_or_array && inner is PointerIndirection) {
			// (*struct)->method()
			ma = ((PointerIndirection) inner).inner as MemberAccess;
		}

		if (instance && struct_or_array && (symbol_reference is Method || lvalue) && ((ma != null && ma.symbol_reference is Variable) || inner is ElementAccess) && !this_access) {
			inner.lvalue = true;
			if (ma != null) {
				ma.lvalue = true;
				ma.check_lvalue_access ();
			}
		}

		if (symbol_reference is Method && ((Method) symbol_reference).get_attribute ("DestroysInstance") != null) {
			unowned Class? cl = ((Method) symbol_reference).parent_symbol as Class;
			if (cl != null && cl.is_compact && ma != null) {
				ma.lvalue = true;
				ma.check_lvalue_access ();
			}
		}
	}

	public override void emit (CodeGenerator codegen) {
		if (inner != null) {
			inner.emit (codegen);
		}

		codegen.visit_member_access (this);

		codegen.visit_expression (this);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		if (inner != null) {
			inner.get_defined_variables (collection);
		}
	}

	public override void get_used_variables (Collection<Variable> collection) {
		if (inner != null) {
			inner.get_used_variables (collection);
		}
		unowned LocalVariable? local = symbol_reference as LocalVariable;
		unowned Parameter? param = symbol_reference as Parameter;
		if (local != null) {
			collection.add (local);
		} else if (param != null && param.direction == ParameterDirection.OUT) {
			collection.add (param);
		}
	}
}
