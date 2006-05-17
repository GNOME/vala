/* valaobjectcreationexpression.vala
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
	public class ObjectCreationExpression : Expression {
		public readonly ref TypeReference type_reference;
		public readonly ref List<ref NamedArgument> named_argument_list;
		public readonly ref SourceReference source_reference;

		public static ref ObjectCreationExpression new (TypeReference type, List<NamedArgument> named_argument_list, SourceReference source) {
			return (new ObjectCreationExpression (type_reference = type, named_argument_list = named_argument_list, source_reference = source));
		}
		
		public override void accept (CodeVisitor visitor) {
			type_reference.accept (visitor);
			
			foreach (NamedArgument arg in named_argument_list) {
				arg.accept (visitor);
			}
		
			visitor.visit_object_creation_expression (this);
		}
	}
}
