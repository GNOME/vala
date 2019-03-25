class FooRegex : Regex {
	public FooRegex () throws RegexError {
		base ("^:*$");
	}
}

void main () {
	try {
		var foo = new FooRegex ();
	} catch {
	}
}
