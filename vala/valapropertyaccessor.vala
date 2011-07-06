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
		set {
			_value_type = value;
			if (value != null) {
				_value_type.parent_node = this;
			}
		}
	}

	/**
	 * Specifies whether this accessor may be used to get the property.
	 */
	public bool readable { get; set; }
	
	/**
	 * Specifies whether this accessor may be used to set the property.
	 */
	public bool writable { get; set; }
	
	/**
	 * Specifies whether this accessor may be used to construct the
	 * property.
	 */
	public bool construction { get; set; }

	/**
	 * True if the body was automatically generated
	 */
	public bool automatic_body { get; set; }

	public override bool has_result {
		get { return readable; }
	}

	/**
	 * Represents the generated value parameter in a set accessor.
	 */
	public Parameter value_parameter { get; set; }

	private DataType _value_type;
	
	/**
	 * Creates a new property accessor.
	 *
	 * @param readable     true if get accessor, false otherwise
	 * @param writable     true if set accessor, false otherwise
	 * @param construction true if construct accessor, false otherwise
	 * @param body         accessor body
	 * @param source       reference to source code
	 * @return             newly created property accessor
	 */
	public PropertyAccessor (bool readable, bool writable, bool construction, DataType? value_type, Block? body, SourceReference? source_reference, Comment? comment = null) {
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

		if (prop.source_type == SourceFileType.SOURCE) {
			if (body == null && !prop.interface_only && !prop.is_abstract) {
				/* no accessor body specified, insert default body */

				if (prop.parent_symbol is Interface) {
					error = true;
					Report.error (source_reference, "Automatic properties can't be used in interfaces");
					return false;
				}
				automatic_body = true;
				body = new Block (source_reference);
				var ma = new MemberAccess.simple ("_%s".printf (prop.name), source_reference);
				if (readable) {
					if (context.profile == Profile.DOVA) {
						body.add_statement (new ExpressionStatement (new Assignment (new MemberAccess.simple ("result", source_reference), ma, AssignmentOperator.SIMPLE, source_reference), source_reference));
						body.add_statement (new ReturnStatement (null, source_reference));
					} else {
						body.add_statement (new ReturnStatement (ma, source_reference));
					}
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

		if (body != null) {
			if (readable && context.profile == Profile.DOVA) {
				result_var = new LocalVariable (value_type.copy (), "result", null, source_reference);
				result_var.is_result = true;

				result_var.check (context);
			} else if (writable || construction) {
				value_parameter = new Parameter ("value", value_type, source_reference);
				body.scope.add (value_parameter.name, value_parameter);
			}

			body.check (context);

			if (context.profile != Profile.DOVA) {
				foreach (DataType body_error_type in body.get_error_types ()) {
					if (!((ErrorType) body_error_type).dynamic_error) {
						Report.warning (body_error_type.source_reference, "unhandled error `%s'".printf (body_error_type.to_string()));
					}
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
