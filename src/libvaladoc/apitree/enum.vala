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


public class Valadoc.Enum : Api.TypeSymbolNode, MethodHandler {
	public Enum (Valadoc.Settings settings, Vala.Enum symbol, EnumHandler parent, Tree root) {
		base (settings, symbol, parent, root);
		this.venum = symbol;

		Gee.Collection<Vala.Method> vmethods = this.venum.get_methods ();
		this.add_methods ( vmethods );

		Gee.Collection<Vala.EnumValue> venvals = this.venum.get_values ();
		this.add_enum_values ( venvals );
	}

	public string? get_cname () {
		return this.venum.get_cname();
	}

	// rename: get_enum_value_list
	public Gee.Collection<EnumValue> get_enum_values () {
		return get_children_by_type (Api.NodeType.ENUM_VALUE);
	}

	private inline void add_enum_values ( Gee.Collection<Vala.EnumValue> venvals ) {
		foreach ( Vala.EnumValue venval in venvals ) {
			var tmp = new EnumValue ( this.settings, venval, this, this.head );
			add_child ( tmp );
		}
	}

	public void visit_enum_values ( Doclet doclet ) {
		accept_children_by_type (Api.NodeType.ENUM_VALUE, doclet);
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_enum ( this );
	}

	public override Api.NodeType node_type { get { return Api.NodeType.ENUM; } }

	public override void accept (Doclet doclet) {
		visit (doclet);
	}

	private Vala.Enum venum;

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_enum ( this, ptr );
	}
}

