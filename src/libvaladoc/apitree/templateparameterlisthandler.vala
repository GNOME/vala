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


public interface Valadoc.TemplateParameterListHandler : Basic {
	protected abstract Gee.ArrayList<TypeParameter> template_param_lst {
		set;
		get;
	}

	public TypeParameter? find_vtemplateparameter ( Vala.GenericType vttype ) {
		foreach ( TypeParameter tparam in this.template_param_lst ) {
			if ( tparam.is_vtypeparam ( vttype.type_parameter ) )
				return tparam;
		}

		if ( this.parent is TemplateParameterListHandler )
			return ((TemplateParameterListHandler)this.parent).find_vtemplateparameter ( vttype );

		return null;
	}

	public Gee.ReadOnlyCollection<TypeParameter> get_template_param_list ( ) {
		return new Gee.ReadOnlyCollection<TypeParameter> ( this.template_param_lst );
	} 

	internal void set_template_parameter_list ( Gee.Collection<Vala.TypeParameter> vtparams ) {
		foreach ( Vala.TypeParameter vtparam in vtparams ) {
			var tmp = new TypeParameter ( this.settings, vtparam, this, this.head );
			this.template_param_lst.add ( tmp );
		}
	}

	internal void set_template_parameter_list_references ( ) {
		foreach ( TypeParameter tparam in this.template_param_lst ) {
			tparam.set_type_reference ( );
		}
	}
}

