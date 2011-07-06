/* valaerrordomain.vala
 *
 * Copyright (C) 2008-2010  Jürg Billeter
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
 * Represents an error domain declaration in the source code.
 */
public class Vala.ErrorDomain : TypeSymbol {
	private List<ErrorCode> codes = new ArrayList<ErrorCode> ();
	private List<Method> methods = new ArrayList<Method> ();

	/**
	 * Creates a new error domain.
	 *
	 * @param name             type name
	 * @param source_reference reference to source code
	 * @return                 newly created error domain
	 */
	public ErrorDomain (string name, SourceReference? source_reference = null, Comment? comment = null) {
		base (name, source_reference, comment);
	}
	
	/**
	 * Appends the specified code to the list of error codes.
	 *
	 * @param ecode an error code
	 */
	public void add_code (ErrorCode ecode) {
		codes.add (ecode);
		scope.add (ecode.name, ecode);
	}

	/**
	 * Adds the specified method as a member to this error domain.
	 *
	 * @param m a method
	 */
	public override void add_method (Method m) {
		if (m is CreationMethod) {
			Report.error (m.source_reference, "construction methods may only be declared within classes and structs");
		
			m.error = true;
			return;
		}
		if (m.binding == MemberBinding.INSTANCE) {
			m.this_parameter = new Parameter ("this", new ErrorType (this, null));
			m.scope.add (m.this_parameter.name, m.this_parameter);
		}

		methods.add (m);
		scope.add (m.name, m);
	}

	/**
	 * Returns a copy of the list of error codes.
	 *
	 * @return list of error codes
	 */
	public List<ErrorCode> get_codes () {
		return codes;
	}

	/**
	 * Returns a copy of the list of methods.
	 *
	 * @return list of methods
	 */
	public List<Method> get_methods () {
		return methods;
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_error_domain (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (ErrorCode ecode in codes) {
			ecode.accept (visitor);
		}

		foreach (Method m in methods) {
			m.accept (visitor);
		}
	}

	public override bool is_reference_type () {
		return false;
	}
	
	public override bool check (CodeContext context) {
		if (checked) {
			return !error;
		}

		checked = true;

		foreach (ErrorCode ecode in codes) {
			ecode.check (context);
		}

		foreach (Method m in methods) {
			m.check (context);
		}

		return !error;
	}
}
