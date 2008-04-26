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

using GLib;


public class Valadoc.Langlet : Object {
	public signal void puts_keyword ( void* ptr, string str );
	public signal void puts ( void* ptr, string str );

	public virtual void write_type_parameter ( TypeParameter param, void* ptr ) {
	}

	public virtual void write_template_parameters ( TemplateParameterListHandler thandler, void* ptr ) {
	}

	public void write_parent_type_list ( Valadoc.ContainerDataType dtype, void* ptr ) {
	}

	public virtual void write_parameter_list ( ParameterListHandler thandler, void* ptr ) {
	}

	public virtual void write_field ( Valadoc.Field field, Valadoc.FieldHandler parent, void* ptr ) {
	}

	public virtual void write_type_reference ( Valadoc.TypeReference tref, void* ptr ) {
	}

	public virtual void write_formal_parameter ( Valadoc.FormalParameter param, void* ptr ) {
	}

	public virtual void write_property_accessor ( Valadoc.PropertyAccessor propac, void* ptr ) {
	}

	public virtual void write_property ( Valadoc.Property prop, void* ptr ) {
	}

	public virtual void write_signal ( Valadoc.Signal sig, void* ptr ) {
	}

	public virtual void write_method ( void* ptr, weak Valadoc.Method m, Valadoc.MethodHandler parent ) {
	}

	public virtual void write_error_domain ( Valadoc.ErrorDomain errdom, void* ptr ) {
	}

	public virtual void write_error_code ( Valadoc.ErrorCode errcode, void* ptr ) {
	}

	public virtual void write_enum_value ( Valadoc.EnumValue enval, void* ptr ) {
	}

	public virtual void write_delegate ( Valadoc.Delegate del, void* ptr ) {
	}

	public virtual void write_class ( Valadoc.Class cl, void* ptr ) {
	}

	public virtual void write_enum ( Valadoc.Enum en, void* ptr ) {
	}

	public virtual void write_struct ( Valadoc.Struct stru, void* ptr ) {
	}

	public virtual void write_interface ( Valadoc.Interface iface, void* ptr ) {
	}

	public virtual void write_namespace ( Valadoc.Namespace ns, void* ptr ) {
	}

	public virtual void write_file ( Valadoc.File file, void* ptr ) {
	}
}


