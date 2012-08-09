/* errorreporter.vala
 *
 * Copyright (C) 2008-2011 Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Brosch Florian <flo.brosch@gmail.com>
 */

using Gee;


public class Valadoc.ErrorReporter : Object {
	private int _warnings = 0;
	private int _errors = 0;

	public int warnings_offset {
		get;
		set;
	}

	public int errors_offset {
		get;
		set;
	}

	public unowned GLib.FileStream stream {
		get;
		set;
	}

	public Settings? settings {
		get;
		set;
	}

	public int errors {
		get {
			return this._errors + errors_offset;
		}
	}

	public int warnings {
		get {
			return this._warnings + warnings_offset;
		}
	}


	public ErrorReporter (Settings? settings = null) {
		this.stream = GLib.stderr;
		this.settings = settings;
	}

	private inline void msg (string type, string file, long line, long startpos, long endpos, string errline, string msg_format, va_list args) {
		this.stream.printf ("%s:%lu.%lu-%lu.%lu: %s: ", file, line, startpos, line, endpos, type);
		this.stream.vprintf (msg_format, args);
		this.stream.putc ('\n');

		if (startpos <= endpos) {
			this.stream.printf ("%s\n", errline);
			for (int i = 0; i < errline.char_count ()+1; i++) {
				if (errline[i] == '\t') {
					this.stream.printf ("\t");
				} else if (i >= startpos - 1 && i < endpos - 1) {
					this.stream.printf ("^");
				} else {
					this.stream.printf (" ");
				}
			}
			this.stream.printf ("\n");
		}
	}

	public void simple_warning (string msg_format, ...) {
		var args = va_list();
		this.stream.vprintf (msg_format, args);
		this.stream.putc ('\n');
		this._warnings++;
	}

	public void simple_error (string msg_format, ...) {
		var args = va_list();
		this.stream.vprintf (msg_format, args);
		this.stream.putc ('\n');
		this._errors++;
	}

	public void simple_note (string msg_format, ...) {
		if (_settings == null || _settings.verbose) {
			var args = va_list();
			this.stream.vprintf (msg_format, args);
			this.stream.putc ('\n');
			this._warnings++;
		}
	}

	public void error (string file, long line, long startpos, long endpos, string errline, string msg_format, ...) {
		var args = va_list();
		this.msg ("error", file, line, startpos, endpos, errline, msg_format, args);
		this._errors++;
	}

	public void warning (string file, long line, long startpos, long endpos, string errline, string msg_format, ...) {
		var args = va_list();
		this.msg ("warning", file, line, startpos, endpos, errline, msg_format, args);
		this._warnings++;
	}
}

