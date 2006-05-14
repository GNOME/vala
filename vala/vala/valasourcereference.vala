/* valasourcereference.vala
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

namespace Vala {
	public class SourceReference {
		public readonly SourceFile file;
		public readonly int first_line;
		public readonly int first_column;
		public readonly int last_line;
		public readonly int last_column;
		public readonly string# comment;
		
		public static SourceReference# new (SourceFile file, int first_line, int first_column, int last_line, int last_column) {
			return (new SourceReference (file = file, first_line = first_line, first_column = first_column, last_line = last_line, last_column = last_column));
		}
		
		public static SourceReference# new_with_comment (SourceFile file, int first_line, int first_column, int last_line, int last_column, string comment) {
			return (new SourceReference (file = file, first_line = first_line, first_column = first_column, last_line = last_line, last_column = last_column, comment = comment));
		}
		
		public string to_string () {
			return ("%s:%d.%d-%d.%d".printf (file.filename, first_line, first_column, last_line, last_column));
		}
	}
}
