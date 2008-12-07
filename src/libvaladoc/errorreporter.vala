


public class Valadoc.ErrorReporter : Object {
	private int _warnings = 0;
	private int _errors = 0;

	public int errors {
		get {
			return this._errors;
		}
	}

	public int warnings {
		get {
			return this._warnings;
		}
	}

	private enum ErrorType {
		WARNING,
		ERROR
	}

	private inline void msg ( ErrorType type, string file, int line, int startpos, int endpos, string errline, string msg ) {
		stdout.printf ( "%s:%d.%d-%d.%d: %s: %s\n", file, line, startpos, line, endpos, (type == ErrorType.ERROR)? "error" : "warning", msg );
		stdout.printf ( "\t%s\n", errline );
		stdout.printf ( "\t%s%s\n", string.nfill ((uint)startpos, ' '), string.nfill( (uint)(endpos-startpos), '^' ) );
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

