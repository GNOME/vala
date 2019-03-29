enum Foo {
	FOO,
	BAR,
	MANAM
}

Foo foo () {
	Foo foo = Foo.BAR;

	switch (foo) {
	case Foo.FOO:
	case Foo.BAR:
		break;
	}

	return foo;
}

void main () {
	assert (foo () == Foo.BAR);
}
