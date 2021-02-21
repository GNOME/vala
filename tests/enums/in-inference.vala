[Flags]
enum Foo {
	FOO,
	BAR,
	MANAM;
}

void main () {
	Foo foo = FOO | BAR;
	if (MANAM in foo) {
		assert_not_reached ();
	}
	assert (BAR in foo);
}
