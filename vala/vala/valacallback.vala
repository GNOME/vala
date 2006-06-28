/* valacallback.vala
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
	public class Callback : DataType {
		public TypeReference return_type { get; set; }
		private List<FormalParameter> parameters;
		
		public static ref Callback new (string! name, TypeReference return_type, SourceReference source) {
			return (new Callback (name = name, return_type = return_type, source_reference = source));
		}
		
		public void add_parameter (FormalParameter! param) {
			parameters.append (param);
		}
		
		public ref List<FormalParameter> get_parameters () {
			return parameters.copy ();
		}
		
		public override void accept (CodeVisitor! visitor) {
			visitor.visit_begin_callback (this);
			
			return_type.accept (visitor);
			
			foreach (FormalParameter! param in parameters) {
				param.accept (visitor);
			}

			visitor.visit_end_callback (this);
		}

		private string cname;
		public override string! get_cname () {
			if (cname == null) {
				cname = "%s%s".printf (@namespace.get_cprefix (), name);
			}
			return cname;
		}

		public override bool is_reference_type () {
			return true;
		}
		
		public override string get_ref_function () {
			return "";
		}
		
		public override string get_free_function () {
			return "";
		}
	}
}
