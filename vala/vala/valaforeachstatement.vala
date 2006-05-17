/* valaforeachstatement.vala
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
	public class ForeachStatement : Statement {
		public readonly ref TypeReference type_reference;
		public readonly ref string variable_name;
		public readonly ref Expression collection;
		public readonly ref Statement body;
		public readonly ref SourceReference source_reference;

		public static ref ForeachStatement new (TypeReference type, string id, Expression col, Statement body, SourceReference source) {
			return (new ForeachStatement (type_reference = type, variable_name = id, collection = col, body = body, source_reference = source));
		}
		
		public override void accept (CodeVisitor visitor) {
			visitor.visit_begin_foreach_statement (this);

			type_reference.accept (visitor);
			collection.accept (visitor);
			body.accept (visitor);

			visitor.visit_end_foreach_statement (this);
		}
	}
}
