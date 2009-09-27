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


public class Valadoc.Struct : DocumentedElement, SymbolAccessibility, Visitable, MethodHandler, ConstructionMethodHandler, FieldHandler, ConstantHandler, TemplateParameterListHandler {
	private Vala.Struct vstruct;

	public Struct (Valadoc.Settings settings, Vala.Struct vstruct, StructHandler parent, Tree head) {
		this.vcomment = vstruct.comment;
		this.settings = settings;
		this.vstruct = vstruct;
		this.vsymbol = vstruct;
		this.parent = parent;
		this.head = head;

		this.template_param_lst = new Gee.ArrayList<TypeParameter> ();
		this.methods = new Gee.ArrayList<Method> ();

		var vtparams = this.vstruct.get_type_parameters ();
		this.set_template_parameter_list (vtparams);

		Gee.Collection<Vala.Field> vfields = this.vstruct.get_fields();
		this.fields = new Gee.ArrayList<Field> ();
		this.add_fields (vfields);

		Gee.Collection<Vala.Constant> vconstants = this.vstruct.get_constants();
		this.constants = new Gee.ArrayList<Constant> ();
		this.add_constants (vconstants);

		Gee.Collection<Vala.Method> vmethods = this.vstruct.get_methods ();
		this.construction_methods = new Gee.ArrayList<Method>();
		this.add_methods_and_construction_methods (vmethods);
	}

	protected Struct? base_type {
		protected set;
		get;
	}

	public string? get_cname () {
		return this.vstruct.get_cname();
	}

	protected Gee.ArrayList<TypeParameter> template_param_lst {
		set;
		get;
	}

	protected Gee.ArrayList<Method> methods {
		set;
		get;
	}

	protected Gee.ArrayList<Field> fields {
		set;
		get;
	}

	protected Gee.ArrayList<Method> construction_methods {
		set;
		get;
	}

	protected Gee.ArrayList<Constant> constants {
		set;
		get;
	}

	internal override DocumentedElement? search_element_vala ( Gee.ArrayList<Vala.Symbol> params, int pos ) {
		Vala.Symbol velement = params[pos];

		if ( velement is Vala.Struct == false )
			return null;

		if ( this.is_vstruct ( (Vala.Struct)velement ) == false )
			return null;

		if ( params.size == pos+1 )
			return this;

		velement = params[pos+1];

		DocumentedElement? element = null;

		if ( velement is Vala.Field ) {
			element = this.search_field_vala ( params, pos );
		}
		else if ( velement is Vala.CreationMethod ) {
			element = this.search_construction_method_vala ( params, pos );
		}
		else if ( velement is Vala.Method ) {
			element = this.search_method_vala ( params, pos );
		}
		else if ( velement is Vala.Constant ) {
			element = this.search_constant_vala ( params, pos );
		}

		return element;
	}

	internal override DocumentedElement? search_element ( string[] params, int pos ) {
		if ( this.name != params[pos] )
			return null;

		if ( params[pos] == this.name && params[pos+1] == null )
			return this;

		DocumentedElement? element = this.search_field ( params, pos );
		if ( element != null )
			return element;

		element = this.search_method ( params, pos );
		if ( element != null )
			return element;

		element = this.search_constant ( params, pos );
		if ( element != null )
			return element;

		return this.search_construction_method ( params, pos );
	}

	internal bool is_vstruct ( Vala.Struct vstru ) {
		return ( this.vstruct == vstru );
	}

	public void visit ( Doclet doclet ) {
		if ( !this.is_visitor_accessible ( ) )
			return ;

		doclet.visit_struct (this);
	}

	public void write (Langlet langlet, void* ptr) {
		langlet.write_struct (this, ptr);
	}

	internal void parse_comments (Valadoc.Parser docparser) {
		if (this.documentation != null)
			return ;

		if (this.vcomment != null) {
			if ( docparser.is_inherit_doc (this) && this.base_type != null) {
				((Valadoc.Struct)this.base_type).parse_comments (docparser);
				this.documentation = this.base_type.documentation;
			}
			else {
				this.parse_comment_helper (docparser);
			}
		}

		this.parse_construction_method_comments (docparser);
		this.parse_constant_comments (docparser);
		this.parse_method_comments (docparser);
		this.parse_field_comments (docparser);
	}

	private void set_parent_references ( ) {
		Vala.ValueType? basetype = (Vala.ValueType?)this.vstruct.base_type;
		if (basetype == null)
			return ;

		this.base_type = (Struct?)this.head.search_vala_symbol ( (Vala.Struct)basetype.type_symbol );
	}

	internal void set_type_references ( ) {
		this.set_template_parameter_list_references ( );
		this.set_construction_method_references ( );
		this.set_constant_type_references ( );
		this.set_method_type_references ( );
		this.set_field_type_references ( );
		this.set_parent_references ( );
	}
}

