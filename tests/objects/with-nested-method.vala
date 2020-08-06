class Foo {
	public int foo () {
		return 23;
	}
}

class Bar {
	public int foo () {
		return 42;
	}
}

void main () {
	var foo = new Foo ();
	var bar = new Bar ();

	with (foo) {
		assert (foo () == 23);

		with (bar) {
			assert (foo () == 42);
		}
	}
}
