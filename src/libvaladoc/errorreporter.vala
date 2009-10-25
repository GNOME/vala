/* errorreporter.vala
 *
 * Copyright (C) 2008-2009 Florian Brosch
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

public enum Valadoc.ErrorLevel {
	ASSUMPTION,
	WARNING,
	ERROR
}


public class Valadoc.ErrorReporter : Object {
	private int _warnings = 0;
	private int _errors = 0;

	public unowned GLib.FileStream stream {
		get; set;
	}

	public Vala.Report? vreporter {
		get; set;
	}

	public ErrorReporter () {
		this.stream = GLib.stderr;
	}

	public int errors {
		get {
			int verrors = (this.vreporter != null)? this.vreporter.get_errors () : 0;
			return this._errors + verrors;
		}
	}

	public int warnings {
		get {
			int vwarnings = (this.vreporter != null)? this.vreporter.get_warnings () : 0;
			return this._warnings + vwarnings;
		}
	}

	private enum ErrorType {
		WARNING,
		ERROR
	}

	private inline void msg (ErrorType type, string file, long line, long startpos, long endpos, string errline, string msg) {
		this.stream.printf ("%s:%lu.%lu-%lu.%lu: %s: %s\n", file, line, startpos, line, endpos, (type == ErrorType.ERROR)? "error" : "warning", msg);
		if (startpos <= endpos) {
			this.stream.printf ("%s\n", errline);
			for (int i = 0; i < errline.length; i++) {
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

	public void simple_warning (string msg) {
		this.stream.puts (msg);
		this.stream.putc ('\n');
		this._warnings++;
	}

	public void simple_error (string msg) {
		this.stream.puts (msg);
		this.stream.putc ('\n');
		this._errors++;
	}

	public void error (string file, long line, long startpos, long endpos, string errline, string msg) {
		this.msg (ErrorType.ERROR, file, line, startpos, endpos, errline, msg);
		this._errors++;
	}

	public void warning (string file, long line, long startpos, long endpos, string errline, string msg) {
		this.msg (ErrorType.WARNING, file, line, startpos, endpos, errline, msg);
		this._warnings++;
	}
}

