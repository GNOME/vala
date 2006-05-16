/* valaccodeifstatement.vala
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
	public class CCodeIfStatement : CCodeStatement {
		public readonly ref CCodeExpression condition;
		public readonly ref CCodeStatement true_statement;
		public readonly ref CCodeStatement false_statement;
		
		public override void write (CCodeWriter writer) {
			writer.write_indent ();
			writer.write_string ("if (");
			if (condition != null) {
				condition.write (writer);
			}
			writer.write_string (")");
			true_statement.write (writer);
			if (false_statement != null) {
				if (writer.bol) {
					writer.write_indent ();
					writer.write_string ("else ");
				} else {
					writer.write_string (" else ");
				}
				false_statement.write (writer);
			}
		}
	}
}
