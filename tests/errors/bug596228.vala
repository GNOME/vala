struct Foo {
	Foo (int foo) {
		this.foo = foo;
	}

	int foo;
}

Foo get_foo () throws Error {
    return Foo (42);
}

void main () {
    var foo = get_foo ();
    assert (foo.foo == 42);
}
