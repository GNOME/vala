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


public class Valadoc.Signal : Api.MemberNode, ParameterListHandler, ReturnTypeHandler {
	private Vala.Signal vsignal;

	public Signal (Vala.Signal symbol, Api.Node parent) {
		base (symbol, parent);

		this.vsignal = symbol;

		var ret = this.vsignal.return_type;
		this.set_ret_type (ret);
	}

	public string? get_cname () {
		return this.vsignal.get_cname();
	}

	public TypeReference? type_reference {
		protected set;
		get;
	}

	protected override void resolve_type_references (Tree root) {
		this.set_return_type_references (root);

		base.resolve_type_references (root);
	}

	public bool is_virtual {
		get {
			return this.vsignal.is_virtual;
		}
	}

	public void visit (Doclet doclet) {
		doclet.visit_signal (this);
	}

	public override Api.NodeType node_type { get { return Api.NodeType.SIGNAL; } }

	public override void accept (Doclet doclet) {
		visit (doclet);
	}

	public void write (Langlet langlet, void* ptr) {
		langlet.write_signal (this, ptr);
	}
}
