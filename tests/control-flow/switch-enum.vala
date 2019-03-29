enum Foo {
	FOO,
	BAR,
	MANAM
}

Foo foo () {
	Foo foo = Foo.BAR;

	switch (foo) {
	case Foo.MANAM:
	case Foo.FOO:
	case Foo.BAR:
		return foo;
	}
}

void main () {
	assert (foo () == Foo.BAR);
}
