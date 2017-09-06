/* property.vala
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
 * Represents a property declaration.
 */
public class Valadoc.Api.Property : Member {
	private PropertyBindingType binding_type;
	private string? dbus_name;
	private string? cname;

	public Property (Node parent, SourceFile file, string name, SymbolAccessibility accessibility,
					 SourceComment? comment, string? cname, string? dbus_name, bool is_dbus_visible,
					 PropertyBindingType binding_type, void* data)
	{
		base (parent, file, name, accessibility, comment, data);

		this.is_dbus_visible = is_dbus_visible;
		this.binding_type = binding_type;

		this.dbus_name = dbus_name;
		this.cname = cname;
	}

	/**
	 * Returns the name of this method as it is used in C.
	 */
	public string? get_cname () {
		return cname;
	}

	/**
	 * Returns the dbus-name.
	 */
	public string get_dbus_name () {
		return dbus_name;
	}

	/**
	 * The property type.
	 */
	public TypeReference? property_type {
		set;
		get;
	}

	/**
	 * Specifies whether the property is virtual.
	 */
	public bool is_virtual {
		get {
			return binding_type == PropertyBindingType.VIRTUAL;
		}
	}

	/**
	 * Specifies whether the property is abstract.
	 */
	public bool is_abstract {
		get {
			return binding_type == PropertyBindingType.ABSTRACT;
		}
	}

	/**
	 * Specifies whether the property is override.
	 */
	public bool is_override {
		get {
			return binding_type == PropertyBindingType.OVERRIDE;
		}
	}

	/**
	 * Specifies whether the property is visible.
	 */
	public bool is_dbus_visible {
		private set;
		get;
	}

	public PropertyAccessor? setter {
		set;
		get;
	}

	public PropertyAccessor? getter {
		set;
		get;
	}

	/**
	 * Specifies the virtual or abstract property this property overrides.
	 */
	public Property base_property {
		set;
		get;
	}

	/**
	 * {@inheritDoc}
	 */
	internal override void parse_comments (Settings settings, DocumentationParser parser) {
		if (getter != null && getter.is_browsable (settings)) {
			getter.parse_comments (settings, parser);
		}

		if (setter != null && setter.is_browsable (settings)) {
			setter.parse_comments (settings, parser);
		}

		base.parse_comments (settings, parser);
	}

	/**
	 * {@inheritDoc}
	 */
	internal override void check_comments (Settings settings, DocumentationParser parser) {
		if (getter != null && getter.is_browsable (settings)) {
			getter.check_comments (settings, parser);
		}

		if (setter != null && setter.is_browsable (settings)) {
			setter.check_comments (settings, parser);
		}

		base.check_comments (settings, parser);
	}


	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (accessibility.to_string ());
		if (is_abstract) {
			signature.append_keyword ("abstract");
		} else if (is_override) {
			signature.append_keyword ("override");
		} else if (is_virtual) {
			signature.append_keyword ("virtual");
		}

		signature.append_content (property_type.signature);
		signature.append_symbol (this);
		signature.append ("{");

		if (setter != null && setter.do_document) {
			signature.append_content (setter.signature);
		}

		if (getter != null && getter.do_document) {
			signature.append_content (getter.signature);
		}

		signature.append ("}");

		return signature.get ();
	}

	/**
	 * {@inheritDoc}
	 */
	public override NodeType node_type {
		get { return NodeType.PROPERTY; }
	}

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_property (this);
	}
}

