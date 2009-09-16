/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2008 Florian Brosch
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */


using Vala;
using GLib;
using Gee;


public class Valadoc.Property : DocumentedElement, SymbolAccessibility, ReturnTypeHandler, Visitable {
	private Vala.Property vproperty;

	public Property (Valadoc.Settings settings, Vala.Property vproperty, PropertyHandler parent, Tree head) {
		this.vcomment = vproperty.comment;
		this.settings = settings;
		this.parent = parent;
		this.head = head;

		this.vsymbol = vproperty;
		this.vproperty = vproperty;

		var ret = this.vproperty.property_type;
		this.set_ret_type (ret);

		if (this.vproperty.get_accessor != null) {
			this.getter = new PropertyAccessor (this.settings, this.vproperty.get_accessor, this, this.head);
		}

		if (this.vproperty.set_accessor != null) {
			this.setter = new PropertyAccessor (this.settings, this.vproperty.set_accessor, this, this.head);
		}
	}

	public bool is_vproperty (Vala.Property vprop) {
		return (this.vproperty == vprop);
	}

	public string? get_cname () {
		return this.vproperty.nick;
	}

	public bool equals ( Property p ) {
		return this.vproperty.equals ( p.vproperty );
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public bool is_virtual {
		get {
			return this.vproperty.is_virtual;
		}
	}

	public bool is_abstract {
		get {
			return this.vproperty.is_abstract;
		}
	}

	public bool is_override {
		get {
			return this.vproperty.overrides;
		}
	}

	public PropertyAccessor setter {
		private set;
		get;
	}

	public PropertyAccessor getter {
		private set;
		get;
	}

	public Property base_property {
		private set;
		get;
	}

	internal void set_type_references ( ) {
		Vala.Property? vp = null;
		if (vproperty.base_property != null) {
			vp = vproperty.base_property;
		} else if (vproperty.base_interface_property != null) {
			vp = vproperty.base_interface_property;
		}
		if (vp == vproperty && vproperty.base_interface_property != null) {
			vp = vproperty.base_interface_property;
		}
		if (vp != null) {
			this.base_property = (Property?) this.head.search_vala_symbol (vp);
		}
		this.set_return_type_references ( );
	}

	public void parse_comment (DocumentationParser docparser) {
		if (this.documentation != null)
			return ;

		if (this.vcomment == null)
			return ;

		this.parse_comment_helper (docparser);
	}

	public void visit (Doclet doclet) {
		if (!this.is_visitor_accessible ())
			return ;

		doclet.visit_property (this);
	}

	public void write (Langlet langlet, void* ptr) {
		langlet.write_property (this, ptr);
	}
}

