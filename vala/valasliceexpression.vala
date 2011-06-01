/* valasliceexpression.vala
 *
 * Copyright (C) 2009 Robin Sonefors
 * Copyright (C) 2009-2010 Jürg Billeter
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
 * 	Robin Sonefors <ozamosi@flukkost.nu>
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Represents an array slice expression e.g "a[1:5]".
 */
public class Vala.SliceExpression : Expression {
	public Expression container {
		get {
			return _container;
		}
		set {
			_container = value;
			_container.parent_node = this;
		}
	}

	public Expression start {
		get {
			return _start;
		}
		private set {
			_start = value;
			_start.parent_node = this;
		}
	}

	public Expression stop {
		get {
			return _stop;
		}
		private set {
			_stop = value;
			_stop.parent_node = this;
		}
	}

	Expression _container;
	Expression _start;
	Expression _stop;

	public SliceExpression (Expression container, Expression start, Expression stop, SourceReference? source_reference = null) {
		this.container = container;
		this.start = start;
		this.stop = stop;
		this.source_reference = source_reference;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_slice_expression (this);

		visitor.visit_expression (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		container.accept (visitor);

		start.accept (visitor);
		stop.accept (visitor);
	}

	public override void replace_expression (Expression old_node, Expression new_node) {
		if (container == old_node) {
			container = new_node;
		}
		if (start == old_node) {
			start = new_node;
		}
		if (stop == old_node) {
			stop = new_node;
		}
	}

	public override bool is_pure () {
		return false;
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (!container.check (context)) {
			error = true;
			return false;
		}

		if (!start.check (context)) {
			error = true;
			return false;
		}

		if (!stop.check (context)) {
			error = true;
			return false;
		}

		if (container.value_type == null) {
			error = true;
			Report.error (container.source_reference, "Invalid container expression");
			return false;
		}

		if (lvalue) {
			error = true;
			Report.error (container.source_reference, "Slice expressions cannot be used as lvalue");
			return false;
		}

		if (container.value_type is ArrayType) {
			value_type = container.value_type.copy ();
			value_type.value_owned = false;

			/* check if the index is of type integer */
			if (!(start.value_type is IntegerType || start.value_type is EnumValueType)) {
				error = true;
				Report.error (start.source_reference, "Expression of integer type expected");
			}
			if (!(stop.value_type is IntegerType || stop.value_type is EnumValueType)) {
				error = true;
				Report.error (stop.source_reference, "Expression of integer type expected");
			}
		} else {
			var slice_method = container.value_type.get_member ("slice") as Method;
			if (slice_method != null) {
				var slice_call = new MethodCall (new MemberAccess (container, "slice"));
				slice_call.add_argument (start);
				slice_call.add_argument (stop);
				slice_call.target_type = this.target_type;
				parent_node.replace_expression (this, slice_call);
				return slice_call.check (context);
			}

			error = true;
			Report.error (source_reference, "The expression `%s' does not denote an array".printf (container.value_type.to_string ()));
		}

		return !error;
	}

	public override void emit (CodeGenerator codegen) {
		container.emit (codegen);

		start.emit (codegen);
		stop.emit (codegen);

		codegen.visit_slice_expression (this);

		codegen.visit_expression (this);
	}

	public override void get_defined_variables (Collection<Variable> collection) {
		container.get_defined_variables (collection);
		start.get_defined_variables (collection);
		stop.get_defined_variables (collection);
	}

	public override void get_used_variables (Collection<Variable> collection) {
		container.get_used_variables (collection);
		start.get_used_variables (collection);
		stop.get_used_variables (collection);
	}
}
