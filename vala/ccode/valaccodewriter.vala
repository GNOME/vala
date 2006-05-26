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
		string _filename;
		string temp_filename;
		bool file_exists;
		public string filename {
			get {
				return _filename;
			}
			construct {
				_filename = value;
				file_exists = File.test (_filename, FileTest.EXISTS);
				if (file_exists) {
					temp_filename = "%s.valatmp".printf (_filename);
					stream = File.open (temp_filename, "w");
				} else {
					stream = File.open (_filename, "w");
				}
			}
		}
		
		File stream;
		
		int indent;
		/* at begin of line */
		public bool bol = true;
		
		public void close () {
			stream.close ();
			
			if (file_exists) {
				var changed = true;
			
				var old_file = MappedFile.new (_filename, false, null);
				var new_file = MappedFile.new (temp_filename, false, null);
				var len = old_file.get_length ();
				if (len == new_file.get_length ()) {
					if (Memory.cmp (old_file.get_contents (), new_file.get_contents (), len) == 0) {
						changed = false;
					}
				}
				old_file.free ();
				new_file.free ();
				
				if (changed) {
					File.rename (temp_filename, _filename);
				} else {
					File.unlink (temp_filename);
				}
			}
		}
		
		public void write_indent () {
			int i;
			
			if (!bol) {
				stream.putc ('\n');
			}
			
			for (i = 0; i < indent; i++) {
				stream.putc ('\t');
			}
			
			bol = false;
		}
		
		public void write_string (string s) {
			stream.printf ("%s", s);
			bol = false;
		}
		
		public void write_newline () {
			stream.putc ('\n');
			bol = true;
		}
		
		public void write_begin_block () {
			if (!bol) {
				stream.putc (' ');
			} else {
				write_indent ();
			}
			stream.putc ('{');
			write_newline ();
			indent++;
		}
		
		public void write_end_block () {
			indent--;
			write_indent ();
			stream.printf ("}");
		}
		
		public void write_comment (string text) {
			write_indent ();
			stream.printf ("/*%s*/", text);
			write_newline ();
		}
	}
}
