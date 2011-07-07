/* property.vala
 *
 * Copyright (C) 2008  Florian Brosch
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

using Gee;
using Valadoc.Content;


/**
 * Represents a property declaration.
 */
public class Valadoc.Api.Property : Member {
	public Property (Vala.Property symbol, Node parent) {
		base (symbol, parent);

		property_type = new TypeReference (symbol.property_type, this);

		if (symbol.get_accessor != null) {
			this.getter = new PropertyAccessor (symbol.get_accessor, this);
		}

		if (symbol.set_accessor != null) {
			this.setter = new PropertyAccessor (symbol.set_accessor, this);
		}
	}

	/**
	 * Returns the name of this method as it is used in C.
	 */
	public string? get_cname () {
		return ((Vala.Property) symbol).nick;
	}

	/**
	 * Returns the dbus-name.
	 */
	public string get_dbus_name () {
		return Vala.GDBusModule.get_dbus_name_for_member (symbol);
	}

	/**
	 * The property type.
	 *
	 * @return The property type or null for void
	 */
	public TypeReference? property_type { private set; get;}

	/**
	 * Specifies whether the property is virtual.
	 */
	public bool is_virtual {
		get {
			return ((Vala.Property) symbol).is_virtual;
		}
	}

	/**
	 * Specifies whether the property is abstract.
	 */
	public bool is_abstract {
		get {
			return ((Vala.Property) symbol).is_abstract;
		}
	}

	/**
	 * Specifies whether the property is override.
	 */
	public bool is_override {
		get {
			return ((Vala.Property) symbol).overrides;
		}
	}

	/**
	 * Specifies whether the property is visible.
	 */
	public bool is_dbus_visible {
		get {
			return Vala.GDBusServerModule.is_dbus_visible (symbol);
		}
	}

	public PropertyAccessor setter { private set; get; }

	public PropertyAccessor getter { private set; get; }

	/**
	 * Specifies the virtual or abstract property this property overrides.
	 */
	public Property base_property { private set; get; }

	/**
	 * {@inheritDoc}
	 */
	internal override void resolve_type_references (Tree root) {
		Vala.Property vala_property = symbol as Vala.Property;
		Vala.Property? base_vala_property = null;
		if (vala_property.base_property != null) {
			base_vala_property = vala_property.base_property;
		} else if (vala_property.base_interface_property != null) {
			base_vala_property = vala_property.base_interface_property;
		}
		if (base_vala_property == vala_property
		    && vala_property.base_interface_property != null) {
			base_vala_property = vala_property.base_interface_property;
		}
		if (base_vala_property != null) {
			base_property = (Property?) root.search_vala_symbol (base_vala_property);
		}

		property_type.resolve_type_references (root);
	}

	/**
	 * {@inheritDoc}
	 */
	internal override void process_comments (Settings settings, DocumentationParser parser) {
		if (getter != null && getter.is_browsable (settings)) {
			getter.process_comments (settings, parser);
		}

		if (setter != null && setter.is_browsable (settings)) {
			setter.process_comments (settings, parser);
		}

		base.process_comments (settings, parser);
	}

	/**
	 * {@inheritDoc}
	 */
	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		signature.append_keyword (get_accessibility_modifier ());
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
	public override NodeType node_type { get { return NodeType.PROPERTY; } }

	/**
	 * {@inheritDoc}
	 */
	public override void accept (Visitor visitor) {
		visitor.visit_property (this);
	}
}

