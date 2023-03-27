struct Foo {
	public unowned string s;
	public int i;
}

struct Bar {
	public Foo foo;
}

Bar bar = {{"foo", 42}};

void main () {
	assert (bar.foo.s == "foo");
	assert (bar.foo.i == 42);
}
