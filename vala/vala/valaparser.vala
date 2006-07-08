/* valaparser.vala
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
	public class Parser : CodeVisitor {
		string comment;
		string _file_comment;
		
		public void parse (CodeContext! context) {
			context.accept (this);
		}
	
		public override void visit_begin_source_file (SourceFile! source_file) {
			parse_file (source_file);
			source_file.comment = _file_comment;
		}
		
		public void push_comment (string! comment_item, bool file_comment) {
			if (comment == null) {
				comment = comment_item;
			} else {
				comment = "%s\n%s".printf (comment, comment_item);
			}
			if (file_comment) {
				_file_comment = comment;
				comment = null;
			}
		}
		
		public ref string pop_comment () {
			if (comment == null) {
				return null;
			}
			
			String result = String.new (comment);
			comment = null;
			
			string index;
			while ((index = result.str.chr (-1, '\t')) != null) {
				result.erase (result.str.pointer_to_offset (index), 1);
			}
			
			return result.str;
		}
		
		[Import ()]
		public void parse_file (SourceFile! source_file);
	}
}
