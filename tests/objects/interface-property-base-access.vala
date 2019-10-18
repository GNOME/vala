struct Manam {
	public int i;
}

interface IFoo {
	public abstract string foo { get; set; }
	public abstract Manam manam { get; set; }
}

class Bar : IFoo {
	public string foo { get; set; }
	public Manam manam { get; set; }
}

class Foo : Bar {
	public string bar (string s) {
		base.foo = s;
		return base.foo;
	}

	public Manam baz (Manam m) {
		base.manam = m;
		return base.manam;
	}
}

void main () {
	var foo = new Foo ();
	assert (foo is IFoo);
	assert (foo.bar ("foo") == "foo");
	Manam manam = { 42 };
	assert (foo.baz (manam) == manam);
}
