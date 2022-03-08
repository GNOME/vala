interface IFoo {
	[NoWrapper]
	public abstract int foo ();
}

class Bar {
	public Bar (IFoo foo) {
		assert (foo.foo () == 42);
	}
}

class Foo : IFoo {
	public int foo () {
		return 42;
	}
}

void main () {
	new Bar (new Foo ());
}
