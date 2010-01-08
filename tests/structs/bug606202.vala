struct Foo {
	string s;

	public Foo (string s) {
		this.s = s;
	}
}

class Bar : Object {
	public Foo? foo { get; set; }
}

void main () {
	var bar = new Bar ();
	var foo = Foo ("hello");
	bar.foo = foo;
	assert (bar.foo.s == "hello");
}
