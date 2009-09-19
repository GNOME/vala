/*
 * Valadoc - a documentation tool for vala.
 * Copyright (C) 2009 Florian Brosch
 * 
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */


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

	private inline void msg ( ErrorType type, string file, long line, long startpos, long endpos, string errline, string msg ) {
		this.stream.printf ( "%s:%lu.%lu-%lu.%lu: %s: %s\n", file, line, startpos, line, endpos, (type == ErrorType.ERROR)? "error" : "warning", msg );
		if (startpos <= endpos) {
			this.stream.printf ( "\t%s\n", errline );
			this.stream.printf ( "\t%s%s\n", string.nfill ((uint)startpos, ' '), string.nfill( (uint)(endpos-startpos), '^' ) );
		}
	}

	public void simple_warning ( string msg ) {
		this.stream.puts ( msg );
		this.stream.putc ( '\n' );
		this._warnings++;
	}

	public void simple_error ( string msg ) {
		this.stream.puts ( msg );
		this.stream.putc ( '\n' );
		this._errors++;
	}

	public void error ( string file, long line, long startpos, long endpos, string errline, string msg ) {
		this.msg ( ErrorType.ERROR, file, line, startpos, endpos, errline, msg );
		this._errors++;
	}

	public void warning ( string file, long line, long startpos, long endpos, string errline, string msg ) {
		this.msg ( ErrorType.WARNING, file, line, startpos, endpos, errline, msg );
		this._warnings++;
	}
}

