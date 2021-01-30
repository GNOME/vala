interface IFoo : Object {
	[NoWrapper]
	public abstract int bar ();
}

class Foo : Object, IFoo {
	int bar () {
		return 42;
	}
}

void main () {
	var foo = new Foo ();
	assert (foo.bar () == 42);
}
