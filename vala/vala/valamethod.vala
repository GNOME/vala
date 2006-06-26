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
		Statement _body;
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
		public bool is_abstract;
		public bool is_virtual;
		public bool is_override;
		public List<FormalParameter> parameters;
		public string cname;
		public bool returns_modified_pointer;
		public bool instance_last;
		
		/* reference must be weak as virtual methods set base_method to themselves */
		public weak Method base_method;
		
		public FormalParameter this_parameter;
		
		public static ref Method new (string name, TypeReference return_type, SourceReference source) {
			return (new Method (name = name, return_type = return_type, source_reference = source));
		}
		
		public void add_parameter (FormalParameter param) {
			parameters.append (param);
		}
		
		public ref List<FormalParameter> get_parameters () {
			return parameters.copy ();
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
			if (cname == null) {
				var parent = symbol.parent_symbol.node;
				if (parent is DataType) {
					cname = "%s_%s".printf (((DataType) parent).get_lower_case_cname (null), name);
				} else if (parent is Namespace) {
					cname = "%s%s".printf (((Namespace) parent).get_lower_case_cprefix (), name);
				} else {
					Report.error (source_reference, "method is neither in struct nor in namespace\n");
				}
			}
			return cname;
		}

		public ref string get_real_cname () {
			if (is_virtual || is_override) {
				var parent = (Class) symbol.parent_symbol.node;
				return "%s_real_%s".printf (parent.get_lower_case_cname (null), name);
			} else {
				return get_cname ();
			}
		}
		
		public void set_cname (string cname) {
			this.cname = cname;
		}
		
		void process_ccode_attribute (Attribute a) {
			foreach (NamedArgument arg in a.args) {
				if (arg.name == "cname") {
					/* this will already be checked during semantic analysis */
					if (arg.argument is LiteralExpression) {
						var lit = ((LiteralExpression) arg.argument).literal;
						if (lit is StringLiteral) {
							set_cname (((StringLiteral) lit).eval ());
						}
					}
				}
			}
		}
		
		public void process_attributes () {
			foreach (Attribute a in attributes) {
				if (a.name == "CCode") {
					process_ccode_attribute (a);
				} else if (a.name == "ReturnsModifiedPointer") {
					returns_modified_pointer = true;
				} else if (a.name == "InstanceLast") {
					instance_last = true;
				} else if (a.name == "FloatingReference") {
					return_type.floating_reference = true;
				}
			}
		}
	}
}
