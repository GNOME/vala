class Foo : Object {
	public string bar {
		owned get {
			try {
				return manam ();
			} catch (Error e) {
				assert_not_reached ();
			}
		}
	}
}

string manam () throws Error {
	return "manam";
}

void main () {
	var foo = new Foo ();
	assert (foo.bar == "manam");
}
