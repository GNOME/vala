enum Foo {
	BAR,
	MANAM
}

void main () {
	var foo = Foo.MANAM;

	switch (foo) {
	case Foo.BAR:
		assert_not_reached ();
		break;
	case Foo.MANAM:
		break;
	default:
		assert_not_reached ();
	}
}
