struct Foo {
	int i;

	public Foo (string s) {
	}
}

void main () {
	var foo = Foo ("hello" + 42.to_string ());
}
