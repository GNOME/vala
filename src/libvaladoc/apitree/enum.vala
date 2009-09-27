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


public class Valadoc.Enum : DocumentedElement, SymbolAccessibility, Visitable, MethodHandler {
	private Gee.ArrayList<EnumValue> en_values;

	public Enum ( Valadoc.Settings settings, Vala.Enum venum, EnumHandler parent, Tree head ) {
		this.vcomment = venum.comment;
		this.settings = settings;
		this.vsymbol = venum;
		this.venum = venum;
		this.parent = parent;
		this.head = head;

		Gee.Collection<Vala.Method> vmethods = this.venum.get_methods ();
		this.methods = new Gee.ArrayList<Method> ();
		this.add_methods ( vmethods );

		Gee.Collection<Vala.EnumValue> venvals = this.venum.get_values ();
		this.en_values = new Gee.ArrayList<EnumValue> ();
		this.add_enum_values ( venvals );
	}

	public string? get_cname () {
		return this.venum.get_cname();
	}

	private DocumentedElement? search_enum_value_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos+1];
		if ( velement is Vala.EnumValue == false )
			return null;

		if ( params.size != pos+2 )
			return null;

		foreach ( EnumValue env in this.en_values ) {
			if ( env.is_venumvalue ( (Vala.EnumValue)velement ) ) {
				return env;
			}
		}
		return null;
	}

	private DocumentedElement? search_enum_value ( string[] params, int pos ) {
		pos++;

		if ( params[pos+1] != null )
			return null;

		foreach ( EnumValue enval in this.en_values ) {
			if ( enval.name == params[pos] )
				return enval;
		}
		return null;
	}

	internal override DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos];

		if ( velement is Vala.Enum == false )
			return null;

		if ( this.is_venum ( (Vala.Enum)velement ) == false )
			return null;

		if ( params.size == pos+1 )
			return this;

		velement = params[pos+1];

		DocumentedElement? element = null;

		if ( velement is Vala.EnumValue ) {
			element = this.search_enum_value_vala ( params, pos );
		}
		else if ( velement is Vala.Method ) {
			element = this.search_method_vala ( params, pos );
		}
		return element;
	}

	internal override DocumentedElement? search_element ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos] == this.name && params[pos+1] == null )
			return this;


		DocumentedElement? element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_enum_value ( params, pos );
		if ( element != null )
			return element;

		return null;
	}

	internal void set_type_references () {
		this.set_method_type_references ();
	}

	protected Gee.ArrayList<Method> methods {
		protected set;
		get;
	}

	// rename: get_enum_value_list
	public Gee.Collection<EnumValue> get_enum_values () {
		return this.en_values.read_only_view;
	}

	internal void parse_comments ( Valadoc.Parser docparser ) {
		this.parse_comment_helper ( docparser );

		foreach ( EnumValue enval in this.en_values ) {
			enval.parse_comment ( docparser );
		}

		this.parse_method_comments ( docparser );
	}

	private inline void add_enum_values ( Gee.Collection<Vala.EnumValue> venvals ) {
		foreach ( Vala.EnumValue venval in venvals ) {
			var tmp = new EnumValue ( this.settings, venval, this, this.head );
			this.en_values.add ( tmp );
		}
	}

	public void visit_enum_values ( Doclet doclet ) {
		foreach ( EnumValue enval in this.en_values )
			enval.visit ( doclet );
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_enum ( this );
	}

	private Vala.Enum venum;

	internal bool is_venum ( Vala.Enum ven ) {
		return ( this.venum == ven );
	}

	public void write ( Langlet langlet, void* ptr ) {
		langlet.write_enum ( this, ptr );
	}
}

