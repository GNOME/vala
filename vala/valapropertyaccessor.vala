/* valapropertyaccessor.vala
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
 * Represents a get or set accessor of a property in the source code.
 */
public class Vala.PropertyAccessor : Subroutine {
	/**
	 * The corresponding property.
	 */
	public Property prop {
		get { return parent_symbol as Property; }
	}

	/**
	 * The property type.
	 */
	public DataType? value_type {
		get { return _value_type; }
		private set {
			_value_type = value;
			if (value != null) {
				_value_type.parent_node = this;
			}
		}
	}

	/**
	 * Specifies whether this accessor may be used to get the property.
	 */
	public bool readable { get; private set; }

	/**
	 * Specifies whether this accessor may be used to set the property.
	 */
	public bool writable { get; private set; }

	/**
	 * Specifies whether this accessor may be used to construct the
	 * property.
	 */
	public bool construction { get; private set; }

	/**
	 * True if the body was automatically generated
	 */
	public bool automatic_body { get; private set; }

	public override bool has_result {
		get { return readable; }
	}

	/**
	 * Represents the generated value parameter in a set accessor.
	 */
	public Parameter value_parameter { get; private set; }

	private DataType _value_type;

	/**
	 * Creates a new property accessor.
	 *
	 * @param readable           true if get accessor, false otherwise
	 * @param writable           true if set accessor, false otherwise
	 * @param construction       true if construct accessor, false otherwise
	 * @param body               accessor body
	 * @param source_reference   reference to source code
	 * @return                   newly created property accessor
	 */
	public PropertyAccessor (bool readable, bool writable, bool construction, DataType? value_type, Block? body, SourceReference? source_reference = null, Comment? comment = null) {
		base (null, source_reference, comment);
		this.readable = readable;
		this.writable = writable;
		this.construction = construction;
		this.value_type = value_type;
		this.body = body;
		this.access = SymbolAccessibility.PUBLIC;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_property_accessor (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		value_type.accept (visitor);

		if (result_var != null) {
			result_var.accept (visitor);
		}

		if (body != null) {
			body.accept (visitor);
		}
	}

	/**
	 * Get the method representing this property accessor
	 * @return   null if the accessor is neither readable nor writable
	 */
	public Method? get_method () {
		Method? m = null;
		if (readable) {
			m = new Method ("get_%s".printf (prop.name), value_type, source_reference, comment);

			// Inherit important attributes
			m.copy_attribute_bool (prop, "CCode", "array_length");
			m.copy_attribute_string (prop, "CCode", "array_length_type");
			m.copy_attribute_bool (prop, "CCode", "array_null_terminated");
			m.copy_attribute_bool (prop, "CCode", "delegate_target");
		} else if (writable || construction) {
			m = new Method ("set_%s".printf (prop.name), new VoidType(), source_reference, comment);
			m.add_parameter (value_parameter.copy ());
		}

		if (m != null) {
			m.owner = prop.owner;
			m.access = access;
			m.binding = prop.binding;
			m.is_abstract = prop.is_abstract;
			m.is_virtual = prop.is_virtual;
			m.this_parameter = prop.this_parameter;

			// Inherit important attributes
			m.copy_attribute_bool (prop, "GIR", "visible");
		}

		return m;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!value_type.check (context)) {
			error = true;
			return false;
		}

		var old_symbol = context.analyzer.current_symbol;

		context.analyzer.current_symbol = this;

		if (writable || construction) {
			value_parameter = new Parameter ("value", value_type, source_reference);
			// Inherit important attributes
			value_parameter.copy_attribute_bool (prop, "CCode", "array_length");
			value_parameter.copy_attribute_string (prop, "CCode", "array_length_type");
			value_parameter.copy_attribute_bool (prop, "CCode", "array_null_terminated");
			value_parameter.copy_attribute_bool (prop, "CCode", "delegate_target");
		}

		if (context.profile == Profile.GOBJECT
		    && readable && ((TypeSymbol) prop.parent_symbol).is_subtype_of (context.analyzer.object_type)) {
			//FIXME Code duplication with CCodeMemberAccessModule.visit_member_access()
			if (prop.has_attribute ("NoAccessorMethod")) {
				if (value_type.is_real_struct_type ()) {
					if (source_reference == null || source_reference.file == null) {
						// Hopefully good as is
					} else if (!value_type.value_owned && source_reference.file.file_type == SourceFileType.SOURCE) {
						error = true;
						Report.error (source_reference, "unowned return value for getter of property `%s' not supported without accessor", prop.get_full_name ());
					}
				} else if (value_type.value_owned && (source_reference == null || source_reference.file == null)) {
					if (value_type is DelegateType || value_type is PointerType || (value_type is ValueType && !value_type.nullable)) {
						value_type.value_owned = false;
					}
				}
			}
		}

		if (prop.source_type == SourceFileType.SOURCE) {
			if (body == null && !prop.interface_only && !prop.is_abstract) {
				/* no accessor body specified, insert default body */

				automatic_body = true;
				body = new Block (source_reference);
				var ma = new MemberAccess.simple ("_%s".printf (prop.name), source_reference);
				if (readable) {
					body.add_statement (new ReturnStatement (ma, source_reference));
				} else {
					Expression value = new MemberAccess.simple ("value", source_reference);
					if (value_type.value_owned) {
						value = new ReferenceTransferExpression (value, source_reference);
					}
					var assignment = new Assignment (ma, value, AssignmentOperator.SIMPLE, source_reference);
					body.add_statement (new ExpressionStatement (assignment));
				}
			}
		}

		if ((prop.is_abstract || prop.is_virtual || prop.overrides) && access == SymbolAccessibility.PRIVATE) {
			error = true;
			Report.error (source_reference, "Property `%s' with private accessor cannot be marked as abstract, virtual or override", prop.get_full_name ());
			return false;
		}

		if (value_type.value_owned && value_type.is_non_null_simple_type ()) {
			error = true;
			Report.error (source_reference, "`owned' accessor not allowed for specified property type");
			return false;
		}

		if (context.profile == Profile.POSIX && construction) {
			error = true;
			Report.error (source_reference, "`construct' is not supported in POSIX profile");
			return false;
		} else if (construction && !((TypeSymbol) prop.parent_symbol).is_subtype_of (context.analyzer.object_type)) {
			error = true;
			Report.error (source_reference, "construct properties require `GLib.Object'");
			return false;
		} else if (construction && !context.analyzer.is_gobject_property (prop)) {
			//TODO Report an error for external property too
			if (external_package) {
				Report.warning (source_reference, "construct properties not supported for specified property type");
			} else {
				error = true;
				Report.error (source_reference, "construct properties not supported for specified property type");
				return false;
			}
		}

		if (body != null && prop.is_abstract) {
			error = true;
			Report.error (source_reference, "Accessor of abstract property `%s' cannot have body", prop.get_full_name ());
			return false;
		}

		if (body != null) {
			if (writable || construction) {
				body.scope.add (value_parameter.name, value_parameter);
			}

			body.check (context);
		}

		if (body != null && !body.error) {
			var error_types = new ArrayList<DataType> ();
			body.get_error_types (error_types);
			foreach (DataType body_error_type in error_types) {
				if (!((ErrorType) body_error_type).dynamic_error) {
					Report.warning (body_error_type.source_reference, "unhandled error `%s'", body_error_type.to_string ());
				}
			}
		}

		context.analyzer.current_symbol = old_symbol;

		return !error;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (value_type == old_type) {
			value_type = new_type;
		}
	}
}
