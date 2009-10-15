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

using Gee;


// deprecated
public abstract class Valadoc.Langlet : Object {
	public abstract void write_pointer (Pointer param, void* ptr, Api.Node pos);
	public abstract void write_array (Array param, void* ptr, Api.Node pos);
	public abstract void write_type_parameter (TypeParameter param, void* ptr);
	public abstract void write_template_parameters (TemplateParameterListHandler thandler, void* ptr);
	public abstract void write_inheritance_list (Api.Node dtype, void* ptr);
	public abstract void write_parameter_list (ParameterListHandler thandler, void* ptr);
	public abstract void write_field (Valadoc.Field field, Valadoc.FieldHandler pos, void* ptr);
	public abstract void write_constant (Valadoc.Constant constant, Valadoc.ConstantHandler parent, void* ptr);
	public abstract void write_type_reference (Valadoc.TypeReference tref, void* ptr);
	public abstract void write_formal_parameter (Valadoc.FormalParameter param, void* ptr);
	public abstract void write_property_accessor (Valadoc.PropertyAccessor propac, void* ptr);
	public abstract void write_property (Valadoc.Property prop, void* ptr);
	public abstract void write_signal (Valadoc.Signal sig, void* ptr);
	public abstract void write_method (void* ptr, Valadoc.Method m, Valadoc.MethodHandler pos);
	public abstract void write_error_domain (Valadoc.ErrorDomain errdom, void* ptr);
	public abstract void write_error_code (Valadoc.ErrorCode errcode, void* ptr);
	public abstract void write_enum_value (Valadoc.EnumValue enval, void* ptr);
	public abstract void write_delegate (Valadoc.Delegate del, void* ptr);
	public abstract void write_class (Valadoc.Class cl, void* ptr);
	public abstract void write_enum (Valadoc.Enum en, void* ptr);
	public abstract void write_struct (Valadoc.Struct stru, void* ptr);
	public abstract void write_interface (Valadoc.Interface iface, void* ptr);
	public abstract void write_namespace (Valadoc.Namespace ns, void* ptr);
	public abstract void write_file (Valadoc.Package file, void* ptr);
}


