/* valaparser.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

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

/**
 * Code visitor parsing all Vala source files.
 */
public class Vala.Parser : CodeVisitor {
	private string comment;
	private string _file_comment;
	
	/**
	 * Parse all source files in the specified code context and build a
	 * code tree.
	 *
	 * @param context a code context
	 */
	public void parse (CodeContext! context) {
		context.accept (this);
	}

	public override void visit_source_file (SourceFile! source_file) {
		if (source_file.filename.has_suffix (".vala") || source_file.filename.has_suffix (".vapi")) {
			parse_file (source_file);
			source_file.comment = _file_comment;
		}

		_file_comment = null;
	}

	/**
	 * Adds the specified comment to the comment stack.
	 *
	 * @param comment_item a comment string
	 * @param file_comment true if file header comment, false otherwise
	 */
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
	
	/**
	 * Clears and returns the content of the comment stack.
	 *
	 * @return saved comment
	 */
	public string pop_comment () {
		if (comment == null) {
			return null;
		}
		
		String result = new String (comment);
		comment = null;
		
		weak string index;
		while ((index = result.str.chr (-1, '\t')) != null) {
			result.erase (result.str.pointer_to_offset (index), 1);
		}
		
		return result.str;
	}
	
	[Import ()]
	public void parse_file (SourceFile! source_file);
}
