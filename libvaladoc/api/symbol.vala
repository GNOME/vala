/* symbol.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch, Didier Villevalois
 * Copyright (C) 2011      Florian Brosch
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
 * 	Didier 'Ptitjes Villevalois <ptitjes@free.fr>
 */


/**
 * Represents a node in the symbol tree.
 */
public abstract class Valadoc.Api.Symbol : Node {
	private Vala.ArrayList<Attribute> attributes;

	public bool is_deprecated {
		default = false;
		private set;
		get;
	}

	public Symbol (Node parent, SourceFile file, string? name, SymbolAccessibility accessibility,
				   void* data)
	{
		base (parent, file, name, data);

		this.accessibility = accessibility;
	}

	public void add_attribute (Attribute att) {
		if (attributes == null) {
			attributes = new Vala.ArrayList<Attribute> ();
		}

		// register deprecated symbols:
		if (att.name == "Version") {
			AttributeArgument? deprecated = att.get_argument ("deprecated");
			AttributeArgument? version = att.get_argument ("deprecated_since");
			if ((deprecated != null && deprecated.get_value_as_boolean ()) || version != null) {
				string? version_str = (version != null) ? version.get_value_as_string () : null;

				package.register_deprecated_symbol (this, version_str);
				is_deprecated = true;
			}
		} else if (att.name == "Deprecated") {
			AttributeArgument? version = att.get_argument ("version");
			string? version_str = (version != null) ? version.get_value_as_string () : null;

			package.register_deprecated_symbol (this, version_str);
			is_deprecated = true;
		}

		attributes.add (att);
	}

	public Vala.Collection<Attribute> get_attributes () {
		if (attributes == null) {
			return new Vala.ArrayList<Attribute> ();
		} else {
			return attributes;
		}
	}

	public Attribute? get_attribute (string name) {
		if (attributes != null) {
			foreach (Attribute att in attributes) {
				if (att.name == name) {
					return att;
				}
			}
		}

		return null;
	}

	/**
	 * {@inheritDoc}
	 */
	public override bool is_browsable (Settings settings) {
		if (!settings._private && this.is_private) {
			return false;
		}
		if (!settings._internal && this.is_internal) {
			return false;
		}
		if (!settings._protected && this.is_protected) {
			return false;
		}

		Item? pos = parent;
		while (pos != null && pos is Symbol && pos is Namespace == false) {
			if (((Symbol) pos).is_browsable (settings) == false) {
				return false;
			}
			pos = pos.parent;
		}

		return true;
	}

	public SymbolAccessibility accessibility {
		private set;
		get;
	}

	/**
	 * Specifies whether this symbol is public.
	 */
	public bool is_public {
		get {
			return accessibility == SymbolAccessibility.PUBLIC;
		}
	}

	/**
	 * Specifies whether this symbol is protected.
	 */
	public bool is_protected {
		get {
			return accessibility == SymbolAccessibility.PROTECTED;
		}
	}

	/**
	 * Specifies whether this symbol is internal.
	 */
	public bool is_internal {
		get {
			return accessibility == SymbolAccessibility.INTERNAL;
		}
	}

	/**
	 * Specifies whether this symbol is private.
	 */
	public bool is_private {
		get {
			return accessibility == SymbolAccessibility.PRIVATE;
		}
	}
}

