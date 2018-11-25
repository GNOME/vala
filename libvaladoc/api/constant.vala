/* constant.vala
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
 * Represents a type member with a constant value.
 */
public class Valadoc.Api.Constant : Symbol {
	private string? cname;

	/**
	 * The data type of this constant.
	 */
	public TypeReference constant_type {
		set;
		get;
	}

	public Constant (Node parent, SourceFile file, string name, Vala.SymbolAccessibility accessibility,
					 SourceComment? comment, Vala.Constant data)
	{
		base (parent, file, name, accessibility, comment, data);

		this.cname = Vala.get_ccode_name (data);
	}

	/**
	 * Returns the name of this constant as it is used in C.
	 */
	public string get_cname () {
		return cname;
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		return new SignatureBuilder ()
			.append_keyword (accessibility.to_string ())
			.append_keyword ("const")
			.append_content (constant_type.signature)
			.append_symbol (this)
			.get ();
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get { return NodeType.CONSTANT; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_constant (this);
	}
}

