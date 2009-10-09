struct Foo {
	int bar;
	string baz;

	public Foo (int bar, string baz) {
		this.bar = bar;
		this.baz = baz;
	}
}

void main () {
	Foo a = Foo (42, "hello");
	Foo b = Foo (42, "hello");
	Foo? c = Foo (42, "hello");
	Foo d = Foo (42, "world");
	Foo e = Foo (23, "hello");

	assert (a == b);
	assert (a == c);
	assert (a != d);
	assert (a != e);
}

