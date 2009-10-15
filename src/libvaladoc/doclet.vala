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


public static delegate Type Valadoc.DocletRegisterFunction ( );


public abstract class Valadoc.Doclet : GLib.Object {
	public abstract void initialisation (Settings settings, Tree tree);
	public abstract void visit_package (Package pkg);
	public abstract void visit_namespace (Namespace ns);
	public abstract void visit_interface (Interface iface);
	public abstract void visit_class (Class cl);
	public abstract void visit_struct (Struct stru);
	public abstract void visit_error_domain (ErrorDomain errdom);
	public abstract void visit_enum (Enum en);
	public abstract void visit_property (Property prop);
	public abstract void visit_field (Field field, FieldHandler parent);
	public abstract void visit_constant (Constant constant, ConstantHandler parent);
	public abstract void visit_error_code (ErrorCode errcode);
	public abstract void visit_enum_value (EnumValue enval);
	public abstract void visit_delegate (Delegate del);
	public abstract void visit_signal (Signal sig);
	public abstract void visit_method (Method m, Valadoc.MethodHandler parent);
}

