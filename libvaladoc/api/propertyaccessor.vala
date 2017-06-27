/* propertyaccessor.vala
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
 * Represents a get or set accessor of a property.
 */
public class Valadoc.Api.PropertyAccessor : Symbol {
	private PropertyAccessorType type;
	private Ownership ownership;
	private string? cname;

	public PropertyAccessor (Property parent, SourceFile file, string name, SymbolAccessibility accessibility,
							 string? cname, PropertyAccessorType type, Ownership ownership, void* data)
	{
		base (parent, file, name, accessibility, data);

		this.ownership = ownership;
		this.cname = cname;
		this.type = type;
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get { return NodeType.PROPERTY_ACCESSOR; }
	}

	/**
	 * Returns the name of this property accessor as it is used in C.
	 */
	public string? get_cname () {
		return cname;
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
	}

	/**
	 * Specifies whether this accessor may be used to construct the property.
	 */
	public bool is_construct {
		get {
			return (type & PropertyAccessorType.CONSTRUCT) != 0;
		}
	}

	/**
	 * Specifies whether this accessor is a setter.
	 */
	public bool is_set {
		get {
			return (type & PropertyAccessorType.SET) != 0;
		}
	}

	/**
	 * Specifies whether this accessor is a getter.
	 */
	public bool is_get {
		get {
			return (type & PropertyAccessorType.GET) != 0;
		}
	}

	/**
	 * Specifies whether the property is owned.
	 */
	public bool is_owned {
		get {
			return ownership == Ownership.OWNED;
		}
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		// FIXME
		if (!do_document) {
			return signature.get ();
		}

		if (((Property) parent).accessibility != accessibility) {
			signature.append_keyword (accessibility.to_string ());
		}

		if (is_set || is_construct) {
			if (is_construct) {
				signature.append_keyword ("construct");
			}
			if (is_set) {
				signature.append_keyword ("set");
			}
		} else if (is_get) {
			if (is_owned) {
				signature.append_keyword ("owned");
			}
			signature.append_keyword ("get");
		}
		signature.append (";", false);

		return signature.get ();
	}
}

