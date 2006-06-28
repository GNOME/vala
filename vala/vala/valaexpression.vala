/* valaexpression.vala
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
	public abstract class Expression : CodeNode {
		/* filled by semantic analyzer, used by semantic analyzer,
		 * memory manager and code generator
		 */
		public TypeReference static_type { get; set; }
		
		/* filled by semantic analyzer, used by lambda expressions in
		 * semantic analyzer
		 */
		public TypeReference expected_type { get; set; }
		
		public Symbol symbol_reference { get; set; }
		
		/* set by memory manager, used by code generator */
		public bool ref_leaked { get; set; }
		public bool ref_missing { get; set; }
		
		/* set and used by code generator */
		public List<VariableDeclarator> temp_vars;
	}
}
