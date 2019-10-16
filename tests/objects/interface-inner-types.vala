class Foo : IFoo {
}

interface IFoo {
	interface IBar {
	}

	class Bar : IBar {
	}

	public void bar () {
		var bar = new Bar ();
		assert (bar is IBar);
	}
}

void main () {
	var foo = new Foo ();
	foo.bar ();
}
