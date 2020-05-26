/* valaerrorcode.vala
 *
 * Copyright (C) 2008  Jürg Billeter
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
 * Represents an error value member in the source code.
 */
public class Vala.ErrorCode : TypeSymbol {
	/**
	 * Specifies the numerical representation of this enum value.
	 */
	public Expression? value {
		get { return _value; }
		set {
			_value = value;
			if (_value != null) {
				_value.parent_node = this;
			}
		}
	}

	/**
	 * Refers to the enum value of this error code for direct access.
	 */
	public Constant code {
		get {
			return _code;
		}
		private set {
			_code = value;
			if (_code != null) {
				_code.owner = owner;
			}
		}
	}

	private Expression _value;
	private Constant _code;

	/**
	 * Creates a new enum value.
	 *
	 * @param name enum value name
	 * @return     newly created enum value
	 */
	public ErrorCode (string name, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
	}

	/**
	 * Creates a new enum value with the specified numerical representation.
	 *
	 * @param name  enum value name
	 * @param value numerical representation
	 * @return      newly created enum value
	 */
	public ErrorCode.with_value (string name, Expression value, SourceReference? source_reference = null) {
		this (name, source_reference);
		this.value = value;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_error_code (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (value != null) {
			value.accept (visitor);
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		if (value != null) {
			value.check (context);
		}

		code = new Constant (name, context.analyzer.int_type.copy (), null, source_reference, comment);
		code.external = true;
		code.check (context);

		return !error;
	}
}
