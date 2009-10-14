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


public class Valadoc.Struct : Api.TypeSymbolNode, MethodHandler, ConstructionMethodHandler, FieldHandler, ConstantHandler, TemplateParameterListHandler {
	private Vala.Struct vstruct;

	public Struct (Valadoc.Settings settings, Vala.Struct symbol, Api.Node parent, Tree root) {
		base (settings, symbol, parent, root);
		this.vstruct = symbol;
	}

	protected Struct? base_type {
		protected set;
		get;
	}

	public string? get_cname () {
		return this.vstruct.get_cname();
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_struct (this);
	}

	public override Api.NodeType node_type { get { return Api.NodeType.STRUCT; } }

	public override void accept (Doclet doclet) {
		visit (doclet);
	}

	public void write (Langlet langlet, void* ptr) {
		langlet.write_struct (this, ptr);
	}

	private void set_parent_references ( ) {
		Vala.ValueType? basetype = (Vala.ValueType?)this.vstruct.base_type;
		if (basetype == null)
			return ;

		this.base_type = (Struct?)this.head.search_vala_symbol ( (Vala.Struct)basetype.type_symbol );
	}

	protected override void resolve_type_references () {
		this.set_parent_references ( );

		base.resolve_type_references ( );
	}
}

