/* valaenumvalue.vala
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
 * Represents an enum value member in the source code.
 */
public class Vala.EnumValue : Constant {
	/**
	 * The nick of this enum-value
	 */
	public string nick {
		get {
			if (_nick == null) {
				_nick = get_attribute_string ("Description", "nick");
				if (_nick == null) {
					_nick = name.ascii_down ().replace ("_", "-");
				}
			}
			return _nick;
		}
	}

	private string? _nick = null;

	/**
	 * Creates a new enum value with the specified numerical representation.
	 *
	 * @param name  enum value name
	 * @param value numerical representation
	 * @return      newly created enum value
	 */
	public EnumValue (string name, Expression? value, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, null, value, source_reference, comment);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_enum_value (this);
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

			// check whether initializer is at least as accessible as the enum value
			if (!value.is_accessible (this)) {
				error = true;
				Report.error (value.source_reference, "value is less accessible than enum `%s'", parent_symbol.get_full_name ());
			}
		}

		return !error;
	}
}
