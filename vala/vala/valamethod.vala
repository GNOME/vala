/* valamethod.vala
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
	public class Method : CodeNode {
		public string name { get; construct; }
		public TypeReference return_type { get; construct; }
		public SourceReference source_reference { get; construct; }
		public weak CodeNode parent_type;
		ref Statement _body;
		public Statement body {
			get {
				return _body;
			}
			set {
				_body = value;
			}
		}
		public MemberAccessibility access;
		public bool instance = true;
		ref List<ref FormalParameter> parameters;
		
		public static ref Method new (string name, TypeReference return_type, SourceReference source) {
			return (new Method (name = name, return_type = return_type, source_reference = source));
		}
		
		public void add_parameter (FormalParameter param) {
			parameters.append (param);
		}
		
		public override void accept (CodeVisitor visitor) {
			visitor.visit_begin_method (this);
			
			return_type.accept (visitor);
			
			foreach (FormalParameter param in parameters) {
				param.accept (visitor);
			}
			
			if (body != null) {
				body.accept (visitor);
			}

			visitor.visit_end_method (this);
		}

		public string get_cname () {
		}
	}
}
