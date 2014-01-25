struct Foo {
	int x;

	public void meth () {
		x = 10;
	}
}

void main () {
	Foo foo = Foo ();
	Foo* bar = &foo;
	bar.meth ();
	assert (foo.x == 10);
}
