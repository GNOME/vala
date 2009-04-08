/* valaccodewriter.vala
 *
 * Copyright (C) 2006-2009  Jürg Billeter
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
 * Represents a writer to write C source files.
 */
public class Vala.CCodeWriter {
	/**
	 * Specifies the file to be written.
	 */
	public string filename { get; set; }

	/**
	 * Specifies whether to emit line directives.
	 */
	public bool line_directives { get; set; }

	/**
	 * Specifies whether the output stream is at the beginning of a line.
	 */
	public bool bol {
		get { return _bol; }
	}

	private string temp_filename;
	private bool file_exists;

	private FileStream stream;
	
	private int indent;
	private int current_line_number = 1;
	private bool using_line_directive;

	/* at begin of line */
	private bool _bol = true;
	
	public CCodeWriter (string filename) {
		this.filename = filename;
	}

	/**
	 * Opens the file.
	 *
	 * @return true if the file has been opened successfully,
	 *         false otherwise
	 */
	public bool open () {
		file_exists = FileUtils.test (filename, FileTest.EXISTS);
		if (file_exists) {
			temp_filename = "%s.valatmp".printf (filename);
			stream = FileStream.open (temp_filename, "w");
		} else {
			stream = FileStream.open (filename, "w");
		}

		return (stream != null);
	}

	/**
	 * Closes the file.
	 */
	public void close () {
		stream = null;
		
		if (file_exists) {
			var changed = true;

			try {
				var old_file = new MappedFile (filename, false);
				var new_file = new MappedFile (temp_filename, false);
				var len = old_file.get_length ();
				if (len == new_file.get_length ()) {
					if (Memory.cmp (old_file.get_contents (), new_file.get_contents (), len) == 0) {
						changed = false;
					}
				}
				old_file = null;
				new_file = null;
			} catch (FileError e) {
				// assume changed if mmap comparison doesn't work
			}
			
			if (changed) {
				FileUtils.rename (temp_filename, filename);
			} else {
				FileUtils.unlink (temp_filename);
			}
		}
	}
	
	/**
	 * Writes tabs according to the current indent level.
	 */
	public void write_indent (CCodeLineDirective? line = null) {
		if (line_directives) {
			if (line != null) {
				line.write (this);
				using_line_directive = true;
			} else if (using_line_directive) {
				// no corresponding Vala line, emit line directive for C line
				write_string ("#line %d \"%s\"".printf (current_line_number + 1, Path.get_basename (filename)));
				write_newline ();
				using_line_directive = false;
			}
		}

		if (!bol) {
			write_newline ();
		}
		
		for (int i = 0; i < indent; i++) {
			stream.putc ('\t');
		}
		
		_bol = false;
	}
	
	/**
	 * Writes the specified string.
	 *
	 * @param s a string
	 */
	public void write_string (string s) {
		stream.printf ("%s", s);
		_bol = false;
	}
	
	/**
	 * Writes a newline.
	 */
	public void write_newline () {
		stream.putc ('\n');
		current_line_number++;
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
	public void write_comment (string text) {
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
