class FooSource : Source {
	public override bool prepare (out int timeout) {
		timeout = 1000;
		return false;
	}

	public override bool check () {
		return false;
	}

	public override bool dispatch (SourceFunc? callback) {
		return false;
	}
}

void main () {
	var foo = new FooSource ();
}
