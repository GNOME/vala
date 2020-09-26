class Foo {
	public signal void manam ();

	public virtual int foo () {
		return 23;
	}
}

class Bar : Foo {
	public override int foo () {
		return 42;
	}
}

void main () {
	var foo = new Foo ();
	var bar = new Bar ();

	with (foo) {
		manam.connect (() => {
			assert (foo () == 23);
		});
		with (bar) {
			manam.connect (() => {
				assert (foo () == 42);
			});
		}
	}

	foo.manam ();
	bar.manam ();
}
