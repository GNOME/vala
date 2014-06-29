public enum Foo {
	BAR
}

void main () {
	int? a = null;
	int b = 1;
	assert (a != b);
	assert (b != a);

	Foo? f = null;
	Foo g = Foo.BAR;
	assert (f != g);
	assert (g != f);
}
