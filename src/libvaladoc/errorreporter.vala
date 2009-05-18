


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

	private inline void msg ( ErrorType type, string file, int line, int startpos, int endpos, string errline, string msg ) {
		this.stream.printf ( "%s:%d.%d-%d.%d: %s: %s\n", file, line, startpos, line, endpos, (type == ErrorType.ERROR)? "error" : "warning", msg );
		this.stream.printf ( "\t%s\n", errline );
		this.stream.printf ( "\t%s%s\n", string.nfill ((uint)startpos, ' '), string.nfill( (uint)(endpos-startpos), '^' ) );
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

	public void error ( string file, int line, int startpos, int endpos, string errline, string msg ) {
		this.msg ( ErrorType.ERROR, file, line, startpos, endpos, errline, msg );
		this._errors++;
	}

	public void warning ( string file, int line, int startpos, int endpos, string errline, string msg ) {
		this.msg ( ErrorType.WARNING, file, line, startpos, endpos, errline, msg );
		this._warnings++;
	}
}

