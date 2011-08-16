struct Foo {
	int bar;
}

void baz (Foo foo) {
	foo.bar = 3;
}

void main () {
	Foo? foo = Foo ();
	baz (foo);
	assert (foo.bar == 0);
}
