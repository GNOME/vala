/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2009 Florian Brosch
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
using Gee;

public abstract class Valadoc.Html.ApiWriter {
	protected Attribute csskeyword = new Attribute ("class", "apikeyword");
	protected Attribute cssformalparam = new Attribute ("class", "apiformalparameter");
	protected Attribute cssparamlist = new Attribute ("class", "apiparameterlist");
	protected Attribute cssexclist = new Attribute ("class", "apiexceptionlist");
	protected Attribute cssapi = new Attribute ("class", "api");
	protected Attribute csstype = new Attribute ("class", "apitype");
	protected Attribute cssbasictype = new Attribute ("class", "apibasictype");
	protected Attribute csslink = new Attribute ("class", "apilink");
	protected Attribute cssoptparamlist = new Attribute ("class", "apioptparameterlist");
	protected Attribute cssparentlist = new Attribute ("class", "parentlist");

	public abstract Div from_method (Method m);
	public abstract Div from_delegate (Delegate del);
	public abstract Div from_signal (Signal sig);
	public abstract Div from_field (Field field);
	public abstract Div from_constant (Constant c);
	public abstract Div from_namespace (Namespace ns);
	public abstract Div from_enum (Enum en);
	public abstract Div from_errordomain (ErrorDomain err);
	public abstract Div from_enumvalue (EnumValue env);
	public abstract Div from_errorcode (ErrorCode errc);
	public abstract Div from_struct (Struct stru);
	public abstract Div from_class (Class cl);
	public abstract Div from_interface (Interface iface);
	public abstract Div from_property (Property prop);

	public Div from_documented_element (Api.Node el) {
		if (el is Method) {
			return this.from_method ((Method)el);
		}
		else if (el is Delegate) {
			return this.from_delegate ((Delegate)el);
		}
		else if (el is Signal) {
			return this.from_signal ((Signal)el);
		}
		else if (el is Field) {
			return this.from_field ((Field)el);
		}
		else if (el is Constant) {
			return this.from_constant ((Constant)el);
		}
		else if (el is Namespace) {
			return this.from_namespace ((Namespace)el);
		}
		else if (el is Enum) {
			return this.from_enum ((Enum)el);
		}
		else if (el is ErrorDomain) {
			return this.from_errordomain ((ErrorDomain)el);
		}
		else if (el is EnumValue) {
			return this.from_enumvalue ((EnumValue)el);
		}
		else if (el is ErrorCode) {
			return this.from_errorcode ((ErrorCode)el);
		}
		else if (el is Struct) {
			return this.from_struct ((Struct)el);
		}
		else if (el is Class) {
			return this.from_class ((Class)el);
		}
		else if (el is Interface) {
			return this.from_interface ((Interface)el);
		}
		else {
			return this.from_property ((Property)el);
		}
	}
}


