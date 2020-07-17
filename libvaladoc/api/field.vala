/* field.vala
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
 * Represents a field.
 */
public class Valadoc.Api.Field : Symbol {
	private string? cname;

	public Field (Node parent, SourceFile file, string name, Vala.SymbolAccessibility accessibility,
				  SourceComment? comment,
				  Vala.Field data)
	{
		base (parent, file, name, accessibility, comment, data);

		this.is_static = !(parent is Namespace) && data.binding == Vala.MemberBinding.STATIC;
		this.is_class = data.binding == Vala.MemberBinding.CLASS;
		this.is_volatile = data.is_volatile;

		this.cname = Vala.get_ccode_name (data);
	}

	/**
	 * Returns the name of this field as it is used in C.
	 */
	public string? get_cname () {
		return cname;
	}

	/**
	 * The field type.
	 */
	public TypeReference? field_type {
		set;
		get;
	}

	/**
	 * Specifies whether the field is static.
	 */
	public bool is_static {
		private set;
		get;
	}

	/**
	 * Specifies whether this field is a class field.
	 */
	public bool is_class {
		private set;
		get;
	}

	/**
	 * Specifies whether the field is volatile.
	 */
	public bool is_volatile {
		private set;
		get;
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (accessibility.to_string ());
		if (is_static) {
			signature.append_keyword ("static");
		} else if (is_class) {
			signature.append_keyword ("class");
		}
		if (is_volatile) {
			signature.append_keyword ("volatile");
		}

		signature.append_content (field_type.signature);
		signature.append_symbol (this);
		return signature.get ();
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get { return NodeType.FIELD; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_field (this);
	}
}

