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


public interface Valadoc.ParameterListHandler : Basic {
	protected abstract Gee.ArrayList<FormalParameter> param_list {
		protected set;
		get;
	}

	public Gee.Collection<FormalParameter> get_parameter_list ( ) {
		return this.param_list.read_only_view;
	}

	protected void add_parameter_list ( Gee.Collection<Vala.FormalParameter> vparams ) {
		foreach ( Vala.FormalParameter vfparam in vparams ) {
			var tmp = new FormalParameter ( this.settings, vfparam, this, this.head );
			this.param_list.add ( tmp );
		}
	}

	internal void set_parameter_list_type_references ( ) {
		foreach ( FormalParameter fparam in this.param_list ) {
			fparam.set_type_references ( );
		}
	}
}

