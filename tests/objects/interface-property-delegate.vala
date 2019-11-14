delegate void FooFunc ();

interface IFoo {
	public abstract unowned FooFunc prop { get; set; }
}

class Foo : IFoo {
	public unowned FooFunc prop { get; set; }
}

class Bar {
	public bool reached;

	public Bar () {
		var foo = new Foo ();
		foo.prop = bar;

		foo.prop ();
	}

	void bar () {
		reached = true;
	}
}

void main () {
	var bar = new Bar ();
	assert (bar.reached);
}
