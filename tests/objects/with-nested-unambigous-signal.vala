class Foo {
	public signal void manam ();

	public int bar () {
		return 23;
	}
}

void main () {
	var foo = new Foo ();

	with (foo) {
		manam.connect (() => {
			assert (bar () == 23);
		});
	}

	foo.manam ();
}
