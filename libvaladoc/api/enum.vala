/* enum.vala
 *
 * Copyright (C) 2008-2011  Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */


using Valadoc.Content;

/**
 * Represents an enum declaration.
 */
public class Valadoc.Api.Enum : TypeSymbol {
	private string cname;

	public Enum (Node parent, SourceFile file, string name, SymbolAccessibility accessibility,
				 SourceComment? comment, string? cname, string? type_macro_name,
				 string? type_function_name, void* data)
	{
		base (parent, file, name, accessibility, comment, type_macro_name, null, null,
			type_function_name, false, data);
		this.cname = cname;
	}

	/**
	 * Returns the name of this enum as it is used in C.
	 */
	public string? get_cname () {
		return cname;
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type { get { return NodeType.ENUM; } }

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_enum (this);
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_keyword (accessibility.to_string ())
			.append_keyword ("enum")
			.append_symbol (this)
			.get ();
	}
}

