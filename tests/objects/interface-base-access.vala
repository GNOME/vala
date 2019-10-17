interface IFoo {
	public abstract void foo ();
}

class Bar : IFoo {
	public void foo () {
		reached = true;
	}
}

class Foo : Bar {
	public void bar () {
		base.foo ();
	}
}

bool reached = false;

void main () {
	var foo = new Foo ();
	assert (foo is IFoo);

	foo.bar ();
	assert (reached);
}
