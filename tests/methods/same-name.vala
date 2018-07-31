interface IFoo {
	public abstract bool foo ();
}

class Foo : IFoo {
	public bool IFoo.foo () {
		return true;
	}

	public int foo () {
		return 42;
	}
}

void main () {
	var foo = new Foo ();
	assert (((IFoo) foo).foo ());
	assert (foo.foo () == 42);
}
