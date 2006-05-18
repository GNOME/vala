/* valaccodeunaryexpression.vala
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
	public class CCodeUnaryExpression : CCodeExpression {
		public CCodeUnaryOperator operator { get; construct; }
		public CCodeExpression inner { get; construct; }
		
		public override void write (CCodeWriter writer) {
			if (operator == CCodeUnaryOperator.PLUS) {
				writer.write_string ("+");
			} else if (operator == CCodeUnaryOperator.MINUS) {
				writer.write_string ("-");
			} else if (operator == CCodeUnaryOperator.LOGICAL_NEGATION) {
				writer.write_string ("!");
			} else if (operator == CCodeUnaryOperator.BITWISE_COMPLEMENT) {
				writer.write_string ("~");
			} else if (operator == CCodeUnaryOperator.ADDRESS_OF) {
				writer.write_string ("&");
			}

			inner.write (writer);
		}
	}
	
	public enum CCodeUnaryOperator {
		PLUS,
		MINUS,
		LOGICAL_NEGATION,
		BITWISE_COMPLEMENT,
		ADDRESS_OF
	}
}
