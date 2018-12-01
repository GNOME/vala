interface IFoo : Object {
	public abstract int foo ();
}

interface IBar : Object {
	public abstract string foo ();
}

class Foo : Object, IFoo, IBar {
	public virtual int IFoo.foo () {
		return 42;
	}
	public string IBar.foo () {
		return "foo";
	}
}

class Bar : Foo {
	public override int foo () {
		return 23;
	}
}

void main () {
	var foo = new Foo ();
	assert (foo.foo () == 42);
	assert (((IBar) foo).foo () == "foo");

	var bar = new Bar ();
	assert (bar.foo () == 23);
	assert (((Foo) bar).foo () == 23);
	assert (((IFoo) bar).foo () == 23);
	assert (((IBar) bar).foo () == "foo");
}
