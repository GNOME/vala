/* valaccodemethod.vala
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
	public class CCodeMethod : CCodeNode {
		public readonly ref string name;
		public CCodeModifiers modifiers;
		public readonly ref string return_type;
		ref List<ref string> parameters;
		public ref CCodeBlock block;
		
		public void add_parameter (string type, string name) {
			parameters.append ("%s %s".printf (type, name));
		}
		
		public override void write (CCodeWriter writer) {
			if ((modifiers & CCodeModifiers.STATIC) == CCodeModifiers.STATIC) {
				writer.write_string ("static ");
			}
			writer.write_string (return_type);
			writer.write_string (" ");
			writer.write_string (name);
			writer.write_string (" (");
			foreach (string parameter in parameters) {
				writer.write_string (parameter);
			}
			writer.write_string (")");
			if (block == null) {
				writer.write_string (";\n");
			} else {
				block.write (writer);
			}
		}
	}
}
