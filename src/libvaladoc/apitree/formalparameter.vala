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

public class Valadoc.FormalParameter : Api.SymbolNode, ReturnTypeHandler {
	private Vala.FormalParameter vformalparam;

	public FormalParameter (Valadoc.Settings settings, Vala.FormalParameter symbol, ParameterListHandler parent, Tree root) {
		base (settings, symbol, parent, root);
		this.vformalparam = symbol;

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

	public override Api.NodeType node_type { get { return Api.NodeType.FORMAL_PARAMETER; } }

	public override void accept (Doclet doclet) {
	}

	protected override void resolve_type_references () {
		if (this.vformalparam.ellipsis)
			return ;

		this.set_return_type_references ();

		base.resolve_type_references ();
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_formal_parameter ( this, ptr );
	}
}

