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


public class Valadoc.FormalParameter : Basic, ReturnTypeHandler {
	private Vala.FormalParameter vformalparam;

	public FormalParameter ( Valadoc.Settings settings, Vala.FormalParameter vformalparam, Basic parent, Tree head ) {
		this.settings = settings;
		this.vformalparam = vformalparam;
		this.vsymbol = vformalparam;
		this.parent = parent;
		this.head = head;

		var vformparam = this.vformalparam.parameter_type;
		this.set_ret_type ( vformparam );
	}

	public bool is_out {
		get {
			return this.vformalparam.direction == ParameterDirection.OUT;
		}
	}

	public bool is_ref {
		get {
			return this.vformalparam.direction == ParameterDirection.REF;
		}
	}

	public bool has_default_value {
		get {
			return this.vformalparam.default_expression != null;
		}
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	public bool ellipsis {
		get {
			return this.vformalparam.ellipsis;
		}
	}

	public string? name {
		owned get {
			return ( this.vformalparam.name == null )? "" : this.vformalparam.name;
		}
	}

	internal void set_type_references ( ) {
		if ( this.vformalparam.ellipsis )
			return ;

		((ReturnTypeHandler)this).set_return_type_references ( );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_formal_parameter ( this, ptr );
	}
}

