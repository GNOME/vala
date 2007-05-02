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

/**
 * Represents a writer to write C source files.
 */
public class Vala.CCodeWriter {
	/**
	 * Specifies the file to be written.
	 */
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

	/**
	 * Specifies whether the output stream is at the beginning of a line.
	 */
	public bool bol {
		get {
			return _bol;
		}
	}
	
	private string _filename;
	private string temp_filename;
	private bool file_exists;

	private File stream;
	
	private int indent;

	/* at begin of line */
	private bool _bol = true;
	
	public CCodeWriter (string! _filename) {
		filename = _filename;
	}
	
	/**
	 * Closes the file.
	 */
	public void close () {
		stream = null;
		
		if (file_exists) {
			var changed = true;
		
			var old_file = new MappedFile (_filename, false, null);
			var new_file = new MappedFile (temp_filename, false, null);
			var len = old_file.get_length ();
			if (len == new_file.get_length ()) {
				if (Memory.cmp (old_file.get_contents (), new_file.get_contents (), len) == 0) {
					changed = false;
				}
			}
			old_file = null;
			new_file = null;
			
			if (changed) {
				File.rename (temp_filename, _filename);
			} else {
				File.unlink (temp_filename);
			}
		}
	}
	
	/**
	 * Writes tabs according to the current indent level.
	 */
	public void write_indent () {
		int i;
		
		if (!bol) {
			stream.putc ('\n');
		}
		
		for (i = 0; i < indent; i++) {
			stream.putc ('\t');
		}
		
		_bol = false;
	}
	
	/**
	 * Writes the specified string.
	 *
	 * @param s a string
	 */
	public void write_string (string! s) {
		stream.printf ("%s", s);
		_bol = false;
	}
	
	/**
	 * Writes a newline.
	 */
	public void write_newline () {
		stream.putc ('\n');
		_bol = true;
	}
	
	/**
	 * Opens a new block, increasing the indent level.
	 */
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
	
	/**
	 * Closes the current block, decreasing the indent level.
	 */
	public void write_end_block () {
		assert (indent > 0);
		
		indent--;
		write_indent ();
		stream.printf ("}");
	}
	
	/**
	 * Writes the specified text as comment.
	 *
	 * @param text the comment text
	 */
	public void write_comment (string! text) {
		write_indent ();
		stream.printf ("/*");
		bool first = true;
		
		/* separate declaration due to missing memory management in foreach statements */
		var lines = text.split ("\n");
		
		foreach (string line in lines) {
			if (!first) {
				write_indent ();
			} else {
				first = false;
			}
			stream.printf ("%s", line);
		}
		stream.printf ("*/");
		write_newline ();
	}
}
