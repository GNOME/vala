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
		string# comment;
		
		public void parse (CodeContext context) {
			context.accept (this);
		}
	
		public override void visit_source_file (SourceFile source_file) {
			parse_file (source_file);
		}
		
		public void push_comment (string comment_item) {
			if (comment == null) {
				comment = comment_item;
			} else {
				comment = "%s\n%s".printf (comment, comment_item);
			}
		}
		
		public string# pop_comment () {
			string# result = comment;
			comment = null;
			return result;
		}
		
		[Import ()]
		public void parse_file (SourceFile source_file);
	}
}
