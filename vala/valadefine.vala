/* valadefine.vala
 *
 * Copyright (C) 2019  Rico Tzschichholz
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
 * 	Rico Tzschichholz <ricotz@ubuntu.com>
 */

using GLib;

/**
 * Represents a define in the source code.
 */
public class Vala.Define : Constant {
	/**
	 * Creates a new define.
	 *
	 * @param name  define name
	 * @param value define value
	 * @return      newly created define
	 */
	public Define (string name, Expression? value, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, null, value, source_reference, comment);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_define (this);
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

		return !error;
	}
}
