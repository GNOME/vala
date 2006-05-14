/* valaccodewriter.vala
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
	public class CCodeWriter {
		public readonly File# stream;
		
		int indent;
		
		public void close () {
			stream.close ();
		}
		
		public void write_indent () {
			int i;
			for (i = 0; i < indent; i++) {
				stream.putc ('\t');
			}
		}
		
		public void write_string (string s) {
			stream.printf ("%s", s);
		}
		
		public void write_begin_block () {
			stream.printf (" {\n");
			indent++;
		}
		
		public void write_end_block () {
			indent--;
			write_indent ();
			stream.printf ("}");
		}
		
		public void write_comment (string text) {
			stream.printf ("/*%s*/", text);
		}
	}
}
