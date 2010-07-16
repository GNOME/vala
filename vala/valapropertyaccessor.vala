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
public class Vala.PropertyAccessor : Symbol {
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
	 * The accessor body.
	 */
	public Block? body {
		get { return _body; }
		set {
			_body = value;
			if (_body != null) {
				_body.owner = scope;
			}
		}
	}

	public BasicBlock entry_block { get; set; }

	public BasicBlock return_block { get; set; }

	public BasicBlock exit_block { get; set; }

	/**
	 * True if the body was automatically generated
	 */
	public bool automatic_body { get; set; }

	/**
	 * Represents the generated value parameter in a set accessor.
	 */
	public FormalParameter value_parameter { get; set; }

	/**
	 * Specifies the generated `result' variable in a get accessor.
	 */
	public LocalVariable? result_var { get; set; }

	/**
	 * The publicly accessible name of the function that performs the
	 * access in C code.
	 */
	public string get_cname () {
		if (_cname != null) {
			return _cname;
		}

		var t = (TypeSymbol) prop.parent_symbol;

		if (readable) {
			return "%sget_%s".printf (t.get_lower_case_cprefix (), prop.name);
		} else {
			return "%sset_%s".printf (t.get_lower_case_cprefix (), prop.name);
		}
	}

	private DataType _value_type;
	private string? _cname;
	private Block _body;
	
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
	public PropertyAccessor (bool readable, bool writable, bool construction, DataType? value_type, Block? body, SourceReference? source_reference) {
		base (null, source_reference);
		this.readable = readable;
		this.writable = writable;
		this.construction = construction;
		this.value_type = value_type;
		this.body = body;
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
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				if (a.has_argument ("cname")) {
					_cname = a.get_string ("cname");
				}
			}
		}
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		process_attributes ();

		if (!value_type.check (analyzer)) {
			error = true;
			return false;
		}

		var old_symbol = analyzer.current_symbol;

		analyzer.current_symbol = this;

		if (!prop.external_package) {
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
					if (analyzer.context.profile == Profile.DOVA) {
						body.add_statement (new ExpressionStatement (new Assignment (new MemberAccess.simple ("result", source_reference), ma, AssignmentOperator.SIMPLE, source_reference), source_reference));
						body.add_statement (new ReturnStatement (null, source_reference));
					} else {
						body.add_statement (new ReturnStatement (ma, source_reference));
					}
				} else {
					var assignment = new Assignment (ma, new MemberAccess.simple ("value", source_reference), AssignmentOperator.SIMPLE, source_reference);
					body.add_statement (new ExpressionStatement (assignment));
				}
			}
		}

		if (body != null) {
			if (readable && analyzer.context.profile == Profile.DOVA) {
				result_var = new LocalVariable (value_type.copy (), "result", null, source_reference);
				result_var.is_result = true;

				result_var.check (analyzer);
			} else if (writable || construction) {
				value_parameter = new FormalParameter ("value", value_type, source_reference);
				body.scope.add (value_parameter.name, value_parameter);
			}

			body.check (analyzer);

			if (analyzer.context.profile != Profile.DOVA) {
				foreach (DataType body_error_type in body.get_error_types ()) {
					if (!((ErrorType) body_error_type).dynamic_error) {
						Report.warning (body_error_type.source_reference, "unhandled error `%s'".printf (body_error_type.to_string()));
					}
				}
			}
		}

		analyzer.current_symbol = old_symbol;

		return !error;
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (value_type == old_type) {
			value_type = new_type;
		}
	}

	public override List<string> get_cheader_filenames () {
		return parent_symbol.get_cheader_filenames ();
	}
}
