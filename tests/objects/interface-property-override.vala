interface IFoo {
	public virtual int bar { get { return -1; } }
}

class Foo : IFoo {
	public override int bar { get { return 42; } }
}

void main () {
	var foo = new Foo ();
	assert (foo.bar == 42);
}
