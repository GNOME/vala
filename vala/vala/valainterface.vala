/* valainterface.vala
 *
 * Copyright (C) 2006  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

namespace Vala {
	public class Interface : Type_ {
		List<string> type_parameters;
		public List<TypeReference> base_types;

		List<Method> methods;
		List<Property> properties;
		
		public static ref Interface new (string name, SourceReference source) {
			return (new Interface (name = name, source_reference = source));
		}

		public void add_type_parameter (TypeParameter p) {
			type_parameters.append (p);
			p.type = this;
		}

		public void add_base_type (TypeReference type) {
			base_types.append (type);
		}
		
		public void add_method (Method m) {
			return_if_fail (m.instance && m.is_abstract && !m.is_virtual && !m.is_override);
		
			methods.append (m);
		}
		
		public ref List<Method> get_methods () {
			return methods.copy ();
		}
		
		public void add_property (Property prop) {
			properties.append (prop);
		}
		
		public ref List<Property> get_properties () {
			return properties.copy ();
		}
		
		private string cname;
		private string lower_case_csuffix;
		
		public override string get_cname () {
			if (cname == null) {
				cname = "%s%s".printf (@namespace.get_cprefix (), name);
			}
			return cname;
		}
		
		public string get_lower_case_csuffix () {
			if (lower_case_csuffix == null) {
				lower_case_csuffix = Namespace.camel_case_to_lower_case (name);
			}
			return lower_case_csuffix;
		}
		
		public void set_lower_case_csuffix (string csuffix) {
			this.lower_case_csuffix = csuffix;
		}
		
		public override ref string get_lower_case_cname (string infix) {
			if (infix == null) {
				infix = "";
			}
			return "%s%s%s".printf (@namespace.get_lower_case_cprefix (), infix, get_lower_case_csuffix ());
		}
		
		public override ref string get_upper_case_cname (string infix) {
			return get_lower_case_cname (infix).up (-1);
		}
		
		public override void accept (CodeVisitor visitor) {
			visitor.visit_begin_interface (this);
			
			foreach (TypeReference type in base_types) {
				type.accept (visitor);
			}

			foreach (TypeParameter p in type_parameters) {
				p.accept (visitor);
			}
			
			foreach (Method m in methods) {
				m.accept (visitor);
			}
			
			foreach (Property prop in properties) {
				prop.accept (visitor);
			}

			visitor.visit_end_interface (this);
		}

		public override bool is_reference_type () {
			return true;
		}
	}
}
