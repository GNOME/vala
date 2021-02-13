class Foo {
	public void minim () requires (this is Bar) {
		assert (this.i == 42);
	}
}

class Bar : Foo {
	public int i = 42;
}

void manam (Foo foo) requires (foo is Bar) {
	assert (foo.i == 42);
}

void main () {
	var bar = new Bar ();
	manam (bar);
	bar.minim ();
}
