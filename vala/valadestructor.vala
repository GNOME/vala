/* valadestructor.vala
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
 * Represents a class or instance destructor.
 */
public class Vala.Destructor : Subroutine {
	/**
	 * Specifies the generated `this` parameter for instance methods.
	 */
	public Parameter this_parameter { get; set; }

	/**
	 * Specifies whether this is an instance or a class destructor.
	 */
	public MemberBinding binding { get; set; default = MemberBinding.INSTANCE; }

	public override bool has_result {
		get { return false; }
	}

	/**
	 * Creates a new destructor.
	 *
	 * @param source_reference reference to source code
	 * @return                 newly created destructor
	 */
	public Destructor (SourceReference? source_reference = null) {
		base (null, source_reference);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_destructor (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (body != null) {
			body.accept (visitor);
		}
	}

	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		owner = context.analyzer.current_symbol.scope;
		context.analyzer.current_symbol = this;

		if (body != null) {
			body.check (context);
		}

		context.analyzer.current_symbol = context.analyzer.current_symbol.parent_symbol;

		return !error;
	}
}
