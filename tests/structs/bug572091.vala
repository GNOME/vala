struct Foo {
	public int bar;
}

void baz (Foo foo) {
	foo.bar = 2;
}

void main() {
	var foo = Foo () { bar = 1 };
	baz (foo);
	assert (foo.bar == 1);
}
