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

using Valadoc;
using GLib;



public class Valadoc.Doclet : Object {
	public Doclet ( construct Langlet langlet, construct Settings settings ) {
	}

	public virtual void initialisation (  ) {
	}

	protected Langlet langlet {
		construct set;
		get;
	}

	protected Settings settings {
		construct set;
		get;
	}

	public virtual void file_block_start ( ) {
	}

	public virtual void file_block_end ( ) {
	}

	public virtual void namespace_block_start ( ) {
	}

	public virtual void namespace_block_end ( ) {
	}

	public virtual void global_field_block_start ( Gee.Collection<Valadoc.Field> fields ) {
	}

	public virtual void global_field_block_end ( Gee.Collection<Valadoc.Field> fields ) {
	}

	public virtual void global_method_block_start ( Gee.Collection<Valadoc.Method> methods ) {
	}

	public virtual void global_method_block_end ( Gee.Collection<Valadoc.Method> methods ) {
	}

	public virtual void method_block_start ( Gee.Collection<Valadoc.Method> methods ) {
	}

	public virtual void method_block_end ( Gee.Collection<Valadoc.Method> methods ) {
	}

	public virtual void field_block_start ( Gee.Collection<Valadoc.Field> fields ) {
	}

	public virtual void field_block_end ( Gee.Collection<Valadoc.Field> fields ) {
	}

	public virtual void enum_value_block_start ( Gee.Collection<Valadoc.EnumValue> envals ) {
	}

	public virtual void enum_value_block_end ( Gee.Collection<Valadoc.EnumValue> envals ) {
	}

	public virtual void delegate_block_start ( Gee.Collection<Valadoc.Delegate> delegates ) {
	}

	public virtual void delegate_block_end ( Gee.Collection<Valadoc.Delegate> delegates ) {
	}

	public virtual void enum_block_start ( Gee.Collection<Valadoc.Enum> enums ) {
	}

	public virtual void enum_block_end ( Gee.Collection<Valadoc.Enum> enums ) {
	}

	public virtual void interface_block_start ( Gee.Collection<Valadoc.Interface> ifaces ) {
	}

	public virtual void interface_block_end ( Gee.Collection<Valadoc.Interface> ifaces ) {
	}

	public virtual void class_block_start ( Gee.Collection<Valadoc.Class> classes ) {
	}

	public virtual void class_block_end ( Gee.Collection<Valadoc.Class> classes ) {
	}

	public virtual void struct_block_start ( Gee.Collection<Valadoc.Struct> structs ) {
	}

	public virtual void struct_block_end ( Gee.Collection<Valadoc.Struct> structs ) {
	}

	public virtual void construction_method_block_start ( Gee.Collection<Valadoc.Method> methods ) {
	}

	public virtual void construction_method_block_end ( Gee.Collection<Valadoc.Method> methods ) {
	}

	public virtual void signal_block_start ( Gee.Collection<Valadoc.Signal> signals ) {
	}

	public virtual void signal_block_end ( Gee.Collection<Valadoc.Signal> signals ) {
	}

	public virtual void property_block_start ( Gee.Collection<Valadoc.Property> properties ) {
	}

	public virtual void property_block_end ( Gee.Collection<Valadoc.Property> properties ) {
	}

	public virtual void file_start ( File file ) {
	}

	public virtual void file_end ( File file ) {
	}

	public virtual void namespace_start ( Namespace ns ) {
	}

	public virtual void namespace_end ( Namespace ns ) {
	}

	public virtual void interface_start ( Interface iface ) {
	}

	public virtual void interface_end ( Interface iface ) {
	}

	public virtual void class_start ( Class cl ) {
	}

	public virtual void class_end ( Class cl ) {
	}

	public virtual void struct_start ( Struct stru ) {
	}

	public virtual void struct_end ( Struct stru ) {
	}

	public virtual void enum_start ( Enum en ) {
	}

	public virtual void enum_end ( Enum en ) {
	}

	public virtual void property ( Property prop ) {
	}

	public virtual void field ( Field field, FieldHandler parent ) {
	}

	public virtual void enum_value ( EnumValue enval ) {
	}

	public virtual void _delegate ( Delegate del ) {
	}

	public virtual void _signal ( Signal sig ) {
	}

	public virtual void method ( Method m, Valadoc.MethodHandler parent ) {
	}
}

