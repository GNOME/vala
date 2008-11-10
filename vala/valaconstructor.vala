/* valaconstructor.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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
 * Represents a class or instance constructor.
 */
public class Vala.Constructor : Symbol {
	/**
	 * The body of this constructor.
	 */
	public Block body { get; set; }
	
	/**
	 * Specifies the generated `this' parameter for instance methods.
	 */
	public FormalParameter this_parameter { get; set; }

	/**
	 * Specifies whether this is an instance or a class constructor.
	 */
	public MemberBinding binding { get; set; default = MemberBinding.INSTANCE; }
	
	/**
	 * Creates a new constructor.
	 *
	 * @param source reference to source code
	 * @return       newly created constructor
	 */
	public Constructor (SourceReference source) {
		base (null, source);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_constructor (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		if (body != null) {
			body.accept (visitor);
		}
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		this_parameter = new FormalParameter ("this", new ObjectType (analyzer.current_class));
		scope.add (this_parameter.name, this_parameter);

		owner = analyzer.current_symbol.scope;
		analyzer.current_symbol = this;

		if (body != null) {
			body.check (analyzer);
		}

		foreach (DataType body_error_type in body.get_error_types ()) {
			Report.warning (body_error_type.source_reference, "unhandled error `%s'".printf (body_error_type.to_string()));
		}

		analyzer.current_symbol = analyzer.current_symbol.parent_symbol;

		return !error;
	}
}
